create table users(
	name varchar(20),
	age int
);


create table if not exists users(
	name varchar(20),
	age int
);


DO $$
BEGIN
	BEGIN
		CREATE TABLE employes(
			name_employe VARCHAR(100)
		);
	EXCEPTION
		WHEN duplicate_table THEN 
		
	END;

END $$;


INSERT INTO users VALUES('JOSE', 27);

INSERT INTO users VALUES('JOSE', 27.3);

INSERT INTO users (age) VALUES(20);
INSERT INTO users (age, name) VALUES(20, 'Cesar');
INSERT INTO users (age, name) VALUES(20, '');

BEGIN;
	INSERT INTO users(name, age) VALUES('Diego', 24),
									   ('Yolanda', 24),
									   ('Jovani', 30);
									   
COMMIT;

ROLLBACK;



