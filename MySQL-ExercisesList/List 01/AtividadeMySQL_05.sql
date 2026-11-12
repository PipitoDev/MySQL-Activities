SELECT ProductID AS 'Ordem p/ID',
	   Quantity AS 'Quantidade',
       OrderID AS 'ID da ordem'
FROM OrderDetails
WHERE Quantity < 12
AND OrderID >= 100 AND OrderID <= 200
ORDER BY ProductID ASC;
