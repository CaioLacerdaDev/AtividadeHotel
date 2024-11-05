CREATE DATABASE hotel_reserva;

\c hotel_reserva;

CREATE TABLE hospedes(
    id_hospede SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100)
);

CREATE TABLE quartos (
    id_quarto SERIAL PRIMARY KEY,
    numero_quarto INT NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    preco_diaria DECIMAL(10,3)
);

CREATE TABLE reservas (
    id_reserva SERIAL PRIMARY KEY,
    id_hospede INT NOT NULL,
    id_quarto INT NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE,
    CONSTRAINT fk_hospede FOREIGN KEY (id_hospede) REFERENCES hospedes(id_hospede),
    CONSTRAINT fk_quarto FOREIGN KEY (id_quarto) REFERENCES quartos (id_quarto)
);

INSERT INTO hospedes (nome, email) VALUES
('Joao Silva','joao@gmail.com'),
('Pedra Lisa','Pedralisa@gmail.com'),
('Jotuera','jotuera@gmail.com'),
('Joao Gamer','joaogamer007@gmail.com');

INSERT INTO quartos (numero_quarto, tipo, preco_diaria) VALUES
(101,'Simples',150.000),
(102,'Luxo',300.000),
(103,'Simples',150.000),
(104,'Luxo',300.000),
(105,'Luxo',300.000);

INSERT INTO reservas (id_hospede, id_quarto, data_inicio, data_fim) VALUES
(1,1, '2023-10-12',NULL),
(2,2, '2023-10-01','2023-10-15'),
(3,3, '2023-10-03',NULL),
(4,4, '2023-10-14','2023-10-15');

SELECT 
    h.nome AS nome_hospede,
    q.numero_quarto,
    r.data_inicio,
    r.data_fim
FROM 
    reservas r
JOIN 
    hospedes h ON r.id_hospede = h.id_hospede
JOIN
    quartos q ON r.id_quarto = q.id_quarto
WHERE
    r.data_fim IS NOT NULL;


SELECT 
    h.nome AS nome_hospede,
    q.numero_quarto,
    r.data_inicio,
    r.data_fim
FROM 
    reservas r
RIGHT JOIN 
    hospedes h ON r.id_hospede = h.id_hospede
LEFT JOIN
    quartos q ON r.id_quarto = q.id_quarto;


SELECT 
    r.id_reserva,
    h.nome,
    h.email,
    q.numero_quarto,
    r.data_inicio,
    r.data_fim
FROM  
    quartos q
LEFT JOIN 
    reservas r ON q.id_quarto = r.id_quarto
LEFT JOIN
    hospedes h ON r.id_hospede = h.id_hospede
WHERE
    r.id_reserva IS NULL;