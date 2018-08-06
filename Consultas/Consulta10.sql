SELECT SUM("Precio con IVA")
FROM public."Entradas", public."Oferta"
WHERE "Entradas"."Fecha_Entrada" = "Oferta"."Fecha"