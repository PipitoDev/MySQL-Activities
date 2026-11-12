SELECT ProductID AS 'Ordem p/ ID do produto',
	   OrderID AS 'ID da ordem',
       Quantity AS 'Quantidade'
FROM OrderDetails
WHERE OrderID % 6 = 0
AND Quantity BETWEEN 15 AND 35
ORDER BY ProductID ASC, OrderID ASC;
