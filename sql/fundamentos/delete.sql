BEGIN;
	DELETE FROM users;
ROLLBACK;

DELETE FROM users where name_user LIKE 'alb%';

-- borra la tabla
DROP TABLE users; 

-- borra el contenido de la tabla
TRUNCATE table users;