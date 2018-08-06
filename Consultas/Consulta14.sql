SELECT COUNT(w1."DNI") numero, w1."Nombre"
FROM public."Restauracion" "w1", public."Restaurante" "w2"
WHERE w1."Nombre" = w2."Nombre"
GROUP BY w1."DNI"
ORDER BY numero;