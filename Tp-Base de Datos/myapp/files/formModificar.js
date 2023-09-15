const contenedor = document.querySelector(".contenedorBotones");
const texto = document.querySelector(".texto");

function cambiar(name){
    texto.innerHTML = "A que valor quiere cambiar: " + name;
    contenedor.innerHTML = "";
    let fila = document.createElement("div");
    fila.className = "row";
    contenedor.appendChild(fila);
    let col = document.createElement("div");
    col.className = "col text-center padding";
    fila.appendChild(col);
    let input = document.createElement("input");
    input.className = "textForm";
    col.appendChild(input);
    input.setAttribute("type", "text");
    input.setAttribute("name", name);
    let fila2 = document.createElement("div");
    fila2.className = "row";
    contenedor.appendChild(fila2);
    let col2 = document.createElement("div");
    col2.className = "col text-center padding";
    fila2.appendChild(col2);
    let enviar = document.createElement("botton");
    enviar.className = "boton";
    enviar.innerHTML = "Enviar";
    enviar.setAttribute("type", "button");
    enviar.setAttribute("onclick","modificar('"+ name +"')")
    col2.appendChild(enviar);
}


function modificar(name){
    const formText = document.querySelector(".textForm");
    let objeto = {
        campo: name,
        valor: formText.value,
    }
    $.ajax({
        url: "http://localhost:3000/gestionar/modificar/" + window.location.search.slice(1, 2),
        type: 'PUT',
        contentType: "application/json",
        data: JSON.stringify(objeto)
    }).done((data) => {
    }).fail(() => {
        console.log("no se pudo modificar");
    });
}