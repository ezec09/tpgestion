USE GD1C2017;
GO

/*CREATE SCHEMA SQLGROUP*/
GRANT CONTROL ON SCHEMA	:: SQLGROUP TO gd
GO

IF(OBJECT_ID('SQLGROUP.crear_tablas') IS NOT NULL)
	DROP PROCEDURE SQLGROUP.crear_tablas
GO
/*--Procedure que crea las tabla------*/
CREATE PROCEDURE SQLGROUP.crear_tablas 
AS
BEGIN

	IF OBJECT_ID('SQLGROUP.Chofer_Turno') IS NOT NULL
		DROP TABLE SQLGROUP.Chofer_Turno
	IF OBJECT_ID('SQLGROUP.Auto_Turno') IS NOT NULL
		DROP TABLE SQLGROUP.Auto_Turno
	IF OBJECT_ID('SQLGROUP.Usuarios_Rol') IS NOT NULL
		DROP TABLE SQLGROUP.Usuarios_Rol
	IF OBJECT_ID('SQLGROUP.Factura_Viaje') IS NOT NULL
		DROP TABLE SQLGROUP.Factura_Viaje
	IF OBJECT_ID('SQLGROUP.Viajes') IS NOT NULL
		DROP TABLE SQLGROUP.Viajes
	IF OBJECT_ID('SQLGROUP.Facturas') IS NOT NULL
		DROP TABLE SQLGROUP.Facturas
	IF OBJECT_ID('SQLGROUP.Usuarios') IS NOT NULL
		DROP TABLE SQLGROUP.Usuarios
	IF OBJECT_ID('SQLGROUP.Rol_Funcionalidad') IS NOT NULL
		DROP TABLE SQLGROUP.Rol_Funcionalidad
	IF OBJECT_ID('SQLGROUP.Roles') IS NOT NULL
		DROP TABLE SQLGROUP.Roles
	IF OBJECT_ID('SQLGROUP.Funcionalidades') IS NOT NULL
		DROP TABLE SQLGROUP.Funcionalidades
	IF OBJECT_ID('SQLGROUP.Rendiciones') IS NOT NULL
		DROP TABLE SQLGROUP.Rendiciones
	IF OBJECT_ID('SQLGROUP.Turno') IS NOT NULL
		DROP TABLE SQLGROUP.Turno
	IF OBJECT_ID('SQLGROUP.Automoviles') IS NOT NULL
		DROP TABLE SQLGROUP.Automoviles
	IF OBJECT_ID('SQLGROUP.Choferes') IS NOT NULL
		DROP TABLE SQLGROUP.Choferes
	IF OBJECT_ID('SQLGROUP.Administradores') IS NOT NULL
		DROP TABLE SQLGROUP.Administradores
	IF OBJECT_ID('SQLGROUP.Clientes') IS NOT NULL
		DROP TABLE SQLGROUP.Clientes

	
	 
	CREATE TABLE SQLGROUP.Administradores (
		Admin_Id INTEGER IDENTITY(1,1) PRIMARY KEY,
		Admin_Dni NUMERIC(18,0) UNIQUE,
		Admin_Nombre VARCHAR(255) NOT NULL,
		Admin_Apellido VARCHAR(255) NOT NULL,
		Admin_Telefono NUMERIC(18,0) NOT NULL,
		Admin_Direccion VARCHAR(255) NOT NULL,
		Admin_Mail VARCHAR(255) NOT NULL
	);

	CREATE TABLE SQLGROUP.Choferes (
		Chofer_Id INTEGER IDENTITY(1,1) PRIMARY KEY,
		Chofer_Nombre VARCHAR(255) NOT NULL,
		Chofer_Apellido VARCHAR(255) NOT NULL,
		Chofer_Direccion VARCHAR(255) NOT NULL,
		Chofer_Dni NUMERIC(18,0) UNIQUE NOT NULL,
		Chofer_Telefono NUMERIC(18,0) NOT NULL,
		Chofer_Mail VARCHAR(50),
		Chofer_Fecha_Nac DATETIME NOT NULL
	);

	CREATE TABLE SQLGROUP.Clientes (
		Cliente_Id INTEGER IDENTITY(1,1) PRIMARY KEY,
		Cliente_Dni NUMERIC(18,0) NOT NULL UNIQUE,
		Cliente_Nombre VARCHAR(255) NOT NULL,
		Cliente_Apellido VARCHAR(255) NOT NULL,
		Cliente_Telefono NUMERIC(18,0) NOT NULL,
		Cliente_Direccion VARCHAR(255) NOT NULL,
		Cliente_Mail VARCHAR(255),
		Cliente_Fecha_Nac DATETIME NOT NULL,
		Cliente_Estado VARCHAR(20) NOT NULL DEFAULT 'Habilitado'
	);


	CREATE TABLE SQLGROUP.Automoviles (
		Auto_Patente VARCHAR(10) PRIMARY KEY,
		Auto_Marca VARCHAR(255) NOT NULL,
		Auto_Modelo VARCHAR(255) NOT NULL,
		Auto_Licencia VARCHAR(26),
		Auto_Rodado VARCHAR(10),
		Auto_Estado VARCHAR(20) DEFAULT 'Habilitado',
		Auto_Chofer INTEGER
	);

	CREATE TABLE SQLGROUP.Viajes (
		Viaje_Id INTEGER PRIMARY KEY,
		Viaje_Cant_Kilometros NUMERIC(18,0) NOT NULL,
		Viaje_Fecha DATETIME NOT NULL,
		Viaje_Fecha_INIC DATETIME NOT NULL,
		Viaje_Fecha_Fin DATETIME NOT NULL,
		Viaje_Chofer_Id INTEGER NOT NULL,
		Viaje_Auto_Patente VARCHAR(10) NOT NULL,
		Viaje_Turno_Id INTEGER NOT NULL,
		Viaje_Cliente_Id INTEGER NOT NULL
	);

	CREATE TABLE SQLGROUP.Rendiciones (
		Rendicion_Nro NUMERIC(18,0) PRIMARY KEY,
		Rendicion_Fecha DATETIME NOT NULL,
		Rendicion_Importe NUMERIC(18,2) NOT NULL,
		Rendicion_Chofer_Id INTEGER NOT NULL,
		Rendicion_Turno_Id INTEGER NOT NULL
	);

	CREATE TABLE SQLGROUP.Turno (
		Turno_Id INTEGER IDENTITY(1,1) PRIMARY KEY,
		Turno_Hora_Inicio NUMERIC(18,0),
		Turno_Hora_Fin NUMERIC(18,0),
		Turno_Descripcion VARCHAR(255),
		Turno_Valor_Kilometro NUMERIC(18,2),
		Turno_Precio_Base NUMERIC(18,2),
		Turno_Estado VARCHAR(20) DEFAULT 'Habilitado'
	);

	CREATE TABLE SQLGROUP.Facturas (
		Factura_Nro NUMERIC(18,0) PRIMARY KEY,
		Factura_Fecha_Inicio DATETIME NOT NULL,
		Factura_Fecha_Fin DATETIME NOT NULL,
		Factura_Fecha DATETIME NOT NULL,
		Factura_Total NUMERIC(18,2) NOT NULL,
		Factua_Nro_Viajes NUMERIC(18,2) NOT NULL,
		Factura_Cliente_Id INTEGER NOT NULL
	);

	CREATE TABLE SQLGROUP.Roles (
		Rol_Nombre VARCHAR(30) PRIMARY KEY,
		Rol_Descripcion VARCHAR(255) NOT NULL DEFAULT 'Habilitado'
	);

	CREATE TABLE SQLGROUP.Funcionalidades (
		Func_Nombre VARCHAR(30) PRIMARY KEY,
		Func_Descripcion VARCHAR(255) DEFAULT 'No hay descripcion'
	);

	CREATE TABLE SQLGROUP.Usuarios (
		Usuario_Id VARCHAR(255) PRIMARY KEY,
		Usuario_Password VARCHAR(64) NOT NULL,
		Usuario_DNI NUMERIC(18,0) UNIQUE NOT NULL,
		Usuario_Intentos INTEGER NOT NULL DEFAULT 0,
		Usuario_Estado VARCHAR(20) NOT NULL DEFAULT 'Habilitado'
	);

	CREATE TABLE SQLGROUP.Rol_Funcionalidad(
		RF_Rol_Nombre VARCHAR(30),
		RF_Func_Nombre VARCHAR(30),
		CONSTRAINT pk_rolxfuncionalidad PRIMARY KEY(RF_Rol_Nombre,RF_Func_Nombre)
	);

	CREATE TABLE SQLGROUP.Usuarios_Rol (
		UR_Rol_Nombre VARCHAR(30),
		UR_Usuario_Id VARCHAR(255),
		CONSTRAINT pk_usuarioxrol PRIMARY KEY(UR_Rol_Nombre,UR_Usuario_Id)
	);

	CREATE TABLE SQLGROUP.Factura_Viaje (
		Fv_Viaje_Id INTEGER,
		Fv_Factura_Nro NUMERIC(18,0),
		CONSTRAINT pk_facturaxviaje PRIMARY KEY(Fv_Viaje_Id,Fv_Factura_Nro) 
	);

	CREATE TABLE SQLGROUP.Chofer_Turno (
		Ct_Chofer_Id INTEGER,
		Ct_Turno_Id INTEGER,
		CONSTRAINT pk_choferxturno PRIMARY KEY (Ct_Chofer_Id,Ct_Turno_Id)
	);

	CREATE TABLE SQLGROUP.Auto_Turno (
		AT_Auto_Patente VARCHAR(10),
		AT_Turno_Id INTEGER,
		CONSTRAINT pk_autoxturno PRIMARY KEY (AT_Auto_Patente,AT_Turno_ID)
	);

	/*----Aca crear foreign keys------*/
	ALTER TABLE SQLGROUP.Automoviles ADD
	CONSTRAINT fk_automovil_chofer FOREIGN KEY (Auto_Chofer) REFERENCES SQLGROUP.Choferes(Chofer_Id)
	ON DELETE NO ACTION ON UPDATE CASCADE;

	ALTER TABLE SQLGROUP.Viajes ADD
	CONSTRAINT fk_viajes_chofer FOREIGN KEY (Viaje_Chofer_Id) REFERENCES SQLGROUP.Choferes(Chofer_Id)
	ON DELETE NO ACTION ON UPDATE CASCADE,
	CONSTRAINT fk_viajes_automovil FOREIGN KEY (Viaje_Auto_Patente) REFERENCES SQLGROUP.Automoviles(Auto_Patente)
	ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_viajes_turno FOREIGN KEY (Viaje_Turno_Id) REFERENCES SQLGROUP.Turno(Turno_Id)
	ON DELETE NO ACTION ON UPDATE CASCADE,
	CONSTRAINT fk_viajes_cliente FOREIGN KEY (Viaje_Cliente_Id) REFERENCES SQLGROUP.Clientes(Cliente_Id)
	ON DELETE NO ACTION ON UPDATE CASCADE;

	ALTER TABLE SQLGROUP.Rendiciones ADD
	CONSTRAINT fk_rendiciones_chofer FOREIGN KEY (Rendicion_Chofer_Id) REFERENCES SQLGROUP.Choferes(Chofer_Id)
	ON DELETE NO ACTION ON UPDATE CASCADE,
	CONSTRAINT fk_rendiciones_turno FOREIGN KEY (Rendicion_Turno_Id) REFERENCES SQLGROUP.Turno(Turno_Id)
	ON DELETE NO ACTION ON UPDATE CASCADE;

	ALTER TABLE SQLGROUP.Facturas ADD
	CONSTRAINT fk_factura_cliente FOREIGN KEY (Factura_Cliente_Id) REFERENCES SQLGROUP.Clientes(Cliente_Id)
	ON DELETE NO ACTION ON UPDATE CASCADE;

	ALTER TABLE SQLGROUP.Rol_Funcionalidad ADD
	CONSTRAINT fk_rolfuncionalidad_rol FOREIGN KEY (RF_Rol_Nombre) REFERENCES SQLGROUP.Roles(Rol_Nombre)
	ON DELETE NO ACTION ON UPDATE CASCADE,
	CONSTRAINT fk_rolfuncionalidad_func FOREIGN KEY (RF_Func_Nombre) REFERENCES SQLGROUP.Funcionalidades(Func_Nombre)
	ON DELETE NO ACTION ON UPDATE CASCADE;

	ALTER TABLE SQLGROUP.Usuarios_Rol ADD
	CONSTRAINT fk_usuariorol_rol FOREIGN KEY (UR_Rol_Nombre) REFERENCES SQLGROUP.Roles(Rol_Nombre)
	ON DELETE NO ACTION ON UPDATE CASCADE,
	CONSTRAINT fk_usuariorol_usuario FOREIGN KEY (UR_Usuario_Id) REFERENCES SQLGROUP.Usuarios(Usuario_Id)
	ON DELETE NO ACTION ON UPDATE CASCADE;

	ALTER TABLE SQLGROUP.Factura_Viaje ADD
	CONSTRAINT fk_facturaviaje_viaje FOREIGN KEY (Fv_Viaje_Id) REFERENCES SQLGROUP.Viajes(Viaje_Id)
	ON DELETE NO ACTION ON UPDATE CASCADE,
	CONSTRAINT fk_facturaviaje_factura FOREIGN KEY (Fv_Factura_Nro) REFERENCES SQLGROUP.Facturas(Factura_Nro)
	ON DELETE NO ACTION ON UPDATE NO ACTION;

	ALTER TABLE SQLGROUP.Chofer_Turno ADD
	CONSTRAINT fk_choferturno_chofer FOREIGN KEY (Ct_Chofer_Id) REFERENCES SQLGROUP.Choferes(Chofer_Id)
	ON DELETE NO ACTION ON UPDATE CASCADE,
	CONSTRAINT fk_choferturno_turno FOREIGN KEY (Ct_Turno_Id) REFERENCES SQLGROUP.Turno(Turno_Id)
	ON DELETE NO ACTION ON UPDATE NO ACTION;

	ALTER TABLE SQLGROUP.Auto_Turno ADD
	CONSTRAINT fk_autoturno_auto FOREIGN KEY (AT_Auto_Patente) REFERENCES SQLGROUP.Automoviles(Auto_Patente)
	ON DELETE NO ACTION ON UPDATE CASCADE,
	CONSTRAINT fk_autoturno_turno FOREIGN KEY (At_Turno_Id) REFERENCES SQLGROUP.Turno(Turno_Id)
	ON DELETE NO ACTION ON UPDATE NO ACTION;


	/*--------------------------------*/
