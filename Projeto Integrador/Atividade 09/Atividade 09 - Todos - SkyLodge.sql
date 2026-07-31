CREATE DATABASE SkyLodge;

USE SkyLodge;

CREATE TABLE clients (
	client_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    client_phone VARCHAR(11) NOT NULL,
    legal_code VARCHAR(11) NOT NULL,
    CONSTRAINT uk_clients_client_phone
		UNIQUE (client_phone),
	CONSTRAINT uk_clients_legal_code
		UNIQUE (legal_code)
);

CREATE TABLE clients_vehicles (
	vehicle_id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT NOT NULL,
    vehicle_model VARCHAR(25) NOT NULL,
    vehicle_plate VARCHAR(7) NOT NULL,
    CONSTRAINT fk_clients_vehicles_clients
		FOREIGN KEY (client_id) REFERENCES clients (client_id),
	CONSTRAINT uk_clients_vehicles_vehicle_plate
		UNIQUE (vehicle_plate)
);

CREATE TABLE parking (
	parking_id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT,
    parking_number TINYINT UNSIGNED NOT NULL,
    CONSTRAINT fk_parking_clients
		FOREIGN KEY (client_id) REFERENCES clients (client_id),
	CONSTRAINT uk_parking_parking_number
		UNIQUE (parking_number)
);

CREATE TABLE employees (
	employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    employee_phone VARCHAR(11) NOT NULL,
    legal_code VARCHAR(11) NOT NULL,
    CONSTRAINT uk_employees_employee_phone
		UNIQUE (employee_phone),
	CONSTRAINT uk_employees_legal_code
		UNIQUE (legal_code)
);

CREATE TABLE employees_address (
	address_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    street_name VARCHAR(100) NOT NULL,
    street_number VARCHAR(15),
    district_name VARCHAR(50) NOT NULL,
    postal_code VARCHAR(8) NOT NULL,
    city_name VARCHAR(50) NOT NULL,
    complement VARCHAR(255),
    CONSTRAINT fk_employees_address_employees
		FOREIGN KEY (employee_id) REFERENCES employees (employee_id)
);

CREATE TABLE checks (
	check_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    client_id INT NOT NULL,
    check_in_time DATE DEFAULT (CURRENT_DATE()) NOT NULL,
    check_out_time DATE,
    check_in_status BOOLEAN DEFAULT (TRUE) NOT NULL,
    check_out_status BOOLEAN DEFAULT (FALSE) NOT NULL,
    CONSTRAINT fk_checks_employees
		FOREIGN KEY (employee_id) REFERENCES employees (employee_id),
	CONSTRAINT fk_checks_clients
		FOREIGN KEY (client_id) REFERENCES clients (client_id),
	CONSTRAINT uk_checks_client_id
		UNIQUE (client_id)
);

CREATE TABLE products (
	product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(30) NOT NULL,
    product_type VARCHAR(20) NOT NULL,
    product_information VARCHAR(100) NOT NULL,
    product_price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL,
    CONSTRAINT ck_products_product_price
		CHECK (product_price > 0),
	CONSTRAINT ck_products_quantity
		CHECK (quantity >= 0)
);

CREATE TABLE minibars (
	minibar_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    quantity_product INT NOT NULL,
    minibar_model VARCHAR(30),
    minibar_availiability BOOLEAN DEFAULT (FALSE) NOT NULL,
    CONSTRAINT fk_minibars_products
		FOREIGN KEY (product_id) REFERENCES products (product_id),
	CONSTRAINT ck_minibars_quantity_product
		CHECK (quantity_product >= 0)
);

CREATE TABLE rooms_categories (
	category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(30) NOT NULL,
    category_type VARCHAR(20) NOT NULL,
    category_information VARCHAR(255),
    CONSTRAINT uk_rooms_categories_category_name
		UNIQUE (category_name),
	CONSTRAINT uk_rooms_categories_category_type
		UNIQUE (category_type)
);

