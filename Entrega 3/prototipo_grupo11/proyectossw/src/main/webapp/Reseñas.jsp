<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.ArrayList"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Reseñas</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="${pageContext.request.contextPath}/css/reseñas.css" rel="stylesheet" type="text/css">
</head>
<body>
    <div id= "encabezado">
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
    <div id="contenido">
        
        
        <div id="cabeceracontenido">
            <% String nombre = (String) request.getSession().getAttribute("nombre"); 
            %>
            <span id="nombrebar" ><%=nombre%>-Reseñas</span>
            
            <% 
            float valoracionMedia = (float) request.getSession().getAttribute("valoracionMedia");
            NumberFormat numberFormat = NumberFormat.getInstance();
            numberFormat.setMaximumFractionDigits(1);
            String valoracionMediaString = numberFormat.format(valoracionMedia);
            %>
            <span><br>Valoración media: <%= valoracionMediaString %>/5 <br></span>

        </div>
        <div id="cuerpocontenido">
            <%
            // Obtén el ArrayList de la sesión del request
            ArrayList<String> usuarios = (ArrayList<String>) request.getSession().getAttribute("usuarios");
            ArrayList<String> descripciones = (ArrayList<String>) request.getSession().getAttribute("descripciones");
            ArrayList<Integer> calificaciones = (ArrayList<Integer>) request.getSession().getAttribute("calificaciones");
            ArrayList<Timestamp> fechas = (ArrayList<Timestamp>) request.getSession().getAttribute("fechas");

            %>
            <div id="reseñas" class="titulo-reseñas">
    <% int puntuacionActual=0;
    for (int i = 0; i < usuarios.size(); i++) { 
        puntuacionActual=calificaciones.get(i); %>
        <h3 align="left"><%= usuarios.get(i) %></h3>
        <div class="puntuacion">
            <div class="stars-outer">
                <div id="stars-inner-puntuacion" class="stars-inner" style="width: <%= puntuacionActual * 20 %>%"></div>
            </div>
        </div>
        <p class="comentario"><%= descripciones.get(i) %></p>
    <% } %>
    <% if (usuarios.isEmpty()) { %>
        <p align="center" class="gris">No hay reseñas</p>
    <% } %>
</div>
            <div id="postreseña">
                <form action="${pageContext.request.contextPath}/ReseñasEnvio" method="post" id="form">

                    <div id="puntuar" name="puntuacion">
                        <p class="clasificacion">
                            <input id="radio1" type="radio" name="estrellas" value="5" ">
                            <label for="radio1">★</label>
                            <input id="radio2" type="radio" name="estrellas" value="4" ">
                            <label for="radio2">★</label>
                            <input id="radio3" type="radio" name="estrellas" value="3" ">
                            <label for="radio3">★</label>
                            <input id="radio4" type="radio" name="estrellas" value="2" ">
                            <label for="radio4">★</label>
                            <input id="radio5" type="radio" name="estrellas" value="1" ">
                            <label for="radio5">★</label>
                        </p>
                </div>
                    <%
                    if (username == null){
                
                    %>
                    <h5 id = "publicar"> AVISO: INICIE SESIÓN PARA PUBLICAR</h5>
                   <textarea placeholder="Introduzca su reseña..." name="contenido" maxlength="200" oninput="updateCounter()" onfocus="changeColor()" onblur="resetColor()"></textarea>
                    <%}else{%>
                    <button type="submit" id = "publicar">Publicar reseña</button>
                    <textarea placeholder="Introduzca su reseña..." name ="contenido" maxlength="200" oninput="updateCounter()"></textarea>

                    <%}%>
                    <p align="right" class="gris" style="margin-right:5%"><span id="counter">0</span>/200</p>
                </form>

            </div>
        </div>
    </div>

    <script>       
        function updateCounter() {
              console.log("updateCounter called");

            var content = document.getElementsByName("contenido")[0].value;
            var counter = document.getElementById("counter");
            counter.textContent = content.length;
        }
        function changeColor() {
          var texto = document.getElementById("publicar");
          texto.style.color = "red";
        }

        function resetColor() {
            var texto = document.getElementById("publicar");
            texto.style.color = "black";
        }
        
    </script>
</body>
</html>