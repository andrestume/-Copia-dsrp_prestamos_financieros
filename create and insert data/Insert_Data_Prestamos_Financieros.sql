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

EXEC sp_help empleados;

-- Insert Empleados

SELECT*FROM empleados;
SELECT TOP 2*FROM personas_naturales
ORDER BY id DESC;

INSERT INTO personas_naturales (numero_documento,nombres,apellido_paterno,apellido_materno,direccion,celular,email)
VALUES
('12304689','Juan','Perez','Rivera','Lima Cercado','965832147','jperezr@gmail.com'),
('12054689','Luis','Flores','Valverde','La victoria-Lima','965832047','lfloresf@gmail.com');

INSERT INTO empleados (persona_id,sucursal_id,supervisor_id,fecha_ingreso)
VALUES (33,2,NULL,'2024-05-05');

INSERT INTO empleados (persona_id,sucursal_id,supervisor_id,fecha_ingreso)
VALUES (34,2,SCOPE_IDENTITY(),'2024-05-05');


INSERT INTO personas_naturales 
SELECT
num_documento,
nombres,
apellido_paterno,
apellido_materno,
direccion,
CONCAT('+51',ROUND(RAND()*1000000,0)) AS 'celular',
TRIM(LOWER(CONCAT(SUBSTRING(nombres,1,1),apellido_paterno,SUBSTRING(apellido_materno,1,1),'@gmail.com'))) AS 'email'
FROM db_dsrp_gestion_inventario.dbo.empleados;

SELECT*FROM personas_naturales;
SELECT*FROM empleados;

SELECT*FROM db_dsrp_gestion_inventario.dbo.empleados;

--

INSERT INTO empleados
SELECT
pn.id AS 'persona_id',
12 AS 'sucursal_id',
e.supervisor_id+152,
e.fecha_ingreso
FROM personas_naturales pn
INNER JOIN db_dsrp_gestion_inventario.dbo.empleados e ON e.num_documento=pn.numero_documento
WHERE supervisor_id IS NOT NULL;


SELECT*FROM  empleados;
--- Metodos de pago y tipos de prestamo

INSERT INTO metodos_pago (nombre, estado, descripcion)
VALUES 
    ('Tarjeta de Crédito', 1, 'Pago realizado con tarjeta de crédito'),
    ('Transferencia Bancaria', 1, 'Pago realizado mediante transferencia bancaria'),
    ('Efectivo', 1, 'Pago realizado en efectivo en la sucursal'),
    ('Cheque', 1, 'Pago realizado mediante cheque bancario'),
    ('Débito Automático', 1, 'Pago automático desde cuenta bancaria'),
    ('PayPal', 1, 'Pago realizado a través de PayPal');

INSERT INTO tipos_prestamo (nombre, estado, descripcion)
VALUES 
    ('Préstamo Hipotecario', 1, 'Préstamo para la compra de bienes inmuebles'),
    ('Préstamo Automotriz', 1, 'Préstamo para la compra de vehículos'),
    ('Préstamo Personal', 1, 'Préstamo para gastos personales no especificados'),
    ('Préstamo Educativo', 1, 'Préstamo para cubrir gastos educativos'),
    ('Línea de Crédito', 1, 'Línea de crédito con límite de fondos disponible'),
    ('Préstamo Comercial', 1, 'Préstamo para empresas o negocios');


-- Insertar data en prestamos
SELECT*FROM prestamos;


DECLARE @Counter INT
SET @Counter = 0

WHILE @Counter < 500
BEGIN
INSERT INTO prestamos (cliente_id,sucursal_id,tipo_prestamo_id,oficial_credito_id,estado_prestamo_id,monto,tasa_interes,plazo_meses,fecha_inicio)
SELECT 
  c.id AS 'cliente_id',
  s.id AS 'sucursal_id',
  tp.id AS 'tipo_prestamo_id',
  ROUND(RAND()*140,0)+167 AS 'oficial_credito_id',
  ep.id AS 'estado_prestamos_id',
  ROUND(RAND() * 100000, 2) AS monto, -- Monto aleatorio
  ROUND(RAND(),2) AS tasa_interes,-- Tasa de interes en decimales ,
  ROUND(RAND()*24,0)+12 AS 'plazo_meses', -- Plazo meses,
  DATEADD(DAY, -ROUND(RAND() * 780,0), GETDATE()) AS 'fecha_inicia' -- Fecha de desembolso en los últimos 2 años
FROM clientes c
	CROSS JOIN sucursales s
	CROSS JOIN tipos_prestamo tp
	CROSS JOIN estados_prestamo ep
ORDER BY NEWID()
OFFSET 0 ROWS
FETCH NEXT 1 ROWS ONLY;
    SET @Counter = @Counter + 1
END

-- Inserción en la tabla cuotas

SELECT*FROM cuotas;

DECLARE @Counter INT
SET @Counter = 0

WHILE @Counter < 1000
BEGIN
INSERT INTO cuotas(prestamo_id,numero_cuota,monto_cuota,estado,fecha_vencimiento,)
SELECT 
  p.id AS 'prestamo_id',
  p.plazo_meses-(ROUND(RAND()*24,0)+12) AS numero_cuota,
  p.monto_prestamo/p.plazo_meses AS monto, -- Monto aleatorio
  DATEADD(MONTH,p.plazo_meses,p.fecha_desembolso) AS 'fecha_vencimiento',
  'En mora'
FROM Prestamos p
CROSS JOIN modalidades_prestamo mp
ORDER BY NEWID()
OFFSET 0 ROWS
FETCH NEXT 1 ROWS ONLY;
    SET @Counter = @Counter + 1
END

CREATE schema prestamos;
DROP schema prestamos;

CREATE TABLE prestamos.test(id INT);