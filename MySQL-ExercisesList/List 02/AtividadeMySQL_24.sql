SELECT CustomerName AS 'Ordem p/ Nome da Loja',
	   City AS 'Cidade da Loja'
FROM Customers
WHERE City LIKE 'S%'
ORDER BY CustomerName;
