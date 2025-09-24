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
END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE popular_bd (p_num_clientes int,  p_num_veiculos int, p_num_func int, p_num_locacoes int)
AS $$

DECLARE
	v_qt_commits integer;
	v_num_registros_commit integer := 5000;
	v_num_registros_restantes integer;
	i integer;
BEGIN 
	
	v_num_registros_restantes := p_num_clientes;
	WHILE v_num_registros_restantes > v_num_registros_commit LOOP
		CALL popular_clientes(v_num_registros_commit);
		COMMIT;
		v_num_registros_restantes := v_num_registros_restantes - v_num_registros_commit;
	END LOOP;
	CALL popular_clientes(v_num_registros_restantes);

	v_num_registros_restantes := p_num_veiculos;
	WHILE v_num_registros_restantes > v_num_registros_commit LOOP
		CALL popular_veiculos(v_num_registros_commit);
		COMMIT;
		v_num_registros_restantes := v_num_registros_restantes - v_num_registros_commit;
	END LOOP;
	CALL popular_veiculos(v_num_registros_restantes);

	v_num_registros_restantes := p_num_func;
	WHILE v_num_registros_restantes > v_num_registros_commit LOOP
		CALL popular_funcionarios(v_num_registros_commit);
		COMMIT;
		v_num_registros_restantes := v_num_registros_restantes - v_num_registros_commit;
	END LOOP;
	CALL popular_funcionarios(v_num_registros_restantes);

END
$$ LANGUAGE plpgsql;
