SELECT OrderID AS 'Ordem p/ ID da ordem',
	   Quantity AS 'Quantidade',
       OrderDetailID AS 'Detalhe da ordem(ID)'
FROM OrderDetails
WHERE Quantity > 30
AND OrderDetailID % 10 = 8
ORDER BY OrderID ASC;
