<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Datos del Bar</title>
        <link rel="stylesheet" type="text/css" href="./css/datosDelBar.css"/>

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
            <a href="./login.jsp"><button type="button">Iniciar sesión</button></a>
            <%}else{%>
            <a href="./Perfil"><button type="button">Mi perfil</button></a>

            <%}%>
            </div>
        </div>
        <%
        String nombre = request.getParameter("bar");
        String telefono = request.getParameter("telefono");
        String direccion = request.getParameter("direccion");
        String tipo = request.getParameter("tiposBar");
        String dueño = (String) request.getSession().getAttribute("username");
        String[] caracteristicasbar = request.getParameterValues("carBar");
        String[] dias = request.getParameterValues("day");
        String apertura = request.getParameter("openingTime");
        String cierre = request.getParameter("closingTime");

        %>
        <div id="detalles">
            <h1><%=nombre%></h1>
            <h4>CONFIRME LOS SIGUIENTES DATOS: </h4>
            
        </div>
        
        <br><br>
        
        <form action="SubirBar" method="POST" enctype="multipart/form-data">
            <div id = "leftDiv">
                 <input type="hidden" name="bar" value="<%= nombre %>">
                <input type="hidden" name="telefono" value="<%= telefono %>">
                <input type="hidden" name="direccion" value="<%= direccion %>">
                <input type="hidden" name="tiposBar" value="<%= tipo %>">
                <input type="hidden" name="username" value="<%= dueño %>">
                <input type="hidden" name="openingTime" value="<%= apertura %>">
                <input type="hidden" name="closingTime" value="<%= cierre %>">

                <% if (caracteristicasbar != null) { %>
                    <% for (String caracteristica : caracteristicasbar) { %>
                      <input type="hidden" name="carBar" value="<%= caracteristica %>">
                    <% } %>
                  <% } %>

              <% if (dias != null) { %>
 
                <% for (String dia : dias) { %>
                    <input type="hidden" name="day" value="<%= dia %>">
                <% } %>
                  <% } %>
            <h3>
                Añada imagenes del bar:
            </h3>
            
        <div class="image-upload">
          <input type="file" name="file" onchange="previewImage(event)" />
          <br>
          <img id="preview" src="" alt="" />
          <span id="drop-text">Arrastra aquí</span>

        </div>

    <!--                <input type="file" name="file" />

    <div id="drag-and-drop-area">
      <h4>Arrastra y suelta las imágenes o pulse aquí</h4>
    </div>
    -->

        </div>
            

            <div id="postreseña">
                <h3>Descripción del bar:</h3>

                <input type="hidden" name="file" id="filePath">

                <textarea placeholder="Introduzca una breve descripción..." name ="descBar" maxlength="500" onchange="comprobarValidez" oninput="updateCounter()"></textarea>
                <p align="right" class="gris" style="margin-right:5%"><span id="counter">0</span>/500</p>

            </div>
            
            <span id="msgerror" style="margin-left: 10px; margin-right: 10px; color: red">Faltan campos por rellenar: Imagen, Descripcion</span>
            <input id="enviar" type="submit" value="Enviar" disabled>
        </form>
            
<script>
    function comprobarValidez(){
        var imagen = document.getElementById("preview").getAttribute("src");
        var counter = document.getElementById("counter").innerText;
        var error = ""
        if(imagen == ""){
            error = "Imagen, "
        }
        if(counter == 0){
            error = error + "Descripción, "
        }
        if(error == ""){
            document.getElementById("enviar").disabled = false
            document.getElementById("msgerror").innerText = ""

        }else{
            error = error.substring(0, error.length -2)
            document.getElementById("enviar").disabled = true
            document.getElementById("msgerror").innerText = "Faltan campos por rellenar: " + error;

        }
    }
    
</script>

<script>  
            
  function previewImage(event) {
    var reader = new FileReader();
    reader.onload = function () {
      var preview = document.getElementById("preview");
      preview.src = reader.result;
      var dropText = document.getElementById("drop-text");
      dropText.style.display = "none";
      comprobarValidez();

    };
    reader.readAsDataURL(event.target.files[0]);
  }
        function updateCounter() {
            var content = document.getElementsByName("descBar")[0].value;
            var counter = document.getElementById("counter");
            counter.textContent = content.length;
            comprobarValidez();
        }
/*        
var dragDropArea = document.getElementById("drag-and-drop-area");
var form = document.querySelector("form"); // Replace this with a more specific selector if needed

// Create and append the file input element to the form
var fileInput = document.createElement("input");
fileInput.type = "file";
fileInput.name = "file";
fileInput.style.display = "none";
form.appendChild(fileInput);

dragDropArea.addEventListener("dragover", function(event) {
  event.preventDefault();
});

dragDropArea.addEventListener("click", function() {
  fileInput.click();
  fileInput.addEventListener("change", function() {
    var file = fileInput.files[0];

    // Store the selected file path in the hidden input field
    document.getElementById("filePath").value = file.name;
    var reader = new FileReader();
    reader.onload = function(event) {
      dragDropArea.innerHTML = "";
      var image = new Image();
      image.src = event.target.result;
      image.style.width = "90%";
      image.style.height = "90%";
      dragDropArea.appendChild(image);
    };
    reader.readAsDataURL(file);
  });
});

dragDropArea.addEventListener("drop", function(event) {
  event.preventDefault();
  var files = event.dataTransfer.files;
  if (files.length > 1) {
    alert("Solo se permite una imagen");
    return;
  }
  var file = files[0];

  // Create a new DataTransfer object
  var dataTransfer = new DataTransfer();

  // Add the dropped file to the DataTransfer object
  dataTransfer.items.add(file);

  // Set the value of the file input element to the DataTransfer object
  fileInput.files = dataTransfer.files;

  var reader = new FileReader();
  reader.onload = function(event) {
    dragDropArea.innerHTML = "";
    var image = new Image();
    image.src = event.target.result;
    image.style.width = "90%";
    image.style.height = "90%";
    dragDropArea.appendChild(image);
  };
  reader.readAsDataURL(file);
});
*/


        </script>
    </body>
    
</html>
    