SELECT Country AS 'País',
	   CustomerName AS 'Nome da loja'
FROM Customers
WHERE CustomerName LIKE '%shop%'
ORDER BY Country ASC;
