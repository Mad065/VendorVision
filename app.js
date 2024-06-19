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

router.post("/gerentessignup", async (req, res) => {
  const {
    correoE,
    nombre_Gerente,
    apellido_Gerente,
    CURP,
    fechaNac,
    nombre_Tienda,
    tel_Tienda,
    colonia,
    calle,
    cp,
    ciudad,
    num_int,
    num_ext,
  } = req.body;

  if (
      !correoE ||
      !nombre_Gerente ||
      !apellido_Gerente ||
      !CURP ||
      !fechaNac ||
      !nombre_Tienda ||
      !tel_Tienda ||
      !colonia ||
      !calle ||
      !cp ||
      !ciudad ||
      !num_ext
  ) {
    return res.status(400).json({
      message: "Se necesitan los datos",
    });
  }

  try {
    const insertQuery =
        "CALL Insertar_Gerente(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    conexion.query(
        insertQuery,
        [
          nombre_Gerente,
          apellido_Gerente,
          CURP,
          fechaNac,
          nombre_Tienda,
          tel_Tienda,
          colonia,
          calle,
          cp,
          ciudad,
          num_int,
          num_ext,
          correoE,
        ],
        (err, result) => {
          if (err) {
            console.error("Error registrando gerente:", err.message);
            if (err.code === "ER_SP_WRONG_NO_OF_ARGS") {
              return res.status(400).json({
                message: "Número incorrecto de argumentos para el procedimiento",
              });
            }
            return res.status(500).json({ message: "Error en el servidor" });
          }
          res.status(201).json({ message: "Gerente registrado exitosamente" });
        }
    );
  } catch (error) {
    console.error("Error en el servidor:", error.message);
    res.status(500).json({ message: "Error en el servidor" });
  }
});

router.post("/proveedoressignup", async (req, res) => {
  const {
    correoE,
    nombre_Proveedor,
    apellido_Proveedor,
    birthdate,
    nombre_Empresa,
    colonia,
    calle,
    cp,
    ciudad,
    num_int,
    num_ext,
  } = req.body;

  if (
    !correoE ||
    !nombre_Proveedor ||
    !apellido_Proveedor ||
    !birthdate ||
    !nombre_Empresa ||
    !colonia ||
    !calle ||
    !cp ||
    !ciudad ||
    !num_ext
  ) {
    return res.status(400).json({
      message: "Se necesitan los datos",
    });
  }

  try {
    const insertQuery =
      "CALL Insertar_Proveedor(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    conexion.query(
      insertQuery,
      [
        nombre_Proveedor,
        apellido_Proveedor,
        nombre_Empresa,
        colonia,
        calle,
        cp,
        ciudad,
        num_int,
        num_ext,
        correoE,
      ],
      (err, result) => {
        if (err) {
          console.error("Error registrando gerente:", err.message);
          return res.status(500).json({ message: "Error en el servidor" });
        }
        res.status(201).json({ message: "Prooveedor registrado exitosamente" });
      }
    );
  } catch (error) {
    console.error("Error en el servidor:", error.message);
    res.status(500).json({ message: "Error en el servidor" });
  }
});

// obtener nombre de usuario
// Endpoint para obtener el nombre de usuario
router.get('/get-username', verifyToken, (req, res) => {
  const email = req.query.email;

  const query = 'SELECT nombre_Usuario FROM Usuario WHERE correoE = ?';

  conexion.query(query, [email], (err, results) => {
    if (err) {
      console.error('Error al obtener el nombre de usuario:', err);
      return res.status(500).json({ message: 'Error en el servidor' });
    }

    if (results.length > 0) {
      return res.status(200).json({ nombreUsuario: results[0].nombre_Usuario });
    } else {
      return res.status(404).json({ message: 'Usuario no encontrado' });
    }
  });
});

