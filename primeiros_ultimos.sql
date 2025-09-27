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
), vendas AS (
	SELECT 
	 a.primeira_venda, 
	 a.id_venda AS ultima_venda, 
	 a.diferenca, 
	 a.total_de_alteracoes,
	 ROW_NUMBER() OVER (
	 	PARTITION BY primeira_venda
	 	ORDER BY total_de_alteracoes desc
	 ) rn
	FROM alteracoes a
	ORDER BY primeira_venda
)

SELECT 
	v.primeira_venda, 
	v.ultima_venda, 
	v.diferenca, 
	v.total_de_alteracoes 
FROM 
	vendas v 
WHERE 
	v.rn=1 
ORDER BY primeira_venda ASC
