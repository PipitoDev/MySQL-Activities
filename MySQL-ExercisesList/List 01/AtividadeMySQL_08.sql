SELECT Quantity AS 'Ordem p/quantidade',
	   OrderDetailID AS 'Detalhe da ordem(ID)',
       ProductID AS 'ID do produto'
FROM OrderDetails
WHERE OrderDetailID % 5 = 0
AND ProductID < 10
ORDER BY Quantity ASC;
