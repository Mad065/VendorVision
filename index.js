// Cargar variavles de .env
require("dotenv").config();

// Creacion servidor
const express = require("express");
const path = require("path");
const mysql = require("mysql");

const app = express();
const port = process.env.PORT || 3000;

// usar archivos estáticos desde la carpeta "public"
app.use(express.static(path.join(__dirname, 'public')));

// Conexión a la base de datos
const conexion = mysql.createConnection({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME
});

conexion.connect((err) => {
  if (err) {
    console.error('Error conectando a la base de datos:', err.message);
    return;
  }
  console.log('Conexión exitosa a la base de datos');
});

// Crear APIs

// Iniciar el servidor
app.listen(port, () => {
  console.log(`Servidor iniciado en http://localhost:${port}`);
});