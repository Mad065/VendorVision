document.addEventListener("DOMContentLoaded", () => {
    // Obtener el nombre del usuario desde el localStorage
    const nombreUsuario = localStorage.getItem("nombre_Usuario");

    // Si existe el nombre del usuario, actualizar el contenido del elemento <strong> con id="nombre_Usuario"
    if (nombreUsuario) {
        document.getElementById("nombre_Usuario").textContent = nombreUsuario;
    }

    // Agregar el evento para cerrar sesión
    document.getElementById("logout").addEventListener("click", function(event) {
        event.preventDefault();
        // Limpiar los datos almacenados en el localStorage
        localStorage.clear();

        // Redirigir a la página de inicio de sesión
        window.location.href = "login.html";
    });
});
