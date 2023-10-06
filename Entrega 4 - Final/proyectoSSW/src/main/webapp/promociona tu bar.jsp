<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Promociona tu bar</title>
    <link rel="stylesheet" type="text/css" href="css/style.css"/>
    <link rel="stylesheet" type="text/css" href="css/global.css"/>
    <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" /> 
    <!-- Enlace a la biblioteca de Leaflet -->
    <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script></head>
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
        <a href="login.jsp"><button type="button">Iniciar sesión</button></a>
        <%}else{%>
        <a href="./Perfil"><button type="button">Mi perfil</button></a>

        <%}%>
    </div>
    </div>
    <form action="./datosDelBar.jsp" method="POST" >
        <div id="promociona">
            <h1 id="titulo">Promociona tu bar</h1>

            <div id="bar">
                <br><br>
                <h3>Nombre del Bar:</h3>
                <input type="text" name="bar" id="nombrebar"/>

                <h3>Teléfono:</h3>
                <input type="text" name="telefono" id="telefonobar"/>
                
                <h3 style="float:left; margin-left: 65px">Dirección:</h3>
                <input type="hidden" id="direccionInput" name="direccion">
                <p id="direccion" name="direccion" type="text" style="float:right; width: 170.5px"> ... </p>

            </div> 

            <div id="mapa">
                <h3>Seleccione la ubicación del bar en el mapa:</h3>
                <div id="map"></div>
            </div>
        </div>

        <div id="tipos">
            <div id="tipos1">
                <h3>Seleccione el tipo al que puede ser asociado su bar:</h3>    
                <input type="radio" id="op1" name="tiposBar" value="Bar-restaurante">
                <label for="op1"> Bar-restaurante</label><br>
                <input type="radio" id="op2" name="tiposBar" value="Cafeteria">
                <label for="op2"> Cafeteria</label><br>
                <input type="radio" id="op3" name="tiposBar" value="Cervecería">
                <label for="op3"> Cervecería</label><br>
                <input type="radio" id="op4" name="tiposBar" value="Club nocturno">
                <label for="op4"> Club nocturno</label><br>
            </div>
            <div style="width: 47%; float:right;">
                <h3>
                    Seleccione caracteristicas sobre su bar:
                </h3>
                <input type="checkbox" id="car1" name="carBar" value="Terraza">
                <label for="car1"> Terraza</label><br>
                <input type="checkbox" id="car2" name="carBar" value="Servicio de terraza">
                <label for="car2"> Servicio de terraza</label><br>
                <input type="checkbox" id="car3" name="carBar" value="Multiplanta">
                <label for="car3"> Multiplanta</label><br>
                <input type="checkbox" id="car4" name="carBar" value="Pedidos a domicilio">
                <label for="car4"> Pedidos a domicilio</label><br>
            </div>
        </div>
        <div id = "caracteristicas">
            <div style="float:left; width: 40%">
               
                <h3>Seleccionar días:</h3>
                <input type="checkbox" id="lunes" name="day" value="Lunes">
                <label for="lunes">Lunes</label><br>
                <input type="checkbox" id="martes" name="day" value="Martes">
                <label for="martes">Martes</label><br>
                <input type="checkbox" id="miércoles" name="day" value="Miércoles">
                <label for="miércoles">Miércoles</label><br>
                <input type="checkbox" id="jueves" name="day" value="Jueves">
                <label for="jueves">Jueves</label><br>
                <input type="checkbox" id="viernes" name="day" value="Viernes">
                <label for="viernes">Viernes</label><br>
                <input type="checkbox" id="sábado" name="day" value="Sábado">
                <label for="sábado">Sábado</label><br>
                <input type="checkbox" id="domingo" name="day" value="Domingo">
                <label for="domingo">Domingo</label><br>
                <input type="radio" id="allDays" name="allDays">
                <label for ="allDays">Seleccionar todo</label><br>
            </div>
            <div style="float: right; width: 60%">
                <h3>Seleccionar hora de apertura:</h3>
                <select name ="openingTime">
                    <%for(int i = 0; i<24; i++){%>
                        <option value = "<%=i%>:00"><%=i%>:00</option>
                    <%}%>
                    <!-- Agrega más opciones según sea necesario -->
                </select>

                <h3>Seleccionar hora de cierre:</h3>
                <select name ="closingTime">
                    <%for(int i = 0; i<24; i++){%>
                        <option value = "<%=i%>:00"><%=i%>:00</option>
                    <%}%>
                    <!-- Agrega más opciones según sea necesario -->
                </select>
            </div>
        <div id="enviar">
            <span id="msgerror" style="color: red">Faltan campos por rellenar: Nombre, Telefono, Direccion, Horarios, Tipo</span>
            <button id="aplicar" disabled>
                Aplicar
            </button>
        </div>
    </form>
    

