-- OS CALL ESTÃO VAZIAS E PRECISAM DE INFORMAÇÕES --
-- POR ISSO ELE DERÁ ERRO --

CREATE DATABASE FastBite;

USE FastBite;

CREATE TABLE Restaurants (
	RestaurantID INT AUTO_INCREMENT PRIMARY KEY,
    RestaurantName VARCHAR(30) NOT NULL,
    RestaurantInfo VARCHAR(255),
    Phone VARCHAR(11) NOT NULL,
    LegalCode VARCHAR(14) NOT NULL,
	CONSTRAINT uk_restaurants_phone
		UNIQUE (Phone),
	CONSTRAINT uk_restaurants_legalcode
		UNIQUE (LegalCode)
);

CREATE TABLE Products (
	ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(20) NOT NULL,
    ProductInfo VARCHAR(100),
    ProductType VARCHAR(15),
    Price DECIMAL(10, 2) NOT NULL,
    CONSTRAINT ck_products_price
		CHECK (Price > 0)
);

CREATE TABLE Users (
	UserID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(30) NOT NULL,
    LastName VARCHAR(30) NOT NULL,
    Email VARCHAR(300) NOT NULL,
    UserPassword VARCHAR(255) NOT NULL,
    Phone VARCHAR(11) NOT NULL,
    CONSTRAINT uk_users_email
		UNIQUE (Email),
	CONSTRAINT uk_users_phone
		UNIQUE (Phone)
);

CREATE TABLE RestaurantsAddress (
	AddressID INT AUTO_INCREMENT PRIMARY KEY,
    RestaurantID INT NOT NULL,
    Street VARCHAR(50) NOT NULL,
    StreetNumber VARCHAR(15),
    District VARCHAR(50) NOT NULL,
    PostalCode VARCHAR(8) NOT NULL,
    City VARCHAR(50) NOT NULL,
    Complement VARCHAR(255),
    CONSTRAINT fk_restaurantsaddress_restaurantid
		FOREIGN KEY (RestaurantID) REFERENCES Restaurants (RestaurantID),
	CONSTRAINT uk_restaurantsaddress_restaurantid
		UNIQUE (RestaurantID)
);

CREATE TABLE Menus (
	MenuID INT AUTO_INCREMENT PRIMARY KEY,
    RestaurantID INT NOT NULL,
    ProductID INT,
    MenuName VARCHAR(20) NOT NULL,
    MenuInfo VARCHAR(255),
    CONSTRAINT fk_menus_restaurantid
		FOREIGN KEY (RestaurantID) REFERENCES Restaurants (RestaurantID),
	CONSTRAINT fk_menus_productid
		FOREIGN KEY (ProductID) REFERENCES Products (ProductID)
);

CREATE TABLE UsersAddress (
	AddressID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    Street VARCHAR(50) NOT NULL,
    StreetNumber VARCHAR(15),
    District VARCHAR(50) NOT NULL,
    PostalCode VARCHAR(8) NOT NULL,
    City VARCHAR(50) NOT NULL,
    Complement VARCHAR(255),
    CONSTRAINT fk_usersaddress_userid
		FOREIGN KEY (UserID) REFERENCES Users (UserID)
);

CREATE TABLE Coupons (
	CouponID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    Avaliability BOOLEAN NOT NULL,
    StartDate DATETIME,
    FinalDate DATETIME,
    CouponType VARCHAR(20) NOT NULL,
    Rules VARCHAR(255) NOT NULL,
    Discount DECIMAL(10, 2) NOT NULL,
    CONSTRAINT fk_coupons_userid
		FOREIGN KEY (UserID) REFERENCES Users (UserID),
	CONSTRAINT ck_coupons_discount
		CHECK (Discount > 0)
);	

CREATE TABLE Orders (
	OrderID INT AUTO_INCREMENT PRIMARY KEY,
    RestaurantID INT NOT NULL,
    UserID INT NOT NULL,
    CouponID INT,
    OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    EstimatedDate TIME NOT NULL,
    Payment DECIMAL(10, 2) NOT NULL,
    CONSTRAINT fk_orders_restaurantid
		FOREIGN KEY (RestaurantID) REFERENCES Restaurants (RestaurantID),
	CONSTRAINT fk_orders_userid
		FOREIGN KEY (UserID) REFERENCES Users (UserID),
	CONSTRAINT fk_orders_couponid
		FOREIGN KEY (CouponID) REFERENCES Coupons (CouponID)
);

CREATE TABLE OrderDetails (
	OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitaryPrice DECIMAL(10, 2) NOT NULL,
    TotalPrice DECIMAL(10, 2) AS (UnitaryPrice * Quantity) STORED,
    CONSTRAINT fk_orderdetails_orderid
		FOREIGN KEY (OrderID) REFERENCES Orders (OrderID),
	CONSTRAINT fk_orderdetails_productid
		FOREIGN KEY (ProductID) REFERENCES Products (ProductID),
	CONSTRAINT ck_orderdetails_quantity
		CHECK (Quantity > 0),
	CONSTRAINT ck_orderdetails_unitaryprice
		CHECK (UnitaryPrice > 0)
);

CREATE TABLE DeliveryPersonnel (
	PersonID INT AUTO_INCREMENT PRIMARY KEY,
    OrderDetailID INT,
    FirstName VARCHAR(30) NOT NULL,
    LastName VARCHAR(30) NOT NULL,
    BirthDate DATE NOT NULL,
    LegalCode VARCHAR(11) NOT NULL,
    Photo BLOB,
    CONSTRAINT fk_deliverypersonnel_orderdetailid
		FOREIGN KEY (OrderDetailID) REFERENCES OrderDetails (OrderDetailID),
	CONSTRAINT uk_deliverypersonnel_legalcode
		UNIQUE (LegalCode)
);

