SELECT OrderID AS 'Ordem p/ ordem de ID',
	   Quantity AS 'Quantidade',
       ProductID AS 'ID do produto'
FROM OrderDetails
WHERE Quantity < 20
AND ProductID % 10 = 5
ORDER BY OrderID ASC;
