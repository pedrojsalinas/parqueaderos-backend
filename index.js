var mysql = require('mysql');
const { Sequelize } = require('sequelize');

// conectar a mysql

// var con = mysql.createConnection({
//     host: "localhost",
//     user: "root",
//     password: "root",
//     port: 3306,
//     database: "parqueaderos",
//     socketPath: '/Applications/MAMP/tmp/mysql/mysql.sock'
// });

// con.connect(function (err) {
//     if (err) throw err;
//     console.log("Connected!");
// });

const sequelize = new Sequelize('parqueaderos', 'root', 'root', {
    host: '127.0.0.1',
    port: '8889',
    dialect: 'mysql',
});


// async function conexion() {
//     try {
//         await sequelize.authenticate();
//         console.log('Connection has been established successfully.');
//     } catch (error) {
//         console.error('Unable to connect to the database:', error);
//     }
// }

// sequelize.authenticate().then(function () {
//     console.log("sucess");
// }).catch(function (error) {
//     console.log("error: " + error);
// });

sequelize
    .query(
        'SELECT * FROM empresa ',
        { raw: true }, { status: 'active' }
    )
    .then(function (projects) {
        console.log(projects)
    })

var User = sequelize.define('User', {
    username: Sequelize.STRING,
    password: Sequelize.STRING
});


// const a = {
//     idEmpresa: Sequelize.,
//     nombre: Sequelize.STRING,
//     direccion: Sequelize.STRING,
//     latitud: Sequelize.STRING,
//     longitud: Sequelize.STRING,
//     num_espacios: Sequelize.STRING,
//     fraccion: Sequelize.STRING,
//     precio: 0.5,
//     descuento: 2.5
// }