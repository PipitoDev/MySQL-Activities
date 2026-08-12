CREATE DATABASE saude_conecta;

USE saude_conecta;

CREATE TABLE patients (
	patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    gender ENUM('M', 'F', 'O') NOT NULL,
    birth_date DATE NOT NULL,
    legal_code VARCHAR(25) NOT NULL,
    active_status BOOLEAN DEFAULT (TRUE) NOT NULL,
    
    CONSTRAINT uk_patients_legal_code
		UNIQUE (legal_code)
);

CREATE TABLE patients_address (
	address_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    address_type ENUM('Casa', 'Apartamento', 'Outro') NOT NULL,
    street_name VARCHAR(50) NOT NULL,
    street_number VARCHAR(15),
    district_name VARCHAR(50) NOT NULL,
    address_code VARCHAR(8) NOT NULL,
    city_name VARCHAR(30) NOT NULL,
    complement VARCHAR(255),
    
    CONSTRAINT fk_patients_address_patients
		FOREIGN KEY (patient_id) REFERENCES patients (patient_id)
        ON DELETE CASCADE
);

CREATE TABLE doctors (
	doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    gender ENUM('M', 'F', 'O') NOT NULL,
    birth_date DATE NOT NULL,
    legal_code VARCHAR(15) NOT NULL,
    doctor_specialty VARCHAR(50) NOT NULL,
    entry_date DATE DEFAULT (CURRENT_DATE()) NOT NULL,
    active_status BOOLEAN DEFAULT (TRUE) NOT NULL,
    
    CONSTRAINT uk_doctors_legal_code
		UNIQUE (legal_code)
);

CREATE TABLE doctors_address (
	address_id INT AUTO_INCREMENT PRIMARY KEY,
    doctor_id INT NOT NULL,
    address_type ENUM('Casa', 'Apartamento', 'Outro') NOT NULL,
    street_name VARCHAR(50) NOT NULL,
    street_number VARCHAR(15),
    district_name VARCHAR(50) NOT NULL,
    address_code VARCHAR(8) NOT NULL,
    city_name VARCHAR(30) NOT NULL,
    complement VARCHAR(255),
    
    CONSTRAINT fk_doctors_address_doctors
		FOREIGN KEY (doctor_id) REFERENCES doctors (doctor_id)
        ON DELETE CASCADE
);

CREATE TABLE consultations (
	consultation_id INT AUTO_INCREMENT PRIMARY KEY,
    doctor_id INT NOT NULL,
    patient_id INT NOT NULL,
    consultation_type VARCHAR(30) NOT NULL,
    consultation_date DATETIME NOT NULL,
    consultation_note VARCHAR(255),
    consultation_price DECIMAL(10, 2) NOT NULL,
    patient_note TEXT,
    doctor_note TEXT,
    register_date DATETIME DEFAULT (CURRENT_TIMESTAMP()) NOT NULL,
    completion_date DATETIME,
    current_status ENUM('Agendada', 'Cancelada', 'Realizada') DEFAULT ('Agendada') NOT NULL,
    
    CONSTRAINT fk_consultations_doctors
		FOREIGN KEY (doctor_id) REFERENCES doctors (doctor_id)
        ON DELETE RESTRICT,
	CONSTRAINT fk_consultations_patients
		FOREIGN KEY (patient_id) REFERENCES patients (patient_id)
        ON DELETE RESTRICT,
	CONSTRAINT ck_consultations_consultation_price
		CHECK (consultation_price >= 0)
);

CREATE TABLE consultations_result (
	result_id INT AUTO_INCREMENT PRIMARY KEY,
    consultation_id INT NOT NULL,
    consultation_result TEXT NOT NULL,
    
    CONSTRAINT fk_consultations_result_consultations
		FOREIGN KEY (consultation_id) REFERENCES consultations (consultation_id)
        ON DELETE RESTRICT,
	CONSTRAINT uk_consultations_result_consultation_id
		UNIQUE (consultation_id)
);

CREATE TABLE exams (
	exam_id INT AUTO_INCREMENT PRIMARY KEY,
    consultation_id INT NOT NULL,
    exam_name VARCHAR(50) NOT NULL,
    request_date DATETIME DEFAULT (CURRENT_TIMESTAMP()) NOT NULL,
    completion_date DATETIME,
    current_status ENUM('Agendada', 'Cancelada', 'Realizada') DEFAULT ('Agendada') NOT NULL,
    
    CONSTRAINT fk_exams_consultations
		FOREIGN KEY (consultation_id) REFERENCES consultations (consultation_id)
        ON DELETE RESTRICT
);

