create database aula21082020;

use aula21082020;

create table categorias(
id_categoria smallint(6) not null,
categoria varchar(30) not null,
primary key(id_categoria));

create table editoras(
id_editora smallint(6) not null,
nome_editora varchar(50) not null,
primary key(id_editora));

create table autores(
id_autor smallint(6) not null,
nome_autor varchar(30) not null,
sobrenome_autor varchar(60) not null,
primary key(id_autor));

create table livros(
id_livro smallint not null,
nome_livro varchar(70) not null,
id_categoria smallint not null,
id_autor smallint not null,
id_editora smallint not null,
data_pub date not null,
preco_livro decimal(6,2) not null,
isbn10 char(10) not null unique,
isbn13 char(13) not null unique,
primary key(id_livro),
foreign key(id_categoria) references categorias(id_categoria),
foreign key(id_autor) references autores(id_autor),
foreign key(id_editora) references editoras(id_editora));

INSERT INTO editoras(id_editora, nome_editora) VALUES
(1000,'Prentice'),
(2000,'O Reilly'),
(3000, 'Microsoft Press'),
(4000, 'Willey'),
(5000, 'McGraw Hill Education');

select * from editoras;

insert into autores(id_autor, nome_autor, sobrenome_autor) values
(1000,'Daniel', 'Barret'),
(2000,'Gerald', 'Carter'),
(3000, 'Mark', 'Sobell'),
(4000,'William', 'Stanek'),
(5000,'Richard', 'Blum'),
(6000,'Jostein', 'Gaarder'),
(7000, 'Umberto', 'Eco'),
(8000, 'Neil', 'De Grasse Tyson'),
(9000,'Stephen', 'Hawking'),
(10000,'Stephen', 'Jay Gould'),
(11000,'Charles', 'Darwin'),
(12000,'Alan', 'Turing'),
(13000,'Simon', 'Mon'),
(14000, 'Paul', 'Scherz');

select * from autores;

insert into categorias(id_categoria, categoria) values
(1010, 'Tecnologia'),
(1020,'História'),
(1030, 'Literatura'),
(1040,'Astronomia');

select * from categorias;

insert into livros(id_livro, nome_livro, id_categoria, id_autor, id_editora, data_pub, preco_livro, isbn10, isbn13) values
(1,'Linux Command Line and Shell Scripting',1010,1000,1000, '2015-01-09', 68.35, '9781', '123456789');

select * from livros;

SELECT nome_Autor FROM autores;

SELECT * FROM autores;

SELECT nome_livro as Nome_do_Livro FROM livros;

SELECT nome_Livro, ID_Autor FROM livros;

SELECT nome_livro, ISBN10 FROM livros;

SELECT * FROM autores ORDER BY nome_autor desc;


SELECT ID_Autor, nome_Autor FROM autores
WHERE sobrenome_Autor = "Stanek";

CREATE TABLE vendas(
ID_Venda smallint not null,
nome_Vendedor varchar(20) not null,
quantidade int not null,
produto varchar(20) not null,
cidade varchar(20) not null default 'Itapira');

INSERT INTO Vendas (ID_Venda , nome_Vendedor , quantidade, produto, cidade) VALUES
(10,'Jorge',1400,'Mouse','São Paulo'),
(12,'Tatiana',1220,'Teclado','São Paulo'),
(14,'Ana',1700,'Teclado','Rio de Janeiro'),
(15,'Rita',2120,'Webcam',cidade),
(18,'Marcos',980,'Mouse','São Paulo'),
(19,'Carla',1120,'Webcam','Recife'),
(22,'Roberto',3145,'Mouse',cidade);

select * from vendas where cidade="São Paulo";

SELECT SUM(quantidade) As Total_Mouses FROM vendas
WHERE produto = 'Mouse';

SELECT cidade, SUM(quantidade) As Total FROM vendas
group by(cidade);

INSERT INTO Vendas (ID_Venda , nome_Vendedor , quantidade, produto, cidade) VALUES
(50,'Marcelo',1500,'Gabinete Gamer','Sao Paulo');

SELECT cidade , COUNT(*) As Total FROM vendas
GROUP BY(cidade);

SELECT cidade, SUM(quantidade) As Total from Vendas
GROUP BY cidade
HAVING SUM(Quantidade) > 2500;

SELECT cidade, SUM(quantidade) As Total_Teclados FROM Vendas
WHERE produto = 'Teclado'
GROUP BY cidade
HAVING SUM(quantidade) < 1500;

SELECT * FROM livros
WHERE ID_Livro = 1 AND ID_Autor =  1000;

SELECT * FROM livros
WHERE ID_Livro=1 OR ID_Autor = 3000;

SELECT * FROM livros
WHERE ID_Livro=1 AND NOT ID_Autor=3000;

select * from autores;

DELETE FROM autores WHERE ID_Autor = 14000;

UPDATE livros SET nome_Livro ="SSH o Shell Seguro"
WHERE ID_Livro=1;

select * from editoras;

update editoras set nome_editora="UNIESI";

SELECT * FROM autores
WHERE nome_autor LIKE 'S%';



SELECT nome_autor FROM autores
WHERE nome_autor LIKE '_%am';







