SELECT CustomerName AS 'Nome do cliente',
	   PostalCode AS 'Código Postal'
FROM Customers
WHERE PostalCode LIKE '1%'
ORDER BY CustomerName;
