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