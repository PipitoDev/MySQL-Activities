SELECT CustomerID AS 'ID',
	   ContactName AS 'Nome'
FROM Customers
WHERE ContactName LIKE 'A%'
ORDER BY CustomerID;
