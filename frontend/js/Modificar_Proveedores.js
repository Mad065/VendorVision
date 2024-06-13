document.addEventListener("DOMContentLoaded", () => {
    const registroForm = document.getElementById("registroForm");

    document.getElementById("seleccionarButton").addEventListener("click", () => {
        const clave = document.getElementById("clave").value;

        fetch(`/api/obtener_producto?clave=${clave}`, {
            method: "GET",
            headers: {
                "Content-Type": "application/json",
                "Authorization": "Bearer " + localStorage.getItem("token")
            }
        })
            .then(response => response.json())
            .then(data => {
                if (data.producto) {
                    document.getElementById("nombre_Producto").value = data.producto.nombre_Producto;
                    document.getElementById("caducidad").value = data.producto.caducidad;
                    document.getElementById("descripcion").value = data.producto.descripcion;
                    document.getElementById("precio").value = data.producto.precio;
                    document.getElementById("tipo").value = data.producto.tipo_Producto;
                } else {
                    alert("Producto no encontrado");
                }
            })
            .catch(error => {
                console.error("Error al obtener el producto:", error);
            });
    });

    registroForm.addEventListener("submit", (e) => {
        e.preventDefault();

        const producto = {
            clave: document.getElementById("clave").value,
            nombre_Producto: document.getElementById("nombre_Producto").value,
            caducidad: document.getElementById("caducidad").value,
            descripcion: document.getElementById("descripcion").value,
            precio: document.getElementById("precio").value,
            tipo_Producto: document.getElementById("tipo").value
        };

        fetch('/api/modificar_producto', {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
                "Authorization": "Bearer " + localStorage.getItem("token")
            },
            body: JSON.stringify(producto)
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert("Producto modificado exitosamente");
                    registroForm.reset();
                } else {
                    alert("Error al modificar el producto: " + data.message);
                }
            })
            .catch(error => {
                console.error("Error al modificar el producto:", error);
            });
    });

    document.getElementById("cancelarButton").addEventListener("click", () => {
        registroForm.reset();
    });
});