document.addEventListener("DOMContentLoaded", () => {
  const form = document.querySelector("form");
  const dateInput = document.getElementById("birthdate");
  const curpInput = document.getElementById("CURP");
  let isCURPValid = false;

  const menorEdad = document.getElementById("menorEdad");
  const curpValido = document.getElementById("curpValido");

  dateInput.addEventListener("blur", () => {
    const birthdate = dateInput.value;
    const edad = calculateAge(new Date(birthdate));
    if (edad < 18) {
      menorEdad.innerHTML = "Debes tener al menos 18 años para registrarte.";
    }
  });

  curpInput.addEventListener("blur", async () => {
    const CURP = curpInput.value;
    if (CURP) {
      try {
        const response = await fetch("/api/curp-disponible", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({ CURP }),
        });

        if (response.ok) {
          const result = await response.json();
          if (result.message === "CURP disponible") {
            curpValido.innerHTML = "El CURP es válido.";
            isCURPValid = true;
          } else {
            curpValido.innerHTML = "El CURP no es válido.";
            isCURPValid = false;
          }
        } else {
          const errorData = await response.json();
          alert(`Error: ${errorData.message}`);
          isCURPValid = false;
        }
      } catch (error) {
        console.error("Error:", error);
        alert("Error en el servidor");
        isCURPValid = false;
      }
    }
  });

  form.addEventListener("submit", async (event) => {
    event.preventDefault();

    const correoE = localStorage.getItem("correoE");
    const name = document.getElementById("name").value;
    const apellidos = document.getElementById("apellidos").value;
    const CURP = curpInput.value;
    const birthdate = dateInput.value;
    const nombre_Tienda = document.getElementById("nombre_Tienda").value;
    const tel_Tienda = document.getElementById("tel_Tienda").value;
    const ciudad = document.getElementById("ciudad").value;
    const colonia = document.getElementById("colonia").value;
    const calle = document.getElementById("calle").value;
    const cp = document.getElementById("cp").value;
    let n_int = document.getElementById("n_int").value;
    const n_ext = document.getElementById("n_ext").value;

    if (n_int === "") {
      n_int = null;
    }

    // Validación de campos
    if (!correoE || !name || !apellidos || !CURP || !birthdate || !nombre_Tienda || !tel_Tienda || !ciudad || !colonia || !calle || !cp || !n_ext) {
      alert("Por favor, completa todos los campos antes de enviar el formulario.");
      return;
    }

    if (!isCURPValid) {
      curpValido.innerHTML = "El CURP no es válido.";
      return;
    }

    // Validación de edad
    const edad = calculateAge(new Date(birthdate));
    if (edad < 18) {
      menorEdad.innerHTML = "Debes tener al menos 18 años para registrarte.";
      return;
    }

    const userData = {
      correoE: correoE,
      nombre_Gerente: name,
      apellido_Gerente: apellidos,
      CURP: CURP,
      fechaNac: birthdate,
      nombre_Tienda: nombre_Tienda,
      tel_Tienda: tel_Tienda,
      colonia: colonia,
      calle: calle,
      cp: cp,
      ciudad: ciudad,
      num_int: n_int,
      num_ext: n_ext,
    };

    try {
      const response = await fetch("/api/gerentessignup", {
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
