

<%@page import="java.io.InputStream"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Bar-lladolid - Busqueda de bares</title>
    <link href="css/busquedaBar.css" rel="stylesheet" type="text/css">
</head>
<!-- Color background = background-color:#ECFFFC -->
<body>
    <div id= "encabezado">
        <a href="index.jsp"><div id="logo">
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
        <a href="${pageContext.request.contextPath}/perfil.jsp"><button type="button">Mi perfil</button></a>

        <%}%>
        </div>
    </div>

<div id="contenido">
    <div id="opciones">
        <p style="margin-top: 15px; margin-left: 10px; float: left">Busqueda por nombre</p>
        <form action="./BuscarBar" method="GET">
                <input type="text" name="nombre" placeholder="Introduzca nombre bar">
                <button type="submit" style="margin-top: 15px; margin-left: 10px; float: left" name="nombre" placeholder="Introduzca nombre bar"> Buscar </button>

        </form>
        <select>
            <option>Mayor valoracion media</option>
            <option>Menor valoración media</option>
            <option>A-Z</option>
            <option>Z-A</option>
        </select>
        <p style="margin-top: 15px; float: right">Orden de los resultados</p>
    </div>
    <div id="filtros">
        <h1>Filtros</h1>
        <button style="margin-left: 10px">Limpiar filtros</button>
        <h2>Valoracion media</h2>
        <label><input type="checkbox"> Menos de 1 estrella</label><br>
        <label><input type="checkbox"> 1-2 estrellas</label><br>
        <label><input type="checkbox"> 2-3 estrellas</label><br>
        <label><input type="checkbox"> 3-4 estrellas</label><br>
        <label><input type="checkbox"> 4-5 estrellas</label><br>
        <h2>Tipo</h2>
        <label><input type="checkbox"> Bar-restaurante</label><br>
        <label><input type="checkbox"> Cafetería</label><br>
        <label><input type="checkbox"> Cervecería</label><br>
        <label><input type="checkbox"> Club nocturno</label><br>
        <label><input type="checkbox"> Otros</label><br>
        <button id="aplicar">Aplicar filtros</button>


    </div>
    <div id="bares">
        <div id="mapa">
           <center><h3>Pulse en el mapa de abajo para buscar por direccion</h3></center>
            <center><a href="Mapa.jsp"><img src="imagenes/mapa.png" id="imagen"></img></a></center>
        </div>
        <%
            ResultSet rs = (ResultSet) request.getSession().getAttribute("listabares");
            if (rs != null){
            while (rs.next()){
                String nombre = rs.getString("nombre");
                String direccion = rs.getString("direccion");
                String telefono = rs.getString("telefono");
                Float calificacion = rs.getFloat("valoracion_media");
                String tipo = rs.getString("tipo");
                String foto = rs.getString("foto");
        %>
        
        <div class="bar" ">
            <a href="./DetallesBar/<%= nombre%>"style="text-decoration: none;">
                <img src="./<%=foto%>">
            </a>
            <button type="button">Añadir a favoritos</button>
            <a href="./DetallesBar/<%= nombre%>"style="text-decoration: none;">
                <h2><%= nombre%></h2>
            </a>
            <hr>
            <h3>Valoracion: <%= calificacion%></h3> 

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
