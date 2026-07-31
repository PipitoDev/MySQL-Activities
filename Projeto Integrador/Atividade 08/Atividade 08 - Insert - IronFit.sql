USE IronFit;

-- =====================================================================
-- 1) MEMBERS (20 linhas)
-- Email é opcional (UNIQUE, mas aceita NULL) -> 2 membros sem e-mail.
-- =====================================================================
INSERT INTO Members (FirstName, LastName, Email, EntryPassword, LegalCode, Phone) VALUES
('Rafael',        'Andrade',     'rafael.andrade@example.com',      'MEM00001', '11122233301', '31988800001'),
('Beatriz',       'Lima',        'beatriz.lima@example.com',        'MEM00002', '11122233302', '31988800002'),
('Gustavo',       'Rocha',       'gustavo.rocha@example.com',       'MEM00003', '11122233303', '31988800003'),
('Camila',        'Freitas',     NULL,                               'MEM00004', '11122233304', '31988800004'),
('Eduardo',       'Nunes',       'eduardo.nunes@example.com',       'MEM00005', '11122233305', '31988800005'),
('Fernanda',      'Castro',      'fernanda.castro@example.com',     'MEM00006', '11122233306', '31988800006'),
('Henrique',      'Souza',       'henrique.souza@example.com',      'MEM00007', '11122233307', '31988800007'),
('Isabela',       'Martins',     'isabela.martins@example.com',     'MEM00008', '11122233308', '31988800008'),
('João Vitor',    'Alves',       NULL,                               'MEM00009', '11122233309', '31988800009'),
('Karen',         'Silveira',    'karen.silveira@example.com',      'MEM00010', '11122233310', '31988800010'),
('Leonardo',      'Prado',       'leonardo.prado@example.com',      'MEM00011', '11122233311', '31988800011'),
('Mariana',       'Vasconcelos', 'mariana.vasconcelos@example.com', 'MEM00012', '11122233312', '31988800012'),
('Nathan',        'Correia',     'nathan.correia@example.com',      'MEM00013', '11122233313', '31988800013'),
('Olivia',        'Barros',      'olivia.barros@example.com',       'MEM00014', '11122233314', '31988800014'),
('Pedro Henrique','Melo',        'pedro.melo@example.com',          'MEM00015', '11122233315', '31988800015'),
('Queila',        'Ferreira',    'queila.ferreira@example.com',     'MEM00016', '11122233316', '31988800016'),
('Ricardo',       'Tavares',     'ricardo.tavares@example.com',     'MEM00017', '11122233317', '31988800017'),
('Sara',          'Monteiro',    'sara.monteiro@example.com',       'MEM00018', '11122233318', '31988800018'),
('Tiago',         'Ramos',       'tiago.ramos@example.com',         'MEM00019', '11122233319', '31988800019'),
('Vitória',       'Campos',      'vitoria.campos@example.com',      'MEM00020', '11122233320', '31988800020');

