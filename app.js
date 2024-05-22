// APIs
const express = require("express");
const router = express.Router();
const util = require("util");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const conexion = require("./db");
const { validate } = require("email-validator");

require("dotenv").config();

// Registro de nuevos usuarios
// Promisify the query method of your database connection
const query = util.promisify(conexion.query).bind(conexion);

router.post("/signup", async (req, res) => {
  const { nombre_Usuario, correoE, contraseña } = req.body;

  if (!nombre_Usuario || !correoE || !contraseña) {
    return res.status(400).json({
      message:
        "Se necesita el nombre de usuario, correo electrónico y contraseña",
    });
  }

  // Validate email format
  if (!validate(correoE)) {
    return res.status(400).json({
      message: "Correo electrónico inválido",
    });
  }

  // Verificar la seguridad de la contraseña (mínimo 8 caracteres)
  if (contraseña.length < 8) {
    return res.status(400).json({
      message: "La contraseña debe tener al menos 8 caracteres",
    });
  }

  try {
    // Hash the password
    const hashedPassword = await bcrypt.hash(contraseña, 10);

    // Insert user into database
    const insertQuery =
      "INSERT INTO Usuario (nombre_Usuario, correoE, contraseña) VALUES (?, ?, ?)";
    await query(insertQuery, [nombre_Usuario, correoE, hashedPassword]);

    res.status(201).json({ message: "Usuario registrado exitosamente" });
  } catch (error) {
    console.error("Error en el servidor:", error.message);
    res.status(500).json({ message: "Error en el servidor" });
  }
});

// Endpoint de login
router.post("/login", async (req, res) => {
  const { correoE, contraseña } = req.body;

  if (!correoE || !contraseña) {
    return res
      .status(400)
      .json({ message: "Se necesita el correo electrónico y contraseña" });
  }

  try {
    const query = "SELECT * FROM Usuario WHERE correoE = ?";
    conexion.query(query, [correoE], async (err, results) => {
      if (err) {
        console.error("Error al buscar el usuario:", err.message);
        return res.status(500).json({ message: "Error en el servidor" });
      }

      if (results.length === 0) {
        return res.status(401).json({ message: "Usuario no encontrado" });
      }

      const user = results[0];

      const isMatch = await bcrypt.compare(contraseña, user.contraseña);
      if (!isMatch) {
        return res.status(401).json({ message: "Contraseña incorrecta" });
      }

      // Generar un token JWT
      const token = jwt.sign(
        { id: user.id_Usuario, correoE: user.correoE },
        process.env.JWT_SECRET,
        { expiresIn: "1h" }
      );

      res.status(200).json({ message: "Login exitoso", token });
    });
  } catch (error) {
    res.status(500).json({ message: "Error en el servidor" });
  }
});

module.exports = router;
