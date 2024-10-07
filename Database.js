const mysql=require('mysql2');
const  connection =mysql.createConnection({
   host:'localhost',  
   user:'root',
   password:'',
   database: 'bancodb'
});

connection.connect((err)=> {
    if(err){
     console.error('No ingreso a la base de datos',err);
     return   
    }
    console.log('Ingreso a la base de datos: '+ connection.config.database)
});

    module.exports=connection;   