SELECT City AS 'Ordem p/ Cidade',
	   ContactName AS 'Nome do Cliente',
       Country AS 'País do Cliente'
FROM Customers
WHERE Country LIKE '%a'
ORDER BY City ASC;
