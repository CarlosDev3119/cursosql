
--explicacion de distinct
SELECT email FROM users;

SELECT DISTINCT email FROM users;

SELECT substring(email, POSITION('@' in email)) FROM users;

SELECT DISTINCT substring(email, POSITION('@' in email)) FROM users;



--MODIFICAR TABLA USERS EN LA COLUMNA NUMERO DE TELEFONO POR INT Y QUITAR EL GUION
BEGIN;
	UPDATE users set phone_number = REPLACE(phone_number, '-', '');
commit;

-- MYSQL
ALTER TABLE
    phone_number
MODIFY
    COLUMN phone_number INT;

--POSTGRESQL
ALTER TABLE
    users
ALTER COLUMN
    phone_number TYPE INTEGER USING phone_number :: integer;



-- AGREGAR CONSTRAINT CHECK AL ATRIBUTO PHONE_NUMBER

ALTER TABLE users ADD CHECK(
	phone_number >=0
);


ALTER TABLE users ADD CHECK(
	(phone_number::text ~ '^[0-9]+$')
);

ALTER TABLE users ADD CHECK(
	(name !~ '[0-9]')
);


ALTER TABLE users ADD CONSTRAINT check_phone_number CHECK(
	phone_number >=0
);


-- ELIMINACION DE UNA CONSTRAINT
ALTER TABLE users DROP CONSTRAINT check_phone_number;

--MOSTRAR CONSTRAINTS
SELECT
    CONSTRAINT_NAME,
    constraint_type
FROM
    information_schema.table_constraints
WHERE
    table_name = 'users';


ALTER TABLE roles ADD CHECK(
	( role_name = 'admin') or 
	( role_name = 'user') or 
	( role_name = 'client') or 
	( role_name = 'general') 
);


--Agregar constraint check a la tabla de roles y solo debe de permitir los siguientes roles

	--admin, user, client, general


--descomoponer la direccion y crear una tabla independiente considerando los siguientes valores

--TABLA DIRECCIONES:
	-- id, calle, numero interior, numero exterior, CODIGO POSTAL

-- TABLA CODIGO POSTAL
	-- id, codigo postal, id localidad

-- TABLA LOCALIDAD
	--id, localidad, id municipio

-- TABLA MUNICIPIO
	-- id, municipio, id estado

-- TABLA DE ESTADOS 
	--id, estado
	
	CREATE TABLE IF NOT EXISTS address(
	id_address SERIAL PRIMARY KEY,
	street VARCHAR(100) NOT NULL,
	num_int VARCHAR(10) NOT NULL,
	num_ext VARCHAR(10) NOT NULL,
	id_postal_code INT NOT NULL,
	
	FOREIGN KEY (id_postal_code) REFERENCES postal_codes (id_postal_code)
);
	
-- insertar los estados de la republica
('Ciudad de México'),('Aguascalientes'), ('Baja California'), 
('Baja California Sur'), ('Campeche'), ('Chiapas'), ('Chihuahua'), 
('Coahuila'), ('Colima'), ('Durango'), ('Guanajuato'), ('Guerrero'),
('Hidalgo'), ('Jalisco'), ('México'), ('Michoacán'), ('Morelos'),
('Nayarit'), ('Nuevo León'), ('Oaxaca'), ('Puebla'), ('Querétaro'),
('Quintana Roo'), ('San Luis Potosí'), ('Sinaloa'), ('Sonora'),
('Tabasco'), ('Tamaulipas'), ('Tlaxcala'), ('Veracruz'), ('Yucatán'), ('Zacatecas');


-- insertar los municipios de la ciudad de mexico
('Álvaro Obregón', 1), 
('Azcapotzalco', 1), 
('Benito Juárez', 1), 
('Coyoacán', 1),
('Cuajimalpa de Morelos', 1), 
('Cuauhtémoc', 1), 
('Gustavo A. Madero', 1),
('Iztacalco', 1), 
('Iztapalapa', 1), 
('La Magdalena Contreras', 1), 
('Miguel Hidalgo', 1), 
('Milpa Alta', 1),
('Tláhuac', 1), 
('Tlalpan', 1), 
('Venustiano Carranza', 1), 
('Xochimilco', 1);

--insertar las localidades de la ciudad de mexico
('Santa Fe', 1), 
('San Ángel', 1),
('Clavería', 2), 
('Del Valle', 3),
('Copilco', 4), 
('Roma Norte', 6), 
('Lindavista', 7), 
('Agrícola Oriental', 8),
('Santa María Aztahuacán', 9), 
('San Jerónimo Lídice', 10), 
('Polanco', 11), 
('Villa Milpa Alta', 12),
('Zapotitla', 13), 
('La Joya', 14), 
('Jardín Balbuena', 15), 
('Santa Cruz Acalpixca', 16);

