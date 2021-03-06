/* No terminal, é realizado a operação "mysql -u root -pcomputacao@raiz
 * CREATE USER 'gabriel'@'localhost' IDENTIFIED BY '123456'
 * GRANT ALL PRIVILEGES on * . * to 'gabriel'@'localhost'
 * FLUSH PRIVILEGES; */

/*Criando database uvv */
create database uvv;
/*Selecionando a database uvv */
use uvv; ( 

/*Criando a tabela Funcionário*/
CREATE TABLE funcionario (
                cpf CHAR(11) NOT NULL,
                primeiro_nome VARCHAR(15) NOT NULL,
                nome_meio CHAR(1),
                ultimo_nome VARCHAR(15) NOT NULL,
                data_nascimento DATE,
                endereco VARCHAR(50),
                sexo CHAR(1),
                salario DECIMAL(10,2),
                cpf_supervisor CHAR(11) NOT NULL,
                numero_departamento INT NOT NULL,
                PRIMARY KEY (cpf)
);
/* Adicionando comentários na tabela Funcionário e suas colunas */
ALTER TABLE funcionario COMMENT 'Tabela que armazena as informações dos funcionários';

ALTER TABLE funcionario MODIFY COLUMN cpf CHAR(11) COMMENT 'CPF do funcionário';

ALTER TABLE funcionario MODIFY COLUMN primeiro_nome VARCHAR(15) COMMENT 'Primeiro nome do funcionário';

ALTER TABLE funcionario MODIFY COLUMN nome_meio CHAR(1) COMMENT 'Inicial do nome do meio';

ALTER TABLE funcionario MODIFY COLUMN ultimo_nome VARCHAR(15) COMMENT 'Sobrenome do funcionário';

ALTER TABLE funcionario MODIFY COLUMN endereco VARCHAR(50) COMMENT 'Endereço do funcionário';

ALTER TABLE funcionario MODIFY COLUMN sexo CHAR(1) COMMENT 'Sexo do funcionário';

ALTER TABLE funcionario MODIFY COLUMN salario DECIMAL(10, 2) COMMENT 'Salário do funcionário';

ALTER TABLE funcionario MODIFY COLUMN cpf_supervisor CHAR(11) COMMENT 'CPF do supervisor';

ALTER TABLE funcionario MODIFY COLUMN numero_departamento INTEGER COMMENT 'Numéro do departamento do funcionário';

/*Criando a tabela Departamento*/
CREATE TABLE departamento (
                numero_departamento INT NOT NULL,
                nome_departamento VARCHAR(15) NOT NULL,
                cpf_gerente CHAR(11) NOT NULL,
                data_inicio_gerente DATE,
                PRIMARY KEY (numero_departamento)
);
/* Adicionando comentários na tabela Departamento e suas colunas */
ALTER TABLE departamento COMMENT 'Tabela que armazena as informações dos departamentos';

ALTER TABLE departamento MODIFY COLUMN numero_departamento INTEGER COMMENT 'Número do departamento.';

ALTER TABLE departamento MODIFY COLUMN nome_departamento VARCHAR(15) COMMENT 'Nome do departamento.';

ALTER TABLE departamento MODIFY COLUMN cpf_gerente CHAR(11) COMMENT 'CPF do gerente do departamento.';

ALTER TABLE departamento MODIFY COLUMN data_inicio_gerente DATE COMMENT 'Data do início do gerente no departamento';


CREATE UNIQUE INDEX departamento_idx
 ON departamento
 ( nome_departamento );
/*Criando a tabela Localizações Departamento*/
CREATE TABLE localizacoes_departamento (
                numero_departamento INT NOT NULL,
                local VARCHAR(15) NOT NULL,
                PRIMARY KEY (numero_departamento, local)
);
/* Adicionando comentários na tabela Localizações Departamento e suas colunas */
ALTER TABLE localizacoes_departamento COMMENT 'Tabel aque armazena as possíveis localizações dos departamentos';

ALTER TABLE localizacoes_departamento MODIFY COLUMN numero_departamento INTEGER COMMENT 'Número do departamento';

ALTER TABLE localizacoes_departamento MODIFY COLUMN local VARCHAR(15) COMMENT 'Localização do departamento';

/*Criando a tabela Projeto*/
CREATE TABLE projeto (
                numero_projeto INT NOT NULL,
                nome_projeto VARCHAR(15) NOT NULL,
                local_projeto VARCHAR(15),
                numero_departamento INT NOT NULL,
                PRIMARY KEY (numero_projeto)
);
/* Adicionando comentários na tabela Projeto e suas colunas */
ALTER TABLE projeto COMMENT 'Tabela que armazena as informações sobre os projetos dos departamentos';

ALTER TABLE projeto MODIFY COLUMN numero_projeto INTEGER COMMENT 'Número do projeto';

ALTER TABLE projeto MODIFY COLUMN nome_projeto VARCHAR(15) COMMENT 'Nome do projeto';

ALTER TABLE projeto MODIFY COLUMN local_projeto VARCHAR(15) COMMENT 'Local do projeto';

ALTER TABLE projeto MODIFY COLUMN numero_departamento INTEGER COMMENT 'Número do departamento';


CREATE UNIQUE INDEX projeto_idx
 ON projeto
 ( nome_projeto );
/*Criando a tabela Trabalha em*/
CREATE TABLE trabalha_em (
                cpf_funcionario CHAR(11) NOT NULL,
                numero_projeto INT NOT NULL,
                horas DECIMAL(3,1) NOT NULL,
                PRIMARY KEY (cpf_funcionario, numero_projeto)
);
/* Adicionando comentários na tabela Trabalha em e suas colunas */
ALTER TABLE trabalha_em COMMENT 'Tabela para armazenar quais funcionários trabalham em quais projetos';

ALTER TABLE trabalha_em MODIFY COLUMN cpf_funcionario CHAR(11) COMMENT 'CPF do funcionário';

ALTER TABLE trabalha_em MODIFY COLUMN numero_projeto INTEGER COMMENT 'Número do projeto';

ALTER TABLE trabalha_em MODIFY COLUMN horas DECIMAL(3, 1) COMMENT 'Horas trabalhadas pelo funcionário neste projeto';

/*Criando a tabela Dependente*/
CREATE TABLE dependente (
                cpf_funcionario CHAR(11) NOT NULL,
                nome_dependente VARCHAR(15) NOT NULL,
                sexo CHAR(1),
                data_nascimento DATE,
                parentesco VARCHAR(15),
                PRIMARY KEY (cpf_funcionario, nome_dependente)
);
/* Adicionando comentários na tabela Dependente e suas colunas */
ALTER TABLE dependente COMMENT 'Tabela que armazena as informações dos dependentes dos funcionários';

ALTER TABLE dependente MODIFY COLUMN cpf_funcionario CHAR(11) COMMENT 'CPF do funcionário';

ALTER TABLE dependente MODIFY COLUMN nome_dependente VARCHAR(15) COMMENT 'Nome do dependente.';

ALTER TABLE dependente MODIFY COLUMN sexo CHAR(1) COMMENT 'Sexo do dependente';

ALTER TABLE dependente MODIFY COLUMN data_nascimento DATE COMMENT 'Data de nascimento do dependente';

ALTER TABLE dependente MODIFY COLUMN parentesco VARCHAR(15) COMMENT 'Descrição do parentesco do dependente com o funcionário';

/*Fazendo alterações referente a relacionamentos e chaves na tabela funcionário*/
ALTER TABLE funcionario ADD CONSTRAINT funcionario_funcionario_fk
FOREIGN KEY (cpf_supervisor)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;
/*Fazendo alterações referente a relacionamentos e chaves na tabela dependente*/
ALTER TABLE dependente ADD CONSTRAINT funcionario_dependente_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;
/*Fazendo alterações referente a relacionamentos e chaves na tabela trabalha em*/
ALTER TABLE trabalha_em ADD CONSTRAINT funcionario_trabalha_em_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;
/*Fazendo alterações referente a relacionamentos e chaves na tabela departamento*/
ALTER TABLE departamento ADD CONSTRAINT funcionario_departamento_fk
FOREIGN KEY (cpf_gerente)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;
/*Fazendo alterações referente a relacionamentos e chaves na tabela projeto*/
ALTER TABLE projeto ADD CONSTRAINT departamento_projeto_fk
FOREIGN KEY (numero_departamento)
REFERENCES departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;
/*Fazendo alterações referente a relacionamentos e chaves na tabela localizações departamento*/
ALTER TABLE localizacoes_departamento ADD CONSTRAINT departamento_localizacoes_departamento_fk
FOREIGN KEY (numero_departamento)
REFERENCES departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;
/*Fazendo alterações referente a relacionamentos e chaves na tabela trabalha em*/
ALTER TABLE trabalha_em ADD CONSTRAINT projeto_trabalha_em_fk
FOREIGN KEY (numero_projeto)
REFERENCES projeto (numero_projeto)
ON DELETE NO ACTION
ON UPDATE NO ACTION;
/*Inserindo dados na relação funcionário*/
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
/*Inserindo dados na relação departamento*/
insert into departamento (nome_departamento, numero_departamento, cpf_gerente, data_inicio_gerente)
values ('Pesquisa', '5', '33344555587', '1988-05-22'), 
('Adminstarãço', '4', '98765432168', '1995-01-01'),
('Matriz', '1', '88866555576', '1981-06-19');
/*Inserindo dados na relação localizações departamento*/
insert into localizacoes_departamento (numero_departamento, local)
values ('1', 'São Paulo'), ('4', 'Mauá'), ('5', 'Santo André'), ('5', 'Itu'), ('5', 'São Paulo');
/*Inserindo dados na relação projeto*/
insert into projeto (nome_projeto, numero_projeto, local_projeto, numero_departamento)
values ('ProdutoX', '1', 'Santo André', '5'), ('ProdutoY', '2', 'Itu', '5'), ('ProdutoZ', '3', 'São Paulo', '5'), ('Informatiazãço', '10', 'Mauá', '4'),
('Reorganiazção', '20', 'São Paulo', '1'), ('Novosbeneficios', '30', 'Mauá', '4');
/*Inserindo dados na relação dependente*/
insert into dependente (cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
values ('33344555587', 'Alícia', 'F', '1986-04-05', 'Filha'), ('33344555587', 'Tiago', 'M', '1983-10-25', 'Filho'), ('33344555587', 'Janaina', 'F', '1958-05-03', 'Esposa'),
('98765432168', 'Antonio', 'M', '1942-02-28', 'Marido'), ('12345678966', 'Michael', 'M', '1988-01-04', 'Filho'), ('12345678966', 'Alícia', 'F', '1988-12-30', 'Filha'),
('12345678966', 'Eliazbeth', 'F', '1967-05-05', 'Esposa');
/*Inserindo dados na relação trabalha em*/
insert into trabalha_em (cpf_funcionario, numero_projeto, horas)
values ('12345678966', '1', '32.5'), ('12345678966', '2', '7.5'), ('66688444476', '3', '40'), ('45345345376', '1', '20'), ('45345345376', '2', '20'), ('33344555587', '2', '10'), ('33344555587', '3', '10'), ('33344555587', '10', '10'),
('33344555587', '20', '10'), ('99988777767', '30', '30'), ('99988777767','10' ,'10'), ('98798798733', '10', '35'), ('98798798733','30','5'), ('98765432168', '30', '20'), ('98765432168','20','15'), ('88866555576','20','0');






