SELECT Quantity AS 'Ordem p/quantidade',
	   ProductID AS 'ID do Produto',
       OrderID AS 'ID da ordem'
FROM OrderDetails
WHERE ProductID >= 5 AND ProductID <= 15
AND OrderID % 2 = 0
ORDER BY Quantity ASC;
