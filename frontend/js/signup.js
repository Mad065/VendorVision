document.addEventListener("DOMContentLoaded", () => {
  const form = document.querySelector("form");

  form.addEventListener("submit", async (event) => {
    event.preventDefault();

    const email = document.getElementById("correoE").value;
    const username = document.getElementById("nombre_Usuario").value;
    const password = document.getElementById("contraseña").value;

    const userData = {
      nombre_Usuario: username,
      correoE: email,
      contraseña: password,
    };

    try {
      const response = await fetch("/api/signup", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(userData),
      });

      if (response.ok) {
        const result = await response.json();
        alert("Usuario registrado exitosamente");
        // Redirige al usuario a la página de inicio de sesión
        window.location.href = "/login.html";
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
