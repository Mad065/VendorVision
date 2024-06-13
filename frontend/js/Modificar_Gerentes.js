document.addEventListener("DOMContentLoaded", () => {
    const seleccionarButton = document.getElementById("seleccionarButton");
    const cancelarButton = document.getElementById("cancelarButton");
    const gananciaInput = document.getElementById("ganancia");
    const nombreProducto = document.getElementById("nombreProducto");

    seleccionarButton.addEventListener("click", async () => {
        const clave = document.getElementById("clave").value;

        try {
            const response = await fetch(`/api/obtener_producto?clave=${clave}`);
            const data = await response.json();

            if (data.success) {
                nombreProducto.textContent = data.producto.nombre_Producto;
                gananciaInput.value = data.producto.ganancia;
            } else {
                nombreProducto.textContent = "Producto no encontrado";
                gananciaInput.value = "";
            }
        } catch (error) {
            console.error("Error al obtener el producto:", error);
            nombreProducto.textContent = "Error al obtener el producto";
            gananciaInput.value = "";
        }
    });

    cancelarButton.addEventListener("click", () => {
        nombreProducto.textContent = "";
        gananciaInput.value = "";
    });

    registroForm.addEventListener("submit", async (event) => {
        event.preventDefault();

        const clave = document.getElementById("clave").value;
        const ganancia = gananciaInput.value;

        try {
            const response = await fetch("/api/modificar_ganancia_producto", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                    "Authorization": "Bearer " + localStorage.getItem("token")
                },
                body: JSON.stringify({ clave, ganancia })
            });

            const data = await response.json();

            if (data.success) {
                alert("Ganancia modificada exitosamente");
                nombreProducto.textContent = "";
                gananciaInput.value = "";
            } else {
                alert(data.message);
            }
        } catch (error) {
            console.error("Error al modificar la ganancia del producto:", error);
            alert("Error al modificar la ganancia del producto");
        }
    });
});
