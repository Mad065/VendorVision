document.addEventListener("DOMContentLoaded", () => {
    const correoE = localStorage.getItem("correoE");

    fetch(`/api/stock-gerente?correoE=${correoE}`, {
        method: "GET",
        headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer " + localStorage.getItem("token") // Asegúrate de tener el token almacenado
        }
    })
        .then(response => response.json())
        .then(data => {
            if (data.stock && data.stock.length > 0) {
                const tbody = document.getElementById("tabla-stock");
                tbody.innerHTML = "";

                data.stock.forEach(producto => {
                    const row = document.createElement("tr");

                    const claveCell = document.createElement("td");
                    claveCell.textContent = producto.clave;
                    row.appendChild(claveCell);

                    const productoCell = document.createElement("td");
                    productoCell.textContent = producto.nombre_Producto;
                    row.appendChild(productoCell);

                    const descripcionCell = document.createElement("td");
                    descripcionCell.textContent = producto.descripcion;
                    row.appendChild(descripcionCell);

                    const caducidadCell = document.createElement("td");
                    caducidadCell.textContent = new Date(producto.caducidad).toLocaleDateString();
                    row.appendChild(caducidadCell);

                    const tipoProductoCell = document.createElement("td");
                    tipoProductoCell.textContent = producto.tipo_Producto;
                    row.appendChild(tipoProductoCell);

                    const cantidadCell = document.createElement("td");
                    cantidadCell.textContent = producto.cantidad;
                    row.appendChild(cantidadCell);

                    const precioCell = document.createElement("td");
                    precioCell.textContent = producto.precio;
                    row.appendChild(precioCell);

                    const gananciaCell = document.createElement("td");
                    gananciaCell.textContent = producto.ganancia.toFixed(2); // Redondea a dos decimales
                    row.appendChild(gananciaCell);

                    tbody.appendChild(row);
                });
            } else {
                console.log("No se encontró stock.");
            }
        })
        .catch(error => {
            console.error("Error al obtener el stock:", error);
        });
});
