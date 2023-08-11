
const botones = document.getElementsByClassName("btn");

for(let boton of botones){
    let datos = {id: boton.getAttribute("sql")};
    $.ajax({
        url: "http://localhost:3000/datos",
        type: 'POST',
        contentType: "application/json",
        data: JSON.stringify(datos)
    })
    .done(function (data) {
        console.log
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

function reproducirAudio(boton){
    let id = boton.getAttribute("sql");
    let datos = {
        id: id,
      };
      $.ajax({
        url: "http://localhost:3000/subir",
        type: 'POST',
        contentType: "application/json",
        data: JSON.stringify(datos)
    })
    .done(function (data) {})
    .fail(function (jqXHR, textStatus, errorThrown) {
    console.log("error, no se pudo ingresar los nuevos datos");
    console.log(jqXHR);
    console.log(textStatus);
    console.log(errorThrown);
});
      var audio = new Audio(boton.getAttribute("src"));
      audio.play();
}

