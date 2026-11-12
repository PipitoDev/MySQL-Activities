SELECT ProductID AS 'Ordem p/ID do produto',
	   Quantity AS 'Quantidade',
       OrderID AS 'ID da ordem'
FROM OrderDetails
WHERE Quantity > 18
AND OrderID % 10 = 3
ORDER BY ProductID ASC, Quantity ASC;
