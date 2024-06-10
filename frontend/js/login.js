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

        // Verificar el rol del usuario
        const roleResponse = await fetch(`/api/check-role?email=${encodeURIComponent(email)}`, {
          method: "GET",
          headers: {
            "Content-Type": "application/json",
            "Authorization": `Bearer ${result.token}`, // Enviar el token en el encabezado de autorización
          },
        });

        if (roleResponse.ok) {
          const roleResult = await roleResponse.json();
          const userRole = roleResult.role;

          if (userRole === "gerente") {
            window.location.href = "/gerentes/Inicio.html";
          } else if (userRole === "proveedor") {
            window.location.href = "/proveedores/Inicio.html";
          } else {
            alert("Rol desconocido");
          }
        } else {
          const errorData = await roleResponse.json();
          alert(`Error al verificar el rol: ${errorData.message}`);
        }
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
