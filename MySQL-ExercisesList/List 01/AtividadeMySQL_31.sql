SELECT Quantity AS 'Ordem p/ quantidade',
	   OrderDetailID AS 'Detalhe da ordem(ID)',
       OrderID AS 'ID da ordem'
FROM OrderDetails
WHERE OrderDetailID % 4 = 0
AND OrderID < 300
ORDER BY Quantity ASC;
