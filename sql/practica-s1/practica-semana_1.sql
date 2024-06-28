-- Generar diagrama entidad-relacion de los siguientes datos:
-- Genera el modelo relacional de los siguientes datos
-- Genera una BD para una biblioteca la cual contendra 3 tablas: libros, editorial, autor tomando en cuenta los siguientes campos
libros: id_libro, nombre_libro, anio_publicacion, copias_vendidas, id_editorial

editorial: id_editorial, nombre_editorial

autor: id_autor, nombre_autor

-- Se tiene que tomar en cuenta la relacion entre autor y libros ya que un autor puede escribir mas de un libro y un libro puede tener mas de un autor

-- Ingresar los siguientes editoriales
    ('Penguin Random House'),
    ('HarperCollins Publishers'),
    ('Simon & Schuster'),
    ('Macmillan Publishers'),
    ('Hachette Book Group'),
    ('Wiley'),
    ('Oxford University Press'),
    ('Cambridge University Press'),
    ('Springer Nature'),
    ('Elsevier');

-- inserta los siguientes libros


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

--insertar 20 autores

-- mostrar todos los registros

-- mostrar los libros que sean del 2000 en adelante

-- mostrar los libros que sean menores al 2000




CREATE TABLE IF NOT EXISTS editorial(
	id_editorial SERIAL PRIMARY KEY,
	editorial_name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS author(
	id_author SERIAL PRIMARY KEY,
	author_name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS books(
	id_book SERIAL PRIMARY KEY,
	book_name VARCHAR(100) NOT NULL,
	book_year INT NOT NULL,
	copies_sold NUMERIC(15,2) NOT NULL,
	id_editorial INT NOT NULL,	
	FOREIGN KEY (id_editorial) REFERENCES editorial(id_editorial)
);

CREATE TABLE IF NOT EXISTS author_books(
	id_book INT NOT NULL,
	id_author INT NOT NULL,
	
	FOREIGN KEY (id_book) REFERENCES books(id_book),
	FOREIGN KEY (id_author) REFERENCES author(id_author)
);


INSERT INTO
    editorial (editorial_name)
VALUES
	('Penguin Random House'),
    ('HarperCollins Publishers'),
    ('Simon & Schuster'),
    ('Macmillan Publishers'),
    ('Hachette Book Group'),
    ('Wiley'),
    ('Oxford University Press'),
    ('Cambridge University Press'),
    ('Springer Nature'),
    ('Elsevier');
    
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
    
    
INSERT INTO author (author_name) VALUES
    ('Gabriel García Márquez'),
    ('J.K. Rowling'),
    ('George Orwell'),
    ('J.R.R. Tolkien'),
    ('Yuval Noah Harari'),
    ('Miguel de Cervantes'),
    ('Jane Austen'),
    ('Dan Brown'),
    ('Carlos Ruiz Zafón'),
    ('Antoine de Saint-Exupéry'),
    ('Stephen Hawking'),
    ('Juan Rulfo'),
    ('Leo Tolstoy'),
    ('Homer'),
    ('William Shakespeare'),
    ('Dante Alighieri'),
    ('Harper Lee'),
    ('Victor Hugo'),
    ('James Joyce'),
    ('Franz Kafka');
    

SELECT * FROM books;
SELECT * FROM author;
SELECT * FROM editorial;
SELECT * FROM author_books;

SELECT * FROM books WHERE book_year >= 2000;

SELECT * FROM books WHERE book_year < 2000;

SELECT * FROM books WHERE book_year > 1800 and book_year < 2000;

SELECT * FROM books WHERE book_year BETWEEN 1800 and 2000;

SELECT ROUND( SUM(copies_sold) / COUNT(*) ) AS average, COUNT(*) FROM books;

SELECT ROUND(AVG(copies_sold)) FROM books;