CREATE TABLE rooms (
	room_id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT NOT NULL,
    minibar_id INT NOT NULL,
    check_id INT,
    room_name VARCHAR(50) NOT NULL,
    room_type VARCHAR(30) NOT NULL,
    room_information VARCHAR(255) NOT NULL,
    CONSTRAINT fk_rooms_rooms_categories
		FOREIGN KEY (category_id) REFERENCES rooms_categories (category_id),
	CONSTRAINT fk_rooms_minibars
		FOREIGN KEY (minibar_id) REFERENCES minibars (minibar_id),
	CONSTRAINT fk_rooms_checks
		FOREIGN KEY (check_id) REFERENCES checks (check_id),
	CONSTRAINT uk_rooms_minibar_id
		UNIQUE (minibar_id)
);

ALTER TABLE clients
	ADD COLUMN birth_date DATE NOT NULL;
    
ALTER TABLE clients_vehicles
	ADD COLUMN addtional_information VARCHAR(255);
    
ALTER TABLE parking
	ADD COLUMN availiability BOOLEAN NOT NULL;
    
ALTER TABLE checks
	ADD COLUMN complete_status BOOLEAN DEFAULT (FALSE);
    
ALTER TABLE employees
	ADD COLUMN birth_date DATE NOT NULL;

ALTER TABLE employees_address
	ADD COLUMN register_date DATE DEFAULT (CURRENT_DATE()) NOT NULL,
    ADD COLUMN last_modifier_date DATE DEFAULT (CURRENT_DATE()) NOT NULL;
    
ALTER TABLE rooms
	RENAME COLUMN room_price TO room_normal_price,
    ADD COLUMN room_discount_price DECIMAL(10, 2),
    ADD CONSTRAINT ck_rooms_room_discount_price
		CHECK (room_discount_price >= 0);
        
ALTER TABLE minibars
	ADD COLUMN alcoholic_product BOOLEAN NOT NULL;
    
ALTER TABLE products
	ADD COLUMN product_validity DATE NOT NULL;
    
ALTER TABLE rooms_categories
	ADD COLUMN room_quantity TINYINT UNSIGNED NOT NULL;
    
USE SkyLodge;

-- ==========================================
-- 1. CLIENTS (20 registros)
-- ==========================================
INSERT INTO clients (first_name, last_name, client_phone, legal_code, birth_date) VALUES
('Carlos', 'Silva', '11987654321', '12345678901', '1985-04-12'),
('Ana', 'Souza', '11976543210', '23456789012', '1990-08-22'),
('Mariana', 'Oliveira', '21965432109', '34567890123', '1982-12-05'),
('Pedro', 'Santos', '31954321098', '45678901234', '1995-01-30'),
('Juliana', 'Costa', '41943210987', '56789012345', '1988-06-15'),
('Lucas', 'Ferreira', '51932109876', '67890123456', '1992-11-03'),
('Beatriz', 'Rodrigues', '61921098765', '78901234567', '1987-03-25'),
('Gabriel', 'Almeida', '71910987654', '89012345678', '1996-09-18'),
('Larissa', 'Martins', '81909876543', '90123456789', '1991-07-07'),
('Rafael', 'Barbosa', '91998765432', '01234567890', '1984-05-19'),
('Camila', 'Ribeiro', '11988887777', '11223344556', '1993-10-10'),
('Bruno', 'Carvalho', '21977776666', '22334455667', '1989-02-14'),
('Fernanda', 'Gomes', '31966665555', '33445566778', '1994-12-28'),
('Thiago', 'Martins', '41955554444', '44556677889', '1986-08-01'),
('Patrícia', 'Araújo', '51944443333', '55667788990', '1997-04-09'),
('Rodrigo', 'Melo', '61933332222', '66778899001', '1983-11-11'),
('Renata', 'Teixeira', '71922221111', '77889900112', '1990-05-20'),
('Marcelo', 'Cavalcanti', '81911110000', '88990011223', '1995-07-16'),
('Vanessa', 'Vieira', '11900009999', '99001122334', '1988-09-30'),
('Diego', 'Cardoso', '21912345678', '10203040506', '1992-03-04');

