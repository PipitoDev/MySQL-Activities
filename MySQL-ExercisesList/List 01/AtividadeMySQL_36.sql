SELECT ProductID AS 'Ordem p/ ID do produto',
	   OrderID AS 'ID da ordem',
       Quantity AS 'Quantidade'
FROM OrderDetails
WHERE OrderID > 700
AND Quantity > 40
ORDER BY ProductID ASC;
