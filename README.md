## Projeto: Desenvolvimento de Sistema de Banco de Dados Personalizado para Lei Rouanet

Este projeto faz parte da avaliação do módulo II do programa Santander Coders 2023.2, que aborda conceitos sobre Banco de Dados I. O objetivo é desenvolver um sistema de gerenciamento completo para a Lei Rouanet, desde a modelagem inicial até a implementação funcional do banco de dados.

### Lei Rouanet: Contextualização

A [Lei Rouanet](https://www.planalto.gov.br/ccivil_03/leis/l8313cons.htm), oficialmente conhecida como Lei Federal de Incentivo à Cultura, é um mecanismo de incentivo fiscal no Brasil que permite que empresas e pessoas físicas destinem parte do imposto devido para projetos culturais aprovados pelo [Ministério da Cultura](https://www.gov.br/cultura/pt-br). Ela é uma importante ferramenta de fomento à cultura no país, incentivando a realização de projetos culturais e a democratização do acesso à cultura.

### Descrição do Modelo de Entidade e Relacionamento

#### Entidades e Atributos:

| Entidade     | Atributos                                                             |
|--------------|-----------------------------------------------------------------------|
| Projeto      | Pronac (chave primária), Ano_projeto, Nome, Cgccpf, Proponente, Segmento, Area, Uf, Municipio, Data_inicio, Data_termino, Situacao, Mecanismo, Enquadramento, Valor_solicitado, Valor_aprovado |
| Incentivo    | Id_tmp_incentivos_salic (chave primária), Pronac (chave estrangeira referenciando o projeto), Valor, Data_recibo, Nome_projeto |
| Incentivador | Id (serial), Cgccpf, Nome_doador, Tipo_pessoa                         |

#### Relacionamentos:

1. Projeto - Incentivo (1:N): Um projeto pode receber vários incentivos, mas um incentivo está relacionado a apenas um projeto.
2. Incentivo - Incentivador (N:1): Um incentivo pode ser dado por um único incentivador, mas um incentivador pode fornecer vários incentivos.

### Diagrama Entidade-Relacionamento

```
+--------------+       1        +------------+       N        +---------------+
|    Projeto   |<---------------|  Incentivo |<--------------|  Incentivador |
+--------------+                 +------------+               +---------------+
|   Pronac     |                 | Id_tmp_incentivos_salic  |   Id          |
|   Ano_projeto|                 | Pronac                   |   Cgccpf      |
|   Nome       |                 | Valor                    |   Nome_doador |
|   Cgccpf     |                 | Data_recibo              |   Tipo_pessoa |
|   Proponente |                 | Nome_projeto             |               |
|   Segmento   |                                               |               |
|   Area       |                                               |               |
|   Uf         |                                               |               |
|   Município  |                                               |               |
|   Data_inicio|                                               |               |
|   Data_termino|                                              |               |
|   Situação   |                                               |               |
|   Mecanismo  |                                               |               |
|   Enquadramento|                                             |               |
|   Valor_solicitado|                                           |               |
|   Valor_aprovado|                                             |               |
+--------------+                                                 +---------------+
```

## Autores

- [@andreaseliass](https://github.com/andreaseliass)
- [@AnthonyHeimlich](https://github.com/AnthonyHeimlich)
- [@evertondcavalcante](https://github.com/evertondcavalcante)
- [@JuliaMidoriRW](https://github.com/JuliaMidoriRW)
- [@luana-kruger](https://github.com/luana-kruger)

## Documentação

#### Entidades e Atributos:

1. **Projeto**
   - **Pronac**: Identificador único do projeto no Ministério da Cultura.
   - **Ano_projeto**: Os últimos dois dígitos do ano de cadastro do projeto na Lei Rouanet.
   - **Nome**: Nome do projeto cultural.
   - **Cgccpf**: CNPJ ou CPF do proponente do projeto (CPF ocultado por questões de privacidade).
   - **Proponente**: Nome do proponente do projeto.
   - **Segmento**: Segmento artístico-cultural ao qual o projeto pertence.
   - **Area**: Área temática do projeto cultural.
   - **Uf**: Estado onde o projeto será executado.
   - **Municipio**: Município onde o projeto será executado.
   - **Data_inicio**: Data de início prevista para o projeto.
   - **Data_termino**: Data de término prevista para o projeto.
   - **Situacao**: Estado atual do processo de aprovação do projeto.
   - **Mecanismo**: Forma de captação de recursos para o projeto.
   - **Enquadramento**: Artigo específico da Lei Rouanet no qual o projeto se enquadra.
   - **Valor_solicitado**: Valor solicitado para captação de recursos.
   - **Valor_aprovado**: Valor aprovado pelo Ministério da Cultura para o projeto.

2. **Incentivo**
   - **Id_tmp_incentivos_salic**: Identificador temporário do registro (pode ser descartado).
   - **Pronac**: Identificador do projeto no Ministério da Cultura.
   - **Valor**: Valor do incentivo financeiro concedido ao projeto.
   - **Data_recibo**: Data de recebimento do incentivo.
   - **Nome_projeto**: Nome do projeto ao qual o incentivo está associado.

3. **Incentivador**
   - **Id**: Identificador único gerado automaticamente pelo PostgreSQL.
   - **Cgccpf**: CNPJ ou CPF do incentivador do projeto (CPF ocultado por questões de privacidade).
   - **Nome_doador**: Nome do incentivador.
   - **Tipo_pessoa**: Tipo de pessoa do incentivador (jurídica ou física).


#### Observações:

Para o campo cgccpf ser um CPF, ele é ocultado por questões de privacidade, seguindo as diretrizes da LGPD (Lei Geral de Proteção de Dados). Isso significa que, quando um CPF é armazenado no banco de dados, parte dele é substituído por asteriscos, preservando assim a privacidade do titular do CPF. Por esse motivo, esse campo não é adequado para ser usado como chave primária, pois não é uma informação única e identificável de forma direta.