// Verificar si el correo ya está registrado
router.post("/correo-disponible", (req, res) => {
  const { correoE } = req.body;

  try {
    const selectQuery = "SELECT * FROM Usuario WHERE correoE = ?";
    conexion.query(selectQuery, [correoE], async (err, results) => {
      if (err) {
        console.error("Error al buscar el usuario:", err.message);
        return res.status(500).json({ message: "Error en el servidor" });
      }

      if (results.length === 0) {
        return res.status(200).json({ message: "Correo disponible" });
      } else {
        res.status(200).json({ message: "Correo no disponible" });
      }
    });
  } catch (error) {
    console.error("Error en el servidor:", error.message);
    res.status(500).json({ message: "Error en el servidor" });
  }
});

// Verificar si el CURP ya está registrado
router.post("/curp-disponible", (req, res) => {
  const { CURP } = req.body;

  if (!CURP) {
    return res.status(400).json({ message: "CURP es requerido" });
  }

  try {
    const selectQuery = "SELECT * FROM Gerente WHERE CURP = ?";
    conexion.query(selectQuery, [CURP], async (err, results) => {
      if (err) {
        console.error("Error al buscar el CURP:", err.message);
        return res.status(500).json({ message: "Error en el servidor" });
      }

      if (results.length === 0) {
        return res.status(200).json({ message: "CURP disponible" });
      } else {
        return res.status(200).json({ message: "CURP no disponible" });
      }
    });
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
        { expiresIn: "1y" }
      );

      res.status(200).json({ message: "Login exitoso", token });
    });
  } catch (error) {
    console.error("Error en el servidor:", error.message);
    res.status(500).json({ message: "Error en el servidor" });
  }
});

// Revisar si es gerente o proveedor
router.get('/check-role', (req, res) => {
  const { email } = req.query;

  if (!email) {
    return res.status(400).send({ error: 'El correo electrónico es requerido' });
  }

  // Consulta para verificar si el usuario es un gerente
  const queryGerente = `
        SELECT g.id_Gerente
        FROM Gerente g
        INNER JOIN Rel_Usuario_Gerente rug ON g.id_Gerente = rug.id_Gerente
        INNER JOIN Usuario u ON rug.id_Usuario = u.id_Usuario
        WHERE u.correoE = ?`;

  // Consulta para verificar si el usuario es un proveedor
  const queryProveedor = `
        SELECT p.id_Proveedor
        FROM Proveedor p
        INNER JOIN Rel_Usuario_Proveedor rup ON p.id_Proveedor = rup.id_Proveedor
        INNER JOIN Usuario u ON rup.id_Usuario = u.id_Usuario
        WHERE u.correoE = ?`;

  conexion.query(queryGerente, [email], (err, results) => {
    if (err) {
      console.error('Error en la consulta de gerente:', err.stack);
      return res.status(500).send({ error: 'Error en el servidor' });
    }

    if (results.length > 0) {
      return res.send({ role: 'gerente', id_Gerente: results[0].id_Gerente });
    }

    conexion.query(queryProveedor, [email], (err, results) => {
      if (err) {
        console.error('Error en la consulta de proveedor:', err.stack);
        return res.status(500).send({ error: 'Error en el servidor' });
      }

      if (results.length > 0) {
        return res.send({ role: 'proveedor', id_Proveedor: results[0].id_Proveedor });
      } else {
        return res.send({ role: 'no encontrado' });
      }
    });
  });
});

// Obtener los datos del producto (Ventas.js)
router.get("/productos", verifyToken, (req, res) => {
  const { clave } = req.query;

  if (!clave) {
    return res
      .status(400)
      .json({ message: "La clave del producto es requerida" });
  }

  try {
    const query = "CALL ObtenerDatosProductos(?);";
    conexion.query(query, [parseInt(clave)], (err, results) => {
      if (err) {
        console.error("Error al obtener el producto:", err.message);
        return res.status(500).json({ message: "Error en el servidor" });
      }
      res.status(200).json({ productos: results[0] });
      console.log("Producto obtenido correctamente");
    });
  } catch (error) {
    console.error("Error en el servidor:", error.message);
    res.status(500).json({ message: "Error en el servidor" });
  }
});

