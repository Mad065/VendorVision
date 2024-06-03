document.addEventListener("DOMContentLoaded", () => {
  const token = localStorage.getItem("token");

  if (!token) {
    handleLoginError("Por favor, inicia sesión primero.");
    return;
  }

  fetch("/api/pedidos", {
    method: "GET",
    headers: {
      "Content-Type": "application/json",
      Authorization: `Bearer ${token}`,
    },
  })
    .then((response) => {
      if (!response.ok) {
        throw new Error("Error al obtener los pedidos");
      }
      return response.json();
    })
    .then((data) => {
      renderPedidos(data.pedidos);
    })
    .catch((error) => {
      handleFetchError(error);
    });
});

function renderPedidos(pedidos) {
  const tabla = document.querySelector(".table tbody");
  tabla.innerHTML = ""; // Limpiar la tabla antes de renderizar los nuevos pedidos
  if (pedidos.length === 0) {
    // Si no hay pedidos, mostrar una alerta
    alert("No hay pedidos en la base de datos.");
    return;
  }
  pedidos.forEach((pedido) => {
    const fila = `
        <tr>
          <th scope="row">${pedido.gerente}</th>
          <td>${pedido.producto}</td>
          <td>${pedido.stock}</td>
          <td>${pedido.unidades}</td>
          <td>${pedido.precio_unitario}</td>
          <td>${pedido.importe_total}</td>
        </tr>
      `;
    tabla.innerHTML += fila;
  });
}

function handleLoginError(message) {
  alert(message);
  // Redirige al usuario a la página de inicio de sesión
  window.location.href = "/login.html";
}

function handleFetchError(error) {
  console.error("Error:", error.message);
  alert(
    "Error al obtener los pedidos. Por favor, vuelve a intentarlo más tarde."
  );
}
