SELECT Country AS 'Ordem p/ País',
	   ContactName AS 'Nome do Cliente',
       City AS 'Cidade'
FROM Customers
WHERE City LIKE 'Paris'
ORDER BY Country ASC;
