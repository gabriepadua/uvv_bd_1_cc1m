/* Criando usuário */
create user gabriel superuser createdb createrole einherit login password '123456';
/* Criando database */
create database uvv
with
owner = "gabriel"
template = template0
encoding = 'UTF8'
LC_COLLATE = 'pt_BR.UTF-8'
LC_CTYPE = 'pt_BR.UTF-8'
connection limit = -1;

/* Criando esquema elmasri */
CREATE SCHEMA elmasri AUTHORIZATION gabriel 
/* Botando o esquema elmasri como padrão */
set SEARCH_PATH to elmasri, "$user", public;
show search_path;
alter USER gabriel 
set SEARCH_PATH to elmasri, "$user", public;

/* Criando tabela funcionário */
CREATE TABLE funcionario (
                cpf CHAR(11) NOT NULL,
                primeiro_nome VARCHAR(15) NOT NULL,
                nome_meio CHAR(1),
                ultimo_nome VARCHAR(15) NOT NULL,
                data_nascimento DATE,
                endereco VARCHAR(50),
                sexo CHAR(1),
                salario NUMERIC(10,2),
                cpf_supervisor CHAR(11) NOT NULL,
                numero_departamento INTEGER NOT NULL,
                CONSTRAINT funcionario2 PRIMARY KEY (cpf)
);
/* Fazendo os comentários referentes a tabela funcionário e as colunas pertencentes à mesma */ 
COMMENT ON TABLE funcionario IS 'Tabela que armazena as informações dos funcionários';
COMMENT ON COLUMN funcionario.cpf IS 'CPF do funcionário';
COMMENT ON COLUMN funcionario.primeiro_nome IS 'Primeiro nome do funcionário';
COMMENT ON COLUMN funcionario.nome_meio IS 'Inicial do nome do meio';
COMMENT ON COLUMN funcionario.ultimo_nome IS 'Sobrenome do funcionário';
COMMENT ON COLUMN funcionario.endereco IS 'Endereço do funcionário';
COMMENT ON COLUMN funcionario.sexo IS 'Sexo do funcionário';
COMMENT ON COLUMN funcionario.salario IS 'Salário do funcionário';
COMMENT ON COLUMN funcionario.cpf_supervisor IS 'CPF do supervisor';
COMMENT ON COLUMN funcionario.numero_departamento IS 'Numéro do departamento do funcionário';

/* Criando tabela departamento */
CREATE TABLE departamento (
                numero_departamento INTEGER NOT NULL,
                nome_departamento VARCHAR(15) NOT NULL,
                cpf_gerente CHAR(11) NOT NULL,
                data_inicio_gerente DATE,
                CONSTRAINT departamento2 PRIMARY KEY (numero_departamento)
);
/* Fazendo comentários referentes a tabela departamento e as colunas pertencentes à mesma */
COMMENT ON TABLE departamento IS 'Tabela que armazena as informações dos departamentos';
COMMENT ON COLUMN departamento.numero_departamento IS 'Número do departamento.';
COMMENT ON COLUMN departamento.nome_departamento IS 'Nome do departamento.';
COMMENT ON COLUMN departamento.cpf_gerente IS 'CPF do gerente do departamento.';
COMMENT ON COLUMN departamento.data_inicio_gerente IS 'Data do início do gerente no departamento';

/* Criando index de departamento */
CREATE UNIQUE INDEX departamento_idx
 ON departamento
 ( nome_departamento );
/* Criando a tabela localizações departamento */
CREATE TABLE localizacoes_departamento (
                numero_departamento INTEGER NOT NULL,
                local VARCHAR(15) NOT NULL,
                CONSTRAINT localizacoes_departamento2 PRIMARY KEY (numero_departamento, local)
);
/* Fazendo comentários referentes a tabela localizações departamento e as colunas pertencentes à mesma */
COMMENT ON TABLE localizacoes_departamento IS 'Tabel aque armazena as possíveis localizações dos departamentos';
COMMENT ON COLUMN localizacoes_departamento.numero_departamento IS 'Número do departamento';
COMMENT ON COLUMN localizacoes_departamento.local IS 'Localização do departamento';

