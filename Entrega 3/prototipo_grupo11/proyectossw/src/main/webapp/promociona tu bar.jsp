
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Promociona tu bar</title>
    <link rel="stylesheet" type="text/css" href="css/style.css"/>
    <link rel="stylesheet" type="text/css" href="css/global.css"/>
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
        
    <div id="promociona">
        <h1 id="titulo">Promociona tu bar</h1>
    
        <div id="bar">
            <br><br>
            <h3>Nombre del Bar:</h3>
            <input type="text" name="bar"/>
    
            <h3>Teléfono:</h3>
            <input type="text" name="telefono"/>
        </div>
    
        <div id="mapa">
            <h3>Seleccione la ubicación del bar en el mapa:</h3>
            <a href="Mapa.jsp"><img src="imagenes/mapa.png"></img></a>
        </div>
    </div>
        
    <div id="tipos">
        <div id="tipos1">
            <h3>Seleccione los tipos a los que puede ser asociado su bar:</h3>    
            <input type="checkbox" id="op1" name="op1" value="Bar-restaurante">
            <label for="op1"> Bar-restaurante</label><br>
            <input type="checkbox" id="op2" name="op2" value="Cafeteria">
            <label for="op2"> Cafeteria</label><br>
            <input type="checkbox" id="op3" name="op3" value="Cervecería">
            <label for="op3"> Cervecería</label><br>
            <input type="checkbox" id="op4" name="op4" value="Club nocturno">
            <label for="op4"> Club nocturno</label><br>
            <input type="checkbox" id="op5" name="op5" value="Otros">
            <label for="op5"> Otros</label><br>
        </div>
        <div style="width: 47%; float:right;">
            <h3>
                Seleccione caracteristicas sobre su bar:
            </h3>
            <input type="checkbox" id="car1" name="op1" value="Terraza">
            <label for="op1"> Terraza</label><br>
            <input type="checkbox" id="car2" name="op2" value="Servicio de terraza">
            <label for="op2"> Servicio de terraza</label><br>
            <input type="checkbox" id="car3" name="op3" value="Multiplanta">
            <label for="op3"> Multiplanta</label><br>
            <input type="checkbox" id="car4" name="op4" value="Pedidos a domicilio">
            <label for="op4"> Pedidos a domicilio</label><br>
            <input type="checkbox" id="car5" name="op5" value="Otros">
            <label for="op5"> Otros</label><br>
        </div>
    </div>
    <div id = "caracteristicas">
        <h3>
            Añada imagenes del bar:
        </h3>
        <img src="imagenes/upload.png" id ="imagenes"></img>
    </div>
    <div id="enviar">
        <button>
            Aplicar
        </button>
    </div>
    
</body>
</html>