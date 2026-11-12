SELECT OrderDetailID AS 'Ordem',
       ProductID AS 'ID',
       Quantity AS 'Quantidade'
FROM OrderDetails
WHERE ProductID > 10
AND Quantity > 15
ORDER BY OrderDetailID;
