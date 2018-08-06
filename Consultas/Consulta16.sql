SELECT COUNT(w2."DNI"), w2."Nombre"
FROM public."Entradas" "w1", public."Empleados" "w2"
WHERE w1."DNI" = w2."DNI"
GROUP BY w2."DNI"
ORDER BY COUNT(w2."DNI") DESC;