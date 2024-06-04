document.addEventListener("DOMContentLoaded", () => {
  const token = localStorage.getItem("token");
  const form = document.querySelector("form");

  if (!token) {
    alert("Por favor, inicia sesión primero.");
    window.location.href = "/login.html";
    return;
  }

  form.addEventListener("submit", async (event) => {
    event.preventDefault();

    const clave = document.getElementById("clave").value;

    // Validación de campos
    if (!clave) {
      alert(
        "Por favor, completa todos los campos antes de añadir un producto."
      );
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
        alert("No hay ningun producto registrado");
        return;
      }

      const productosContainer = document.getElementById("productos-container");
      productosContainer.innerHTML = ""; // Limpiar el contenedor antes de insertar nuevos productos

      let subtotal = 0;
      let cantidadProductos = data.productos.length;
      const fechaCompra = new Date().toLocaleDateString();

      // Iterar sobre los datos de los productos y crear una card para cada uno
      data.productos.forEach((producto) => {
        const precioProducto = producto.ganancia + producto.inversion;
        subtotal += precioProducto;

        const productoHTML = `
          <div class="d-flex justify-content-between">
            <div>
              <h6 class="card-black-title mb-2">${producto.nombre_Producto}</h6>
              <p class="description-producs">${producto.descripcion}</p>
            </div>
            <div>
              <p class="card-black-text">Precio: ${precioProducto}</p>
              <p class="card-black-text">Cantidad: ${producto.cantidad}</p>
              <p class="card-black-text">${producto.peso} ${producto.tipo_Producto}</p>
            </div>
          </div>
          <div class="d-flex justify-content-between align-items-center mt-3">
            <div class="input-group">
              <select class="form-select cantidad-select" aria-label="Cantidad">
                <option selected>Cantidad</option>
              </select>
              <button class="btn btn-primary ms-2 vender-btn" data-id="${producto.id_Producto}">Vender</button>
            </div>
          </div>
          <hr class="featurette-divider" />
        `;
        productosContainer.insertAdjacentHTML("beforeend", productoHTML);

        // Llenar el select con la cantidad según el stock del producto
        const selectElement = productosContainer.querySelector(
          ".cantidad-select:last-child"
        );
        populateSelect(selectElement, producto.cantidad);
      });

      // Actualizar la fecha de compra, cantidad de productos, subtotal y precio total en el HTML
      const fechaCompraText = document.getElementById("fecha-compra");
      const cantidadProductosText =
        document.getElementById("cantidad-productos");
      const subtotalText = document.getElementById("subtotal-text");
      const precioTotalText = document.getElementById("precio-total");

      fechaCompraText.textContent = `Fecha de compra: ${fechaCompra}`;
      cantidadProductosText.textContent = `Cantidad de productos: ${cantidadProductos}`;
      subtotalText.textContent = `Subtotal: $${subtotal.toFixed(2)}`;
      precioTotalText.textContent = `Precio total de venta: $${subtotal.toFixed(
        2
      )}`;

      // Agregar evento de venta a los botones
      const venderBtns = document.querySelectorAll(".vender-btn");
      venderBtns.forEach((btn) => {
        btn.addEventListener("click", async () => {
          const idProducto = btn.dataset.id;
          const cantidadSelect = btn.previousElementSibling;
          const cantidadVendida = parseInt(cantidadSelect.value);

          if (cantidadVendida <= 0 || isNaN(cantidadVendida)) {
            alert("Por favor, selecciona una cantidad válida para vender.");
            return;
          }

          try {
            const sellResponse = await fetch("/api/productos/vender-producto", {
              method: "POST",
              headers: {
                "Content-Type": "application/json",
                Authorization: `Bearer ${token}`,
              },
              body: JSON.stringify({
                idProducto,
                cantidadVendida,
              }),
            });

            if (!sellResponse.ok) {
              throw new Error("Error al vender el producto");
            }

            const sellData = await sellResponse.json();
            alert(sellData.message);

            // Actualizar el frontend para reflejar el cambio en el stock
            cantidadSelect.value = "Cantidad";
            const producto = data.productos.find(
              (p) => p.id_Producto === idProducto
            );
            producto.cantidad -= cantidadVendida;

            // Volver a calcular y actualizar el subtotal y cantidad de productos
            subtotal -=
              (producto.ganancia + producto.inversion) * cantidadVendida;
            cantidadProductos -= cantidadVendida;

            cantidadProductosText.textContent = `Cantidad de productos: ${cantidadProductos}`;
            subtotalText.textContent = `Subtotal: $${subtotal.toFixed(2)}`;
            precioTotalText.textContent = `Precio total de venta: $${subtotal.toFixed(
              2
            )}`;
          } catch (error) {
            console.error("Error:", error.message);
            alert("Error al vender el producto.");
          }
        });
      });
    } catch (error) {
      console.error("Error:", error.message);
      alert("Error al obtener los datos del producto.");
    }
  });

  // Función para llenar el <select> basado en el stock
  function populateSelect(selectElement, stock) {
    // Limpiar las opciones actuales (excepto la primera opción)
    while (selectElement.options.length > 1) {
      selectElement.remove(1);
    }

    // Crear opciones basadas en el stock
    for (let i = 1; i <= stock; i++) {
      const option = document.createElement("option");
      option.value = i;
      option.textContent = i;
      selectElement.appendChild(option);
    }
  }
});
