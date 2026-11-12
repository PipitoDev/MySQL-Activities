SELECT OrderID AS 'Ordem p/ ID da ordem',
	   Quantity AS 'Quantidade',
       OrderDetailID AS 'Detalhe da ordem(ID)'
FROM OrderDetails
WHERE Quantity < 12
AND OrderDetailID > 150
ORDER BY OrderID ASC, Quantity ASC;
