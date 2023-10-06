
<%@page import="java.util.Arrays"%>
<%@page import="barlladolid.modelo.Horario"%>
<%@page import="barlladolid.modelo.Bar"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.NumberFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <% Bar miBar = (Bar) request.getSession().getAttribute("miBar");%>

        <% String nombre = miBar.getNombre(); %>


        <title><%= nombre %></title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/global.css"/>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/cssBar.css"/>
        <!-- Enlace a la hoja de estilos de Leaflet -->
        <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" /> 
        <!-- Enlace a la biblioteca de Leaflet -->
        <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    </head>
<body>
    <div id= "encabezado" style="z-index: 2;">
        <a href="${pageContext.request.contextPath}/PaginaPrincipal"><div id="logo">
            <h1>
                <img src="${pageContext.request.contextPath}/imagenes/img.png">
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
    
    
        
    <div id = "principal-izq">
        <div id="title">
            <div id="name">
                <h1><%= nombre %></h1>

            </div>
         <%if(username != null){%>
            <div id="like">
                <button type="button", id="like-button" name="like_<%=nombre%>" onclick="quitaFavorito('<%=nombre.replace("'", "\\'").replace("\"", "\\\"")%>')">❤️</button>    
                <button type="button", id="like-button-null" name = "like_null_<%=nombre%>" onclick="nuevoFavorito('<%=nombre.replace("'", "\\'").replace("\"", "\\\"")%>')">♡</button>    
            </div>
            <%}%>
                
        </div>
        <div id="map" style="height: 400px;z-index: 1;"></div>
        
    </div>
    <div id="principal-der">
        <img src="${pageContext.request.contextPath}/<%=miBar.getFoto()%>" alt="Imagen" width="95%" height="95%" style=" margin:0;">     
    </div>
    
    <div id="description">
    

        <b>Descripción: </b>
        <% if ((username!=null) &&(username.equals(miBar.getDueno()))){ %>
            <i class="fa fa-pencil" onclick="editBar('descripcion')"></i>
        <%}%>
        <br>
        <span id="descripcion"><%= miBar.getDescripcion() %></span>
        <input type="text" id="descripcionInput" style="display: none;">
        <br><br>

        <b>Dirección:</b>
        <% if ((username!=null) &&(username.equals(miBar.getDueno()))){ %>
            <i class="fa fa-pencil" onclick="editBar('direccion')"></i>
        <%}%>
        <br>
        <span id="direccion"><%= miBar.getDireccion() %></span>
        <input type="text" id="direccionInput" style="display: none;">
        <br><br>

        <b>Teléfono: </b>        <span id="telefono"><%= miBar.getTelefono() %></span>
        <% if ((username!=null) &&(username.equals(miBar.getDueno()))){ %>
            <i class="fa fa-pencil" onclick="editBar('telefono')"></i>
        <%}%>
        <br>
        <input type="text" id="telefonoInput" style="display: none;">
        <br>

        <b>Tipo: </b>        <span id="telefono"><%= miBar.getTipo() %></span>
        <br>
        <br>
        
        
        <%
        ArrayList<String> caracteristicas = (ArrayList<String>) request.getSession().getAttribute("caracteristicas");
        if(caracteristicas!=null){
            String car = "";
            for(String c : caracteristicas){
                car = car + c + ", ";
            }
            if(car != ""){
                car = car.substring(0, car.length()-2);
            
        %>
        
        <b>Caracteristicas:</b> <span><%=car%></span>
        <br>
        <br>

               <%}}
    ArrayList<Horario> horarios = (ArrayList<Horario>) request.getSession().getAttribute("horarios");
    String hor = "";
    ArrayList<String> dias1 = new ArrayList<>(Arrays.asList("Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado", "Domingo"));
    ArrayList<String> dias2 = new ArrayList<>();
    for(Horario h : horarios){
        dias2.add(h.getDiaSemana());
    }
    String diasAbierto = "";
    String diasCerrado = "";
    for(String d : dias1){
        if(dias2.contains(d)){
            diasAbierto = diasAbierto + d + ", ";
        } else {
            diasCerrado = diasCerrado + d + ", ";
        }
    }
    diasAbierto = diasAbierto.substring(0, diasAbierto.length() - 2);
    if(diasCerrado!= ""){
        diasCerrado = diasCerrado.substring(0, diasCerrado.length() - 2);
    }
    hor = "Abierto: "+hor + "de " + horarios.get(0).getInicio().toString() + " a " + horarios.get(0).getFin().toString();
