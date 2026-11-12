SELECT CustomerName AS 'Ordem p/ Nome da Loja',
	   ContactName AS 'Nome do Cliente'
FROM Customers
WHERE City LIKE 'New York'
ORDER BY CustomerName;