// Obtener stock de proveedores
router.get("/stock-proveedor", (req, res) => {
  const { correoE } = req.query;

  if (!correoE) {
    return res.status(400).json({ message: "Se requiere el correo electrónico del proveedor" });
  }

  try {
    const query = "CALL Obtener_Stock_Proveedores(?);";
    conexion.query(query, [correoE], (err, results) => {
      if (err) {
        console.error("Error al obtener el stock de los proveedores:", err.message);
        return res.status(500).json({ message: "Error en el servidor" });
      }
      res.status(200).json({ stockProveedores: results[0] });
      console.log("Stock de proveedores obtenido correctamente");
    });
  } catch (error) {
    console.error("Error en el servidor:", error.message);
    res.status(500).json({ message: "Error en el servidor" });
  }
});

// Obtener stock de gerente
router.get("/stock-gerente", (req, res) => {
  const { correoE } = req.query.correoE;

  if (!correoE) {
    return res.status(400).json({ message: "Se requiere el correo electrónico del gerente" });
  }

  try {
    const query = "CALL Obtener_Stock_Gerente(?);";
    conexion.query(query, [correoE], (err, results) => {
      if (err) {
        console.error("Error al obtener el stock del gerente:", err.message);
        return res.status(500).json({ message: "Error en el servidor" });
      }
      res.status(200).json({ stockGerente: results[0] });
      console.log("Stock del gerente obtenido correctamente");
    });
  } catch (error) {
    console.error("Error en el servidor:", error.message);
    res.status(500).json({ message: "Error en el servidor" });
  }
});

// Realizar venta
router.post("/realizar-venta", (req, res) => {
  const { productos, correoGerente } = req.body;
  const fechaVenta = new Date().toISOString().split('T')[0]; // Fecha de la venta en formato YYYY-MM-DD

  const productosJSON = JSON.stringify(productos);

  conexion.query('CALL realizar_venta(?, ?, ?)', [correoGerente, fechaVenta, productosJSON], (err, results) => {
    if (err) {
      return res.status(500).send('Error al realizar la venta');
    }
    res.send('Venta realizada con éxito');
  });
});

// Registrar producto
router.post("/registrar_producto", (req, res) => {
  const {
    clave,
    nombre_Producto,
    descripcion,
    caducidad,
    tipo_Producto,
    precio,
    correoE
  } = req.body;

  // Validación de campos
  if (
      !clave ||
      !nombre_Producto ||
      !descripcion ||
      !caducidad ||
      !tipo_Producto ||
      !precio ||
      !correoE
  ) {
    res.status(400).json({ message: "Todos los campos son requeridos" });
    return;
  }

  const query = `CALL RegistrarProducto(?, ?, ?, ?, ?, ?, ?)`;

  conexion.query(
      query,
      [
        clave,
        nombre_Producto,
        descripcion,
        caducidad,
        tipo_Producto,
        precio,
        correoE
      ],
      (error, results) => {
        if (error) {
          console.error("Error ejecutando el procedimiento almacenado:", error);
          res.status(400).json({ message: error.message });
          return;
        }
        res.status(201).json({ message: "Producto registrado exitosamente" });
      }
  );
});

// Obtener gerentes
router.get("/obtener-gerentes", verifyToken, (req, res) => {
  try {
    // Ejecutar el procedimiento almacenado para obtener los datos de los gerentes
    conexion.query("CALL ObtenerDatosGerentes()", (err, results) => {
      if (err) {
        console.error("Error al obtener datos de los gerentes:", err.message);
        return res.status(500).json({ message: "Error en el servidor" });
      }

      // Enviar los resultados como respuesta
      res.status(200).json({ gerentes: results[0] });
      console.log("Gerentes obtenidos correctamente");
    });
  } catch (error) {
    console.error("Error en el servidor:", error.message);
    res.status(500).json({ message: "Error en el servidor" });
  }
});

