SELECT CONCAT(Country, ' | ', PostalCode) AS 'Ordem da Lista',
	   CustomerName AS 'Nome da Loja',
       ContactName AS 'Nome do Cliente'
FROM Customers
WHERE ContactName LIKE 'J%'
ORDER BY 'Ordem da Lista';
