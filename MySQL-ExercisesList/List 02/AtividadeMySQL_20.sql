SELECT PostalCode AS 'Ordem p/ Código Postal',
	   ContactName AS 'Nome do Cliente',
       CustomerName AS 'Nome da Loja'
FROM Customers
WHERE ContactName LIKE '%son%'
ORDER BY PostalCode;
