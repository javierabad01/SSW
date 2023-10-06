DROP TABLE IF EXISTS horario;
DROP TABLE IF EXISTS fotosbar;
DROP TABLE IF EXISTS favoritos;
DROP TABLE IF EXISTS reseña;
DROP TABLE IF EXISTS bar;
DROP TABLE IF EXISTS users;


CREATE TABLE users (
  email VARCHAR(50), 
  username VARCHAR(50) PRIMARY KEY,
  password VARCHAR(100)
);


INSERT INTO users (email, username, password) VALUES ("hola@gmail.com", "pepe", "1234");
INSERT INTO users (email, username, password) VALUES ("adios@gmail.com", "luisa", "1234");
INSERT INTO users (email, username, password) VALUES ("javi@gmail.com", "Javier Abad", "javier");
INSERT INTO users (email, username, password) VALUES ("santi@gmail.com", "Santiago Alvarez", "santiago");
INSERT INTO users (email, username, password) VALUES ("miriam@gmail.com", "Miriam Arconada", "miriam");
INSERT INTO users (email, username, password) VALUES ("ruben@gmail.com", "Ruben Zarate", "ruben");
select * from users;

CREATE TABLE bar ( 
    dueño VARCHAR(50),
    nombre VARCHAR(50) PRIMARY KEY,
    descripcion VARCHAR(500),
    direccion VARCHAR(50),
    telefono VARCHAR(50),
    tipo VARCHAR(20),
    foto VARCHAR(1055),
    FOREIGN KEY (dueño) REFERENCES users(username)
);


