/*Após o schema físico ter sido criado, apareceu a necessidade de aumentar a coluna nom_pessoa da tabela Pessoa para 1.000 caracteres. Monte o comando DDL para realizar essa ação, considerando que a tabela não pode ser recriada.*/

 ALTER TABLE pessoa ALTER COLUMN nom_pessoa varchar(1000);


/*Após o banco de dados ter sido populado com dados de exemplo, a empresa viu a necessidade de incluir um campo (ind_status char(1) NOT NULL) para informar se o título (produção) se encontra disponível para comercialização (ativo) ou se foi descontinuado (inativo). Qual(is) seria(m) o(s) comando(s) DDL para realizar essa alteração, sem ter que recriar a tabela Titulo?*/


ALTER TABLE titulo ADD ind_status char(1) default

/*Para finalizar essa primeira parte do projeto, a empresa solicitou que você elaborasse os comandos DML para realizar as consultas básicas abaixo, que alimentarão o dashboard do portfólio dos produtos da plataforma:*/
-- a. Total de título ativos.*
	SELECT COUNT(IND_STATUS) FROM Titulo
--  b. Relação dos títulos em ordem alfabética e seus detalhes.
	SELECT * FROM Titulo_Detalhe ORDER BY nom_principal_titulo ASC
--c. Relação dos títulos em ordem alfabética, seus autores e diretores (quando existirem essas duas últimas informações).
	SELECT tit.nom_titulo,el.dsc_funcao,p.nom_pessoa FROM Elenco as el	
	inner join Titulo as tit on tit.cod_titulo = el.cod_titulo
	inner join Pessoa as  p on p.cod_pessoa = el.cod_pessoa
	where el.dsc_funcao in ('actor','director')
	order by tit.nom_titulo asc
--d. Relação dos 100 títulos mais bem avaliados, suas avaliações e total de votos.

SELECT TOP 100 AVG(AV.classificacao_media) AS media,TIT.nom_titulo FROM Avaliacao AS AV
INNER JOIN Titulo AS TIT ON TIT.cod_titulo = AV.cod_titulo
GROUP BY TIT.nom_titulo, AV.cod_titulo,av.classificacao_media 
ORDER BY AV.classificacao_media desc


/*A empresa solicitou que você faça uma espécie de “auditoria da qualidade dos dados”. Para isso, você precisa criar uma query para cada uma das situações abaixo:*/
-- Títulos sem avaliação

SELECT * FROM Titulo AS TIT
LEFT JOIN Avaliacao AS AV ON AV.cod_titulo = TIT.cod_titulo
WHERE AV.cod_titulo IS  NULL

-- Títulos sem autor

select * from Titulo as tit
LEFT JOIN Autoria AS AT ON AT.cod_titulo = tit.cod_titulo
WHERE AT.cod_titulo IS NULL
-- Títulos sem diretor

select * from Titulo as tit
LEFT JOIN Direcao AS D ON D.cod_titulo = tit.cod_titulo
WHERE D.cod_titulo IS NULL

--  Títulos sem elenco

select * from Titulo as tit
LEFT JOIN Elenco AS EL ON EL.cod_titulo = tit.cod_titulo
WHERE EL.cod_titulo IS NULL