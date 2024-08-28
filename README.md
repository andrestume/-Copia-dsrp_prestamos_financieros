# dsrp_prestamos_financieros
Pequeña base de datos para gestionar prestamos financieros.

# Caso Práctico: Modelamiento de Datos Relacionales para Préstamos Financieros
## Contexto
Una institución financiera desea gestionar y controlar los préstamos que ofrece a sus clientes. La institución maneja diferentes tipos de préstamos (hipotecarios, automotrices, personales, etc.) y necesita un sistema para registrar y seguir el estado de cada préstamo, así como los pagos realizados por los clientes.

#Requerimientos del Sistema
## Clientes:

La institución tiene clientes que pueden ser personas naturales o jurídicas.
Se necesita registrar información como nombre, dirección, teléfono, correo electrónico, tipo de cliente (natural o jurídico), y número de identificación.
## Préstamos:

Cada préstamo está asociado a un cliente y tiene un tipo específico (hipotecario, automotriz, personal, etc.).
Se deben registrar datos como el monto del préstamo, la tasa de interés, el plazo del préstamo (en meses), la fecha de inicio, y el estado actual del préstamo (activo, pagado, en mora, etc.).
## Pagos:

Los clientes realizan pagos periódicos para amortizar sus préstamos.
Cada pago debe registrar la fecha, el monto pagado, el saldo restante del préstamo después del pago, y si el pago está retrasado o al día.
## Sucursales:

Los préstamos pueden ser gestionados a través de diferentes sucursales de la institución.
Se necesita registrar la ubicación de las sucursales y el gerente responsable de cada una.
## Oficiales de Crédito:

Cada préstamo es asignado a un oficial de crédito que es responsable de gestionar el préstamo.
Se debe registrar información sobre el oficial de crédito como nombre, contacto, y la sucursal a la que pertenece.
### Requerimientos Adicionales
Los clientes pueden tener múltiples préstamos activos al mismo tiempo.
Un préstamo puede cambiar de estado a lo largo del tiempo, por lo que es necesario registrar un historial de estados.
Es importante poder generar reportes sobre el estado de los préstamos, como el total de préstamos activos, el total en mora, y los pagos realizados en un período específico.
# Tareas
## Modelo Entidad-Relación (ERD):

Diseña un modelo entidad-relación que represente los datos y relaciones descritos en los requerimientos.
Asegúrate de identificar las llaves primarias y foráneas, y de definir las cardinalidades entre las entidades.
## Normalización:

Normaliza las tablas de tu modelo hasta la tercera forma normal (3NF) para evitar redundancias y asegurar la integridad de los datos.
Consultas SQL:

## Escribe consultas SQL para:
Obtener la lista de todos los clientes con préstamos activos.
Mostrar el total de pagos realizados por cada cliente en un período específico.
Listar los préstamos en mora y el oficial de crédito responsable de cada uno.
Generar un reporte del total de préstamos gestionados por cada sucursal.



