CREATE TABLE alumnos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    grupo VARCHAR(50) NOT NULL,
    carrera VARCHAR(100) NOT NULL
);

INSERT INTO alumnos (nombre, grupo, carrera) VALUES
('Juan Pérez García', 'Grupo A', 'Ingeniería en Sistemas'),
('María López Hernández', 'Grupo B', 'Medicina'),
('Carlos Sánchez Martínez', 'Grupo C', 'Derecho'),
('Ana Rodríguez Gómez', 'Grupo A', 'Ingeniería en Sistemas'),
('Luis Fernández Torres', 'Grupo B', 'Medicina'),
('Sofía González Ruiz', 'Grupo C', 'Derecho'),
('Miguel Hernández Díaz', 'Grupo A', 'Ingeniería en Sistemas'),
('Laura Martínez Pérez', 'Grupo B', 'Medicina'),
('Diego López Morales', 'Grupo C', 'Derecho'),
('Elena García Fernández', 'Grupo A', 'Ingeniería en Sistemas'),
('Pablo Jiménez Vargas', 'Grupo B', 'Medicina'),
('Claudia Ramírez Ortiz', 'Grupo C', 'Derecho'),
('Fernando Castillo Núñez', 'Grupo A', 'Ingeniería en Sistemas'),
('Patricia Romero Peña', 'Grupo B', 'Medicina'),
('Jorge Herrera Silva', 'Grupo C', 'Derecho'),
('Gloria Rivas Sánchez', 'Grupo A', 'Ingeniería en Sistemas'),
('Roberto Delgado Torres', 'Grupo B', 'Medicina'),
('Isabel Navarro Morales', 'Grupo C', 'Derecho'),
('Francisco Álvarez Gómez', 'Grupo A', 'Ingeniería en Sistemas'),
('Andrea Soto López', 'Grupo B', 'Medicina'),
('José Ramírez Díaz', 'Grupo C', 'Derecho'),
('Rosa Ruiz Jiménez', 'Grupo A', 'Ingeniería en Sistemas'),
('Raúl Morales Pérez', 'Grupo B', 'Medicina'),
('Adriana Herrera Vargas', 'Grupo C', 'Derecho'),
('Manuel García Ríos', 'Grupo A', 'Ingeniería en Sistemas'),
('Beatriz Castillo Núñez', 'Grupo B', 'Medicina'),
('Gabriel Romero Peña', 'Grupo C', 'Derecho'),
('Verónica Rivas Sánchez', 'Grupo A', 'Ingeniería en Sistemas'),
('Alfredo Delgado Torres', 'Grupo B', 'Medicina'),
('Silvia Navarro Morales', 'Grupo C', 'Derecho'),
('Victor Álvarez Gómez', 'Grupo A', 'Ingeniería en Sistemas'),
('Marta Soto López', 'Grupo B', 'Medicina'),
('Pedro Ramírez Díaz', 'Grupo C', 'Derecho'),
('Lucía Ruiz Jiménez', 'Grupo A', 'Ingeniería en Sistemas'),
('Emilio Morales Pérez', 'Grupo B', 'Medicina'),
('Carmen Herrera Vargas', 'Grupo C', 'Derecho'),
('Enrique García Ríos', 'Grupo A', 'Ingeniería en Sistemas'),
('Natalia Castillo Núñez', 'Grupo B', 'Medicina'),
('Daniel Romero Peña', 'Grupo C', 'Derecho'),
('Paula Rivas Sánchez', 'Grupo A', 'Ingeniería en Sistemas'),
('Ignacio Delgado Torres', 'Grupo B', 'Medicina'),
('Sara Navarro Morales', 'Grupo C', 'Derecho'),
('Óscar Álvarez Gómez', 'Grupo A', 'Ingeniería en Sistemas'),
('Irene Soto López', 'Grupo B', 'Medicina'),
('Marcos Ramírez Díaz', 'Grupo C', 'Derecho'),
('Eva Ruiz Jiménez', 'Grupo A', 'Ingeniería en Sistemas'),
('Ricardo Morales Pérez', 'Grupo B', 'Medicina'),
('Teresa Herrera Vargas', 'Grupo C', 'Derecho'),
('Hugo García Ríos', 'Grupo A', 'Ingeniería en Sistemas');