-- ==========================================
-- 2. CLIENTS_VEHICLES (20 registros)
-- ==========================================
INSERT INTO clients_vehicles (client_id, vehicle_model, vehicle_plate, addtional_information) VALUES
(1, 'Toyota Corolla', 'ABC1D23', 'Carro sedan, cor preta'),
(2, 'Honda Civic', 'XYZ9W87', 'Possui adesivo no vidro traseiro'),
(3, 'Jeep Renegade', 'JKL4M56', 'SUV grande'),
(4, 'Volkswagen T-Cross', 'QWE2R33', NULL),
(5, 'Hyundai Creta', 'ASD4F55', 'Cor branca'),
(6, 'Chevrolet Tracker', 'ZXC7V88', NULL),
(7, 'Fiat Pulse', 'ERT5Y66', 'Veículo alugado'),
(8, 'Nissan Kicks', 'UIO8P99', NULL),
(9, 'Renault Duster', 'HJK1L22', 'Porta-malas cheio de bagagens'),
(10, 'Toyota Hilux', 'BNM3C44', 'Caminhonete cabine dupla'),
(11, 'Ford Ranger', 'VBN6M77', NULL),
(12, 'Chevrolet S10', 'CVB8N99', 'Possui capota marítima'),
(13, 'Jeep Compass', 'ASDF123', NULL),
(14, 'Fiat Toro', 'ZXCV456', 'Cor vermelha'),
(15, 'Volkswagen Nivus', 'QWER789', NULL),
(16, 'Honda HR-V', 'TYUI321', 'Vidros fumês escuros'),
(17, 'Hyundai HB20', 'GHJK654', NULL),
(18, 'Chevrolet Onix', 'BNMK987', 'Carro econômico'),
(19, 'Fiat Argo', 'POIU159', NULL),
(20, 'Renault Kwid', 'LKJH357', 'Veículo compacto');

-- ==========================================
-- 3. PARKING (20 registros)
-- ==========================================
INSERT INTO parking (client_id, parking_number, availiability) VALUES
(1, 10, FALSE),
(2, 11, FALSE),
(3, 12, FALSE),
(4, 13, FALSE),
(5, 14, FALSE),
(6, 15, FALSE),
(7, 16, FALSE),
(8, 17, FALSE),
(9, 18, FALSE),
(10, 19, FALSE),
(NULL, 20, TRUE),
(NULL, 21, TRUE),
(NULL, 22, TRUE),
(NULL, 23, TRUE),
(NULL, 24, TRUE),
(NULL, 25, TRUE),
(NULL, 26, TRUE),
(NULL, 27, TRUE),
(NULL, 28, TRUE),
(NULL, 29, TRUE);

-- ==========================================
-- 4. EMPLOYEES (20 registros)
-- ==========================================
INSERT INTO employees (first_name, last_name, employee_phone, legal_code, birth_date) VALUES
('Cláudia', 'Mendes', '31998881111', '10987654321', '1980-05-10'),
('Roberto', 'Alves', '31988772222', '21098765432', '1985-09-15'),
('Julio', ' César', '31977663333', '32109876543', '1992-02-20'),
('Sandra', 'Lima', '31966554444', '43210987654', '1988-11-30'),
('Marcos', 'Vinicius', '31955445555', '54321098765', '1994-07-04'),
('Eliane', 'Cristina', '31944336666', '65432109876', '1991-03-12'),
('Wagner', 'Souza', '31933227777', '76543210987', '1983-12-25'),
('Tatiane', 'Freitas', '31922118888', '87654321098', '1996-06-08'),
('Leandro', 'Costa', '31911009999', '98765432109', '1989-10-19'),
('Priscila', 'Rocha', '31900998888', '09876543210', '1995-01-17'),
('Fabiano', 'Diniz', '31989898989', '11122233344', '1987-04-22'),
('Daniela', 'Pires', '31978787878', '22233344455', '1993-08-14'),
('Eduardo', 'Moreira', '31967676767', '33344455666', '1982-06-05'),
('Camila', 'Borges', '31956565656', '44455667777', '1990-12-09'),
('Gustavo', 'Kardec', '31945454545', '55566778888', '1986-02-18'),
('Aline', 'Fagundes', '31934343434', '66677889999', '1994-09-27'),
('Luciana', 'Macedo', '31923232323', '77788990000', '1984-07-11'),
('Alexandre', 'Magno', '31912121212', '88899001111', '1991-05-03'),
('Tatiana', 'Bulhões', '31901010101', '99900112222', '1988-10-21'),
('Felipe', 'Campos', '31999887766', '00011223344', '1996-12-15');

