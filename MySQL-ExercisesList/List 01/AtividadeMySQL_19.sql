SELECT Quantity AS 'Ordem p/ quantidade',
	   ProductID AS 'ID do produto',
       OrderID AS 'ID da ordem'
FROM OrderDetails
WHERE ProductID > 10
AND OrderID < 50
ORDER BY Quantity ASC;
