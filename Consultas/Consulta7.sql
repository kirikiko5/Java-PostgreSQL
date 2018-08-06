SELECT SUM(w1."Precio con IVA") AS entradas, SUM(w2."Precio con IVA") AS tickets
FROM public."Entradas" "w1", public."Sorteo" "w3", public."Ticket" "w2"
WHERE w1."Codigo_Entrada" = w3."Codigo_Entrada"
AND w2."Codigo_Ticket" = w3."Codigo_Ticket";