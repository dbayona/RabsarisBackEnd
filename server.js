var express = require('express'),
    app = express(),
    bodyParser = require('body-parser');
port = process.env.PORT || 3000;

const mysql = require('mysql');

//connection configurations
const mc = mysql.createConnection({
    host: 'localhost',
    user: 'rabsarisapp',
    password: 'rabsarisapp',
    database: 'rabsarisapp'
});

//connect to database
mc.connect();

app.listen(port);

app.use(function(req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    res.header('Access-Control-Allow-Methods', 'PUT, POST, GET, DELETE, OPTIONS');
    next();
});

console.log('RabsarisApp Server started on: ' + port);

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

//importing route
var routes = require('./app/routes/appRoutes');
//register the route
routes(app);