END
GO

IF(OBJECT_ID('SQLGROUP.migrar_choferes') IS NOT NULL)
	DROP PROCEDURE SQLGROUP.migrar_choferes
GO

CREATE PROCEDURE SQLGROUP.migrar_choferes
AS
BEGIN
	INSERT INTO SQLGROUP.Choferes (Chofer_Nombre,Chofer_Apellido,Chofer_Direccion,Chofer_Dni,Chofer_Telefono,Chofer_Mail,Chofer_Fecha_Nac)
	SELECT m.Chofer_Nombre,m.Chofer_Apellido,m.Chofer_Direccion,m.Chofer_Dni,m.Chofer_Telefono,m.Chofer_Mail,m.Chofer_Fecha_Nac
	FROM gd_esquema.Maestra as m
	GROUP BY m.Chofer_Nombre,m.Chofer_Apellido,m.Chofer_Direccion,m.Chofer_Dni,m.Chofer_Telefono,m.Chofer_Mail,m.Chofer_Fecha_Nac
END
GO

IF(OBJECT_ID('SQLGROUP.migrar_automoviles') IS NOT NULL)
	DROP PROCEDURE SQLGROUP.migrar_automoviles
GO

CREATE PROCEDURE SQLGROUP.migrar_automoviles
AS
BEGIN
	INSERT INTO SQLGROUP.Automoviles (Auto_Marca,Auto_Modelo,Auto_Patente,Auto_Licencia,Auto_Rodado,Auto_Chofer)
	SELECT m.Auto_Marca, m.Auto_Modelo, m.Auto_Patente, m.Auto_Licencia, m.Auto_Rodado, (SELECT c.Chofer_Id FROM SQLGROUP.Choferes as c WHERE c.Chofer_Dni = m.Chofer_Dni)
	FROM gd_esquema.Maestra as m
	GROUP BY m.Auto_Marca, m.Auto_Modelo, m.Auto_Patente, m.Auto_Licencia, m.Auto_Rodado,m.Chofer_Dni
