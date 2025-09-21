-- Criação de banco de dados para e-commerce
CREATE DATABASE oficina;
USE oficina;

-- Tabela Cliente
CREATE TABLE clients(
     id_client INT AUTO_INCREMENT PRIMARY KEY,
     nome VARCHAR(60) NOT NULL,
     contato VARCHAR(20) NOT NULL
);

-- Tabela Veiculo
CREATE TABLE veiculo(
     id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
     marca VARCHAR(20) NOT NULL,
     modelo VARCHAR(20) NOT NULL,
     cor VARCHAR(10) NOT NULL,
     placa VARCHAR(10) NOT NULL,
     id_client INT,
     CONSTRAINT fk_veiculo_client FOREIGN KEY (id_client) REFERENCES clients(id_client)
);

-- Tabela Pagamento
CREATE TABLE payment(
    id_payment INT AUTO_INCREMENT PRIMARY KEY,
    id_client INT,
    forma_pagamento ENUM('Boleto', 'Cartão', 'Pix') NOT NULL,
    data_pagamento DATE DEFAULT NULL,
    CONSTRAINT fk_payment_client FOREIGN KEY (id_client) REFERENCES clients(id_client)
);

-- Tabela mecânicos
CREATE TABLE mechanic(
     id_mechanic INT AUTO_INCREMENT PRIMARY KEY,
     nome VARCHAR(60) NOT NULL,
     contato VARCHAR(20) NOT NULL,
     especialidade VARCHAR(60)
);

-- Tabela Ordem de Serviço
CREATE TABLE ordem_servico(
     id_os INT AUTO_INCREMENT PRIMARY KEY,
     id_client INT,
     id_veiculo INT,
	 data_emissao DATE NOT NULL,
     valor_maodeobra FLOAT NOT NULL,
     data_entrega DATE DEFAULT NULL,
     tipo_servico ENUM('conserto', 'revisao'),
     fase ENUM('aguardando peças', 'em andamento', 'finalizada') NOT NULL,
     CONSTRAINT fk_os_client FOREIGN KEY (id_client) REFERENCES clients(id_client),
     CONSTRAINT fk_os_veiculo FOREIGN KEY (id_veiculo) REFERENCES veiculo(id_veiculo)
);

-- Tabela peças
CREATE TABLE pecas(
     id_pecas INT AUTO_INCREMENT PRIMARY KEY,
	 nome VARCHAR(20) NOT NULL,
     valor FLOAT NOT NULL,
     motivo_uso VARCHAR(255)
);

-- Tabelas de Relacionamento 
CREATE TABLE os_mechanic(
     id_os INT,
     id_mechanic INT,
     PRIMARY KEY(id_os, id_mechanic),
     CONSTRAINT fk_osm_os FOREIGN KEY(id_os) REFERENCES ordem_servico(id_os),
     CONSTRAINT fk_osm_mechanic FOREIGN KEY(id_mechanic) REFERENCES mechanic(id_mechanic)
);

CREATE TABLE os_pecas(
     id_os INT,
     id_pecas INT,
     PRIMARY KEY(id_os, id_pecas),
     CONSTRAINT fk_osp_os FOREIGN KEY(id_os) REFERENCES ordem_servico(id_os),
     CONSTRAINT fk_osp_pecas FOREIGN KEY(id_pecas) REFERENCES pecas(id_pecas)
);

INSERT INTO clients (nome, contato) VALUES
('João Silva', '(11) 98765-4321'),
('Maria Oliveira', '(21) 91234-5678'),
('Carlos Pereira', '(31) 95555-8888'),
('Ana Costa', '(41) 94444-7777'),
('Pedro Martins', '(51) 93333-6666'),
('Sofia Almeida', '(61) 92222-5555');

INSERT INTO veiculo (marca, modelo, cor, placa, id_client) VALUES
('Volkswagen', 'Gol', 'Branco', 'ABC-1234', 1),
('Chevrolet', 'Onix', 'Prata', 'DEF-5678', 2),
('Fiat', 'Uno', 'Vermelho', 'GHI-9012', 3),
('Ford', 'Ka', 'Preto', 'JKL-3456', 4),
('Hyundai', 'HB20', 'Cinza', 'MNO-7890', 5),
('Toyota', 'Corolla', 'Azul', 'PQR-1234', 6);

