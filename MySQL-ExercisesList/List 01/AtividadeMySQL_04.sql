SELECT OrderID AS 'Ordem p/ID de ordem',
	   OrderDetailID AS 'Detalhe da Ordem(ID)',
       ProductID AS 'ID do produto'
FROM OrderDetails
WHERE OrderDetailID > 50
AND ProductID % 10 = 0
ORDER BY OrderID ASC;
