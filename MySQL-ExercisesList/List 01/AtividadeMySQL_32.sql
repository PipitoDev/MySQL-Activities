SELECT ProductID AS 'Ordem p/ ID do produto',
	   Quantity AS 'Quantidade',
       OrderID AS 'ID da ordem'
FROM OrderDetails
WHERE Quantity < 5
AND OrderID BETWEEN 10 AND 100
ORDER BY ProductID ASC;
