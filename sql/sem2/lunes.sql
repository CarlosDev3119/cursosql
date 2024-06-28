-- refrescar los temas de la semana pasada, filtros y funciones agregadas

SELECT book_name FROM books WHERE id_editorial = 4 OR id_editorial = 7;

SELECT * FROM books ORDER BY book_name desc;

SELECT count(*) FROM books WHERE id_editorial = 4 OR id_editorial = 7;

SELECT count(*), book_name FROM books WHERE id_editorial = 4 OR id_editorial = 7;

SELECT count(*), id_editorial, book_name FROM books WHERE id_editorial = 4 OR id_editorial = 7 GROUP BY id_editorial, book_name;

SELECT count(*), id_editorial FROM books WHERE id_editorial = 4 OR id_editorial = 7 GROUP BY id_editorial;

SELECT count(*), id_editorial FROM books WHERE id_editorial BETWEEN 1 and 2 GROUP BY id_editorial;


-- OBTENER TODOS LOS LIBROS QUE ESTEN ENTRE 1900 Y 2000, CALCULAR CUANTOS TENEMOS?

SELECT * FROM books WHERE book_year BETWEEN 1900 AND 2000;


SELECT COUNT(*) FROM books WHERE book_year BETWEEN 1900 AND 2000;


-- OBTENER TODOS LOS LIBROS QUE TENGAN MAS DE 5000000
SELECT book_name, copies_sold FROM books WHERE copies_sold > 50000;

-- MODIFICAR TODOS LOS REGISTROS DE COPIES SOLD, REDUCIR DOS CEROS A LA IZQUIERDA DEL PUNTO DECIMAL

SELECT POSITION('.' in copies_sold::TEXT),copies_sold FROM books;

SELECT SUBSTRING(copies_sold::TEXT, 0, POSITION('.' in copies_sold::TEXT) -2 ) FROM books;

SELECT REPLACE(copies_sold::TEXT, '00.', '.') from books;

SELECT CONCAT( SUBSTRING(copies_sold::TEXT, 0, POSITION('.' in copies_sold::TEXT) -2 ), '.00')as copies_sold FROM books;

BEGIN;
	update books SET copies_sold = CONCAT( SUBSTRING(copies_sold::TEXT, 0, POSITION('.' in copies_sold::TEXT) -2 ), '.00')::numeric;
	
ROLLBACK;

BEGIN;
	update books SET copies_sold = REPLACE(copies_sold::TEXT, '00.', '.')::NUMERIC;
	
ROLLBACK;


commit;


DELETE FROM books;


INSERT INTO
    books (book_name, book_year, copies_sold, id_editorial)
VALUES
	('Don Quijote de la Mancha', 1605, 5000000, 6),  
    ('Orgullo y prejuicio', 1813, 20000000, 7),  
    ('Cien años de soledad', 1967, 8000000, 1),  
    ('El código Da Vinci', 2003, 80000000, 2),  
    ('La sombra del viento', 2001, 15000000, 3), 
    ('El hobbit', 1937, 100000000, 4),  
    ('El principito', 1943, 140000000, 5),  
    ('La historia del tiempo', 1988, 5000000, 8),  
    ('Pedro Páramo', 1955, 2000000, 9),  
    ('La Odisea', -800, 5000000, 6),  
    ('Romeo y Julieta', 1597, 20000000, 7),  
    ('La Divina Comedia', 1320, 8000000, 1),  
    ('Hamlet', 1609, 80000000, 2),  
    ('Matar a un ruiseñor', 1960, 15000000, 3),  
    ('Los Miserables', 1862, 100000000, 4), 
    ('Ulises', 1922, 140000000, 5), 
    ('La metamorfosis', 1915, 5000000, 8),  
    ('1984', 1949, 2000000, 9),  
    ('Los juegos del hambre', 2008, 5000000, 10);


-- HAVING
SELECT * FROM books;

SELECT COUNT(*), book_name FROM books where copies_sold = 5000000 GROUP BY book_name;

--buscar todos los libros que sean entre 2000 y 2001
SELECT COUNT(*), book_year FROM books where book_year BETWEEN 1900 AND 2003 GROUP BY book_year;

UPDATE books SET  book_year = 2001 where id_editorial = 2 or id_editorial = 1;

UPDATE books SET  book_year = 2002 where id_editorial = 4 or id_editorial = 6;


--obtener la cantidad de libros por cada anio
SELECT COUNT(*), book_year FROM books GROUP BY book_year;

-- ordenar los datos de forma descendente de la consulta anterior
SELECT COUNT(*), book_year FROM books GROUP BY book_year ORDER BY count(*) DESC;

--obtener la cantidad de libros por cada anio, que tengan mas de un libro por anio

SELECT COUNT(*), book_year FROM books GROUP BY book_year HAVING count(*) > 1 ORDER BY count(*) DESC;
































