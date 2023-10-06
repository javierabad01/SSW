
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.NumberFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <% String nombre = (String) request.getSession().getAttribute("nombre"); %>


    <title><%= nombre %></title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/global.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/cssBar.css"/>
    <!-- Enlace a la hoja de estilos de Leaflet -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" /> 
    <!-- Enlace a la biblioteca de Leaflet -->
    <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
    <div id= "encabezado" style="z-index: 2;">
        <a href="${pageContext.request.contextPath}/index.jsp"><div id="logo">
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
        <a href="${pageContext.request.contextPath}/perfil.jsp"><button type="button">Mi perfil</button></a>

        <%}%>
        </div>
    </div>
    
        
    <div id = "principal-izq">
        <div id="title">
            <div id="name">
                <h1><%= nombre %></h1>

            </div>
            <div id="like">
                <button type="button", id="like-button">❤️</button>    
            </div>
        </div>
        <div id="map" style="height: 400px;z-index: 1;"></div>
        
    </div>
    <div id="principal-der">
<%  
    String foto = (String) request.getSession().getAttribute("foto");
%>
        <img src="${pageContext.request.contextPath}/<%=foto%>" alt="Imagen" width="95%" height="95%" style=" margin:0;">     
    </div>
    
    <div id="description">
    <% String descripcion = (String) request.getSession().getAttribute("descripcion"); %>
    <% String direccion = (String) request.getSession().getAttribute("direccion"); %>
    <% String telefono = (String) request.getSession().getAttribute("telefono"); %>


        <b>Descripción:</b><br>
        <%= descripcion %>
        <br><br>
        <b>Dirección:</b><br>
        <%= direccion %> 
        <br><br>
        <b>Teléfono: </b><%=telefono%>
        <%
        // Obtén el ArrayList de la sesión del request
        ArrayList<String> ultimasValoraciones = (ArrayList<String>) request.getSession().getAttribute("ultimasValoraciones");

        %>
        
    </div>
        <a href = "${pageContext.request.contextPath}/DetallesBar/<%=nombre%>/Reseña">
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
            </div><br>
                            <!-- ★★☆☆☆ -->
        </div>
    </a>
        
        
    <script>    
        const ratings = {
        valoracionMedia: <%=valoracionMedia%>,
        valoracion1: <%=Integer.parseInt(ultimasValoraciones.get(0))%>,
        valoracion2: <%=Integer.parseInt(ultimasValoraciones.get(1))%>
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
        var direccion = "<%= direccion %>"; // Dirección en el formato deseado
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
    </script>

 
</body>

</html>
