SELECT COUNT("Codigo") numero
FROM public."Animales"
GROUP BY "Tipo"
ORDER BY numero DESC;