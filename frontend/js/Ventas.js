document.addEventListener("DOMContentLoaded", () => {
  const token = localStorage.getItem("token");
  const form = document.querySelector("form");
  const claveInput = document.getElementById("clave");
  const cantidadInput = document.getElementById("cantidad");

  let cantidadTotal = 0;
  let subtotal = 0;
  let productosSeleccionados = []; // Lista de productos seleccionados

  if (!token) {
    alert("Por favor, inicia sesión primero.");
    window.location.href = "/login.html";
    return;
  }

  form.addEventListener("submit", async (event) => {
    event.preventDefault();

    const clave = claveInput.value;
    const cantidad = parseInt(cantidadInput.value);

    // Validación de campos
    if (!clave || isNaN(cantidad) || cantidad <= 0) {
      alert("Por favor, completa todos los campos antes de añadir un producto.");
      return;
    }

    try {
      const response = await fetch(`/api/productos?clave=${clave}`, {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
      });

      if (!response.ok) {
        throw new Error("Error al obtener los datos de los productos");
      }

      const data = await response.json();

      if (data.productos.length === 0) {
        alert("No hay ningún producto registrado con esa clave");
        return;
      }

      // Verificar la cantidad disponible
      const producto = data.productos[0]; // Suponiendo que solo devuelve un producto
      const cantidadDisponible = producto.cantidad;

      if (cantidad > cantidadDisponible) {
        alert("La cantidad solicitada es mayor a la cantidad disponible");
        return;
      }

      productosSeleccionados.push({ id: producto.id_Producto, cantidad }); // Añadir producto a la lista

      const productosContainer = document.getElementById("productos-container");
      let contenidoPrevio = productosContainer.innerHTML;

      const precioProducto = producto.precio;
      subtotal += precioProducto * cantidad;
      cantidadTotal += cantidad;

      contenidoPrevio += `
        <div class="d-flex justify-content-between">
          <div>
            <h6 class="card-black-title mb-2">${producto.nombre_Producto}</h6>
            <p class="description-producs">${producto.descripcion}</p>
          </div>
          <div>
            <p class="card-black-text">Precio: ${precioProducto}</p>
            <p class="card-black-text">Tipo producto: ${producto.tipo_Producto}</p>
          </div>
        </div>
        <div class="d-flex justify-content-between align-items-center mt-3">
          <div class="input-group">
            <label for="cantidad-disponible" class="input-label">Cantidad:</label>
            <select class="form-select cantidad-select" id="cantidad-disponible" aria-label="Cantidad">
              ${populateSelectOptions(producto.cantidad, cantidad)}
            </select>
          </div>
        </div>
        <hr class="featurette-divider" />
      `;

      productosContainer.innerHTML = contenidoPrevio;

      document.getElementById("subtotal-text").innerText = `Subtotal (${cantidadTotal}): ${subtotal}`;
      document.getElementById("cantidad-productos").innerText = `Cantidad de productos: ${cantidadTotal}`;
      document.getElementById("precio-total").innerText = `Precio total de venta: ${subtotal}`;

      claveInput.value = '';
      cantidadInput.value = '';

    } catch (error) {
      alert("Hubo un error al añadir el producto: " + error.message);
    }
  });

  document.getElementById("vender").addEventListener("click", async () => {
    const correoGerente = localStorage.getItem("correoE");

    if (productosSeleccionados.length === 0) {
      alert("No hay productos para vender.");
      return;
    }

    try {
      const response = await fetch('/api/realizar-venta', {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify({ productos: productosSeleccionados, correoGerente })
      });

      if (!response.ok) {
        throw new Error("Error al procesar la venta");
      }

      alert("Venta procesada con éxito.");
      // Resetear los datos después de la venta
      productosSeleccionados = [];
      cantidadTotal = 0;
      subtotal = 0;
      document.getElementById("productos-container").innerHTML = '';
      document.getElementById("subtotal-text").innerText = 'Subtotal (0): 0';
      document.getElementById("cantidad-productos").innerText = 'Cantidad de productos: 0';
      document.getElementById("precio-total").innerText = 'Precio total de venta: 0';

    } catch (error) {
      alert("Hubo un error al procesar la venta: " + error.message);
    }
  });
});

function populateSelectOptions(max, selected) {
  let options = '';
  for (let i = 1; i <= max; i++) {
    options += `<option value="${i}" ${i === selected ? 'selected' : ''}>${i}</option>`;
  }
  return options;
}
