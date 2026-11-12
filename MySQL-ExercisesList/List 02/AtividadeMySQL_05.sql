SELECT CustomerName AS 'Nome',
	   ContactName AS 'Nome de contato',
       City AS 'Cidade'
FROM Customers
WHERE City = 'Berlin'
ORDER BY CustomerName;