CREATE TABLE Vehicles (
	VehicleID INT AUTO_INCREMENT PRIMARY KEY,
    PersonID INT NOT NULL,
    Model VARCHAR(30) NOT NULL,
    Plate VARCHAR(7) NOT NULL,
    Note VARCHAR(100),
    CONSTRAINT fk_vehicles_personid
		FOREIGN KEY (PersonID) REFERENCES DeliveryPersonnel (PersonID),
	CONSTRAINT uk_vehicles_plate
		UNIQUE (Plate)
);

ALTER TABLE Coupons
	ADD COLUMN Quantity INT NOT NULL,
	ADD CONSTRAINT ck_coupons_quantity
		CHECK (Quantity >= 0);

ALTER TABLE DeliveryPersonnel
	ADD COLUMN RegisterDate DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL;

ALTER TABLE Menus
	ADD COLUMN RegisterDate DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
	ADD COLUMN LastChangeDate DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL;

ALTER TABLE Orders
	ADD COLUMN PaymentType VARCHAR(30) NOT NULL;

ALTER TABLE Products
	ADD COLUMN RegisterDate DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
	ADD COLUMN PriceChangeDate DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL;

ALTER TABLE Restaurants
	ADD COLUMN RestaurantType VARCHAR(50);
    
ALTER TABLE RestaurantsAddress
	ADD COLUMN RegisterDate DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
	ADD COLUMN AddressChangeDate DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL;
    
ALTER TABLE Users
	ADD COLUMN AlternativeEmail VARCHAR(300),
    ADD CONSTRAINT uk_users_alternativeemail
		UNIQUE (AlternativeEmail);
        
ALTER TABLE UsersAddress
	ADD COLUMN RegisterDate DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
	ADD COLUMN AddressChangeDate DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL;
    
ALTER TABLE Vehicles
	ADD COLUMN ActiveStage BOOLEAN DEFAULT TRUE NOT NULL;
    
CREATE TABLE LogProduct (
	LogID INT AUTO_INCREMENT PRIMARY KEY,
    OldPrice DECIMAL(10, 2),
    NewPrice DECIMAL(10, 2),
    Difference DECIMAL(10, 2) AS (OldPrice - NewPrice) VIRTUAL,
    ChangeDate DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- INSERT

USE FastBite;

-- =====================================================================
-- 1) RESTAURANTS (20 linhas)
-- RestaurantInfo e RestaurantType ficam NULL em alguns registros
-- (informação não cadastrada pelo restaurante).
-- =====================================================================
INSERT INTO Restaurants (RestaurantName, RestaurantInfo, Phone, LegalCode, RestaurantType) VALUES
('Pizza Suprema',          'Pizzaria tradicional com forno a lenha.',   '31987650001', '11122233000101', 'Pizzaria'),
('Burger House',           'Hambúrgueres artesanais smash.',            '31987650002', '11122233000102', 'Hamburgueria'),
('Sushi Kaze',             'Culinária japonesa contemporânea.',         '31987650003', '11122233000103', 'Japonesa'),
('Cantina Trattoria',      NULL,                                        '31987650004', '11122233000104', 'Italiana'),
('Tempero Mineiro',        'Comida mineira de boteco.',                 '31987650005', '11122233000105', 'Mineira'),
('Sabor Caseiro',          'Marmitas e pratos do dia.',                 '31987650006', '11122233000106', NULL),
('Taco Fiesta',            'Comida mexicana rápida.',                  '31987650007', '11122233000107', 'Mexicana'),
('Churrasco Real',         'Churrasco no rodízio e à la carte.',        '31987650008', '11122233000108', 'Churrascaria'),
('Veggie Delícia',         'Opções vegetarianas e veganas.',            '31987650009', '11122233000109', 'Vegetariana'),
('Doce Sabor',             'Doces e sobremesas artesanais.',            '31987650010', '11122233000110', 'Confeitaria'),
('Frango Frito Express',   'Frango frito estilo americano.',            '31987650011', '11122233000111', NULL),
('Massas da Nona',         'Receitas italianas de família.',            '31987650012', '11122233000112', 'Italiana'),
('Pastel do Zé',           'Pastéis fritos na hora.',                   '31987650013', '11122233000113', 'Salgados'),
('Crepe Gourmet',          NULL,                                        '31987650014', '11122233000114', 'Creperia'),
('Açaí Power',             'Açaí e complementos.',                      '31987650015', '11122233000115', 'Açaiteria'),
('Espeto Carioca',         'Espetinhos grelhados na brasa.',            '31987650016', '11122233000116', NULL),
('Padoca do Bairro',       'Padaria com salgados e pães.',              '31987650017', '11122233000117', 'Padaria'),
('Comida Mineira',         'Culinária típica de Minas Gerais.',         '31987650018', '11122233000118', 'Mineira'),
('Pizzaria Napoli',        NULL,                                        '31987650019', '11122233000119', 'Pizzaria'),
('Hamburgueria Artesanal', 'Lanches artesanais gourmet.',                '31987650020', '11122233000120', 'Hamburgueria');

