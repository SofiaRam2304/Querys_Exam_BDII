/*
	=====================================================
	EXAMEN I PARCIAL - II PERIODO 2021 - BASE DE DATOS II 
	FECHA: 05/06/2021

	Nombres:
			1. Alma Leticia Douglas Gonzales Guilbert
			2. Sofía Raquel Ramírez Rodriguez
	==========================================================
	==========================================================
	NOTA: SE SEGUIRÁN LAS INDICIACIONES DE LA PRIMERA OPCIÓN
	POR LO TANTO, PARA PODER REVISAR EL EXÁMEN, SE REQUIERE 
	PRIMERO CREAR LA BASE DE DATOS JUNTO CON SUS TABLAS Y 
	SUS RESPECTIVOS DATOS UNO POR UNO.

	POSTERIORMENTE, SE INDICARÁ EN ESTE MISMO QUERY EL INICIO
	DE LA PARTE DONDE SE HAN ESCRITO LOS EJERCICIOS QUE 
	ALTERARÁN LA BASE DE DATOS.
	==========================================================
	==========================================================
*/

---------------------------------------------------------------
/*
		===================================================
		INCISO # 1: CREACIÓN DE TABLAS Y VARIABLES DE DATOS
		===================================================

*/
CREATE DATABASE EXAMEN1_IPARCIAL

USE EXAMEN1_IPARCIAL

CREATE TABLE Empresa
(
	cod_empresa INT IDENTITY(1,1) PRIMARY KEY,
	nom_empresa VARCHAR(50),
	tel_empresa VARCHAR(40)
)

CREATE TABLE Servicios
(
	cod_servicio INT IDENTITY(1,1) PRIMARY KEY,
	servicio VARCHAR(50)
)

CREATE TABLE Clientes
(
	cod_cliente INT IDENTITY(1,1) PRIMARY KEY,
	num_identidad VARCHAR(13),
	nom_cliente VARCHAR(50),
	direccion VARCHAR(50),
	tel_cliente VARCHAR(20)
)


CREATE TABLE Poblacion
(
	cod_poblacion INT IDENTITY(1,1) PRIMARY KEY,
	nom_departamento VARCHAR(20),
	nom_municipio VARCHAR(20)
)

CREATE TABLE Empleados
(
	cod_empleado INT IDENTITY(1,1) PRIMARY KEY,
	num_identidad VARCHAR(13),
	nom_empleado VARCHAR(50),
	dir_empleado VARCHAR(40),
	tel_empleado VARCHAR(20),
	tipo_empleado VARCHAR(30),
	sueldo MONEY
)

CREATE TABLE Trabajos
(
	cod_trabajo INT IDENTITY(1,1) PRIMARY KEY,
	fecha_real DATE,
	horas_real INT
)

CREATE TABLE Empleados_Empresas
(
	cod_empresa INT FOREIGN KEY(cod_empresa)REFERENCES Empresa(cod_empresa),
	cod_empleado INT FOREIGN KEY(cod_empleado)REFERENCES Empleados(cod_empleado)
	PRIMARY KEY(cod_empresa, cod_empleado)
)

CREATE TABLE Empleados_Trabajos
(
	cod_trabajo INT FOREIGN KEY(cod_trabajo) REFERENCES Trabajos(cod_trabajo),
	cod_empleado INT FOREIGN KEY(cod_empleado) REFERENCES Empleados(cod_empleado),
	PRIMARY KEY(cod_empleado, cod_trabajo)
)

CREATE TABLE Costos
(
	cod_empresa INT FOREIGN KEY(cod_empresa) REFERENCES Empresa(cod_empresa),
	cod_poblacion INT FOREIGN KEY(cod_poblacion) REFERENCES Poblacion(cod_poblacion),
	cod_servicio INT FOREIGN KEY(cod_servicio) REFERENCES Servicios(cod_servicio),
	PRIMARY KEY(cod_empresa, cod_poblacion, cod_servicio),
	costo MONEY
)