END
GO

IF(OBJECT_ID('SQLGROUP.migrar_clientes') IS NOT NULL)
	DROP PROCEDURE SQLGROUP.migrar_clientes
GO

CREATE PROCEDURE SQLGROUP.migrar_clientes
AS
BEGIN
	INSERT INTO SQLGROUP.Clientes (Cliente_Nombre,Cliente_Apellido,Cliente_Dni,Cliente_Telefono,Cliente_Direccion,Cliente_Mail,Cliente_Fecha_Nac)
	SELECT m.Cliente_Nombre, m.Cliente_Apellido, m.Cliente_Dni, m.Cliente_Telefono,m.Cliente_Direccion, m.Cliente_Mail, m.Cliente_Fecha_Nac
	FROM gd_esquema.Maestra as m
	GROUP BY m.Cliente_Nombre, m.Cliente_Apellido, m.Cliente_Dni, m.Cliente_Telefono, m.Cliente_Mail, m.Cliente_Fecha_Nac,m.Cliente_Direccion
END
GO

IF(OBJECT_ID('SQLGROUP.crear_administradores') IS NOT NULL)
	DROP PROCEDURE SQLGROUP.crear_administradores
GO

CREATE PROCEDURE SQLGROUP.crear_administradores
AS
BEGIN
	INSERT INTO SQLGROUP.Administradores (Admin_Dni,Admin_Nombre,Admin_Apellido,Admin_Telefono,Admin_Direccion,Admin_Mail)
	VALUES(1569877,'admin','admin',1512345678,'admin','admin@admin.com')