-- ==========================================
-- 5. EMPLOYEES_ADDRESS (20 registros)
-- ==========================================
INSERT INTO employees_address (employee_id, street_name, street_number, district_name, postal_code, city_name, complement) VALUES
(1, 'Rua das Flores', '123', 'Centro', '38400100', 'Belo Horizonte', 'Apto 101'),
(2, 'Avenida Brasil', '1500', 'Funcionários', '38400200', 'Belo Horizonte', NULL),
(3, 'Rua da Bahia', '45', 'Savassi', '38400300', 'Belo Horizonte', 'Bloco B'),
(4, 'Rua Goiás', '789', 'Lourdes', '38400400', 'Belo Horizonte', NULL),
(5, 'Avenida Afonso Pena', '2000', 'Centro', '38400500', 'Belo Horizonte', 'Sala 402'),
(6, 'Rua Espírito Santo', '321', 'Centro', '38400600', 'Belo Horizonte', NULL),
(7, 'Rua Tupinambás', '55', 'Centro', '38400700', 'Belo Horizonte', 'Fundos'),
(8, 'Avenida Contorno', '4500', 'Sion', '38400800', 'Belo Horizonte', NULL),
(9, 'Rua Alagoas', '12', 'Boa Viagem', '38400900', 'Belo Horizonte', 'Cobertura'),
(10, 'Rua Curitiba', '999', 'Centro', '38401000', 'Belo Horizonte', NULL),
(11, 'Rua São Paulo', '88', 'Centro', '38401100', 'Belo Horizonte', 'Apto 203'),
(12, 'Avenida Amazonas', '3000', 'Prado', '38401200', 'Belo Horizonte', NULL),
(13, 'Rua Rio de Janeiro', '412', 'Centro', '38401300', 'Belo Horizonte', 'Loja 3'),
(14, 'Rua dos Tamoios', '77', 'Centro', '38401400', 'Belo Horizonte', NULL),
(15, 'Rua dos Guajajaras', '505', 'Centro', '38401500', 'Belo Horizonte', 'Bloco A'),
(16, 'Avenida Raja Gabaglia', '2200', 'Estoril', '38401600', 'Belo Horizonte', NULL),
(17, 'Rua Prudente de Morais', '333', 'Santo Antônio', '38401700', 'Belo Horizonte', 'Casa 2'),
(18, 'Rua do Ouro', '101', 'Serra', '38401800', 'Belo Horizonte', NULL),
(19, 'Avenida do Contorno', '8800', 'Barro Preto', '38401900', 'Belo Horizonte', 'Conjunto 50'),
(20, 'Rua Carijós', '65', 'Centro', '38402000', 'Belo Horizonte', NULL);

