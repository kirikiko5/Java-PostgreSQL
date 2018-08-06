SELECT w1."Tipo de Comida", count(w1."Codigo") as tipo, 
( SELECT COUNT(w1."Tipo de Comida")*100/count(mami."Codigo")
  FROM public."Mamiferos" AS mami
) as porcentaje
FROM public."Mamiferos" "w1"
GROUP BY w1."Tipo de Comida";