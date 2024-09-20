USE dsrp_prestamos_financieros;
GO

--Funciones
-- Crear una función que devuelva el monto total de prestamo de un cliente.

CREATE FUNCTION FN_KV_DEVUELVE_TOTAL_PRESTAMO_CLIENTE(@id_cliente INT)
RETURNS MONEY

AS BEGIN 
	DECLARE @monto_total MONEY;
	SELECT @monto_total=SUM(monto) FROM prestamos WHERE cliente_id=@id_cliente;
	RETURN @monto_total
END

SELECT dbo.FN_KV_DEVUELVE_TOTAL_PRESTAMO_CLIENTE(25);

SELECT 
	*,dbo.FN_KV_DEVUELVE_TOTAL_PRESTAMO_CLIENTE(id) AS 'total_prestamo'
FROM clientes;


SELECT*FROM prestamos;
--Crear una función que calcule el monto de la cuota de un prestamo

CREATE FUNCTION FN_KV_VALOR_CUOTA(@id_prestamo INT)
RETURNS MONEY
AS BEGIN
	DECLARE @valor_cuota MONEY;
	SELECT @valor_cuota=(monto + monto*tasa_interes)/plazo_meses FROM prestamos WHERE id=@id_prestamo;
	RETURN @valor_cuota;
END

SELECT dbo.FN_KV_VALOR_CUOTA(1);

SELECT*,dbo.FN_KV_VALOR_CUOTA(id) FROM prestamos;

SELECT*FROM cuotas;

SELECT*FROM estados_cuota;

-- Crear un Procedimimiento almacenado que inserte las cuotas de un prestamo.

CREATE PROCEDURE SP_KV_INSERTAR_CUOTAS
	@id_prestamo INT
AS
	SET NOCOUNT ON;
	DECLARE @Counter INT;
	DECLARE @plazo_meses INT;
	SET @Counter = 1;
	SET @plazo_meses=(SELECT plazo_meses FROM prestamos WHERE id=@id_prestamo);

	WHILE @Counter <= @plazo_meses
	BEGIN
	INSERT INTO cuotas(prestamo_id,numero_cuota,monto_cuota,estado_cuota_id,fecha_vencimiento)
	SELECT 
	  @id_prestamo,
	  @Counter AS numero_cuota,
	  dbo.FN_KV_VALOR_CUOTA(@id_prestamo) AS 'monto_cuota', 
	  ROUND(RAND()*8,0)+1 AS estado_cuota_id, 
	  DATEADD(MONTH,@Counter,p.fecha_inicio) AS 'fecha_vencimiento'	 
	FROM Prestamos p
	ORDER BY NEWID()
	OFFSET 0 ROWS
	FETCH NEXT 1 ROWS ONLY;
		SET @Counter = @Counter + 1
END

GO

SELECT*FROM prestamos;

SELECT*FROM estados_prestamo;

EXEC SP_KV_INSERTAR_CUOTAS 1;

SELECT*FROM cuotas;
SELECT*FROM prestamos;

SELECT*FROM prestamos WHERE estado_prestamo_id=1;

--Procedimiento almacenado para registrar cuotas

ALTER PROCEDURE SP_KV_REGISTRA_PAGOS 
	@cuota_id INT
 AS
	SET NOCOUNT ON;
	DECLARE @estado_cuota_id INT;
	DECLARE @monto_cuota MONEY;
	DECLARE @monto_pagado MONEY;
	DECLARE @fecha_pago DATETIME;
	SET @estado_cuota_id= (SELECT estado_cuota_id FROM cuotas WHERE id=@cuota_id);
	SET @monto_cuota= (SELECT monto_cuota FROM cuotas WHERE id=@cuota_id);
	SET @fecha_pago= (SELECT DATEADD(DAY,-ROUND(RAND()*20,0),fecha_vencimiento)  FROM cuotas WHERE id=@cuota_id);

	IF @estado_cuota_id NOT IN(1,4,5,7,6,9,8) BEGIN
		IF @estado_cuota_id =3 BEGIN
			   SET @monto_pagado= @monto_cuota/(ROUND(RAND()*2,0)+2);
		END
		ELSE BEGIN
			SET @monto_pagado=@monto_cuota;
		END

		INSERT INTO pagos(metodo_pago_id,codigo_operacion,monto_pagado,fecha_pago,created_at,created_by)
		VALUES (ROUND(RAND()*5,0)+1,ROUND(RAND()*100000+1,0),@monto_pagado,@fecha_pago,@fecha_pago,ROUND(RAND()*1,0)+1);

		INSERT INTO detalles_cuotas_pagos(cuota_id,pago_id,saldo_restante)
		VALUES (@cuota_id,SCOPE_IDENTITY(),@monto_cuota-@monto_pagado)
	END

GO

SELECT*FROM cuotas

EXEC SP_KV_REGISTRA_PAGOS 2;
EXEC SP_KV_REGISTRA_PAGOS 3;

SELECT*FROM pagos;
SELECT*FROM detalles_cuotas_pagos;

DELETE FROM pagos;
DELETE FROM detalles_cuotas_pagos;

--CASE WHEN c.estado_cuota_id =3 THEN c.monto_cuota/(ROUND(RAND()*2,0)+2) ELSE c.monto_cuota END AS 'monto_pagado',

/*
IF search_condition BEGIN
	statement_list
END
ELSE BEGIN
	statement_list
END */

SELECT*FROM estados_cuota;

--- Inserción masiva

DECLARE @Counter INT
DECLARE @id_cuota INT

SET @Counter = 0

WHILE @Counter < 500
BEGIN
SELECT @id_cuota=c.id
FROM cuotas c
WHERE 
	c.id NOT IN(SELECT cuota_id FROM detalles_cuotas_pagos WHERE saldo_restante='0.00') 
	AND c.estado_cuota_id NOT IN(1,4,5,7,6,9,8)
	/*AND c.monto_cuota<ISNULL((SELECT SUM(p1.monto_pagado) 
						FROM pagos p1 
						INNER JOIN detalles_cuotas_pagos dc ON p1.id=dc.pago_id
						WHERE dc.cuota_id=c.id),1)*/
ORDER BY NEWID()
OFFSET 0 ROWS
FETCH NEXT 1 ROWS ONLY;
EXEC SP_KV_REGISTRA_PAGOS @id_cuota;
SET @Counter = @Counter + 1;
END;


--- Inconsitencia de pagos


SELECT DISTINCT c.id,c.numero_cuota, c.monto_cuota, p.monto_pagado
FROM cuotas c
INNER JOIN detalles_cuotas_pagos dc ON dc.cuota_id=c.id
INNER JOIN pagos p ON p.id=dc.pago_id;