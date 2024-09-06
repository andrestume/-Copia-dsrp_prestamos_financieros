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

-- Pagos

CREATE TABLE pagos (
id INT PRIMARY KEY IDENTITY(1,1),
metodo_pago_id INT NOT NULL,
codigo_operacion VARCHAR(20) NOT NULL,
monto_pagado MONEY NOT NULL,
fecha_pago datetime DEFAULT GETDATE() NOT NULL,
created_at datetime2 NOT NULL,
updated_at datetime2 NULL,
deleted_at datetime2 NULL,
created_by int NOT NULL,
updated_by int NULL,
deleted_by int NULL,
FOREIGN KEY (metodo_pago_id) REFERENCES metodos_pago(id)
);
GO



-- Prestamos

CREATE TABLE prestamos (
	id INT PRIMARY KEY IDENTITY(1,1),
	cliente_id INT NOT NULL,
	sucursal_id INT NOT NULL,
	tipo_prestamo_id INT NOT NULL,
	oficial_credito_id INT NOT NULL,
	estado_prestamo VARCHAR(55) NOT NULL,
	monto MONEY NOT NULL,
	tasa_interes DECIMAL(9,4) NOT NULL,
	plazo_meses INT NOT NULL,
	fecha_inicio DATETIME DEFAULT GETDATE() NOT NULL
	FOREIGN KEY (cliente_id) REFERENCES clientes(id),
	FOREIGN KEY (sucursal_id) REFERENCES sucursales(id),
	FOREIGN KEY (tipo_prestamo_id) REFERENCES tipos_prestamo(id),
	FOREIGN KEY (oficial_credito_id) REFERENCES empleados(id)
	);

	GO

-- Cuotas
CREATE TABLE cuotas (
	id INT PRIMARY KEY IDENTITY(1,1),
	prestamo_id INT NOT NULL,
	numero_cuota INT NOT NULL,
	monto_cuota MONEY NOT NULL,
	estado VARCHAR(55)NOT NULL,
	fecha_vencimiento DATETIME DEFAULT GETDATE() NOT NULL
	FOREIGN KEY (prestamo_id) REFERENCES prestamos(id)
	);

-- detalles_cuotas_pagos
CREATE TABLE detalles_cuotas_pagos (
	id INT PRIMARY KEY IDENTITY(1,1),
	cuota_id INT NOT NULL,
	pago_id INT NOT NULL,
	saldo_restante MONEY NOT NULL,
	);

ALTER TABLE detalles_cuotas_pagos
ADD CONSTRAINT fk_detalle_cuotas_pagos_cuotas FOREIGN KEY (cuota_id) REFERENCES cuotas(id);

ALTER TABLE detalles_cuotas_pagos
ADD CONSTRAINT fk_detalle_cuotas_pagos_pagos FOREIGN KEY (pago_id) REFERENCES pagos(id);
