-- nombre completo en una sola columna PARA TODA LAS VISTAS
--MOSTRANDO EL GRUPO Y CARRERA respectivos


--GENERAR UNA VISTA PARA SOLO ALUMNOS DEL GRUPO A

--GENERAR UNA VISTA PARA SOLO ALUMNOS DEL GRUPO B
--GENERAR UNA VISTA PARA SOLO ALUMNOS DEL GRUPO C





CREATE VIEW vista_alumnos as 
	SELECT a.nombre, a.ap_paterno, a.ap_materno, b.grupo, c.carrera FROM alumnos a 
	INNER JOIN grupos b ON b.id_grupo = a.grupo
	INNER JOIN carreras c ON c.id_carrera = a.carrera;

















--Funcion Basica

CREATE OR REPLACE FUNCTION saludar(nombre text) RETURNS TEXT AS $$ 

	BEGIN
	
		RETURN  'Hola,' || nombre;
		
	
	END;


$$ language plpgsql;


SELECT saludar('carlos');




DROP FUNCTION saludar;
--Funcion Basica

CREATE OR REPLACE FUNCTION saludar(nombre text) RETURNS TEXT AS $$ 

	BEGIN
	
		RAISE NOTICE 'Hola, %', nombre;
		
	
	END;


$$ language plpgsql;


SELECT saludar('carlos');



--FUNCION de suma


CREATE OR REPLACE FUNCTION sumar(a int DEFAULT 2, b int DEFAULT 5) RETURNS integer AS $$
BEGIN

	return a + b;

END;
$$ LANGUAGE plpgsql;

SELECT sumar(10, 2);



CREATE OR REPLACE FUNCTION es_mayor_de_edad(edad integer) RETURNS text AS $$
BEGIN
    IF edad >= 18 THEN
        RETURN 'Mayor de edad';
    ELSE
        RETURN 'Menor de edad';
    END IF;
END;
$$ LANGUAGE plpgsql;

SELECT es_mayor_de_edad(20);



CREATE OR REPLACE FUNCTION getFullNameByCareer(id_carrera INT) RETURNS text as $$
DECLARE 
	 name text;

BEGIN
	
	SELECT nombre || ' ' || ap_paterno || ' ' || ap_materno  INTO name FROM alumnos where carrera = id_carrera;
	
	RETURN name;
	
END;
$$ LANGUAGE plpgsql;

SELECT getFullNameByCareer(2);




DO $$
BEGIN 
	FOR I IN 1..50 LOOP
		
		RAISE NOTICE 'j = %', I;
		
	END LOOP;
	
END $$;










ALTER SEQUENCE calificaciones_id_calificacion_seq RESTART WITH 1;

CREATE FUNCTION saludar() RETURNS text AS 
'
	BEGIN
	    RETURN ''Hola, mundo!'';
	END;
' LANGUAGE plpgsql;


select saludar();










CREATE FUNCTION saludarDollar() RETURNS text AS $$

	BEGIN
	    RETURN 'Hola, mundo!';
	END;

$$LANGUAGE plpgsql;








CREATE OR REPLACE FUNCTION saludarDollar() RETURNS text AS $$

	BEGIN
	    RETURN 'Hola, mundo signo!';
	END;

$$LANGUAGE plpgsql;










select saludarDollar();



SELECT saludarDollar();




DROP FUNCTION saludar;



create table calificaciones (
	id_calificacion SERIAL PRIMARY KEY,
	calificacion INT NOT NULL,
	materia int NOT NULL,
	id_alumno INT NOT NULL,
	fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	fecha_actualizacion TIMESTAMP,
	FOREIGN KEY (materia) REFERENCES materias(id_materia),
	FOREIGN KEY (id_alumno) REFERENCES alumnos(id)
);


CREATE TABLE materias (
	id_materia serial primary key,
	materia VARCHAR(100) NOT NULL
);

INSERT INTO materias (materia) VALUES
('Matemáticas'),
('Literatura'),
('Historia'),
('Física'),
('Química');

