
select * from cliente;

select * from vendedor;

select * from produto;

select * from pedido;

select * from item_pedido;

-- A que clientes estão associados os pedidos existentes? Listar pelos nomes dos clientes

select c.cod_cli, c.nome_cli, p.num_ped  from cliente c, pedido p where
c.cod_cli = p.cod_cli
order by c.nome_cli;

select c.cod_cli, c.nome_cli, p.num_ped  from pedido p inner join cliente c on
c.cod_cli = p.cod_cli
order by c.nome_cli;

-- Quais são os clientes que têm pedidos com prazos de entrega superiores a 15 dias e que estão localizados nos
-- estados de São Paulo ou do Rio de Janeiro?

select c.cod_cli, c.nome_cli, c.uf, p.num_ped, p.prazo_entr from cliente c, pedido p where
c.cod_cli = p.cod_cli and
p.prazo_entr > 15 and
(c.uf='sp' or c.uf='rj');
-- c.uf in ('sp','rj');

-- Mostrar os pedidos dos clientes e seus respectivos prazos
-- de entrega, ordenados do maior para o menor

select c.cod_cli, c.nome_cli, p.num_ped, p.prazo_entr from cliente c, pedido p where
c.cod_cli = p.cod_cli
order by p.prazo_entr desc;

-- Exibir os vendedores (ordenados por nome) que emitiram
-- pedidos com prazos de entrega superiores a 15 dias e que
-- tenham salários fixos iguais ou superiores a R 1 000 00

select v.nome_vend, v.sal_fixo, p.num_ped, p.prazo_entr from vendedor v, pedido p where
v.cod_vend = p.cod_vend and
p.prazo_entr > 15 and
v.sal_fixo >= 1000
order by v.nome_vend;

-- Exiba a relação dos clientes localizados no Rio de Janeiro
-- (ordenados alfabeticamente) que têm pedidos do produto
-- Chapa de Aço com prazos de entrega superiores a 15 dias

select c.nome_cli, c.uf, p.num_ped, p.prazo_entr, pr.desc_prod 
from cliente c, pedido p, produto pr, item_pedido ip where
c.cod_cli = p.cod_cli and
p.num_ped = ip.num_ped and
pr.cod_prod = ip.cod_prod and
c.uf = 'rj' and
pr.desc_prod = 'Chapa de Aço' and
p.prazo_entr > 15
order by c.nome_cli;


select c.nome_cli, c.uf, p.num_ped, p.prazo_entr, pr.desc_prod 
from pedido p inner join cliente c inner join item_pedido ip
inner join produto pr on
c.cod_cli = p.cod_cli and p.num_ped = ip.num_ped and pr.cod_prod = ip.cod_prod and
c.uf = 'rj' and
pr.desc_prod = 'Chapa de Aço' and
p.prazo_entr > 15
order by c.nome_cli;









