SELECT ProductID AS 'Ordem p/ID do produto',
	   Quantity AS 'Quantidade',
       OrderDetailID AS 'Detalhe da ordem(ID)'
FROM OrderDetails
WHERE Quantity % 7 = 0
AND OrderDetailID < 300
ORDER BY ProductID ASC, Quantity ASC;
