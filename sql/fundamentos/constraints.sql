
CREATE TABLE IF NOT EXISTS postal_codes (
    id_postal_code SERIAL PRIMARY KEY,
    postal_code VARCHAR(10) not null
);

CREATE TABLE IF NOT EXISTS users (

    id_user serial PRIMARY KEY,
    name_user VARCHAR(100) UNIQUE NOT NULL,
    email_user VARCHAR(100) UNIQUE NOT NULL,
    status_user CHAR(1) DEFAULT '1',
    id_postal_code INT NOT NULL,
    FOREIGN KEY (id_postal_code) REFERENCES postal_codes(id_postal_code)
);

INSERT INTO postal_codes (postal_code) VALUES('56590');

INSERT INTO users (name_user, email_user, id_postal_code)
	VALUES('alberto', 'alberto@smart-force.com', 1);

-- DML, DDL, DCL Y TCL


--DML = DATA MANIPULATION LANGUAGE (SELECT, UPDATE, INSERT, TRUNCATE)

--DDL = DATA DEFINITION LANGUAGE (CREATE, ALTER, DROP)

--DCL = DATA CONTROL LANGUAGE (GRANT, REVOKE) 

--TCL = TRANSACTION CONTROL LANGUAGE (TRANSACTION, ROLLBACK, BEGIN, COMMIT)

