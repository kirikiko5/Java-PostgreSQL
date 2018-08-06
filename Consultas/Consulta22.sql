SELECT "Nombre Comun"
FROM public."Animales" "w1", public."Mamiferos" "w2"
WHERE w1."Codigo" = w2."Codigo"
AND w2."Preniada" = TRUE;