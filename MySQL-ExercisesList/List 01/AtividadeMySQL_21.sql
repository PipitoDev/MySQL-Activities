SELECT Quantity AS 'Ordem p/ quantidade',
	   OrderID AS 'ID da ordem',
       ProductID AS 'ID do produto'
FROM OrderDetails
WHERE OrderID BETWEEN 300 AND 400
AND ProductID < 20
ORDER BY Quantity ASC;
