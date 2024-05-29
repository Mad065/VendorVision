document.addEventListener("DOMContentLoaded", () => {
  const form = document.querySelector("form");

  form.addEventListener("submit", async (event) => {
    event.preventDefault();

    const email = document.getElementById("correoE").value;
    const password = document.getElementById("contraseña").value;

    const userData = {
      correoE: email,
      contraseña: password,
    };

    try {
      const response = await fetch("/api/login", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(userData),
      });

      if (response.ok) {
        const result = await response.json();

        // Guardar el token en localStorage
        if (result.token) {
          localStorage.setItem("token", result.token);
          console.log("Token guardado en localStorage");
        }

        alert("Inicio de sesión realizado exitosamente");
        // Redirige al usuario a la página de proveedores
        window.location.href = "/proveedores/proveedores.html";
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
