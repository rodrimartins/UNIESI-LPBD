-- Consultando os usuários existentes no sistema
SELECT User, Host FROM mysql.user;

-- criando um novo usuário no sistema (sem privilégios)
CREATE USER usuario@localhost IDENTIFIED BY '1234';

SHOW GRANTS FOR usuario@localhost;

-- excluindo o usuario
drop user usuario@localhost;

-- Criando um usuário de nome “rodrigo” com senha “1234” no MySQL, 
-- com acesso a partir do host local
CREATE USER rodrigo@localhost IDENTIFIED BY '1234';

-- Criando um usuário de nome “mané” com acesso a partir de qualquer local
CREATE USER mané IDENTIFIED BY "1234";
-- % para o usuário mané, significando que ela pode acessar o SGBD de qualquer local

-- Criando um usuário de nome bianca sem senha definida no momento
CREATE USER bianca@localhost;

-- Para alterar ou configurar uma senha para o usuário posteriormente, use o comando SET PASSWORD
SET PASSWORD FOR 'bianca'@'localhost' = '1234';

-- renomear a usuária bianca para monica
RENAME USER bianca@localhost TO monica@localhost;

-- excluindo o usuario
drop user julia@localhost;

-- Usando a declaração GRANT para atribuir privilégios

-- criando a usuária julia no sistema (sem privilégios)
CREATE USER 'julia'@'localhost' IDENTIFIED BY '1234';

-- Garantindo acesso a um usuário de nome julia
GRANT ALL ON *.* TO 'julia'@'localhost';

-- verificando privilégios
SHOW GRANTS FOR julia@localhost;

-- criando o usuario alexandre no sistema
CREATE USER 'alexandre'@'localhost' IDENTIFIED BY '1234';
SHOW GRANTS FOR alexandre@localhost;

-- Dar privilégios globais a um usuário de nome maria e concedendo permissão a ela
GRANT ALL ON *.* TO 'alexandre'@'localhost'
with grant option;

-- Dar privilégios específicos para execução de comandos DML em todas as tabelas do banco db_biblioteca
-- ao usuário ricardo
CREATE USER 'ricardo'@'localhost' IDENTIFIED BY '1234';

GRANT SELECT, INSERT, UPDATE, DELETE
ON biblioteca.*
TO 'ricardo'@'localhost';
SHOW GRANTS FOR ricardo@localhost;

-- Garantir privilégios de inserção e atualização de registros e efetuar consultas na a tabela 
-- autores do banco de dados biblioteca ao usuário julia
GRANT SELECT, INSERT, UPDATE
ON biblioteca.autores
TO 'julia'@'localhost';
SHOW GRANTS FOR julia@localhost;

-- garantir o privilégio de consultar nomes e sobrenomes e alterar somente nomes dos autores
-- (coluna nome-Autor) da tabela autores do banco biblioteca ao usuário rodrigo

GRANT SELECT (nome_Autor, sobrenome_Autor), UPDATE (nome_Autor)
ON biblioteca.autores
TO 'rodrigo'@'localhost';
SHOW GRANTS FOR rodrigo@localhost;

-- Revogando privilégios com a declaração REVOKE
-- Revogando o privilégio de exclusão de dados no banco biblioteca para o usuario ricardo

REVOKE DELETE
ON biblioteca.*
FROM 'ricardo'@'localhost';
SHOW GRANTS FOR ricardo@localhost;

-- Removendo todos os privilégios em todos os bancos de dados dos usuários alexandre e rodrigo

REVOKE ALL, GRANT OPTION
FROM 'julia'@'localhost';

SHOW GRANTS FOR alexandre@localhost;
SHOW GRANTS FOR rodrigo@localhost;