-- ==========================================
-- 6. CHECKS (20 registros)
-- ==========================================
INSERT INTO checks (employee_id, client_id, check_in_time, check_out_time, check_in_status, check_out_status, complete_status) VALUES
(1, 1, '2026-06-01', '2026-06-05', TRUE, TRUE, TRUE),
(2, 2, '2026-06-02', '2026-06-06', TRUE, TRUE, TRUE),
(3, 3, '2026-06-03', '2026-06-07', TRUE, TRUE, TRUE),
(4, 4, '2026-06-04', '2026-06-08', TRUE, TRUE, TRUE),
(5, 5, '2026-06-05', '2026-06-09', TRUE, TRUE, TRUE),
(6, 6, '2026-06-06', '2026-06-10', TRUE, TRUE, TRUE),
(7, 7, '2026-06-07', '2026-06-11', TRUE, TRUE, TRUE),
(8, 8, '2026-06-08', '2026-06-12', TRUE, TRUE, TRUE),
(9, 9, '2026-06-09', '2026-06-13', TRUE, TRUE, TRUE),
(10, 10, '2026-06-10', '2026-06-14', TRUE, TRUE, TRUE),
(11, 11, '2026-06-11', NULL, TRUE, FALSE, FALSE),
(12, 12, '2026-06-12', NULL, TRUE, FALSE, FALSE),
(13, 13, '2026-06-13', NULL, TRUE, FALSE, FALSE),
(14, 14, '2026-06-14', NULL, TRUE, FALSE, FALSE),
(15, 15, '2026-06-15', NULL, TRUE, FALSE, FALSE),
(16, 16, '2026-06-16', NULL, TRUE, FALSE, FALSE),
(17, 17, '2026-06-17', NULL, TRUE, FALSE, FALSE),
(18, 18, '2026-06-18', NULL, TRUE, FALSE, FALSE),
(19, 19, '2026-06-19', NULL, TRUE, FALSE, FALSE),
(20, 20, '2026-06-20', NULL, TRUE, FALSE, FALSE);

-- ==========================================
-- 7. PRODUCTS (20 registros)
-- ==========================================
INSERT INTO products (product_name, product_type, product_information, product_price, quantity, product_validity) VALUES
('Água Mineral 500ml', 'Bebida', 'Água sem gás gelada', 5.00, 150, '2027-12-31'),
('Refrigerante Cola', 'Bebida', 'Lata 350ml', 7.50, 100, '2027-06-30'),
('Suco de Laranja', 'Bebida', 'Natural 300ml', 9.00, 50, '2026-07-15'),
('Cerveja Pilsen', 'Bebida', 'Lata 350ml', 10.00, 80, '2027-10-10'),
('Vinho Tinto Seco', 'Bebida', 'Garrafa 750ml', 65.00, 30, '2030-01-01'),
('Chocolate ao Leite', 'Snack', 'Barra 90g', 8.50, 60, '2027-03-20'),
('Batata Frita Salgadinho', 'Snack', 'Pacote 50g', 9.00, 90, '2027-02-10'),
('Amendoim Japanese', 'Snack', 'Pacote 100g', 6.00, 70, '2027-05-15'),
('Sanduíche Natural', 'Alimento', 'Frango com maionese', 15.00, 20, '2026-07-01'),
('Barra de Cereal', 'Snack', 'Aveia e Mel', 4.50, 120, '2027-08-30'),
('Energético', 'Bebida', 'Lata 473ml', 14.00, 50, '2027-11-11'),
('Chá Gelado', 'Bebida', 'Lata 300ml', 6.50, 40, '2027-04-05'),
('Biscoito Recheado', 'Snack', 'Pacote 140g', 5.50, 85, '2027-09-12'),
('Castanha de Caju', 'Snack', 'Pacote 80g', 18.00, 40, '2028-01-15'),
('Espumante Brut', 'Bebida', 'Garrafa 750ml', 85.00, 25, '2032-05-05'),
('Gatorade', 'Bebida', 'Garrafa 500ml', 8.00, 60, '2027-07-22'),
('Balas de Goma', 'Snack', 'Pacote pequeno', 4.00, 100, '2028-03-10'),
('Água Tônica', 'Bebida', 'Lata 350ml', 6.00, 50, '2027-10-20'),
('Café Solúvel', 'Alimento', 'Sachê individual', 3.50, 150, '2029-01-01'),
('Mix de Castanhas', 'Snack', 'Pacote 100g', 20.00, 35, '2028-06-18');

