SELECT OrderDetailID AS 'Ordem p/ Detalhe da Ordem(ID)',
	   OrderID AS 'ID da Ordem',
       ProductID AS 'ID do Produto'
FROM OrderDetails
WHERE OrderID < 100
AND ProductID BETWEEN 10 AND 20
ORDER BY OrderDetailID;
