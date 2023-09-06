--BOOTCAMP IGTI
--M�DULO 02
--DESAFIO 01
--26/07/2020



--ATIVIDADE 01: Desenvolver o script DDL para criar um banco de dados com o nome
--CRIAR O BANCO DE DADOS RELACIONAL
CREATE DATABASE BDProducoes
GO

--USAR O BANCO DE DADOS BDProducoes
USE BDProducoes
GO

--ATIVIDADE 02: Desenvolver o script DDL para criar, no banco criado no item anterior, todos os objetos existentes no modelo de dados.
--ATIVIDADE 03: Desenvolver o script DDL para garantir que todos os t�tulos tenham nome. (RESTRI��O NOT NULL na coluna nom_titulo)
--------------------------------------------------------------------------------------------------------------------------------------
--CRIAR AS TABELAS J� COM AS VARI�VEIS E AS CONSTRAINT: INICIO

--TABELA T�TULO
CREATE TABLE Titulo
(
	cod_titulo INT PRIMARY KEY CLUSTERED NOT NULL,			--CONSTRAINT PRIMARY KEY REPRESENTA A CHAVE PRIM�RIA, CLUSTERED E PARA ORGANIZAR EM ORDEM CRESCENTE POR ESSA CHAVE
	nom_titulo VARCHAR(100) NOT NULL						--NOT NULL � PQ N�O PODE PREENCHER ESSE REGISTRO SEM VINCULAR UM VALOR A ESSA COLUNA
);
GO

--TABELA PESSOA
CREATE TABLE Pessoa
( 
	cod_pessoa INT PRIMARY KEY CLUSTERED NOT NULL,
	nom_pessoa VARCHAR(500) NOT NULL,
	ano_nascimento INT NULL,
	ano_falecimento INT NULL,
	dsc_profissao VARCHAR(1000) NULL
);
GO

--TABELA DIRE��O
CREATE TABLE Direcao
(
	cod_direcao INT PRIMARY KEY IDENTITY (1,1),		--IDENTITY � UM AUTOINCREMENTO. ESSE INICIA NO 1 E ADICIONA SEMPRE +1
	
	cod_titulo_fk INT NOT NULL,			
		CONSTRAINT FK_Direcao_Titulo				--ADICIONANDO A RESTRI��O DE FOREIGN KEY (RELACIONAMENTO)
		FOREIGN KEY (cod_titulo_fk)					--VINCULANDO A VARI�VEL DA TABELA DIRE��O
		REFERENCES Titulo(cod_titulo)				--VINCULANDO A VARIV�VEL DA TABELA T�TULO
		ON UPDATE NO ACTION							--N�O FA�O IDEIA, TO USANDO PQ O PROFESSOR USOU, MAS ACHO QUE � PARA POSTERGAR O TRATAMENTO DE ALGUM ERRO
		ON DELETE NO ACTION,						--IDEM
	cod_pessoa_fk INT NOT NULL,						--CRIANDO A SEGUNDA FOREIGN KEY
		CONSTRAINT FK_Direcao_Pessoa
		FOREIGN KEY (cod_pessoa_fk)
		REFERENCES Pessoa(cod_pessoa)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION
);
GO

--TABELA AUTORIA
CREATE TABLE Autoria
(
	cod_autoria INT PRIMARY KEY CLUSTERED IDENTITY(1,1),
	cod_titulo_fk INT NOT NULL,
		CONSTRAINT FK_Autoria_Titulo 
		FOREIGN KEY (cod_titulo_fk)
		REFERENCES Titulo(cod_titulo)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION,
	cod_pessoa_fk INT NOT NULL,
		CONSTRAINT FK_Autoria_Pessoa
		FOREIGN KEY (cod_pessoa_fk)
		REFERENCES Pessoa(cod_pessoa)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION
);
GO

--TABELA ELENCON
CREATE TABLE Elenco
(
	cod_elenco INT PRIMARY KEY CLUSTERED IDENTITY (1,1),
	cod_titulo_fk INT NOT NULL,
		CONSTRAINT FK_Elenco_Titulo
		FOREIGN KEY (cod_titulo_fk)
		REFERENCES Titulo(cod_titulo)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION,
	cod_pessoa_fk INT NOT NULL,
		CONSTRAINT FK_Elencon_Pessoa
		FOREIGN KEY (cod_pessoa_fk)
		REFERENCES Pessoa(cod_pessoa)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION,
	dsc_funcao VARCHAR(1000) NOT NULL,
	desc_personagem VARCHAR(1000) NULL
);
GO

