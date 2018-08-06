SELECT  SUM(totalDinero) totalDinero
FROM ( 
	SELECT SUM("Precio con IVA") totalDinero FROM public."Entradas"
	WHERE "DNI" IS NULL
	AND "Nombre de Usuario" IS NULL
	UNION ALL
	SELECT SUM("Precio con IVA") totalDinero FROM public."Entradas" "w1", public."Cliente Online" "w2"
	WHERE w1."Nombre de Usuario" = w2."Nombre de Usuario"
     ) 
AS totalDinero