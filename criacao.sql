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
  matricula numeric(11) not null, 
  nome varchar(30) not null, 
  modelo varchar(50) not null, 
  comprimento int not null, 
  potMotor int not null,
  vlDiaria int not null, 
  codTipo int not null,
  PRIMARY KEY(matricula),
  FOREIGN KEY codTipo REFERENCES TiposVeiculos
);

CREATE TABLE funcionarios(
  codF int not null, 
  nome varchar(100) not null, 
  telefone numeric(10) not null, 
  endereco varchar(100) not null, 
  idade smallint not null, 
  salario int not null,
  PRIMARY KEY(codF)
);

CREATE TABLE veiculos_habilitacoes(
  codTipo int not null,
  codH int not null,
  FOREIGN KEY codTipo REFERENCES tipos_veiculos,
  FOREIGN KEY codH REFERENCES habilitacoes
);

CREATE TABLE clientes(
  CPF numeric(11) not null, 
  nome varchar(50) not null, 
  endereco varchar(100) not null, 
  estado_civil varchar(20), 
  num_filhos int,
  data_nasc date not null, 
  telefone numeric(10) not null,
  codH int not null,
  PRIMARY KEY(CPF), 
  FOREIGN KEY codH REFERENCES habilitacoes
);

CREATE TABLE locacoes(
  codLoc int not null,
  valor int not null, 
  inicio date not null, 
  fim date, 
  obs varchar(150) not null, 
  matricula numeric(11) not null,
  codF int not null,
  CPF numeric(11) not null,
  FOREIGN KEY matricula REFERENCES veiculos, 
  FOREIGN KEY codF REFERENCES funcionarios, 
  FOREIGN KEY CPF REFERENCES clientes,

  constraint DatasCoerentes check(fim >= inicio or fim is null);
  constraint CarroDisponivel check(matricula not in (select matricula from locacoes where fim is null))
);

END;