-- =====================================================================
-- 2) MEMBERADDRESS (24 linhas — 20 membros + 4 endereços extras)
-- StreetNumber e Complement ficam NULL quando não se aplica.
-- =====================================================================
INSERT INTO MemberAddress (MemberID, Street, StreetNumber, District, PostalCode, City, Complement) VALUES
(1,  'Rua das Palmeiras',     '120', 'Savassi',         '30130000', 'Belo Horizonte', 'Apto 101'),
(2,  'Av. Afonso Pena',       '2200','Centro',          '30130002', 'Belo Horizonte', NULL),
(3,  'Rua Pium-í',            '340', 'Santo Antônio',   '30330030', 'Belo Horizonte', 'Casa 2'),
(4,  'Rua Sergipe',           NULL,  'Funcionários',    '30130170', 'Belo Horizonte', NULL),
(5,  'Av. Amazonas',          '1500','Barro Preto',     '30180001', 'Belo Horizonte', NULL),
(6,  'Rua Bernardo Guimarães','450', 'Santo Agostinho', '30140080', 'Belo Horizonte', 'Fundos'),
(7,  'Rua Curitiba',          '600', 'Centro',          '30170120', 'Belo Horizonte', NULL),
(8,  'Av. do Contorno',       '3300','Floresta',        '30110005', 'Belo Horizonte', NULL),
(9,  'Rua Tomé de Souza',     NULL,  'Savassi',         '30140131', 'Belo Horizonte', 'Apto 302'),
(10, 'Rua Rio de Janeiro',    '210', 'Centro',          '30160041', 'Belo Horizonte', NULL),
(11, 'Av. Cristiano Machado', '5000','Cidade Nova',     '31160000', 'Belo Horizonte', NULL),
(12, 'Rua Grão Pará',         '330', 'Santa Efigênia',  '30150341', 'Belo Horizonte', NULL),
(13, 'Rua Padre Eustáquio',   '1200','Padre Eustáquio', '30720000', 'Belo Horizonte', NULL),
(14, 'Av. Raja Gabáglia',     '2000','Estoril',         '30494000', 'Belo Horizonte', 'Bloco B'),
(15, 'Rua São Paulo',         '900', 'Centro',          '30170131', 'Belo Horizonte', NULL),
(16, 'Rua Ouro Preto',        '410', 'Floresta',        '30150280', 'Belo Horizonte', NULL),
(17, 'Rua Diamantina',        '150', 'Bonfim',          '32017080', 'Contagem',       NULL),
(18, 'Av. Gov. Valadares',    '1000','Centro',          '32010000', 'Contagem',       NULL),
(19, 'Rua das Acácias',       NULL,  'Vila Nova',       '32600000', 'Betim',          NULL),
(20, 'Rua José Bonifácio',    '850', 'Centro',          '34000000', 'Nova Lima',      NULL),
(1,  'Av. Trabalho',          '15',  'Centro',          '30110002', 'Belo Horizonte', 'Escritório'),
(2,  'Rua Alternativa',       '25',  'Funcionários',    '30130171', 'Belo Horizonte', NULL),
(3,  'Av. Secundária',        '35',  'Centro',          '30170121', 'Belo Horizonte', NULL),
(4,  'Rua Nova',              '45',  'Buritis',         '30575060', 'Belo Horizonte', 'Casa dos fundos');

-- =====================================================================
-- 3) PERSONALTRAINERS (20 linhas)
-- =====================================================================
INSERT INTO PersonalTrainers (FirstName, LastName, Email, EntryPassword, LegalCode, Phone) VALUES
('Marcos',    'Teixeira', 'marcos.teixeira@ironfit.com', 'TRN00001', '44455566601', '31977700001'),
('Renata',    'Dias',     'renata.dias@ironfit.com',     'TRN00002', '44455566602', '31977700002'),
('Felipe',    'Nogueira', 'felipe.nogueira@ironfit.com', 'TRN00003', '44455566603', '31977700003'),
('Juliana',   'Rezende',  'juliana.rezende@ironfit.com', 'TRN00004', '44455566604', '31977700004'),
('Rodrigo',   'Assis',    'rodrigo.assis@ironfit.com',   'TRN00005', '44455566605', '31977700005'),
('Camila',    'Duarte',   'camila.duarte@ironfit.com',   'TRN00006', '44455566606', '31977700006'),
('André',     'Lucena',   'andre.lucena@ironfit.com',    'TRN00007', '44455566607', '31977700007'),
('Patrícia',  'Farias',   'patricia.farias@ironfit.com', 'TRN00008', '44455566608', '31977700008'),
('Vinícius',  'Bastos',   'vinicius.bastos@ironfit.com', 'TRN00009', '44455566609', '31977700009'),
('Aline',     'Cardoso',  'aline.cardoso@ironfit.com',   'TRN00010', '44455566610', '31977700010'),
('Gustavo',   'Pires',    'gustavo.pires@ironfit.com',   'TRN00011', '44455566611', '31977700011'),
('Bianca',    'Moraes',   'bianca.moraes@ironfit.com',   'TRN00012', '44455566612', '31977700012'),
('Eduardo',   'Sales',    'eduardo.sales@ironfit.com',   'TRN00013', '44455566613', '31977700013'),
('Larissa',   'Viana',    'larissa.viana@ironfit.com',   'TRN00014', '44455566614', '31977700014'),
('Tiago',     'Andrade',  'tiago.andrade@ironfit.com',   'TRN00015', '44455566615', '31977700015'),
('Vanessa',   'Brito',    'vanessa.brito@ironfit.com',   'TRN00016', '44455566616', '31977700016'),
('Leonardo',  'Costa',    'leonardo.costa@ironfit.com',  'TRN00017', '44455566617', '31977700017'),
('Priscila',  'Reis',     'priscila.reis@ironfit.com',   'TRN00018', '44455566618', '31977700018'),
('Rafael',    'Xavier',   'rafael.xavier@ironfit.com',   'TRN00019', '44455566619', '31977700019'),
('Débora',    'Franco',   'debora.franco@ironfit.com',   'TRN00020', '44455566620', '31977700020');

