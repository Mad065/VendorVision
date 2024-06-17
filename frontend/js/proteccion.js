document.addEventListener("DOMContentLoaded", () => {
    const token = localStorage.getItem("token");
    const accountType = localStorage.getItem("accountType");

    if (!token) {
        alert("Por favor, inicia sesión primero.");
        window.location.href = "/login.html"; // Redirige a la página de inicio de sesión si no hay token
        return;
    }

    if (window.location.pathname.startsWith("/gerentes") && accountType !== "gerente") {
        alert("No tienes permiso para acceder a esta página.");
        window.location.href = "/noAutorizado.html"; // Redirige a una página de acceso no autorizado
        return;
    }

    if (window.location.pathname.startsWith("/proveedores") && accountType !== "proveedor") {
        alert("No tienes permiso para acceder a esta página.");
        window.location.href = "/noAutorizado.html"; // Redirige a una página de acceso no autorizado
        return;
    }
});