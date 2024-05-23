// APIs
const express = require("express");
const router = express.Router();
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const conexion = require("./db");
const app = express();

// Registro de nuevos usuarios
router.post("/signup", async (req, res) => {
  const { nombre_Usuario, correoE, contraseña } = req.body;

  // Mandar a la base de datos
  const insertQuery = "CALL Insertar_Usuario (?, ?, ?);";

  // Ejecutar
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
});

module.exports = router;
