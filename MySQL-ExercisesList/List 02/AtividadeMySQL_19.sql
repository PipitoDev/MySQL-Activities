SELECT CustomerName AS 'Ordem p/ Nome da Loja',
	   ContactName AS 'Nome do Cliente',
       Country AS 'País do Cliente'
FROM Customers
WHERE Country LIKE 'Germany'
ORDER BY CustomerName ASC;
