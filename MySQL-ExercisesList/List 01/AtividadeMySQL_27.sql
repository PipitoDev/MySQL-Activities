SELECT OrderDetailID AS 'Ordem p/ detalhe da ordem(ID)',
	   ProductID AS 'ID do produto',
       OrderID AS 'ID da ordem'
FROM OrderDetails
WHERE ProductID BETWEEN 5 AND 20
AND OrderID % 10 = 7
ORDER BY OrderDetailID ASC;
