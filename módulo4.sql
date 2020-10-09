-- Funções
SELECT 3 * 9;

SELECT Nome_Livro, Preco_Livro * 5  AS 'Preço de 5 Unidades' FROM Livros;

SELECT 2 * 9 / 3;

SELECT id_livro,Nome_Livro, Preco_Livro / 2 AS 'Preço com 50% de desconto'
FROM Livros order by preco_livro desc;

SELECT 10 % 3;

UPDATE livros SET Preco_livro = Preco_livro * 1.1
where id_livro=2;

select * from livros;

SELECT Nome_Livro, CEILING(Preco_Livro)  
AS  'Preço Arredondado' FROM livros;

SELECT Nome_Livro, Floor(Preco_Livro)  
AS  'Preço Arredondado para Menos' FROM livros;

SELECT PI();

SELECT POW(2,4);

SELECT SQRT(81);

SELECT SIN(PI());

SELECT HEX(1200);

-- -- exemplo 1
-- criando a função
CREATE FUNCTION fn_teste (a DECIMAL(10,2), b INT)
RETURNS INT
DETERMINISTIC
RETURN a * b;

-- invocando a função
SELECT fn_teste(2.5, 4) AS Resultado;

-- exemplo 2
SELECT Nome_Livro, fn_teste(Preco_Livro, 6) AS 'Preço de 6 unidades'
FROM Livros
WHERE ID_Livro = 2;

select * from livros;

-- -- exemplo 3
CREATE FUNCTION fn_verPreço (a SMALLINT)
RETURNS VARCHAR(60)
deterministic
RETURN
(SELECT CONCAT('O preço do livro ', Nome_Livro, ' é ', Preco_Livro)
FROM livros
WHERE ID_livro = a);

-- invocando a função
SELECT fn_verPreço(3);

-- Stored Procedure

-- exemplo 1
-- criando a stored procedure
CREATE PROCEDURE verPreco (varLivro smallint)
SELECT CONCAT('O preço do livro ', Nome_Livro, ' é ', Preco_Livro) AS Preço
FROM Livros
WHERE ID_Livro = varLivro;

-- invocando a stored procedure
CALL verPreco(3);

-- exemplo 2
CREATE PROCEDURE consultaLivros (varEditora VARCHAR(50))
SELECT CONCAT('O livro ', Nome_Livro, ' custa ', Preco_Livro) AS Preço
FROM Livros
INNER JOIN editoras
ON livros.ID_editora = editoras.ID_Editora
WHERE editoras.Nome_Editora = varEditora;

CALL consultaLivros('O´Reilly');

-- criando a função com DELIMITER
DELIMITER //
CREATE FUNCTION aumenta_preco(preco DECIMAL(10,2), taxa DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
	RETURN preco + preco * taxa / 100;
END//
DELIMITER ;

-- executando a função para aumentar o preço em 10%
SELECT aumenta_preco(100.00, 20.00) AS RESULTADO;

-- criando o procedimento com DELIMITER
DELIMITER //
CREATE PROCEDURE verPreco2 (varLivro int)
BEGIN
	SELECT CONCAT('O Preço é: ', preco_livro) AS Preço from livros
    WHERE id_livro = varLivro;
END//
DELIMITER ;

CALL verPreco2(3);

DELIMITER //
CREATE PROCEDURE verPreco3 (varLivro int, nomeLivro varchar(40))
BEGIN
	SELECT CONCAT('O Preço é: ', preco_livro) AS Preço from livros
    WHERE id_livro = varLivro;
    SELECT CONCAT('O Preço é: ', preco_livro) AS Preço from livros
    WHERE  nome_Livro = nomeLivro;
END//
DELIMITER ;

CALL verPreco3(1, 'Using Samba');

-- criando um procedimento com o parâmetro IN
 -- exemplo 1
DELIMITER //
CREATE PROCEDURE editora_livro (in editora varchar(50))
BEGIN
	SELECT l.nome_Livro, e.nome_Editora
	FROM livros as l
	INNER JOIN editoras as e
	ON l.ID_Editora = E.ID_Editora
	WHERE e.nome_Editora = editora;
END //
DELIMITER ;

CALL editora_livro('Wiley');

-- outra forma de chamar
SET @minhaeditora = 'Wiley';
CALL editora_livro(@minhaeditora);

-- exemplo 2
DELIMITER //
CREATE PROCEDURE aumenta_preco (IN codigo int, taxa decimal(10,2))
BEGIN
	UPDATE livros
    set preco_livro = preco_livro + preco_livro * taxa / 100
	WHERE ID_livro = codigo;
END //
DELIMITER ;

-- testando: vamos aumentar em 20% o livro de ID=4
-- vamos verificar o preço do livro com ID=4
SELECT * from livros where ID_Livro=4;

-- vamos executar o aumento
SET @livro = 4;
SET @aumento = 20;
CALL aumenta_preco(@livro,@aumento);

-- criando um procedimento com o parâmetro OUT
-- EXEMPLO 3
DELIMITER //
CREATE PROCEDURE teste_OUT (IN id int, OUT LIVRO varchar(50))
BEGIN
	SELECT nome_Livro 
    INTO LIVRO
    FROM livros
    WHERE ID_livro = id;
END //
DELIMITER ;

CALL teste_OUT(1, @LIVRO);
SELECT @LIVRO;

select preco_livro, @LIVRO from livros
where nome_livro = @LIVRO;

-- criando um procedimento com o parâmetro inOUT
-- EXEMPLO 4
 -- nesse exemplo o valor da variável que for passado  ao parâmetro "valor" será refletida
 -- na própria variável externa a qual terá seu valor alterado também
DELIMITER //
CREATE PROCEDURE aumento (INOUT valor decimal(10,2), taxa decimal(10,2))
BEGIN
	SET valor = valor + valor * taxa / 100 ;
END //
DELIMITER ;

-- testando: criamos a variável valorinicial  e a usamos
-- para passar o parâmetro valor
-- vamos aumentar em 15%

-- criei a variável e passei o valor inicial 20
SET @valorinicial = 100;
SELECT @valorinicial;

CALL aumento(@valorinicial, 15.00);
-- verficamos se a variável externa @valorinicial foi alterada
SELECT @valorinicial;


