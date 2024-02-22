-- View 1 -- Valor Total Aprovado por Área
/* Esta view apresenta o valor total aprovado para projetos agrupados por área  */

CREATE VIEW view_valor_total_por_area AS
SELECT
    p.area,
    SUM(p.valor_aprovado) AS valor_total_aprovado
FROM
    projeto p
JOIN
    proponente pr ON p.id_proponente = pr.id_proponente
GROUP BY
    p.area;
	

-- View 2 -- Projetos Aprovados por Área
/* Esta view mostra o número total de projetos aprovados, juntamente com o valor total aprovado, agrupados por área  */

CREATE VIEW view_projetos_aprovados_por_area AS
SELECT
    p.area,
    COUNT(p.pronac) AS total_projetos,
    SUM(p.valor_aprovado) AS valor_total_aprovado
FROM
    projeto p
JOIN
    proponente pr ON p.id_proponente = pr.id_proponente
WHERE
    LOWER(p.situacao) LIKE '%aprovado%' OR LOWER(p.situacao) LIKE '%aprovada%'
GROUP BY
    p.area;

-- View 3 -- Projetos por Área e Situação
/* Esta view apresenta a contagem total e o valor total aprovado para projetos agrupados por área e situação */

CREATE VIEW view_projetos_por_area_situacao AS
SELECT
    p.area,
    p.situacao,
    COUNT(*) AS total_projetos,
    SUM(p.valor_aprovado) AS valor_total_aprovado
FROM
    projeto p
JOIN
    proponente pr ON p.id_proponente = pr.id_proponente
GROUP BY
    p.area, p.situacao
ORDER BY
    p.area;
	

-- View 4 -- Quantidade de Projetos por Estado
/* Esta view indica a quantidade de projetos agrupados por estado, ordenados do maior para o menor número de projetos */

CREATE VIEW view_quantidade_projetos_por_estado AS
SELECT
    p.uf,
    COUNT(*) AS quantidade_projetos
FROM
    projeto p
GROUP BY
    p.uf
ORDER BY
    quantidade_projetos DESC;


-- View 5 -- Projetos em ordem de Valor Aprovado
/* Esta view exibe os projetos ordenados de acordo com o valor aprovado, excluindo projetos com valores nulos */

CREATE VIEW view_projetos_ordem_valor_aprovado AS
SELECT
    p.nome_projeto,
    p.valor_aprovado
FROM
    projeto p
WHERE
    p.valor_aprovado IS NOT NULL
ORDER BY
    p.valor_aprovado DESC;

-- View 6 -- Projetos com maior Valor Solicitado
/* Esta view apresenta os 10 projetos com o maior valor solicitado */

CREATE VIEW view_projetos_maior_valor_solicitado AS
SELECT
    pronac,
    nome_projeto,
    valor_solicitado
FROM
    Projeto
WHERE
    valor_solicitado IS NOT NULL
ORDER BY
    valor_solicitado DESC
LIMIT 10;

-- View 7 -- Projetos Aprovados acima da média
/* Esta view exibe projetos cujo valor aprovado é superior à média dos valores aprovados */

CREATE VIEW view_projetos_aprovados_acima_media AS
SELECT
    pronac,
    nome_projeto,
    valor_aprovado
FROM
    Projeto
WHERE
    valor_aprovado IS NOT NULL
    AND valor_aprovado > (
        SELECT
            AVG(valor_aprovado)
        FROM
            Projeto
        WHERE
            valor_aprovado IS NOT NULL
    )
ORDER BY valor_aprovado DESC;


-- View 8 -- Projetos mais Incentivados
/* Esta view mostra os 10 projetos que receberam o maior valor total de incentivos */

CREATE VIEW view_projetos_mais_incentivados AS
SELECT
    p.pronac,
    p.nome_projeto,
    SUM(i.valor) as total_incentivo
FROM
    Projeto p
INNER JOIN
    Incentivos i ON p.pronac = i.pronac
WHERE
    i.valor IS NOT NULL
GROUP BY
    p.pronac, p.nome_projeto
ORDER BY
    total_incentivo DESC
LIMIT 10;

-- View 9 -- Incentivadores que mais doaram 
/* Esta view apresenta os 10 incentivadores que mais contribuíram financeiramente para projetos */

CREATE VIEW incentivador_mais_doou AS
SELECT
    ince.id_incentivador,
    ince.nome_doador,
    ince.tipo_pessoa,
    SUM(i.valor) as total_doado
FROM
    Incentivos i
INNER JOIN
    Incentivador ince ON i.id_incentivador = ince.id_incentivador
WHERE
    i.valor IS NOT NULL
GROUP BY
    ince.id_incentivador, ince.nome_doador, ince.tipo_pessoa
ORDER BY
    total_doado DESC
LIMIT 10;


-- View 10 -- Projetos com maior diferença entre Valor Solicitado e Aprovado
/* Esta view identifica os 10 projetos com a maior diferença entre o valor solicitado e o valor aprovado, considerando apenas projetos aprovados */

CREATE VIEW projetos_maior_diferenca AS
SELECT pronac, nome_projeto,
       valor_solicitado, valor_aprovado,
       ABS(valor_aprovado - valor_solicitado) AS diferenca
FROM Projeto p
WHERE valor_solicitado IS NOT NULL 
      AND (valor_aprovado > 0 OR valor_aprovado IS NULL)
      AND (LOWER(p.situacao) LIKE '%aprovado%' OR LOWER(p.situacao) LIKE '%aprovada%')
ORDER BY diferenca DESC
LIMIT 10;


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------

select * from view_valor_total_por_area
select * from view_projetos_aprovados_por_area
select * from view_projetos_por_area_situacao
select * from view_quantidade_projetos_por_estado
select * from view_projetos_ordem_valor_aprovado
select * from view_projetos_maior_valor_solicitado
select * from view_projetos_aprovados_acima_media
select * from view_projetos_mais_incentivados
select * from incentivador_mais_doou
select * from projetos_maior_diferenca

