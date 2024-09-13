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
