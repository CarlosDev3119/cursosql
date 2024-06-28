CREATE TABLE IF NOT EXISTS videogames(
	id SERIAL PRIMARY KEY,
	name VARCHAR(200) not null,
	developer VARCHAR(100) not null
);

INSERT INTO videogames (name, developer) VALUES
('The Legend of Zelda: Breath of the Wild', 'Nintendo'),
('The Witcher 3: Wild Hunt', 'CD Projekt Red'),
('Red Dead Redemption 2', 'Rockstar Games'),
('God of War', 'Santa Monica Studio'),
('Cyberpunk 2077', 'CD Projekt Red'),
('Minecraft', 'Mojang'),
('Grand Theft Auto V', 'Rockstar Games'),
('Super Mario Odyssey', 'Nintendo'),
('Horizon Zero Dawn', 'Guerrilla Games'),
('Dark Souls III', 'FromSoftware'),
('The Legend of Zelda: Breath of the Wild', 'Nintendo'),
('The Witcher 3: Wild Hunt', 'CD Projekt Red'),
('Red Dead Redemption 2', 'Rockstar Games'),
('God of War', 'Santa Monica Studio'),
('Cyberpunk 2077', 'CD Projekt Red'),
('Minecraft', 'Mojang'),
('Grand Theft Auto V', 'Rockstar Games'),
('Super Mario Odyssey', 'Nintendo'),
('Horizon Zero Dawn', 'Guerrilla Games'),
('Dark Souls III', 'FromSoftware'),
('The Legend of Zelda: Breath of the Wild', 'Nintendo'),
('The Witcher 3: Wild Hunt', 'CD Projekt Red'),
('Red Dead Redemption 2', 'Rockstar Games'),
('God of War', 'Santa Monica Studio'),
('Cyberpunk 2077', 'CD Projekt Red'),
('Minecraft', 'Mojang'),
('Grand Theft Auto V', 'Rockstar Games'),
('Super Mario Odyssey', 'Nintendo'),
('Horizon Zero Dawn', 'Guerrilla Games'),
('Dark Souls III', 'FromSoftware'),
('The Legend of Zelda: Breath of the Wild', 'Nintendo'),
('The Witcher 3: Wild Hunt', 'CD Projekt Red'),
('Red Dead Redemption 2', 'Rockstar Games'),
('God of War', 'Santa Monica Studio'),
('Cyberpunk 2077', 'CD Projekt Red'),
('Minecraft', 'Mojang'),
('Grand Theft Auto V', 'Rockstar Games'),
('Super Mario Odyssey', 'Nintendo'),
('Horizon Zero Dawn', 'Guerrilla Games'),
('Dark Souls III', 'FromSoftware');

-- extraer todos los juegos desarollados por FromSoftware
SELECT * FROM videogames WHERE developer = 'FromSoftware';

-- Mostrar los juegos desarrollados por Santa monica Studio o CD Projekt Red
SELECT name FROM videogames WHERE developer = 'Santa Monica Studio' OR developer = 'CD Projekt Red';


-- Mostrar todos los juegos que empiecen con la letra G
SELECT name FROM videogames WHERE name LIKE 'G%';


-- mostrar todos los datos que tengan mas de una palabra en el nombre
SELECT name FROM videogames WHERE name LIKE '% %';


-- cambiar todos los registros que sean de la desarrolladora que tenga la palabra games en el nombre por SFORCE, ejemplo:
    -- Rockstar Games = SFORCE
BEGIN;	
	UPDATE videogames SET developer = 'SFORCE' WHERE developer LIKE '% Games';

-- Eliminar los juegos que la desarrolladora es igual a: "nintendo"
BEGIN;
	DELETE FROM videogames WHERE developer = 'nintendo'
	
-- eliminar el ultimo registro
	
BEGIN;
	DELETE FROM videogames WHERE id = (SELECT MAX(id) FROM videogames);