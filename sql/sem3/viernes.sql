-- SELECT * FROM regions;

-- si no se quiere dar acceso a otros desarrolladores a la data 
-- es bueno crear funciones y procedimientos almacenados
-- esto nos servira para restringir las consultas y solo dar acceso a lo que nosotros consideremos.

-- select * from countries;


-- select * from country_region();


-- CREATE OR REPLACE FUNCTION country_region() RETURNS TABLE(id character(2), name varchar(40), region varchar(25) ) AS $$
-- BEGIN
	
-- 	RETURN QUERY
-- 	SELECT country_id, country_name, region_name FROM countries
-- 	INNER JOIN regions ON countries.region_id = regions.region_id;
	
	
-- END;
-- $$ LANGUAGE plpgsql;


-- CREATE OR REPLACE PROCEDURE insert_region_proc( int, varchar)
-- as $$ 
-- -- declare 
-- BEGIN

-- 	insert into regions( region_id, region_name) VALUES ( $1, $2);
-- 	ROLLBACK;

-- END;
-- $$ LANGUAGE plpgsql;


-- CALL insert_region_proc(5, 'Central america');

-- SELECT * from regions;



-- CREATE OR REPLACE FUNCTION max_raise( empl_id int )
-- returns NUMERIC(8,2) as $$

-- DECLARE
-- 	possible_raise NUMERIC(8,2);

-- BEGIN
	
-- 	select 
-- 		max_salary - salary into possible_raise
-- 	from employees
-- 	INNER JOIN jobs on jobs.job_id = employees.job_id
-- 	WHERE employee_id = empl_id;

-- 	if ( possible_raise < 0 ) THEN
-- 		possible_raise = 0;
-- 	end if;

-- 	return possible_raise;

-- END;
-- $$ LANGUAGE plpgsql;




-- SELECT  
-- 	CURRENT_DATE as "date", 
-- 	employee_id,
-- 	salary, 
-- 	max_raise( employee_id ), 
-- 	max_Raise(employee_id) * 0.01 as amount,
-- 	5 as percentage
-- from employees;



-- CREATE OR REPLACE PROCEDURE controlled_raise (percentage NUMERIC ) AS 
-- $$
-- DECLARE 
-- 	real_percentage NUMERIC;
-- 	total_employees int;
-- BEGIN

-- 	real_percentage = percentage / 100;
	
-- 	INSERT INTO raise_history(date, employee_id, base_salary, amount, percentage)
-- 	SELECT  
-- 		CURRENT_DATE as "date", 
-- 		employee_id,
-- 		salary, 
-- 		max_Raise(employee_id) * real_percentage as amount,
-- 		real_percentage
-- 	from employees;
	
-- 	--IMPACTAR LA TABLA DE EMPLEADOS
-- 	UPDATE employees 
-- 		SET salary = (max_raise(employee_id) * real_percentage) + salary;
	
-- 	COMMIT;
	
-- 	select count(*) into total_employees from employees;

-- 	RAISE NOTICE 'afectados % empleados', total_employees;

-- end;
-- $$ Language plpgsql;


-- SELECT * FROM employees;

-- call controlled_raise(5);



CREATE table sesiones(
	id_sesion SERIAL PRIMARY KEY,
	usuario VARCHAR(50),
	ultimo_inicio TIMESTAMP default CURRENT_TIMESTAMP
);


CREATE table sesiones_erroneas(
	id_sesion SERIAL PRIMARY KEY,
	usuario VARCHAR(50),
	ultimo_inicio TIMESTAMP default CURRENT_TIMESTAMP
);

