SELECT ProductID AS 'Ordenados p/ ID do Produto',
	   OrderID AS 'ID da Ordem',
       Quantity AS 'Quantidade'
FROM OrderDetails
WHERE OrderID = 350
AND Quantity > 30
ORDER BY ProductID;