CREATE TABLE exams_result (
	result_id INT AUTO_INCREMENT PRIMARY KEY,
    exam_id INT NOT NULL,
    exam_result TEXT NOT NULL,
    
    CONSTRAINT fk_exams_result_exams
		FOREIGN KEY (exam_id) REFERENCES exams (exam_id)
        ON DELETE RESTRICT,
	CONSTRAINT uk_exams_result_exam_id
		UNIQUE (exam_id)
);

CREATE TABLE auditoriums (
	auditorium_id INT AUTO_INCREMENT PRIMARY KEY,
    consultation_id INT,
    auditorium_note TEXT NOT NULL,
    register_date DATETIME DEFAULT (CURRENT_TIMESTAMP()) NOT NULL,
    responsible_person VARCHAR(60) NOT NULL,
    
	CONSTRAINT fk_auditoriums_consultations
		FOREIGN KEY (consultation_id) REFERENCES consultations (consultation_id),
	CONSTRAINT uk_aditoriums_consultation_id
		UNIQUE (consultation_id)
);

CREATE TABLE auditoriums_log (
	log_id INT AUTO_INCREMENT PRIMARY KEY,
    auditorium_id INT NOT NULL,
    old_auditorium_note TEXT NOT NULL,
    update_date DATETIME DEFAULT (CURRENT_TIMESTAMP()) NOT NULL,
    responsible_person VARCHAR(60) NOT NULL,
    
    CONSTRAINT fk_auditoriums_log_auditoriums
		FOREIGN KEY (auditorium_id) REFERENCES auditoriums (auditorium_id)
);

USE saude_conecta;

-- Insert foi gerado com IA --
-- ============================================
-- PATIENTS (10 registros)
-- ============================================
INSERT INTO patients (first_name, last_name, gender, birth_date, legal_code, active_status) VALUES
('Ana',      'Oliveira', 'F', '1990-03-12', '123.456.789-00', TRUE),
('Bruno',    'Souza',    'M', '1985-07-25', '234.567.890-11', TRUE),
('Carla',    'Lima',     'F', '1998-11-02', '345.678.901-22', TRUE),
('Daniel',   'Santos',   'M', '1975-01-30', '456.789.012-33', TRUE),
('Elaine',   'Costa',    'F', '2000-05-18', '567.890.123-44', TRUE),
('Fabio',    'Pereira',  'M', '1992-09-09', '678.901.234-55', FALSE),
('Gabriela', 'Almeida',  'F', '1988-12-21', '789.012.345-66', TRUE),
('Hugo',     'Ribeiro',  'M', '1979-04-14', '890.123.456-77', TRUE),
('Isabela',  'Carvalho', 'F', '1995-06-07', '901.234.567-88', TRUE),
('Joao',     'Martins',  'M', '1983-08-23', '012.345.678-99', TRUE);

-- ============================================
-- PATIENTS_ADDRESS (10 registros)
-- ============================================
INSERT INTO patients_address (patient_id, address_type, street_name, street_number, district_name, address_code, city_name, complement) VALUES
(1,  'Casa',         'Rua das Flores',        '120',  'Centro',          '30130010', 'Belo Horizonte', NULL),
(2,  'Apartamento',  'Av. Afonso Pena',       '2500', 'Funcionarios',    '30130007', 'Belo Horizonte', 'Bloco B, apto 302'),
(3,  'Casa',         'Rua Bahia',             '45',   'Lourdes',         '30160011', 'Belo Horizonte', NULL),
(4,  'Outro',        'Rua Rio de Janeiro',    '890',  'Centro',          '30160041', 'Belo Horizonte', 'Sala comercial'),
(5,  'Casa',         'Av. do Contorno',       '3300', 'Santo Agostinho', '30110017', 'Belo Horizonte', NULL),
(6,  'Apartamento',  'Rua Espirito Santo',    '150',  'Centro',          '30160030', 'Belo Horizonte', 'Apto 501'),
(7,  'Casa',         'Rua Sergipe',           '600',  'Savassi',         '30130170', 'Belo Horizonte', NULL),
(8,  'Casa',         'Rua Alagoas',           '75',   'Savassi',         '30130160', 'Belo Horizonte', NULL),
(9,  'Apartamento',  'Av. Cristiano Machado', '4200', 'Cidade Nova',     '31160000', 'Belo Horizonte', 'Bloco 2, apto 101'),
(10, 'Outro',        'Rua Curitiba',          '310',  'Centro',          '30170120', 'Belo Horizonte', NULL);

