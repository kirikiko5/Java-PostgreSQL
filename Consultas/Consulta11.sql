SELECT COUNT("Nombre") numero
FROM public."Ticket"
GROUP BY "Nombre"
ORDER BY numero DESC;