-- Atividade 1 --
SELECT ProductID AS 'ID do Produto',
	ProductName AS 'Nome do Produto',
	(Price * 2) AS 'Preço do Produto'
FROM Products
LIMIT 10;

-- Atividade 2 --
SELECT ProductID AS 'ID do Produto',
	CONCAT('O ', ProductName, ' custa ', price, ' euros') AS 'Informativo'
FROM Products
ORDER BY Price ASC
LIMIT 5;

-- Atividade 3 --