INSERT INTO bar (dueño, nombre, descripcion, direccion, telefono, tipo, foto) VALUES ("pepe","El tio molonio", "Bar situado muy cerca al centro de Valladolid cuyo público en su mayor parte es universitario. Tenemos grandes ofertas en consumiciones y distintas actividades durante varios días de la semana. También una terraza buena exterior y con música en directo varios días y sobre todo un gran ambiente.
\¡Ven a visitarnos!","C. de los Alamillos, 9, 47005 Valladolid", "678543212", "Cerveceria", "/imagenes/molonio.jpg");
INSERT INTO bar (dueño, nombre, descripcion, direccion, telefono, tipo, foto) VALUES ("luisa","Kuik'AS","Un bar muy guay", "C. Gardoqui, 6, 47003 Valladolid", "697536217", "Bar nocturno", "/imagenes/kuikas.jpg");
INSERT INTO bar (dueño, nombre, descripcion, direccion, telefono, tipo, foto) VALUES ("Javier Abad","Be Funky","Un bar muy funky", "C. Gardoqui, 2, 47003 Valladolid", "621349861", "Bar nocturno", "/imagenes/befunky.jpg");

select * from bar;

CREATE TABLE reseña (
    usuario VARCHAR(50),
    bar VARCHAR(50),
    descripcion VARCHAR(200),
    calificacion DECIMAL,
    fecha TIMESTAMP,
    PRIMARY KEY (usuario, bar, fecha),
    FOREIGN KEY (usuario) REFERENCES users(username),
    FOREIGN KEY (bar) REFERENCES bar(nombre)
);

INSERT INTO reseña (usuario, bar, descripcion, calificacion, fecha) VALUES ("Miriam Arconada", "Be Funky", "No me ha gustado el trato que he recibido por parte del dueño, muy mala educacion, pero he de decir que habia ambientazo", 3, TIMESTAMP('2023-02-27'));
INSERT INTO reseña (usuario, bar, descripcion, calificacion, fecha) VALUES ("Ruben Zarate", "Be Funky", "Pues la verdad es que nunca he entrado, pero conozco al dueño y recomiendo el bar con creces", 2, TIMESTAMP('2022-12-22'));
INSERT INTO reseña (usuario, bar, descripcion, calificacion, fecha) VALUES ("Javier Abad", "Be Funky", "Es uno de los mejores locales de ocio nocturno más allá de las tipicas discotecas que se llenan y no puedes respirar", 5, TIMESTAMP('2022-10-22'));
INSERT INTO reseña (usuario, bar, descripcion, calificacion, fecha) VALUES ("Miriam Arconada", "Kuik'as", "No me ha gustado el ambiente, demasiada luz de láser, molesta la musica.", 1, TIMESTAMP('2023-02-27'));
INSERT INTO reseña (usuario, bar, descripcion, calificacion, fecha) VALUES ("Ruben Zarate", "Kuik'as", "Si no fuera porque pasar la noche ahi es relativamente barato, no iría.", 3, TIMESTAMP('2021-12-22'));
INSERT INTO reseña (usuario, bar, descripcion, calificacion, fecha) VALUES ("Javier Abad", "Kuik'as", "Ya tan solo por el Kuikazo merece la pena ir, aunque el DJ no es muy bueno. " , 4, TIMESTAMP('2022-02-27'));
INSERT INTO reseña (usuario, bar, descripcion, calificacion, fecha) VALUES ("Ruben Zarate", "El tio molonio", "Los dias que traen a grupos a cantar están muy bien!!", 2, TIMESTAMP('2023-01-22'));
INSERT INTO reseña (usuario, bar, descripcion, calificacion, fecha) VALUES ("Miriam Arconada", "El tio molonio", "Para los estudiantes de medicina es un lugar ideal, es perfecto", 5, TIMESTAMP('2023-01-02'));
INSERT INTO reseña (usuario, bar, descripcion, calificacion, fecha) VALUES ("Javier Abad", "El tio molonio", "Muy buen bar con un gran ambiente de terraza.", 5, TIMESTAMP('2023-03-22'));


select * from reseña;


CREATE TABLE favoritos (
    usuario VARCHAR(50),
    bar VARCHAR(50),
    PRIMARY KEY (usuario, bar),
    FOREIGN KEY (usuario) REFERENCES users(username),
    FOREIGN KEY (bar) REFERENCES bar(nombre)
);

INSERT INTO favoritos (usuario, bar) VALUES ("Santiago Alvarez", "El tio Molonio");
INSERT INTO favoritos (usuario, bar) VALUES ("Santiago Alvarez", "Kuik'AS");
INSERT INTO favoritos (usuario, bar) VALUES ("Javier Abad", "Be Funky");


CREATE TABLE fotosbar (
    numfoto INT not null AUTO_INCREMENT,
    bar VARCHAR(50),
    foto VARCHAR(1055),
    PRIMARY KEY (numfoto),
    FOREIGN KEY (bar) REFERENCES bar(nombre)
);

CREATE TABLE horario(
    bar VARCHAR(50),
    diaSemana VARCHAR(10),
    inicio TIME,
    fin TIME,
    PRIMARY KEY (bar, diaSemana, inicio, fin),
    FOREIGN KEY (bar) REFERENCES bar(nombre)
);

INSERT INTO horario (bar, diaSemana, inicio, fin) VALUES ("Be Funky", "Jueves", TIME('20:00'), TIME('4:00'));
INSERT INTO horario (bar, diaSemana, inicio, fin) VALUES ("Be Funky", "Viernes", TIME('20:00'), TIME('4:00'));
INSERT INTO horario (bar, diaSemana, inicio, fin) VALUES ("Be Funky", "Sabado", TIME('20:00'), TIME('4:00'));

INSERT INTO horario (bar, diaSemana, inicio, fin) VALUES ("El tio molonio", "Lunes", TIME('10:00'), TIME('00:00'));
INSERT INTO horario (bar, diaSemana, inicio, fin) VALUES ("El tio molonio", "Martes", TIME('10:00'), TIME('00:00'));
INSERT INTO horario (bar, diaSemana, inicio, fin) VALUES ("El tio molonio", "Miercoles", TIME('10:00'), TIME('00:00'));
INSERT INTO horario (bar, diaSemana, inicio, fin) VALUES ("El tio molonio", "Jueves", TIME('10:00'), TIME('2:00'));
INSERT INTO horario (bar, diaSemana, inicio, fin) VALUES ("El tio molonio", "Viernes", TIME('10:00'), TIME('2:00'));
INSERT INTO horario (bar, diaSemana, inicio, fin) VALUES ("El tio molonio", "Sabado", TIME('10:00'), TIME('14:00'));
INSERT INTO horario (bar, diaSemana, inicio, fin) VALUES ("El tio molonio", "Sabado", TIME('16:00'), TIME('4:00'));

INSERT INTO horario (bar, diaSemana, inicio, fin) VALUES ("Kuik'AS", "Jueves", TIME('20:00'), TIME('4:00'));
INSERT INTO horario (bar, diaSemana, inicio, fin) VALUES ("Kuik'AS", "Viernes", TIME('20:00'), TIME('4:00'));
INSERT INTO horario (bar, diaSemana, inicio, fin) VALUES ("Kuik'AS", "Sabado", TIME('20:00'), TIME('4:00'));
