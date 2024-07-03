
--mostrar continentes
INSERT INTO continent(name)
	select DISTINCT continent from country ORDER BY continent;
	
	
SELECT * FROM country;


-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."country_bk" (
    "code" bpchar(3) NOT NULL,
    "name" text NOT NULL,
    "continent" text NOT NULL,
    "region" text NOT NULL,
    "surfacearea" float4 NOT NULL,
    "indepyear" int2,
    "population" int4 NOT NULL,
    "lifeexpectancy" float4,
    "gnp" numeric(10,2),
    "gnpold" numeric(10,2),
    "localname" text NOT NULL,
    "governmentform" text NOT NULL,
    "headofstate" text,
    "capital" int4,
    "code2" bpchar(2) NOT NULL,
    PRIMARY KEY ("code")
);

--seleccionar todos los paises
SELECT * FROM country ORDER BY name ASC;

insertar en la tabla de backup los mismos registros
BEGIN;
INSERT INTO country_bk
	SELECT * FROM country ORDER BY name ASC;

commit;


SELECT * FROM country ORDER BY name ASC;

-- quitar restriccion del check
ALTER TABLE country DROP CONSTRAINT country_continent_check;

--mostrar los continentes de la tabla country con continents para validar los datos
SELECT 
	a.name, a.continent, 
	( SELECT "code" from continent b 
where b.name = a.continent ) 
FROM country a;

--actualizar los datos de la columna con la subquery anterior
UPDATE country a SET continent = ( SELECT "code" from continent b 
where b.name = a.continent );


--cambiar tipo de dato de tabla country atributo continent

ALTER TABLE country 
ALTER COLUMN continent TYPE int4 USING continent::integer;

ALTER TABLE country 
ALTER COLUMN continent TYPE int4 USING continent::integer;

ALTER TABLE country ADD FOREIGN KEY (continent) REFERENCES continent(code);


-- ejercicio
CREATE SEQUENCE IF NOT EXISTS language_code_seq;

CREATE TABLE "public"."language" (
    "code" int4 NOT NULL DEFAULT 	nextval('language_code_seq'::regclass),
    "name" text NOT NULL,
    PRIMARY KEY ("code")
);


ALTER TABLE countrylanguage
ADD COLUMN languagecode varchar(3);

SELECT DISTINCT "language" FROM countrylanguage ORDER BY language ASC;

INSERT INTO language (name)
	SELECT DISTINCT "language" FROM countrylanguage;

ALTER SEQUENCE language_code_seq RESTART WITH 1;

SELECT a.*, (SELECT code FROM "language" b where b."name" = a."language") FROM countrylanguage a;

alter table countrylanguage 
ALTER COLUMN languagecode TYPE int4 USING languagecode::integer;

update countrylanguage a SET languagecode = 
(SELECT code FROM "language" b where b."name" = a."language");

ALTER TABLE countrylanguage
ADD FOREIGN KEY (languagecode) REFERENCES "language"(code);

ALTER TABLE countrylanguage ALTER COLUMN  languagecode SET NOT NULL;

