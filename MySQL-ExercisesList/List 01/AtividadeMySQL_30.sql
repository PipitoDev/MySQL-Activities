SELECT OrderDetailID AS 'Ordem p/ Detalhe da ordem(ID)',
	   Quantity AS 'Quantidade',
       ProductID AS 'ID do produto'
FROM OrderDetails
WHERE Quantity > 50
AND ProductID < 30
ORDER BY OrderDetailID ASC;
