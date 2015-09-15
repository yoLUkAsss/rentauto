create table usuario
(id integer primary key not null AUTO_INCREMENT,
nombre varchar(25),
apellido varchar(25),
username varchar(25) unique, 
email varchar(30) unique, 
fechaNacimiento date, 
validez boolean, 
codigo varchar(40) unique, 
password varchar(40)
);

create table automovil
(auto_id integer primary key not null AUTO_INCREMENT,
auto_patente varchar(30) not null unique,
auto_marca varchar(20),
auto_modelo varchar(20),
auto_anio int,
auto_costoBase double
);
