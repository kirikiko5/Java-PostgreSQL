/*
Created: 16/03/16
Modified: 21/04/16
Model: PostgreSQL 9.4
Database: PostgreSQL 9.4
*/


-- Create tables section -------------------------------------------------

-- Table Animales

CREATE TABLE "Animales"(
 "Codigo" Integer NOT NULL,
 "Tipo" Varchar NOT NULL,
 "Fecha de Nacimiento" Date NOT NULL,
 "Nombre Comun" Name NOT NULL,
 "Nombre Cientifico" Name NOT NULL,
 "Descripcion" Text,
 "Ubicacion" Varchar NOT NULL,
 "DNI" Varchar
)
;

-- Create indexes for table Animales

CREATE INDEX "IX_Relationship14" ON "Animales" ("DNI")
;

-- Add keys for table Animales

ALTER TABLE "Animales" ADD CONSTRAINT "Key1" PRIMARY KEY ("Codigo")
;

-- Table Empleados

CREATE TABLE "Empleados"(
 "DNI" Varchar NOT NULL,
 "Nombre" Name NOT NULL,
 "Direccion" Varchar NOT NULL,
 "Telefono" Integer NOT NULL,
 "Correo Electronico" Varchar NOT NULL,
 "Tipo" Varchar NOT NULL,
 "Turno" Varchar NOT NULL
)
;

-- Add keys for table Empleados

ALTER TABLE "Empleados" ADD CONSTRAINT "Key2" PRIMARY KEY ("DNI")
;

-- Table Entradas

CREATE TABLE "Entradas"(
 "Fecha" Date,
 "Codigo Postal" Integer,
 "Precio sin IVA" Money NOT NULL,
 "Precio con IVA" Money NOT NULL,
 "Tipo" Varchar NOT NULL,
 "Codigo_Entrada" Integer NOT NULL,
 "Porcentaje_Administrativo" Integer,
 "Porcentaje_Cuidadores" Bigint,
 "Nombre de Usuario" Varchar,
 "DNI" Varchar
)
;

-- Create indexes for table Entradas

CREATE INDEX "Cliente" ON "Entradas" ("Nombre de Usuario")
;

CREATE INDEX "IX_Relationship28" ON "Entradas" ("DNI")
;

CREATE INDEX "IX_Relationship29" ON "Entradas" ("Fecha")
;

-- Add keys for table Entradas

ALTER TABLE "Entradas" ADD CONSTRAINT "Key3" PRIMARY KEY ("Codigo_Entrada")
;

-- Table Cliente Online

CREATE TABLE "Cliente Online"(
 "Nombre de Usuario" Varchar NOT NULL,
 "Contrasena" Varchar NOT NULL
)
;

-- Add keys for table Cliente Online

ALTER TABLE "Cliente Online" ADD CONSTRAINT "Key4" PRIMARY KEY ("Nombre de Usuario")
;

-- Table Opinion

CREATE TABLE "Opinion"(
 "Fecha" Date NOT NULL,
 "Puntuacion" Integer NOT NULL,
 "Descripcion" Varchar,
 "Nombre de Usuario" Varchar NOT NULL
)
;

-- Add keys for table Opinion

ALTER TABLE "Opinion" ADD CONSTRAINT "Key5" PRIMARY KEY ("Nombre de Usuario")
;

-- Table Oferta

CREATE TABLE "Oferta"(
 "Fecha" Date NOT NULL,
 "Cantidad" Varchar NOT NULL
)
;

-- Add keys for table Oferta

ALTER TABLE "Oferta" ADD CONSTRAINT "Key6" PRIMARY KEY ("Fecha")
;

-- Table Ticket

CREATE TABLE "Ticket"(
 "Nombre Empleado" Name,
 "Articulos Consumidos" Text,
 "Precio sin IVA" Money NOT NULL,
 "Precio con IVA" Money NOT NULL,
 "Codigo_Ticket" Integer NOT NULL,
 "Nombre" Name
)
;

-- Create indexes for table Ticket

CREATE INDEX "IX_Relationship35" ON "Ticket" ("Nombre")
;

-- Add keys for table Ticket

ALTER TABLE "Ticket" ADD CONSTRAINT "Key7" PRIMARY KEY ("Codigo_Ticket")
;

-- Table Restaurante

CREATE TABLE "Restaurante"(
 "Nombre" Name NOT NULL,
 "Tipo" Varchar NOT NULL
)
;

-- Add keys for table Restaurante

ALTER TABLE "Restaurante" ADD CONSTRAINT "Key8" PRIMARY KEY ("Nombre")
;

-- Table Sorteo

