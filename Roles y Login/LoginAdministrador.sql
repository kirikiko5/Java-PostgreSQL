﻿CREATE ROLE "Administrador" LOGIN
  ENCRYPTED PASSWORD 'md585635c9ce1440bd12df405ab0ec6b84f'
  SUPERUSER INHERIT CREATEDB CREATEROLE REPLICATION;
GRANT "AdministradorRol" TO "Administrador";