/*empregados
	-departamento_id
	-nome
	-salario
	-email
	-empregado_id
	-cargo_id
	-sobrenome
	-data_admissao
*/

CREATE TABLE empregados (
	empregado_id int primary key,
	nome varchar (30),
	sobrenome varchar (50),
	salario decimal (8,2),
	email varchar (50),
	data_admissao date,
	cargo_id int,
	departamento_id int
);

/*	
departamentos
	-departamento_nome
	-departamento_id
	-localidade_id
*/

CREATE TABLE departamentos (
	departamento_nome int primary key,
	departamento_nome varchar (50),
	localidade_id int
);

ALTER TABLE empregados ADD CONSTRAINT FK_EMP_DEP FOREIGN KEY (departamento_id) REFERENCES departamentos (departamento_id);

CREATE UNIQUE INDEX IX_EMAIL_EMP ON empregados(email);


/*
cargos
	-cargo_nome
	-cargo_id
*/

CREATE TABLE cargos (
	cargo_nome int primary key,
	cargo_id varchar (30),
	cargo_historico_id int,
	empregado_id int
);

/*
cargo_historico
	-data_inicio
	-data_fim
	-empregado_id
	-cargo_id
	-cargo_historico_id
*/

CREATE TABLE cargo_historico (
	cargo_historico_id int primary key,
	data_inicio date,
	data_fim date,
	cargo_id int,
	empregado_id int
);

/*
localidades
	-cidade
	-estado
	-localidade_id
	-endereco
	-pais_id
*/

CREATE TABLE localidades (
	localidade_id int primary key,
	cidade varchar (30),
	estado varchar (40),
	pais_id int,
	departamento_id int
);

/*	
paises
	-pais_id
	-pais_nome
	-regiao_id
*/

CREATE TABLE paises (
	pais_id int primary key,
	pais_nome varchar (50),
	localidade_id int,
	regiao_id int
);
	
/*
regioes
	-regiao_id
	-regiao_nome
*/

CREATE TABLE regioes (
	regiao_id int primary key,
	regiao_nome varchar (40),
	pais_id int
);
	

	
	
	