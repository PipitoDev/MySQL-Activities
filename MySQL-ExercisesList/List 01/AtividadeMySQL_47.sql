SELECT OrderID AS 'Ordenados p/ ID da Ordem',
	   OrderDetailID AS 'Detalhe da Ordem(ID)',
       ProductID AS 'ID do Produto'
FROM OrderDetails	   
WHERE OrderDetailID % 2 = 0
AND ProductID % 10 = 0
ORDER BY OrderID;
