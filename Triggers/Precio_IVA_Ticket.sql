CREATE OR REPLACE FUNCTION public.precio_iva_ticket()
  RETURNS trigger AS
$BODY$BEGIN
	IF NEW."Codigo_Ticket" ISNULL THEN
		RAISE EXCEPTION 'El numero de compra no puede ser un valor NULO';
	END IF;
	IF NEW."Precio sin IVA" <= CAST(0 as money) THEN
		RAISE EXCEPTION '% no puede tener un precio negativo',NEW."Precio_sin_IVA";
	END IF;
NEW."Precio con IVA" := NEW."Precio sin IVA" * 1.21;
RETURN NEW;
END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.precio_iva_ticket()
  OWNER TO postgres;