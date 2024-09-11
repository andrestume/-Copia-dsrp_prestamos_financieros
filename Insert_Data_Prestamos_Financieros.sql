USE dsrp_prestamos_financieros;
GO


-- Insertar Personas Juridicas

SELECT*FROM personas_juridicas;

EXEC SP_HELP personas_juridicas;

INSERT INTO personas_juridicas(numero_documento,razon_social,domicilio_fiscal,telefono,email)
VALUES ('12345678910','JKC Tecnología e Información','Huaraz-Ancash','32165894','jkcit@gmail.com');

-- Agregar campo fecha_constitucion a la tabla personas_juridicas

ALTER TABLE personas_juridicas 
ADD fecha_constitucion DATE NULL; 

--Actualizar fecha constitución registro 1
UPDATE personas_juridicas SET fecha_constitucion = '2020-05-05'
WHERE id=1;

-- Copiar datos desde db_prestamos_financieros.dbo.personas_juridicas
INSERT INTO personas_juridicas (numero_documento,razon_social,domicilio_fiscal,telefono,email,fecha_constitucion)
SELECT 
	RUC AS 'numero_documento',
	razon_social,
	direccion_fiscal AS 'domicilio_fiscal',
	CONCAT('01',ROUND(RAND()*1000000,0)) AS 'telefono',
	TRIM(LOWER(CONCAT(SUBSTRING(razon_social,1,3),'@gmail.com'))) AS 'email',
	fecha_constitucion
FROM db_prestamos_financieros.dbo.personas_juridicas;

-- Insertar Personas Naturales
SELECT*FROM personas_naturales;

-- Consulta para generar el excel
SELECT 
	*, TRIM(LOWER(CONCAT(SUBSTRING(nombres,1,1),apellido_paterno,SUBSTRING(apellido_materno,1,1),'@gmail.com'))) AS 'email'
FROM db_prestamos_financieros.dbo.personas_naturales;

-- Insertar datos en la tabla clientes

SELECT*FROM clientes;

EXEC SP_HELP clientes;

INSERT INTO clientes (persona_id,tipo_cliente,fecha_registro)

SELECT id AS 'persona_id','Persona Jurídica' AS 'tipo_cliente', GETDATE() AS 'fecha_registro'
FROM personas_juridicas
UNION
SELECT id AS 'persona_id','Persona Natural' AS 'tipo_cliente', GETDATE() AS 'fecha_registro'
FROM personas_naturales;

--Sucursales

SELECT*FROM sucursales;

-- Insert Empleados

SELECT*FROM empleados;
SELECT TOP 2*FROM personas_naturales
ORDER BY id DESC;

INSERT INTO personas_naturales (numero_documento,nombres,apellido_paterno,apellido_materno,direccion,celular,email)
VALUES
('12304689','Juan','Perez','Rivera','Lima Cercado','965832147','jperezr@gmail.com'),
('12054689','Luis','Flores','Valverde','La victoria-Lima','965832047','lfloresf@gmail.com');

INSERT INTO empleados (persona_id,sucursal_id,supervisor_id,fecha_ingreso)
VALUES
(33,)




