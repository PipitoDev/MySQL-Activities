SELECT CONCAT(CustomerID, ' | ', Country) AS 'Ordem p/ ID e País',
	   ContactName AS 'Nome do Cliente'
FROM Customers
WHERE ContactName LIKE 'P%'
AND Country <> 'Argentina'
ORDER BY Country, CustomerID;
