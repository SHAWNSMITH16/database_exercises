USE albums_db;

DESCRIBE albums;

SELECT * FROM albums;

SELECT COUNT(DISTINCT artist) FROM albums;

SELECT MAX(release_date) FROM albums;


 /*Create a new file called select_exercises.sql. Store your code for this exercise in that file. You should be testing your code in MySQL Workbench as you go.

Use the albums_db database.

Explore the structure of the albums table.

a. How many rows are in the albums table?
31

b. How many unique artist names are in the albums table?
23

c. What is the primary key for the albums table?
int unsigned

d. What is the oldest release date for any album in the albums table? What is the most recent release date?
1967,  2011*/


/*Write queries to find the following information:

a. The name of all albums by Pink Floyd*/

SELECT name FROM albums
WHERE artist = "Pink Floyd";

/*
b. The year Sgt. Pepper's Lonely Hearts Club Band was released*/

SELECT release_date FROM albums
WHERE name = "Sgt. Pepper's Lonely Hearts Club Band";

/*
c. The genre for the album Nevermind*/

SELECT genre FROM albums
WHERE name = 'Nevermind';

/*
d. Which albums were released in the 1990s*/

SELECT name FROM albums
WHERE release_date < 2000 and release_date > 1989;

/*
e. Which albums had less than 20 million certified sales*/

SELECT name FROM albums
WHERE sales < 20;

/*
f. All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"?
To get anything that has "Rock" in the genre, you'd use the LIKE operator*/

SELECT name, genre FROM albums
WHERE genre = "Rock";

/*
Be sure to add, commit, and push your work.*/