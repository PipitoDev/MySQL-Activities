SELECT Quantity AS 'Ordenado p/ Quantidade',
	   OrderID AS 'ID da Ordem',
       ProductID AS 'ID do Produto'
FROM OrderDetails
WHERE OrderID % 5 = 0
AND ProductID BETWEEN 15 AND 30
ORDER BY Quantity, OrderID;