INSERT INTO calificaciones (calificacion, materia, id_alumno, fecha_actualizacion) VALUES
(85, 1, 1, CURRENT_TIMESTAMP),
(90, 2, 1, CURRENT_TIMESTAMP),
(75, 3, 1, CURRENT_TIMESTAMP),
(88, 4, 1, CURRENT_TIMESTAMP),
(92, 5, 1, CURRENT_TIMESTAMP),

(80, 1, 2, CURRENT_TIMESTAMP),
(85, 2, 2, CURRENT_TIMESTAMP),
(78, 3, 2, CURRENT_TIMESTAMP),
(87, 4, 2, CURRENT_TIMESTAMP),
(90, 5, 2, CURRENT_TIMESTAMP),

(70, 1, 3, CURRENT_TIMESTAMP),
(75, 2, 3, CURRENT_TIMESTAMP),
(80, 3, 3, CURRENT_TIMESTAMP),
(85, 4, 3, CURRENT_TIMESTAMP),
(90, 5, 3, CURRENT_TIMESTAMP),

(82, 1, 4, CURRENT_TIMESTAMP),
(77, 2, 4, CURRENT_TIMESTAMP),
(79, 3, 4, CURRENT_TIMESTAMP),
(81, 4, 4, CURRENT_TIMESTAMP),
(85, 5, 4, CURRENT_TIMESTAMP),

(88, 1, 5, CURRENT_TIMESTAMP),
(84, 2, 5, CURRENT_TIMESTAMP),
(90, 3, 5, CURRENT_TIMESTAMP),
(87, 4, 5, CURRENT_TIMESTAMP),
(91, 5, 5, CURRENT_TIMESTAMP);
TRUNCATE TABLE calificaciones;

select * FROM CALIFICACIONEs;

DO $$
BEGIN 
	FOR I IN 1..50 LOOP
		
		 INSERT INTO calificaciones (calificacion, materia, id_alumno, fecha_actualizacion) VALUES
        (FLOOR(70 + RANDOM() * 30)::INT, 1, i, CURRENT_TIMESTAMP),
        (FLOOR(70 + RANDOM() * 30)::INT, 2, i, CURRENT_TIMESTAMP),
        (FLOOR(70 + RANDOM() * 30)::INT, 3, i, CURRENT_TIMESTAMP),
        (FLOOR(70 + RANDOM() * 30)::INT, 4, i, CURRENT_TIMESTAMP),
        (FLOOR(70 + RANDOM() * 30)::INT, 5, i, CURRENT_TIMESTAMP);
		
	END LOOP;
	
END $$;




DO $$ 
BEGIN 
	FOR i IN 1..50 LOOP
		RAISE NOTICE 'i = %', i;
		
		FOR j IN 1..5 LOOP
			RAISE NOTICE 'j = %', j;
		
		END LOOP;
		
	END LOOP;

END $$;



DO $$
BEGIN 
	FOR i in 1..50 LOOP
	
		FOR materia IN 1..5 LOOP
			INSERT INTO calificaciones (calificacion, materia, id_alumno, fecha_actualizacion)
            VALUES (FLOOR(70 + RANDOM() * 30)::INT, materia, i, CURRENT_TIMESTAMP);
		
		END LOOP;
	
	END LOOP;

END $$;













CREATE OR REPLACE FUNCTION generar_numeros() 
RETURNS TABLE (numero INTEGER, numero2 INTEGER, numero3 TEXT)  -- Definición de la tabla que la función devuelve
AS $$
DECLARE
    i INTEGER;
BEGIN
    FOR i IN 1..3 LOOP
    
    	FOR j in 1..10 LOOP
    	  	RETURN QUERY 
        	SELECT i, j, i||'x'|| j || '=' || i * j;
    	END LOOP;
        
      
    END LOOP;
END;
$$ LANGUAGE plpgsql;

DROP FUNCTION generar_numeros;
select * FROM generar_numeros();