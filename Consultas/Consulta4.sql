SELECT COUNT("Codigo_Entrada") AS Numero, SUM("Precio con IVA") AS ImporteTotal
FROM public."Entradas"
WHERE "Tipo" != 'Especial';