-- SCC130 Database Coursework

-- Q1.	Which artists have a start year in or after 1995, and are still active (i.e., the end year is unknown)?

SELECT
   name 
FROM
   artists 
WHERE
   start_year >= 1995 
   AND end_year IS NULL;


-------------------------------------------------------------------------------------------------------------------
-- Q2.	Find all artists that are called "R…" (e.g. "Rahsaan Roland Kirk"), who are not from the United Kingdom. 
-- List your results along with the country of origin, start year and sorted by the year started, earliest first.

SELECT
   name AS 'Artists',
   origin AS 'Country of Origin',
   start_year AS 'Start Year' 
FROM
   artists 
WHERE
   name LIKE 'R%' 
   AND origin != 'United Kingdom' 
ORDER BY
   start_year DESC;


-------------------------------------------------------------------------------------------------------------------
-- Q3.	From the tracks that have a position less or equal to 3, What is the minimum and 
-- maximum length of these tracks which have a length listed (i.e., not NULL)? 

SELECT
   MIN(length) AS 'Minimum Length',
   MAX(length) AS 'Maximum Length'
FROM
   tracks 
WHERE
   position <= 3;


-------------------------------------------------------------------------------------------------------------------
-- Q4.	Which years had the most albums released, list the top-3 years. 
-- Include the number of albums released in that year in your result.

SELECT
   release_year AS 'Release Year',
   COUNT(release_year) AS 'Number of Albums' 
FROM
   albums 
GROUP BY
   release_year 
ORDER BY
   COUNT(release_year) DESC LIMIT 3;


-------------------------------------------------------------------------------------------------------------------
-- Q5.	Produce a track listing (ordered from the shortest one to the longest one based on the length) 
-- for the album named "Blue Lines". Include the position, name, and length.

SELECT
   position AS 'Position',
   name AS 'Tracks from Blue Lines Album',
   length AS 'Length' 
FROM
   tracks 
WHERE
   album_id IN
   (
      SELECT
         id 
      FROM
         albums 
      WHERE
         name = 'Blue Lines'
   )
ORDER BY
   length ASC;


-------------------------------------------------------------------------------------------------------------------
-- Q6.	There are 6 artists (in our database) who have released tracks having the words "Love Song" as part of the title. 
-- List all 6 artists in alphabetical order. Note: track including the words "Love Songs" 
-- should be excluded from the results. 

SELECT DISTINCT
   artists.name AS 'Artists' 
FROM
   artists 
   INNER JOIN
      albums 
      ON artists.id = albums.artist_id 
   INNER JOIN
      tracks 
      ON tracks.album_id = albums.id 
WHERE
   tracks.name LIKE '%Love Song%' 
   AND tracks.name NOT LIKE '%Love Songs%' 
ORDER BY
   artists.name ASC;
   
   
-------------------------------------------------------------------------------------------------------------------
-- Q7.	Which artists do not have an album listed in the database? Please list the name of those artists, 
-- their start years based on the ascending order of the start year.

SELECT
   artists.name AS 'Artists',
   start_year AS 'Start Year' 
FROM
   artists 
   LEFT JOIN
      albums 
      ON artists.id = albums.artist_id 
WHERE
   albums.name IS NULL 
ORDER BY
   start_year ASC;

   
-------------------------------------------------------------------------------------------------------------------
-- Q8.	The band "Black Box Recorder" will be touring again this year after previously retiring in 2010. 
-- Change the end year for Black Box Recorder to be undefined (i.e. the band are still active). 
-- Run a SELECT statement to show the change.

UPDATE
   artists 
SET
   end_year = NULL 
WHERE
   name = 'Black Box Recorder'; 


-------------------------------------------------------------------------------------------------------------------
-- Q9.	Create a new table, "playlist", in your database that represents tracks listed next to a person's name (i.e. who owns the playlist). The table should contain columns for the following: 
-- - a numerical ID, which is the primary key; 
-- - the name of the playlist owner (up to 25 characters); 
-- - the track id, which you should set as a foreign key referencing the id column in tracks (the parent key); 
-- - and a date added. 
-- You must ensure that the name of the person and the track id are present for every row, but the date added may be missing.



