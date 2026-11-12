SELECT OrderID AS 'Ordem p/ ordem de ID',
	   OrderDetailID AS 'Detalhe da ordem(ID)',
       Quantity AS 'Quantidade'
FROM OrderDetails
WHERE OrderDetailID < 10
AND Quantity % 2 = 0
ORDER BY OrderID ASC;
