SELECT Quantity AS 'Ordem p/ quantidade',
	   OrderID AS 'ID da ordem',
       ProductID AS 'ID do produto'
FROM OrderDetails
WHERE OrderID % 10 = 2
AND ProductID > 15
ORDER BY Quantity ASC;