/* Criando a tabela projeto */
CREATE TABLE projeto (
                numero_projeto INTEGER NOT NULL,
                nome_projeto VARCHAR(15) NOT NULL,
                local_projeto VARCHAR(15),
                numero_departamento INTEGER NOT NULL,
                CONSTRAINT projeto2 PRIMARY KEY (numero_projeto)
);
/* Fazendo comentários referentes a tabela projeto e as colunas pertencentes à mesma */
COMMENT ON TABLE projeto IS 'Tabela que armazena as informações sobre os projetos dos departamentos';
COMMENT ON COLUMN projeto.numero_projeto IS 'Número do projeto';
COMMENT ON COLUMN projeto.nome_projeto IS 'Nome do projeto';
COMMENT ON COLUMN projeto.local_projeto IS 'Local do projeto';
COMMENT ON COLUMN projeto.numero_departamento IS 'Número do departamento';

/* Criando index de projeto */
CREATE UNIQUE INDEX projeto_idx
 ON projeto
 ( nome_projeto );
/* Criando a tabela trabalha em*/
CREATE TABLE trabalha_em (
                cpf_funcionario CHAR(11) NOT NULL,
                numero_projeto INTEGER NOT NULL,
                horas NUMERIC(3,1) NOT NULL,
                CONSTRAINT trabalha_em2 PRIMARY KEY (cpf_funcionario, numero_projeto)
);
/* Fazendo comentários referente a tabela trabalha_em e as colunas referentes à mesma */
COMMENT ON TABLE trabalha_em IS 'Tabela para armazenar quais funcionários trabalham em quais projetos';
COMMENT ON COLUMN trabalha_em.cpf_funcionario IS 'CPF do funcionário';
COMMENT ON COLUMN trabalha_em.numero_projeto IS 'Número do projeto';
COMMENT ON COLUMN trabalha_em.horas IS 'Horas trabalhadas pelo funcionário neste projeto';

/*Criando a tabela dependente */
CREATE TABLE dependente (
                cpf_funcionario CHAR(11) NOT NULL,
                nome_dependente VARCHAR(15) NOT NULL,
                sexo CHAR(1),
                data_nascimento DATE,
                parentesco VARCHAR(15),
                CONSTRAINT dependente2 PRIMARY KEY (cpf_funcionario, nome_dependente)
);
/* Fazendo comentários referente a tabela dependente e as colunas referentes à mesma */
COMMENT ON TABLE dependente IS 'Tabela que armazena as informações dos dependentes dos funcionários';
COMMENT ON COLUMN dependente.cpf_funcionario IS 'CPF do funcionário';
COMMENT ON COLUMN dependente.nome_dependente IS 'Nome do dependente.';
COMMENT ON COLUMN dependente.sexo IS 'Sexo do dependente';
COMMENT ON COLUMN dependente.data_nascimento IS 'Data de nascimento do dependente';
COMMENT ON COLUMN dependente.parentesco IS 'Descrição do parentesco do dependente com o funcionário';

/* Fazendo alterações de relacionamento e chafes na tabela Funcionário */
ALTER TABLE funcionario ADD CONSTRAINT funcionario_funcionario_fk
FOREIGN KEY (cpf_supervisor)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
/* Fazendo alterações de relacionamento e chafes na tabela Dependente */
ALTER TABLE dependente ADD CONSTRAINT funcionario_dependente_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
/* Fazendo alterações de referencias e chafes na tabela Trabalha em */
ALTER TABLE trabalha_em ADD CONSTRAINT funcionario_trabalha_em_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
/* Fazendo alterações de relacionamento e chafes na tabela Departamento */
ALTER TABLE departamento ADD CONSTRAINT funcionario_departamento_fk
FOREIGN KEY (cpf_gerente)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
/* Fazendo alterações de relacionamento e chafes na tabela Projeto */
ALTER TABLE projeto ADD CONSTRAINT departamento_projeto_fk
FOREIGN KEY (numero_departamento)
REFERENCES departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
/* Fazendo alterações de relacionamento e chafes na tabela Localizações departamento */
ALTER TABLE localizacoes_departamento ADD CONSTRAINT departamento_localizacoes_departamento_fk
FOREIGN KEY (numero_departamento)
REFERENCES departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
/* Fazendo alterações de relacionamento e chafes na tabela Trabalha em*/
ALTER TABLE trabalha_em ADD CONSTRAINT projeto_trabalha_em_fk
FOREIGN KEY (numero_projeto)
REFERENCES projeto (numero_projeto)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


