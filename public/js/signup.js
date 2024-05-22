document.addEventListener("DOMContentLoaded", () => {
  const form = document.querySelector("form");

  form.addEventListener("submit", async (event) => {
    event.preventDefault();

    const email = document.getElementById("email").value;
    const username = document.getElementById("username").value;
    const password = document.getElementById("password").value;
    const birthdate = document.getElementById("date").value;
    const accountType = document.getElementById("account-type").value;

    if (!email || !username || !password || !birthdate || !accountType) {
      alert("Todos los campos son obligatorios");
      return;
    }

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
        window.location.href = "login.html"; // Redirige al login después del registro
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
