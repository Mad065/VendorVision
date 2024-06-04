document.addEventListener("DOMContentLoaded", () => {
  const form = document.getElementById("registroForm");

  form.addEventListener("submit", async (event) => {
    event.preventDefault();

    const clave = document.getElementById("clave").value;
    const nombre = document.getElementById("nombre_Producto").value;
    const caducidad = document.getElementById("caducidad").value;
    const descripcion = document.getElementById("descripcion").value;
    const ganancia = document.getElementById("ganancia").value;
    const inversion = document.getElementById("inversion").value;
    const cantidad = document.getElementById("cantidad").value;
    const peso = document.getElementById("peso").value;

    // Validación de campos
    if (
      !clave ||
      !nombre ||
      !caducidad ||
      !descripcion ||
      !ganancia ||
      !inversion ||
      !cantidad ||
      !peso
    ) {
      alert(
        "Por favor, completa todos los campos antes de enviar el formulario."
      );
      return;
    }

    const producto = {
      clave,
      nombre,
      caducidad,
      descripcion,
      ganancia,
      inversion,
      cantidad,
      peso,
    };

    try {
      const response = await fetch("/api/productos", {
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
