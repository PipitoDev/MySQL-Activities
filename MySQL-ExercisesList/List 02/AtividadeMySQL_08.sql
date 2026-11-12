SELECT PostalCode AS 'Código Postal',
	   Country AS 'País'
FROM Customers
WHERE Country NOT IN ('Canada', 'Ireland')
ORDER BY PostalCode ASC;
