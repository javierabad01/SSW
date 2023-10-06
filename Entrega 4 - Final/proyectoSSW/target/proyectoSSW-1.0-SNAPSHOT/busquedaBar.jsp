

<%@page import="barlladolid.modelo.Bar"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Bar-lladolid - Busqueda de bares</title>
    <link href="css/busquedaBar.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" /> 
    <!-- Enlace a la biblioteca de Leaflet -->
    <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


</head>
<!-- Color background = background-color:#ECFFFC -->
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
    <form action="./BuscarBar" method="GET">
        
            <div id="opciones">
        <p style="margin-top: 15px; margin-left: 10px; float: left">Busqueda por nombre</p>
            <input type="text" name="nombre" placeholder="Introduzca nombre bar">
            <select name="select">
                <option value="maxval">Mayor valoración media</option>
                <option value="minval">Menor valoración media</option>
                <option value="alf">A-Z</option>
                <option value="revalf">Z-A</option>
            </select>
            <p style="margin-top: 15px; float: right">Orden de los resultados</p> 
            <button type="submit" style="margin-top: 15px; margin-left: 10px; float: left" placeholder="Introduzca nombre bar"> Buscar </button>
    </div>
    <div id="filtros">
        <button type="button" id="limpiarfiltros" onclick="limpiarFiltros()">Limpiar filtros</button>
        <h2>Valoracion media</h2>
        <label><input type="checkbox" name="calif" value="2"> 1-2 estrellas</label><br>
        <label><input type="checkbox" name="calif" value="3"> 2-3 estrellas</label><br>
        <label><input type="checkbox" name="calif" value="4"> 3-4 estrellas</label><br>
        <label><input type="checkbox" name="calif" value="5"> 4-5 estrellas</label><br>
        <h2>Tipo</h2>
        <label><input type="checkbox" name="tipo" value="Bar-restaurante"> Bar-restaurante</label><br>
        <label><input type="checkbox" name="tipo" value="Cafeteria"> Cafetería</label><br>
        <label><input type="checkbox" name="tipo" value="Cerveceria"> Cervecería</label><br>
        <label><input type="checkbox" name="tipo" value="Bar nocturno"> Bar nocturno</label><br>
        <h2>Caracteristicas</h2>
        <label><input type="checkbox" name="carac" value="Terraza"> Terraza</label><br>
        <label><input type="checkbox" name="carac" value="Servicio de terraza"> Servicio de terraza</label><br>
        <label><input type="checkbox" name="carac" value="Multiplanta"> Multiplanta</label><br>
        <label><input type="checkbox" name="carac" value="Pedidos a domicilio"> Pedidos a domicilio</label><br>
        


    </div>
    </form>

    <div id="bares">
        <div id="mapa">
           <center><h3>Pulse en el mapa de abajo para buscar por direccion</h3></center>
            <center><a href="./GeolocalizacionMapa"><img src="imagenes/mapa.png" id="imagen"></img></a></center>
        </div>
        <%
            ArrayList<Bar> listabares = (ArrayList<Bar>) request.getSession().getAttribute("listabares");
            if (listabares != null){
            for(Bar b : listabares){
                String nombre = b.getNombre();
                Float calificacion = b.getVal();
                String foto = b.getFoto();
        %>
        
        <div class="bar" ">
            <a href="./DetallesBar/<%= nombre%>"style="text-decoration: none;">
                <img src="./<%=foto%>">
            </a>
            <%if(username != null){%>
            <div id="like">
                <button type="button", id="like-button" name="like_<%=nombre%>" onclick="quitaFavorito('<%=nombre.replace("'", "\\'").replace("\"", "\\\"")%>')">❤️</button>    
                <button type="button", id="like-button-null" name = "like_null_<%=nombre%>" onclick="nuevoFavorito('<%=nombre.replace("'", "\\'").replace("\"", "\\\"")%>')">♡</button>    
            </div>
            <%}%>
            <a href="./DetallesBar/<%= nombre%>"style="text-decoration: none;">
                <h2><%= nombre%></h2>
            </a>
            <hr>
            <%if (calificacion!=0.0){ %>
                <h3>Valoracion: <%= String.format("%.2f", calificacion)%></h3> 
            <% }else {%>
                <h3>Valoracion: Sin calificacion.</h3> 
            <%}%>

        </div>
        <% }}else{%>
        <div class="bar">
            <h4> Pulse en el botón "Buscar" de la barra superior para mostrar todos los bares</h4>
        </div>
        <%}%>
</div>

</div>

</body>
</html>

<script>
document.getElementById('limpiarfiltros').onclick = function() {
    var checkboxes = document.getElementsByName('carac');
    for (var checkbox of checkboxes) {
        checkbox.checked = false;
    }
    var checkboxes = document.getElementsByName('tipo');
    for (var checkbox of checkboxes) {
        checkbox.checked = false;
    }
    var checkboxes = document.getElementsByName('calif');
    for (var checkbox of checkboxes) {
        checkbox.checked = false;
    }
}

window.onload = function() {
  var bares = [<%
    if (listabares != null) {
      for (int i = 0; i < listabares.size(); i++) {
        %>"<%= listabares.get(i).getNombre()%>"<%= (i + 1 < listabares.size()) ? ", " : "" %><%
      }
    }
  %>];

  for (var i = 0; i < bares.length; i++) {
    obtenerFavorito(bares[i]);
  }

  function obtenerFavorito(barName) {
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 200) {
        var isFavorite = JSON.parse(this.responseText).isFavorite;
        if (isFavorite) {
          console.log(document.getElementsByName('like_null_' + barName));
          document.getElementsByName('like_' + barName)[0].style.display = 'inline';
          document.getElementsByName('like_null_' + barName)[0].style.display = 'none';
        } else {
          console.log(document.getElementsByName('like_null_' + barName));
          document.getElementsByName('like_' + barName)[0].style.display = 'none';
          document.getElementsByName('like_null_' + barName)[0].style.display = 'inline';
        }
      }
    };

    var username = "<%=username%>"; // Aquí debes obtener el nombre de usuario del cliente
    var encodedUsername = encodeURIComponent(username);
    var encodedBarName = encodeURIComponent(barName);

    xhr.open('GET', './BaresFavoritos?username=' + encodedUsername + '&barName=' + encodedBarName, true);
    xhr.send();
  }
}   

    
  
    
    function nuevoFavorito(nombre){
            $.ajax({
                url: './BaresFavoritos',
                type: 'POST',
                data: {
                    username: "<%=username%>",
                    barName: nombre,
                    action: "add"
                },
                success: function(response) {
                    username: "<%=username%>",

                    
                        
                        // Aquí puedes manejar la respuesta del servlet
                document.getElementsByName('like_'+nombre)[0].style.display = 'inline';
                document.getElementsByName('like_null_'+nombre)[0].style.display = 'none';   
                    
                }
            });
        }
        function quitaFavorito(nombre){
            $.ajax({
                url: './BaresFavoritos',
                type: 'POST',
                data: {
                    username: "<%=username%>",
                    barName: nombre,
                    action: "remove"
                },
                success: function(response) {
                    
                // Aquí puedes manejar la respuesta del servlet
                document.getElementsByName('like_'+nombre)[0].style.display = 'none';
                document.getElementsByName('like_null_'+nombre)[0].style.display = 'inline';
                    
                }
            });
        }
       
</script>
