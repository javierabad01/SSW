<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Bar-lladolid - Pagina principal</title>
    <link href="css/paginaPrincipal.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

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
        <a href="login.jsp"><button type="button">Iniciar sesión</button></a>
        <%}else{%>
        <a href="./Perfil"><button type="button">Mi perfil</button></a>

        <%}%>
    </div>
</div>
<div id="contenido">
    <div id="botonescabecera">
        <%if (username != null){%>
        <a href="promociona tu bar.jsp"><button style="float:left"> <b>¡Promociona ahora tu bar! </b></button></a>
        <%}else{%>
        <a href="login.jsp"><button style="float:left"> <b>¡Promociona ahora tu bar! </b></button></a>
        <%}%>
        <a href="busquedaBar.jsp"><button style="float:right"> <b>¡Encuentra los mejores bares de Valladolid!</b></button></a>
    </div>
    <hr>
    <h3 align="center">¡Encuentra los mejores bares de Valladolid con solo un click!</h3>

    <%
    // Obtén el ArrayList de la sesión del request
    ArrayList<String> bares = (ArrayList<String>) request.getSession().getAttribute("baresInicio");
    ArrayList<String> fotos = (ArrayList<String>) request.getSession().getAttribute("fotosInicio");
    ArrayList<String> calificaciones = (ArrayList<String>) request.getSession().getAttribute("calificacionesInicio");
    ArrayList<String> direcciones = (ArrayList<String>) request.getSession().getAttribute("direccionesInicio");

    for (int i = 0; i < bares.size(); i++) {
%>
        <div class="recomendacion">
            <a href="./DetallesBar/<%=bares.get(i)%>"  class="bar"><img src=".<%=fotos.get(i)%>" class="imgPortada"></a>
            <a href="./DetallesBar/<%=bares.get(i)%>"><div class="informacion">
                <h2><%=bares.get(i)%>, <%=direcciones.get(i)%></h2>
                <div id="valoraciones" style="margin-left: 30px;">
                    <div class="valoracion_media">
                        <div class="stars-outer">
                            <div id="stars-inner-puntuacion" class="stars-inner" style="width: <%= Float.parseFloat(calificaciones.get(i)) * 20 %>%"></div>
                        </div>
                    </div>
                </div>
            </div></a>
        </div>
<%
    }
%>
</div>
</body>
</html>
