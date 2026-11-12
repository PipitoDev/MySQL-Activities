SELECT ProductID AS 'Ordem p/ ID do produto',
	   OrderID AS 'ID da ordem',
       Quantity AS 'Quantidade'
FROM OrderDetails
WHERE OrderID < 200
AND Quantity > 25
ORDER BY ProductID ASC;
