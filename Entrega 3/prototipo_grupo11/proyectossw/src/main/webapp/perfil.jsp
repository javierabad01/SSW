<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Tu Perfil</title>
    <link rel="stylesheet" href="css/perfil.css">
</head>

<body>
    <div id= "encabezado">
        <a href="index.jsp"><div id="logo">
            <h1>
                <img src="imagenes/img.png">
            </h1>
        </div></a>
    
        <div id="perfil">
            <button type="button">Editar perfil </button>
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

    <div>
        <div class="div1Infor">
            <div class="divColeccion">
                <p1 style="font-size:20px"><b>Coleccion de bares</b></p1>
                <a href="./DetallesBar/El t�o Molonio">
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

            </div>

            <div class="divPromocionados">
                <p1 style="font-size:20px"><b>Bares promocionados</b></p1>
                <a href="./DetallesBar/Kuik'as">
                    <div>

                        <div class="promImgKuikas">
                            <img src="imagenes/kuikas.jpg" style="width:150px; height:100px">
                        </div>
                        <div class="promTxtKuikas">
                            <b>Kuik-AS</b>

                    </div>
                </a>
                
                <div style="clear: right; clear:left;"></div>

                <a href="./DetallesBar/El t�o Molonio">
                    <div>
                        <div class="promImgMolonio">
                            <img src="imagenes/molonio.jpg" style="width:150px; height:100px">
                        </div>
                        <div class="promTxtMolonio">
                            <b>El Tio Molonio</b>
                        </div>
                    </div>
                </a>
            </div>
        </div>
    </div>

        <div class="div2Infor">
            <div style="height:100%">
                <p1 style="font-size:20px"><b>Ultimas rese�as</b></p1>

                <div>
                    <a href="./DetallesBar/Kuik'as" style="text-decoration: none;">
                        <div class="resTtlKuikas">
                            <b>Kuik-AS</b>
                        </div>

                        <div class="resTxtKuikas">
                            <text>Bar muy limpio, buen ambiente y precios asequibles. Lo recomiendo, especialmente su
                            bebida estrella, el Kuikazo.</text>

                        </div>
                    </a>
                    <a href="./DetallesBar/El t�o Molonio"  style="text-decoration: none;">
                        <div class="resTtlMolonio">
                            <b>El Tio Molonio</b>
                        </div>

                        <div class="resTxtMolonio">
                            <text>El trato en el bar no fue muy agradable,nos hicieron esperar 30 minutos para una mesa.
                                En general deja bastante que desear, no lo recomiendo.</text>

                        </div>
                    </a>
            </div>
        </div>
    </div>
</div>

</body>
</html>