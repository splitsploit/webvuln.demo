const mysql = require("mysql2");

const db = mysql.createConnection({
  host: 'localhost',
  user: "root",
  port: 3306,
  password: "password",
  database: "isaa_db",
  multipleStatements: true
});

module.exports = db;