// Obtener proveedores
router.get("/obtener-proveedores", verifyToken, (req, res) => {
  try {
    // Ejecutar el procedimiento almacenado para obtener los datos de los proveedores
    conexion.query("CALL ObtenerDatosProveedores()", (err, results) => {
      if (err) {
        console.error("Error al obtener datos de los proveedores:", err.message);
        return res.status(500).json({ message: "Error en el servidor" });
      }

      // Enviar los resultados como respuesta
      res.status(200).json({ proveedores: results[0] });
      console.log("Proveedores obtenidos correctamente");
    });
  } catch (error) {
    console.error("Error en el servidor:", error.message);
    res.status(500).json({ message: "Error en el servidor" });
  }
});

// Hacer pedido
router.post("/hacer_pedido", verifyToken, async (req, res) => {
  try {
    // Aquí recibes los detalles del pedido desde el cuerpo de la solicitud
    const {
      clave_producto,
      correo_usuario,
      cantidad_pedida,
      fecha_pedido
    } = req.body;

    // Llamada al procedimiento almacenado para insertar el pedido
    connection.query(
        "CALL InsertarPedido(?, ?, ?, ?)",
        [clave_producto, correo_usuario, cantidad_pedida, fecha_pedido],
        (error, results) => {
          if (error) {
            console.error("Error al insertar el pedido:", error.message);
            res.status(500).json({ message: "Error al procesar el pedido" });
          } else {
            console.log("Pedido realizado con éxito");
            res.status(200).json({ message: "Pedido realizado con éxito" });
          }
        }
    );
  } catch (error) {
    console.error("Error:", error.message);
    res.status(500).json({ message: "Error al procesar el pedido" });
  }
});

// Obtener pedidos
router.get("/obtener_pedidos_proveedor", verifyToken, (req, res) => {
  const { correoE } = req.query;

  if (!correoE) {
    return res.status(400).json({ message: "Correo del proveedor es requerido" });
  }

  try {

    // Llamar al procedimiento almacenado con el correo del proveedor
    const query = "CALL ObtenerPedidosProveedor(?);";
    conexion.query(query, [correoE], (err, results) => {
      if (err) {
        console.error("Error al obtener los datos de los pedidos:", err.message);
        return res.status(500).json({ message: "Error en el servidor" });
      }
      res.status(200).json({ pedidos: results[0] });
      console.log("Pedidos obtenidos correctamente");
    });
  } catch (error) {
    console.error("Error en el servidor:", error.message);
    res.status(500).json({ message: "Error en el servidor" });
  }
});

router.post('/confirmar_pedido', verifyToken, async (req, res) => {
  const { id_Pedido } = req.body;

  if (!id_Pedido) {
    return res.status(400).json({ success: false, message: 'El ID del pedido es requerido' });
  }

  try {
    const [result] = await pool.query('UPDATE Pedido SET confirmado = 1 WHERE id_Pedido = ?', [id_Pedido]);

    if (result.affectedRows === 0) {
      return res.status(404).json({ success: false, message: 'Pedido no encontrado' });
    }

    res.json({ success: true, message: 'Pedido confirmado exitosamente' });
  } catch (error) {
    console.error('Error al confirmar el pedido:', error);
    res.status(500).json({ success: false, message: 'Error interno del servidor' });
  }
});

// Obtener pedidos
router.get("/obtener_pedidos_gerente", verifyToken, (req, res) => {
  const { correoE } = req.query;

  if (!correoE) {
    return res.status(400).json({ message: "Correo del proveedor es requerido" });
  }

  try {

    // Llamar al procedimiento almacenado con el correo del proveedor
    const query = "CALL ObtenerPedidosGerente(?);";
    conexion.query(query, [correoE], (err, results) => {
      if (err) {
        console.error("Error al obtener los datos de los pedidos:", err.message);
        return res.status(500).json({ message: "Error en el servidor" });
      }
      res.status(200).json({ pedidos: results[0] });
      console.log("Pedidos obtenidos correctamente");
    });
  } catch (error) {
    console.error("Error en el servidor:", error.message);
    res.status(500).json({ message: "Error en el servidor" });
  }
});

