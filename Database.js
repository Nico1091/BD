const mysql = require('mysql2');
const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'BancoDB'
});

connection.connect((err) => {
    if (err) {
        console.error('Error al conectarse a la base de datos:', err.message);
        return;
    }
    console.log('Conexión exitosa a la base de datos:', connection.config.database);
});

module.exports = connection;
