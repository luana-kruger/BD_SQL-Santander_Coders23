-- Carregamento do arquivo de projeto para a tabela stage
COPY stage.stg_projeto_nao_normalizado(pronac,ano_projeto,nome,cgccpf,proponente,segmento,area,uf,municipio,data_inicio,data_termino,situacao,mecanismo,enquadramento,valor_solicitado,valor_aprovado)
FROM 'C:\projetos_rouanet.csv'
DELIMITER ';'
quote '"'
CSV header;

-- Carregamento do arquivo de incentivo para a tabela stage
COPY stage.stg_incentivo_nao_normalizado(id_tmp_incentivos_salic,pronac,valor,data_recibo,nome_projeto,cgccpf,nome_doador,tipo_pessoa)
FROM 'C:\incentivos_rouanet.csv'
DELIMITER ';'
quote '"'
CSV header;


