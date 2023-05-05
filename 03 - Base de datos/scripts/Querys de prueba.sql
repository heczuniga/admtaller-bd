
select *
from config_taller
where cod_agrupador <> 0;

select p.nom_producto as producto,
	cp.nom_categ_producto as categoria,
    ct.cantidad as cantidad,
    um.nom_unidad_medida_abrev as unidad,
    p.precio as precio_unit,
    p.precio * ct.cantidad as sub_total,
    a.nom_agrupador as agrupador
from config_taller ct,
	producto p,
    categ_producto cp,
    unidad_medida um,
    agrupador a
where a.cod_agrupador = ct.cod_agrupador and
	p.cod_unidad_medida = um.cod_unidad_medida and
	ct.id_producto = p.id_producto and
	p.cod_categ_producto = cp.cod_categ_producto and
	ct.id_taller = 151
order by a.nom_agrupador asc,
	cp.nom_categ_producto asc,
    p.nom_producto asc;


select *
from taller
where sigla = "ABT3131"
order by semana asc
