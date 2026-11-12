SELECT Quantity AS 'Ordenados p/ Quantidade',
	   OrderDetailID AS 'Detalhe da Ordem(ID)',
       ProductID AS 'ID Do Produto'
FROM OrderDetails
WHERE OrderDetailID BETWEEN 50 AND 150
AND ProductID > 20
ORDER BY Quantity, OrderDetailID;
