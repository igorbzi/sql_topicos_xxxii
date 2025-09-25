BEGIN

CREATE TABLE tipos_veiculos(
  codTipo int not null,
  descricao varchar(30) not null,
  PRIMARY KEY(codTipo)
);

CREATE TABLE habilitacoes(
  codH int not null, 
  tipo varchar(30) not null, 
  idade_min smallint not null, 
  descricao varchar(100) not null,
  PRIMARY KEY(codH)
);

CREATE TABLE veiculos(
  matricula serial not null, 
  nome varchar(30) not null, 
  modelo varchar(50) not null, 
  comprimento numeric(10,2) not null, 
  potMotor numeric(10,2) not null,
  vlDiaria numeric(10,2) not null, 
  codTipo int not null,
  PRIMARY KEY(matricula),
  FOREIGN KEY (codTipo) REFERENCES tipos_veiculos
);

CREATE TABLE funcionarios(
  codF serial not null, 
  nome varchar(100) not null, 
  telefone varchar(15) not null, 
  endereco varchar(150) not null, 
  idade smallint not null, 
  salario numeric(10,2) not null,
  PRIMARY KEY(codF)
);

CREATE TABLE veiculos_habilitacoes(
  codTipo int not null,
  codH int not null,
  FOREIGN KEY (codTipo) REFERENCES tipos_veiculos,
  FOREIGN KEY (codH) REFERENCES habilitacoes
);

CREATE TABLE clientes(
  CPF varchar(11) not null, 
  nome varchar(50) not null, 
  endereco varchar(150) not null, 
  estado_civil varchar(20), 
  num_filhos int,
  data_nasc date not null, 
  telefone varchar(15) not null,
  codH int not null,
  PRIMARY KEY(CPF), 
  FOREIGN KEY (codH) REFERENCES habilitacoes
);

CREATE TABLE locacoes(
  codLoc serial not null,
  valor numeric(10,2) not null, 
  inicio date not null, 
  fim date, 
  obs varchar(150) not null, 
  matricula int not null,
  codF int not null,
  CPF varchar(11) not null,
  FOREIGN KEY (matricula) REFERENCES veiculos, 
  FOREIGN KEY (codF) REFERENCES funcionarios, 
  FOREIGN KEY (CPF) REFERENCES clientes,

  constraint DatasCoerentes check(fim >= inicio or fim is null)
);

END;