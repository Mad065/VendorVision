// Creacion servidor
const express = require("express");
const app = express();
const path = require("path");
const port = process.env.PORT || 3000;
const router = require("./app");

app.use(express.static(path.join(__dirname, "frontend")));
app.use(express.json());
app.use("/api", router);

app.listen(port, () => {
  console.log(`Servidor iniciado en http://localhost:${port}`);
});
