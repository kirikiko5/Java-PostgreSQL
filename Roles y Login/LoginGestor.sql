﻿CREATE ROLE "Gestor" LOGIN
  ENCRYPTED PASSWORD 'md57036ee946e9fe6731f480bfb189181e2'
  NOSUPERUSER INHERIT CREATEDB NOCREATEROLE NOREPLICATION;
GRANT "GrupoGestor" TO "Gestor";