SELECT OrderID AS 'Ordem p/ ID da ordem',
	   Quantity AS 'Quantidade',
       OrderDetailID AS 'Detalhe da ordem(ID)'
FROM OrderDetails
WHERE Quantity > 15
AND OrderDetailID % 10 = 4
ORDER BY OrderID;