CREATE TABLE "Sorteo"(
 "Nombre" Name NOT NULL,
 "Fecha" Date NOT NULL,
 "Codigo_Ticket" Integer NOT NULL,
 "Codigo_Entrada" Integer NOT NULL
)
;

-- Create indexes for table Sorteo

CREATE INDEX "IX_Relationship27" ON "Sorteo" ("Codigo_Ticket")
;

CREATE INDEX "IX_Relationship26" ON "Sorteo" ("Codigo_Entrada")
;

-- Add keys for table Sorteo

ALTER TABLE "Sorteo" ADD CONSTRAINT "Key9" PRIMARY KEY ("Nombre")
;

-- Table Cuidadores

CREATE TABLE "Cuidadores"(
 "DNI_Cuidadores" Varchar NOT NULL
)
;

-- Add keys for table Cuidadores

ALTER TABLE "Cuidadores" ADD CONSTRAINT "Key10" PRIMARY KEY ("DNI_Cuidadores")
;

-- Table Personal de Limpieza

CREATE TABLE "Personal de Limpieza"(
 "Lugar" Varchar NOT NULL,
 "DNI" Varchar NOT NULL
)
;

-- Add keys for table Personal de Limpieza

ALTER TABLE "Personal de Limpieza" ADD CONSTRAINT "Key11" PRIMARY KEY ("DNI")
;

-- Table Personal Administrativo

CREATE TABLE "Personal Administrativo"(
 "DNI" Varchar NOT NULL
)
;

-- Add keys for table Personal Administrativo

ALTER TABLE "Personal Administrativo" ADD CONSTRAINT "Key12" PRIMARY KEY ("DNI")
;

-- Table Restauracion

CREATE TABLE "Restauracion"(
 "DNI" Varchar NOT NULL,
 "Nombre" Name NOT NULL
)
;

-- Create indexes for table Restauracion

CREATE INDEX "IX_Relationship37" ON "Restauracion" ("Nombre")
;

-- Add keys for table Restauracion

ALTER TABLE "Restauracion" ADD CONSTRAINT "Key13" PRIMARY KEY ("DNI")
;

-- Table Mamiferos

CREATE TABLE "Mamiferos"(
 "Tipo de Comida" Varchar NOT NULL,
 "Codigo" Integer NOT NULL,
 "Sexo" Character(20) NOT NULL,
 "Fecha de parto" Date,
 "Preniada" Boolean
)
;

-- Add keys for table Mamiferos

ALTER TABLE "Mamiferos" ADD CONSTRAINT "Key14" PRIMARY KEY ("Codigo")
;

-- Table Reptiles

CREATE TABLE "Reptiles"(
 "Codigo" Integer NOT NULL
)
;

-- Add keys for table Reptiles

ALTER TABLE "Reptiles" ADD CONSTRAINT "Key15" PRIMARY KEY ("Codigo")
;

-- Table Peces

CREATE TABLE "Peces"(
 "Tamanio" Integer NOT NULL,
 "Codigo" Integer NOT NULL,
 "Peso" Integer NOT NULL
)
;

-- Add keys for table Peces

ALTER TABLE "Peces" ADD CONSTRAINT "Key16" PRIMARY KEY ("Codigo")
;

-- Table Aves

CREATE TABLE "Aves"(
 "Peso" Integer NOT NULL,
 "Envergadura" Integer NOT NULL,
 "Codigo" Integer NOT NULL
)
;

-- Add keys for table Aves

ALTER TABLE "Aves" ADD CONSTRAINT "Key17" PRIMARY KEY ("Codigo")
;

-- Table Cuidar

CREATE TABLE "Cuidar"(
 "DNI" Varchar NOT NULL,
 "Codigo" Integer NOT NULL
)
;

-- Add keys for table Cuidar

ALTER TABLE "Cuidar" ADD CONSTRAINT "Key20" PRIMARY KEY ("DNI","Codigo")
;

-- Table Dias no visitables

CREATE TABLE "Dias no visitables"(
 "Codigo" Integer NOT NULL,
 "Fecha" Date NOT NULL
)
;

-- Add keys for table Dias no visitables

ALTER TABLE "Dias no visitables" ADD CONSTRAINT "Key21" PRIMARY KEY ("Codigo","Fecha")
;

-- Table Vacunas

CREATE TABLE "Vacunas"(
 "Nombre" Text NOT NULL,
 "Codigo" Integer NOT NULL
)
;

-- Add keys for table Vacunas

ALTER TABLE "Vacunas" ADD CONSTRAINT "Key22" PRIMARY KEY ("Nombre","Codigo")
;

-- Create relationships section ------------------------------------------------- 