-- ==========================================
-- 8. MINIBARS (20 registros)
-- ==========================================
INSERT INTO minibars (product_id, quantity_product, minibar_model, minibar_availiability, alcoholic_product) VALUES
(1, 4, 'Brastemp Compact', TRUE, FALSE),
(2, 3, 'Brastemp Compact', TRUE, FALSE),
(5, 2, 'Consul Flex', TRUE, TRUE),
(4, 4, 'Consul Flex', TRUE, TRUE),
(9, 2, 'Midea Mini', TRUE, FALSE),
(6, 3, 'Midea Mini', TRUE, FALSE),
(3, 2, 'Brastemp Compact', TRUE, FALSE),
(7, 3, 'Brastemp Compact', TRUE, FALSE),
(11, 2, 'Electrolux Small', TRUE, FALSE),
(10, 4, 'Electrolux Small', TRUE, FALSE),
(14, 2, 'Consul Flex', TRUE, FALSE),
(15, 1, 'Consul Flex', TRUE, TRUE),
(16, 3, 'Midea Mini', TRUE, FALSE),
(8, 2, 'Midea Mini', TRUE, FALSE),
(12, 3, 'Brastemp Compact', TRUE, FALSE),
(13, 2, 'Brastemp Compact', TRUE, FALSE),
(17, 4, 'Electrolux Small', TRUE, FALSE),
(18, 2, 'Electrolux Small', TRUE, FALSE),
(19, 5, 'Midea Mini', TRUE, FALSE),
(20, 2, 'Consul Flex', TRUE, FALSE);

-- ==========================================
-- 9. ROOMS_CATEGORIES (20 registros)
-- ==========================================
INSERT INTO rooms_categories (category_name, category_type, category_information, room_quantity) VALUES
('Standard Solteiro', 'Solteiro', 'Quarto básico com uma cama de solteiro', 5),
('Standard Casal', 'Casal', 'Quarto básico com uma cama de casal', 8),
('Luxo Solteiro', 'Solteiro', 'Quarto superior com cama de solteiro e vista', 4),
('Luxo Casal', 'Casal', 'Quarto superior com cama queen size', 10),
('Suíte Master', 'Suíte', 'Suíte completa com hidromassagem e king size', 3),
('Suíte Presidencial', 'Suíte', 'Maior suíte do hotel com duplex e mordomo', 1),
('Economic Solteiro', 'Solteiro', 'Opção econômica com ventilador de teto', 6),
('Economic Casal', 'Casal', 'Opção econômica para casais sem frescura', 6),
('Família Standard', 'Família', 'Quarto com uma cama de casal e duas de solteiro', 4),
('Família Luxo', 'Família', 'Quarto familiar amplo com duas suítes integradas', 3),
('Bangalô Simples', 'Bangalô', 'Bangalô rústico próximo à natureza', 2),
('Bangalô Luxo', 'Bangalô', 'Bangalô com piscina privativa e deck', 2),
('Loft Executivo', 'Loft', 'Quarto estilo loft moderno com escritório', 4),
('Studio Comfort', 'Studio', 'Quarto compacto com frigobar e micro-ondas', 5),
('Duplex Master', 'Duplex', 'Quarto de dois andares com vista panorâmica', 2),
('Suíte Romântica', 'Suíte', 'Decoração temática com pétalas e luzes de LED', 3),
('Quarto Acessível', 'Adaptado', 'Totalmente adaptado para PCD com rampas', 4),
('Loft Industrial', 'Loft', 'Estilo moderno rústico urbano', 3),
('Suíte Executiva', 'Suíte', 'Ideal para viagens de negócios de longa duração', 4),
('Bangalô Família', 'Bangalô', 'Bangalô amplo para até 6 pessoas', 2);

