SELECT "DNI", contador, (((24.4::float8::numeric::money)*contador) - (17::float8::numeric::money)*contador)
FROM (SELECT "DNI", COUNT("DNI") contador
	  FROM public."Entradas"
	  GROUP BY "DNI") AS T1
WHERE contador IN (SELECT MAX(contador)
				   FROM (SELECT "DNI", COUNT("DNI") contador
				         FROM public."Entradas"
				         GROUP BY "DNI") AS T2
			 )