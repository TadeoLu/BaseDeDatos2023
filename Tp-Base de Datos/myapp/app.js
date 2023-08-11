//Node Js
const express = require("express");
const app = express();
const bodyParser = require("body-parser");
const port = 3000;

var mysql = require("mysql");
var connection = mysql.createConnection({
  host: "localhost",
  user: "alumno",
  password: "alumnoipm",
  database: "soniditos",
});

connection.connect();

app.use(express.static("files"));
app.use(express.json());

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

app.get("/", (req, res, error) => {
  res.sendFile(__dirname + "/index.html");
});

app.post("/subir", (req, res) => {
    let id = req.body.id;
    connection.query("call subirReproducciones("+id+")", (error, results, fields) => {
        if (error) throw error;
    })
});

app.post("/datos", (req, res) => {
    let id = req.body.id;
    connection.query("select * from sonidos where id ="+id+";", (error, results, fields) => {
        res.send(results);
    });
});

app.listen(port);
console.log("Server started at http://localhost:" + port);
