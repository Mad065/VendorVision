document.addEventListener("DOMContentLoaded", () => {
  const correoE = localStorage.getItem("correoE");

  fetch(`/api/obtener_pedidos_proveedor?correoE=${correoE}`, {
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

            const gerenteCell = document.createElement("td");
            gerenteCell.textContent = pedido.nombre_Gerente;
            row.appendChild(gerenteCell);

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
            if (pedido.confirmado) {
              confirmadoCell.textContent = "Sí";
            } else {
              const confirmarButton = document.createElement("button");
              confirmarButton.textContent = "Confirmar";
              confirmarButton.addEventListener("click", () => confirmarPedido(pedido.id_Pedido));
              confirmadoCell.appendChild(confirmarButton);
            }
            row.appendChild(confirmadoCell);

            const entregadoCell = document.createElement("td");
            entregadoCell.textContent = pedido.entregado ? "Sí" : "No";
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

function confirmarPedido(id_Pedido) {
  fetch(`/api/confirmar_pedido`, {
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
          console.error("Error al confirmar el pedido:", data.message);
        }
      })
      .catch(error => {
        console.error("Error al confirmar el pedido:", error);
      });
}