/* Inserindo dados na relação funcionário */
insert into funcionario (primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
values ('Jorge', 'E', 'Brito','88866555576', '1937-11-10', 'Rua do Horto,35,São Paulo,SP', 'M', '55.000', '88866555576', '1');
insert into funcionario (primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
values ('Fernando', 'T', 'Wong', '33344555587', '1955-08-12', 'Rua da Lapa,34,São Paulo,SP', 'M', '40.000', '88866555576', '5'),
('João', 'B', 'Silva', '12345678966', '1968-12-08', 'Rua das Flores,751,São Paulo', 'M', '30.000', '33344555587', '5');
insert into funcionario (primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
values ('Jennifer', 'S', 'Souza', '98765432168', '1941-06-20', 'Av.Arthur de Lima,54,Santo André,SP', 'F', '43.000', '88866555576', '4'),
('Alice', 'J', 'Zelaya', '99988777767', '1968-01-19', 'Rua Souza Lima,35,Curitiba,PR', 'F', '25.000', '98765432168', '4');
insert into funcionario (primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
values ('Ronaldo', 'K', 'Lima', '66688444476', '1962-09-15', 'Rua Rebouças,65,Piracicaba,SP', 'M', '38.000', '33344555587', '5'), ('Joice','A','Leite','45345345376','1972-07-31', 'Av.Lucas Obes,74,São Paulo, SP', 'F', '25.000','33344555587', '5'),
('André', 'V', 'Pereira', '98798798733', '1969-03-29', 'Rua Timbiera, 35, São Paulo,SP', 'M', '25.000', '98765432168', '4');
/* Inserindo dados na relação departamento */
insert into departamento (nome_departamento, numero_departamento, cpf_gerente, data_inicio_gerente)
values ('Pesquisa', '5', '33344555587', '1988-05-22'), 
('Adminstarãço', '4', '98765432168', '1995-01-01'),
('Matriz', '1', '88866555576', '1981-06-19');
/* Inserindo dados na relação Localizações Departamento */
insert into localizacoes_departamento (numero_departamento, "local")
values ('1', 'São Paulo'), ('4', 'Mauá'), ('5', 'Santo André'), ('5', 'Itu'), ('5', 'São Paulo');
/* Inserindo dados na relação Projeto */
insert into projeto (nome_projeto, numero_projeto, local_projeto, numero_departamento)
values ('ProdutoX', '1', 'Santo André', '5'), ('ProdutoY', '2', 'Itu', '5'), ('ProdutoZ', '3', 'São Paulo', '5'), ('Informatiazãço', '10', 'Mauá', '4'),
('Reorganiazção', '20', 'São Paulo', '1'), ('Novosbeneficios', '30', 'Mauá', '4');
/* Inserindo dados na relação Dependente */
insert into dependente (cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
values ('33344555587', 'Alícia', 'F', '1986-04-05', 'Filha'), ('33344555587', 'Tiago', 'M', '1983-10-25', 'Filho'), ('33344555587', 'Janaina', 'F', '1958-05-03', 'Esposa'),
('98765432168', 'Antonio', 'M', '1942-02-28', 'Marido'), ('12345678966', 'Michael', 'M', '1988-01-04', 'Filho'), ('12345678966', 'Alícia', 'F', '1988-12-30', 'Filha'),
('12345678966', 'Eliazbeth', 'F', '1967-05-05', 'Esposa');
/*Inserindo dados na relação Dependente */
insert into trabalha_em (cpf_funcionario, numero_projeto, horas)
values ('12345678966', '1', '32.5'), ('12345678966', '2', '7.5'), ('66688444476', '3', '40'), ('45345345376', '1', '20'), ('45345345376', '2', '20'), ('33344555587', '2', '10'), ('33344555587', '3', '10'), ('33344555587', '10', '10'),
('33344555587', '20', '10'), ('99988777767', '30', '30'), ('99988777767','10' ,'10'), ('98798798733', '10', '35'), ('98798798733','30','5'), ('98765432168', '30', '20'), ('98765432168','20','15'), ('88866555576','20','0');