-- =====================================================================
-- 2) RESTAURANTSADDRESS (20 linhas — 1 por restaurante, relação 1:1)
-- StreetNumber e Complement ficam NULL quando não se aplica.
-- =====================================================================
INSERT INTO RestaurantsAddress (RestaurantID, Street, StreetNumber, District, PostalCode, City, Complement) VALUES
(1,  'Rua das Palmeiras',       '120', 'Savassi',         '30130000', 'Belo Horizonte', 'Loja 1'),
(2,  'Av. Afonso Pena',         '2200','Centro',          '30130002', 'Belo Horizonte', NULL),
(3,  'Rua Pium-í',              '340', 'Santo Antônio',   '30330030', 'Belo Horizonte', 'Sala 2'),
(4,  'Rua Sergipe',             '890', 'Funcionários',    '30130170', 'Belo Horizonte', NULL),
(5,  'Av. Amazonas',            '1500','Barro Preto',     '30180001', 'Belo Horizonte', NULL),
(6,  'Rua Bernardo Guimarães',  NULL,  'Santo Agostinho', '30140080', 'Belo Horizonte', 'Fundos'),
(7,  'Rua Curitiba',            '600', 'Centro',          '30170120', 'Belo Horizonte', NULL),
(8,  'Av. do Contorno',         '3300','Floresta',        '30110005', 'Belo Horizonte', NULL),
(9,  'Rua Tomé de Souza',       '780', 'Savassi',         '30140131', 'Belo Horizonte', 'Loja 3'),
(10, 'Rua Rio de Janeiro',      '210', 'Centro',          '30160041', 'Belo Horizonte', NULL),
(11, 'Av. Cristiano Machado',   '5000','Cidade Nova',     '31160000', 'Belo Horizonte', NULL),
(12, 'Rua Grão Pará',           '330', 'Santa Efigênia',  '30150341', 'Belo Horizonte', NULL),
(13, 'Rua Padre Eustáquio',     NULL,  'Padre Eustáquio', '30720000', 'Belo Horizonte', NULL),
(14, 'Av. Raja Gabáglia',       '2000','Estoril',         '30494000', 'Belo Horizonte', NULL),
(15, 'Rua São Paulo',           '900', 'Centro',          '30170131', 'Belo Horizonte', 'Quiosque 4'),
(16, 'Rua Ouro Preto',          '410', 'Floresta',        '30150280', 'Belo Horizonte', NULL),
(17, 'Rua Diamantina',          '150', 'Bonfim',          '32017080', 'Contagem',       NULL),
(18, 'Av. Gov. Valadares',      '1000','Centro',          '32010000', 'Contagem',       NULL),
(19, 'Rua das Acácias',         NULL,  'Vila Nova',       '32600000', 'Betim',          NULL),
(20, 'Rua José Bonifácio',      '850', 'Centro',          '34000000', 'Nova Lima',      NULL);

-- =====================================================================
-- 3) PRODUCTS (25 linhas)
-- ProductInfo e ProductType ficam NULL em alguns registros.
-- =====================================================================
INSERT INTO Products (ProductName, ProductInfo, ProductType, Price) VALUES
('Pizza Margherita',    'Molho, mussarela e manjericão.',        'Pizza',        39.90),
('Pizza Calabresa',     'Calabresa fatiada e cebola.',           'Pizza',        42.90),
('X-Burger Clássico',   'Pão, carne, queijo e salada.',          'Lanche',       24.90),
('X-Bacon Duplo',       NULL,                                    'Lanche',       29.90),
('Temaki Salmão',       'Arroz, salmão e cream cheese.',         'Japonesa',     28.50),
('Combo Sushi 20',      'Seleção variada de sushi.',             'Japonesa',     54.90),
('Lasanha Bolonhesa',   'Massa, molho e queijo.',                'Italiana',     32.00),
('Nhoque ao Sugo',      NULL,                                    'Italiana',     27.50),
('Burrito de Carne',    'Tortilha, carne e feijão.',             'Mexicana',     26.90),
('Taco al Pastor',      'Taco de carne suína marinada.',         'Mexicana',     18.90),
('Picanha na Chapa',    'Picanha grelhada com acompanhamento.',  'Churrasco',    65.00),
('Espeto de Frango',    NULL,                                    'Churrasco',    12.50),
('Salada Caesar',       'Alface, croutons e molho especial.',    'Vegetariana',  22.00),
('Burger Vegetal',      'Hambúrguer de grão-de-bico.',           'Vegetariana',  25.90),
('Brigadeiro Gourmet',  'Brigadeiro artesanal ao leite.',        'Doce',          5.50),
('Pudim de Leite',      NULL,                                    'Doce',          8.90),
('Frango Frito Balde',  'Balde de frango frito crocante.',       'Frango',       45.00),
('Coxinha de Frango',   'Recheada com frango desfiado.',         'Salgados',      7.50),
('Pastel de Carne',     NULL,                                    'Salgados',      9.00),
('Crepe Chocolate',     'Crepe doce com chocolate.',             'Doce',         14.90),
('Açaí 500ml',          'Açaí batido com complementos.',         'Açaí',         19.90),
('Pão de Queijo',       'Pão de queijo mineiro, 6 unidades.',    'Padaria',      12.00),
('Feijão Tropeiro',     NULL,                                    'Mineira',      21.00),
('Refrigerante Lata',   'Refrigerante gelado 350ml.',            'Bebida',        6.00),
('Sorvete 2 Bolas',     'Sorvete artesanal, sabores variados.',  'Sorvete',      11.50);

