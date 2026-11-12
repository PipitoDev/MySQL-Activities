SELECT ProductID AS 'Ordem p/ ID do produto',
	   OrderDetailID AS 'Detalhe da ordem(ID)',
       Quantity AS 'Quantidade'
FROM OrderDetails
WHERE OrderDetailID >= 100 AND OrderDetailID <= 200
AND Quantity < 15
ORDER BY ProductID ASC;