%>


        
        <%
        // Obtén el ArrayList de la sesión del request
        ArrayList<String> ultimasValoraciones = (ArrayList<String>) request.getSession().getAttribute("ultimasValoraciones");

        %>
        
    </div>
        
    <div style="width: 23%;float:right;">
        <a style="text-decoration: none;" href = "${pageContext.request.contextPath}/DetallesBar/<%=nombre%>/Reseña">
        <div id="valoraciones">
            <% 
            float valoracionMedia = (float) request.getSession().getAttribute("valoracionMedia");
            NumberFormat numberFormat = NumberFormat.getInstance();
            numberFormat.setMaximumFractionDigits(1);
            String valoracionMediaString = numberFormat.format(valoracionMedia);

            %>
            Valoración media: <%= valoracionMediaString %>/5 <br>
            <div class="valoracion_media">
                <div class="stars-outer">
                    <div id="stars-inner-valoracionMedia" class="stars-inner"></div>
                </div>
            </div><br>
            Ultimas valoraciones:<br>
            <div class="valoracion_1">
                <div class="stars-outer">
                    <div id="stars-inner-valoracion1" class="stars-inner"></div>
                </div>
            </div>
            <div class="valoracion_2">
                <div class="stars-outer">
                    <div id="stars-inner-valoracion2" class="stars-inner"></div>
                </div>
            </div>
                            <!-- ★★☆☆☆ -->
        </div>
    </a>
    <table style="text-align: center; margin:0; width: 100%; border: 2px;
    margin-top: 10px;
    border-style: solid;
    margin-bottom: 15px;
    color: black;">
        <tr>
            <td><b><%=diasAbierto%></b></td>
        </tr>
        <tr>
            <td><%=hor%></td>
        </tr>
        <tr>
        <%if(diasCerrado!=""){
        %>
            <td><b><%=diasCerrado%></b></td>
        </tr>
        <tr>
            <td>Cerrado</td>
        </tr>
        <%}%>
    </table>
    </div>
        
        
    <script>    
        const ratings = {
        valoracionMedia: <%=valoracionMedia%>,
        <% System.out.println(ultimasValoraciones);
        if (!ultimasValoraciones.isEmpty()){%>         
        valoracion1: <%=Integer.parseInt(ultimasValoraciones.get(0))%>,
        <% } if (ultimasValoraciones.size()>1){%>
        valoracion2: <%=Integer.parseInt(ultimasValoraciones.get(1))%>
        <%}%>
    };

    for (const rating in ratings) {
        const starPercentage = (ratings[rating] / 5) * 100;
        const starPercentageRounded = Math.round(starPercentage / 10) * 10 + '%';
        const element = document.querySelector('#stars-inner-' + rating);
        if (element) {
            element.style.width = starPercentageRounded;
        } else {
            console.log('Element not found: #stars-inner-' + rating);
        }
    }
        

       
        // Crea un mapa y lo muestra en el contenedor con id 'map'
        var map = L.map('map').setView([41.65420987672593, -4.716357156149885], 15);

        // Agrega una capa de mosaico de OpenStreetMap al mapa
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '© OpenStreetMap contributors'
        }).addTo(map);

        // Obtén las coordenadas geográficas mediante geocodificación de la dirección
        var direccion = "<%= miBar.getDireccion() %>"; // Dirección en el formato deseado
        
        
        var geocodingUrl = "https://nominatim.openstreetmap.org/search?format=json&q=" + encodeURIComponent(direccion);

            fetch(geocodingUrl)
            .then(response => response.json())
            .then(data => {
                if (data.length > 0) {
                    var latitud = parseFloat(data[0].lat);
                    var longitud = parseFloat(data[0].lon);

                    // Centra la vista del mapa en la ubicación geocodificada
                    map.setView([latitud, longitud], 15);

                    // Agrega un marcador en la ubicación geocodificada
                    L.marker([latitud, longitud]).addTo(map)
                        .bindPopup("<%= nombre %>"); // Agrega la dirección como mensaje emergente al marcador
                } else {
                    console.error("No se encontraron coordenadas para la dirección especificada.");
                }
            })
            .catch(error => {
                console.error("Error al obtener las coordenadas: " + error);
            });

