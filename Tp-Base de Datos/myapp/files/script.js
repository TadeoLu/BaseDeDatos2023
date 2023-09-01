
const botones = document.getElementsByClassName("boton");
const audio = new Audio();
const nombre = document.getElementsByClassName("nombre")[0];
const duracion = document.getElementsByClassName("duracion")[0];
const tipo = document.getElementsByClassName("tipo")[0];
const autor = document.getElementsByClassName("autor")[0];
const reproducciones = document.getElementsByClassName("reproducciones")[0];
const masRep = document.getElementsByClassName("masRep")[0];
const menosRep = document.getElementsByClassName("menosRep")[0];
nombresBotones();
function nombresBotones(){
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