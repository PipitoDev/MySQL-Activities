SELECT Quantity AS 'Ordem p/quantidade',
	   ProductID AS 'ID do produto',
       OrderID AS 'ID da ordem'
FROM OrderDetails
WHERE ProductID < 30
AND OrderID > 100
ORDER BY Quantity ASC, ProductID ASC;