function editBar(campo) {
    // Obtener los elementos span y textarea
    var span = $('#' + campo);
    var textarea = $('#' + campo + 'Input');

    // Crear un elemento span oculto para medir el ancho del texto
    var textWidthSpan = $('<span>').css({
        'display': 'inline-block',
        'visibility': 'hidden',
        'white-space': 'pre'
    }).appendTo('body');

    // Obtener el texto actual del campo
    var valorActual = span.text().trim();

    // Establecer el valor del textarea y mostrarlo
    textarea.val(valorActual);
    textarea.show();
    span.hide();

    // Ajustar automáticamente el tamaño del textarea para mostrar todo su contenido
    textarea.on('input', function() {
        // Establecer el texto del elemento span oculto al mismo valor que el textarea
        textWidthSpan.text(textarea.val());

        // Obtener el ancho del texto
        var textWidth = textWidthSpan.width();

        // Obtener el ancho máximo disponible para el textarea
        var maxWidth = textarea.parent().width();

        // Establecer el ancho del textarea en función del ancho del texto y el ancho máximo disponible
        if (textWidth > maxWidth) {
            textarea.width(maxWidth);
        } else {
            textarea.width(textWidth);
        }

        // Ajustar la altura del textarea para mostrar todo su contenido
        this.style.height = 'auto';
        this.style.height = (this.scrollHeight) + 'px';
    });
    textarea.trigger('input');

    // Agregar un controlador de eventos para actualizar el campo cuando el usuario presione enter
    var nuevoValor;
    textarea.on('keydown', function(e) {
        if (e.key === 'Enter') {
            // Obtener el nuevo valor del campo
            nuevoValor = textarea.val();

            
            // Actualizar el campo en la página
            span.text(nuevoValor);

            // Ocultar el textarea y mostrar el span
            textarea.hide();
            span.show();

            // Crear una solicitud AJAX para enviar el nuevo valor al servidor
            var data = {};
            data[campo] = nuevoValor;
            $.ajax({
                url: '../ActualizaBar',
                method: 'POST',
                data: data,
                success: function(response) {
                    // La solicitud fue exitosa, manejar la respuesta aquí
                    // ...
                    
                    // Si se está editando la dirección, recargar la página
                    if (campo === 'direccion') {
                        location.reload();
                    }
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    // Hubo un error al enviar la solicitud, manejar el error aquí
                    console.error(textStatus, errorThrown);
                }
            });
            
        
        } else if (e.key === 'Escape') {
            // Si se presiona la tecla Escape, ocultar el textarea y mostrar el span con el valor original
            textarea.hide();
            span.show();
        }
        
    });
}




function updateMarkerPosition(direccion) {
    // Hacer una petición a la API de geolocalización para obtener las coordenadas de la dirección
    fetch("https://nominatim.openstreetmap.org/search?q=" + direccion + "&format=json&limit=1")
    .then(response => response.json())
    .then(data => {
        var latitud = data[0].lat;
        var longitud = data[0].lon;
        // Actualizar la posición del marcador en el mapa
        marker.setLatLng([latitud, longitud]);
        map.setView([latitud, longitud], 16);
    })
    .catch(error => console.log(error));
}

window.onload = function() {
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            var isFavorite = JSON.parse(this.responseText).isFavorite;
            if (isFavorite) {
                document.getElementById('like-button').style.display = 'inline';
                document.getElementById('like-button-null').style.display = 'none';
            } else {
                document.getElementById('like-button').style.display = 'none';
                document.getElementById('like-button-null').style.display = 'inline';
            }
        }
    };
    var username = "<%=username%>"; // Aquí debes obtener el nombre de usuario del cliente
    var barName = "<%=miBar.getNombre()%>"; // Aquí debes obtener el nombre del bar que quieres verificar
    xhr.open('GET', '../BaresFavoritos?username=' + encodeURIComponent(username) + '&barName=' + encodeURIComponent(barName), true);
    xhr.send();
}
       

    
  
    
    function nuevoFavorito(){
            $.ajax({
                url: '../BaresFavoritos',
                type: 'POST',
                data: {
                    username: "<%=username%>",
                    barName: "<%=miBar.getNombre()%>",
                    action: "add"
                },
                success: function(response) {
                    username: "<%=username%>",

                    
                        
                        // Aquí puedes manejar la respuesta del servlet
                        document.getElementById('like-button').style.display = 'inline';
                        document.getElementById('like-button-null').style.display = 'none'     
                    
                }
            });
        }
        function quitaFavorito(){
            $.ajax({
                url: '../BaresFavoritos',
                type: 'POST',
                data: {
                    username: "<%=username%>",
                    barName: "<%=miBar.getNombre()%>",
                    action: "remove"
                },
                success: function(response) {
                    
                        
                        // Aquí puedes manejar la respuesta del servlet
                        document.getElementById('like-button').style.display = 'none';
                        document.getElementById('like-button-null').style.display = 'inline'      
                    
                }
            });
        }
       
    </script>

 
</body>

</html>
