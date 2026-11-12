SELECT OrderDetailID AS 'Ordem p/Detalhe de ordem(ID)',
	   OrderID AS 'Ordem ID',
       Quantity AS 'Quantidade'
FROM OrderDetails
WHERE OrderID >= 150 AND OrderID <= 300
AND Quantity > 25
ORDER BY OrderDetailID ASC, Quantity ASC;
