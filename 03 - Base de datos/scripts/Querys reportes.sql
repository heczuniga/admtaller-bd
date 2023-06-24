
/* Reporte 1: Valorización por taller */
select c.nom_carrera as nom_carrera,
	a.sigla,
	a.nom_asign,
    t.id_taller as id_taller,
    t.semana as semana,
    t.titulo_preparacion as titulo_preparacion,
    round(sum(p.precio * ct.cantidad), 0) as total_taller
from asign a
join taller t on t.sigla = a.sigla
join config_taller ct on t.id_taller = ct.id_taller
join producto p on ct.id_producto = p.id_producto
join carrera c on a.cod_carrera = c.cod_carrera
group by c.nom_carrera,
	a.sigla,
	a.nom_asign,
    t.id_taller,
    t.semana,
    t.titulo_preparacion;

/* Reporte2 : Presupuesto estimado por asignatura */
select pa.sigla as sigla,
	count(pa.seccion) as seccion,
    (select round(sum(pr.precio * cota.cantidad), 0) as total_taller
		from config_taller cota
		join producto pr on cota.id_producto = pr.id_producto
		join taller ta on cota.id_taller = ta.id_taller
		where ta.sigla = pa.sigla) as total_asign,
    (count(pa.seccion) * (select round(sum(pr.precio * cota.cantidad), 0) as total_taller
                            from config_taller cota
                            join producto pr on cota.id_producto = pr.id_producto
                            join taller ta on cota.id_taller = ta.id_taller
                            where ta.sigla = pa.sigla)) as total
from prog_asign pa
where pa.ano_academ = 2023
group by pa.sigla;

/* Reporte 3: Asignación y registro de docentes */
select u.primer_apellido as primer_apellido,
	u.segundo_apellido as segundo_apellido,
    u.nom_preferido as nom_preferido,
    pa.nom_periodo_academ as nom_periodo_academ,
    c.nom_carrera as nom_carrera,
	count(pt.id_taller) as talleres_asignados,
    count(rt.id_taller) as talleres_registrados
from prog_taller pt
left outer join regis_taller rt on pt.fecha = rt.fecha and pt.ano_academ = rt.ano_academ and pt.cod_periodo_academ = rt.cod_periodo_academ and pt.sigla = rt.sigla and pt.seccion = rt.seccion and pt.id_taller = rt.id_taller and pt.id_usuario = rt.id_usuario
join usuario u on pt.id_usuario = u.id_usuario
join periodo_academ pa on pt.cod_periodo_academ = pa.cod_periodo_academ
join carrera c on u.cod_carrera = c.cod_carrera
where pt.ano_academ = 2023
group by pt.id_usuario,
	pt.cod_periodo_academ,
    u.cod_carrera
order by u.primer_apellido asc,
	u.segundo_apellido asc,
    u.nom_preferido asc;