CREATE OR REPLACE FUNCTION public."importeSorteo"()
  RETURNS trigger AS
$BODY$DECLARE
	suma MONEY = CAST(0 as Money);
BEGIN 
	IF (NEW."Codigo_Entrada" = (SELECT "Entradas"."Codigo_Entrada"
					FROM "Entradas"
					WHERE NEW."Codigo_Entrada" = "Entradas"."Codigo_Entrada"))
	THEN suma = suma + (SELECT "Entradas"."Precio con IVA"
		FROM "Entradas"
		WHERE NEW."Codigo_Entrada" = "Entradas"."Codigo_Entrada");
	END IF;
	IF (NEW."Codigo_Ticket" = (SELECT "Ticket"."Codigo_Ticket"
					FROM "Ticket"
					WHERE NEW."Codigo_Ticket" = "Ticket"."Codigo_Ticket"))
	THEN suma = suma + (SELECT "Ticket"."Precio con IVA"
		FROM "Ticket"
		WHERE NEW."Codigo_Ticket" = "Ticket"."Codigo_Ticket");
	END IF;
RAISE INFO 'El importe total es %', suma;
RETURN NULL;
END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public."importeSorteo"()
  OWNER TO postgres;