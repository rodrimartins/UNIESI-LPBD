 -- CREATE TRIGGER nome timing(momento) operação
 -- ON tabela
-- FOR EACH ROW
-- declarações

-- timing = BEFORE | AFTER
-- operação = INSERT | UPDATE | DELETE

CREATE DATABASE exemploTRIGGER1;
use exemploTRIGGER1;

CREATE TABLE produto (
idProduto int not null auto_increment,
nomeProduto varchar(45) null,
precoNormal decimal(10,2) null,
precoDesconto decimal(10,2) null,
primary key(idProduto));

-- criando o trigger
CREATE TRIGGER trg_desconto BEFORE INSERT
ON produto
FOR each row
SET new.precoDesconto = (new.precoNormal * 0.9);

show triggers;

INSERT INTO produto(nomeProduto, precoNormal) values
("Teclado", 100.00);

INSERT INTO produto(nomeProduto, precoNormal) values
("Mouse", 30.00),
("Placa de Vídeo", 500.00),
("Placa de Som", 100.00);

select * from produto;

drop trigger trg_desconto;

CREATE TABLE usuario (
idUsuario int not null auto_increment,
nome varchar(45) NULL,
primary key(idusuario));

DELIMITER //
CREATE TRIGGER trg_valida BEFORE INSERT
ON usuario
FOR each row
  BEGIN
	set @nomeU  = new.nome;
    set @qtd = char_length(@nomeU);
    if (@qtd<=4) or (@nomeU = '') then
		set new.nome="usuarioPadrao";
    end if;
  END //
DELIMITER ;

show triggers;

INSERT INTO usuario(nome) values ("A");

INSERT INTO usuario(nome) values ("rodrimartins");

select * from usuario;

drop trigger trg_valida;

-- exemplo 2 de trigger

CREATE DATABASE exemploTRIGGER2;
use exemploTRIGGER2;

CREATE TABLE Produtos(
Referencia  VARCHAR(3) PRIMARY KEY,
Descricao   VARCHAR(50) UNIQUE,
Estoque INT NOT NULL DEFAULT 0);
 
INSERT INTO Produtos VALUES ('001', 'Feijão', 10);
INSERT INTO Produtos VALUES ('002', 'Arroz', 5);
INSERT INTO Produtos VALUES ('003', 'Farinha', 15);

select * from produtos;
 
CREATE TABLE ItensVenda(   
Venda INT,
Produto VARCHAR(3),
Quantidade INT);


-- baixa estoque 
CREATE TRIGGER Trg_ItensVenda_Insert AFTER INSERT
ON ItensVenda
FOR EACH ROW
    UPDATE Produtos SET Estoque = Estoque - NEW.Quantidade
	WHERE Referencia = NEW.Produto;
    
INSERT INTO ItensVenda VALUES (2, '001',3);
INSERT INTO ItensVenda VALUES (1, '002',1);
INSERT INTO ItensVenda VALUES (1, '003',5);

select * from produtos;

select * from ItensVenda;

-- venda cancelada, atualiza estoque
CREATE TRIGGER trg_ItensVenda_Delete AFTER DELETE
ON ItensVenda
FOR EACH ROW
    UPDATE produtos SET Estoque = Estoque + OLD.Quantidade
	WHERE Referencia = OLD.Produto;

DELETE FROM itensvenda WHERE Venda = 2 AND Produto = '001';

-- exemplo 3 de trigger
CREATE DATABASE exemploTRIGGER3;
use exemploTRIGGER3;

CREATE TABLE cliente(
idCliente int auto_increment,
nome varchar(40) not null,
email varchar(80) not null,
endereco varchar(60) not null,
primary key(idCliente));

CREATE TABLE newsletter(
idNews int auto_increment,
email char(80) not null,
primary key(idNews));

insert cliente (nome, email, endereco) values
("Maria","maria@gmail.com","Rua 3");

select * from cliente;

select * from newsletter;

-- backup
CREATE TRIGGER trg_email AFTER INSERT
ON cliente
FOR EACH row
	insert into newsletter set email = new.email;
    
insert cliente (nome, email, endereco) values
("Rodrigo","rodrigo@gmail.com","Rua 4");









