SELECT City AS 'Cidade',
	   ContactName AS 'Nome',
       Country AS 'País'
FROM Customers
WHERE Country = 'USA'
ORDER BY City DESC;
