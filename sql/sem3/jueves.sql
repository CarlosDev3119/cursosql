DO $$
BEGIN 
	FOR i in 1..50 LOOP
	
		FOR materia IN 1..5 LOOP
			INSERT INTO calificaciones (calificacion, materia, id_alumno, fecha_actualizacion)
            VALUES (FLOOR(70 + RANDOM() * 30)::INT, materia, i, CURRENT_TIMESTAMP);
		
		END LOOP;
	
	END LOOP;

END $$;

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


truncate table calificaciones;

ALTER SEQUENCE calificaciones_id_calificacion_seq RESTART WITH 1;


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


SELECT AVG(calificacion) FROM calificaciones where id_alumno = 1;

SELECT calificacion from calificaciones where id_alumno = 1;




--crear una funcion que calcule el promedio por alumno
CREATE OR REPLACE FUNCTION obtener_promedio( id INT) RETURNS FLOAT AS $$
DECLARE 
	promedio FLOAT;
BEGIN

	SELECT AVG(calificacion) INTO promedio FROM calificaciones where id_alumno = id;
	
	RETURN promedio;
	
	
END;
$$ language plpgsql;




DROP FUNCTION obtener_promedio;






SELECT calificacion from calificaciones where id_alumno = 1;

CREATE OR REPLACE FUNCTION obtener_promedio( id INT) RETURNS FLOAT AS $$
DECLARE 
	promedio FLOAT;
BEGIN

	SELECT AVG(calificacion) INTO promedio FROM calificaciones where id_alumno = id;
	
	if promedio < 70 THEN
		promedio = 70;
	
	END IF;
	
	RETURN promedio;
	
	
END;
$$ language plpgsql;



--crear una funcion que muestre las calificaciones mayores de 80 de los alumnos

CREATE OR REPLACE FUNCTION mayores_calificaciones()
RETURNS TABLE(value INT, alumno VARCHAR(100)) AS $$
BEGIN
    RETURN QUERY 
    SELECT a.calificacion AS cali, b.nombre as nombre 
    FROM calificaciones a 
    INNER JOIN alumnos b ON b.id = a.id_alumno 
    WHERE a.calificacion >= 80;
END;
$$ LANGUAGE plpgsql;



--obtener LOS 10 mejorES promedio
CREATE OR REPLACE FUNCTION obtener_alumnos_mejor_promedio()
RETURNS TABLE(id_alumno INT, promedio FLOAT) AS $$
BEGIN
    RETURN QUERY 
    SELECT c.id_alumno, obtener_promedio(c.id_alumno) as promedio
    FROM calificaciones c
    GROUP BY c.id_alumno
    order by promedio DESC
    LIMIT 10;
END;
$$ LANGUAGE plpgsql;

DROP FUNCTION mayores_calificaciones;

select * from mayores_calificaciones();

select * from obtener_alumnos_mejor_promedio();


SELECT obtener_promedio(1), nombre FROM alumnos WHERE id = 1;





