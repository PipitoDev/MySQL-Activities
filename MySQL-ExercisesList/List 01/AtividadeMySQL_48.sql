SELECT Quantity AS 'Quantidade',
	   ProductID AS 'ID do Produto'
FROM OrderDetails
WHERE Quantity BETWEEN 10 AND 25
AND ProductID < 50
ORDER BY Quantity;