-- ============================================
-- DOCTORS (10 registros)
-- ============================================
INSERT INTO doctors (first_name, last_name, gender, birth_date, legal_code, doctor_specialty, entry_date, active_status) VALUES
('Marcos',   'Fernandes', 'M', '1970-02-15', 'CRM/MG 11111', 'Cardiologia',    '2015-03-01', TRUE),
('Patricia', 'Gomes',     'F', '1978-06-22', 'CRM/MG 22222', 'Dermatologia',   '2016-07-14', TRUE),
('Rafael',   'Barbosa',   'M', '1982-10-09', 'CRM/MG 33333', 'Ortopedia',      '2017-01-20', TRUE),
('Sandra',   'Teixeira',  'F', '1974-12-03', 'CRM/MG 44444', 'Pediatria',      '2014-09-10', TRUE),
('Thiago',   'Rocha',     'M', '1988-04-27', 'CRM/MG 55555', 'Clinica Geral',  '2019-02-05', TRUE),
('Vanessa',  'Dias',      'F', '1980-08-16', 'CRM/MG 66666', 'Ginecologia',    '2015-11-30', TRUE),
('William',  'Cardoso',   'M', '1976-05-11', 'CRM/MG 77777', 'Neurologia',     '2013-06-18', FALSE),
('Ximena',   'Nogueira',  'F', '1991-01-29', 'CRM/MG 88888', 'Psiquiatria',    '2021-04-12', TRUE),
('Yuri',     'Moreira',   'M', '1985-03-08', 'CRM/MG 99999', 'Endocrinologia', '2018-08-25', TRUE),
('Zelia',    'Pinto',     'F', '1973-07-19', 'CRM/MG 10101', 'Oftalmologia',   '2012-05-03', TRUE);

-- ============================================
-- DOCTORS_ADDRESS (10 registros)
-- ============================================
INSERT INTO doctors_address (doctor_id, address_type, street_name, street_number, district_name, address_code, city_name, complement) VALUES
(1,  'Casa',         'Rua Timbiras',        '1200', 'Centro',          '30140060', 'Belo Horizonte', NULL),
(2,  'Apartamento',  'Av. Getulio Vargas',  '800',  'Funcionarios',    '30112020', 'Belo Horizonte', 'Apto 902'),
(3,  'Casa',         'Rua Pium-i',          '55',   'Serra',           '30220050', 'Belo Horizonte', NULL),
(4,  'Outro',        'Av. Brasil',          '2100', 'Santa Efigenia',  '30140001', 'Belo Horizonte', 'Consultorio'),
(5,  'Casa',         'Rua Grao Para',       '410',  'Santa Efigenia',  '30150340', 'Belo Horizonte', NULL),
(6,  'Apartamento',  'Rua Paraiba',         '650',  'Savassi',         '30130141', 'Belo Horizonte', 'Apto 1201'),
(7,  'Casa',         'Rua Ceara',           '300',  'Santa Efigenia',  '30150311', 'Belo Horizonte', NULL),
(8,  'Casa',         'Av. Bias Fortes',     '900',  'Lourdes',         '30170011', 'Belo Horizonte', NULL),
(9,  'Apartamento',  'Rua Piaui',           '220',  'Funcionarios',    '30150320', 'Belo Horizonte', 'Apto 305'),
(10, 'Outro',        'Rua Goias',           '180',  'Centro',          '30190070', 'Belo Horizonte', 'Consultorio 2');

