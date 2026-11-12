SELECT CONCAT(Country, ' | ', City) AS 'Ordem da Lista',
	   CustomerName AS 'Nome da Loja'
FROM Customers
WHERE CustomerName LIKE '%Ltd'
ORDER BY 'Ordem da Lista' ASC;
