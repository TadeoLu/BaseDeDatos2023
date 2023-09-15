//Node Js
const express = require("express");
const app = express();
const bodyParser = require("body-parser");
const port = 3000;
const multer = require("multer");
const path = require("path");

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

app.use(express.static(path.join(__dirname, "/files")));
app.use(express.json());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

app.get("/", (req, res, error) => {
  res.sendFile(__dirname + "/files/index.html");
});

app.get("/form", (req, res, error) => {
    res.sendFile(__dirname + "/files/form.html");
});

app.get("/gestionar/formModificar", (req, res, error) => {
    res.sendFile(__dirname + "/files/formModificar.html");
});

app.get("/sonidos", (req, res, error) => {
    res.sendFile(__dirname + "/files/sonidos.html");
});

app.get("/gestionar/eliminar/", (req, res, error) => {
   res.sendFile(__dirname + "/files/gestion.html");
});
app.get("/gestionar/modificar/", (req, res, error) => {
    res.sendFile(__dirname + "/files/gestion.html");
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

app.post("/getSonidos", (req, res, error) => {
   connection.query("select * from sonidos;" , (error, result, fields) => {
       if (error) throw error;
       res.send(result);
   });
});

app.delete("/gestionar/eliminar/:id", (req, res, error) => {
    connection.query("delete from sonidos where id = "+ req.params.id + ";", (error, result, fields) => {
        if(error) throw error;
        res.send(result);
    });
});

app.put("/gestionar/modificar/:id", (req, res, error) => {
    connection.query("update sonidos set "+req.body.campo+" = '"+ req.body.valor +"' where id = " + req.params.id, (error, result, fields) => {
       if (error) throw error;
       res.send(result);
    });
});



app.listen(port);
console.log("Server started at http://localhost:" + port);
