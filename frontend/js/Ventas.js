document.addEventListener("DOMContentLoaded", () => {
  const token = localStorage.getItem("token");
  const form = document.querySelector("form");

  if (!token) {
    alert("Por favor, inicia sesión primero.");
    // Redirige al usuario a la página de inicio de sesión
    window.location.href = "/login.html";
    return;
  }

  const clave = document.getElementById("clave").value;
  const cantidad = document.getElementById("cantidad").value;

  form.addEventListener("submit", async (event) => {
    event.preventDefault();

    const clave = document.getElementById("clave").value;
    const cantidad = document.getElementById("cantidad").value;

    // Validación de campos
    if (!clave || !cantidad) {
      alert(
        "Por favor, completa todos los campos antes de aañadir un producto."
      );
      return;
    }

    const userData = {
      nombre_Usuario: username,
      correoE: email,
      contraseña: password,
    };

    try {
      const response = await fetch("/api/productos", {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
      })
        .then((response) => {
          if (!response.ok) {
            throw new Error("Error al obtener los datos de los productos");
          }
          return response.json();
        })
        .then((data) => {
          if (data.productos.length === 0) {
            alert("No hay ningun producto registrado");
            return;
          }
          const productosContainer = document.getElementById(
            "productos-container"
          );
          // Iterar sobre los datos de los gerentes y crear una card para cada uno
          data.productos.forEach((producto) => {
            const producto = `
            <div class="d-flex justify-content-between">
            <div>
              <h6 class="card-black-title mb-2">
                ${producto.nombre_Producto}
              </h6>
              <p class="description-producs">
                ${producto.descripcion}
              </p>
            </div>
            <div>
              <p class="card-black-text">Precio: 
                ${producto.ganancia + producto.inversion}
              </p>
              <p class="card-black-text">Cantidad: 1</p>
              <p class="card-black-text">Peso: 250 ml</p>
            </div>
          </div>
          <div
            class="d-flex justify-content-between align-items-center mt-3">
            <div class="input-group">
              <select class="form-select" aria-label="Cantidad">
                <option selected>Cantidad</option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
              </select>
              <button class="btn btn-primary ms-2">Eliminar</button>
            </div>
          </div>
          <hr class="featurette-divider" />
          <div class="d-flex justify-content-end">
            <p class="card-black-text">
              Subtotal (1 producto): $500.00
            </p>
          </div>
              `;
            productosContainer.insertAdjacentHTML("beforeend", producto);
          });
        })
        .catch((error) => {
          console.error("Error:", error.message);
          alert("Por favor, inicia sesión primero.");
          // Redirige al usuario a la página de inicio de sesión
          window.location.href = "/login.html";
        });
    } catch (error) {
      console.error("Error:", error);
      alert("Error en el servidor");
    }
  });
});
