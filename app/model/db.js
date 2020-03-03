'use strict';

var mysql = require('mysql');

var connection = mysql.createConnection({
    host: 'localhost',
    user: 'rabsarisapp',
    password: 'rabsarisapp',
    database: 'rabsarisapp',
    multipleStatements: true
});

connection.connect((err) => {
    if (err) throw err;
});

module.exports = connection;