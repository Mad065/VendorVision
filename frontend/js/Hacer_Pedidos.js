document.addEventListener("DOMContentLoaded", () => {
    const token = localStorage.getItem("token");
    const form = document.querySelector("form");
    const claveInput = document.getElementById("clave");
    const cantidadInput = document.getElementById("cantidad");
    const realizarPedidoBtn = document.getElementById("vender");

    let cantidadTotal = 0;
    let subtotal = 0;

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

            const productosContainer = document.getElementById("productos-container");
            let contenidoPrevio = productosContainer.innerHTML;

            const precioProducto = producto.precio + producto.ganancia;
            subtotal += precioProducto * cantidad;
            cantidadTotal += cantidad;

            const productoHTML = `
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

            productosContainer.innerHTML = contenidoPrevio + productoHTML;

            // Actualizar la fecha de compra, cantidad de productos, subtotal y precio total en el HTML
            const fechaCompraText = document.getElementById("fecha-compra");
            const cantidadProductosText = document.getElementById("cantidad-productos");
            const subtotalText = document.getElementById("subtotal-text");
            const precioTotalText = document.getElementById("precio-total");

            const fechaCompra = new Date().toLocaleDateString();
            fechaCompraText.textContent = `Fecha de compra: ${fechaCompra}`;
            cantidadProductosText.textContent = `Cantidad de productos: ${cantidadTotal}`;
            subtotalText.textContent = `Subtotal: $${subtotal.toFixed(2)}`;
            precioTotalText.textContent = `Precio total de venta: $${subtotal.toFixed(2)}`;

            // Limpiar los campos de entrada después de agregar contenido al HTML
            claveInput.value = "";
            cantidadInput.value = "";

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
                        subtotal -= (producto.ganancia + producto.inversion) * cantidadVendida;
                        cantidadTotal -= cantidadVendida;

                        cantidadProductosText.textContent = `Cantidad de productos: ${cantidadTotal}`;
                        subtotalText.textContent = `Subtotal: $${subtotal.toFixed(2)}`;
                        precioTotalText.textContent = `Precio total de venta: $${subtotal.toFixed(2)}`;
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

    realizarPedidoBtn.addEventListener("click", async () => {
        try {
            // Aquí debes definir los detalles del pedido
            const clave_producto = claveInput.value;
            const correo_usuario = localStorage.getItem("correoE");
            const cantidad_pedida = parseInt(cantidadInput.value);
            const fecha_pedido = new Date().toISOString(); // Fecha actual en formato ISO

            // Envía la solicitud POST al servidor con los detalles del pedido
            const response = await fetch("/api/hacer_pedido", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                    Authorization: `Bearer ${token}`, // Si necesitas enviar un token de autenticación
                },
                body: JSON.stringify({
                    clave_producto,
                    correo_usuario,
                    cantidad_pedida,
                    fecha_pedido,
                }),
            });

            if (!response.ok) {
                throw new Error("Error al realizar el pedido");
            }

            const data = await response.json();
            alert(data.message); // Mensaje de éxito o error desde el servidor

            // Limpiar el carrito y actualizar el frontend según sea necesario...
        } catch (error) {
            console.error("Error:", error.message);
            alert("Error al realizar el pedido.");
        }
    });


    // Función para llenar el <select> basado en el stock
    function populateSelectOptions(stock, cantidadSeleccionada) {
        let options = '<option value="Cantidad">Cantidad</option>';

        for (let i = 1; i <= stock; i++) {
            options += `<option value="${i}" ${i === cantidadSeleccionada ? 'selected' : ''}>${i}</option>`;
        }

        return options;
    }
});
