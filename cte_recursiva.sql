create table venda(id_venda int primary key
                                  , valor numeric
                                  , id_venda_anterior int
                                  , constraint venda_anterior foreign key (id_venda_anterior) references venda(id_venda));
                                                           
                                 
INSERT INTO public.venda(id_venda, valor, id_venda_anterior)
VALUES(1, 1252.66, NULL)
        , (2, 2011.32, NULL)
        , (3, 2635.66, NULL)
        , (4, 657.04, NULL)
        , (5, 415.11, 4)
        , (6, 155.26, NULL)
        , (7, 459.09, NULL)
        , (8, 1139.22, 1)
        , (9, 1791.71, NULL)
        , (10, 2209.06, 3)
        , (11, 1000.42, 8)
        , (12, 2225.76, NULL)
        , (13, 374.43, 5)
        , (14, 603.56, 7)
        , (15, 1465.67, NULL)
        , (16, 384.76, 6)
        , (17, 1994.13, NULL)
        , (18, 2661.65, NULL)
        , (19, 1549.49, 14)
        , (20, 957.35, NULL)
        , (21, 201.24, 13)
        , (22, 1528.42, 20)
        , (23, 1419.39, 19)
        , (24, 2683.78, 22)
        , (25, 2232.0, 25);        



WITH RECURSIVE alteracoes AS (

	SELECT 
	  id_venda,
	  id_venda AS primeira_venda,
	  id_venda_anterior,
	  valor,
	  0::NUMERIC AS diferenca,
	  1 AS total_de_alteracoes
	FROM 
	  venda 
	WHERE 
	  id_venda_anterior IS NULL 
	  
	UNION 
	
	SELECT 
	  v.id_venda, 
	  a.primeira_venda AS primeira_venda,
	  v.id_venda_anterior, 
	  v.valor, 
	  ((v.valor - a.valor) + a.diferenca) AS diferenca,
	  (a.total_de_alteracoes + 1) AS total_de_alteracoes
	FROM 
	  venda v
	  JOIN alteracoes a ON a.id_venda = v.id_venda_anterior
)

SELECT 
 a.primeira_venda, 
 a.id_venda AS ultima_venda, 
 a.diferenca, 
 a.total_de_alteracoes
FROM alteracoes a
ORDER BY primeira_venda
