-- Inserir dados na tabela tipos_veiculos
INSERT INTO tipos_veiculos (codTipo, descricao) VALUES
(1, 'Veleiro'),
(2, 'Jet-Ski'),
(3, 'Catamaran'),
(4, 'Iate');

-- Inserir dados na tabela habilitacoes
INSERT INTO habilitacoes (codH, tipo, idade_min, descricao) VALUES
(1, 'Veleiro', 8, 'Veleiro'),
(2, 'Motonauta', 18, 'Jet-Ski'),
(3, 'Arrais-Amador', 18, 'Pode dirigir todas as embarcações exceto Jet-Ski'),
(4, 'Mestre-Amador', 18, 'Pode dirigir todas as embarcações'),
(5, 'Capitão-Amador', 18, 'Pode dirigir todas as embarcações');

-- Inserir dados na tabela veiculos
INSERT INTO veiculos (matricula, nome, modelo, comprimento, potMotor, vlDiaria, codTipo) VALUES
(101, 'Princesa da Praia', 'Cutter', 28, 24, 800, 1),
(102, 'Stephanie', 'Flash 165', 16, 20, 650, 1),
(103, 'E o vento Levou', 'Open590', 16, 25, 1000, 1),
(104, 'O nome do Vento', 'Fluvimar BR 6000', 20, 25, 900, 1),
(201, 'Jet-Sky', 'Sea Doo GTI 130', 12, 160, 2500, 2),
(202, 'Motoneta', 'Yamaha VX 1100 Deluxe', 5, 100, 1000, 2),
(203, 'Poeira em alto mar', 'VX de Luxe 2021', 10, 110, 1200, 2),
(204, 'Relâmpago', 'VX Cruiser 2021', 10, 120, 1300, 2),
(205, 'Pikachu', 'FX SHO 2021', 10, 100, 1100, 2),
(301, 'Claudia II', 'Lavezzi', 40, 60, 1800, 3),
(302, 'Sereia da Praia', 'Lipari 41', 41, 60, 4000, 3),
(303, 'Carmen', 'Ocema 42', 42, 50, 2100, 3),
(304, 'Flor de Lótus', 'Levefort 40P', 46, 150, 4500, 3),
(401, 'Clutcher', 'Prestige 500', 50, 870, 7600, 4),
(402, 'Anabelle', 'C38', 38, 300, 3800, 4),
(403, 'Lua de Cristal', 'Prestige 500', 50, 870, 7600, 4),
(404, 'Ariete', 'Azimut 740', 74, 1150, 12500, 4),
(405, 'Sereia IV', 'Prestige 440s', 44, 850, 4500, 4);

-- Inserir dados na tabela funcionarios
INSERT INTO funcionarios (codF, nome, telefone, endereco, idade, salario) VALUES
(1, 'Renan', 1231231231, 'Rua Paraná, 527', 27, 3200),
(2, 'Rafhael', 1233754124, 'Av. Fernando Machado, 157, Apto 502', 32, 3000),
(3, 'Alexandre', 8213104512, 'Av. Getulio Vargas, 48, Apto 205', 25, 3200),
(4, 'Sabrina', 3452762415, 'Rua Quintino Bocaiuva, 782', 37, 3800),
(5, 'Lucas', 4534563061, 'Rua Felipe Schimidt, 155, Apto 105', 53, 2700),
(6, 'Marquito', 4534563061, 'Rua Felipe Schimidt, 155, Apto 105', 53, 2700);

-- Inserir dados na tabela veiculos_habilitacoes
INSERT INTO veiculos_habilitacoes (codTipo, codH) VALUES
(1, 1),
(1, 3),
(1, 4),
(1, 5),
(2, 2),
(3, 3),
(3, 4),
(3, 5),
(4, 3),
(4, 4),
(4, 5);