-- =====================================================================
-- 4) TRAINERADDRESS (20 linhas — 1 por personal trainer)
-- =====================================================================
INSERT INTO TrainerAddress (TrainerID, Street, StreetNumber, District, PostalCode, City, Complement) VALUES
(1,  'Rua A', '10',  'Centro',        '30110010', 'Belo Horizonte', 'Apto 101'),
(2,  'Rua B', '20',  'Savassi',       '30140020', 'Belo Horizonte', NULL),
(3,  'Rua C', '30',  'Floresta',      '30150030', 'Belo Horizonte', 'Casa 2'),
(4,  'Rua D', NULL,  'Buritis',       '30575040', 'Belo Horizonte', NULL),
(5,  'Rua E', '50',  'Cidade Nova',   '31170050', 'Belo Horizonte', 'Bloco B'),
(6,  'Rua F', '60',  'Barreiro',      '30640060', 'Belo Horizonte', NULL),
(7,  'Rua G', '70',  'Pampulha',      '31270070', 'Belo Horizonte', 'Apto 302'),
(8,  'Rua H', '80',  'Santa Efigênia','30150080', 'Belo Horizonte', NULL),
(9,  'Rua I', NULL,  'Gutierrez',     '30441090', 'Belo Horizonte', NULL),
(10, 'Rua J', '100', 'Centro',        '32010100', 'Contagem',       NULL),
(11, 'Rua K', '110', 'Eldorado',      '32310110', 'Contagem',       'Casa 1'),
(12, 'Rua L', '120', 'Centro',        '32600120', 'Betim',          NULL),
(13, 'Rua M', '130', 'Alterosas',     '32677130', 'Betim',          NULL),
(14, 'Rua N', '140', 'Centro',        '34000140', 'Nova Lima',      'Apto 4'),
(15, 'Rua O', NULL,  'Vila Boa Vista','34006150', 'Nova Lima',      NULL),
(16, 'Rua P', '160', 'Centro',        '34500160', 'Sabará',         NULL),
(17, 'Rua Q', '170', 'São Geraldo',   '31035170', 'Belo Horizonte', NULL),
(18, 'Rua R', '180', 'Anchieta',      '30310180', 'Belo Horizonte', 'Casa 3'),
(19, 'Rua S', '190', 'Sion',          '30320190', 'Belo Horizonte', NULL),
(20, 'Rua T', '200', 'Lourdes',       '30180200', 'Belo Horizonte', NULL);

