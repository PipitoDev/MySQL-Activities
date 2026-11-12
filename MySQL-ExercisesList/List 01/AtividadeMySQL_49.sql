SELECT OrderDetailID AS 'Ordenados p/ Detalhe da Ordem(ID)',
	   OrderID AS 'ID da Ordem',
       Quantity AS 'Quantidade'
FROM OrderDetails
WHERE OrderID % 10 = 1
AND Quantity % 5 = 0
ORDER BY OrderDetailID;
