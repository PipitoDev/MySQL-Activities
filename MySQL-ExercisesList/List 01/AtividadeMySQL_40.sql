SELECT OrderID AS 'Ordem p/ ID da Ordem',
	   Quantity AS 'Quantidade',
       ProductID AS 'ID do Produto'
FROM OrderDetails
WHERE Quantity < 30
AND ProductID % 5 = 0
ORDER BY OrderID;
