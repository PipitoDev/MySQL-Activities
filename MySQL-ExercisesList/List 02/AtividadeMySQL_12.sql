SELECT ContactName AS 'Nome do cliente',
	   CustomerName AS 'Nome da loja',
       City AS 'País'
FROM Customers
WHERE City LIKE 'Madrid'
ORDER BY ContactName ASC;
