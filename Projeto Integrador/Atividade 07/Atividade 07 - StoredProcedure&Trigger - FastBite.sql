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
-- Select para os produtos gerais: --
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