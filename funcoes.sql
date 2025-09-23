CREATE OR REPLACE FUNCTION popular_bd (p_num_clientes int,  p_num_veiculos int, p_num_func int, p_num_locacoes int)
RETURNS void AS $$

	BEGIN 
		select popular_clientes(p_num_clientes);
	END

$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION popular_clientes (p_num_clientes int)
RETURNS void AS $$

DECLARE
	i integer;
	v_cpf varchar(11);
	v_nome varchar(50);
	v_endereco varchar(100);
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
		v_telefone := translate(faker.phone_number(), '-()+ ' , '');

		select codh into v_codh
		from public.habilitacoes
		order by random()
		limit 1;

		INSERT INTO public.clientes (cpf, nome, endereco, estado_civil, num_filhos, data_nasc, telefone, codh)
			VALUES (v_cpf, v_nome, v_endereco, v_estado_civil, v_num_filhos, v_data_nasc, v_telefone, v_codh);
	END LOOP;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION popular_funcionarios (p_num_func int)
RETURNS void AS $$

DECLARE
	i integer;
	v_nome varchar(50);
	v_endereco varchar(100);
	v_telefone varchar(15);
	v_idade SMALLINT;
	v_salario NUMERIC(10,2);

BEGIN

	FOR i IN 1..p_num_func LOOP
		v_nome := faker.name();
		v_endereco := replace(faker.address(), CHR(10), ', ');
		v_idade:= floor(18 + random() * 65)::SMALLINT;
		v_telefone := translate(faker.phone_number(), '-()+ ' , '');
		v_salario := (2000 + random() * 15000 + random())::NUMERIC(10,2);

		INSERT INTO public.funcionarios (nome, telefone, endereco, idade, salario)
			VALUES (v_nome, v_telefone, v_endereco, v_idade, v_salario);
	END LOOP;
END;
$$ LANGUAGE plpgsql;

BEGIN
	SELECT popular_funcionarios(10);

	SELECT * FROM funcionarios;
	
ROLLBACK;
END


