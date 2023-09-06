
CREATE TABLE regioes (
                regioes_id INT NOT NULL,
                regiao_nome VARCHAR(40) NOT NULL,
                CONSTRAINT pk_regioes PRIMARY KEY (regioes_id)
)

CREATE TABLE paises (
                paises_id INT NOT NULL,
                regioes_id INT NOT NULL,
                pais_nome VARCHAR(50) NOT NULL,
                CONSTRAINT pk_paises PRIMARY KEY (paises_id)
)

CREATE TABLE localidades (
                localidades_id INT NOT NULL,
                departamento_nome VARCHAR(100) NOT NULL,
                estado VARCHAR(30) NOT NULL,
                cidade VARCHAR(40) NOT NULL,
                paises_id INT NOT NULL,
                CONSTRAINT pk_localidades PRIMARY KEY (localidades_id)
)

CREATE TABLE cargos (
                cargos_id INT NOT NULL,
                cargo_nome VARCHAR(30) NOT NULL,
                CONSTRAINT pk_cargos PRIMARY KEY (cargos_id)
)

CREATE TABLE departamentos (
                departamentos_id INT NOT NULL,
                localidades_id INT NOT NULL,
                departamento_nome VARCHAR(50) NOT NULL,
                CONSTRAINT pk_departamentos PRIMARY KEY (departamentos_id)
)

CREATE TABLE empregados (
                empregados_id INT NOT NULL,
                departamentos_id INT NOT NULL,
                nome VARCHAR(30) NOT NULL,
                sobrenome VARCHAR(50) NOT NULL,
                email VARCHAR(50) NOT NULL,
                salario NUMERIC(8,2) NOT NULL,
                data_admissao DATETIME NOT NULL,
                cargos_id INT NOT NULL,
                CONSTRAINT pk_empregados PRIMARY KEY (empregados_id)
)

CREATE TABLE cargo_historico (
                cargo_historico_id INT NOT NULL,
                cargos_id INT NOT NULL,
                empregados_id INT NOT NULL,
                data_inicio DATETIME NOT NULL,
                data_fim DATETIME NOT NULL,
                CONSTRAINT pk_cargo_historico PRIMARY KEY (cargo_historico_id)
)

ALTER TABLE paises ADD CONSTRAINT regioes_paises_fk
FOREIGN KEY (regioes_id)
REFERENCES regioes (regioes_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE localidades ADD CONSTRAINT paises_localidades_fk
FOREIGN KEY (paises_id)
REFERENCES paises (paises_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE departamentos ADD CONSTRAINT localidades_departamentos_fk
FOREIGN KEY (localidades_id)
REFERENCES localidades (localidades_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE empregados ADD CONSTRAINT cargos_empregados_fk
FOREIGN KEY (cargos_id)
REFERENCES cargos (cargos_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE cargo_historico ADD CONSTRAINT cargos_cargo_historico_fk
FOREIGN KEY (cargos_id)
REFERENCES cargos (cargos_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE empregados ADD CONSTRAINT departamentos_empregados_fk1
FOREIGN KEY (departamentos_id)
REFERENCES departamentos (departamentos_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE cargo_historico ADD CONSTRAINT empregados_cargo_historico_fk
FOREIGN KEY (empregados_id)
REFERENCES empregados (empregados_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION