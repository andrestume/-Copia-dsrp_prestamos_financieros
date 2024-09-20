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

