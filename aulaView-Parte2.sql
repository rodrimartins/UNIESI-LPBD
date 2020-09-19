select * from consumo;

select * from marca;

select * from veiculos;

create view vw_VeiculoMarca as
select v.modelo Modelo, m.marca Marca, v.anofabricacao Ano from veiculos v, marca m where
v.codMarca_fk = m.codMarca
order by v.modelo;

select * from vw_veiculomarca;

create view vw_VeiculoKmRodado as
Select m.marca, v.cor, c.kmRodado, c.valor from marca m, veiculos v, consumo c
where m.codMarca = v.codMarca_fk and
c.placa_fk = v.placa;

alter view vw_VeiculoKmRodado as
Select m.marca Marca, v.cor Cor, c.kmRodado KmRodado, c.valor Valor from marca m, veiculos v, consumo c
where m.codMarca = v.codMarca_fk and
c.placa_fk = v.placa;

select * from vw_veiculokmrodado;

create view vw_MediaKMRodado as
Select m.marca, v.modelo, avg(c.kmRodado) Media_KM_Rodado
from veiculos v, marca m, consumo c where
m.codMarca = v.codMarca_fk and
v.placa = c.placa_fk;

alter view vw_MediaKMRodado as
Select m.marca, v.modelo, avg(c.kmRodado) Media_KM_Rodado
from veiculos v, marca m, consumo c where
m.codMarca = v.codMarca_fk and
v.placa = c.placa_fk
group by v.modelo;

select * from vw_mediakmrodado;

create view vw_QtdMarcas as
Select m.marca, v.modelo, count(*) Qtd_Marca from marca m, veiculos v where
m.codMarca = v.codMarca_fk
group by m.marca;

select * from vw_qtdmarcas;

create view viewMarca as
select m.codMarca, m.marca from marca m;

alter view viewMarca as
select m.codMarca CODMARCA, m.marca MARCA from marca m;

select * from marca;

select * from viewmarca;

insert into viewmarca(marca) values
("VW");

update viewmarca set marca = "Volksvagem" where codMarca = 8;

RENAME TABLE vw_veiculokmrodado 
TO vw_veiculoskmrodados;