router.post('/marcar_entregado', verifyToken, async (req, res) => {
  const { id_Pedido } = req.body;

  if (!id_Pedido) {
    return res.status(400).json({ success: false, message: 'El ID del pedido es requerido' });
  }

  try {
    const [result] = await pool.query('UPDATE Pedido SET entregado = 1 WHERE id_Pedido = ?', [id_Pedido]);

    if (result.affectedRows === 0) {
      return res.status(404).json({ success: false, message: 'Pedido no encontrado' });
    }

    res.json({ success: true, message: 'Pedido marcado como entregado' });
  } catch (error) {
    console.error('Error al marcar como entregado:', error);
    res.status(500).json({ success: false, message: 'Error interno del servidor' });
  }
});

// Obtener producto por clave
router.get('/obtener_producto', verifyToken, async (req, res) => {
  const { clave } = req.query;

  if (!clave) {
    return res.status(400).json({ success: false, message: 'La clave del producto es requerida' });
  }

  try {
    const [rows] = await pool.query('CALL Obtener_Producto_Por_Clave(?)', [clave]);

    if (rows.length === 0) {
      return res.status(404).json({ success: false, message: 'Producto no encontrado' });
    }

    res.json({ success: true, producto: rows[0] });
  } catch (error) {
    console.error('Error al obtener el producto:', error);
    res.status(500).json({ success: false, message: 'Error interno del servidor' });
  }
});

// Modificar producto
router.post('/modificar_producto', verifyToken, async (req, res) => {
  const { clave, nombre_Producto, descripcion, caducidad, precio, tipo_Producto } = req.body;

  if (!clave || !nombre_Producto || !descripcion || !caducidad || !precio || !tipo_Producto) {
    return res.status(400).json({ success: false, message: 'Todos los campos son requeridos' });
  }

  try {
    const [tipoProductoIdResult] = await pool.query('SELECT id_Tipo_Producto FROM Cat_Tipo_Producto WHERE tipo_Producto = ?', [tipo_Producto]);

    if (tipoProductoIdResult.length === 0) {
      return res.status(404).json({ success: false, message: 'Tipo de producto no encontrado' });
    }

    const id_Tipo_Producto = tipoProductoIdResult[0].id_Tipo_Producto;

    await pool.query('CALL Modificar_Producto(?, ?, ?, ?, ?, ?)', [clave, nombre_Producto, descripcion, caducidad, precio, tipo_Producto]);

    res.json({ success: true, message: 'Producto modificado exitosamente' });
  } catch (error) {
    console.error('Error al modificar el producto:', error);
    res.status(500).json({ success: false, message: 'Error interno del servidor' });
  }
});

// Modificar ganancia de un producto
router.post('/modificar_ganancia_producto', verifyToken, async (req, res) => {
  const { clave, ganancia } = req.body;

  if (!clave || !ganancia) {
    return res.status(400).json({ success: false, message: 'La clave del producto y la nueva ganancia son requeridas' });
  }

  try {
    // Llamar al procedimiento almacenado para modificar la ganancia del producto
    await pool.query('CALL Modificar_Ganancia_Producto(?, ?)', [clave, ganancia]);

    res.json({ success: true, message: 'Ganancia del producto modificada exitosamente' });
  } catch (error) {
    console.error('Error al modificar la ganancia del producto:', error);
    res.status(500).json({ success: false, message: 'Error interno del servidor' });
  }
});

// Ejemplo de ruta protegida
router.get("/protected", verifyToken, (req, res) => {
  res
    .status(200)
    .json({ message: "Acceso permitido a la ruta protegida", user: req.user });
});

module.exports = router;
