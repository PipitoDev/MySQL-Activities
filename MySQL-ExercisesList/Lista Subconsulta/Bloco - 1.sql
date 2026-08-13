-- Atividade 1 --
SELECT ProductID AS 'ID do Produto',
	ProductName AS 'Nome do Produto',
    Price AS 'Preço'
FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products)
LIMIT 15;

-- Atividade 2 --
SELECT EmployeeID AS 'ID do Funcionário',
	CONCAT(FirstName, ' ', LastName) AS 'Nome do Funcionário',
    BirthDate AS 'Data de Nascimento'
FROM Employees
WHERE BirthDate < (SELECT MAX(BirthDate) FROM Employees)
LIMIT 5;

-- Atividade 3 --
SELECT P1.ProductID AS 'ID do Produto',
	P1.ProductName AS 'Nome do Produto',
    C1.CategoryName AS 'Nome da Categoria',
    P1.Price AS 'Preço',
    (SELECT AVG(Price) FROM Products P2 
     WHERE P2.CategoryID = C1.CategoryID) AS 'Preço Médio p/ Categoria'
FROM Products P1
INNER JOIN Categories C1
ON C1.CategoryID = P1.CategoryID
LIMIT 10;

-- Atividade 4 --
SELECT CustomerID AS 'ID do Cliente',
	CONCAT(CustomerName, ' | ', Country) AS 'Cliente e País',
    (SELECT Country FROM Suppliers WHERE SupplierID = 1) AS 'País do Fornecedor'
FROM Customers C
WHERE Country = (SELECT Country FROM Suppliers WHERE SupplierID = 1);

-- Atividade 5 --
