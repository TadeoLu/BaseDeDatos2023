//Node Js
const express = require("express");
const app = express();
const bodyParser = require("body-parser");
const port = 3000;
const multer = require("multer");

const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, './files/Sonidos');
    },
    filename: (req, file, cb) => {
        cb(null, file.originalname);
    }
});

const upload = multer({ storage: storage});

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

app.get("/form", (req, res, error) => {
    res.sendFile(__dirname + "/files/form.html");
});

app.get("/sonidos", (req, res, error) => {
    res.sendFile(__dirname + "/files/sonidos.html");
});

app.post("/subir/:id", (req, res) => {
    let id = req.params['id'];
    connection.query("call subirReproducciones("+id+")", (error, results, fields) => {
        if (error) throw error;
    })
});

app.post("/datos/:id", (req, res) => {
    let id = req.params['id'];
    connection.query("select * from sonidos where id ="+id+";", (error, results, fields) => {
        if (error) throw error;
        res.send(results);
    });
});

app.post("/masReproducido", (req, res) => {
  connection.query("select * from masElegido;", (error, results, fields) => {
      if (error) throw error;
      res.send(results);
  });
});

app.post("/menosReproducido", (req, res) => {
  connection.query("select * from menosElegido;", (error, results, fields) => {
      if (error) throw error;
      res.send(results);
  });
});

app.delete("/borrar/:id", (req, res) => {
    let id = req.params.id;
    connection.query("delete from sonidos where id = " + id + ";", (error , results) => {
       if(error) throw error;
       res.send(results);
    });
});

app.post("/uploadFile",upload.single("archivo") , (req, res) => {
    let nombre = req.body.nombre;
    let src = req.body.url;
    let duracion = req.body.duracion;
    let tipo = req.body.tipo;
    let autor = req.body.autor;
    connection.query("insert into sonidos(nombre,src,duracion,tipo,autores,cantReproducciones) values (\""+nombre+"\",\"Sonidos/"+req.file.originalname+"\",\""+duracion+"\",\""+tipo+"\",\""+autor+"\",0);", (error, result) =>{
        if (error) throw error;
    })
    res.redirect('/');
});
app.listen(port);
console.log("Server started at http://localhost:" + port);
