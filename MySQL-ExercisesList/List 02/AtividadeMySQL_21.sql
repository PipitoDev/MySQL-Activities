SELECT CustomerName AS 'Ordem p/ Nome da Loja',
	   ContactName AS 'Nome do Cliente',
       City AS 'Cidade da Loja'
FROM Customers
WHERE City LIKE 'Tokyo'
ORDER BY CustomerName DESC;
