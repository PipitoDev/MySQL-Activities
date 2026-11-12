SELECT PostalCode AS 'Código Postal',
	   ContactName AS 'Nomes'
FROM Customers
WHERE Country = 'France'
ORDER BY PostalCode;
