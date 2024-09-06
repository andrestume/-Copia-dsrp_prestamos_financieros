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

