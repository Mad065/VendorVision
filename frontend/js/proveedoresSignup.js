document.addEventListener("DOMContentLoaded", () => {
  console.log("hola sirvo");
  const form = document.querySelector("form");
  const dateInput = document.getElementById("birthdate");

  const menorEdad = document.getElementById("menorEdad");

  dateInput.addEventListener("blur", () => {
    const birthdate = dateInput.value;
    const edad = calculateAge(new Date(birthdate));
    if (edad < 18) {
      menorEdad.innerHTML = "Debes tener al menos 18 años para registrarte.";
    }
  });

  form.addEventListener("submit", async (event) => {
    event.preventDefault();

    const correoE = localStorage.getItem("correoE");
    const name = document.getElementById("name").value;
    const apellidos = document.getElementById("apellidos").value;
    const birthdate = document.getElementById("birthdate").value;
    const nombre_Empresa = document.getElementById("nombre_Empresa").value;
    const ciudad = document.getElementById("ciudad").value;
    const colonia = document.getElementById("colonia").value;
    const calle = document.getElementById("calle").value;
    const cp = document.getElementById("cp").value;
    let n_int = document.getElementById("n_int").value;
    const n_ext = document.getElementById("n_ext").value;

    if (!n_int) {
      n_int = null;
    }

    // Validación de campos
    if (!correoE || !name || !apellidos || !birthdate || !nombre_Empresa || !ciudad || !colonia || !calle || !cp || !n_ext) {
      alert("Por favor, completa todos los campos antes de enviar el formulario.");
      return;
    }

    // Validación de edad
    const edad = calculateAge(new Date(birthdate));
    if (edad < 18) {
      menorEdad.innerHTML = "Debes tener al menos 18 años para registrarte.";
      return;
    }

    const userData = {
      correoE,
      nombre_Proveedor: name,
      apellido_Proveedor: apellidos,
      birthdate,
      nombre_Empresa,
      colonia,
      calle,
      cp,
      ciudad,
      num_int: n_int,
      num_ext: n_ext,
    };

    try {
      const response = await fetch("/api/proveedoressignup", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(userData),
      });

      if (response.ok) {
        const result = await response.json();
        // Redirige al usuario a la página de inicio de sesión
        window.location.href = "login.html";
      } else {
        const errorData = await response.json();
        alert(`Error: ${errorData.message}`);
      }
    } catch (error) {
      console.error("Error:", error);
      alert("Error en el servidor");
    }
  });

  function calculateAge(birthDate) {
    const today = new Date();
    let age = today.getFullYear() - birthDate.getFullYear();
    const monthDifference = today.getMonth() - birthDate.getMonth();

    if (monthDifference < 0 || (monthDifference === 0 && today.getDate() < birthDate.getDate())) {
      age--;
    }

    return age;
  }
});
