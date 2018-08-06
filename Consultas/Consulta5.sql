SELECT AVG("Precio con IVA"::numeric), w1."Nombre de Usuario"
FROM public."Entradas" "w1", public."Cliente Online" "w2"
WHERE w1."Nombre de Usuario" = w2."Nombre de Usuario"
GROUP BY w1."Nombre de Usuario";