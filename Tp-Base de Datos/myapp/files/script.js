const contenedorBotones = document.querySelector(".contenedor-botones");
const audio = new Audio();
const nombre = document.getElementsByClassName("nombre")[0];
const duracion = document.getElementsByClassName("duracion")[0];
const tipo = document.getElementsByClassName("tipo")[0];
const autor = document.getElementsByClassName("autor")[0];
const reproducciones = document.getElementsByClassName("reproducciones")[0];
const masRep = document.getElementsByClassName("masRep")[0];
const menosRep = document.getElementsByClassName("menosRep")[0];
const url =(window.location.search.slice(1,window.location.search.length).split(","));
let idsSonidos = [];
if(window.location.search === "") {
    idsSonidos = [1, 2, 3, 4, 5, 6, 7, 8, 9];
}else{
    for(let i of url){
        idsSonidos.push(Number(i));
    }
}

getSonidos();
function nombresBotones(botones){
    for(let boton of botones){
        $.ajax({
            url: "http://localhost:3000/datos/"+boton.getAttribute("sql"),
            type: 'POST'
        })
        .done(function (data) {
            boton.innerHTML = data[0].nombre;
            boton.setAttribute("src", data[0].src);
        })
        .fail(function (jqXHR, textStatus, errorThrown) {
            console.log("error, no se pudo ingresar los nuevos datos");
            console.log(jqXHR);
            console.log(textStatus);
            console.log(errorThrown);
        });
    }
}

function getSonidos(){
    let contadorFila = 0;
    let contador = 0;
    $.ajax({
        url: "http://localhost:3000/getSonidos",
        type: 'POST',
    }).done(function (data) {
        let row;
        for (let fila of data){
            if(!idsSonidos.includes(fila.id)){
                continue;
            }
            if(contadorFila === 0){
                row = document.createElement("div");
                row.className = "row fila";
                contenedorBotones.appendChild(row);
            }
            contadorFila++;
            let col = document.createElement("div");
            col.className = "col-4";
            row.appendChild(col);
            let boton = document.createElement("button");
            boton.className = "boton";
            boton.setAttribute("sql", fila.id);
            boton.setAttribute("src", "");
            boton.setAttribute("type", "button");
            boton.setAttribute("onclick", "reproducirAudio(this)");
            col.appendChild(boton);
            if(contadorFila === 3){
                contadorFila = 0;
            }
            contador++;
            if(contador > 9){
                break;
            }
        }
        nombresBotones(document.getElementsByClassName("boton"));
    }).fail(function (jqXHR, textStatus, errorThrown) {
        console.log("error, no se pudo traer los sonidos");
        console.log(jqXHR);
        console.log(textStatus);
        console.log(errorThrown);
    });
}

function reproducirAudio(boton){
    if(!audio.ended) {
        audio.pause();
    }
    let id = boton.getAttribute("sql");
    $.ajax({
        url: "http://localhost:3000/subir/"+id,
        type: 'POST',
    }).done(function (data) {})
      .fail(function (jqXHR, textStatus, errorThrown) {
        console.log("error, no se pudo ingresar los nuevos datos");
        console.log(jqXHR);
        console.log(textStatus);
        console.log(errorThrown);
    });
    $.ajax({
        url: "http://localhost:3000/datos/"+id,
        type: 'POST',
    }).done(function (data) {
        nombre.innerHTML = data[0].nombre;
        duracion.innerHTML = data[0].duracion;
        tipo.innerHTML = data[0].tipo;
        autor.innerHTML = data[0].autores;
        reproducciones.innerHTML = data[0].cantReproducciones;
    }).fail(function (jqXHR, textStatus, errorThrown) {
        console.log("error, no se pudo ingresar los nuevos datos");
        console.log(jqXHR);
        console.log(textStatus);
        console.log(errorThrown);
    });
    audio.src = boton.getAttribute("src");
    if(audio.paused) {
        audio.play();
    }
    actualizarRep();
}

function actualizarRep(){
    $.ajax({
        url: "http://localhost:3000/masReproducido",
        type: 'POST',
    }).done(function (data) {
        masRep.innerHTML = "Nombre: " + data[0].nombre +"\n Reproducciones: " + data[0].cantReproducciones;
    }).fail(function (jqXHR, textStatus, errorThrown) {
        console.log("error, no se pudo ingresar los nuevos datos");
        console.log(jqXHR);
        console.log(textStatus);
        console.log(errorThrown);
    });

    $.ajax({
        url: "http://localhost:3000/menosReproducido",
        type: 'POST',
    }).done(function (data) {
        menosRep.innerHTML = "Nombre: " + data[0].nombre +"\n Reproducciones: " + data[0].cantReproducciones;
    }).fail(function (jqXHR, textStatus, errorThrown) {
        console.log("error, no se pudo ingresar los nuevos datos");
        console.log(jqXHR);
        console.log(textStatus);
        console.log(errorThrown);
    });
}