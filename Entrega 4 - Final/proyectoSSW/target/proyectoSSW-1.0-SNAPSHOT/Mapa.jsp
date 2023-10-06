<%@page import="barlladolid.modelo.Bar"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Mapa</title>
    <link href="css/mapa.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />

</head>
<body>
<div id= "encabezado">
    <a href="PaginaPrincipal"><div id="logo">
        <h1>
            <img src="imagenes/img.png">
        </h1>
    </div></a>

    <div id="perfil">
        <%
            String username = (String) request.getSession().getAttribute("username");
            if (username == null){
                
        %>
        <a href="${pageContext.request.contextPath}/login.jsp"><button type="button">Iniciar sesión</button></a>
        <%}else{%>
        <a href="${pageContext.request.contextPath}/Perfil"><button type="button">Mi perfil</button></a>

        <%}%>
        </div>
</div>

<div id="contenido">
    <div style = "float:bottom; margin-top:25px">
        <div id="opciones">
            <h4 align="center">BARES POR LOCALIZACIÓN</h4>
            <p align = "center">Seleccione el radio de busqueda</p>
            <div id="slider">
                <span>100m</span>
                <input type="range" min="100" max="2000" value="100" class="slider" id="myRange">
                <span>2km</span>
            </div>

            <%
            // Obtén el ArrayList de la sesión del request
            ArrayList<Bar> listaBares = (ArrayList<Bar>) request.getSession().getAttribute("listaBares");
            %>

            <form align="center" action="./GeolocalizacionMapa" method="GET" onsubmit="return enviarSeleccion(this)">
              Seleccione un bar<br>
              <select size="10" name="bar" onchange="habilitarboton()">
                
              </select>
              <br>
              <input id="enviarseleccion" type="submit" value="Enviar selección" disabled>
            </form>
        </div>
        <div id="mapa"></div>
    </div>
</div>
<script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>

        <script>
        function habilitarboton(){
            document.getElementById("enviarseleccion").disabled = false
        }
        var baresDentroDelCirculo = [];

            
        // crea un mapa con las coordenadas del centro y nivel de zoom predeterminados
        var mymap = L.map('mapa').setView([41.652251, -4.724532], 13);

        // agrega una capa de azulejos de OpenStreetMap
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors',
                maxZoom: 18
        }).addTo(mymap);

        var circle = L.circle([41.652251, -4.724532], { radius: 100 });
        circle.addTo(mymap);
        mymap.fitBounds(circle.getBounds());
        
        var actualizarBaresTimeout;

        var slider = document.getElementById("myRange");
        slider.addEventListener("input", function() {
            clearTimeout(actualizarBaresTimeout);
            actualizarBaresTimeout = setTimeout(actualizarDistancias, 1000);

        });
 
        slider.oninput = function() {
                var radius = parseInt(this.value);
                circle.setRadius(radius);
                mymap.fitBounds(circle.getBounds());
        };
        // Centra el círculo en el medio del mapa
        circle.setLatLng(mymap.getCenter());
        mymap.on('move', function() {
            circle.setLatLng(mymap.getCenter());
        });
        mymap.on('moveend', function() {
            clearTimeout(actualizarBaresTimeout);
            actualizarBaresTimeout = setTimeout(actualizarDistancias, 1000);

        });
        
        
var listaBares = [
    <% for (Bar bar : listaBares) { %>
        {
            nombre: "<%= bar.getNombre() %>",
            direccion: "<%= bar.getDireccion() %>"
            
        },
    <% } %>
    
];




function getLatLong(bar) {
    var address = bar.direccion;
    var url = "https://nominatim.openstreetmap.org/search?q=" + address.replace(" ", "+") + "&format=json&addressdetails=1";
    return fetch(url)
        .then(response => response.json())
        .then(data => {
            if (data.length > 0) {
                var firstResult = data[0];
                var lat = firstResult.lat;
                var lon = firstResult.lon;
                bar.lon= lon;
                bar.lat = lat;

            } else {
                console.log("No se encontraron resultados");
            }
        })
        .catch(error => {
            console.error('Error al obtener los datos de la API:', error);
        });
}
   
function actualizarDistancias(){
    baresDentroDelCirculo = [];
    listaBares.forEach(bar => {
                getLatLong(bar).then(() => {
                    var barLatLng = L.latLng(bar.lat, bar.lon);
                    var circleCenter = circle.getLatLng();
                    var distance = barLatLng.distanceTo(circleCenter);
                    if (distance <= circle.getRadius()) {
                        baresDentroDelCirculo.push(bar);
                        actualizarMarcas();
                        actualizarSelect();


                    } else {
                        actualizarMarcas();
                        actualizarSelect();
                    }
                });
            });

}
function actualizarSelect() {
    var select = document.querySelector('select[name="bar"]');
    select.innerHTML = '';
    baresDentroDelCirculo.forEach(function(bar) {
        var option = document.createElement('option');
        option.value = bar.nombre;
        option.textContent = bar.nombre;
        select.appendChild(option);
    });
}

var markers = [];
var select = document.querySelector('select[name="bar"]');

function actualizarMarcas() {
    // Eliminar marcas existentes del mapa
    markers.forEach(function(marker) {
        mymap.removeLayer(marker);
    });
    markers = [];

    // Agregar nuevas marcas al mapa
    baresDentroDelCirculo.forEach(function(bar, index) {
        var marker = L.marker([bar.lat, bar.lon])
            .addTo(mymap)
            .bindPopup(bar.nombre)
            .on('click', function() {
                select.selectedIndex = index;
            });
        markers.push(marker);
    });
}

// Llamar a la función actualizarMarcas cada vez que se actualice el array baresDentroDelCirculo
// Por ejemplo:
baresDentroDelCirculo.push(bar);
actualizarMarcas();

// Agregar un controlador de eventos al menú desplegable para actualizar la marca seleccionada en el mapa
select.addEventListener('change', function() {
    var selectedIndex = select.selectedIndex;
    var selectedMarker = markers[selectedIndex];
    selectedMarker.openPopup();
});

function enviarSeleccion(form) {
        var select = form.querySelector('select[name="bar"]');
        var selectedBar = select.value;
        window.location.href = './DetallesBar/' + encodeURIComponent(selectedBar);
        return false;
    }
        
</script>
</body>
</html>
