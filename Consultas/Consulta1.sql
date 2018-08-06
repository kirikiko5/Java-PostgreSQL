SELECT  SUM(totalDinero) totalDinero
FROM ( 
	select SUM("Precio con IVA") totalDinero from public."Entradas"
	UNION ALL
	select SUM("Precio con IVA") totalDinero from public."Ticket"
     ) 
AS totalDinero
        