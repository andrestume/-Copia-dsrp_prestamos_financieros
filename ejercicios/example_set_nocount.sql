USE AdventureWorks2019;
GO

SET NOCOUNT OFF;
GO

-- Display the count message.
SELECT TOP (5) LastName
FROM Person.Person
WHERE LastName LIKE 'A%';
GO

SELECT*FROM Person.Person;

-- SET NOCOUNT to ON to no longer display the count message.
SET NOCOUNT ON;
GO

SELECT TOP (5) LastName
FROM Person.Person
WHERE LastName LIKE 'A%';
GO

SELECT*FROM Person.Person;

-- Reset SET NOCOUNT to OFF
SET NOCOUNT OFF;
GO