SELECT  (
        SELECT COUNT(*)
        FROM   public."Animales"
        ) AS Animales,
        (
        SELECT COUNT(*)
        FROM   public."Empleados"
        ) AS Empleados