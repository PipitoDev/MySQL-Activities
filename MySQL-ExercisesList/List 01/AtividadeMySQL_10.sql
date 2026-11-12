SELECT Quantity AS 'Ordem p/quantidade',
	   ProductID AS 'ID do produto',
       OrderDetailID AS 'Detalhe da ordem(ID)'
FROM OrderDetails
WHERE ProductID % 4 = 0
AND OrderDetailID < 200
ORDER BY Quantity ASC;
