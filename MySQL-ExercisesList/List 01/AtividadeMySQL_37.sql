SELECT Quantity AS 'Ordem p/ quantidade',
	   ProductID AS 'ID do produto',
       OrderID AS 'ID da ordem'
FROM OrderDetails
WHERE ProductID % 8 = 0
AND OrderID < 400
ORDER BY Quantity;