-- normalizar la base de datos

-- Crear una tabla independiente para los grupos 

CREATE TABLE grupos (
	id_grupo SERIAL PRIMARY KEY,
	grupo varchar(10)
);

-- Crear una tabla independiente para las carreras
CREATE TABLE carreras (
	id_carrera SERIAL PRIMARY KEY,
	carrera varchar(100)
);


-- actualizar la tabla de alumnos en la columna de grupos por los id de la tabla grupos
select grupo from alumnos;

SELECT DISTINCT grupo FROM alumnos;

INSERT INTO grupos (grupo)
	SELECT DISTINCT grupo FROM alumnos;


SELECT a.grupo, (SELECT id_grupo FROM grupos g WHERE g.grupo = a.grupo) FROM alumnos a;

UPDATE alumnos a SET grupo = (SELECT id_grupo FROM grupos g WHERE g.grupo = a.grupo);

-- actualizar la tabla de alumnos en la columna de carreras por los id de la tabla carreras
select carrera from alumnos;

SELECT DISTINCT carrera FROM alumnos;

INSERT INTO carreras (carrera)
	SELECT DISTINCT carrera FROM alumnos;
	

SELECT a.carrera, (SELECT id_carrera FROM carreras c WHERE c.carrera = a.carrera) FROM alumnos a;

UPDATE alumnos a SET carrera = (SELECT id_carrera FROM carreras c WHERE c.carrera = a.carrera);


-- cambiar el tipo de dato de grupos a int4

alter table alumnos
alter column grupo TYPE INTEGER using grupo :: integer;

-- cambiar el tipo de dato de carrera a int4

alter table alumnos
alter column carrera TYPE INTEGER using carrera :: integer;

-- crear llaves foraneas para carreras y grupos
ALTER TABLE alumnos
ADD FOREIGN KEY (grupo) REFERENCES grupos(id_grupo);

ALTER TABLE alumnos
ADD FOREIGN KEY (carrera) REFERENCES carreras(id_carrera);

-- crear constraint not null para la columna carrera y grupos
ALTER TABLE alumnos
ALTER COLUMN grupo SET NOT NULL; 

ALTER TABLE alumnos
ALTER COLUMN carrera SET NOT NULL; 

-- crear columnas de ap_paterno y ap_materno

ALTER TABLE alumnos
ADD COLUMN ap_paterno varchar(50);

ALTER TABLE alumnos
ADD COLUMN ap_materno varchar(50);


-- separar el nombre y actualizar las columnas que se crearon anteriormente.

SELECT nombre from alumnos;

SELECT nombre, SPLIT_PART(nombre, ' ', 3) FROM alumnos;

UPDATE alumnos SET ap_paterno = SPLIT_PART(nombre, ' ', 2);

UPDATE alumnos SET ap_materno = SPLIT_PART(nombre, ' ', 3);

UPDATE alumnos SET nombre = SPLIT_PART(nombre, ' ', 1);


SELECT nombre, ap_paterno, ap_materno, grupo, carrera FROM alumnos;

SELECT a.nombre, a.ap_paterno, a.ap_materno, b.grupo, c.carrera FROM alumnos a 
	INNER JOIN grupos b ON b.id_grupo = a.grupo
	INNER JOIN carreras c ON c.id_carrera = a.carrera;
	

CREATE VIEW vista_alumnos as 
	SELECT a.nombre, a.ap_paterno, a.ap_materno, b.grupo, c.carrera FROM alumnos a 
	INNER JOIN grupos b ON b.id_grupo = a.grupo
	INNER JOIN carreras c ON c.id_carrera = a.carrera;
		
select * FROM vista_alumnos WHERE carrera = 'Ingeniería en Sistemas';
	
SELECT * FROM carreras;

insert into alumnos (nombre, ap_paterno, ap_materno, grupo, carrera)
	VALUES('Carlos', 'Ortega', 'Cordova', 3, 2);





