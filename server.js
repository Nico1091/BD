const express =require('express');
const cors = require('cors');
const connection  = require ('./Database');

const app =express();
const  port  = 3000;

app.use(cors());
app.use(express.json());

app.get('/usuarios',(req,res) => {
    connection.query('SELECT * FROM Sucursal',(err,results) =>{
        if(err){
            res.status(500).send('error database');
            return;
        }
        res.json(results);
    })
});

app.listen(port, ()=>{
    console.log(`Servidor escuchando en el puerto ${port}`)

});