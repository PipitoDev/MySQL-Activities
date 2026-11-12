SELECT ProductID AS 'Ordem',
	   OrderID AS 'ID',
       Quantity AS 'Quantidade'
FROM OrderDetails
WHERE OrderID < 100
AND Quantity > 20
ORDER BY ProductID;