-- =====================================================================
-- 4) USERS (20 linhas)
-- =====================================================================
INSERT INTO Users (FirstName, LastName, Email, UserPassword, Phone) VALUES
('Ana',      'Silva',      'ana.silva@example.com',       '$2y$10$hashsenha000000000001', '31999990001'),
('Bruno',    'Costa',      'bruno.costa@example.com',     '$2y$10$hashsenha000000000002', '31999990002'),
('Carla',    'Souza',      'carla.souza@example.com',     '$2y$10$hashsenha000000000003', '31999990003'),
('Diego',    'Almeida',    'diego.almeida@example.com',   '$2y$10$hashsenha000000000004', '31999990004'),
('Elaine',   'Ferreira',   'elaine.ferreira@example.com', '$2y$10$hashsenha000000000005', '31999990005'),
('Fábio',    'Lima',       'fabio.lima@example.com',      '$2y$10$hashsenha000000000006', '31999990006'),
('Gabriela', 'Rocha',      'gabriela.rocha@example.com',  '$2y$10$hashsenha000000000007', '31999990007'),
('Henrique', 'Martins',    'henrique.martins@example.com','$2y$10$hashsenha000000000008','31999990008'),
('Isabela',  'Carvalho',   'isabela.carvalho@example.com','$2y$10$hashsenha000000000009','31999990009'),
('João',     'Pereira',    'joao.pereira@example.com',    '$2y$10$hashsenha000000000010', '31999990010'),
('Karina',   'Duarte',     'karina.duarte@example.com',   '$2y$10$hashsenha000000000011', '31999990011'),
('Lucas',    'Barbosa',    'lucas.barbosa@example.com',   '$2y$10$hashsenha000000000012', '31999990012'),
('Mariana',  'Teixeira',   'mariana.teixeira@example.com','$2y$10$hashsenha000000000013','31999990013'),
('Nicolas',  'Ribeiro',    'nicolas.ribeiro@example.com', '$2y$10$hashsenha000000000014', '31999990014'),
('Otávia',   'Gomes',      'otavia.gomes@example.com',    '$2y$10$hashsenha000000000015', '31999990015'),
('Paulo',    'Nunes',      'paulo.nunes@example.com',     '$2y$10$hashsenha000000000016', '31999990016'),
('Quésia',   'Araújo',     'quesia.araujo@example.com',   '$2y$10$hashsenha000000000017', '31999990017'),
('Rafael',   'Cardoso',    'rafael.cardoso@example.com',  '$2y$10$hashsenha000000000018', '31999990018'),
('Sabrina',  'Moreira',    'sabrina.moreira@example.com', '$2y$10$hashsenha000000000019', '31999990019'),
('Thiago',   'Correia',    'thiago.correia@example.com',  '$2y$10$hashsenha000000000020', '31999990020');

-- Atualiza e-mail alternativo apenas para parte dos usuários (coluna
-- adicionada via ALTER TABLE, opcional e única quando preenchida).
UPDATE Users SET AlternativeEmail = 'ana.s.alt@example.com'      WHERE UserID = 1;
UPDATE Users SET AlternativeEmail = 'bruno.c.alt@example.com'    WHERE UserID = 2;
UPDATE Users SET AlternativeEmail = 'carla.s.alt@example.com'    WHERE UserID = 3;
UPDATE Users SET AlternativeEmail = 'henrique.m.alt@example.com' WHERE UserID = 8;
UPDATE Users SET AlternativeEmail = 'karina.d.alt@example.com'   WHERE UserID = 11;
UPDATE Users SET AlternativeEmail = 'rafael.c.alt@example.com'   WHERE UserID = 18;

-- =====================================================================
-- 5) USERSADDRESS (24 linhas — 20 usuários + 4 endereços extras)
-- StreetNumber e Complement ficam NULL quando não se aplica.
-- =====================================================================
INSERT INTO UsersAddress (UserID, Street, StreetNumber, District, PostalCode, City, Complement) VALUES
(1,  'Rua A', '10',  'Centro',         '30110002', 'Belo Horizonte', 'Apto 101'),
(2,  'Rua B', '20',  'Savassi',        '30140002', 'Belo Horizonte', NULL),
(3,  'Rua C', NULL,  'Floresta',       '30150003', 'Belo Horizonte', 'Casa 2'),
(4,  'Rua D', '40',  'Buritis',        '30575004', 'Belo Horizonte', NULL),
(5,  'Rua E', '50',  'Cidade Nova',    '31170005', 'Belo Horizonte', 'Bloco B'),
(6,  'Rua F', '60',  'Barreiro',       '30640006', 'Belo Horizonte', NULL),
(7,  'Rua G', '70',  'Pampulha',       '31270007', 'Belo Horizonte', 'Apto 302'),
(8,  'Rua H', NULL,  'Santa Efigênia', '30150008', 'Belo Horizonte', NULL),
(9,  'Rua I', '90',  'Gutierrez',      '30441009', 'Belo Horizonte', NULL),
(10, 'Rua J', '100', 'Centro',         '32010010', 'Contagem',       NULL),
(11, 'Rua K', '110', 'Eldorado',       '32310011', 'Contagem',       'Casa 1'),
(12, 'Rua L', '120', 'Centro',         '32600012', 'Betim',          NULL),
(13, 'Rua M', NULL,  'Alterosas',      '32677013', 'Betim',          NULL),
(14, 'Rua N', '140', 'Centro',         '34000014', 'Nova Lima',      'Apto 4'),
(15, 'Rua O', '150', 'Vila Boa Vista', '34006015', 'Nova Lima',      NULL),
(16, 'Rua P', '160', 'Centro',         '34500016', 'Sabará',         NULL),
(17, 'Rua Q', '170', 'São Geraldo',    '31035017', 'Belo Horizonte', NULL),
(18, 'Rua R', NULL,  'Anchieta',       '30310018', 'Belo Horizonte', 'Casa 3'),
(19, 'Rua S', '190', 'Sion',           '30320019', 'Belo Horizonte', NULL),
(20, 'Rua T', '200', 'Lourdes',        '30180020', 'Belo Horizonte', NULL),
(1,  'Av. Trabalho',    '15', 'Centro',       '30110021', 'Belo Horizonte', 'Escritório'),
(2,  'Rua Alternativa', '25', 'Funcionários', '30130022', 'Belo Horizonte', NULL),
(3,  'Av. Secundária',  '35', 'Centro',       '30170023', 'Belo Horizonte', NULL),
(4,  'Rua Nova',        '45', 'Buritis',      '30575024', 'Belo Horizonte', 'Casa dos fundos');

