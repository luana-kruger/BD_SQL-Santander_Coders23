--Criação da view 1
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
	

-- Criação da view 2
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

--Criação da view 3
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
	

--- Criação da view 4
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


--Criação da view 5
CREATE VIEW view_projetos_ordem_valor_solicitado AS
SELECT
    p.nome_projeto,
    p.valor_aprovado
FROM
    projeto p
WHERE
    p.valor_aprovado IS NOT NULL
ORDER BY
    p.valor_aprovado DESC;


select * from view_valor_total_por_area
select * from view_projetos_aprovados_por_area
select * from view_projetos_por_area_situacao
select * from view_quantidade_projetos_por_estado
select * from view_projetos_ordem_valor_solicitado

