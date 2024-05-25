const express = require("express");
const router = express.Router();
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const conexion = require("./db");

// Middleware para verificar el token
const verifyToken = (req, res, next) => {
  const token = req.headers["authorization"];

  if (!token) {
    return res.status(403).json({ message: "No se proporcionó un token" });
  }

  try {
    const decoded = jwt.verify(token.split(" ")[1], process.env.JWT_SECRET); // Verificar y decodificar el token
    req.user = decoded; // Guardar la información decodificada en el request
    next(); // Pasar al siguiente middleware o ruta
  } catch (error) {
    return res.status(401).json({ message: "Token inválido o expirado" });
  }
};

// Registro de nuevos usuarios
router.post("/signup", async (req, res) => {
  const { nombre_Usuario, correoE, contraseña } = req.body;

  if (!nombre_Usuario || !correoE || !contraseña) {
    return res.status(400).json({
      message:
        "Se necesita el nombre de usuario, correo electrónico y contraseña",
    });
  }

  // Verificar la seguridad de la contraseña (mínimo 8 caracteres)
  if (contraseña.length < 8) {
    return res
      .status(400)
      .json({ message: "La contraseña debe tener al menos 8 caracteres" });
  }

  try {
    const insertQuery = "CALL Insertar_Usuario (?, ?, ?);";
    conexion.query(
      insertQuery,
      [nombre_Usuario, correoE, contraseña],
      (err, result) => {
        if (err) {
          console.error("Error registrando usuario:", err.message);
          return res.status(500).json({ message: "Error en el servidor" });
        }
        res.status(201).json({ message: "Usuario registrado exitosamente" });
      }
    );
  } catch (error) {
    console.error("Error en el servidor:", error.message);
    res.status(500).json({ message: "Error en el servidor" });
  }
});

// Inicio de sesión
router.post("/login", async (req, res) => {
  const { correoE, contraseña } = req.body;

  if (!correoE || !contraseña) {
    return res
      .status(400)
      .json({ message: "Se necesita el correo electrónico y contraseña" });
  }

  try {
    const selectQuery = "SELECT * FROM Usuario WHERE correoE = ?";
    conexion.query(selectQuery, [correoE], async (err, results) => {
      if (err) {
        console.error("Error al buscar el usuario:", err.message);
        return res.status(500).json({ message: "Error en el servidor" });
      }

      if (results.length === 0) {
        return res.status(401).json({ message: "Usuario no encontrado" });
      }

      const user = results[0];
      const isMatch = contraseña === user.contraseña;

      if (!isMatch) {
        return res.status(401).json({ message: "Contraseña incorrecta" });
      }

      // Generar un token JWT
      const token = jwt.sign(
        { id: user.id, correoE: user.correoE },
        process.env.JWT_SECRET,
        { expiresIn: "1h" }
      );

      res.status(200).json({ message: "Login exitoso", token });
    });
  } catch (error) {
    console.error("Error en el servidor:", error.message);
    res.status(500).json({ message: "Error en el servidor" });
  }
});

// Obtener gerentes
router.get("/proveedoresgerentes", verifyToken, (req, res) => {
  try {
    // Ejecutar el procedimiento almacenado para obtener los datos de los gerentes
    conexion.query("CALL ObtenerDatosGerentes()", (err, results) => {
      if (err) {
        console.error("Error al obtener datos de los gerentes:", err.message);
        return res.status(500).json({ message: "Error en el servidor" });
      }

      // Enviar los resultados como respuesta
      res.status(200).json({ gerentes: results[0] });
    });
  } catch (error) {
    console.error("Error en el servidor:", error.message);
    res.status(500).json({ message: "Error en el servidor" });
  }
});

// Ejemplo de ruta protegida
router.get("/protected", verifyToken, (req, res) => {
  res
    .status(200)
    .json({ message: "Acceso permitido a la ruta protegida", user: req.user });
});

module.exports = router;