-- ============================================
-- CONSULTATIONS (10 registros, todas Realizadas para permitir
-- 10 resultados e 10 exames vinculados sem violar constraints)
-- ============================================
INSERT INTO consultations (doctor_id, patient_id, consultation_type, consultation_date, consultation_note, consultation_price, patient_note, doctor_note, completion_date, current_status) VALUES
(1,  1,  'Presencial',   '2026-06-10 09:00:00', 'Consulta de rotina',      250.00, 'Dor no peito ocasional',  'Solicitado ECG',              '2026-06-10 09:40:00', 'Realizada'),
(2,  2,  'Teleconsulta', '2026-06-11 14:30:00', 'Avaliacao de pele',       180.00, 'Mancha na pele',          'Encaminhado para biopsia',    '2026-06-11 15:00:00', 'Realizada'),
(3,  3,  'Presencial',   '2026-06-12 10:15:00', 'Dor no joelho',           220.00, 'Dor ao caminhar',         'Solicitado raio-x',           '2026-06-12 10:50:00', 'Realizada'),
(4,  4,  'Presencial',   '2026-06-15 08:00:00', 'Consulta pediatrica',     200.00, 'Febre ha 2 dias',         'Prescrito antitermico',       '2026-06-15 08:30:00', 'Realizada'),
(5,  5,  'Teleconsulta', '2026-06-16 16:00:00', 'Checkup geral',           150.00, 'Sem queixas relevantes',  'Paciente saudavel',           '2026-06-16 16:20:00', 'Realizada'),
(6,  6,  'Presencial',   '2026-06-18 11:00:00', 'Consulta ginecologica',   240.00, 'Dor abdominal',           'Solicitado ultrassom',        '2026-06-18 11:35:00', 'Realizada'),
(9,  7,  'Presencial',   '2026-06-19 09:30:00', 'Avaliacao hormonal',      260.00, 'Cansaco frequente',       'Solicitado exame de sangue',  '2026-06-19 10:05:00', 'Realizada'),
(10, 8,  'Presencial',   '2026-06-20 13:00:00', 'Consulta oftalmologica',  190.00, 'Visao embacada',          'Prescritos oculos',           '2026-06-20 13:25:00', 'Realizada'),
(1,  9,  'Teleconsulta', '2026-07-02 09:00:00', 'Retorno cardiologico',    150.00, 'Acompanhamento pos-ECG',  'Quadro estavel',              '2026-07-02 09:20:00', 'Realizada'),
(3,  10, 'Presencial',   '2026-07-05 15:00:00', 'Dor no ombro',            220.00, 'Dor apos exercicio',      'Encaminhado para fisioterapia','2026-07-05 15:30:00', 'Realizada');

-- ============================================
-- CONSULTATIONS_RESULT (10 registros, 1 por consulta)
-- ============================================
INSERT INTO consultations_result (consultation_id, consultation_result) VALUES
(1,  'ECG dentro dos parametros normais, sem sinais de arritmia.'),
(2,  'Biopsia solicitada; lesao com aspecto sugestivo de benignidade.'),
(3,  'Raio-x indica leve desgaste na cartilagem, recomendada fisioterapia.'),
(4,  'Quadro compativel com virose comum, sem necessidade de exames adicionais.'),
(5,  'Paciente saudavel, exames de rotina em dia.'),
(6,  'Ultrassom pelvico normal, sem alteracoes relevantes.'),
(7,  'Exame de sangue indicou leve alteracao na tireoide, iniciar acompanhamento.'),
(8,  'Grau de miopia leve, indicado uso de oculos de grau.'),
(9,  'Paciente estavel, sem novas alteracoes cardiacas.'),
(10, 'Tendinite leve no ombro, indicada fisioterapia por 4 semanas.');

-- ============================================
-- EXAMS (10 registros)
-- ============================================
INSERT INTO exams (consultation_id, exam_name, request_date, completion_date, current_status) VALUES
(1, 'Eletrocardiograma (ECG)',    '2026-06-10 09:10:00', '2026-06-10 09:35:00', 'Realizada'),
(2, 'Biopsia de pele',            '2026-06-11 14:40:00', '2026-06-13 10:00:00', 'Realizada'),
(3, 'Raio-x de joelho',           '2026-06-12 10:20:00', '2026-06-12 10:45:00', 'Realizada'),
(4, 'Hemograma completo',         '2026-06-15 08:05:00', '2026-06-15 08:25:00', 'Realizada'),
(5, 'Perfil lipidico',            '2026-06-16 16:05:00', '2026-06-17 09:00:00', 'Realizada'),
(6, 'Ultrassom pelvico',          '2026-06-18 11:05:00', '2026-06-18 11:30:00', 'Realizada'),
(7, 'Exame de tireoide (TSH/T4)', '2026-06-19 09:35:00', '2026-06-19 10:00:00', 'Realizada'),
(8, 'Exame de acuidade visual',   '2026-06-20 13:05:00', '2026-06-20 13:20:00', 'Realizada'),
(9, 'Novo ECG de retorno',        '2026-07-02 09:05:00', '2026-07-02 09:18:00', 'Realizada'),
(10,'Ressonancia do ombro',       '2026-07-05 15:05:00', '2026-07-06 14:00:00', 'Realizada');

-- ============================================
-- EXAMS_RESULT (10 registros)
-- ============================================
INSERT INTO exams_result (exam_id, exam_result) VALUES
(1,  'Ritmo sinusal normal, sem alteracoes eletrocardiograficas.'),
(2,  'Biopsia confirma lesao benigna, sem sinais de malignidade.'),
(3,  'Reducao do espaco articular compativel com desgaste leve.'),
(4,  'Hemograma dentro dos valores de referencia.'),
(5,  'Colesterol LDL levemente elevado, demais valores normais.'),
(6,  'Ultrassom sem alteracoes estruturais no utero e ovarios.'),
(7,  'TSH levemente elevado, T4 dentro da normalidade.'),
(8,  'Acuidade visual reduzida em ambos os olhos, grau -1.5.'),
(9,  'Ritmo cardiaco estavel, sem novas alteracoes.'),
(10, 'Sinais de tendinite no manguito rotador, sem ruptura.');

