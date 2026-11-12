SELECT ProductID AS 'Ordem p/ID de produto',
	   OrderDetailID AS 'Detalhe da ordem(ID)',
       Quantity AS 'Quantidade'
FROM OrderDetails
WHERE OrderDetailID % 10 = 6
AND Quantity >= 20 AND Quantity <= 40
ORDER BY ProductID ASC, Quantity ASC;
