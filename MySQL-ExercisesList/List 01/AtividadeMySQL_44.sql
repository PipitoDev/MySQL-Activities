SELECT ProductID AS 'Ordenado p/ ID do Produto',
	   OrderID AS 'ID da Ordem',
       Quantity 'Quantidade'
FROM OrderDetails
WHERE OrderID < 250
AND Quantity % 6 = 0
ORDER BY ProductID;
