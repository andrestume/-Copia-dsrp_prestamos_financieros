/*Ejercicio 1: Listar Todos los Clientes
Obt�n una lista de todos los clientes registrados, mostrando su n�mero de documento, nombre completo y tipo de cliente.

Ejercicio 2: Listar Todas las Sucursales
Muestra todas las sucursales con su nombre, tel�fono y direcci�n.

Ejercicio 3: M�todos de Pago Activos
Obt�n una lista de todos los m�todos de pago que est�n activos.

Ejercicio 4: Pr�stamos por Cliente
Muestra el ID del pr�stamo, el nombre completo del cliente y el monto de cada pr�stamo.*/
SELECT*FROM clientes;


SELECT 
	p.id AS 'prestamo_id',
	CONCAT(cl.tipo_cliente,'-',nt.apellido_paterno,' ',nt.apellido_materno,' ', nt.nombres) AS 'Cliente',
	--ISNULL(nt.apellido_paterno,'') +' '+nt.apellido_materno+' '+ nt.nombres,
	p.monto
INTO #clientes
FROM clientes cl
	INNER JOIN prestamos p ON p.cliente_id=cl.id
	INNER JOIN personas_naturales nt ON nt.id=cl.persona_id AND cl.tipo_cliente='Persona Natural'
UNION
SELECT 
	p.id AS 'prestamo_id',
	CONCAT(cl.tipo_cliente,'-',pj.razon_social) AS 'Cliente',
	--ISNULL(nt.apellido_paterno,'') +' '+nt.apellido_materno+' '+ nt.nombres,
	p.monto
FROM clientes cl
	INNER JOIN prestamos p ON p.cliente_id=cl.id
	INNER JOIN personas_juridicas pj ON pj.id=cl.persona_id AND cl.tipo_cliente='Persona Jur�dica'
ORDER BY 2 ASC;

-- Crear una tabla temporal y calcular el prestamo total(sumar todos sus prestamos registrados) de cada cliente
SELECT
	Cliente,
	SUM(monto) AS 'prestamo_acumulado'
FROM  #clientes
GROUP BY Cliente
ORDER BY 2 DESC;


/*

Ejercicio 5: Empleados y Sucursales
Genera una lista de todos los empleados mostrando el nombre completo del empleado y el nombre de la sucursal donde trabaja.

Ejercicio 6: Cuotas por Pr�stamo
Obt�n una lista que muestre el ID del pr�stamo y el n�mero de cuotas asociadas a ese pr�stamo.

Ejercicio 7: Tipos de Pr�stamo
Muestra una lista de todos los tipos de pr�stamos disponibles, mostrando su nombre y descripci�n.

Ejercicio 8: Pagos Realizados
Muestra una lista de todos los pagos realizados, mostrando el ID del pago, el monto pagado y la fecha de pago.

Ejercicio 9: Listar Personas Naturales
Obt�n una lista de todas las personas naturales registradas, mostrando su n�mero de documento, nombres, apellido paterno y materno.

Ejercicio 10: Listar Personas Jur�dicas
Muestra una lista de todas las personas jur�dicas registradas, con su n�mero de documento, raz�n social y domicilio fiscal.

*/