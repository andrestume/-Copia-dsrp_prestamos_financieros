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