SELECT Quantity AS 'Ordem p/ quantidade',
	   ProductID AS 'ID do produto',
       OrderDetailID AS 'Detalhe da ordem(ID)'
FROM OrderDetails
WHERE ProductID > 25
AND OrderDetailID % 3 = 0
ORDER BY Quantity ASC, productID ASC;