-- =====================================================================
-- 6) COUPONS (20 linhas)
-- UserID fica NULL em cupons gerais (não vinculados a um usuário
-- específico). StartDate/FinalDate ficam NULL quando o cupom não tem
-- prazo definido. Quantity pode ser 0 (cupom esgotado).
-- =====================================================================
INSERT INTO Coupons (UserID, Avaliability, StartDate, FinalDate, CouponType, Rules, Discount, Quantity) VALUES
(NULL, TRUE,  '2026-01-01 00:00:00', '2026-12-31 23:59:59', 'Percentual', 'Cupom geral de boas-vindas.',         10.00, 500),
(NULL, TRUE,  NULL,                   NULL,                  'Fixo',       'Cupom geral de frete grátis, sem prazo.', 8.00, 300),
(NULL, TRUE,  '2026-03-01 00:00:00', '2026-09-30 23:59:59', 'Percentual', 'Cupom geral de aniversário FastBite.',15.00, 200),
(NULL, FALSE, '2025-11-01 00:00:00', '2025-12-31 23:59:59', 'Percentual', 'Cupom geral Black Friday (esgotado).',20.00, 0),
(NULL, TRUE,  '2026-04-01 00:00:00', '2026-12-31 23:59:59', 'Fixo',       'Cupom geral primeiro pedido.',         5.00, 1000),
(NULL, TRUE,  NULL,                   NULL,                  'Percentual', 'Cupom geral sem data definida.',      12.00, 150),
(1,   TRUE,  '2026-01-10 00:00:00', '2026-06-30 23:59:59', 'Percentual', 'Cupom fidelidade Ana.',               12.00, 1),
(2,   TRUE,  '2026-01-15 00:00:00', '2026-06-30 23:59:59', 'Fixo',       'Cupom fidelidade Bruno.',              7.00, 1),
(3,   TRUE,  '2026-02-01 00:00:00', '2026-07-31 23:59:59', 'Percentual', 'Cupom fidelidade Carla.',             10.00, 1),
(4,   FALSE, '2025-12-01 00:00:00', '2026-01-31 23:59:59', 'Fixo',       'Cupom fidelidade Diego (expirado).',   6.00, 0),
(5,   TRUE,  '2026-02-10 00:00:00', '2026-08-10 23:59:59', 'Percentual', 'Cupom fidelidade Elaine.',            18.00, 1),
(6,   TRUE,  '2026-03-01 00:00:00', '2026-09-01 23:59:59', 'Fixo',       'Cupom fidelidade Fábio.',              9.00, 1),
(7,   TRUE,  '2026-03-05 00:00:00', '2026-09-05 23:59:59', 'Percentual', 'Cupom fidelidade Gabriela.',          14.00, 1),
(8,   TRUE,  '2026-01-20 00:00:00', '2026-07-20 23:59:59', 'Fixo',       'Cupom fidelidade Henrique.',           5.50, 1),
(9,   TRUE,  '2026-02-15 00:00:00', '2026-08-15 23:59:59', 'Percentual', 'Cupom fidelidade Isabela.',           11.00, 1),
(10,  FALSE, '2025-10-01 00:00:00', '2025-11-30 23:59:59', 'Fixo',       'Cupom fidelidade João (expirado).',    4.00, 0),
(11,  TRUE,  '2026-04-01 00:00:00', '2026-10-01 23:59:59', 'Percentual', 'Cupom fidelidade Karina.',            13.00, 1),
(12,  TRUE,  '2026-04-10 00:00:00', '2026-10-10 23:59:59', 'Fixo',       'Cupom fidelidade Lucas.',              6.50, 1),
(13,  TRUE,  '2026-05-01 00:00:00', '2026-11-01 23:59:59', 'Percentual', 'Cupom fidelidade Mariana.',           16.00, 1),
(14,  TRUE,  '2026-05-10 00:00:00', '2026-11-10 23:59:59', 'Fixo',       'Cupom fidelidade Nicolas.',            7.50, 1);

-- =====================================================================
-- 7) ORDERS (25 linhas)
-- CouponID fica NULL quando o pedido não usou cupom.
-- =====================================================================
INSERT INTO Orders (RestaurantID, UserID, CouponID, OrderDate, EstimatedDate, Payment, PaymentType) VALUES
(1,  1,  1,    '2026-06-01 12:00:00', '00:45:00', 82.80, 'Cartão de Crédito'),
(2,  2,  NULL, '2026-06-01 13:10:00', '00:40:00', 54.80, 'Pix'),
(3,  3,  2,    '2026-06-02 19:00:00', '00:35:00', 83.40, 'Cartão de Débito'),
(4,  4,  NULL, '2026-06-02 20:15:00', '00:50:00', 59.50, 'Dinheiro'),
(5,  5,  3,    '2026-06-03 12:30:00', '00:30:00', 66.00, 'Pix'),
(6,  6,  NULL, '2026-06-03 13:00:00', '00:35:00', 28.50, 'Cartão de Crédito'),
(7,  7,  4,    '2026-06-04 18:45:00', '00:40:00', 45.80, 'Vale-Refeição'),
(8,  8,  NULL, '2026-06-04 19:30:00', '00:55:00', 77.50, 'Cartão de Crédito'),
(9,  9,  5,    '2026-06-05 12:15:00', '00:40:00', 47.90, 'Pix'),
(10, 10, NULL, '2026-06-05 14:00:00', '00:30:00', 14.40, 'Dinheiro'),
(11, 11, 6,    '2026-06-06 20:00:00', '00:45:00', 45.00, 'Cartão de Débito'),
(12, 12, NULL, '2026-06-06 12:40:00', '00:35:00', 32.00, 'Pix'),
(13, 13, 7,    '2026-06-07 19:10:00', '00:30:00', 16.50, 'Vale-Refeição'),
(14, 14, NULL, '2026-06-07 20:00:00', '00:35:00', 14.90, 'Cartão de Crédito'),
(15, 15, 8,    '2026-06-08 15:30:00', '00:25:00', 19.90, 'Pix'),
(16, 16, NULL, '2026-06-08 19:00:00', '00:30:00', 12.50, 'Dinheiro'),
(17, 17, 9,    '2026-06-09 09:00:00', '00:20:00', 12.00, 'Pix'),
(18, 18, NULL, '2026-06-09 12:20:00', '00:40:00', 21.00, 'Cartão de Débito'),
(19, 19, 10,   '2026-06-10 18:30:00', '00:35:00', 39.90, 'Cartão de Crédito'),
(20, 20, NULL, '2026-06-10 19:45:00', '00:30:00', 24.90, 'Pix'),
(1,  2,  NULL, '2026-06-11 12:00:00', '00:40:00', 42.90, 'Dinheiro'),
(2,  3,  NULL, '2026-06-11 13:15:00', '00:35:00', 29.90, 'Pix'),
(3,  4,  NULL, '2026-06-12 19:20:00', '00:40:00', 28.50, 'Cartão de Crédito'),
(4,  5,  NULL, '2026-06-12 20:30:00', '00:45:00', 27.50, 'Vale-Refeição'),
(5,  6,  NULL, '2026-06-13 12:10:00', '00:30:00', 21.00, 'Pix');

