SELECT OrderDetailID AS 'Ordem p/detalhe de ID',
	   OrderID AS 'ID da ordem',
       Quantity AS 'Quantidade'
FROM OrderDetails
WHERE OrderID = 300
AND Quantity >= 10 AND Quantity <= 20
ORDER BY OrderDetailID;
