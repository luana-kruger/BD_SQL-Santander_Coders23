-- Carregamento dos dados do proponente
insert into proponente (
	cgc_cpf 
	, proponente 
)
select distinct cgccpf 
	, proponente
from stage.stg_projeto_nao_normalizado a;

-- Carregamento dos dados do projeto, já recuperando o id do proponente
-- Verificado que existem datas de inicio e termino em branco, assim como os valores solicitado e aprovado
-- devido a isto, colocado tratamento para salvar o campo como nulo
insert into projeto(
	pronac 
	, ano_projeto 
	, nome_projeto 
	, segmento 
	, area 
	, uf 
	, municipio 
	, data_inicio 
	, data_termino 
	, situacao 
	, mecanismo 
	, enquadramento 
	, valor_solicitado 
	, valor_aprovado 
	, id_proponente 
)
select a.pronac 
	, a.ano_projeto 
	, a.nome
	, a.segmento 
	, a.area 
	, a.uf 
	, a.municipio 
	, case
		when a.data_inicio = '' then null
		else (a.data_inicio::date) 
	end as dt1
	, case
		when a.data_termino = '' then null
		else (a.data_termino::date) 
	end as dt2
	, a.situacao 
	, a.mecanismo 
	, a.enquadramento 
	, case
		when a.valor_solicitado = '' then null
		else (a.valor_solicitado::numeric) 
	end as valor_solicitado
	, case
		when a.valor_aprovado = '' then null
		else (a.valor_aprovado::numeric) 
	end as valor_aprovado
	, b.id_proponente 
from stage.stg_projeto_nao_normalizado a
inner join public.proponente b
	on a.cgccpf = b.cgc_cpf
	and a.proponente = b.proponente;

-- Carregamento dos dados do incentivador
-- Feito tratamento do campo tipo de pessoa, pois alguns casos vieram vazios (1 - Jurídica, 0 - Física)
insert into incentivador (
	cgc_cpf 
	, nome_doador 
	, tipo_pessoa 
)
select distinct cgccpf 
	, nome_doador
	, case 
		when length(cgccpf) > 11 then 1
		else 0
	end tipo_pessoa
from stage.stg_incentivo_nao_normalizado a;

-- Carregamento dos dados dos incentivos, já recuperando o id do incentivador
insert into incentivos (
	pronac 
	, valor 
	, data_recibo 
	, id_incentivador 
)
select a.pronac 
	, (a.valor::numeric) valor
	, (a.data_recibo::date) data_recibo
	, b.id_incentivador 
from stage.stg_incentivo_nao_normalizado a
inner join public.incentivador b
	on a.cgccpf = b.cgc_cpf 
	and a.nome_doador  = b.nome_doador 
inner join public.projeto c
	on c.pronac = a.pronac;


/*---------------------------------
 * COMPARATIVO DA MIGRAÇÃO
 ----------------------------------
 
-- PROPONENTE
--55.193
select count(distinct concat(cgccpf,proponente))
from stage.stg_projeto_nao_normalizado

--55.193
select count(1)
from public.proponente

-- PROJETO
--119.361
select count(distinct pronac)
from stage.stg_projeto_nao_normalizado

--119.361
select count(1)
from public.projeto

-- INCENTIVADOR
--80.510
select count(distinct concat(cgccpf,nome_doador))
from stage.stg_incentivo_nao_normalizado

--80.510
select count(1)
from public.incentivador

-- INCENTIVOS
--368.855
select count(1)
from stage.stg_incentivo_nao_normalizado

--368.855
select count(1)
from public.incentivos i 

*/