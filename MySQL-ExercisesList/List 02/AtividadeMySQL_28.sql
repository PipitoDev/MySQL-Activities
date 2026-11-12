SELECT CONCAT(CustomerName, ' | ', PostalCode) AS 'Ordem da Lista',
	   ContactName AS 'Nome do Cliente',
       City AS 'Cidade'
FROM Customers
WHERE City LIKE 'Canada'
ORDER BY 'Ordem da Lista';
