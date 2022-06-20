with RECURSIVE classificacao_a as (  
select codigo, concat(nome) as nome, codigo_pai
from classificacao 
where codigo_pai is null
union all
select class2.codigo, concat(abc.nome, '-->', class2.nome), class2.codigo_pai
from classificacao as class2
inner join classificacao_a as abc on abc.codigo = class2.codigo_pai
where class2.codigo_pai is NOT null)
select codigo as codigo, nome as nome, codigo_pai as "Codigo pai"
from classificacao_a 
order by classificacao_a.nome;