--TABELA DETALHE
CREATE TABLE Detalhe
(
	cod_titulo_fk INT NOT NULL,
		CONSTRAINT FK_Detalhe_Titulo
		FOREIGN KEY (cod_titulo_fk)
		REFERENCES Titulo(cod_titulo)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION,
	tip_titulo VARCHAR(100) NOT NULL,
	nom_principal_titulo VARCHAR(1000) NOT NULL,
	nom_original_titulo  VARCHAR(1000) NOT NULL,
	ind_adulto BIT NOT NULL,
	ano_lancamento INT NOT NULL,
	qtd_minutos SMALLINT NULL,
	dsc_genero VARCHAR(1000) NULL
);
GO

--TABELA AVALIA��O
CREATE TABLE Avaliacao
(
	cod_titulo_fk INT NOT NULL,
		CONSTRAINT FK_Avaliacao_titulo
		FOREIGN KEY (cod_titulo_fk)
		REFERENCES Titulo(cod_titulo)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION,
	classificacao_media INT NOT NULL,
	qtd_votos INT NOT NULL
);
GO

--CRIAR AS TABELAS J� COM AS VARI�VEIS E AS CONSTRAINT: FIM
--------------------------------------------------------------------------------------------------------------------------------------


--ATIVIDADE 04: aumentar a coluna nom_pessoa da tabela Pessoa para 1.000 caracteres
ALTER TABLE Pessoa ALTER COLUMN nom_pessoa VARCHAR(1000) NOT NULL;
	sp_help 'pessoa'		--para verificar se realmente foi alterado o length da coluna nom_pessoa para 1000 caracter 

--------------------------------------------------------------------------------------------------------------------------------------


--ATIVIDADE 05: incluir um campo (ind_status char(1) NOT NULL) na tabela t�tulo
ALTER TABLE Titulo ADD ind_status CHAR(1) NOT NULL;
	sp_help 'TITULO'		--para verificar se realmente foi adicionado a coluna desejada 

--------------------------------------------------------------------------------------------------------------------------------------
--RECOMENDO POVOAR O BANCO DE DADOS (RESOLVER A QUEST�O 07), ANTES DE FAZER A 06
--ATIVIDADE 06: CONSULTAR:

--ATIVIDADE 06-a:Total de t�tulo ativos.
SELECT COUNT(cod_titulo) FROM Titulo WHERE ind_status	=	'A'

--ATIVIDADE 06-b:Rela��o dos t�tulos em ordem alfab�tica e seus detalhes.
SELECT	T.nom_titulo			AS	'T�tulo',					--AS � para definir o nome que quero mostrar ao cliente,
		D.tip_titulo			AS	'Tipo de T�tulo',			--n�o � um sinonimo, n�o fica salvo na memoria, 
		D.nom_principal_titulo  AS	'Nome Principal T�tulo',	--apenas quando eu rodo essa querry
		D.nom_original_titulo	AS	'Nome Original T�tulo',
		D.ind_adulto			AS	'Indica��o Filme Adulto',
		D.qtd_minutos			AS	'Dura��o Filme em Minutos',
		D.dsc_genero			AS	'G�nero do Filme'
FROM		Titulo AS T												--o AS � para ALIAS, para n�o precisar escrever o nome todo na hora de definir a coluna. 
LEFT JOIN	Detalhe AS D	ON	T.cod_titulo = D.cod_titulo_fk		--Pq eu quero apenas a informa��o 						
ORDER BY	T.nom_titulo asc;											--� bom utilizar, n�o � obrigat�rio.

--ATIVIDADE 06-c:Rela��o dos t�tulos em ordem alfab�tica, seus autores e diretores (quando existirem essas duas �ltimas informa��es).
SELECT	T.nom_titulo	AS	'Titulo',
		P.nom_pessoa	AS	'Nome Diretor',
		P2.nom_pessoa	AS	'Nome Autor'	
FROM	Titulo AS T
INNER JOIN	Direcao AS	D	ON	T.cod_titulo	=	D.cod_titulo_fk		--S� VAI MOSTRAR QUANDO TIVER DIRETOR E AUTOR
INNER JOIN	Pessoa	AS	P	ON	D.cod_pessoa_fk	=	P.cod_pessoa
INNER JOIN	Autoria	AS	A	ON	T.cod_titulo	=	A.cod_titulo_fk
INNER JOIN	Pessoa	AS	P2	ON	A.cod_pessoa_fk	=	P2.cod_pessoa
ORDER BY	T.nom_titulo;


--ATIVIDADE 06-d:Rela��o dos 100 t�tulos mais bem avaliados, suas avalia��es e total de votos.
SELECT TOP 100	T.nom_titulo			AS	'T�tulo',
				A.classificacao_media	AS	'Avalia��o',
				A.qtd_votos				AS	'Quantidade de Votos'
