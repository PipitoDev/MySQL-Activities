SELECT CustomerID AS 'Ordem p/ ID da Loja',
	   ContactName AS 'Nome do Cliente',
       PostalCode AS 'Código Postal'
FROM Customers
WHERE PostalCode LIKE '%00'
ORDER BY CustomerID;