-- Primeiro Select --
SELECT c.consultation_id AS 'ID da Consulta',
	CONCAT(p.first_name, ' ', p.last_name) AS 'Nome do Paciente',
    c.consultation_date AS 'Data da Consulta',
    CONCAT(d.first_name, ' ', d.last_name) AS 'Nome do Médico',
    d.doctor_specialty AS 'Especialidade do Médico'
FROM consultations c
INNER JOIN patients p 
	ON p.patient_id = c.patient_id
INNER JOIN doctors d
	ON d.doctor_id = c.doctor_id
WHERE c.consultation_date BETWEEN '2026-01-01 00:00:00' AND '2026-12-31 23:59:59';

-- Segundo Select --
SELECT d.doctor_specialty AS 'Especialidade',
	COUNT(c.consultation_id) AS 'Quantidade de Consultas',
    COUNT(DISTINCT d.doctor_id) AS 'Quantidade de Profissionais',
    ROUND(AVG(c.consultation_price), 2) AS 'Valor Médio da Consulta',
    SUM(c.consultation_price) AS 'Valor Total das Consultas'
FROM consultations c 
INNER JOIN doctors d
	ON d.doctor_id = c.doctor_id
GROUP BY d.doctor_specialty
ORDER BY SUM(c.consultation_price) DESC;

-- Terceiro Select --
SELECT d.doctor_id AS 'ID do Médico',
	CONCAT(d.first_name, ' ', d.last_name) AS 'Nome',
    COUNT(c.consultation_id) AS 'Quantidade de Consultas',
    IFNULL(GROUP_CONCAT(c.consultation_date SEPARATOR ' - '), 'Sem consultas') AS 'Data das Consultas'
FROM consultations c
RIGHT JOIN doctors d
	ON d.doctor_id = c.doctor_id
GROUP BY d.doctor_id, d.first_name, d.last_name;

-- View --
CREATE VIEW vw_historico_paciente AS
SELECT p.patient_id AS 'ID do Paciente',
	CONCAT(p.first_name, ' ', p.last_name) AS 'Nome',
    p.legal_code AS 'Código Legal',
    c.consultation_id AS 'ID da Consulta',
    c.consultation_type AS 'Tipo de Consulta',
    d.doctor_specialty AS 'Especialidade',
    CONCAT(d.first_name, ' ', d.last_name) AS 'Profissional Responsável',
    c.consultation_date AS 'Data do atendimento',
    e.exam_id AS 'ID do Exame',
    er.exam_result AS 'Resultado do Exame'
FROM consultations c
INNER JOIN patients p
	ON p.patient_id = c.patient_id
INNER JOIN doctors d
	ON d.doctor_id = c.doctor_id
INNER JOIN exams e
	ON e.consultation_id = c.consultation_id
INNER JOIN exams_result er
	ON er.exam_id = e.exam_id
WHERE c.current_status = 'Realizada'
ORDER BY p.patient_id ASC;

-- Comando para chamar o view --
SELECT * FROM vw_historico_paciente;

-- Trigger --
DELIMITER //
CREATE TRIGGER trg_auditoriums_recovery
AFTER UPDATE
ON auditoriums
FOR EACH ROW
BEGIN
	IF NOT (OLD.auditorium_note <=> NEW.auditorium_note) THEN
		INSERT INTO auditoriums_log (auditorium_id, old_auditorium_note, responsible_person) VALUES
		(NEW.auditorium_id, OLD.auditorium_note, NEW.responsible_person);
	END IF;
END //
DELIMITER ;

-- Criação do Usuário --
CREATE USER 'usuario_gestor'@'localhost' IDENTIFIED BY 'password123';
GRANT SELECT ON saude_conecta.vw_historico_paciente TO 'usuario_gestor'@'localhost';

-- Usando o Start Transaction --
DELIMITER //
CREATE PROCEDURE sp_update_consultation_price (
	IN p_consultation_id INT,
    IN p_new_consultation_price DECIMAL(10, 2)
)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		ROLLBACK;
        SELECT 'Comando cancelado. Algum erro aconteceu.' AS 'Mensagem de Erro';
	END;
    UPDATE consultations
    SET
		consultation_price = p_new_consultation_price
	WHERE consultation_id = p_consultation_id;
    
    COMMIT;
END //
DELIMITER ;
-- Chamar a procedure --
CALL sp_update_consultation_price(1, null);