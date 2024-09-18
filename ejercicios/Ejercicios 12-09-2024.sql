USE dsrp_prestamos_financieros;
GO

--Igualdad Simple
--Mostrare el numero de documento, nombres y apellidos de las personas naturales
--que se llamen'Juan'
SELECT 
	numero_documento,
	nombres, 
	CONCAT(apellido_paterno,' ',apellido_materno) AS 'apellidos'
FROM personas_naturales
WHERE nombres='Juan';

-- Encontrar filas que tengan un valor como parte de una cadena
--Mostrar el numero de documento, nombres,apellidos y direccion de las personas naturales
--que se llamen que en su nombre contengan la letra "j"
-- En cualquier lugar de la cadena
SELECT 
	numero_documento,
	nombres, 
	CONCAT(apellido_paterno,' ',apellido_materno) AS 'apellidos',
	direccion
FROM personas_naturales
WHERE nombres LIKE '%j%';

-- Al inicio o que empieza con

SELECT 
	numero_documento,
	nombres, 
	CONCAT(apellido_paterno,' ',apellido_materno) AS 'apellidos',
	direccion
FROM personas_naturales
WHERE nombres LIKE 'j%';

-- Al final o que termina con

SELECT 
	numero_documento,
	nombres, 
	CONCAT(apellido_paterno,' ',apellido_materno) AS 'apellidos',
	direccion
FROM personas_naturales
WHERE nombres LIKE '%a';

-- Encontrar valores mediante un operador de comparación
-- "=" IGUAL "<" MENOR QUE ">" MAYOR QUE "<=" MENOR IGUAL QUE 
--">=" MAYOR IGUAL QUE "!=" DIFERENTE DE

SELECT*FROM prestamos
WHERE plazo_meses>14;

SELECT*FROM prestamos
WHERE plazo_meses>=14;

SELECT*FROM prestamos
WHERE plazo_meses<14;

SELECT*FROM prestamos
WHERE plazo_meses<=14;

-- ENCONTRAR FILAS QUE CUMPLAN CON UNA O MAS CONDICIONES

SELECT*FROM personas_juridicas;

-- Seleccionar las personas Juridicas que se hayan consituido luego del año 2005
-- ó tengan la letra "h" en su razon social ó su domicilio fiscal sea una avenida.

SELECT*FROM personas_juridicas
WHERE 
	YEAR(fecha_constitucion)>'2005' OR
	razon_social LIKE '%h%' OR
	domicilio_fiscal LIKE 'Av.%';

UPDATE personas_juridicas SET domicilio_fiscal='AV. Industrial 123'
WHERE id=2;

-- Seleccionar las personas Juridicas que se hayan consituido luego del año 2005
-- , tengan la letra "h" en su razon social y su domicilio fiscal sea una avenida.

SELECT*FROM personas_juridicas
WHERE 
	YEAR(fecha_constitucion)>'2005' AND
	razon_social LIKE '%h%' AND
	domicilio_fiscal like 'Av.%';

-- Seleccionar las personas Juridicas que se hayan consituido luego del año 2005
-- y tengan la letra "h" en su razon social ó su domicilio fiscal sea una avenida.

SELECT*FROM personas_juridicas
WHERE 
	YEAR(fecha_constitucion)>'2005' AND
	(razon_social LIKE '%h%' OR
	domicilio_fiscal like 'Av.%');

-- ENCONTRAR FILAS QUE ESTEN EN UNA LISTA DE VALORES
SELECT*FROM tipos_prestamo;
-- DEVOLVER LOS DATOS DE LOS SIGUIENTES TIPOS DE PRESTAMO 
--'Préstamo Personal','Préstamo Educativo','Línea de Crédito'
SELECT 
	id,
	tipo_prestamo_id,
	monto, 
	tasa_interes,
	plazo_meses 
FROM prestamos
WHERE tipo_prestamo_id IN (3,4,5);

SELECT 
	p.id AS 'prestamo_id',
	p.tipo_prestamo_id,
	tp.nombre AS 'tipo_prestamo',
	p.monto, 
	p.tasa_interes,
	p.plazo_meses 
