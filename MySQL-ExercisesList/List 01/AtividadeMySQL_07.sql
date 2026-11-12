SELECT OrderID AS 'Ordem p/ID',
	   ProductID AS 'ID do produto',
       Quantity AS 'Quantidade'
FROM OrderDetails
WHERE ProductID > 20
AND Quantity % 2 != 0
ORDER BY OrderID ASC;
