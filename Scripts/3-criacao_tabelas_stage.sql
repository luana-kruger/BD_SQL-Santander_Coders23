create table stage.stg_projeto_nao_normalizado(
	pronac int primary key
	,ano_projeto varchar(2)
	,nome varchar(8000)
	,cgccpf varchar(14)
	,proponente varchar(1000)
	,segmento varchar(100)
	,area varchar(100)
	,uf varchar(2)
	,municipio varchar(100)
	,data_inicio varchar(10)
	,data_termino varchar(10)
	,situacao varchar(100)
	,mecanismo varchar(100)
	,enquadramento varchar(50)
	,valor_solicitado varchar(50)
	,valor_aprovado varchar(50)
);

create table stage.stg_incentivo_nao_normalizado(
	id_tmp_incentivos_salic int primary key
	,pronac int
	,valor varchar(50)
	,data_recibo varchar(10)
	,nome_projeto varchar(8000)
	,cgccpf varchar(14)
	,nome_doador varchar(1000)
	,tipo_pessoa varchar(50)
);