-- =====================================================================
-- 5) PLANS (20 linhas)
-- OldPrice = preço original (era "Price"); NewPrice = preço reajustado
-- atualmente em vigor. PlanInformation fica NULL em alguns registros.
-- =====================================================================
INSERT INTO Plans (PlanName, PlanType, PlanInformation, OldPrice, NewPrice) VALUES
('Musculação Mensal',     'Individual', 'Acesso à sala de musculação.',          400.00, 420.00),
('Musculação Trimestral', 'Individual', NULL,                                    1080.00, 1140.00),
('Emagrecimento Mensal',  'Individual', 'Treino focado em perda de peso.',       360.00, 380.00),
('Ganho de Força Mensal', 'Individual', 'Treino de força com acompanhamento.',   460.00, 480.00),
('Condicionamento Mensal','Individual', NULL,                                    340.00, 360.00),
('Tonificação Mensal',    'Individual', 'Treino de definição muscular.',         330.00, 350.00),
('Crossfit Mensal',       'Grupo',      'Turma em grupo, até 12 alunos.',        170.00, 180.00),
('Pilates Mensal',        'Grupo',      'Turma em grupo, até 10 alunos.',        150.00, 160.00),
('Funcional Mensal',      'Grupo',      NULL,                                    140.00, 150.00),
('Yoga Mensal',           'Grupo',      'Turma em grupo, até 12 alunos.',        130.00, 140.00),
('HIIT Mensal',           'Grupo',      'Turma em grupo, até 10 alunos.',        160.00, 170.00),
('Alongamento Mensal',    'Grupo',      NULL,                                    110.00, 120.00),
('Musculação Anual',      'Individual', 'Plano anual com desconto.',            4200.00, 4400.00),
('Personal Trainer VIP',  'Individual', 'Acompanhamento exclusivo diário.',      800.00, 850.00),
('Avaliação Física',      NULL,         'Sessão avulsa de avaliação.',            60.00,  65.00),
('Aula Experimental',     'Grupo',      'Aula única para novos alunos.',          20.00,  25.00),
('Natação Mensal',        'Individual', NULL,                                    380.00, 400.00),
('Spinning Mensal',       'Grupo',      'Turma em grupo, até 15 alunos.',        150.00, 160.00),
('Reabilitação Mensal',   'Individual', 'Treino orientado por fisioterapeuta.',  420.00, 440.00),
('Combo Musc + Crossfit', 'Individual', 'Musculação e Crossfit combinados.',     520.00, 550.00);

-- =====================================================================
-- 6) MEMBERREVIEWS (20 linhas — 1 avaliação por membro)
-- AdditionalInformation fica NULL quando não há observação extra.
-- =====================================================================
INSERT INTO MemberReviews (MemberID, PlanID, MemberHeight, MemberWeight, BirthDate, Objective, AdditionalInformation) VALUES
(1,  1,  178.00, 82.50, '1995-03-12', 'Hipertrofia',            'Sem restrições médicas.'),
(2,  8,  165.00, 61.00, '1998-07-22', 'Emagrecimento',          NULL),
(3,  4,  182.00, 90.20, '1990-01-05', 'Ganho de força',         'Histórico de lesão no ombro.'),
(4,  10, 160.00, 58.40, '2000-11-30', 'Condicionamento físico', NULL),
(5,  1,  175.00, 75.00, '1993-06-17', 'Hipertrofia',            NULL),
(6,  3,  168.00, 64.80, '1997-09-09', 'Emagrecimento',          'Acompanhamento nutricional externo.'),
(7,  4,  180.00, 88.00, '1988-02-14', 'Ganho de força',         NULL),
(8,  6,  158.00, 55.50, '1999-12-25', 'Tonificação',            NULL),
(9,  5,  176.00, 79.30, '1994-04-08', 'Condicionamento físico', NULL),
(10, 3,  163.00, 62.10, '1996-08-19', 'Emagrecimento',          'Pressão alta controlada com medicação.'),
(11, 13, 185.00, 95.00, '1991-05-27', 'Hipertrofia',            NULL),
(12, 6,  162.00, 59.90, '1999-01-15', 'Tonificação',            NULL),
(13, 4,  179.00, 84.70, '1989-10-02', 'Ganho de força',         NULL),
(14, 3,  159.00, 57.20, '1998-03-21', 'Emagrecimento',          NULL),
(15, 1,  183.00, 91.50, '1992-07-30', 'Hipertrofia',            'Sem restrições médicas.'),
(16, 5,  164.00, 60.30, '2001-09-11', 'Condicionamento físico', NULL),
(17, 4,  177.00, 87.60, '1990-12-04', 'Ganho de força',         NULL),
(18, 6,  157.00, 54.00, '2000-02-28', 'Tonificação',            NULL),
(19, 1,  174.00, 80.80, '1995-11-16', 'Hipertrofia',            'Joelho sensível, evitar impacto alto.'),
(20, 3,  166.00, 63.40, '1997-06-06', 'Emagrecimento',          NULL);

