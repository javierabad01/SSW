<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link href="css/login.css" rel="stylesheet" type="text/css">
</head>
<body>
    <div id="contenido">
        <div id="logo">
            <a href="PaginaPrincipal"><img src="imagenes/img.png"></a>
            <h2 align="center">¡La mejor página para encontrar bares vallisoletanos!</h2>
        </div>
        <div id="login">
            <h1>Inicio de sesión</h1>
            <h2>Nombre de usuario</h2>
            <form action="./IniciarSesion" method="GET">    
            <input type="text" name= "username" placeholder="Introduzca aqui su nombre de usuario">
            <h2>Contraseña</h2>
            <input type="password" name="password" placeholder="Introduzca aqui su contraseña">
            <button type="submit">Iniciar sesion</button>
            <h3>¿No tienes una cuenta todavia? ¡Registrate!</h3>
            </form>

            <a href="registro.jsp"><button>Registrarse</button></a>
             <% 
                String mensajeError = (String) request.getSession().getAttribute("mensajeError"); 
                if (mensajeError != null && !mensajeError.isEmpty()) {
            %>
                <p style="color: red;"><%= mensajeError %></p>
            <%
                }
            %>
        </div>

    </div>

<%
request.getSession().removeAttribute("mensajeError");
%>
</body>
</html>