CREATE TABLE promedios (
    id_promedio SERIAL PRIMARY KEY,
    id_alumno INT,
    promedio DECIMAL(5, 2),
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



CREATE SEQUENCE IF NOT EXISTS user_id_seq;
DROP TABLE user;
-- Table Definition
CREATE TABLE "public"."user" (
    "id" int4 NOT NULL DEFAULT nextval('user_id_seq'::regclass),
    "username" varchar,
    "password" text,
    "last_loggin" timestamp
);



--triggerss

-- los procedimientos almacenanos, y triggers son muy parecidos a las funciones

-- crear un ejemplo para simular un login


--libreria de postgres
CREATE extension pgcrypto;

INSERT INTO "user" (username, password)
values('Carlos', crypt('123456', gen_salt('bf')));

SELECT * FROM "user";

SELECT COUNT(*) FROM "user"
	WHERE username = 'Carlos' and password = crypt('123456', password);


--crear una consulta para encontrar el usuario con su passord y contrase;a
SELECT COUNT(*) FROM "user"
		WHERE username = 'Carlos' and password = crypt('123456', password);

--procedimiento para encontrar el usuario con password y contrase;a y actualizar su ultimo inicio de sesion
create or replace PROCEDURE user_login(user_name varchar, user_password varchar) as $$
DECLARE
	existe_usuario BOOLEAN;
	
BEGIN
	SELECT COUNT(*) into existe_usuario FROM "user"
		WHERE username = user_name and password = crypt(user_password, password);
	
	update "user" SET last_loggin = now() where username = user_name;
	commit;
	raise notice 'Usuario %', existe_usuario;

END;
$$ LANGUAGE plpgsql;



--consulta compleja con registros a sesiones erroneas 
create or replace PROCEDURE user_login(user_name varchar, user_password varchar) as $$
DECLARE
	was_found BOOLEAN;
	
BEGIN
	SELECT COUNT(*) into was_found FROM "user"
		WHERE username = user_name and password = crypt(user_password, password);
		
	if ( was_found = false ) THEN 
	
		INSERT INTO sesiones_erroneas(usuario, ultimo_inicio)values( user_name, now());
		commit;
		RAISE EXCEPTION 'Usuario incorrecto';
		
	END IF;
	
	update "user" SET last_loggin = now() where username = user_name;

	raise notice 'Usuario %', was_found;

END;
$$ LANGUAGE plpgsql;


call user_login('Carlos', '1234562');




CREATE OR REPLACE TRIGGER crear_sesion_trigger after update ON "user"
FOR EACH ROW EXECUTE PROCEDURE crear_registro_sesion();


CREATE OR REPLACE FUNCTION crear_registro_sesion()
RETURNS TRIGGER AS $$
BEGIN
	insert INTO sesiones(usuario, ultimo_inicio) values (NEW.username, now() );
	
	return new;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION crear_registro_sesion()
RETURNS TRIGGER AS $$
BEGIN
	insert INTO sesiones(usuario, ultimo_inicio) values (NEW.username, now() );
	
	return new;
END;
$$ LANGUAGE plpgsql;






CREATE OR REPLACE PROCEDURE insertar_calificacion (calificacion int, id_materia int,  id_alumno int ) AS 
$$
DECLARE 
	
BEGIN
	 	INSERT INTO calificaciones (calificacion, materia, id_alumno, fecha_actualizacion)
	 		values(calificacion, id_materia, id_alumno, CURRENT_TIMESTAMP );
	 	
		
	EXCEPTION
	 	WHEN foreign_key_violation THEN
    		RAISE EXCEPTION 'Error desconocido (SQLSTATE: %)', SQLSTATE;
	

end;
$$ Language plpgsql;






CREATE OR REPLACE FUNCTION obtener_promedio( id INT) RETURNS FLOAT AS $$
DECLARE 
	promedio FLOAT;
BEGIN

	SELECT AVG(calificacion) INTO promedio FROM calificaciones where id_alumno = id;
	
	RETURN promedio;
	
	
END;
$$ language plpgsql;







--crear trigger para guardar en promedios cuando ya se tengan las 5 calificaciones del alumno
CREATE OR REPLACE FUNCTION calcular_promedio()
RETURNS TRIGGER AS $$
DECLARE 
	total_materias INT ;
	sum_calificaciones NUMERIC;
	promedio int;
BEGIN

 -- Contar el número de materias únicas para el alumno
    SELECT COUNT(DISTINCT materia), SUM(calificacion) INTO total_materias, sum_calificaciones
    FROM calificaciones
    WHERE id_alumno = NEW.id_alumno;
    
    -- Verificar si el alumno tiene calificaciones en 5 materias diferentes
    IF total_materias = 5 THEN
        promedio = obtener_promedio(NEW.id_alumno);
        
        -- Insertar el promedio en la tabla de promedios
        INSERT INTO promedios (id_alumno, promedio)
        VALUES (NEW.id_alumno, promedio);
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE TRIGGER trigger_calcular_promedio
AFTER INSERT ON calificaciones
FOR EACH ROW
EXECUTE FUNCTION calcular_promedio();












	



















CALL insertar_calificacion(76, 2, 5);


CALL insertar_calificacion(76, 1, 50);

select * from calificaciones where id_alumno = 50;


--SIMULAR LOGIN


--triggerss
CREATE extension pgcrypto;

INSERT INTO "user" (username, password)
values('Carlos', crypt('123456', gen_salt('bf')));

SELECT * FROM "user";

SELECT COUNT(*) FROM "user"
	WHERE username = 'Carlos' and password = crypt('123456', password);



create or replace PROCEDURE user_login(user_name varchar, user_password varchar) as $$
DECLARE
	was_found BOOLEAN;
	
BEGIN
	SELECT COUNT(*) into was_found FROM "user"
		WHERE username = user_name and password = crypt(user_password, password);
		
	if ( was_found = false ) THEN 
	
		INSERT INTO sesiones_erroneas(usuario, ultimo_inicio)values( user_name, now());
		commit;
		RAISE EXCEPTION 'Usuario incorrecto';
		
	END IF;
	
	update "user" SET last_loggin = now() where username = user_name;
	commit;
	raise notice 'Usuario %', was_found;

END;
$$ LANGUAGE plpgsql;


call user_login('Carlos', '1234562');


CREATE table sesiones(
	id_sesion SERIAL PRIMARY KEY,
	usuario VARCHAR(50),
	ultimo_inicio TIMESTAMP default CURRENT_TIMESTAMP
);


CREATE table sesiones_erroneas(
	id_sesion SERIAL PRIMARY KEY,
	usuario VARCHAR(50),
	ultimo_inicio TIMESTAMP default CURRENT_TIMESTAMP
);


CREATE OR REPLACE TRIGGER crear_sesion_trigger after update ON "user"
FOR EACH ROW EXECUTE PROCEDURE crear_registro_sesion();


CREATE OR REPLACE FUNCTION crear_registro_sesion()
RETURNS TRIGGER AS $$
BEGIN
	insert INTO sesiones(usuario, ultimo_inicio) values (NEW.username, now() );
	
	return new;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION crear_registro_sesion()
RETURNS TRIGGER AS $$
BEGIN
	insert INTO sesiones(usuario, ultimo_inicio) values (NEW.username, now() );
	
	return new;
END;
$$ LANGUAGE plpgsql;









