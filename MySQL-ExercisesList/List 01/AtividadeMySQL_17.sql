SELECT Quantity AS 'Ordem p/ quantidade',
	   OrderID AS 'ID da ordem',
       ProductID AS 'ID do produto'
FROM OrderDetails
WHERE OrderID > 500
AND ProductID % 3 = 0
ORDER BY Quantity ASC;