CREATE TABLE Solicitudes
(
	cod_solicitud INT IDENTITY (1,1) PRIMARY KEY,
	cod_empresa INT FOREIGN KEY(cod_empresa) REFERENCES Empresa(cod_empresa),
	cod_servicio INT FOREIGN KEY(cod_servicio) REFERENCES Servicios(cod_servicio),
	cod_cliente INT FOREIGN KEY(cod_cliente) REFERENCES Clientes(cod_cliente),
	dir_salida VARCHAR(80),
	dir_destino VARCHAR(80),
	fecha_solicitud DATE,
	fecha_resolucion DATE
)

CREATE TABLE costos_Totales
(
	cod_empresa INT FOREIGN KEY(cod_empresa) REFERENCES Empresa(cod_empresa),
	cod_servicio INT FOREIGN KEY(cod_servicio) REFERENCES Servicios(cod_servicio),
	cod_poblacion INT FOREIGN KEY(cod_poblacion) REFERENCES Poblacion(cod_poblacion),
	cod_solicitud INT FOREIGN KEY(cod_solicitud) REFERENCES Solicitudes(cod_solicitud),
	PRIMARY KEY(cod_empresa,cod_servicio,cod_poblacion,cod_solicitud),
	total money
)
------------------------------------------------------------------------------------------

/*

===========================================================================================
		INCISO # 3: INSERCIÓN DE 4 DATOS A CADA UNA DE LAS TABLAS
===========================================================================================

*/

INSERT INTO Empresa VALUES
							('Mudanza Aplicaciones S.A.','+504 2246-8523'),
							('Imperio Mudanzas & Cia.','+504 2287-1233'),
							('Mudanzas: "El Amigo"','+504 2287-6374'),
							('Mudanzas: Alma & Sofia','+504 2287-1287')

INSERT INTO Servicios VALUES 
							('Transporte'),	
							('Embalaje'),
							('Desmontar/Montaje de Muebles'),
							('Servicios de Gruas')

INSERT INTO Clientes VALUES
							('0801200508626','Alma Leticia D. Gonzáles Guilbert','Col. Guilbert, Sendero Montecristo, Casa 2','+504 9886-7812'),
							('0801199907288','Sofia Raquel Ramírez Rodriguez','Res. Lomas del Navou, Bloque 4, Casa 30','+504 8776-7899'),
							('0801200507545','Melisa Beatriz Rodriguez Medina','Col. La Joya, Casa 45','+504 8586-8987'),
							('0801199002491','José Rafael Villela Gonzalez','Col. Alameda, Edificio 3, Apartamento 2117','+504 9972-8080')

INSERT INTO Poblacion VALUES 
							('Comayagua','Comayagua'),
							('Copan','Santa rosa de copan'),
							('Choluteca','Choluteca'),
							('Francisco Morazan','Distrito central')

INSERT INTO Empleados VALUES
							('0801197207285','Alfredo Camacho Contreras','Barrio La bolsa, Avenida 12, Casa 15','+504 9881-9785','Gerente Administrativo',12500),
							('1515199508745','Maria José Canales Vaquedano','Col. Hato de Enmedio, Sector 4, Casa 10','+504 9881-8796','Jefe de Mudanzas',12300),
							('0801199608656','Mario Perdomo Sanchez','Res. El Sauce, Bloque 4, Casa 12', '+504 9832-7878','Conductor',10000),
							('1010199402136','Rodolfo Sanchez Montenegro','Col. Montecito, Sector 2, Casa 2','+504 8795-7852','Grúa',9500)

INSERT INTO Trabajos VALUES 
							('2021/06/08',7),
							('2021/06/16',10),
							('2022/01/01',24),
							('2022/02/01',48)

INSERT INTO Empleados_Empresas VALUES
										(1,1),
										(2,4),
										(3,2),
										(4,3)

INSERT INTO Empleados_Trabajos VALUES 
									  (1,3),
									  (3,1),
									  (4,2),
									  (2,4)

INSERT INTO Solicitudes VALUES (2,3,4,'Col. Los Ramitos, Edificio 4','Res. Los llanos, Antes del Punto de Taxis','2021/01/17','2021/06/08'),
								(3,2,1,'Col. Los Platanos, Edificio 30','Res. Miraflores, Casa 20','2021/10/12','2022/01/01'),
								(4,1,2,'Res. Las Guacamayas Rojas, Local 40',' Mall Los Guacates, Local 12, Segundo Piso en el Foodcourt','2021/01/14','2021/06/16'),
								(1,4,3,'Col. Los Limones, Casa 3','Col. Las Guayabas dulces, Casa 8','2021/02/01','2021/08/10')

