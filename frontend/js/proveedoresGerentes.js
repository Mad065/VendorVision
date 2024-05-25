document.addEventListener("DOMContentLoaded", () => {
  // Realizar una solicitud GET a la API para obtener los datos de los gerentes
  fetch("/api/proveedoresgerentes", {
    method: "GET",
    headers: {
      "Content-Type": "application/json",
      // Aquí podrías agregar el token JWT si lo necesitas
    },
  })
    .then((response) => {
      if (!response.ok) {
        throw new Error("Error al obtener los datos de los gerentes");
      }
      return response.json();
    })
    .then((data) => {
      const gerentesContainer = document.getElementById("gerentes-container");
      // Iterar sobre los datos de los gerentes y crear una card para cada uno
      data.gerentes.forEach((gerente) => {
        const card = `
          <div class="row">
            <div class="col-sm-6 card card-person mb-3" style="max-width: 540px">
              <div class="row g-0">
                <div class="col-md-4">
                  <svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
                    <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0" />
                    <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1" />
                  </svg>
                </div>
                <div class="col-md-8">
                  <div class="card-body">
                    <h5 class="card-title">${gerente.nombre_Gerente} ${gerente.apellidos}</h5>
                    <p class="card-text">
                      Edad: ${gerente.edad} años<br />
                      Fecha de nacimiento: ${gerente.fechaNac}<br />
                      ...
                    </p>
                    <p class="card-text">
                      <small class="text-body-secondary">Correo electrónico: ${gerente.correoE}</small>
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        `;
        gerentesContainer.insertAdjacentHTML("beforeend", card);
      });
    })
    .catch((error) => {
      console.error("Error:", error.message);
    });
});