ALTER TABLE "Sorteo" ADD CONSTRAINT "Realiza" FOREIGN KEY ("Nombre") REFERENCES "Restaurante" ("Nombre") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "Opinion" ADD CONSTRAINT "Escribir" FOREIGN KEY ("Nombre de Usuario") REFERENCES "Cliente Online" ("Nombre de Usuario") ON DELETE NO ACTION ON UPDATE CASCADE
;

ALTER TABLE "Animales" ADD CONSTRAINT "Relationship14" FOREIGN KEY ("DNI") REFERENCES "Cuidadores" ("DNI_Cuidadores") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "Peces" ADD CONSTRAINT "Es3" FOREIGN KEY ("Codigo") REFERENCES "Animales" ("Codigo") ON DELETE CASCADE ON UPDATE CASCADE
;

ALTER TABLE "Reptiles" ADD CONSTRAINT "Es2" FOREIGN KEY ("Codigo") REFERENCES "Animales" ("Codigo") ON DELETE CASCADE ON UPDATE CASCADE
;

ALTER TABLE "Mamiferos" ADD CONSTRAINT "Es1" FOREIGN KEY ("Codigo") REFERENCES "Animales" ("Codigo") ON DELETE CASCADE ON UPDATE NO ACTION
;

ALTER TABLE "Aves" ADD CONSTRAINT "Es4" FOREIGN KEY ("Codigo") REFERENCES "Animales" ("Codigo") ON DELETE CASCADE ON UPDATE CASCADE
;

ALTER TABLE "Cuidadores" ADD CONSTRAINT "Es5" FOREIGN KEY ("DNI_Cuidadores") REFERENCES "Empleados" ("DNI") ON DELETE CASCADE ON UPDATE CASCADE
;

ALTER TABLE "Personal de Limpieza" ADD CONSTRAINT "Es6" FOREIGN KEY ("DNI") REFERENCES "Empleados" ("DNI") ON DELETE CASCADE ON UPDATE CASCADE
;

ALTER TABLE "Personal Administrativo" ADD CONSTRAINT "Es7" FOREIGN KEY ("DNI") REFERENCES "Empleados" ("DNI") ON DELETE CASCADE ON UPDATE CASCADE
;

ALTER TABLE "Restauracion" ADD CONSTRAINT "Es8" FOREIGN KEY ("DNI") REFERENCES "Empleados" ("DNI") ON DELETE CASCADE ON UPDATE CASCADE
;

ALTER TABLE "Cuidar" ADD CONSTRAINT "Relationship24" FOREIGN KEY ("DNI") REFERENCES "Cuidadores" ("DNI_Cuidadores") ON DELETE CASCADE ON UPDATE CASCADE
;

ALTER TABLE "Cuidar" ADD CONSTRAINT "Relationship25" FOREIGN KEY ("Codigo") REFERENCES "Animales" ("Codigo") ON DELETE CASCADE ON UPDATE CASCADE
;

ALTER TABLE "Entradas" ADD CONSTRAINT "Adquirir" FOREIGN KEY ("Nombre de Usuario") REFERENCES "Cliente Online" ("Nombre de Usuario") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "Ticket" ADD CONSTRAINT "Emite" FOREIGN KEY ("Nombre") REFERENCES "Restaurante" ("Nombre") ON DELETE NO ACTION ON UPDATE CASCADE
;

ALTER TABLE "Restauracion" ADD CONSTRAINT "TrabajaEn" FOREIGN KEY ("Nombre") REFERENCES "Restaurante" ("Nombre") ON DELETE CASCADE ON UPDATE CASCADE
;

ALTER TABLE "Entradas" ADD CONSTRAINT "Descuento" FOREIGN KEY ("DNI") REFERENCES "Empleados" ("DNI") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "Dias no visitables" ADD CONSTRAINT "Tiene" FOREIGN KEY ("Codigo") REFERENCES "Reptiles" ("Codigo") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "Vacunas" ADD CONSTRAINT "Tiene" FOREIGN KEY ("Codigo") REFERENCES "Animales" ("Codigo") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "Sorteo" ADD CONSTRAINT "Sortea" FOREIGN KEY ("Codigo_Ticket") REFERENCES "Ticket" ("Codigo_Ticket") ON DELETE CASCADE ON UPDATE CASCADE
;

ALTER TABLE "Entradas" ADD CONSTRAINT "Promociona" FOREIGN KEY ("Fecha") REFERENCES "Oferta" ("Fecha") ON DELETE CASCADE ON UPDATE CASCADE
;

ALTER TABLE "Sorteo" ADD CONSTRAINT "Devuelve" FOREIGN KEY ("Codigo_Entrada") REFERENCES "Entradas" ("Codigo_Entrada") ON DELETE RESTRICT ON UPDATE CASCADE
;