FROM prestamos p, tipos_prestamo tp
WHERE 
	p.tipo_prestamo_id=tp.id AND 
	tp.nombre IN ('Préstamo Personal','Préstamo Educativo','Línea de Crédito');

-- DEVOLVER LOS DATOS QUE NO PERTENEZCAN A LOS SIGUIENTES TIPOS DE PRESTAMO 
--'Préstamo Personal','Préstamo Educativo','Línea de Crédito'

SELECT 
	p.id AS 'prestamo_id',
	p.tipo_prestamo_id,
	tp.nombre AS 'tipo_prestamo',
	p.monto, 
	p.tasa_interes,
	p.plazo_meses 
FROM prestamos p, tipos_prestamo tp
WHERE 
	p.tipo_prestamo_id=tp.id AND 
	tp.nombre NOT IN ('Préstamo Personal','Préstamo Educativo','Línea de Crédito');

-- INTERVALO DE VALORES

SELECT*FROM prestamos;

-- Devolver los registros de prestamos cuyo plazo en meses este entre 20 y 25 meses.

SELECT*FROM prestamos
WHERE plazo_meses BETWEEN 20 AND 25;

SELECT*FROM prestamos
WHERE plazo_meses>=20 AND plazo_meses<=25;

-- SUBCONSULTA
-- DEVOLVER LOS DATOS de los prestamos cuyo estado se encuentre en estado "Vencido" o "En Mora"
SELECT*FROM estados_prestamo;

SELECT 
	p.id AS 'prestamo_id',
	p.tipo_prestamo_id,
	p.estado_prestamo_id,
	p.monto, 
	p.tasa_interes,
	p.plazo_meses 
FROM prestamos p
WHERE 
 	p.estado_prestamo_id IN (SELECT id FROM estados_prestamo WHERE nombre IN('Vencido','En Mora'));

--- DEVOLVER ESTADISTICAS DE LOS PRESTAMOS EN ESTADO "VENCIDO" y en ESTADO "En Mora"

SELECT 
	estado_prestamo_id,
	SUM(monto) AS 'monto_total',
	AVG(monto) AS 'promedio',
	MAX (monto) AS 'Maximo_monto_prestado',
	MIN(monto) AS 'Minimo_monto_prestado'
FROM prestamos
WHERE 
 estado_prestamo_id IN (SELECT id FROM estados_prestamo WHERE nombre IN('Vencido','En Mora'))
 GROUP BY estado_prestamo_id;


 -- LISTAR las estadisticas de los estados de prestamos cuyo monto toal supere los 5 millones de soles
 SELECT 
	estado_prestamo_id,
	SUM(monto) AS 'monto_total',
	ROUND(AVG(monto),2) AS 'promedio',
	MAX (monto) AS 'Maximo_monto_prestado',
	MIN(monto) AS 'Minimo_monto_prestado'
FROM prestamos
GROUP BY estado_prestamo_id
HAVING SUM(monto)>'5000000'
ORDER BY 2 DESC;
 -- LISTAR las estadisticas de los estados de prestamos cuyo monto toal supere los 5 millones de soles
 SELECT 
	SUM(monto) AS 'monto_total',
	ROUND(AVG(monto),2) AS 'promedio',
	MAX (monto) AS 'Maximo_monto_prestado',
	MIN(monto) AS 'Minimo_monto_prestado'
FROM prestamos
HAVING SUM(monto)>'5000000';


-- CREACIÓN DE VISTAS
CREATE VIEW VW_KV_INFO_PRESTAMOS AS
SELECT 
	p.id AS 'prestamo_id',
	p.tipo_prestamo_id,
	tp.nombre AS 'tipo_prestamo',
	p.monto, 
	p.tasa_interes,
	p.plazo_meses 
FROM prestamos p, tipos_prestamo tp
WHERE 
	p.tipo_prestamo_id=tp.id AND 
	tp.nombre NOT IN ('Préstamo Personal','Préstamo Educativo','Línea de Crédito');

	SELECT*FROM VW_KV_INFO_PRESTAMOS;

	DROP VIEW VW_KV_INFO_PRESTAMOS;