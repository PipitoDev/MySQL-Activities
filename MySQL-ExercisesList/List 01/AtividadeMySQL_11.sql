SELECT OrderDetailID AS 'Ordem p/detalhe de ID',
	   OrderID AS 'ID da ordem',
       Quantity AS 'Quantidade'
FROM OrderDetails
WHERE OrderID % 3 = 0
AND Quantity > 10
ORDER BY OrderDetailID ASC, Quantity ASC;