-- Inserir dados na tabela clientes
INSERT INTO clientes (CPF, nome, endereco, estado_civil, num_filhos, data_nasc, telefone, codH) VALUES
('68745120480', 'Joao Loco', 'Rua Konder, 181', 'Casado', 2, '1965/10/22', 4799235687, 5),
('52145784502', 'Carlos', 'Rua Paraná, 155, Apto 405', 'Casado', 3, '1970/02/05', 4899563201, 2),
('35420227840', 'Marcos', 'Rua Pejuçara, 97, Apto 202', 'Solteiro', 0, '1985/11/29', 4888015423, 3),
('89406159987', 'Cristhian', 'Rua Mato Grosso, 48', 'Divorciado', 3, '1967/09/22', 4799563201, 3),
('34568754210', 'Juliano', 'Rua Sete de Setembro, 485, Apto 408', 'Casado', 1, '1970/07/12', 4899873214, 1),
('25415420130', 'Luiza', 'Rua Cludio Stakonski, 345, Apto 512', 'Casado', 3, '1950/02/23', 4888025411, 2),
('87542022642', 'Cleyton', 'Rua Jorge Lacerda, 354', 'Solteiro', 0, '1987/12/30', 4899939529, 3),
('35421578450', 'Crsitiane', 'Rua Assis Brasil, 455, Apto 604', 'Viuvo', 4, '1945/05/10', 4896584523, 4),
('32154789605', 'Eloisa', 'Av. Rio Branco, 542, Apto 708', 'Casado', 2, '1960/10/24', 4895632024, 1),
('32022487964', 'Heitor', 'Av. Sao Pedro, 25, Apto 105', 'Solteiro', 0, '1990/07/19', 4899962364, 5),
('73154879460', 'Rubens', 'Rua Tamandaré, 152, Apto 547', 'Casado', 1, '1998/03/24', 4888998598, 2),
('23548754210', 'Mariana', 'Av. Getulio Vargas, 725, Apto 804', 'Casado', 3, '1972/01/18', 4899596233, 2);

-- Inserir dados na tabela locacoes
INSERT INTO locacoes (codLoc, valor, inicio, fim, obs, matricula, codF, CPF) VALUES
(1, 15200, '2021/12/24', '2021/12/26', 'Locação para o Natal', 401, 3, '68745120480'),
(2, 30400, '2021/12/24', '2021/12/28', 'Locação para o Natal', 403, 2, '35421578450'),
(3, 150000, '2021/12/29', '2022/01/10', 'Locação para férias', 404, 3, '87542022642'),
(4, 30400, '2021/12/29', '2022/01/02', 'Locação para reveillon', 401, 1, '32022487964'),
(5, 31500, '2021/12/29', '2022/01/05', 'Locação para o reveillon', 405, 1, '68745120480'),
(6, 5000, '2022/01/10', '2022/01/12', 'Locação curta de Jet-Ski', 201, 4, '73154879460'),
(7, 2500, '2022/01/13', '2022/01/14', 'Locação curta de Jet-Ski', 201, 2, '52145784502'),
(8, 32000, '2022/01/17', '2022/01/25', 'Locação para viagem média', 302, 1, '35421578450'),
(9, 63000, '2022/01/20', '2022/02/03', 'Locação para viagem média', 405, 3, '87542022642'),
(10, 1100, '2022/02/07', '2022/02/08', 'Locação curta de Jet-Ski', 205, 2, '73154879460'),
(11, 4800, '2022/02/09', '2022/02/13', 'Locação média de Jet-Ski', 203, 1, '23548754210'),
(12, 5000, '2022/02/17', '2022/02/22', 'Locação média de Veleiro', 103, 2, '32154789605'),
(13, 10500, '2022/02/23', '2022/02/28', 'Locação média de Catamaran', 303, 4, '87542022642'),
(14, 5400, '2022/02/23', '2022/02/26', 'Locação curta de Catamaran', 301, 1, '68745120480'),
(15, 1000, '2022/03/04', '2022/03/05', 'Locação curta de Jet-Ski', 202, 3, '25415420130'),
(16, 1950, '2022/03/09', '2022/03/12', 'Locação curta de Jet-Ski', 201, 3, '23548754210'),
(17, 2000, '2022/03/15', '2022/03/17', 'Locação curta de Veleiro', 103, 2, '32154789605'),
(18, 8400, '2022/04/10', '2022/04/14', 'Locação curta de Catamaran', 303, 1, '68745120480'),
(19, 38000, '2022/04/13', '2022/04/18', 'Locação média de Iate', 403, 4, '32022487964'),
(20, 98800, '2022/04/19', '2022/05/02', 'Locação longa de Iate', 401, 2, '35420227840'),
(21, 1600, '2022/05/04', '2022/05/06', 'Locação curta de Jet-Ski', 201, 4, '25415420130'),
(22, 2000, '2022/05/08', '2022/05/10', 'Locação curta de Veleiro', 103, 2, '35421578450'),
(23, 16000, '2022/05/17', '2022/05/21', 'Locação curta de Catamaran', 302, 3, '32022487964'),
(24, 1200, '2022/05/22', '2022/05/23', 'Locação curta de Jet-Ski', 203, 1, '73154879460'),
(25, 45600, '2022/05/27', '2022/06/02', 'Locação média de Iate', 401, 3, '68745120480');