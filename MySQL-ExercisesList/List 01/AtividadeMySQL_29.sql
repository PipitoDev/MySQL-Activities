SELECT OrderID AS 'Ordem p/ ID da ordem',
	   ProductID AS 'ID do produto',
       Quantity AS 'Quantidade'
FROM OrderDetails
WHERE ProductID % 9 = 0
AND Quantity BETWEEN 10 AND 20
ORDER BY OrderID ASC;
