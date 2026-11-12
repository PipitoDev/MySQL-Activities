SELECT ProductID AS 'Ordem p/ ID do produto',
	   Quantity AS 'Quantidade',
       OrderID AS 'ID da ordem'
FROM OrderDetails
WHERE Quantity < 10
AND OrderID > 50
ORDER BY ProductID ASC, Quantity ASC;
