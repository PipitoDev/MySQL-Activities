SELECT OrderID AS 'Ordenado p/ ID da Ordem',
	   Quantity AS 'Quantidade',
       OrderDetailID AS 'Detalhe da Ordem(ID)'
FROM OrderDetails
WHERE Quantity BETWEEN 25 AND 50
AND OrderDetailID % 7 = 0
ORDER BY OrderID;
