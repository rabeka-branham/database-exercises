SHOW databases;
USE albums_db;
SELECT database();
-- Use the albums_db database.

SHOW tables;
DESCRIBE albums;
-- What is the primary key for the albums table?
-- ANSWER: id

SELECT name 
FROM albums;
-- What does the column named 'name' represent?
-- ANSWER: the title of the album.

SELECT sales 
FROM albums;
-- What do you think the sales column represents?
-- ANSWER: # of album sales in millions

SELECT name 
FROM albums 
WHERE artist = 'Pink Floyd';
-- Find the name of all albums by Pink Floyd.
-- ANSWER: The Dark Side of the Moon & The Wall

SELECT release_date 
FROM albums 
WHERE name = 'Sgt. Pepper\'s Lonely Hearts Club Band';
-- What is the year Sgt. Pepper's Lonely Hearts Club Band was released?
-- ANSWER: 1967

SELECT genre 
FROM albums 
WHERE name = 'Nevermind';
-- What is the genre for the album Nevermind?
-- ANSWER: Grunge, Alternative rock

SELECT name 
FROM albums 
WHERE release_date >= 1990 
	AND release_date <= 1999;
-- Which albums were released in the 1990s?
/* ANSWER: 
The Bodyguard
Jagged Little Pill
Come On Over
Falling into You
Let's Talk About Love
Dangerous
The Immaculate Collection
Titanic: Music from the Motion Picture
Metallica
Nevermind
Supernatural*/

SELECT name as low_selling_albums 
FROM albums 
WHERE sales < 20;
-- Which albums had less than 20 million certified sales? Rename this column as low_selling_albums.
/* ANSWER:
Grease: The Original Soundtrack from the Motion Picture
Bad
Sgt. Pepper's Lonely Hearts Club Band
Dirty Dancing
Let's Talk About Love
Dangerous
The Immaculate Collection
Abbey Road
Born in the U.S.A.
Brothers in Arms
Titanic: Music from the Motion Picture
Nevermind
The Wall*/