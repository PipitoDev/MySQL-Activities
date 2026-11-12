SELECT Quantity AS 'Quantidade',
	   ProductID AS 'ID do produto'
FROM OrderDetails
WHERE ProductID BETWEEN 20 AND 40
AND Quantity % 3 = 0
ORDER BY Quantity ASC, ProductID ASC;
