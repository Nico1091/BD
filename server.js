const express = require('express');
const cors = require('cors');
const connection = require('./Database');

const app = express();
const port = 3000;

app.use(cors());
app.use(express.json());

// Ruta para obtener usuarios (Sucursal en este caso)
app.get('/usuarios', (req, res) => {
    connection.query('SELECT * FROM Sucursal', (err, results) => {
        if (err) {
            console.error('Error en la consulta a la base de datos:', err.message);
            res.status(500).send('Error en la base de datos');
            return;
        }
        if (results.length === 0) {
            res.status(404).send('No se encontraron sucursales');
            return;
        }
        res.json(results);
    });
});

// Ruta para obtener el nombre de la base de datos
app.get('/bancodb', (req, res) => {
    res.json({ nombre: connection.config.database });
});

app.listen(port, () => {
    console.log(`Servidor escuchando en el puerto ${port}`);
});
