SELECT w1."DNI", w1."Nombre", w2."Lugar"
FROM public."Empleados" "w1", public."Personal de Limpieza" "w2"
WHERE w1."DNI" = w2."DNI";
