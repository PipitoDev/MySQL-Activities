SELECT Quantity AS 'Ordem p/ quantidade',
	   OrderDetailID AS 'Detalhe da ordem(ID)',
       OrderID AS 'ID da ordem'
FROM OrderDetails
WHERE OrderDetailID > 400
AND OrderID % 5 = 0
ORDER BY Quantity ASC, OrderDetailID ASC;