-- ==========================================
-- 10. ROOMS (20 registros)
-- ==========================================
INSERT INTO rooms (category_id, minibar_id, check_id, room_name, room_type, room_information, room_normal_price, room_discount_price, room_availiability) VALUES
(1, 1, 1, 'Quarto 101', 'Standard', 'Vista para o jardim interno', 150.00, 135.00, FALSE),
(2, 2, 2, 'Quarto 102', 'Standard', 'Próximo à recepção', 180.00, 160.00, FALSE),
(3, 3, 3, 'Quarto 103', 'Luxo', 'Vista parcial para a montanha', 250.00, 220.00, FALSE),
(4, 4, 4, 'Quarto 104', 'Luxo', 'Cama King Size muito confortável', 300.00, 270.00, FALSE),
(5, 5, 5, 'Suíte 201', 'Suíte', 'Hidromassagem dupla e varanda ampla', 550.00, 499.00, FALSE),
(6, 6, 6, 'Suíte Presidencial 301', 'Suíte', 'Andar exclusivo com segurança privada', 1200.00, 1100.00, FALSE),
(1, 7, 7, 'Quarto 105', 'Standard', 'Silencioso e aconchegante', 150.00, NULL, FALSE),
(2, 8, 8, 'Quarto 106', 'Standard', 'Próximo à área de lazer', 180.00, NULL, FALSE),
(3, 9, 9, 'Quarto 107', 'Luxo', 'Sol da manhã na janela', 250.00, 230.00, FALSE),
(4, 10, 10, 'Quarto 108', 'Luxo', 'Smart TV 55 polegadas', 300.00, NULL, FALSE),
(5, 11, 11, 'Suíte 202', 'Suíte', 'Roupões de algodão egípcio inclusos', 550.00, 500.00, TRUE),
(1, 12, 12, 'Quarto 109', 'Standard', 'Localização central no corredor', 150.00, NULL, TRUE),
(2, 13, 13, 'Quarto 110', 'Standard', 'Ambiente climatizado', 180.00, 165.00, TRUE),
(3, 14, 14, 'Quarto 111', 'Luxo', 'Decoração contemporânea', 250.00, NULL, TRUE),
(4, 15, 15, 'Quarto 112', 'Luxo', 'Banheiro com duas pias', 300.00, 280.00, TRUE),
(5, 16, 16, 'Suíte 203', 'Suíte', 'Lareira elétrica na sala de estar', 600.00, 550.00, TRUE),
(1, 17, 17, 'Quarto 113', 'Standard', 'Ideal para estadias curtas', 150.00, NULL, TRUE),
(2, 18, 18, 'Quarto 114', 'Standard', 'Boa iluminação natural', 180.00, NULL, TRUE),
(3, 19, 19, 'Quarto 115', 'Luxo', 'Varanda com espreguiçadeiras', 270.00, 240.00, TRUE),
(4, 20, 20, 'Quarto 116', 'Luxo', 'Isolamento acústico reforçado', 310.00, NULL, TRUE);

USE SkyLodge;

-- !Os comando CALL não irão funcionar por estarem vazios! --

-- 1 SP: adicionar um novo cliente ao check-in --
DELIMITER //
CREATE PROCEDURE sp_adding_new_check_in (
	IN p_employee_id INT,
    IN p_client_id INT,
    IN p_room_id INT
)
BEGIN
	DECLARE v_employee_verifier INT;
    DECLARE v_client_verifier INT;
    DECLARE v_room_verifier INT;
    
    IF (p_employee_id IS NOT NULL) AND (p_client_id IS NOT NULL) AND (p_room_id IS NOT NULL) THEN
		
        SELECT COUNT(*) INTO v_employee_verifier FROM employees
        WHERE employee_id = p_employee_id;
        
        SELECT COUNT(*) INTO v_client_verifier FROM clients
        WHERE client_id = p_client_id;
        
        SELECT COUNT(*) INTO v_room_verifier FROM rooms
        WHERE room_id = p_room_id AND room_availiability = TRUE;
        
        IF (v_employee_verifier = 1) AND (v_client_verifier = 1) AND (v_room_verifier = 1) THEN
        
			INSERT INTO checks (employee_id, client_id) VALUES
            (p_employee_id, p_client_id);
            
            UPDATE rooms
            SET
				check_id = LAST_INSERT_ID(),
                room_availiability = FALSE
			WHERE room_id = p_room_id;
		
        ELSE
			
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'O funcionário e/ou cliente não existem. O quarto pode não existir ou está indisponível.';
		
        END IF;
        
	ELSE
    
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Os parâmetros não podem ser null.';
            
	END IF;
        
END //
DELIMITER ;
-- Coloque as informações dentro dos parênteses()! --
CALL sp_adding_new_check_in();

-- x -- x -- x -- x -- x -- x -- x -- x -- x --