END
GO

IF(OBJECT_ID('SQLGROUP.crear_roles') IS NOT NULL)
	DROP PROCEDURE SQLGROUP.crear_roles
GO

CREATE PROCEDURE SQLGROUP.crear_roles
AS
BEGIN
	INSERT INTO SQLGROUP.Roles
	VALUES ('Administrador','Rol administrativo del sistema');
	INSERT INTO SQLGROUP.Roles
	VALUES ('Cliente','Rol cliente del sistema');
	INSERT INTO SQLGROUP.Roles
	VALUES ('Chofer','Rol chofer del sistema');
END
GO

IF(OBJECT_ID('SQLGROUP.crear_usuarios') IS NOT NULL)
	DROP PROCEDURE SQLGROUP.crear_usuarios
GO

/*Usuario: Nombre Password: Nombre, Falta hacer el trigger que cifra las pass*/
CREATE PROCEDURE SQLGROUP.crear_usuarios
AS
BEGIN
	INSERT INTO SQLGROUP.Usuarios (Usuario_Id, Usuario_Password,Usuario_DNI) 
	SELECT Chofer_Nombre + '_' + Chofer_Apellido,Chofer_Nombre,Chofer_Dni 
	FROM SQLGROUP.Choferes

	INSERT INTO SQLGROUP.Usuarios (Usuario_Id, Usuario_Password,Usuario_DNI)
	SELECT Cliente_Nombre + '_' + Cliente_Apellido,Cliente_Nombre,Cliente_Dni
	FROM SQLGROUP.Clientes,SQLGROUP.Usuarios
	WHERE Cliente_Dni != Usuario_DNI
	GROUP BY Cliente_Nombre,Cliente_Nombre,Cliente_Dni,Cliente_Apellido

