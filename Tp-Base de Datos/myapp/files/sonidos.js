const lista = document.querySelector(".lista");
const eleccion = [];
getSonidos();
function llenarLista(botones){
    for (let boton of botones) {
        $.ajax({
            url: "http://localhost:3000/datos/"+boton.getAttribute("sql"),
            type: 'POST',
        }).done(function (data) {
                boton.innerText = data[0].nombre;
                boton.setAttribute("src", data[0].src);
            })
            .fail(function (jqXHR, textStatus, errorThrown) {
                console.log("error, no se pudo llenar los sonidos");
                console.log(jqXHR);
                console.log(textStatus);
                console.log(errorThrown);
            });
    }
}
function getSonidos(){
    let contador = 0;
    $.ajax({
        url: "http://localhost:3000/getSonidos",
        type: 'POST',
    }).done(function (data) {
        let row;
        for (let fila of data){
            if(contador === 0){
                row = document.createElement("div");
                row.className = "row fila";
                lista.appendChild(row);
            }
            contador++;
            let col = document.createElement("div");
            col.className = "col-3";
            row.appendChild(col);
            let boton = document.createElement("button");
            boton.className = "boton-lleno";
            boton.setAttribute("sql", fila.id);
            boton.setAttribute("src", "");
            boton.setAttribute("type", "button");
            boton.setAttribute("onclick", "elegir(this)")
            col.appendChild(boton);
            if(contador === 4){
                contador = 0;
            }
        }
        llenarLista(document.getElementsByClassName("boton-lleno"));
    }).fail(function (jqXHR, textStatus, errorThrown) {
        console.log("error, no se pudo traer los sonidos");
        console.log(jqXHR);
        console.log(textStatus);
        console.log(errorThrown);
    });
}

function elegir(boton) {
    if(eleccion.length < 9) {
        if (!boton.classList.contains("seleccionado")) {
            eleccion.push(boton.getAttribute("sql"));
            boton.classList.add("seleccionado");
        } else {
            let index = eleccion.indexOf(boton.getAttribute("sql"));
            eleccion.splice(index, 1);
            boton.classList.remove("seleccionado");
        }
    }else {
        enviar();
    }
}


function enviar(){

    window.location.replace("http://localhost:3000/?" + eleccion.toString())
}