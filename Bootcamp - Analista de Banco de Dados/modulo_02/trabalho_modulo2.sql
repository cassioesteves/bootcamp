/*Ap�s o schema f�sico ter sido criado, apareceu a necessidade de aumentar a coluna nom_pessoa da tabela Pessoa para 1.000 caracteres. Monte o comando DDL para realizar essa a��o, considerando que a tabela n�o pode ser recriada.*/

 ALTER TABLE pessoa ALTER COLUMN nom_pessoa varchar(1000);


/*Ap�s o banco de dados ter sido populado com dados de exemplo, a empresa viu a necessidade de incluir um campo (ind_status char(1) NOT NULL) para informar se o t�tulo (produ��o) se encontra dispon�vel para comercializa��o (ativo) ou se foi descontinuado (inativo). Qual(is) seria(m) o(s) comando(s) DDL para realizar essa altera��o, sem ter que recriar a tabela Titulo?*/


ALTER TABLE titulo ADD ind_status char(1) default

/*Para finalizar essa primeira parte do projeto, a empresa solicitou que voc� elaborasse os comandos DML para realizar as consultas b�sicas abaixo, que alimentar�o o dashboard do portf�lio dos produtos da plataforma:*/
-- a. Total de t�tulo ativos.*
	SELECT COUNT(IND_STATUS) FROM Titulo
--  b. Rela��o dos t�tulos em ordem alfab�tica e seus detalhes.
	SELECT * FROM Titulo_Detalhe ORDER BY nom_principal_titulo ASC
--c. Rela��o dos t�tulos em ordem alfab�tica, seus autores e diretores (quando existirem essas duas �ltimas informa��es).
	SELECT tit.nom_titulo,el.dsc_funcao,p.nom_pessoa FROM Elenco as el	
	inner join Titulo as tit on tit.cod_titulo = el.cod_titulo
	inner join Pessoa as  p on p.cod_pessoa = el.cod_pessoa
	where el.dsc_funcao in ('actor','director')
	order by tit.nom_titulo asc
--d. Rela��o dos 100 t�tulos mais bem avaliados, suas avalia��es e total de votos.

SELECT TOP 100 AVG(AV.classificacao_media) AS media,TIT.nom_titulo FROM Avaliacao AS AV
INNER JOIN Titulo AS TIT ON TIT.cod_titulo = AV.cod_titulo
GROUP BY TIT.nom_titulo, AV.cod_titulo,av.classificacao_media 
ORDER BY AV.classificacao_media desc


/*A empresa solicitou que voc� fa�a uma esp�cie de �auditoria da qualidade dos dados�. Para isso, voc� precisa criar uma query para cada uma das situa��es abaixo:*/
-- T�tulos sem avalia��o

SELECT * FROM Titulo AS TIT
LEFT JOIN Avaliacao AS AV ON AV.cod_titulo = TIT.cod_titulo
WHERE AV.cod_titulo IS  NULL

-- T�tulos sem autor

select * from Titulo as tit
LEFT JOIN Autoria AS AT ON AT.cod_titulo = tit.cod_titulo
WHERE AT.cod_titulo IS NULL
-- T�tulos sem diretor

select * from Titulo as tit
LEFT JOIN Direcao AS D ON D.cod_titulo = tit.cod_titulo
WHERE D.cod_titulo IS NULL

--  T�tulos sem elenco

select * from Titulo as tit
LEFT JOIN Elenco AS EL ON EL.cod_titulo = tit.cod_titulo
WHERE EL.cod_titulo IS NULL