INSERT INTO payment (id_client, forma_pagamento, data_pagamento) VALUES
(1, 'Cartão', '2025-09-12'),
(2, 'Pix', '2025-09-11'),
(3, 'Boleto', '2025-08-15'),
(4, 'Cartão', '2025-09-20'),
(5, 'Pix', '2025-08-07'),
(6, 'Boleto', '2025-09-19');

INSERT INTO mechanic (nome, contato, especialidade) VALUES
('Ricardo Souza', '(11) 98888-1111', 'Motor e Transmissão'),
('Fernanda Lima', '(21) 97777-2222', 'Sistema Elétrico'),
('Lucas Gabriel', '(31) 96666-3333', 'Freios e Suspensão'),
('Juliana Santos', '(41) 95555-4444', 'Ar Condicionado'),
('Marcos Rocha', '(51) 94444-5555', 'Injeção Eletrônica'),
('Beatriz Gomes', '(61) 93333-6666', 'Funilaria e Pintura');

INSERT INTO ordem_servico (id_client, id_veiculo, data_emissao, valor_maodeobra, data_entrega, tipo_servico, fase) VALUES
(1, 1, '2025-09-10', 250.00, '2025-09-12', 'conserto', 'finalizada'),
(2, 2, '2025-09-11', 180.00, '2025-09-15', 'revisao', 'em andamento'),
(3, 3, '2025-09-15', 300.00, NULL, 'conserto', 'aguardando peças'),
(4, 4, '2025-09-16', 450.00, '2025-09-20', 'conserto', 'finalizada'),
(5, 5, '2025-09-18', 120.00, NULL, 'revisao', 'em andamento'),
(1, 1, '2025-09-20', 500.00, NULL, 'conserto', 'em andamento');

INSERT INTO pecas (nome, valor, motivo_uso) VALUES
('Pastilha de Freio', 150.00, 'Desgaste natural, troca preventiva'),
('Óleo do Motor 5W30', 80.50, 'Troca de óleo de rotina'),
('Filtro de Ar', 45.00, 'Substituição durante a revisão'),
('Vela de Ignição', 95.75, 'Falha no cilindro 2'),
('Bateria 60Ah', 350.00, 'Bateria antiga não segura mais carga'),
('Amortecedor Diant.', 280.00, 'Vazamento de óleo no amortecedor direito');

-- Exemplo de OS com mais de um mecânico
INSERT INTO os_mechanic (id_os, id_mechanic) VALUES
(1, 3),
(2, 2),
(3, 1),
(4, 6),
(5, 5),
(6, 1),
(6, 2);

-- Exemplo de OS com mais de uma peça
INSERT INTO os_pecas (id_os, id_pecas) VALUES
(1, 1),
(2, 2),
(2, 3),
(3, 6),
(4, 5),
(5, 4),
(6, 4);

SELECT id_veiculo,
marca,
placa
FROM veiculo;

SELECT id_payment,
forma_pagamento
FROM payment
WHERE forma_pagamento = 'cartão';

SELECT o.id_os,
       o.valor_maodeobra +
       COALESCE((SELECT SUM(p.valor)
                 FROM os_pecas op JOIN pecas p ON op.id_pecas = p.id_pecas
                 WHERE op.id_os = o.id_os), 0) AS custo_total_estimado
FROM ordem_servico o;

SELECT id_os, 
valor_maodeobra, 
tipo_servico
FROM ordem_servico
ORDER BY valor_maodeobra ASC;

SELECT o.id_os, o.id_client, SUM(o.valor_maodeobra) AS total_maodeobra
FROM ordem_servico o
GROUP BY o.id_os, o.id_client
HAVING SUM(o.valor_maodeobra) > 200
ORDER BY total_maodeobra DESC;

SELECT
  c.id_client,
  c.nome AS cliente,
  v.id_veiculo,
  v.modelo,
  o.id_os,
  o.data_emissao,
  o.fase
FROM clients c
LEFT JOIN veiculo v ON v.id_client = c.id_client
LEFT JOIN ordem_servico o ON o.id_client = c.id_client AND o.id_veiculo = v.id_veiculo
ORDER BY c.id_client, o.data_emissao;