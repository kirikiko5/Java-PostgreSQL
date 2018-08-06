SELECT w1."Ubicacion", w2."Nombre", w2."DNI"
FROM public."Animales" "w1", public."Empleados" "w2"
WHERE w1."Ubicacion" LIKE 'R1'
AND w1."DNI" = w2."DNI";

