document.addEventListener("DOMContentLoaded", () => {
  const form = document.getElementById("registroForm");

  form.addEventListener("submit", async (event) => {
    event.preventDefault();

    const clave = document.getElementById("clave").value;
    const nombre_Producto = document.getElementById("nombre_Producto").value;
    const caducidad = document.getElementById("caducidad").value;
    const descripcion = document.getElementById("descripcion").value;
    const tipo_Producto = document.getElementById("tipo").value;
    const precio = document.getElementById("precio").value;
    const correoE = localStorage.getItem("correoE");

    // Validación de campos
    if (!clave || !nombre_Producto || !caducidad || !descripcion || !tipo_Producto || !precio || !correoE) {
      console.log("Por favor, completa todos los campos antes de enviar el formulario.")
      alert("Por favor, completa todos los campos antes de enviar el formulario.");
      return;
    }

    const producto = {
      clave,
      nombre_Producto,
      descripcion,
      caducidad,
      tipo_Producto,
      precio,
      correoE
    };

    try {
      const response = await fetch("/api/registrar_producto", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(producto),
      });

      if (response.ok) {
        alert("Producto registrado exitosamente");
        form.reset();
      } else {
        const errorData = await response.json();
        alert(`Error: ${errorData.message}`);
      }
    } catch (error) {
      console.error("Error:", error);
      alert("Error en el servidor");
    }
  });
});
