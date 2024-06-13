document.addEventListener("DOMContentLoaded", () => {
    const correoE = localStorage.getItem("correoE");

    fetch(`/api/stock-proveedores?correoE=${correoE}`, {
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

                    const precioCell = document.createElement("td");
                    precioCell.textContent = producto.precio;
                    row.appendChild(precioCell);

                    const caducidadCell = document.createElement("td");
                    caducidadCell.textContent = new Date(producto.caducidad).toLocaleDateString();
                    row.appendChild(caducidadCell);

                    const tipoProductoCell = document.createElement("td");
                    tipoProductoCell.textContent = producto.tipo_Producto;
                    row.appendChild(tipoProductoCell);

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
