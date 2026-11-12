SELECT OrderDetailID AS 'Ordem p/ Detalhe da Ordem(ID)',
	   ProductID AS 'ID do Produto',
       Quantity AS 'Quantidade'
FROM OrderDetails
WHERE ProductID % 10 = 9
AND Quantity < 20
ORDER BY OrderDetailID;
