CREATE OR REPLACE FUNCTION public.limite_entradas()
  RETURNS trigger AS
$BODY$BEGIN
	IF (10 <= (SELECT count(NEW."DNI") 
		FROM public."Entradas"
		WHERE NEW."DNI" = "Entradas"."DNI"))
	THEN RAISE EXCEPTION 'Ha superado el numero de entradas';
	END IF;
RETURN new;
END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.limite_entradas()
  OWNER TO postgres;