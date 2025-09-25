--Igor Lautert Bazei
--2211100014

--Para utilizar essas funções é necessário utilizar a extensão faker e definir o local por meio do comando
--Select faker.faker('pt_BR');

--O banco usado tem a seguinte estrutura:

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
  endereco varchar(100) not null, 
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
  endereco varchar(100) not null, 
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

--Funções

CREATE OR REPLACE PROCEDURE popular_clientes (p_num_clientes int)
AS $$

DECLARE
	i integer;
	v_cpf varchar(11);
	v_nome varchar(50);
	v_endereco varchar(150);
	v_estado_civil varchar(20);
	v_num_filhos int;
	v_data_nasc date;
	v_telefone varchar(15);
	v_codh int;
	estados_civis TEXT[] := ARRAY['Solteiro', 'Casado', 'Divorciado', 'Viúvo'];

BEGIN

	FOR i IN 1..p_num_clientes LOOP
		v_cpf := translate(faker.unique_cpf()::VARCHAR, '.-', '');
		v_nome := faker.name();
		v_endereco := replace(faker.address(), CHR(10), ', ');
		v_num_filhos := floor(random() * 5)::INT;
		v_estado_civil := estados_civis[1 + floor(random() * array_length(estados_civis, 1))::INT];
		v_data_nasc := faker.date_of_birth(null, 21, 80);
		v_telefone := left(translate(faker.phone_number(), '-()+ ' , '');

		select codh into v_codh
		from public.habilitacoes
		order by random()
		limit 1;

		INSERT INTO public.clientes (cpf, nome, endereco, estado_civil, num_filhos, data_nasc, telefone, codh)
			VALUES (v_cpf, v_nome, v_endereco, v_estado_civil, v_num_filhos, v_data_nasc, v_telefone, v_codh);

	END LOOP;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE popular_funcionarios (p_num_func int)
AS $$

DECLARE
	i integer;
	v_nome varchar(50);
	v_endereco varchar(150);
	v_telefone varchar(15);
	v_idade SMALLINT;
	v_salario NUMERIC(10,2);

BEGIN

	FOR i IN 1..p_num_func LOOP
		v_nome := faker.name();
		v_endereco := replace(faker.address(), CHR(10), ', ');
		v_idade:= floor(18 + random() * 40)::SMALLINT;
		v_telefone := translate(faker.phone_number(), '-()+ ' , '');
		v_salario := (2000 + random() * 4000 + random())::NUMERIC(10,2);

		INSERT INTO public.funcionarios (nome, telefone, endereco, idade, salario)
			VALUES (v_nome, v_telefone, v_endereco, v_idade, v_salario);

	END LOOP;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE popular_veiculos (p_num_veiculos int)
AS $$

DECLARE
	i integer;
	v_nome varchar(50);
	v_modelo varchar(50);
	v_comprimento numeric(10,2);
	v_potMotor numeric(10,2);
	v_vlDiaria numeric(10,2);
	v_codTipo int;

BEGIN

	FOR i IN 1..p_num_veiculos LOOP
		v_nome := INITCAP(faker.word() || ' ' ||faker.color_name());
		v_modelo := INITCAP(faker.street_suffix()) || ' ' || faker.country_code();
		v_comprimento := (10 + (random() * 10)::INT * 5)::NUMERIC(10,2);
		v_potMotor := (20 + (random() * 20)::INT * 5)::NUMERIC(10,2);
		v_vlDiaria := (500 + (random() * 50)::INT*v_potMotor)::NUMERIC(10,2);
		
		select codTipo into v_codTipo
		from public.tipos_veiculos
		order by random()
		limit 1;

		INSERT INTO public.veiculos (nome, modelo, comprimento, potMotor, vlDiaria, codTipo)
			VALUES (v_nome, v_modelo, v_comprimento, v_potMotor, v_vlDiaria, v_codTipo);

	END LOOP;
END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE popular_locacoes (p_num_locacoes int)
AS $$

DECLARE
	i integer;
	v_valor numeric(10,2);
	v_inicio date;
	v_fim date;
	v_obs varchar(150);
	v_matricula int;
	v_codf int;
	v_cpf varchar(11);
	v_cli_loc_todos record;
	v_veiculo record;

BEGIN

	FOR i IN 1..p_num_locacoes LOOP
		v_valor := (500 + (random() * 50)::INT*100)::NUMERIC(10,2);
		v_inicio := faker.date_this_decade()::DATE;
		v_fim :=  v_inicio + floor(random()*7)::INTEGER;
		v_obs := faker.catch_phrase();
		
		select matricula into v_matricula
		from public.veiculos
		order by random()
		limit 1;

		select codf into v_codf
		from public.funcionarios
		order by random()
		limit 1;

		select cpf into v_cpf
		from public.clientes
		order by random()
		limit 1;

		INSERT INTO public.locacoes (valor, inicio, fim, obs, matricula, codf, cpf)
			VALUES (v_valor, v_inicio, v_fim, v_obs, v_matricula, v_codf, v_cpf);

	END LOOP;

	select *
	into v_cli_loc_todos
	from public.clientes c
	where c.codh = 5
	order by random()
	limit 1;

	FOR v_veiculo in select * from public.veiculos LOOP

		v_valor := (500 + (random() * 50)::INT*100)::NUMERIC(10,2);
		v_inicio := faker.date_this_decade()::DATE;
		v_fim :=  v_inicio + floor(random()*7)::INTEGER;
		v_obs := faker.catch_phrase();

		select codf into v_codf
		from public.funcionarios
		order by random()
		limit 1;

		INSERT INTO public.locacoes (valor, inicio, fim, obs, matricula, codf, cpf)
		VALUES (v_valor, v_inicio, v_fim, v_obs, v_veiculo.matricula, v_codf, v_cli_loc_todos.cpf);

	END LOOP;
	
END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE popular_bd (p_num_clientes int,  p_num_veiculos int, p_num_func int, p_num_locacoes int)
AS $$
BEGIN 
	CALL popular_clientes(p_num_clientes);
	CALL popular_veiculos(p_num_veiculos);
	CALL popular_funcionarios(p_num_func);
	CALL popular_locacoes(p_num_locacoes);
END
$$ LANGUAGE plpgsql;
