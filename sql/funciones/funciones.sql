
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
('The Last of Us Part II', 'Naughty Dog'),
('Assassins Creed Valhalla', 'Ubisoft'),
('Ghost of Tsushima', 'Sucker Punch Productions'),
('Resident Evil Village', 'Capcom'),
('Elden Ring', 'FromSoftware'),
('Fortnite', 'Epic Games'),
('Among Us', 'InnerSloth'),
('Doom Eternal', 'id Software'),
('Animal Crossing: New Horizons', 'Nintendo'),
('FIFA 21', 'EA Sports'),
('Call of Duty: Modern Warfare', 'Infinity Ward'),
('Apex Legends', 'Respawn Entertainment'),
('League of Legends', 'Riot Games'),
('Overwatch', 'Blizzard Entertainment'),
('Valorant', 'Riot Games'),
('Genshin Impact', 'miHoYo'),
('Destiny 2', 'Bungie'),
('Half-Life: Alyx', 'Valve'),
('Control', 'Remedy Entertainment'),
('Sekiro: Shadows Die Twice', 'FromSoftware'),
('Death Stranding', 'Kojima Productions'),
('Hades', 'Supergiant Games'),
('Cyberpunk 2077', 'CD Projekt Red'),
('Final Fantasy VII Remake', 'Square Enix'),
('Borderlands 3', 'Gearbox Software'),
('Star Wars Jedi: Fallen Order', 'Respawn Entertainment'),
('Persona 5 Royal', 'Atlus'),
('Monster Hunter: World', 'Capcom'),
('The Outer Worlds', 'Obsidian Entertainment');

name =' Legend of Zelda: Breath of the Wild'


SELECT * FROM videogames;

SELECT UPPER(name) FROM videogames;

SELECT LOWER(name) FROM videogames;

SELECT CONCAT(name, ' y ', UPPER(developer) ) FROM videogames;

SELECT CONCAT(name, ' y ', UPPER(developer) ) AS name_developer FROM videogames;


SELECT
    (name || ' Y ' || UPPER(developer)) as name_developer
FROM
    videogames;
    

SELECT
	SUBSTRING(name, 0, POSITION(' ' in name) ) AS first_word,
-- 	SUBSTRING(name, POSITION(' ' in name) + 1 ) as second_word,
	SUBSTRING( SUBSTRING(name, POSITION(' ' in name) + 1 ), 0, POSITION(' ' IN SUBSTRING(name, POSITION(' ' in name) + 1 ) )  ),
	SUBSTRING(SUBSTRING(name, POSITION(' ' in name) + 1 ), POSITION(' ' in SUBSTRING(name, POSITION(' ' in name) + 1 )) + 1 ) as third_word,
	name
FROM videogames WHERE name LIKE '% % %';
    
    
SELECT * FROM videogames;

ALTER SEQUENCE videogames_id_seq RESTART WITH 1;

ALTER TABLE
    videogames
ADD
    COLUMN first_word VARCHAR(100),
ADD
    COLUMN second_word VARCHAR(100),
ADD
    COLUMN rest_word VARCHAR(100);
   
BEGIN;
UPDATE videogames SET first_word = SUBSTRING(name, 0, POSITION(' ' in name) ) WHERE name LIKE '% % %';

BEGIN;
UPDATE videogames SET second_word = SUBSTRING( SUBSTRING(name, POSITION(' ' in name) + 1 ), 0, POSITION(' ' IN SUBSTRING(name, POSITION(' ' in name) + 1 ) )  ) WHERE name LIKE '% % %';

commit;

BEGIN;
	UPDATE videogames SET rest_word = SUBSTRING(SUBSTRING(name, POSITION(' ' in name) + 1 ), POSITION(' ' in SUBSTRING(name, POSITION(' ' in name) + 1 )) + 1 ) WHERE name LIKE '% % %';

ROLLBACK;


