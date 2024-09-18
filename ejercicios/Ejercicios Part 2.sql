/*Ejercicio 1: Listar Clientes con Préstamos Activos
Obtén una lista de todos los clientes que tienen préstamos activos(En Proceso de Pago).
Muestra el nombre completo del cliente, el número de documento y el monto total del préstamo.
*/

SELECT 
	CONCAT(nt.nombres,' ',nt.apellido_paterno,' ',nt.apellido_materno) AS 'Nombre Completo',
	nt.numero_documento,
	c.tipo_cliente,
	SUM(monto) AS 'Monto Total Prestamo'
FROM clientes c
INNER JOIN prestamos p ON p.cliente_id=c.id
INNER JOIN personas_naturales nt ON nt.id=c.persona_id AND c.tipo_cliente='Persona Natural'
WHERE p.estado_prestamo_id = 4
GROUP BY nt.nombres,nt.apellido_paterno,nt.apellido_materno,nt.numero_documento,c.tipo_cliente
UNION
SELECT 
	pj.razon_social AS 'Nombre Completo',
	pj.numero_documento,
	c.tipo_cliente,
	SUM(monto) AS 'Monto Total Prestamo'
FROM clientes c
INNER JOIN prestamos p ON p.cliente_id=c.id
INNER JOIN personas_juridicas pj ON pj.id=c.persona_id AND c.tipo_cliente='Persona Jurídica'
WHERE p.estado_prestamo_id=4
GROUP BY pj.razon_social,pj.numero_documento,c.tipo_cliente;


/*
Ejercicio 2: Cuotas Pendientes por Cliente
Genera un informe que muestre el número de cuotas pendientes por cliente. Incluye el nombre completo del cliente, el número de documento y el número de cuotas pendientes.

Ejercicio 3: Total Pagado por Cliente
Calcula el total pagado por cada cliente hasta la fecha. Muestra el nombre completo del cliente y el monto total pagado.

Ejercicio 4: Préstamos con Pagos Parciales
Encuentra los préstamos que tienen al menos una cuota con un pago parcial. Muestra el ID del préstamo, el nombre completo del cliente, la fecha de inicio del préstamo y el monto restante.
*//*
Ejercicio 5: Empleados con más Préstamos Asignados
Determina cuáles son los empleados que han gestionado más préstamos como oficiales de crédito.
Muestra el nombre del empleado y el número total de préstamos asignados.
*/
SELECT
TOP 3
	CONCAT(nt.nombres,' ',nt.apellido_paterno,' ',nt.apellido_materno) AS 'Nombre Completo',
	COUNT(p.id) AS 'num_prestamos_asignados'
FROM empleados e
	INNER JOIN personas_naturales nt ON nt.id=e.persona_id
	INNER JOIN prestamos p ON p.oficial_credito_id=e.id
GROUP BY 
	nt.nombres,
	nt.apellido_paterno,
	nt.apellido_materno
--HAVING COUNT(p.id)>10
ORDER BY 2 DESC;

-- devolver los 3 empleados con mayor cantidad de prestamos asignados

SELECT oficial_credito_id, COUNT(id) AS 'prestamos_asignados'
INTO #prestamos_asignados
FROM prestamos
GROUP BY oficial_credito_id;

SELECT 
	DISTINCT CONCAT(nt.nombres,' ',nt.apellido_paterno,' ',nt.apellido_materno) AS 'Nombre Completo',
	pa.prestamos_asignados
FROM empleados e
	INNER JOIN personas_naturales nt ON nt.id=e.persona_id
	INNER JOIN prestamos p ON p.oficial_credito_id=e.id
	INNER JOIN #prestamos_asignados pa ON pa.oficial_credito_id=e.id
WHERE pa.prestamos_asignados IN (SELECT 
					DISTINCT TOP 3 prestamos_asignados
					FROM #prestamos_asignados
					ORDER BY prestamos_asignados DESC )
ORDER BY 2 DESC;


SELECT
TOP 3
	CONCAT(nt.nombres,' ',nt.apellido_paterno,' ',nt.apellido_materno) AS 'Nombre Completo',
	COUNT(p.id) AS 'num_prestamos_asignados'
FROM empleados e
	INNER JOIN personas_naturales nt ON nt.id=e.persona_id
	INNER JOIN prestamos p ON p.oficial_credito_id=e.id
GROUP BY 
	nt.nombres,
	nt.apellido_paterno,
	nt.apellido_materno
--HAVING COUNT(p.id)>10
ORDER BY 2 DESC;




/*
Ejercicio 6: Préstamos por Sucursal ><
Muestra el total de préstamos activos en cada sucursal. Incluye el nombre de la sucursal y la suma de los montos de los préstamos.

Ejercicio 7: Cuotas Vencidas por Préstamo
Obtén una lista de todos los préstamos que tienen cuotas vencidas. Muestra el ID del préstamo, el nombre del cliente, la fecha de inicio del préstamo, el número de cuotas vencidas y el monto total vencido.

Ejercicio 8: Métodos de Pago Utilizados
Genera un informe que muestre cuántas veces se ha utilizado cada método de pago para realizar pagos. Muestra el nombre del método de pago y la cantidad de veces que se ha utilizado.

Ejercicio 9: Renegociaciones de Préstamos
Obtén un informe de todos los préstamos que han sido renegociados, incluyendo el ID del préstamo, el nombre del cliente y la nueva tasa de interés o plazo.

Ejercicio 10: Préstamos por Tipo
Muestra el número total de préstamos por cada tipo de préstamo. Incluye el nombre del tipo de préstamo y el número total de préstamos.
*/