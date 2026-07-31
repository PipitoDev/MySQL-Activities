USE IronFit;

-- !Os comando CALL não irão funcionar por estarem vazios! --

-- 1 SP: Alterando plano de um membro --
DELIMITER //
CREATE PROCEDURE sp_change_member_plan (
	IN p_legalcode VARCHAR(11),
    IN p_new_plan_name VARCHAR(30)
)
BEGIN
	DECLARE v_member_verifier INT;
    DECLARE v_plan_verifier INT;
    DECLARE v_plan_id INT;
    
    IF (p_legalcode IS NOT NULL) AND (p_new_plan_name IS NOT NULL) THEN
    
		SELECT COUNT(*) INTO v_member_verifier FROM Members
		WHERE LegalCode = p_legalcode;
    
		SELECT COUNT(*) INTO v_plan_verifier FROM Plans
        WHERE PlanName = p_new_plan_name;
        
        IF (v_member_verifier = 1) AND (v_plan_verifier = 1) THEN
			
			SELECT PlanID INTO v_plan_id FROM Plans
            WHERE PlanName = p_new_plan_name;
            
            UPDATE MemberReviews AS MR
            INNER JOIN Members AS M
            ON M.MemberID = MR.MemberID
            SET
				MR.PlanID = v_plan_id
			WHERE M.LegalCode = p_legalcode;
		
        ELSE
			
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'O membro ou o plano inseridos não existem.';
            
		END IF;
	
    ELSE
    
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Alguma ou todas informações obrigatórias estão como null.';
	
    END IF;
    
END //
DELIMITER ;
-- Coloque as informações dentro dos parênteses()! --
CALL sp_changing_member_plan();

-- x -- x -- x -- x -- x -- x -- x -- x -- x --

-- 2 SP: Adicionando novo plano --
DELIMITER //
CREATE PROCEDURE sp_add_new_plan (
	IN p_plan_name VARCHAR(30),
    IN p_plan_type VARCHAR(30),
    IN p_plan_information VARCHAR(200),
    IN p_price DECIMAL(10, 2)
)
BEGIN
	DECLARE v_verifier INT;
    
    IF (p_plan_name IS NOT NULL) AND (p_price IS NOT NULL) THEN
		
        SELECT COUNT(*) INTO v_verifier FROM Plans
        WHERE PlanName = p_plan_name;
        
        IF (v_verifier = 0) AND (p_price > 0) THEN
			
			INSERT INTO Plans (PlanName, PlanType, PlanInformation, OldPrice, NewPrice) VALUES
            (p_plan_name, p_plan_type, p_plan_information, p_price, p_price);
		
			SELECT PlanID AS 'ID do Plano',
				PlanName AS 'Nome do plano',
                PlanType AS 'Tipo do plano',
                PlanInformation AS 'Informação do plano',
                OldPrice AS 'Preço antigo',
                NewPrice AS 'Preço novo'
			FROM Plans
            WHERE PlanID = (SELECT MAX(PlanID) FROM Plans);
            
        ELSE
        
			SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'O nome do plano já existe ou o preço é inválido.';
            
		END IF;
	
    ELSE 
    
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O nome e o preço não podem ser null.';
        
    END IF;
    
END //
DELIMITER ;
-- Coloque as informações dentro dos parênteses()! --
CALL sp_adding_new_plan();

-- x -- x -- x -- x -- x -- x -- x -- x -- x --

-- 3 SP: Alterando o preço de um plano --
DELIMITER //
CREATE PROCEDURE sp_change_plan_price (
	IN p_plan_name VARCHAR(30),
    IN p_new_price DECIMAL(10, 2)
)
BEGIN
	DECLARE v_verifier INT;
    
    IF (p_plan_name IS NOT NULL) AND (p_new_price IS NOT NULL) THEN
		
        SELECT COUNT(*) INTO v_verifier FROM Plans
        WHERE PlanName = p_plan_name;
        
        IF (v_verifier = 1) AND (p_new_price > 0) THEN
        
			UPDATE Plans
            SET
				OldPrice = NewPrice,
                NewPrice = p_new_price
			WHERE PlanName = p_plan_name;
            
            SELECT PlanID AS 'ID do plano',
				PlanName AS 'Nome do plano',
                PlanType AS 'Tipo do plano',
                PlanInformation AS 'Informativo',
                OldPrice AS 'Antigo preço',
                NewPrice AS 'Novo preço'
			FROM Plans
            WHERE PlanName = p_plan_name;
		
        ELSE
			
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Não existe um plano com esse nome, ou o preço novo é inválido.';
		
        END IF;
	
    ELSE
		
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O nome do plano e o novo preço são informações obrigatórias';
	
    END IF;
        
END //
DELIMITER ;
-- Coloque as informações dentro dos parênteses()! --
CALL sp_change_plan_price();

-- x -- x -- x -- x -- x -- x -- x -- x -- x --

-- 4 SP: Removendo um plano --
DELIMITER //
CREATE PROCEDURE sp_remove_plan(
	IN p_plan_id INT,
    IN p_plan_name VARCHAR(30)
)
BEGIN
	DECLARE v_plan_verifier INT;
    DECLARE v_status_verifier INT;
    
    IF (p_plan_id IS NOT NULL) AND (p_plan_name IS NOT NULL) THEN
		
        SELECT COUNT(*) INTO v_plan_verifier FROM Plans
        WHERE PlanID = p_plan_id AND PlanName = p_plan_name;
        
        IF v_plan_verifier = 1 THEN
            
            SELECT COUNT(*) INTO v_status_verifier FROM MemberReviews
            WHERE PlanID = p_plan_id;
            
            IF v_status_verifier = 0 THEN
            
				DELETE FROM Plans
				WHERE PlanID = p_plan_id;
                
			ELSE
            
				SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Há membros ativos com esse plano, não será possível deletar.';
                
			END IF;
            
		ELSE
        
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'O ID e o nome não coincidem ou não existem.';
            
		END IF;
        
	ELSE
		
        SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'O ID e o nome do plano precisam ser informados.';
        
    END IF ;
        
END //
DELIMITER ;
-- Coloque as informações dentro dos parênteses()! --
CALL sp_remove_plan();

-- x -- x -- x -- x -- x -- x -- x -- x -- x --

-- 1 TRG: Trigger para atualizar coluna de data --
DELIMITER //
CREATE TRIGGER trg_update_date_member_address
BEFORE UPDATE
ON MemberAddress
FOR EACH ROW
BEGIN
	SET NEW.LastModifier = CURRENT_DATE();
END //
DELIMITER ;

-- x -- x -- x -- x -- x -- x -- x -- x -- x --

-- 2 TRG: Trigger para atualizar coluna de data(sim, de novo) --
DELIMITER //
CREATE TRIGGER trg_update_date_trainer_address
BEFORE UPDATE
ON TrainerAddress
FOR EACH ROW
BEGIN
	SET NEW.LastModifier = CURRENT_DATE();
END //
DELIMITER ;

-- x -- x -- x -- x -- x -- x -- x -- x -- x --

-- 3 TRG: Verificando e-mail de personal trainer --
DELIMITER //
CREATE TRIGGER trg_email_verifier
BEFORE INSERT
ON PersonalTrainers
FOR EACH ROW
BEGIN
	IF NEW.Email NOT LIKE '%@%' THEN
    
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Formato de e-mail inválido.';
    
	END IF;
END //
DELIMITER ;