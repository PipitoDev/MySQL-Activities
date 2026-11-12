SELECT CustomerID AS 'Ordem p/ ID da Loja',
	   ContactName AS 'Nome do Cliente',
       City AS 'Cidade do Cliente'
FROM Customers
WHERE City NOT IN ('London')
ORDER BY CustomerID;
