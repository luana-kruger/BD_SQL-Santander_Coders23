-- Create tabela Proponente
CREATE TABLE Proponente (
    id_proponente INT PRIMARY KEY,
    cgc_cpf VARCHAR(14),
    proponente VARCHAR(1000)
);

-- Create tabela Projeto
CREATE TABLE Projeto (
    pronac INT PRIMARY KEY,
    ano_projeto VARCHAR(2),
    nome_projeto VARCHAR(8000),
    segmento VARCHAR(100),
    area VARCHAR(100),
    uf VARCHAR(2),
    municipio VARCHAR(100),
    data_inicio DATE,
    data_termino DATE,
    situacao VARCHAR(100),
    mecanismo VARCHAR(100),
    enquadramento VARCHAR(50),
    valor_solicitado NUMERIC,
    valor_aprovado NUMERIC,
    id_proponente INT REFERENCES Proponente(id_proponente)
);

-- Create tabela Incentivador
CREATE TABLE Incentivador (
    id_incentivador INT PRIMARY KEY,
    cgc_cpf VARCHAR(14),
    nome_doador VARCHAR(1000),
    tipo_pessoa SMALLINT
);

-- Create tabela Incentivos
CREATE TABLE Incentivos (
    id_tmp_incentivos_salic INT PRIMARY KEY,
    pronac INT REFERENCES Projeto(pronac),
    valor NUMERIC,
    data_recibo DATE,
    id_incentivador INT REFERENCES Incentivador(id_incentivador)
);

