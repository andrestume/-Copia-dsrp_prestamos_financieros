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