-- insertar los codigos postales
('01210', 1), 
('01000', 2),
('02080', 3), 
('03100', 4),
('04360', 5), 
('06700', 6), 
('07300', 7), 
('08500', 8),
('09510', 9), 
('10200', 10), 
('11510', 11), 
('12000', 12),
('13200', 13), 
('14000', 14), 
('15900', 15), 
('16010', 16);

CREATE TABLE IF NOT EXISTS address(
	id_address SERIAL PRIMARY KEY,
	street VARCHAR(100) NOT NULL,
	num_int VARCHAR(10) NOT NULL,
	num_ext VARCHAR(10) NOT NULL,
	id_postal_code INT NOT NULL,
	
	FOREIGN KEY (id_postal_code) REFERENCES postal_codes (id_postal_code)
);

CREATE TABLE states (
	id_state SERIAL PRIMARY KEY,
	state VARCHAR(30) NOT NULL
);

CREATE TABLE municipalities (
	id_municipality SERIAL PRIMARY KEY,
	municipality VARCHAR(100) NOT NULL,
	id_state INT NOT NULL,
	
	FOREIGN KEY (id_state) REFERENCES states (id_state)
);

CREATE TABLE localities (
	id_location SERIAL PRIMARY KEY,
	location VARCHAR(100) NOT NULL,
	id_municipality INT NOT NULL,
	
	FOREIGN KEY (id_municipality) REFERENCES municipalities (id_municipality)
);

CREATE TABLE postal_codes(
	id_postal_code SERIAL PRIMARY KEY,
	postal_code INT NOT NULL,
	id_location INT NOT NULL,
	
	FOREIGN KEY (id_location) REFERENCES localities (id_location)
);



INSERT INTO states (state) 
VALUES
	('Ciudad de México'),('Aguascalientes'), ('Baja California'), 
	('Baja California Sur'), ('Campeche'), ('Chiapas'), ('Chihuahua'), 
	('Coahuila'), ('Colima'), ('Durango'), ('Guanajuato'), ('Guerrero'),
	('Hidalgo'), ('Jalisco'), ('México'), ('Michoacán'), ('Morelos'),
	('Nayarit'), ('Nuevo León'), ('Oaxaca'), ('Puebla'), ('Querétaro'),
	('Quintana Roo'), ('San Luis Potosí'), ('Sinaloa'), ('Sonora'),
	('Tabasco'), ('Tamaulipas'), ('Tlaxcala'), ('Veracruz'), ('Yucatán'), ('Zacatecas');
	
	
	

INSERT INTO municipalities (municipality, id_state) 
VALUES
	('Álvaro Obregón', 1), 
	('Azcapotzalco', 1), 
	('Benito Juárez', 1), 
	('Coyoacán', 1),
	('Cuajimalpa de Morelos', 1), 
	('Cuauhtémoc', 1), 
	('Gustavo A. Madero', 1),
	('Iztacalco', 1), 
	('Iztapalapa', 1), 
	('La Magdalena Contreras', 1), 
	('Miguel Hidalgo', 1), 
	('Milpa Alta', 1),
	('Tláhuac', 1), 
	('Tlalpan', 1), 
	('Venustiano Carranza', 1), 
	('Xochimilco', 1);
	
INSERT INTO localities (location, id_municipality) 
VALUES
	('Santa Fe', 1), 
	('San Ángel', 1),
	('Clavería', 2), 
	('Del Valle', 3),
	('Copilco', 4), 
	('Roma Norte', 6), 
	('Lindavista', 7), 
	('Agrícola Oriental', 8),
	('Santa María Aztahuacán', 9), 
	('San Jerónimo Lídice', 10), 
	('Polanco', 11), 
	('Villa Milpa Alta', 12),
	('Zapotitla', 13), 
	('La Joya', 14), 
	('Jardín Balbuena', 15), 
	('Santa Cruz Acalpixca', 16);
	

INSERT INTO postal_codes (postal_code, id_location) 
VALUES
	('01210', 1), 
	('01000', 2),
	('02080', 3), 
	('03100', 4),
	('04360', 5), 
	('06700', 6), 
	('07300', 7), 
	('08500', 8),
	('09510', 9), 
	('10200', 10), 
	('11510', 11), 
	('12000', 12),
	('13200', 13), 
	('14000', 14), 
	('15900', 15), 
	('16010', 16);
	
	
INSERT INTO address (street, num_int, num_ext, id_postal_code) 
VALUES
	('MINAS DE PLATINO', '89C', '22', 8);
	
	
SELECT
    ad.*,
    cp.postal_code,
    loc.location,
    m.municipality,
    st.state
FROM
    address AS ad
    INNER JOIN postal_codes as cp ON cp.id_postal_code = ad.id_postal_code
    INNER JOIN localities as loc ON loc.id_location = cp.id_location
    INNER JOIN municipalities as m ON m.id_municipality = loc.id_municipality
    INNER JOIN states as st ON st.id_state = m.id_state;



