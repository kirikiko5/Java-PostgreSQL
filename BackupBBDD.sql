PGDMP     :                    t           PecL3    9.5.1    9.5.1 ~    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            �           1262    26457    PecL3    DATABASE     �   CREATE DATABASE "PecL3" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_United States.1252' LC_CTYPE = 'English_United States.1252';
    DROP DATABASE "PecL3";
             postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false            �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    6            �           0    0    public    ACL     �   REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;
                  postgres    false    6                        3079    12355    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false            �           0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    1            �            1255    26739    importeSorteo()    FUNCTION     	  CREATE FUNCTION "importeSorteo"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE
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
END;$$;
 (   DROP FUNCTION public."importeSorteo"();
       public       postgres    false    1    6            �            1255    26745    limite_entradas()    FUNCTION       CREATE FUNCTION limite_entradas() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
	IF (10 <= (SELECT count(NEW."DNI") 
		FROM public."Entradas"
		WHERE NEW."DNI" = "Entradas"."DNI"))
	THEN RAISE EXCEPTION 'Ha superado el numero de entradas';
	END IF;
RETURN new;
END;$$;
 (   DROP FUNCTION public.limite_entradas();
       public       postgres    false    1    6            �            1255    26728    precio_iva()    FUNCTION     �  CREATE FUNCTION precio_iva() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
	IF NEW."Codigo_Entrada" ISNULL THEN
		RAISE EXCEPTION 'El numero de compra no puede ser un valor NULO';
	END IF;
	IF NEW."Precio sin IVA" <= CAST(0 as money) THEN
		RAISE EXCEPTION '% no puede tener un precio negativo',NEW."Precio_sin_IVA";
	END IF;
NEW."Precio con IVA" := NEW."Precio sin IVA" * 1.21;
RETURN NEW;
END;
$$;
 #   DROP FUNCTION public.precio_iva();
       public       postgres    false    6    1            �            1255    26742    precio_iva_ticket()    FUNCTION     �  CREATE FUNCTION precio_iva_ticket() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
	IF NEW."Codigo_Ticket" ISNULL THEN
		RAISE EXCEPTION 'El numero de compra no puede ser un valor NULO';
	END IF;
	IF NEW."Precio sin IVA" <= CAST(0 as money) THEN
		RAISE EXCEPTION '% no puede tener un precio negativo',NEW."Precio_sin_IVA";
	END IF;
NEW."Precio con IVA" := NEW."Precio sin IVA" * 1.21;
RETURN NEW;
END;$$;
 *   DROP FUNCTION public.precio_iva_ticket();
       public       postgres    false    6    1            �            1259    26458    Animales    TABLE     5  CREATE TABLE "Animales" (
    "Codigo" integer NOT NULL,
    "Tipo" character varying NOT NULL,
    "Fecha de Nacimiento" date NOT NULL,
    "Nombre Comun" name NOT NULL,
    "Nombre Cientifico" name NOT NULL,
    "Descripcion" text,
    "Ubicacion" character varying NOT NULL,
    "DNI" character varying
);
    DROP TABLE public."Animales";
       public         postgres    false    6            �           0    0    Animales    ACL     .  REVOKE ALL ON TABLE "Animales" FROM PUBLIC;
REVOKE ALL ON TABLE "Animales" FROM postgres;
GRANT ALL ON TABLE "Animales" TO "AdministradorRol" WITH GRANT OPTION;
GRANT SELECT ON TABLE "Animales" TO "GrupoCajero" WITH GRANT OPTION;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE "Animales" TO "GrupoGestor";
            public       postgres    false    181            �            1259    26585    Aves    TABLE     x   CREATE TABLE "Aves" (
    "Peso" integer NOT NULL,
    "Envergadura" integer NOT NULL,
    "Codigo" integer NOT NULL
);
    DROP TABLE public."Aves";
       public         postgres    false    6            �           0    0    Aves    ACL     �   REVOKE ALL ON TABLE "Aves" FROM PUBLIC;
REVOKE ALL ON TABLE "Aves" FROM postgres;
GRANT ALL ON TABLE "Aves" TO "AdministradorRol";
GRANT SELECT ON TABLE "Aves" TO "GrupoCajero";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE "Aves" TO "GrupoGestor";
            public       postgres    false    197            �            1259    26486    Cliente Online    TABLE     �   CREATE TABLE "Cliente Online" (
    "Nombre de Usuario" character varying NOT NULL,
    "Contrasena" character varying NOT NULL
);
 $   DROP TABLE public."Cliente Online";
       public         postgres    false    6            �           0    0    Cliente Online    ACL     (  REVOKE ALL ON TABLE "Cliente Online" FROM PUBLIC;
REVOKE ALL ON TABLE "Cliente Online" FROM postgres;
GRANT ALL ON TABLE "Cliente Online" TO "AdministradorRol";
GRANT SELECT ON TABLE "Cliente Online" TO "GrupoCajero";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE "Cliente Online" TO "GrupoGestor";
            public       postgres    false    184            �            1259    26534 
   Cuidadores    TABLE     O   CREATE TABLE "Cuidadores" (
    "DNI_Cuidadores" character varying NOT NULL
);
     DROP TABLE public."Cuidadores";
       public         postgres    false    6            �           0    0 
   Cuidadores    ACL       REVOKE ALL ON TABLE "Cuidadores" FROM PUBLIC;
REVOKE ALL ON TABLE "Cuidadores" FROM postgres;
GRANT ALL ON TABLE "Cuidadores" TO "AdministradorRol";
GRANT SELECT ON TABLE "Cuidadores" TO "GrupoCajero";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE "Cuidadores" TO "GrupoGestor";
            public       postgres    false    190            �            1259    26590    Cuidar    TABLE     _   CREATE TABLE "Cuidar" (
    "DNI" character varying NOT NULL,
    "Codigo" integer NOT NULL
);
    DROP TABLE public."Cuidar";
       public         postgres    false    6            �           0    0    Cuidar    ACL        REVOKE ALL ON TABLE "Cuidar" FROM PUBLIC;
REVOKE ALL ON TABLE "Cuidar" FROM postgres;
GRANT ALL ON TABLE "Cuidar" TO "AdministradorRol";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE "Cuidar" TO "GrupoGestor";
GRANT SELECT ON TABLE "Cuidar" TO "GrupoCajero";
            public       postgres    false    198            �            1259    26598    Dias no visitables    TABLE     `   CREATE TABLE "Dias no visitables" (
    "Codigo" integer NOT NULL,
    "Fecha" date NOT NULL
);
 (   DROP TABLE public."Dias no visitables";
       public         postgres    false    6            �           0    0    Dias no visitables    ACL     <  REVOKE ALL ON TABLE "Dias no visitables" FROM PUBLIC;
REVOKE ALL ON TABLE "Dias no visitables" FROM postgres;
GRANT ALL ON TABLE "Dias no visitables" TO "AdministradorRol";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE "Dias no visitables" TO "GrupoGestor";
GRANT SELECT ON TABLE "Dias no visitables" TO "GrupoCajero";
            public       postgres    false    199            �            1259    26467 	   Empleados    TABLE     0  CREATE TABLE "Empleados" (
    "DNI" character varying NOT NULL,
    "Nombre" name NOT NULL,
    "Direccion" character varying NOT NULL,
    "Telefono" integer NOT NULL,
    "Correo Electronico" character varying NOT NULL,
    "Tipo" character varying NOT NULL,
    "Turno" character varying NOT NULL
);
    DROP TABLE public."Empleados";
       public         postgres    false    6            �           0    0 	   Empleados    ACL       REVOKE ALL ON TABLE "Empleados" FROM PUBLIC;
REVOKE ALL ON TABLE "Empleados" FROM postgres;
GRANT ALL ON TABLE "Empleados" TO "AdministradorRol";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE "Empleados" TO "GrupoGestor";
GRANT SELECT ON TABLE "Empleados" TO "GrupoCajero";
            public       postgres    false    182            �            1259    26475    Entradas    TABLE     �  CREATE TABLE "Entradas" (
    "Fecha_Oferta" date,
    "Codigo Postal" integer,
    "Precio sin IVA" money NOT NULL,
    "Precio con IVA" money NOT NULL,
    "Tipo" character varying NOT NULL,
    "Codigo_Entrada" integer NOT NULL,
    "Porcentaje_Administrativo" integer,
    "Porcentaje_Cuidadores" bigint,
    "Nombre de Usuario" character varying,
    "DNI" character varying,
    "Fecha_Entrada" date NOT NULL
);
    DROP TABLE public."Entradas";
       public         postgres    false    6            �           0    0    Entradas    ACL     
  REVOKE ALL ON TABLE "Entradas" FROM PUBLIC;
REVOKE ALL ON TABLE "Entradas" FROM postgres;
GRANT ALL ON TABLE "Entradas" TO "AdministradorRol";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE "Entradas" TO "GrupoGestor";
GRANT SELECT ON TABLE "Entradas" TO "GrupoCajero";
            public       postgres    false    183            �            1259    26567 	   Mamiferos    TABLE     �   CREATE TABLE "Mamiferos" (
    "Tipo de Comida" character varying NOT NULL,
    "Codigo" integer NOT NULL,
    "Sexo" character(20) NOT NULL,
    "Fecha de parto" date,
    "Preniada" boolean
);
    DROP TABLE public."Mamiferos";
       public         postgres    false    6            �           0    0 	   Mamiferos    ACL       REVOKE ALL ON TABLE "Mamiferos" FROM PUBLIC;
REVOKE ALL ON TABLE "Mamiferos" FROM postgres;
GRANT ALL ON TABLE "Mamiferos" TO "AdministradorRol";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE "Mamiferos" TO "GrupoGestor";
GRANT SELECT ON TABLE "Mamiferos" TO "GrupoCajero";
            public       postgres    false    194            �            1259    26502    Oferta    TABLE     `   CREATE TABLE "Oferta" (
    "Fecha" date NOT NULL,
    "Cantidad" character varying NOT NULL
);
    DROP TABLE public."Oferta";
       public         postgres    false    6            �           0    0    Oferta    ACL       REVOKE ALL ON TABLE "Oferta" FROM PUBLIC;
REVOKE ALL ON TABLE "Oferta" FROM postgres;
GRANT ALL ON TABLE "Oferta" TO "AdministradorRol";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE "Oferta" TO "GrupoGestor";
GRANT SELECT,UPDATE ON TABLE "Oferta" TO "GrupoCajero";
            public       postgres    false    186            �            1259    26494    Opinion    TABLE     �   CREATE TABLE "Opinion" (
    "Fecha" date NOT NULL,
    "Puntuacion" integer NOT NULL,
    "Descripcion" character varying,
    "Nombre de Usuario" character varying NOT NULL
);
    DROP TABLE public."Opinion";
       public         postgres    false    6            �           0    0    Opinion    ACL       REVOKE ALL ON TABLE "Opinion" FROM PUBLIC;
REVOKE ALL ON TABLE "Opinion" FROM postgres;
GRANT ALL ON TABLE "Opinion" TO "AdministradorRol";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE "Opinion" TO "GrupoGestor";
GRANT SELECT ON TABLE "Opinion" TO "GrupoCajero";
            public       postgres    false    185            �            1259    26580    Peces    TABLE     u   CREATE TABLE "Peces" (
    "Tamanio" integer NOT NULL,
    "Codigo" integer NOT NULL,
    "Peso" integer NOT NULL
);
    DROP TABLE public."Peces";
       public         postgres    false    6            �           0    0    Peces    ACL     �   REVOKE ALL ON TABLE "Peces" FROM PUBLIC;
REVOKE ALL ON TABLE "Peces" FROM postgres;
GRANT ALL ON TABLE "Peces" TO "AdministradorRol";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE "Peces" TO "GrupoGestor";
GRANT SELECT ON TABLE "Peces" TO "GrupoCajero";
            public       postgres    false    196            �            1259    26550    Personal Administrativo    TABLE     Q   CREATE TABLE "Personal Administrativo" (
    "DNI" character varying NOT NULL
);
 -   DROP TABLE public."Personal Administrativo";
       public         postgres    false    6            �           0    0    Personal Administrativo    ACL     U  REVOKE ALL ON TABLE "Personal Administrativo" FROM PUBLIC;
REVOKE ALL ON TABLE "Personal Administrativo" FROM postgres;
GRANT ALL ON TABLE "Personal Administrativo" TO "AdministradorRol";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE "Personal Administrativo" TO "GrupoGestor";
GRANT SELECT ON TABLE "Personal Administrativo" TO "GrupoCajero";
            public       postgres    false    192            �            1259    26542    Personal de Limpieza    TABLE     v   CREATE TABLE "Personal de Limpieza" (
    "Lugar" character varying NOT NULL,
    "DNI" character varying NOT NULL
);
 *   DROP TABLE public."Personal de Limpieza";
       public         postgres    false    6            �           0    0    Personal de Limpieza    ACL     F  REVOKE ALL ON TABLE "Personal de Limpieza" FROM PUBLIC;
REVOKE ALL ON TABLE "Personal de Limpieza" FROM postgres;
GRANT ALL ON TABLE "Personal de Limpieza" TO "AdministradorRol";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE "Personal de Limpieza" TO "GrupoGestor";
GRANT SELECT ON TABLE "Personal de Limpieza" TO "GrupoCajero";
            public       postgres    false    191            �            1259    26575    Reptiles    TABLE     ;   CREATE TABLE "Reptiles" (
    "Codigo" integer NOT NULL
);
    DROP TABLE public."Reptiles";
       public         postgres    false    6             	           0    0    Reptiles    ACL     
  REVOKE ALL ON TABLE "Reptiles" FROM PUBLIC;
REVOKE ALL ON TABLE "Reptiles" FROM postgres;
GRANT ALL ON TABLE "Reptiles" TO "AdministradorRol";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE "Reptiles" TO "GrupoGestor";
GRANT SELECT ON TABLE "Reptiles" TO "GrupoCajero";
            public       postgres    false    195            �            1259    26558    Restauracion    TABLE     b   CREATE TABLE "Restauracion" (
    "DNI" character varying NOT NULL,
    "Nombre" name NOT NULL
);
 "   DROP TABLE public."Restauracion";
       public         postgres    false    6            	           0    0    Restauracion    ACL       REVOKE ALL ON TABLE "Restauracion" FROM PUBLIC;
REVOKE ALL ON TABLE "Restauracion" FROM postgres;
GRANT ALL ON TABLE "Restauracion" TO "AdministradorRol";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE "Restauracion" TO "GrupoGestor";
GRANT SELECT ON TABLE "Restauracion" TO "GrupoCajero";
            public       postgres    false    193            �            1259    26519    Restaurante    TABLE     b   CREATE TABLE "Restaurante" (
    "Nombre" name NOT NULL,
    "Tipo" character varying NOT NULL
);
 !   DROP TABLE public."Restaurante";
       public         postgres    false    6            	           0    0    Restaurante    ACL       REVOKE ALL ON TABLE "Restaurante" FROM PUBLIC;
REVOKE ALL ON TABLE "Restaurante" FROM postgres;
GRANT ALL ON TABLE "Restaurante" TO "AdministradorRol";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE "Restaurante" TO "GrupoGestor";
GRANT SELECT ON TABLE "Restaurante" TO "GrupoCajero";
            public       postgres    false    188            �            1259    26527    Sorteo    TABLE     �   CREATE TABLE "Sorteo" (
    "Nombre" name NOT NULL,
    "Fecha" date NOT NULL,
    "Codigo_Ticket" integer NOT NULL,
    "Codigo_Entrada" integer NOT NULL
);
    DROP TABLE public."Sorteo";
       public         postgres    false    6            	           0    0    Sorteo    ACL        REVOKE ALL ON TABLE "Sorteo" FROM PUBLIC;
REVOKE ALL ON TABLE "Sorteo" FROM postgres;
GRANT ALL ON TABLE "Sorteo" TO "AdministradorRol";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE "Sorteo" TO "GrupoGestor";
GRANT SELECT ON TABLE "Sorteo" TO "GrupoCajero";
            public       postgres    false    189            �            1259    26510    Ticket    TABLE     �   CREATE TABLE "Ticket" (
    "Nombre Empleado" name,
    "Articulos Consumidos" text,
    "Precio sin IVA" money NOT NULL,
    "Precio con IVA" money NOT NULL,
    "Codigo_Ticket" integer NOT NULL,
    "Nombre" name
);
    DROP TABLE public."Ticket";
       public         postgres    false    6            	           0    0    Ticket    ACL        REVOKE ALL ON TABLE "Ticket" FROM PUBLIC;
REVOKE ALL ON TABLE "Ticket" FROM postgres;
GRANT ALL ON TABLE "Ticket" TO "AdministradorRol";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE "Ticket" TO "GrupoGestor";
GRANT SELECT ON TABLE "Ticket" TO "GrupoCajero";
            public       postgres    false    187            �            1259    26603    Vacunas    TABLE     V   CREATE TABLE "Vacunas" (
    "Nombre" text NOT NULL,
    "Codigo" integer NOT NULL
);
    DROP TABLE public."Vacunas";
       public         postgres    false    6            	           0    0    Vacunas    ACL       REVOKE ALL ON TABLE "Vacunas" FROM PUBLIC;
REVOKE ALL ON TABLE "Vacunas" FROM postgres;
GRANT ALL ON TABLE "Vacunas" TO "AdministradorRol";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE "Vacunas" TO "GrupoGestor";
GRANT SELECT ON TABLE "Vacunas" TO "GrupoCajero";
            public       postgres    false    200            �          0    26458    Animales 
   TABLE DATA               �   COPY "Animales" ("Codigo", "Tipo", "Fecha de Nacimiento", "Nombre Comun", "Nombre Cientifico", "Descripcion", "Ubicacion", "DNI") FROM stdin;
    public       postgres    false    181   �       �          0    26585    Aves 
   TABLE DATA               :   COPY "Aves" ("Peso", "Envergadura", "Codigo") FROM stdin;
    public       postgres    false    197   ݝ       �          0    26486    Cliente Online 
   TABLE DATA               F   COPY "Cliente Online" ("Nombre de Usuario", "Contrasena") FROM stdin;
    public       postgres    false    184   
�       �          0    26534 
   Cuidadores 
   TABLE DATA               1   COPY "Cuidadores" ("DNI_Cuidadores") FROM stdin;
    public       postgres    false    190   q�       �          0    26590    Cuidar 
   TABLE DATA               ,   COPY "Cuidar" ("DNI", "Codigo") FROM stdin;
    public       postgres    false    198   ��       �          0    26598    Dias no visitables 
   TABLE DATA               :   COPY "Dias no visitables" ("Codigo", "Fecha") FROM stdin;
    public       postgres    false    199   ��       �          0    26467 	   Empleados 
   TABLE DATA               o   COPY "Empleados" ("DNI", "Nombre", "Direccion", "Telefono", "Correo Electronico", "Tipo", "Turno") FROM stdin;
    public       postgres    false    182   <�       �          0    26475    Entradas 
   TABLE DATA               �   COPY "Entradas" ("Fecha_Oferta", "Codigo Postal", "Precio sin IVA", "Precio con IVA", "Tipo", "Codigo_Entrada", "Porcentaje_Administrativo", "Porcentaje_Cuidadores", "Nombre de Usuario", "DNI", "Fecha_Entrada") FROM stdin;
    public       postgres    false    183   B�       �          0    26567 	   Mamiferos 
   TABLE DATA               `   COPY "Mamiferos" ("Tipo de Comida", "Codigo", "Sexo", "Fecha de parto", "Preniada") FROM stdin;
    public       postgres    false    194   s�       �          0    26502    Oferta 
   TABLE DATA               0   COPY "Oferta" ("Fecha", "Cantidad") FROM stdin;
    public       postgres    false    186   ۢ       �          0    26494    Opinion 
   TABLE DATA               W   COPY "Opinion" ("Fecha", "Puntuacion", "Descripcion", "Nombre de Usuario") FROM stdin;
    public       postgres    false    185   �       �          0    26580    Peces 
   TABLE DATA               7   COPY "Peces" ("Tamanio", "Codigo", "Peso") FROM stdin;
    public       postgres    false    196   u�       �          0    26550    Personal Administrativo 
   TABLE DATA               3   COPY "Personal Administrativo" ("DNI") FROM stdin;
    public       postgres    false    192   ��       �          0    26542    Personal de Limpieza 
   TABLE DATA               9   COPY "Personal de Limpieza" ("Lugar", "DNI") FROM stdin;
    public       postgres    false    191   ߣ       �          0    26575    Reptiles 
   TABLE DATA               '   COPY "Reptiles" ("Codigo") FROM stdin;
    public       postgres    false    195   '�       �          0    26558    Restauracion 
   TABLE DATA               2   COPY "Restauracion" ("DNI", "Nombre") FROM stdin;
    public       postgres    false    193   J�       �          0    26519    Restaurante 
   TABLE DATA               2   COPY "Restaurante" ("Nombre", "Tipo") FROM stdin;
    public       postgres    false    188   ��       �          0    26527    Sorteo 
   TABLE DATA               Q   COPY "Sorteo" ("Nombre", "Fecha", "Codigo_Ticket", "Codigo_Entrada") FROM stdin;
    public       postgres    false    189   �       �          0    26510    Ticket 
   TABLE DATA               �   COPY "Ticket" ("Nombre Empleado", "Articulos Consumidos", "Precio sin IVA", "Precio con IVA", "Codigo_Ticket", "Nombre") FROM stdin;
    public       postgres    false    187   N�       �          0    26603    Vacunas 
   TABLE DATA               0   COPY "Vacunas" ("Nombre", "Codigo") FROM stdin;
    public       postgres    false    200   ˥                  2606    26466    Key1 
   CONSTRAINT     N   ALTER TABLE ONLY "Animales"
    ADD CONSTRAINT "Key1" PRIMARY KEY ("Codigo");
 ;   ALTER TABLE ONLY public."Animales" DROP CONSTRAINT "Key1";
       public         postgres    false    181    181            4           2606    26541    Key10 
   CONSTRAINT     Y   ALTER TABLE ONLY "Cuidadores"
    ADD CONSTRAINT "Key10" PRIMARY KEY ("DNI_Cuidadores");
 >   ALTER TABLE ONLY public."Cuidadores" DROP CONSTRAINT "Key10";
       public         postgres    false    190    190            6           2606    26549    Key11 
   CONSTRAINT     X   ALTER TABLE ONLY "Personal de Limpieza"
    ADD CONSTRAINT "Key11" PRIMARY KEY ("DNI");
 H   ALTER TABLE ONLY public."Personal de Limpieza" DROP CONSTRAINT "Key11";
       public         postgres    false    191    191            8           2606    26557    Key12 
   CONSTRAINT     [   ALTER TABLE ONLY "Personal Administrativo"
    ADD CONSTRAINT "Key12" PRIMARY KEY ("DNI");
 K   ALTER TABLE ONLY public."Personal Administrativo" DROP CONSTRAINT "Key12";
       public         postgres    false    192    192            ;           2606    26566    Key13 
   CONSTRAINT     P   ALTER TABLE ONLY "Restauracion"
    ADD CONSTRAINT "Key13" PRIMARY KEY ("DNI");
 @   ALTER TABLE ONLY public."Restauracion" DROP CONSTRAINT "Key13";
       public         postgres    false    193    193            =           2606    26574    Key14 
   CONSTRAINT     P   ALTER TABLE ONLY "Mamiferos"
    ADD CONSTRAINT "Key14" PRIMARY KEY ("Codigo");
 =   ALTER TABLE ONLY public."Mamiferos" DROP CONSTRAINT "Key14";
       public         postgres    false    194    194            ?           2606    26579    Key15 
   CONSTRAINT     O   ALTER TABLE ONLY "Reptiles"
    ADD CONSTRAINT "Key15" PRIMARY KEY ("Codigo");
 <   ALTER TABLE ONLY public."Reptiles" DROP CONSTRAINT "Key15";
       public         postgres    false    195    195            A           2606    26584    Key16 
   CONSTRAINT     L   ALTER TABLE ONLY "Peces"
    ADD CONSTRAINT "Key16" PRIMARY KEY ("Codigo");
 9   ALTER TABLE ONLY public."Peces" DROP CONSTRAINT "Key16";
       public         postgres    false    196    196            C           2606    26589    Key17 
   CONSTRAINT     K   ALTER TABLE ONLY "Aves"
    ADD CONSTRAINT "Key17" PRIMARY KEY ("Codigo");
 8   ALTER TABLE ONLY public."Aves" DROP CONSTRAINT "Key17";
       public         postgres    false    197    197                       2606    26474    Key2 
   CONSTRAINT     L   ALTER TABLE ONLY "Empleados"
    ADD CONSTRAINT "Key2" PRIMARY KEY ("DNI");
 <   ALTER TABLE ONLY public."Empleados" DROP CONSTRAINT "Key2";
       public         postgres    false    182    182            E           2606    26597    Key20 
   CONSTRAINT     T   ALTER TABLE ONLY "Cuidar"
    ADD CONSTRAINT "Key20" PRIMARY KEY ("DNI", "Codigo");
 :   ALTER TABLE ONLY public."Cuidar" DROP CONSTRAINT "Key20";
       public         postgres    false    198    198    198            G           2606    26602    Key21 
   CONSTRAINT     b   ALTER TABLE ONLY "Dias no visitables"
    ADD CONSTRAINT "Key21" PRIMARY KEY ("Codigo", "Fecha");
 F   ALTER TABLE ONLY public."Dias no visitables" DROP CONSTRAINT "Key21";
       public         postgres    false    199    199    199            I           2606    26610    Key22 
   CONSTRAINT     X   ALTER TABLE ONLY "Vacunas"
    ADD CONSTRAINT "Key22" PRIMARY KEY ("Nombre", "Codigo");
 ;   ALTER TABLE ONLY public."Vacunas" DROP CONSTRAINT "Key22";
       public         postgres    false    200    200    200            #           2606    26485    Key3 
   CONSTRAINT     V   ALTER TABLE ONLY "Entradas"
    ADD CONSTRAINT "Key3" PRIMARY KEY ("Codigo_Entrada");
 ;   ALTER TABLE ONLY public."Entradas" DROP CONSTRAINT "Key3";
       public         postgres    false    183    183            %           2606    26493    Key4 
   CONSTRAINT     _   ALTER TABLE ONLY "Cliente Online"
    ADD CONSTRAINT "Key4" PRIMARY KEY ("Nombre de Usuario");
 A   ALTER TABLE ONLY public."Cliente Online" DROP CONSTRAINT "Key4";
       public         postgres    false    184    184            '           2606    26501    Key5 
   CONSTRAINT     a   ALTER TABLE ONLY "Opinion"
    ADD CONSTRAINT "Key5" PRIMARY KEY ("Nombre de Usuario", "Fecha");
 :   ALTER TABLE ONLY public."Opinion" DROP CONSTRAINT "Key5";
       public         postgres    false    185    185    185            )           2606    26509    Key6 
   CONSTRAINT     K   ALTER TABLE ONLY "Oferta"
    ADD CONSTRAINT "Key6" PRIMARY KEY ("Fecha");
 9   ALTER TABLE ONLY public."Oferta" DROP CONSTRAINT "Key6";
       public         postgres    false    186    186            ,           2606    26518    Key7 
   CONSTRAINT     S   ALTER TABLE ONLY "Ticket"
    ADD CONSTRAINT "Key7" PRIMARY KEY ("Codigo_Ticket");
 9   ALTER TABLE ONLY public."Ticket" DROP CONSTRAINT "Key7";
       public         postgres    false    187    187            .           2606    26526    Key8 
   CONSTRAINT     Q   ALTER TABLE ONLY "Restaurante"
    ADD CONSTRAINT "Key8" PRIMARY KEY ("Nombre");
 >   ALTER TABLE ONLY public."Restaurante" DROP CONSTRAINT "Key8";
       public         postgres    false    188    188            2           2606    26533    Key9 
   CONSTRAINT     U   ALTER TABLE ONLY "Sorteo"
    ADD CONSTRAINT "Key9" PRIMARY KEY ("Nombre", "Fecha");
 9   ALTER TABLE ONLY public."Sorteo" DROP CONSTRAINT "Key9";
       public         postgres    false    189    189    189                       1259    26481    Cliente    INDEX     H   CREATE INDEX "Cliente" ON "Entradas" USING btree ("Nombre de Usuario");
    DROP INDEX public."Cliente";
       public         postgres    false    183                       1259    26464    IX_Relationship14    INDEX     D   CREATE INDEX "IX_Relationship14" ON "Animales" USING btree ("DNI");
 '   DROP INDEX public."IX_Relationship14";
       public         postgres    false    181            /           1259    26531    IX_Relationship26    INDEX     M   CREATE INDEX "IX_Relationship26" ON "Sorteo" USING btree ("Codigo_Entrada");
 '   DROP INDEX public."IX_Relationship26";
       public         postgres    false    189            0           1259    26530    IX_Relationship27    INDEX     L   CREATE INDEX "IX_Relationship27" ON "Sorteo" USING btree ("Codigo_Ticket");
 '   DROP INDEX public."IX_Relationship27";
       public         postgres    false    189                        1259    26482    IX_Relationship28    INDEX     D   CREATE INDEX "IX_Relationship28" ON "Entradas" USING btree ("DNI");
 '   DROP INDEX public."IX_Relationship28";
       public         postgres    false    183            !           1259    26483    IX_Relationship29    INDEX     M   CREATE INDEX "IX_Relationship29" ON "Entradas" USING btree ("Fecha_Oferta");
 '   DROP INDEX public."IX_Relationship29";
       public         postgres    false    183            *           1259    26516    IX_Relationship35    INDEX     E   CREATE INDEX "IX_Relationship35" ON "Ticket" USING btree ("Nombre");
 '   DROP INDEX public."IX_Relationship35";
       public         postgres    false    187            9           1259    26564    IX_Relationship37    INDEX     K   CREATE INDEX "IX_Relationship37" ON "Restauracion" USING btree ("Nombre");
 '   DROP INDEX public."IX_Relationship37";
       public         postgres    false    193            c           2620    26740    calcular_sorteo    TRIGGER     t   CREATE TRIGGER calcular_sorteo AFTER INSERT OR UPDATE ON "Sorteo" FOR EACH ROW EXECUTE PROCEDURE "importeSorteo"();
 1   DROP TRIGGER calcular_sorteo ON public."Sorteo";
       public       postgres    false    189    214            `           2620    26729    insert_entrada    TRIGGER     q   CREATE TRIGGER insert_entrada BEFORE INSERT OR UPDATE ON "Entradas" FOR EACH ROW EXECUTE PROCEDURE precio_iva();
 2   DROP TRIGGER insert_entrada ON public."Entradas";
       public       postgres    false    183    201            b           2620    26743    iva    TRIGGER     a   CREATE TRIGGER iva BEFORE INSERT ON "Ticket" FOR EACH ROW EXECUTE PROCEDURE precio_iva_ticket();
 %   DROP TRIGGER iva ON public."Ticket";
       public       postgres    false    215    187            a           2620    26746    limite    TRIGGER     d   CREATE TRIGGER limite BEFORE INSERT ON "Entradas" FOR EACH ROW EXECUTE PROCEDURE limite_entradas();
 *   DROP TRIGGER limite ON public."Entradas";
       public       postgres    false    216    183            K           2606    26676    Adquirir    FK CONSTRAINT     �   ALTER TABLE ONLY "Entradas"
    ADD CONSTRAINT "Adquirir" FOREIGN KEY ("Nombre de Usuario") REFERENCES "Cliente Online"("Nombre de Usuario");
 ?   ALTER TABLE ONLY public."Entradas" DROP CONSTRAINT "Adquirir";
       public       postgres    false    2085    183    184            L           2606    26691 	   Descuento    FK CONSTRAINT     n   ALTER TABLE ONLY "Entradas"
    ADD CONSTRAINT "Descuento" FOREIGN KEY ("DNI") REFERENCES "Empleados"("DNI");
 @   ALTER TABLE ONLY public."Entradas" DROP CONSTRAINT "Descuento";
       public       postgres    false    2078    182    183            R           2606    26716    Devuelve    FK CONSTRAINT     �   ALTER TABLE ONLY "Sorteo"
    ADD CONSTRAINT "Devuelve" FOREIGN KEY ("Codigo_Entrada") REFERENCES "Entradas"("Codigo_Entrada") ON UPDATE CASCADE ON DELETE RESTRICT;
 =   ALTER TABLE ONLY public."Sorteo" DROP CONSTRAINT "Devuelve";
       public       postgres    false    189    183    2083            O           2606    26681    Emite    FK CONSTRAINT     �   ALTER TABLE ONLY "Ticket"
    ADD CONSTRAINT "Emite" FOREIGN KEY ("Nombre") REFERENCES "Restaurante"("Nombre") ON UPDATE CASCADE;
 :   ALTER TABLE ONLY public."Ticket" DROP CONSTRAINT "Emite";
       public       postgres    false    188    2094    187            X           2606    26636    Es1    FK CONSTRAINT     �   ALTER TABLE ONLY "Mamiferos"
    ADD CONSTRAINT "Es1" FOREIGN KEY ("Codigo") REFERENCES "Animales"("Codigo") ON DELETE CASCADE;
 ;   ALTER TABLE ONLY public."Mamiferos" DROP CONSTRAINT "Es1";
       public       postgres    false    2076    194    181            Y           2606    26631    Es2    FK CONSTRAINT     �   ALTER TABLE ONLY "Reptiles"
    ADD CONSTRAINT "Es2" FOREIGN KEY ("Codigo") REFERENCES "Animales"("Codigo") ON UPDATE CASCADE ON DELETE CASCADE;
 :   ALTER TABLE ONLY public."Reptiles" DROP CONSTRAINT "Es2";
       public       postgres    false    181    195    2076            Z           2606    26626    Es3    FK CONSTRAINT     �   ALTER TABLE ONLY "Peces"
    ADD CONSTRAINT "Es3" FOREIGN KEY ("Codigo") REFERENCES "Animales"("Codigo") ON UPDATE CASCADE ON DELETE CASCADE;
 7   ALTER TABLE ONLY public."Peces" DROP CONSTRAINT "Es3";
       public       postgres    false    196    181    2076            [           2606    26641    Es4    FK CONSTRAINT     �   ALTER TABLE ONLY "Aves"
    ADD CONSTRAINT "Es4" FOREIGN KEY ("Codigo") REFERENCES "Animales"("Codigo") ON UPDATE CASCADE ON DELETE CASCADE;
 6   ALTER TABLE ONLY public."Aves" DROP CONSTRAINT "Es4";
       public       postgres    false    197    181    2076            S           2606    26646    Es5    FK CONSTRAINT     �   ALTER TABLE ONLY "Cuidadores"
    ADD CONSTRAINT "Es5" FOREIGN KEY ("DNI_Cuidadores") REFERENCES "Empleados"("DNI") ON UPDATE CASCADE ON DELETE CASCADE;
 <   ALTER TABLE ONLY public."Cuidadores" DROP CONSTRAINT "Es5";
       public       postgres    false    190    2078    182            T           2606    26651    Es6    FK CONSTRAINT     �   ALTER TABLE ONLY "Personal de Limpieza"
    ADD CONSTRAINT "Es6" FOREIGN KEY ("DNI") REFERENCES "Empleados"("DNI") ON UPDATE CASCADE ON DELETE CASCADE;
 F   ALTER TABLE ONLY public."Personal de Limpieza" DROP CONSTRAINT "Es6";
       public       postgres    false    182    2078    191            U           2606    26656    Es7    FK CONSTRAINT     �   ALTER TABLE ONLY "Personal Administrativo"
    ADD CONSTRAINT "Es7" FOREIGN KEY ("DNI") REFERENCES "Empleados"("DNI") ON UPDATE CASCADE ON DELETE CASCADE;
 I   ALTER TABLE ONLY public."Personal Administrativo" DROP CONSTRAINT "Es7";
       public       postgres    false    182    192    2078            V           2606    26661    Es8    FK CONSTRAINT     �   ALTER TABLE ONLY "Restauracion"
    ADD CONSTRAINT "Es8" FOREIGN KEY ("DNI") REFERENCES "Empleados"("DNI") ON UPDATE CASCADE ON DELETE CASCADE;
 >   ALTER TABLE ONLY public."Restauracion" DROP CONSTRAINT "Es8";
       public       postgres    false    182    2078    193            N           2606    26616    Escribir    FK CONSTRAINT     �   ALTER TABLE ONLY "Opinion"
    ADD CONSTRAINT "Escribir" FOREIGN KEY ("Nombre de Usuario") REFERENCES "Cliente Online"("Nombre de Usuario") ON UPDATE CASCADE;
 >   ALTER TABLE ONLY public."Opinion" DROP CONSTRAINT "Escribir";
       public       postgres    false    2085    184    185            M           2606    26711 
   Promociona    FK CONSTRAINT     �   ALTER TABLE ONLY "Entradas"
    ADD CONSTRAINT "Promociona" FOREIGN KEY ("Fecha_Oferta") REFERENCES "Oferta"("Fecha") ON UPDATE CASCADE ON DELETE CASCADE;
 A   ALTER TABLE ONLY public."Entradas" DROP CONSTRAINT "Promociona";
       public       postgres    false    186    2089    183            P           2606    26611    Realiza    FK CONSTRAINT     r   ALTER TABLE ONLY "Sorteo"
    ADD CONSTRAINT "Realiza" FOREIGN KEY ("Nombre") REFERENCES "Restaurante"("Nombre");
 <   ALTER TABLE ONLY public."Sorteo" DROP CONSTRAINT "Realiza";
       public       postgres    false    189    2094    188            J           2606    26621    Relationship14    FK CONSTRAINT        ALTER TABLE ONLY "Animales"
    ADD CONSTRAINT "Relationship14" FOREIGN KEY ("DNI") REFERENCES "Cuidadores"("DNI_Cuidadores");
 E   ALTER TABLE ONLY public."Animales" DROP CONSTRAINT "Relationship14";
       public       postgres    false    181    2100    190            \           2606    26666    Relationship24    FK CONSTRAINT     �   ALTER TABLE ONLY "Cuidar"
    ADD CONSTRAINT "Relationship24" FOREIGN KEY ("DNI") REFERENCES "Cuidadores"("DNI_Cuidadores") ON UPDATE CASCADE ON DELETE CASCADE;
 C   ALTER TABLE ONLY public."Cuidar" DROP CONSTRAINT "Relationship24";
       public       postgres    false    2100    190    198            ]           2606    26671    Relationship25    FK CONSTRAINT     �   ALTER TABLE ONLY "Cuidar"
    ADD CONSTRAINT "Relationship25" FOREIGN KEY ("Codigo") REFERENCES "Animales"("Codigo") ON UPDATE CASCADE ON DELETE CASCADE;
 C   ALTER TABLE ONLY public."Cuidar" DROP CONSTRAINT "Relationship25";
       public       postgres    false    2076    181    198            Q           2606    26706    Sortea    FK CONSTRAINT     �   ALTER TABLE ONLY "Sorteo"
    ADD CONSTRAINT "Sortea" FOREIGN KEY ("Codigo_Ticket") REFERENCES "Ticket"("Codigo_Ticket") ON UPDATE CASCADE ON DELETE CASCADE;
 ;   ALTER TABLE ONLY public."Sorteo" DROP CONSTRAINT "Sortea";
       public       postgres    false    187    2092    189            ^           2606    26696    Tiene    FK CONSTRAINT     y   ALTER TABLE ONLY "Dias no visitables"
    ADD CONSTRAINT "Tiene" FOREIGN KEY ("Codigo") REFERENCES "Reptiles"("Codigo");
 F   ALTER TABLE ONLY public."Dias no visitables" DROP CONSTRAINT "Tiene";
       public       postgres    false    195    2111    199            _           2606    26701    Tiene    FK CONSTRAINT     n   ALTER TABLE ONLY "Vacunas"
    ADD CONSTRAINT "Tiene" FOREIGN KEY ("Codigo") REFERENCES "Animales"("Codigo");
 ;   ALTER TABLE ONLY public."Vacunas" DROP CONSTRAINT "Tiene";
       public       postgres    false    200    2076    181            W           2606    26686 	   TrabajaEn    FK CONSTRAINT     �   ALTER TABLE ONLY "Restauracion"
    ADD CONSTRAINT "TrabajaEn" FOREIGN KEY ("Nombre") REFERENCES "Restaurante"("Nombre") ON UPDATE CASCADE ON DELETE CASCADE;
 D   ALTER TABLE ONLY public."Restauracion" DROP CONSTRAINT "TrabajaEn";
       public       postgres    false    193    2094    188            �   �  x���_��@ş��b>�Z���cH
�����/wugQG��~��qC4�B� 2^<?�9w$��֜4YPA��R�J�^�؍�&�5O�Ȕ��'�bY[($�0��4�=� �|���5�.������i�M�D��WB(Ԃ	0�H_����_�p�DP�~4�@��)��-mE�aC���T�?r��T��a;��'�aGx�:*-����ܻB��v4����<��(Q^�@|��YSot7����2�m������2��ė�L�(��k���<�i������8�W��rՇ��#��T��V�ƒ ���t�L�ډ8�U��^��+WR����!a���܅��m!B�o�A�ﭥ�]��׉%�T�wѴ�8=|z]-�Lz0��\a�'�J�=c�Z1��n��?�&����\�~��g��҉�}��|e�F�(_����󼿟��      �      x�32�4".NCSNe����� 5@�      �   W   x�+N,J�����\ɉ9e��`�+*MJͫ�Q@�{bQU~'��]R��2�9!��R�X���	��">�ɉŜ`ȋ���� ��#$      �   %   x��0615�40沴05713�2	�[Xr��qqq cV�      �   B   x�M˻�@��W�s������p��6YQ�YĐ�2ԡ��ö��v+Z��+��j��0<���<      �   4   x�3�4204�54�52�2ApL�L!C]3d�9��Ti��1����� O��      �   �  x���O��0�ϓO�O��tkjZ�Ҕ�,��^fmu�Ŷ�d�Oߑ�,v����<�x�橐���P�>� ���p���Ed\HVY!9�%x|:��c}�t	v.�8EF�[�(��d�4l����[u�Ð}��|fVF��YvK]��|#���`�+c��i������uۺ�H4@�܁����cHt\������k6oMc%94��YO�"
��FW��ǈo�t�)JH4~�����S�=(�<zs|u��pVYi�Ⱦ����J��
B�Ô�@����u��8��7!���������K�}���ó���O�`����>��u�����2G��Ɋ��3H�)���%���2�qj|�`�̛[8��8������K���p�p)57�2TlpyxKۺ���}������UR�v��G�#�2v����\(S�Z�8�@_��9���Dl\����;[W����x����8��اix~}��K5�g���-��?�S�      �   !  x����j�0���s�*����uo�-O��	9��I���W��#�����7�F�8 Ŏ�F��M���t?�.�7Cwf�4�×���j�'q�	PY�QQ�p�W��m�������z�L�wP��JIϣ�<vn��?^��T��K�r���ZS�g�S,)�`z�IM�)�C���baU�(*��g
"g}�ϻ�����\�j��m$��$�"�]'\m��&�����BopQ-%��2�(2}��c�U�nfh���FeO[�w��TI���C��2H$by�#ۦi~Z�1i      �   X   x��H-*�L�/�/�4��ML��W@�1~@��X��YT�i�鑚�T�������B��L�Ј���?���bCS]K]#��=... u�      �   /   x�3204�54�52�4�0�2quL����FH\�b�l� ��      �   K   x�3204�50�52�4���tI���,�2�	sZ��}J��D8MA�ɉ9e�pQCN#��kJibQJ>W� V�      �   $   x�32�44�4�25 29���e�i����� L�z      �   &   x�3��46143�2015��42,�̍�ML�b���� e�      �   8   x��452436�0�
�416��042�
r�45304�02�r�4���\1z\\\ �T�      �      x�3�2�2����� 	Nf      �   =   x�30620602��M�����0�41534��L��-L���82��K3�B1z\\\ ��E      �   ?   x��M�����tNLK-I-�L�
��K/���/��H�M*-J/M-K�&%E2����=... ���      �   X   x���K/���/�4204�54�52�4�4��M,J���DM8́�y�9�PQ#��9��1W �)f�����f�F�Xd�&q��qqq ɷ�      �   m   x��*-.����T14�30 RFz�����y饙y��\^ؕVb��$�,3�S�	�obQ2����x�%�aJ����s�qH[����/DPy��,r0��qqq ��X�      �   l   x��0�0P�4��0,`K���(�[Y��������ih��3D�q%&e&rBiߘ+ ��,�,�(�8�(��2��H-J�,�/��静�
Q
@n� Zx/     