-- 2 SP: fazendo o check-out --
DELIMITER //
CREATE PROCEDURE sp_realize_check_out (
    IN p_check_id INT,
    IN p_room_id INT
)
BEGIN
    DECLARE v_check_verifier INT;

	IF (p_check_id IS NOT NULL) AND (p_room_id IS NOT NULL) THEN
    
		SELECT COUNT(*) INTO v_check_verifier FROM checks 
		WHERE check_id = p_check_id AND check_out_status = FALSE;

			IF v_check_verifier = 1 THEN

				UPDATE checks 
				SET 
					check_out_time = CURRENT_DATE(),
					check_out_status = TRUE,
					complete_status = TRUE
				WHERE check_id = p_check_id;
				
				UPDATE rooms 
				SET 
					check_id = NULL,
					room_availiability = TRUE
				WHERE room_id = p_room_id;
                
			ELSE
            
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Check-in não encontrado ou este check já foi finalizado.';
                
			END IF;
            
	ELSE
    
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Os parâmetros não podem ser null.';
        
	END IF;
END //
DELIMITER ;
-- Coloque as informações dentro dos parênteses()! --
CALL sp_realize_check_out();

-- x -- x -- x -- x -- x -- x -- x -- x -- x --

-- 3 SP: aplicador de descontos nas categorias --
DELIMITER //
CREATE PROCEDURE sp_apply_category_discount (
    IN p_category_id INT,
    IN p_discount_percentage DECIMAL(5,2)
)
BEGIN
    DECLARE v_category_verifier INT;

    SELECT COUNT(*) INTO v_category_verifier FROM rooms_categories 
    WHERE category_id = p_category_id;

    IF v_category_verifier = 1 THEN
    
        UPDATE rooms 
        SET room_discount_price = room_normal_price - (room_normal_price * (p_discount_percentage / 100))
        WHERE category_id = p_category_id;
        
    ELSE
    
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'A categoria de quarto informada não existe.';
        
    END IF;
    
END //
DELIMITER ;
-- Coloque as informações dentro dos parênteses()! --
CALL sp_apply_category_discount();

-- x -- x -- x -- x -- x -- x -- x -- x -- x --

-- 4 SP: relatório do estacionamento --
DELIMITER //
CREATE PROCEDURE sp_parking_status_report ()
BEGIN
    SELECT 
        p.parking_number AS 'Número da vaga',
        IF(p.availiability, 'Disponível', 'Em uso') AS 'Disponibilidade',
        IFNULL(CONCAT(c.first_name, ' ', c.last_name), 'Sem Cliente') AS 'Cliente'
    FROM parking p
    LEFT JOIN clients c ON p.client_id = c.client_id
    ORDER BY p.parking_number ASC;
    
END //
DELIMITER ;
CALL sp_parking_status_report();

-- x -- x -- x -- x -- x -- x -- x -- x -- x --

-- 1 TRG: Impedindo funcionários menores de idade --
DELIMITER //
CREATE TRIGGER trg_check_employee_age
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    IF TIMESTAMPDIFF(YEAR, NEW.birth_date, CURRENT_DATE()) < 18 THEN
    
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O funcionário deve ser maior de idade.';
        
    END IF;
    
END //
DELIMITER ;

-- x -- x -- x -- x -- x -- x -- x -- x -- x --

-- 2 TRG: Atualizando status da vaga do estacionamento --
DELIMITER //
CREATE TRIGGER trg_auto_parking_status
BEFORE INSERT ON parking
FOR EACH ROW
BEGIN
    IF NEW.client_id IS NOT NULL THEN
    
        SET NEW.availiability = FALSE;
        
    ELSE
    
        SET NEW.availiability = TRUE;
        
    END IF;
    
END //
DELIMITER ;

-- x -- x -- x -- x -- x -- x -- x -- x -- x --

-- 3 TRG: Impedindo produtos vencidos --
DELIMITER //
CREATE TRIGGER trg_validate_product_verifier
BEFORE INSERT ON products
FOR EACH ROW
BEGIN
    IF NEW.product_validity < CURRENT_DATE() THEN
    
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Não é permitido cadastrar produtos com data de validade vencida.';
        
    END IF;
    
END //
DELIMITER ;