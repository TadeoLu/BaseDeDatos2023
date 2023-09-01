const lista = document.querySelector(".lista");
let isDragging = false;
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
            boton.addEventListener("mousedown", (e) => {
                let esto = boton;
                isDragging = true;
                esto.style.cursor = "grabbing";
            });
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


document.addEventListener("mousemove", (e) => {
    if (isDragging) {
        boton.style.left = e.clientX - boton.clientWidth / 2 + "px";
        boton.style.top = e.clientY - boton.clientHeight / 2 + "px";
    }
});

document.addEventListener("mouseup", (boton) => {
    if (isDragging) {
        isDragging = false;
        boton.style.cursor = "grab";

        if (isInsideContainer(boton, contenedor)) {
            contenedor.appendChild(boton);
            boton.style.position = "static";
        }
    }
});

function isInsideContainer(element, container) {
    const elementRect = element.getBoundingClientRect();
    const containerRect = container.getBoundingClientRect();

    return (
        elementRect.left >= containerRect.left &&
        elementRect.right <= containerRect.right &&
        elementRect.top >= containerRect.top &&
        elementRect.bottom <= containerRect.bottom
    );
}