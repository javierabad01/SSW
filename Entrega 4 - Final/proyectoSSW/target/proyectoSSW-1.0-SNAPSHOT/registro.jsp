<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Registro</title>
    <link href="css/login.css" rel="stylesheet" type="text/css">
</head>
<body>
    <div id="contenido">
        <div id="logo">
            <a href="PaginaPrincipal"><img src="imagenes/img.png"></a>
            <h2 align="center">¡La mejor página para encontrar bares vallisoletanos!</h2>
        </div>
        <div id="login">
            <h1>Registro de usuario</h1>
            <form action="./Registrar" method="POST">
                <h2>Correo electronico</h2>
                <input type="text" name="email" placeholder="Introduzca aqui su correo electronico">
                <h2>Nombre de usuario</h2>
                <input type="text" name="username" placeholder="Introduzca aqui su nombre de usuario">
                <h2>Contraseña</h2>
                <input type="password" name="password" placeholder="Introduzca aqui su contraseña">
                <h2>Repetir contraseña</h2>
                <input type="password" name="passwordRepeat" placeholder="Introduzca de nuevo su contraseña">
                <button type="submit">Registrar usuario</button>
            </form>

                <div id="error-msg"></div>
                <% 
                String mensajeError = (String) request.getSession().getAttribute("mensajeError"); 
                if (mensajeError != null && !mensajeError.isEmpty()) {
                %>
                <p style="color: red;"><%= mensajeError %></p>
                <%
                }
                %>
                
                <% 
                String successMessage = (String) request.getSession().getAttribute("successMessage"); 
                if (successMessage != null && !successMessage.isEmpty()) {
                %>
                <p style="color: #35B65A;" id="success-message"><%= successMessage %></p>
                <%
                }
                %>
<%
request.getSession().removeAttribute("mensajeError");
%>
<%
request.getSession().removeAttribute("successMessage");
%>
        </div>

    </div>

<script>
    if (document.getElementById("success-message")!==null){
        // Espera 1 segundo y redirige a la página principal
        setTimeout(function() {
            window.location.href = "PaginaPrincipal";
        }, 1500);
    }
    
</script>
</body>
</html>