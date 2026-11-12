SELECT OrderID AS 'Ordenados p/ ID da Ordem',
	   OrderDetailID AS 'Detalhe da Ordem(ID)',
       Quantity AS 'Quantidade'
FROM OrderDetails
WHERE OrderDetailID > 300
AND Quantity < 12
ORDER BY OrderID;
