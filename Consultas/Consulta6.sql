SELECT count(w1."Nombre de Usuario")*100/count(w1."Codigo_Entrada")
  FROM public."Entradas" "w1";