<script>
        var d = document.getElementsByTagName("input");
        for (var i = 0; i < d.length; i++) {
            d[i].setAttribute('onchange', 'comprobarValidez()');
        }
        
        function comprobarValidez(){
            var horarios = document.querySelectorAll('input[name="day"]:checked');
            var tipo = document.querySelectorAll('input[name="tiposBar"]:checked');
            var nombre = document.getElementById("nombrebar").value;
            var telefono = document.getElementById("telefonobar").value;
            var direccion = document.getElementById("direccionInput").value;

            var error = "";
            if(nombre == "" || nombre==null){
                error = "Nombre, ";
            }
            if(telefono == "" || telefono== null){
                error = error + "Telefono, ";
            }
            if(direccion == "" || direccion==null){
                error = error + "Direccion, ";
            }
            if(horarios.length == 0){
                error = error + "Horarios, ";
            }
            if(tipo.length == 0){
                error = error + "Tipo, ";
            }
            
            if(error == ""){
            //if(horarios.length != 0 && tipo.length != 0 && nombre != "" && nombre!=null && telefono != "" && telefono!= null && direccion != "" && direccion!=null){
                document.getElementById("aplicar").disabled = false
                document.getElementById("msgerror").innerText = ""
            }else{
                error = error.substring(0, error.length - 2)
                document.getElementById("aplicar").disabled = true
                document.getElementById("msgerror").innerText = "Faltan campos por rellenar: " + error
            }
        }


</script>
<script>

        
        // Crea un nuevo mapa Leaflet centrado en una ubicación específica y con un nivel de zoom inicial
        var map = L.map('map').setView([41.649251, -4.724532], 15);

        // Agrega una capa de mapa base de OpenStreetMap
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
          attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors',
          maxZoom: 18
        }).addTo(map);

        // Agrega un marcador en una ubicación específica

    var marker;

 // Manejador de eventos al hacer clic en el mapa
    map.on('click', function(e) {
        // Obtener coordenadas de ubicación seleccionada
        var latlng = e.latlng;
        var lat = latlng.lat;
        var lng = latlng.lng;
        
        // Eliminar el marcador anterior, si existe
        if (marker) {
            map.removeLayer(marker);
        }
        
        marker = L.marker(latlng).addTo(map);


        // Usar API de geocodificación de OpenStreetMap para obtener dirección
        var url = 'https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=' + lat + '&lon=' + lng;
        fetch(url)
            .then(function(response) {
                return response.json();
            })
            .then(function(data) {
                // Actualizar elemento HTML con la dirección obtenida
                document.getElementById('direccion').innerHTML = data.display_name;
                var direccion = data.address.road + ' ' + data.address.house_number + ', ' + data.address.city;
            document.getElementById('direccion').innerHTML = direccion;
            direccionInput.value = direccion;
            comprobarValidez();

            // Actualizar posición del marcador y ajustar vista del mapa
            marker.setLatLng(latlng);
            map.setView(latlng, 16);
            });
            

    // Set the value of the hidden input to the content of the <p> element
    direccionInput.value = direccion.textContent;
    });
    
    
    
  /*  
    var dropzone = document.getElementById('dropzone');

dropzone.addEventListener('dragover', function(event) {
  event.preventDefault();
  dropzone.classList.add('dragover');
});

dropzone.addEventListener('dragleave', function(event) {
  event.preventDefault();
  dropzone.classList.remove('dragover');
});

dropzone.addEventListener('drop', function(event) {
  event.preventDefault();
  dropzone.classList.remove('dragover');

  var files = event.dataTransfer.files;

  for (var i = 0; i < files.length; i++) {
    var formData = new FormData();
    formData.append('file', files[i]);

    var xhr = new XMLHttpRequest();
    xhr.open('POST', './SubirBar');
    xhr.onload = function() {
      if (xhr.status === 200) {
        console.log('Archivo subido con éxito.');
      } else {
        console.log('Error al subir archivo.');
      }
    };
    xhr.send(formData);
  }
});*/


var direccion = document.getElementById('direccion');
var direccionInput = document.getElementById('direccionInput');




  </script>
  <script>
    document.getElementById("allDays").onclick = function() {
              var checkboxes = document.getElementsByName("day");
              for (var i = 0; i < checkboxes.length; i++) {
                  checkboxes[i].checked = true;
          }
    };
  </script>
</body>
</html>
