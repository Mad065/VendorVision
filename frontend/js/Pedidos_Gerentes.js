document.addEventListener("DOMContentLoaded", () => {
    const correoE = localStorage.getItem("correoE");

    fetch("/api/obtener_pedidos_gerente?correoE=${correoE}", {
        method: "GET",
        headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer " + localStorage.getItem("token") // Asegúrate de tener el token almacenado
        }
    })
        .then(response => response.json())
        .then(data => {
            if (data.pedidos && data.pedidos.length > 0) {
                const tbody = document.getElementById("tabla-pedidos");
                tbody.innerHTML = "";

                data.pedidos.forEach(pedido => {
                    const row = document.createElement("tr");

                    const proveedorCell = document.createElement("td");
                    proveedorCell.textContent = pedido.nombre_Proveedor;
                    row.appendChild(proveedorCell);

                    const empresaCell = document.createElement("td");
                    empresaCell.textContent = pedido.empresa_Proveedor;
                    row.appendChild(empresaCell);

                    const productoCell = document.createElement("td");
                    productoCell.textContent = pedido.nombre_Producto;
                    row.appendChild(productoCell);

                    const cantidadCell = document.createElement("td");
                    cantidadCell.textContent = pedido.cantidad;
                    row.appendChild(cantidadCell);

                    const precioCell = document.createElement("td");
                    precioCell.textContent = pedido.precio; // Asegúrate de que el campo precio existe en tu resultado
                    row.appendChild(precioCell);

                    const importeTotalCell = document.createElement("td");
                    const importeTotal = pedido.cantidad * pedido.precio;
                    importeTotalCell.textContent = importeTotal.toFixed(2); // Redondea a dos decimales
                    row.appendChild(importeTotalCell);

                    const fechaCell = document.createElement("td");
                    fechaCell.textContent = new Date(pedido.fecha).toLocaleDateString();
                    row.appendChild(fechaCell);

                    const confirmadoCell = document.createElement("td");
                    confirmadoCell.textContent = pedido.confirmado ? "Sí" : "No";
                    row.appendChild(confirmadoCell);

                    const entregadoCell = document.createElement("td");
                    if (pedido.entregado) {
                        entregadoCell.textContent = "Sí";
                    } else {
                        const entregaButton = document.createElement("button");
                        entregaButton.textContent = "Marcar como entregado";
                        entregaButton.addEventListener("click", () => marcarComoEntregado(pedido.id_Pedido));
                        entregadoCell.appendChild(entregaButton);
                    }
                    row.appendChild(entregadoCell);

                    tbody.appendChild(row);
                });
            } else {
                console.log("No se encontraron pedidos.");
            }
        })
        .catch(error => {
            console.error("Error al obtener los pedidos:", error);
        });
});

function marcarComoEntregado(id_Pedido) {
    fetch("/api/marcar_entregado", {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer " + localStorage.getItem("token") // Asegúrate de tener el token almacenado
        },
        body: JSON.stringify({ id_Pedido: id_Pedido })
    })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                location.reload(); // Recarga la página para actualizar la tabla
            } else {
                console.error("Error al marcar como entregado:", data.message);
            }
        })
        .catch(error => {
            console.error("Error al marcar como entregado:", error);
        });
}