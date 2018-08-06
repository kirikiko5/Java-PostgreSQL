SELECT count(w2."Fecha_Oferta"), SUM(w2."Precio con IVA") 
FROM public."Oferta" "w1", public."Entradas" "w2"
WHERE w1."Fecha" = w2."Fecha_Oferta";