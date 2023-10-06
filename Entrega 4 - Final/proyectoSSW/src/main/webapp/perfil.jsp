<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.ArrayList"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Tu Perfil</title>
    <link rel="stylesheet" href="css/perfil.css">
</head>

<body>
    <div id= "encabezado">
        <a href="PaginaPrincipal"><div id="logo">
            <h1>
                <img src="imagenes/img.png">
            </h1>
        </div></a>
    
        <div id="perfil">
            <button type="button" id="cerrarSesionBtn">Cerrar sesion </button>
            
            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <!-- Asegúrate de tener jQuery incluido -->

            <script>
              $(document).ready(function() {
                $("#cerrarSesionBtn").click(function() {
                  $.ajax({
                    url: "./Perfil",
                    type: "POST",
                    success: function() {
                      // Manejar la respuesta exitosa aquí, como redirigir al usuario a la página de inicio de sesión
                      window.location.href = "./PaginaPrincipal";
                    },
                    error: function() {
                      // Manejar el error aquí, si es necesario
                      alert("Error al cerrar sesión");
                    }
                  });
                });
              });
            </script>
            
        </div>
    </div>

    <div style="clear: right; clear:left;"></div>

    <div class="divPerfil">

        <div>
            <img class="imgPerfil" src="imagenes/profile.png">
        </div>
        
        <% String username = (String) request.getSession().getAttribute("username"); %>
        
        <b>
            <text style="font-size:20px"><%= username%></text>
        </b>
    </div>

        
    <%
        // Obtén el ArrayList de la sesión del request
        ArrayList<String> usuarios = (ArrayList<String>) request.getSession().getAttribute("usuarios");
        ArrayList<String> descripciones = (ArrayList<String>) request.getSession().getAttribute("descripciones");
        ArrayList<Integer> calificaciones = (ArrayList<Integer>) request.getSession().getAttribute("calificaciones");
        ArrayList<Timestamp> fechas = (ArrayList<Timestamp>) request.getSession().getAttribute("fechas");
        
    %>
    <form ction="/Perfil" method="GET">
      
 <div>
        <%
     //   ArrayList<String> bares = (ArrayList<String>) request.getSession().getAttribute("barFav");
     //   ArrayList<String> fotos = (ArrayList<String>) request.getSession().getAttribute("fotoFav");
        %>
      <!--           <div class="div1Infor">
            <div class="divColeccion">
                <p1 style="font-size:20px"><b>Coleccion de bares</b></p1>
              
                <a href="./DetallesBar/El tío Molonio">
                    <div>
                        <div class="colImgMolonio">
                            <img src="imagenes/molonio.jpg" style="width:150px; height:100px">
                        </div>
                        <div class="colTxtMolonio">
                            <b>El Tio Molonio</b>
                        </div>
                    </div>
                </a>

                <div style="clear: right; clear:left;"></div>
                <a href="./DetallesBar/Kuik'as">
                    <div>
                        <div class="colImgKuikas">
                            <img src="imagenes/kuikas.jpg" style="width:150px; height:100px">
                        </div>
                        <div class="colTxtKuikas">
                            <b>Kuik'AS</b>
                        </div>
                    </div>
                </a>

            </div> -->
            <%
    ArrayList<String> bares = (ArrayList<String>) request.getSession().getAttribute("barFav");
    ArrayList<String> fotos = (ArrayList<String>) request.getSession().getAttribute("fotoFav");
System.out.println(fotos);
%>
 <div class="div1Infor">
    <div class="divColeccion">
        <p1 style="font-size:20px"><b>Coleccion de bares</b></p1>
        <% for (int i = 0; i < bares.size(); i++) {%>
            <a href="./DetallesBar/<%=bares.get(i)%>">
                <div>
                    <div class="colImg">
                        <img src=".<%=fotos.get(i)%>" style="width:150px; height:100px">
                    </div>
                    <div class="colTxt">
                        <b><%=bares.get(i)%></b>
                    </div>
                </div>
            </a>
            <div style="clear: right; clear:left;"></div>
        <% } %>
    </div>

                <%
                    ArrayList<String> barP = (ArrayList<String>) request.getSession().getAttribute("barP");
               ArrayList<String> fotoP = (ArrayList<String>) request.getSession().getAttribute("fotoP");
              // System.out.println(fotosP);
               
        %>
         <div class="divPromocionados">

        <p1 style="font-size:20px"><b>Bares promocionados</b></p1>
        <% for (int i = 0; i < barP.size(); i++) {%>
            <a href="./DetallesBar/<%=barP.get(i)%>">
                <div>
                    <div class="colImg">
                        <img src=".<%=fotoP.get(i)%>" style="width:150px; height:100px">
                    </div>
                    <div class="colTxt">
                        <b><%=barP.get(i)%></b>
                    </div>
                </div>
            </a>
            <div style="clear: right; clear:left;"></div>
        <%
        }%>
        
    </div>
    </div>


        <div class="div2Infor">
            <%
                ArrayList<String> baresR = (ArrayList<String>) request.getSession().getAttribute("barRes");
                ArrayList<String> descR = (ArrayList<String>) request.getSession().getAttribute("descRes");
            %>
            <div style="height:100%">
                <p1 style="font-size:20px"><b>Ultimas reseñas</b></p1>
                <div>
                    <% for (int i = 0; i < baresR.size(); i++) { %>
                        <a href="./DetallesBar/<%=baresR.get(i)%>/Reseña" style="text-decoration: none;">
                            <div class="resTtl">
                                <b><%=baresR.get(i)%></b>
                            </div>
                            <div class="resTxt">
                                <text><%=descR.get(i)%></text>
                            </div>
                        </a>
                    <% } %>
                </div>
            </div>
            </div>
        </div>

    </div>
</form>

            
<script>
window.addEventListener('load', function() {
  $.ajax({
    url: '/miServlet',
    type: 'GET',
    success: function(data) {
      // Procesar la respuesta del servlet aquí
    }
  });
});
</script>
</body>
</html>