-- =====================================================================
-- 8) ORDERDETAILS (35 linhas)
-- Pedidos 1-10 recebem 2 itens; pedidos 11-25 recebem 1 item.
-- (Sem restrição de par único nesta versão do schema.)
-- =====================================================================
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitaryPrice) VALUES
(1,  1,  1, 39.90),
(1,  15, 2,  5.50),
(2,  3,  2, 24.90),
(2,  24, 1,  6.00),
(3,  5,  2, 28.50),
(3,  6,  1, 54.90),
(4,  7,  1, 32.00),
(4,  16, 1,  8.90),
(5,  11, 1, 65.00),
(5,  24, 1,  6.00),
(6,  23, 1, 21.00),
(6,  18, 1,  7.50),
(7,  9,  1, 26.90),
(7,  10, 1, 18.90),
(8,  11, 1, 65.00),
(8,  12, 1, 12.50),
(9,  13, 1, 22.00),
(9,  14, 1, 25.90),
(10, 20, 1, 14.90),
(10, 21, 1, 19.90),
(11, 17, 1, 45.00),
(12, 7,  1, 32.00),
(13, 18, 1,  7.50),
(14, 20, 1, 14.90),
(15, 21, 1, 19.90),
(16, 12, 1, 12.50),
(17, 22, 1, 12.00),
(18, 23, 1, 21.00),
(19, 1,  1, 39.90),
(20, 3,  1, 24.90),
(21, 2,  1, 42.90),
(22, 4,  1, 29.90),
(23, 5,  1, 28.50),
(24, 8,  1, 27.50),
(25, 23, 1, 21.00);

-- =====================================================================
-- 9) DELIVERYPERSONNEL (20 linhas)
-- OrderDetailID fica NULL para entregadores disponíveis, ainda sem
-- entrega associada no momento.
-- =====================================================================
INSERT INTO DeliveryPersonnel (OrderDetailID, FirstName, LastName, BirthDate, LegalCode, Photo) VALUES
(1,  'Marcos',    'Vinícius', '2003-04-12', '44455566601', NULL),
(2,  'Renata',    'Alves',    '2000-08-23', '44455566602', NULL),
(3,  'Felipe',    'Cardozo',  '1995-01-05', '44455566603', NULL),
(4,  'Juliana',   'Prado',    '1997-11-30', '44455566604', NULL),
(5,  'Rodrigo',   'Melo',     '1990-06-17', '44455566605', NULL),
(6,  'Camila',    'Duarte',   '1985-09-09', '44455566606', NULL),
(7,  'André',     'Luiz',     '2001-02-14', '44455566607', NULL),
(8,  'Patrícia',  'Nogueira', '1996-07-21', '44455566608', NULL),
(9,  'Vinícius',  'Tavares',  '1992-03-03', '44455566609', NULL),
(10, 'Aline',     'Batista',  '1998-12-25', '44455566610', NULL),
(11, 'Gustavo',   'Freitas',  '1994-05-19', '44455566611', NULL),
(12, 'Bianca',    'Ramos',    '1999-10-02', '44455566612', NULL),
(13, 'Eduardo',   'Pinto',    '1987-01-27', '44455566613', NULL),
(14, 'Larissa',   'Monteiro', '2002-04-08', '44455566614', NULL),
(15, 'Tiago',     'Fonseca',  '1980-06-30', '44455566615', NULL),
(NULL,'Vanessa',  'Cunha',    '1989-08-15', '44455566616', NULL),
(NULL,'Leonardo', 'Farias',   '1997-02-22', '44455566617', NULL),
(NULL,'Priscila', 'Andrade',  '2001-09-11', '44455566618', NULL),
(NULL,'Rafael',   'Souza',    '1993-11-04', '44455566619', NULL),
(NULL,'Débora',   'Lopes',    '1991-03-28', '44455566620', NULL);

