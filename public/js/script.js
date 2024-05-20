document.addEventListener("DOMContentLoaded", function() {
    const panelDerecho = document.getElementById("panel-derecho");
    const opciones = document.querySelectorAll(".list-link");
  
    opciones.forEach(function(opcion) {
      opcion.addEventListener("click", function() {
        // Eliminar la clase activa de todos los enlaces
        opciones.forEach(function(item) {
          item.classList.remove("active");
        });
        // Agregar la clase activa al enlace seleccionado
        this.classList.add("active");
  
        const target = this.getAttribute("data-target");
        // Cargar y mostrar contenido dinámico
        fetch(target)
          .then(response => response.text())
          .then(html => {
            panelDerecho.innerHTML = html;
          })
          .catch(error => console.error('Error al cargar el contenido:', error));
      });
    });
  });
  