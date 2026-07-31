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
		UNIQUE (category_name)
);

CREATE TABLE rooms (
	room_id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT NOT NULL,
    minibar_id INT NOT NULL,
    check_id INT,
    room_name VARCHAR(50) NOT NULL,
    room_type VARCHAR(30) NOT NULL,
    room_information VARCHAR(255) NOT NULL,
    room_price DECIMAL(10, 2) NOT NULL,
    room_availiability BOOLEAN NOT NULL,
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