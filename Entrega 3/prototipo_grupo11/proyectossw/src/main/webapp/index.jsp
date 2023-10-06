<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Bar-lladolid - Pagina principal</title>
    <link href="css/paginaPrincipal.css" rel="stylesheet" type="text/css">
</head>
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
        <a href="login.jsp"><button type="button">Iniciar sesión</button></a>
        <%}else{%>
        <a href="perfil.jsp"><button type="button">Mi perfil</button></a>

        <%}%>
    </div>
</div>
<div id="contenido">
    <div id="botonescabecera">
        <a href="promociona tu bar.jsp"><button style="float:left"> <b>¡Promociona ahora tu bar! </b></button></a>
        <a href="busquedaBar.jsp"><button style="float:right"> <b>¡Encuentra los mejores bares de Valladolid!</b></button></a>
    </div>
    <hr>
    <h3 align="center">¡Encuentra los mejores bares de Valladolid con solo un click!</h3>

    <div class="recomendacion">
        <a href="./DetallesBar/El Tío Molonio"><img src="imagenes/molonio.jpg" class="bar"></a>
        <a href="./DetallesBar/El Tío Molonio"><div class="informacion">
            <h2> El tío Molonio, C. de los Alamillos, 9</h2>
            <img src="imagenes/4Estrellas.jpg" class="puntuacion">
        </div></a>
    </div>
    <div class="recomendacion">
        <a href="./DetallesBar/Kuik'as"><img src="imagenes/kuikas.jpg" class="bar"></a>
        <a href="./DetallesBar/Kuik'as"><div class="informacion">
            <h2> Kuik'As, C. Gardoqui, 6</h2>
            <img src="imagenes/3.5Estrellas.jpg" class="puntuacion">
        </div></a>
    </div>
</div>
</body>
</html>
