// APIs
const express = require("express");
const router = express.Router();
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const conexion = require("./db");

// Registro de nuevos usuarios
router.post("/singup", async (req, res) => {
  const { email, password } = req.body;

  if (!email || !password) {
    return res
      .status(400)
      .json({ message: "Se necesita el email y contraseña" });
  }

  try {
    const hashedPassword = await bcrypt.hash(password, 10);

    const query = "INSERT INTO usuarios (email, password) VALUES (?, ?)";
    conexion.query(query, [email, hashedPassword], (err, result) => {
      if (err) {
        console.error("Error registrando usuario:", err.message);
        return res.status(500).json({ message: "Error en el servidor" });
      }
      res.status(201).json({ message: "Usuario registrado exitosamente" });
    });
  } catch (error) {
    res.status(500).json({ message: "Error en el servidor" });
  }
});

// Inicio de sesión
router.post("/login", (req, res) => {
  const { email, password } = req.body;

  if (!email || !password) {
    return res
      .status(400)
      .json({ message: "Nombre de usuario y contraseña son requeridos" });
  }

  const query = "SELECT * FROM usuarios WHERE email = ?";
  conexion.query(query, [email], async (err, results) => {
    if (err) {
      console.error("Error al buscar usuario:", err.message);
      return res.status(500).json({ message: "Error en el servidor" });
    }

    if (results.length === 0) {
      return res
        .status(401)
        .json({ message: "Nombre de usuario o contraseña incorrectos" });
    }

    const user = results[0];
    const isPasswordValid = await bcrypt.compare(password, user.password);

    if (!isPasswordValid) {
      return res
        .status(401)
        .json({ message: "Nombre de usuario o contraseña incorrectos" });
    }

    const token = jwt.sign(
      { id: user.id, email: user.email },
      process.env.JWT_SECRET,
      {
        expiresIn: "1h",
      }
    );

    res.status(200).json({ message: "Inicio de sesión exitoso", token });
  });
});

// Ruta protegida (ejemplo)
router.get("/protected", (req, res) => {
  // Extraer el token del encabezado de la solicitud
  const token = req.headers["authorization"];

  // Verificar si el token no está presente
  if (!token) {
    return res.status(403).json({ message: "Token no proporcionado" });
  }

  // Verificar el token
  jwt.verify(token, process.env.JWT_SECRET, (err, decoded) => {
    if (err) {
      return res.status(401).json({ message: "Token no válido" });
    }

    // Si el token es válido, conceder acceso al recurso protegido
    res.status(200).json({ message: "Acceso autorizado", user: decoded });
  });
});

module.exports = router;
