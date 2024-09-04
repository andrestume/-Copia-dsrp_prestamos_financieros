CREATE DATABASE dsrp_prestamos_financieros;
GO

USE dsrp_prestamos_financieros;
GO

-- Crear personas naturales
CREATE TABLE personas_naturales (
id INT PRIMARY KEY IDENTITY(1,1),
numero_documento VARCHAR(15) UNIQUE NOT NULL,
nombres VARCHAR(255) NOT NULL,
apellido_paterno VARCHAR(255) NOT NULL,
apellido_materno VARCHAR(255) NOT NULL,
direccion NVARCHAR(1000) NOT NULL,
celular VARCHAR(15) NOT NULL,
email VARCHAR(255) NOT NULL
);
GO
-- Personas Juridicas
CREATE TABLE personas_juridicas (
id INT PRIMARY KEY IDENTITY(1,1),
numero_documento VARCHAR(20) UNIQUE NOT NULL,
razon_social VARCHAR(255) NOT NULL,
domicilio_fiscal NVARCHAR(1000) NOT NULL,
telefono VARCHAR(15) NOT NULL,
email VARCHAR(255) NOT NULL
);
GO

-- Clientes
CREATE TABLE clientes (
id INT PRIMARY KEY IDENTITY(1,1),
persona_id INT NOT NULL,
tipo_cliente VARCHAR(100) NOT NULL,
fecha_registro DATETIME DEFAULT GETDATE() NOT NULL
);
GO

-- Tipos prestamo

CREATE TABLE tipos_prestamo (
id INT PRIMARY KEY IDENTITY(1,1),
nombre VARCHAR(155) UNIQUE NOT NULL,
estado BIT NOT NULL,
descripcion VARCHAR(500)
);
GO
-- Funcion para visualizar el detalle de las tablas
EXEC SP_HELP clientes;

--Sucursales
CREATE TABLE sucursales(
id INT PRIMARY KEY IDENTITY(1,1),
nombre VARCHAR(255) UNIQUE NOT NULL,
telefono VARCHAR(20) NOT NULL,
direccion NVARCHAR(500) NOT NULL,
gerente_id INT );

GO

--Metodos de pago
CREATE TABLE metodos_pago(
id INT PRIMARY KEY IDENTITY(1,1),
nombre VARCHAR(255) UNIQUE NOT NULL,
estado BIT NOT NULL,
descripcion VARCHAR(500) NOT NULL);

GO

-- Empleados
CREATE TABLE empleados(
id INT PRIMARY KEY IDENTITY(1,1),
persona_id INT NOT NULL,
sucursal_id INT NOT NULL,
supervisor_id INT NULL,
fecha_ingreso DATE NOT NULL,
CONSTRAINT fk_persona_natural_empleado FOREIGN KEY (persona_id) REFERENCES personas_naturales(id),
FOREIGN KEY (sucursal_id) REFERENCES sucursales(id),
FOREIGN KEY (supervisor_id) REFERENCES empleados(id)
);
Go

EXEC SP_HELP empleados;