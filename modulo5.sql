-- exemplo do uso do DECLARE
DELIMITER //
CREATE FUNCTION calcula_desconto(livro int, desconto decimal(10,2))
RETURNS decimal(10,2)
DETERMINISTIC
BEGIN
	DECLARE preco decimal(10,2);
    Select preco_livro from livros
    where id_livro = livro into preco; -- select retornado será armazenado na variável preco (into preco)
    return preco - desconto;
END//
DELIMITER ; 

-- testando com o livro de Id 4 e desconto de 10.00
Select * from livros where id_livro = 2;
select calcula_desconto(3,30) as Livro_com_Desconto;

-- EXEMPLO IF
DELIMITER //
CREATE FUNCTION calcula_imposto(salario decimal(10,2))
RETURNS decimal(10,2)
DETERMINISTIC
BEGIN
	DECLARE valorImposto decimal(10,2);
    IF salario <= 1000 THEN
		SET valorImposto = 0.00;
	ELSEIF salario < 2000 THEN
		SET valorImposto = salario * 0.15;
	ELSEIF salario < 3000 THEN
		SET valorImposto = salario * 0.22;
	ELSE
		SET valorImposto = salario * 0.27;
	END IF;
    RETURN valorImposto;
END//
DELIMITER ;

-- testando passando valores de salários como parâmetros
SELECT calcula_imposto(3000.00) as Valor_Imposto_Pagar;

-- EXEMPLO CASE
DELIMITER //
CREATE FUNCTION calcula_imposto_CASE(salario decimal(10,2))
RETURNS decimal(10,2)
DETERMINISTIC
BEGIN
	DECLARE valorImposto decimal(10,2);
    CASE
    WHEN salario <= 1000 THEN
		SET valorImposto = 0.00;
	WHEN salario < 2000 THEN
		SET valorImposto = salario * 0.15;
	WHEN salario < 3000 THEN
		SET valorImposto = salario * 0.22;
	ELSE
		SET valorImposto = salario * 0.27;
	END CASE;
    RETURN valorImposto;
END//
DELIMITER ;

-- testando passando valores de salários como parâmetros
SELECT calcula_imposto_case(1000);

-- exemplo LOOP
DELIMITER //
CREATE PROCEDURE acumula(limite int)
BEGIN
	DECLARE contador INT DEFAULT 0;
    DECLARE soma INT DEFAULT 0;
    Loop1: LOOP
		SET contador = contador + 1; -- 10
        SET soma = soma + contador; -- acumulador -- 55
        IF contador >= limite then -- 10
			LEAVE loop1; -- LEAVE (similar ao break), ou seja, saia do LOOP
		END IF;
	END LOOP loop1;
    SELECT soma;
END//
DELIMITER ;

call acumula(5);

-- exemplo de LOOP com ITERATE
DELIMITER //
CREATE PROCEDURE acumula_iterate(limite int)
BEGIN
	DECLARE contador INT DEFAULT 0;
    DECLARE soma INT DEFAULT 0;
    Loop1: LOOP
		IF limite <=0 THEN
			LEAVE loop1;
		END IF;
		SET contador = contador + 1; -- 1
        SET soma = soma + contador; -- acumulador -- soma 1
        IF contador < limite then
			ITERATE loop1; -- ITERATE (similar ao CONTINUE), ou seja, inicie o loop novamnte
		END IF;
        LEAVE loop1;
	END LOOP loop1;
    SELECT soma;
END//
DELIMITER ;

call acumula_iterate(-1);

-- exemplo REPEAT
DELIMITER //
CREATE PROCEDURE acumula_REPEAT(limite INT UNSIGNED) -- UNSIGNED (sem sinal), ou seja, 
BEGIN													-- aceita somente positivos
	DECLARE contador INT UNSIGNED DEFAULT 0; 
    DECLARE soma INT DEFAULT 0;
    REPEAT
		SET contador = contador + 1; -- 3
        SET soma = soma + contador; -- acumulador -- soma 6
	UNTIL contador >= limite
    END REPEAT;
    SELECT soma;
END//
DELIMITER ;

call acumula_REPEAT(3);
call acumula_REPEAT(0); -- erro

-- arrumando o erro
-- exemplo REPEAT 2
DELIMITER //
CREATE PROCEDURE acumula_REPEAT_2(limite INT UNSIGNED)
trata_erro: BEGIN
	DECLARE contador INT UNSIGNED DEFAULT 0;
    DECLARE soma INT DEFAULT 0;
    IF limite < 1 THEN
		SELECT 'O valor deve ser maior que 0' as ERRO;
        LEAVE trata_erro;
	END IF;
    REPEAT
		SET contador = contador + 1;
        SET soma = soma + contador; -- acumulador
	UNTIL contador >= limite
    END REPEAT;
    SELECT soma;
END//
DELIMITER ;

call acumula_REPEAT_2(10);
call acumula_REPEAT_2(0); -- erro

-- exemplo WHILE
DELIMITER //
CREATE PROCEDURE acumula_WHILE(limite INT UNSIGNED)
BEGIN
	DECLARE contador INT UNSIGNED DEFAULT 0;
    DECLARE soma INT DEFAULT 0;
   WHILE contador < limite DO
		SET contador = contador + 1; -- 3
        SET soma = soma + contador; -- acumulador -- 6
    END WHILE;
    SELECT soma;
END//
DELIMITER ;

call acumula_WHILE(3);
call acumula_WHILE(0);

-- exemplo WHILE com ITERATE
DELIMITER //
CREATE PROCEDURE pares(limite INT UNSIGNED)
BEGIN
	DECLARE contador INT UNSIGNED DEFAULT 0;
	loop1: WHILE contador < limite DO
		SET contador = contador + 1; -- 6
        IF MOD(contador, 2) THEN -- RESULTADO 0=FALSE 1=VERDADEIRO
			ITERATE loop1;
		END IF;
        SELECT CONCAT(contador, ' é um número par') AS Pares;
    END WHILE;
END//
DELIMITER ;

call pares(20);










