-- INDICES

-- tambien se consideran constraints
-- los indices sirven para buscar informacion en la base de datos 
-- para una busqueda mas rapida en lugar de buscar en todo tendra un indice
-- donde comenzar para buscar ese registro
-- son sumamente importantes para la velocidad de busqueda en la base de datos
-- si el indice se crea despues de crear la bd y existen miles de registros va a tardar un rato


--INSERTAR EN LA TABLA DE ADDRESS UNA COLUMAN NUEVA CON EL ID DEL USUARIO

--AGREGAMOS EN DIRECCION LA COLUMNA PARA EL ID DEL USUARIO 
ALTER TABLE address ADD COLUMN id_user INT;

--ACTUALIZAR EL CAMPO DEL USUARIO
UPDATE address SET id_user = 1 where id_address =1;

--AGREGAMOS CONSTRAINT NOT NULL
ALTER TABLE address alter column id_user SET NOT NULL;

--CREAR RELACION CON USUARIOS
ALTER TABLE address ADD FOREIGN KEY (id_user) REFERENCES users(id);


--eliminar columna direccion de usuarios
ALTER TABLE users DROP COLUMN address;

-- consultar tabla de DIRECCIONES Y MOSTRAR TODA LA DIRECCION COMPLETA 
SELECT
    users.name,
    users.phone_number,
    users.email,
    CONCAT(
	    address.street, ' ',
	    address.num_ext, ' ',
	    address.num_int, ' ',
	    cp.postal_code, ' ',
	    mun.municipality, ' ',
	    st."state"
    ) AS address
    
FROM
    address
    INNER JOIN users ON users.id = address.id_user
    INNER JOIN postal_codes AS cp ON cp.id_postal_code = address.id_postal_code
    INNER JOIN localities as loc ON loc.id_location = cp.id_location
    INNER JOIN municipalities as mun ON mun.id_municipality = loc.id_municipality
    INNER JOIN states as st ON st.id_state = mun.id_state;
    
   
   
-- crear indice unico

CREATE UNIQUE INDEX "unique_email" ON users (
	email
);

--CREAR INDICE NORMAL
CREATE INDEX "name_index" ON users( name );

SELECT * FROM users where name = 'Vera Black';

-- Crear un check para numeros de telefono que no acepte mas de 7 caracteres
ALTER TABLE users ADD CHECK(
	LENGTH(phone_number::text) <=7
);

--CREAR NUEVA TABLA DE productos
	--id, producto, estado de producto
	
CREATE TABLE IF NOT EXISTS products (
	id_product SERIAL PRIMARY KEY,
	product VARCHAR(100) NOT NULL,
	status_product BOOLEAN DEFAULT true
);

-- CREAR NUEVA TABLA DE ORDENES
CREATE TABLE IF NOT EXISTS orders (
	id_order SERIAL PRIMARY KEY,
	order_date timestamp
);

--CREAR NUEVA TABLA DE PRODUCTOS Y ORDENES
CREATE TABLE product_orders (
	id_product INT NOT NULL,
	id_order INT NOT NULL,
	id_user INT NOT NULL,
	quantity INT NOT NULL,
	
	PRIMARY KEY(id_product, id_order),
	FOREIGN KEY (id_product) REFERENCES products(id_product),
	FOREIGN KEY (id_order) REFERENCES orders(id_order),
	FOREIGN KEY (id_user) REFERENCES users(id)
);

--INSERTAR UN REGISTRO EN PRODUCTOS
INSERT INTO products (product) VALUES ('chamarra');

--CUANDO SE REALICE UNA ORDEN SE CREA LA ORDEN Y TAMBIEN SE CREA EL REGISTRO EN PRODUCTOS Y ORDENES
INSERT INTO orders (order_date) VALUES (CURRENT_TIMESTAMP);

--OBTENEMOS EL ULTIMO REGISTRO CREADO
SELECT LASTVAL();

--INSERTAMOS EN LA TABLA DE PRODUCOTS Y ORDENES
INSERT INTO product_orders (id_product, id_order, id_user, quantity) VALUES (1, LASTVAL(), 1, 10);

-- CONSULTAR ORDENES REALIZADAS
SELECT * FROM orders;

--mostrar los pedidos de los usuarios

SELECT
    p.product,
    o.order_date,
    po.quantity,
    u."name"
FROM
    product_orders as po
    INNER JOIN products as p ON p.id_product = po.id_product
    INNER JOIN orders AS o ON o.id_order = po.id_order
    INNER JOIN users AS u ON u.id = po.id_user WHERE id_user = 1;
    
    
BEGIN;
	DELETE FROM postal_codes where postal_code = '8500';
commit;
ROLLBACK;


SELECT orders.order_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/Mexico_City' AS fecha_cst
FROM orders;