END
GO

IF(OBJECT_ID('SQLGROUP.migrar_turnos') IS NOT NULL)
	DROP PROCEDURE SQLGROUP.migrar_turnos
GO

CREATE PROCEDURE SQLGROUP.migrar_turnos
AS
BEGIN
	INSERT INTO SQLGROUP.Turno (Turno_Hora_Inicio,Turno_Hora_Fin,Turno_Descripcion,Turno_Valor_Kilometro, Turno_Precio_Base)
	SELECT m.Turno_Hora_Inicio, m.Turno_Hora_Fin, m.Turno_Descripcion, m.Turno_Valor_Kilometro, m.Turno_Precio_Base
	FROM gd_esquema.Maestra as m
	GROUP BY m.Turno_Hora_Inicio, m.Turno_Hora_Fin, m.Turno_Descripcion, m.Turno_Valor_Kilometro, m.Turno_Precio_Base
END
GO



/*-----Aca se ejecutan todos los procedures de migracion de arriba------*/
BEGIN
	EXEC SQLGROUP.crear_tablas;
	EXEC SQLGROUP.crear_roles;
	EXEC.SQLGROUP.migrar_turnos;
	EXEC SQLGROUP.crear_administradores;
	EXEC SQLGROUP.migrar_choferes;
	EXEC SQLGROUP.migrar_clientes;
	EXEC SQLGROUP.migrar_automoviles;
	EXEC SQLGROUP.crear_usuarios;
END