-- =====================================================================
-- 7) GROUPTRAINERS (30 linhas)
-- Quantidade de sessões varia por membro/trainer (alguns membros
-- aparecem em várias turmas, outros em nenhuma). PlanID fica NULL em
-- aulas avulsas sem plano vinculado. Information fica NULL quando não
-- há observação adicional.
-- =====================================================================
INSERT INTO GroupTrainers (MemberID, TrainerID, PlanID, Information, TrainingDate, TrainingTime) VALUES
(2,  7,  7,  'Turma de Crossfit - segunda.',        '2026-06-01', '07:00:00'),
(2,  7,  7,  'Turma de Crossfit - quarta.',         '2026-06-03', '07:00:00'),
(4,  8,  8,  'Turma de Pilates - terça.',           '2026-06-02', '08:00:00'),
(6,  9,  9,  NULL,                                   '2026-06-01', '06:00:00'),
(6,  9,  9,  NULL,                                   '2026-06-03', '06:00:00'),
(6,  9,  9,  'Reposição de aula.',                  '2026-06-05', '06:00:00'),
(8,  10, 10, 'Turma de Yoga - sábado.',             '2026-06-06', '09:00:00'),
(9,  11, 11, 'Turma de HIIT - terça.',              '2026-06-02', '06:30:00'),
(9,  11, 11, 'Turma de HIIT - quinta.',             '2026-06-04', '06:30:00'),
(12, 12, 12, NULL,                                   '2026-06-01', '17:00:00'),
(14, 7,  7,  'Turma de Crossfit - sábado.',         '2026-06-06', '09:00:00'),
(16, 8,  8,  NULL,                                   '2026-06-02', '09:00:00'),
(16, 8,  8,  'Turma de Pilates - quinta.',          '2026-06-04', '09:00:00'),
(18, 9,  9,  'Turma de Funcional - sexta.',         '2026-06-05', '07:00:00'),
(20, 10, 10, NULL,                                   '2026-06-06', '10:00:00'),
(1,  11, NULL,'Aula experimental de HIIT.',          '2026-06-07', '18:30:00'),
(3,  12, NULL,'Aula experimental de Alongamento.',   '2026-06-07', '17:30:00'),
(5,  7,  NULL,'Aula experimental de Crossfit.',      '2026-06-07', '19:00:00'),
(7,  8,  NULL,'Aula experimental de Pilates.',       '2026-06-08', '09:00:00'),
(10, 10, NULL,'Aula experimental de Yoga.',          '2026-06-08', '10:00:00'),
(11, 9,  9,  'Turma de Funcional - segunda.',       '2026-06-01', '12:00:00'),
(13, 11, 11, 'Turma de HIIT - sexta.',               '2026-06-05', '18:00:00'),
(15, 12, 12, 'Turma de Alongamento - terça.',        '2026-06-02', '17:00:00'),
(17, 7,  7,  'Turma de Crossfit - quinta.',          '2026-06-04', '19:30:00'),
(19, 8,  8,  'Turma de Pilates - sábado.',           '2026-06-06', '10:00:00'),
(2,  10, 10, 'Turma de Yoga - quarta.',              '2026-06-03', '08:00:00'),
(4,  11, 11, 'Turma de HIIT - segunda.',             '2026-06-01', '06:30:00'),
(6,  12, 12, 'Turma de Alongamento - sexta.',        '2026-06-05', '17:00:00'),
(8,  9,  9,  'Turma de Funcional - quarta.',         '2026-06-03', '07:00:00'),
(20, 7,  NULL,'Aula experimental de Crossfit.',      '2026-06-09', '18:00:00');