-- =====================================================================
-- 10) VEHICLES (20 linhas — 1 por entregador)
-- ActiveStage é explicitado para mostrar alguns veículos inativos
-- (manutenção); nos demais, o valor coincide com o DEFAULT (TRUE).
-- Note fica NULL quando não há observação registrada.
-- =====================================================================
INSERT INTO Vehicles (PersonID, Model, Plate, Note, ActiveStage) VALUES
(1,  'Honda CG 160',      'ABC1234', 'Moto para entregas rápidas.',   TRUE),
(2,  'Yamaha Factor 125', 'ABC1235', NULL,                             TRUE),
(3,  'Honda Biz 110',     'ABC1236', 'Baú de entrega instalado.',     TRUE),
(4,  'Fiat Mobi',         'ABC1237', 'Carro para pedidos grandes.',   TRUE),
(5,  'Honda CG 160',      'ABC1238', NULL,                             TRUE),
(6,  'Yamaha Fazer 250',  'ABC1239', NULL,                             TRUE),
(7,  'Honda Biz 110',     'ABC1240', 'Baú térmico.',                  TRUE),
(8,  'Bicicleta Caloi',   'ABC1241', 'Entregas de curta distância.',  TRUE),
(9,  'Honda CG 160',      'ABC1242', NULL,                             TRUE),
(10, 'Yamaha Factor 125', 'ABC1243', NULL,                             TRUE),
(11, 'Fiat Mobi',         'ABC1244', NULL,                             TRUE),
(12, 'Honda Biz 110',     'ABC1245', 'Baú de entrega instalado.',     TRUE),
(13, 'Yamaha Fazer 250',  'ABC1246', NULL,                             TRUE),
(14, 'Bicicleta Caloi',   'ABC1247', NULL,                             TRUE),
(15, 'Honda CG 160',      'ABC1248', NULL,                             TRUE),
(16, 'Yamaha Factor 125', 'ABC1249', NULL,                             TRUE),
(17, 'Honda Biz 110',     'ABC1250', NULL,                             TRUE),
(18, 'Fiat Mobi',         'ABC1251', 'Em manutenção.',                FALSE),
(19, 'Honda CG 160',      'ABC1252', 'Em manutenção.',                FALSE),
(20, 'Yamaha Fazer 250',  'ABC1253', 'Aguardando revisão.',           FALSE);

USE FastBite;

-- !Os comando CALL não irão funcionar por estarem vazios! --

-- 1 SP: Adicionando um novo Restaurante --
DELIMITER //
CREATE PROCEDURE sp_adding_restaurant (
	IN p_restaurant_name VARCHAR(30),
    IN p_restaurant_info VARCHAR(255),
    IN p_phone VARCHAR(11),
    IN p_legal_code VARCHAR(14),
    IN p_restaurant_type VARCHAR(50)
)
BEGIN 
	DECLARE v_verifier INT;
    
    SELECT COUNT(*) INTO v_verifier FROM Restaurants
    WHERE LegalCode = p_legal_code OR Phone = p_phone;
    
    IF (v_verifier != 0) OR (p_restaurant_name IS NULL) OR (p_phone IS NULL) OR (p_legal_code IS NULL) THEN
    
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Algum campo não foi preenchido ou o restaurante já existe!';
        
	ELSEIF (LENGTH(TRIM(p_restaurant_name)) < 5) OR (LENGTH(TRIM(p_phone)) < 11) OR (LENGTH(TRIM(p_legal_code)) < 14) THEN
    
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Algum campo não foi preenchido corretamente!';
        
	ELSE
    
		INSERT INTO Restaurants (RestaurantName, RestaurantInfo, Phone, LegalCode, RestaurantType) VALUES
		(p_restaurant_name, p_restaurant_info, p_phone, p_legal_code, p_restaurant_type);
        
        SELECT RestaurantID AS 'ID do Restaurante',
			RestaurantName AS 'Nome do Restaurante',
			RestaurantInfo AS 'Informações',
            Phone AS 'Telefone de Contato',
            LegalCode AS 'CNPJ do Restaurante',
            RestaurantType AS 'Tipo de Restaurante'
		FROM Restaurants
        WHERE RestaurantID = (SELECT MAX(RestaurantID) FROM Restaurants);
        
	END IF;
    
END //
DELIMITER ;
-- Insira as informações dentro dos parênteses()! --
CALL sp_adding_restaurant ();

-- x -- x -- x -- x -- x -- x -- x --

-- 2 SP: Adicionando produto na tabela
DELIMITER //
CREATE PROCEDURE sp_adding_product (
	IN p_product_name VARCHAR(20),
    IN p_product_info VARCHAR(100),
    IN p_product_type VARCHAR(15),
    IN p_price DECIMAL(10, 2)
)
BEGIN
	IF (p_product_name IS NULL) OR (p_price IS NULL) OR (p_price <= 0) THEN
    
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O produto não tem informações obrigatórias ou seu preço é menor que zero!';
        
	ELSEIF LENGTH(TRIM(p_product_name)) < 3 THEN
    
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O produto não tem informações obrigatórias ou o nome do produto é pequeno demais!';
        
	ELSE
    
		INSERT INTO Products (ProductName, ProductInfo, ProductType, Price) VALUES
        (p_product_name, p_product_info, p_product_type, p_price);
        
        SELECT ProductID AS 'ID do Produto',
			ProductName AS 'Nome do Produto',
            ProductInfo AS 'Informação do Produto',
            ProductType AS 'Tipo de Produto',
            Price AS 'Preço do Produto',
            RegisterDate AS 'Data do Registro'
		FROM Products
        WHERE ProductID = (SELECT MAX(ProductID) FROM Products);
        
	END IF;
    
END //
DELIMITER ;
-- Insira as informações dentro dos parênteses()! --
CALL sp_adding_product ();

-- x -- x -- x -- x -- x -- x -- x --

