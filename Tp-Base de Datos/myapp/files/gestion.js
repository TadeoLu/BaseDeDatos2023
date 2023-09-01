const lista = document.querySelector(".lista");
const tipo = window.location.pathname.split("/",3)[2];
const modElim = document.querySelector(".modElim");

getSonidos();
boton();
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
            col.className = "col-4";
            row.appendChild(col);
            let boton = document.createElement("button");
            boton.className = "boton-lleno";
            boton.setAttribute("sql", fila.id);
            boton.setAttribute("src", "");
            boton.setAttribute("type", "button");
            if(tipo == "eliminar") {
                boton.setAttribute("onclick", "eliminar(this)");
            }else{
                boton.setAttribute("onclick", "formModificar(this)");
            }
            col.appendChild(boton);
            if(contador === 3){
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

function boton(){
    let a = modElim.getElementsByTagName("a")[0];
    let b = a.getElementsByTagName("button")[0];
    if(tipo == "eliminar"){
        a.setAttribute("href", "/gestionar/modificar");
        b.innerHTML = "Modificar";
    }else{
        a.setAttribute("href", "/gestionar/eliminar");
        b.innerHTML = "Eliminar";
    }
}

function eliminar(boton){
    let id = boton.getAttribute("sql");
    $.ajax({
        url: "http://localhost:3000/gestionar/eliminar/"+boton.getAttribute("sql"),
        type: 'DELETE',
    }).done(function (data) {
        //boton.parentNode.parentNode.removeChild(boton.parentNode);
        location.reload();
    }).fail(function (jqXHR, textStatus, errorThrown) {
            console.log("error, no se pudo eliminar");
            console.log(jqXHR);
            console.log(textStatus);
            console.log(errorThrown);
        });
}

function modificar(boton, campo){
    let id = boton.getAttribute("sql");
    let datos = {
        campoModificar: campo,
    };
    $.ajax({
        url: "http://localhost:3000/gestionar/modificar/"+boton.getAttribute("sql"),
        type: 'PUT',
        contentType: "application/json",
        data: JSON.stringify(datos)
    }).done(function (data) {
    }).fail(function (jqXHR, textStatus, errorThrown) {
        console.log("error, no se pudo modificar");
        console.log(jqXHR);
        console.log(textStatus);
        console.log(errorThrown);
    });
}

function formModificar(boton){
    window.location.replace("/gestionar/formModificar/?"+boton.getAttribute("sql"));
}