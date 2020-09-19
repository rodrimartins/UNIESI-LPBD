-- aula do dia 18/09/2020 - View

-- criando a view

create view vw_LivrosAutores as
select l.nome_livro as Livro, a.nome_autor as Autor from livros l
inner join autores a on
l.ID_Autor = a.ID_Autor;


create view vw_LivrosEditora as
select l.nome_livro as Livro, e.nome_editora as Editora, l.data_Pub as Data_Publicação,
l.preco_livro as Valor from livros l inner join editoras e on
l.id_Editora = e.id_editora;

-- executando a view
select Livro, Valor from vw_livrosautores
order by autor;

select * from vw_livroseditora;

-- alterando a view

alter view vw_LivrosAutores as
select l.nome_livro as Livro, a.nome_autor as Autor, l.preco_Livro as Valor
from livros l
inner join autores a on
l.ID_Autor = a.ID_Autor;