-- 3 SP: Alterado preço de um produto existente --
DELIMITER //
CREATE PROCEDURE sp_changing_product_price (
	IN p_product_id INT,
    IN p_new_price DECIMAL(10, 2)
)
BEGIN
	DECLARE v_verifier INT;
    
    IF (p_product_id IS NULL) OR (p_new_price IS NULL) THEN
    
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O ID do produto ou o novo preço estão vazios!';
        
	END IF;
    
    SELECT COUNT(*) INTO v_verifier FROM Products
    WHERE ProductID = p_product_id;
    
    IF v_verifier = 0 THEN
    
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nenhum produto dentro do sistema pertence a esse ID!';
        
	ELSE
    
        UPDATE Products
		SET Price = p_new_price
        WHERE ProductID = p_product_id;
        
        SELECT ProductID AS 'ID do Produto',
			ProductName AS 'Nome do Produto',
            Price AS 'Preço do Produto',
            RegisterDate AS 'Data de Registro',
            PriceChangeDate AS 'Última data de alteração de preço'
		FROM Products
        WHERE ProductID = p_product_id;
        
	END IF;
    
END //
DELIMITER ;
-- Insira as informações dentro dos parênteses()! --
CALL sp_changing_product_price();
-- Select para os produtos gerais : --
SELECT ProductID AS 'ID', 
	ProductName AS 'Nome', 
    Price AS 'Preço', 
    RegisterDate AS 'Data de Registro', 
    PriceChangeDate AS 'Data de alteração do preço' 
FROM Products;

-- x -- x -- x -- x -- x -- x -- x --

-- 4 SP: Alterando endereço do usuário --
DELIMITER //
CREATE PROCEDURE sp_changing_user_address (
	IN p_user_id INT,
    IN p_user_email VARCHAR(300),
    IN p_street VARCHAR(50),
    IN p_street_number VARCHAR(15),
    IN p_district VARCHAR(50),
    IN p_postal_code VARCHAR(8),
    IN p_city VARCHAR(50),
    IN p_complement VARCHAR(255)
)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		ROLLBACK;
	END;
    
	IF (p_user_id IS NULL) OR (p_user_email IS NULL) THEN
    
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'A informação do ID e E-mail são obrigatórios!';
        
	END IF;
    
    START TRANSACTION;
    
	UPDATE UsersAddress AS UA
    INNER JOIN Users AS U
    ON U.UserID = UA.UserID
    SET
		UA.Street = COALESCE(NULLIF(TRIM(p_street), ''), UA.Street),
        UA.StreetNumber = COALESCE(NULLIF(TRIM(p_street_number), ''), UA.StreetNumber),
        UA.District = COALESCE(NULLIF(TRIM(p_district), ''), UA.District),
        UA.PostalCode = COALESCE(NULLIF(TRIM(p_postal_code), ''), UA.PostalCode),
        UA.City = COALESCE(NULLIF(TRIM(p_city), ''), UA.City),
        UA.Complement = COALESCE(NULLIF(TRIM(p_complement), ''), UA.Complement)
	WHERE UA.UserID = p_user_id AND U.Email = p_user_email;
    
    COMMIT;
    
    SELECT Users.UserID AS 'ID do usuário',
		CONCAT(Users.FirstName, ' ', Users.LastName) AS 'Nome do Usuário',
        Users.Email AS 'E-mail do usuário',
        UsersAddress.Street AS 'Rua',
        UsersAddress.StreetNumber AS 'Número',
        UsersAddress.District AS 'Bairro',
        UsersAddress.PostalCode AS 'CEP',
        UsersAddress.Complement AS 'Complemento',
        UsersAddress.AddressChangeDate AS 'Data da última alteração'
	FROM Users
    INNER JOIN UsersAddress
    ON Users.UserID = UsersAddress.UserID
    WHERE Users.UserID = p_user_id;
    
END //
DELIMITER ;
-- Insira as informações dentro dos parênteses()! --
CALL sp_changing_user_address();

-- x -- x -- x -- x -- x -- x -- x --

-- 1 TRG : Log sobre o preço dos produtos --
DELIMITER //
CREATE TRIGGER trg_product_price_log
AFTER UPDATE
ON Products
FOR EACH ROW
BEGIN
	INSERT INTO LogProduct (OldPrice, NewPrice) VALUES
    (OLD.Price, NEW.Price);
END //
DELIMITER ;
-- Abrir o Log --
SELECT LogID AS 'ID do Log',
	OldPrice AS 'Antigo preço',
    NewPrice AS 'Novo preço',
    Difference AS 'Diferença',
    ChangeDate AS 'Data da alteração'
FROM LogProduct;

-- x -- x -- x -- x -- x -- x -- x --

-- 2 TRG : Diminuindo quantidade e desativando cupons --
DELIMITER //
CREATE TRIGGER trg_auto_decreasing_coupon
AFTER INSERT
ON Orders
FOR EACH ROW
BEGIN
	UPDATE Coupons
    SET
		Quantity = Quantity - 1
	WHERE CouponID = NEW.CouponID AND Quantity > 0;
    
    UPDATE Coupons
    SET
		Avaliability = FALSE
	WHERE CouponID = NEW.CouponID AND Quantity <= 0;
END //
DELIMITER ;

-- x -- x -- x -- x -- x -- x -- x --

-- 3 TRG : Impedindo pedidos sem cupom disponível --
DELIMITER //
CREATE TRIGGER trg_orders_coupons_verifier
BEFORE INSERT
ON Orders
FOR EACH ROW
BEGIN
	DECLARE v_quantity INT;
    DECLARE v_avaliability BOOLEAN;
    
    IF NEW.CouponID IS NOT NULL THEN
    
		SELECT Quantity, Avaliability
		INTO v_quantity, v_avaliability
		FROM Coupons
		WHERE CouponID = NEW.CouponID;
		
		IF (v_quantity = 0) OR (v_avaliability = FALSE) THEN
        
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Cupom esgotado ou indisponível.';

        END IF;
        
	END IF;
END //
DELIMITER ;