INSERT INTO costos_Totales VALUES 
									(2,3,1,4,15000),
									(3,2,4,1,9000),
									(4,1,3,2,13000),
									(1,4,2,3,11000)

INSERT INTO Costos VALUES (1,2,3,8000),
						  (4,3,1,10000),
						  (3,4,2,7000),
						  (2,1,4,11000)

-----------------------------------------------------------------------------------------
/*
===================================================
	INCISO # 4: MODIFICIACIÓN DE 3 REGISTROS
===================================================
*/

UPDATE Empleados 
SET nom_empleado = 'José Maria Ramos Sanchez'
WHERE cod_empleado = 1

UPDATE Empleados 
SET nom_empleado = 'Mario Roberto Perez Ochoa'
WHERE cod_empleado = 3

UPDATE Empleados
SET num_identidad = '0801198207245'
WHERE cod_empleado = 2

/*
===================================================
	INCISO # 5: ELIMINACIÓN DE 2 REGISTROS 
===================================================
*/

DELETE FROM Empleados_Trabajos
WHERE cod_empleado = 1

DELETE FROM Empleados_Trabajos
WHERE cod_empleado = 3

-----------------------------------------------------------------------------------------
/*
===========================================================================================
						NOTA: ESTA SECCIÓN DEL QUERY ES PARA LA CREACIÓN 
							DE LOS INCISOS DE EJERCICIOS 6, 7 Y 8
===========================================================================================
*/
/*	
	==============
	EJERCICIO # 6
	==============	

	Crear una vista que me permita visualizar los clientes que x empresa le ha brindado
	un servicio cualquiera. (adjuntar SELECT para poder visualizarlo de acuerdo a los
	registros ingresados)

*/

CREATE VIEW EJERCICIO_6 AS
SELECT a.cod_cliente, a.nom_cliente,d.nom_empresa,c.servicio FROM Clientes a
INNER JOIN Solicitudes AS b ON b.cod_cliente = a.cod_cliente
INNER JOIN Servicios AS c ON c.cod_servicio = b.cod_servicio
INNER JOIN Empresa AS d ON d.cod_empresa = b.cod_empresa

SELECT * FROM EJERCICIO_6 WHERE nom_empresa = 'Mudanzas: Alma & Sofia'

/*	
	==============
	EJERCICIO # 7
	==============	

	    Crear una vista que permita visualizar las empresas y los servicios que brindan para		 
		x departamento y municipio. (adjuntar SELECT para poder visualizarlo de acuerdo
        a los registros ingresados) 5 %
*/
CREATE VIEW EJERCICIO_7 AS
SELECT  c.nom_empresa, d.servicio, CONCAT(a.nom_departamento,' / ',a.nom_municipio) [Departamento / Municipio] FROM Poblacion as a
INNER JOIN costos_Totales as b on b.cod_poblacion = a.cod_poblacion
INNER JOIN Empresa as c on c.cod_empresa = b.cod_empresa
INNER JOIN Servicios as d on d.cod_servicio= b.cod_servicio

WHERE c.nom_empresa = 'Mudanzas: Alma & Sofia'

/*	
	==============
	EJERCICIO # 8
	==============	

	Crear una vista que me permita visualizar la identidad, nombre, especialidad y
	empresas para las que un empleado x presta sus servicios. (adjuntar SELECT para
	poder visualizarlo de acuerdo a los registros ingresados).
*/
CREATE VIEW EJERCICIO_8 AS
SELECT a.num_identidad,a.nom_empleado,a.tipo_empleado,c.nom_empresa FROM Empleados as a
INNER JOIN Empleados_Empresas as b on b.cod_empleado = a.cod_empleado
INNER JOIN Empresa as c on c.cod_empresa = b.cod_empresa
INNER JOIN costos_Totales as d on d.cod_empresa = c.cod_empresa

