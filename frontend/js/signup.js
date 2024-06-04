document.addEventListener("DOMContentLoaded", () => {
  const form = document.querySelector("form");
  const emailInput = document.getElementById("correoE");
  let isEmailValid = false;

  emailInput.addEventListener("blur", async () => {
    const email = emailInput.value;
    if (email) {
      try {
        const response = await fetch("/api/correo-disponible", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({ correoE: email }),
        });

        if (response.ok) {
          const result = await response.json();
          if (result.message === "Correo disponible") {
            alert(result.message);
            isEmailValid = true;
          } else {
            alert(result.message);
            isEmailValid = false;
          }
        } else {
          const errorData = await response.json();
          alert(`Error: ${errorData.message}`);
          isEmailValid = false;
        }
      } catch (error) {
        console.error("Error:", error);
        alert("Error en el servidor");
        isEmailValid = false;
      }
    }
  });

  form.addEventListener("submit", async (event) => {
    event.preventDefault();

    const email = document.getElementById("correoE").value;
    const username = document.getElementById("nombre_Usuario").value;
    const password = document.getElementById("contraseña").value;
    const accountType = document.getElementById("account-type").value;

    // Validación de campos
    if (!email || !username || !password || !accountType) {
      alert(
        "Por favor, completa todos los campos antes de enviar el formulario."
      );
      return;
    }

    if (email) {
      try {
        const response = await fetch("/api/correo-disponible", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({ correoE: email }),
        });

        if (response.ok) {
          const result = await response.json();
          if (result.message === "Correo disponible") {
            alert(result.message);
            isEmailValid = true;
          } else {
            alert(result.message);
            isEmailValid = false;
          }
        } else {
          const errorData = await response.json();
          alert(`Error: ${errorData.message}`);
          isEmailValid = false;
        }
      } catch (error) {
        console.error("Error:", error);
        alert("Error en el servidor");
        isEmailValid = false;
      }
    }
    // Verificar si el correo es válido
    if (!isEmailValid) {
      alert("El correo electrónico no es válido o ya está registrado.");
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
        localStorage.setItem("correoE", correoE);
        localStorage.setItem("nombre_Usuario", username);
        localStorage.setItem("contraseña", password);
        localStorage.setItem("accountType", accountType);

        alert("Usuario registrado exitosamente");
        // Redirige al usuario a la página de inicio de sesión
        if (accountType === "proveedor") {
          window.location.href = "/proveedoresSignup.html";
        } else if (accountType === "gerente") {
          window.location.href = "/gerentesSignup.html";
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
