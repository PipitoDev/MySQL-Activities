SELECT CustomerID AS 'ID da loja',
	   Country AS 'País',
       City AS 'Cidade'
FROM Customers
WHERE Country LIKE 'Mexico'
ORDER BY CustomerID DESC;