FROM	Titulo	AS T
INNER JOIN Avaliacao	AS	A	ON	T.cod_titulo	=	A.cod_titulo_fk
ORDER BY A.classificacao_media DESC;

-------------------------------------------------------------------------------------------------------------------------------------

--ATIVIDADE 07: Carregar as tabelas

BULK INSERT BDProducoes.dbo.Titulo
FROM 'C:\desafio01\Titulo.txt'
WITH ( FIELDTERMINATOR ='\t',
ROWTERMINATOR ='\n',
--Manter os valores nos arquivos para colunas com a prop. IDENTITY
KEEPIDENTITY
);

BULK INSERT BDProducoes.dbo.Avaliacao
FROM 'C:\desafio01\Avaliacao.txt'
WITH ( FIELDTERMINATOR ='\t',
ROWTERMINATOR ='\n',
--Manter os valores nos arquivos para colunas com a prop. IDENTITY
KEEPIDENTITY
);

BULK INSERT BDProducoes.dbo.Pessoa
FROM 'C:\desafio01\Pessoa.txt'
WITH ( FIELDTERMINATOR ='\t',
ROWTERMINATOR ='\n',
--Manter os valores nos arquivos para colunas com a prop. IDENTITY
KEEPIDENTITY
);

BULK INSERT BDProducoes.dbo.Direcao
FROM 'C:\desafio01\Direcao.txt'
WITH ( FIELDTERMINATOR ='\t',
ROWTERMINATOR ='\n',
--Manter os valores nos arquivos para colunas com a prop. IDENTITY
KEEPIDENTITY
);

BULK INSERT BDProducoes.dbo.Autoria
FROM 'C:\desafio01\Autoria.txt'
WITH ( FIELDTERMINATOR ='\t',
ROWTERMINATOR ='\n',
--Manter os valores nos arquivos para colunas com a prop. IDENTITY
KEEPIDENTITY
);

BULK INSERT BDProducoes.dbo.Detalhe
FROM 'C:\desafio01\Detalhe.txt'
WITH ( FIELDTERMINATOR ='\t',
ROWTERMINATOR ='\n',
--Manter os valores nos arquivos para colunas com a prop. IDENTITY
KEEPIDENTITY
);

BULK INSERT BDProducoes.dbo.Elenco
FROM 'C:\desafio01\Elenco.txt'
WITH ( FIELDTERMINATOR ='\t',
ROWTERMINATOR ='\n',
--Manter os valores nos arquivos para colunas com a prop. IDENTITY
KEEPIDENTITY
);

--------------------------------------------------------------------------------------------------------------------------------------
--ATIVIDADE 08: criar uma query para cada uma das situa��es

--ATIVIDADE 08-a: T�tulos sem avalia��o
SELECT 

SELECT	T.nom_titulo	AS	Nome, 
		A.qtd_votos,
		CASE
			WHEN	A.qtd_votos	>	0	THEN	'Titulo com avalia��o'
			ElSE								'T�tulo sem avalia��o'
		END AS Avaliacao
FROM	Titulo	AS T
LEFT JOIN	Avaliacao	AS	A	ON	T.cod_titulo	=	A.cod_titulo_fk
WHERE A.cod_titulo_fk  IS NULL -- CASO RETIRE ESSA RESTRI��O, MOSTRAR� TODOS OS T�TULOS, INFORMANDO SE H� OU N�O AVALIA��O
ORDER BY A.qtd_votos

--Segue abaixo uma segunda forma de fazer
SELECT * FROM Titulo AS T 
LEFT JOIN Avaliacao A ON T.cod_titulo = A.cod_titulo_fk 
WHERE A.cod_titulo_fk  IS NULL



--ATIVIDADE 08-b: T�tulos sem o detalhe da dura��o (qtd_minutos) ou informa��o do g�nero (dsc_genero)
SELECT * FROM	Titulo	AS	T
LEFT JOIN	Detalhe	AS	D	ON	T.cod_titulo	=	D.cod_titulo_fk
WHERE	D.qtd_minutos IS NULL	OR D.dsc_genero IS NULL

--ATIVIDADE 08-C: T�tulos sem autor
SELECT * FROM	Titulo	WHERE	cod_titulo	not in (SELECT cod_titulo_fk FROM Autoria)

--ATIVIDADE 08-D: T�tulos sem Diretor
SELECT * FROM	Titulo	WHERE	cod_titulo	not in (SELECT cod_titulo_fk FROM Direcao)

--ATIVIDADE 08-E: T�tulos sem autor
SELECT * FROM	Titulo	WHERE	cod_titulo	not in (SELECT cod_titulo_fk FROM Elenco)

--------------------------------------------------------------------------------------------------------------------------------------


--EXCLUIR ALGUMA TABLEA
DROP TABLE Autoria



