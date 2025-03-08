/*=======================
LAB 1
=========================*/

--- \c lab1
/*Find the name of the artist who has created the Artwork titled ‘Rainbow’. 
 */
SELECT
  a.artist_name as "Artist name",
  ar.work_title as "Title"
From
  artist a
  join creates c on c.artist_id = a.artist_id
  join artwork ar on c.artwork_id = ar.artwork_id
where
  work_title = 'Rainbow';


/*Artist name |  Title
 -------------+---------
 Ringo       | Rainbow
 (1 row)*/
/*Find the titles of the Artworks created by ‘Lolo’.*/
SELECT
  a.artist_name as "Artist name",
  ar.work_title as "Title"
From
  artist a
  join creates c on c.artist_id = a.artist_id
  join artwork ar on c.artwork_id = ar.artwork_id
where
  a.artist_name = 'Lolo';


/*Artist name |       Title
 -------------+--------------------
 Lolo        | Colours of the Sky
 Lolo        | Long road to home
 (2 rows)*/
/*Find the names of customers who have not bought an artwork priced more than £ 200. 
 List the customer name, artwork title and the price. Add the £ sign to the output and 
 order on price from lowest to highest.*/
SELECT
  c.cust_name as "Customer name",
  art.work_title as "Title",
  CONCAT_WS (' ', '£', art.price) as "Price"
FROM
  customer c
  join purchase p on p.cust_id = c.cust_id
  join artwork art on p.artwork_id = art.artwork_id
WHERE
  art.price <= '200'
Order by
  art.price ASC;


/*Customer name |       Title       |  Price
 ---------------+-------------------+----------
 Mary          | The war           | £ 1.00
 Michael       | Reflection        | £ 40.00
 Mary          | Reflection        | £ 40.00
 John          | Reflection        | £ 40.00
 Sally         | The moon          | £ 145.00
 Margaret      | Night street      | £ 150.00
 Michael       | Long road to home | £ 150.00
 Paul          | Long road to home | £ 150.00
 Sally         | Long road to home | £ 150.00
 Paul          | Night street      | £ 150.00
 Harry         | My lovely song    | £ 200.00
 (11 rows)*/

/*=======================
LAB 2
=========================*/

--- Create database
--CREATE DATABASE animal;
-- \c animal
--create ANIMAL_TYPE table 
CREATE TABLE
  animal_type(
    animal_type_id SERIAL PRIMARY KEY,
    common_name VARCHAR(50) NOT NULL UNIQUE,
    scientific_name VARCHAR(150) NOT NULL,
    conservation_status VARCHAR(50) NOT NULL
  );


--CREATE TABLE  menagerie
CREATE TABLE
  menagerie(
    menagerie_id SERIAL PRIMARY KEY,
    common_name VARCHAR(50) NOT NULL,
    date_aquired DATE NOT NULL,
    gender CHAR(1) NOT NULL,
    aquired_from VARCHAR(250) NOT NULL,
    name VARCHAR(50) NOT NULL,
    notes TEXT,
    FOREIGN KEY (common_name) REFERENCES animal_type(common_name)
  );


--create insert animal_type
INSERT INTO
  animal_type(common_name, scientific_name, conservation_status)
VALUES
  (
    'Bengal Tiger',
    'Panthera tigris tigris',
    'Endangered'
  ),
  (
    'Arctic Wolf',
    'Canis lupus arctos',
    'Least Concern'
  );


--CREATE INSERT TABLE menagerie
INSERT INTO
  menagerie(
    common_name,
    date_aquired,
    gender,
    aquired_from,
    name,
    notes
  )
VALUES
  (
    'Bengal Tiger',
    '2011-07-14',
    'F',
    'Dhaka Zoo',
    'Ariel',
    'Healthy coat at last exam'
  ),
  (
    'Arctic Wolf',
    '2008-09-30',
    'F',
    'National Zoo',
    'Freddy',
    'Strong appetite'
  ),
  (
    'Bengal Tiger',
    '2006-06-01',
    'M',
    'Scotland Zoo',
    'Spark',
    'Likes to play'
  ),
  (
    'Arctic Wolf',
    '2007-06-12',
    'F',
    'Southampton National Park',
    'Mia',
    'Doesn`t like sun'
  );


/* list all the animals that are endangered, along with common name, scientific name, 
 animal name and date acquired.  
 */
--type mistake in word -acquired in the database is aquired!!
SELECT
  at.common_name as "Common Name",
  at.scientific_name as "Scientific name",
  m.name as "Animal name",
  m.date_aquired as "Data of aquired"
From
  animal_type at
  JOIN menagerie m on at.common_name = m.common_name
WHERE
  conservation_status = 'Endangered';


/*Common Name  |    Scientific name     | Animal name | Data of aquired 
 --------------+------------------------+-------------+-----------------
 Bengal Tiger | Panthera tigris tigris | Ariel       | 2011-07-14
 Bengal Tiger | Panthera tigris tigris | Spark       | 2006-06-01
 (2 rows)*/



/*=======================
LAB 3
=========================*/
--Create table Language
CREATE TABLE
  language (
    lang_id SERIAL PRIMARY KEY,
    lang_name VARCHAR(20) NOT NULL
  );


--CREATE TABLE ACTOR 
CREATE TABLE
  actor(
    actor_id SERIAL PRIMARY KEY,
    actor_first_name VARCHAR(30) NOT NULL,
    actor_middle_name VARCHAR (30),
    actor_last_name VARCHAR(30) NOT NULL
  );


--CREATE TABLE category
CREATE TABLE
  category(
    cat_id SERIAL PRIMARY KEY,
    cat_name VARCHAR(30) NOT NULL
  );


--CREATE TABLE FILM
CREATE TABLE
  film(
    film_id SERIAL PRIMARY KEY,
    lang_id INT NOT NULL,
    original_lang_id INT NOT NULL,
    film_name VARCHAR(50) NOT NULL,
    FOREIGN KEY (lang_id) REFERENCES language(lang_id),
    FOREIGN KEY(original_lang_id) REFERENCES language(lang_id)
  );


--create table film actor
CREATE TABLE
  film_actor (
    film_id INT NOT NULL,
    actor_id INT NOT NULL,
    PRIMARY KEY (film_id, actor_id),
    -- Composite Primary Key
    FOREIGN KEY (film_id) REFERENCES film(film_id),
    FOREIGN KEY (actor_id) REFERENCES actor(actor_id)
  );


--CREATE TABLE  FILM CATEGORY
CREATE TABLE
  film_category (
    film_id INT NOT NULL,
    cat_id INT NOT NULL,
    PRIMARY KEY(film_id, cat_id),
    FOREIGN KEY (film_id) REFERENCES film(film_id),
    FOREIGN KEY(cat_id) REFERENCES category(cat_id)
  );


----inserts
--INSERT INTO LANGUAGE
INSERT INTO
  language (lang_name)
VALUES
  ('English'),
  ('Spanish'),
  ('German'),
  ('Italy');


--INSERT INTO ACTOR
INSERT INTO
  actor(
    actor_first_name,
    actor_middle_name,
    actor_last_name
  )
VALUES
  ('Robert ', NULL, 'De Niro'),
  ('Marlon', NULL, 'Brando'),
  ('Denzel', 'Hayes', 'Washington'),
  ('Humphrey', 'DeForest', 'Bogart'),
  ('Meryl', NULL, 'Streep'),
  ('Danie', 'Michael', 'Blake Day-Lewis');


--insert into category
INSERT INTO
  category (cat_name)
VALUES
  ('Action'),
  ('Horror'),
  ('Crime'),
  ('Adventure');


--insert into Film 
INSERT INTO
  film (lang_id, original_lang_id, film_name)
VALUES
  (1, 3, 'Movie 1'),
  (1, 2, 'Movie 2'),
  (2, 3, 'Movie 3'),
  (4, 1, 'Movie 4'),
  (4, 3, 'Movie 5');


--insert into Film_category
INSERT INTO
  film_category(film_id, cat_id)
VALUES
  (1, 3),
  (2, 4),
  (3, 1),
  (4, 2),
  (5, 3);


---INSERT INTO FILM_ACTOR
INSERT INTO
  film_actor(film_id, actor_id)
VALUES
  (1, 6),
  (1, 5),
  (2, 4),
  (2, 1),
  (3, 2),
  (3, 4),
  (4, 2),
  (4, 3),
  (5, 6),
  (5, 5);


---CREATE DATABASE Movie;




--list all movei that actor with id -5 Participate.
Select
  CONCAT_WS (
    ' ',
    a.actor_first_name,
    a.actor_middle_name,
    a.actor_last_name
  ) as "Actor name",
  f.film_name as "Movie"
from
  actor a
  join film_actor fa on fa.actor_id = a.actor_id
  join film f on f.film_id = fa.film_id
WHERE
  a.actor_id = 5;


---in this query Transaction analize matrix will only read date 
--from table actor, film_actor and film to show us the actor with id5 in which movie participte.





--- insert a new actor 
--- if we need to insert a new actor , first need to read the database 
---
INSERT INTO
  actor(
    actor_id,
    actor_first_name,
    actor_middle_name,
    actor_last_name
  )
VALUES(1,'Reneta','Stoyanova','Todorova');

--- in this case I  put id-1(This id arleady exist) after readig the database 
--return me this :
/*VALUES(1,'Reneta','Stoyanova','Todorova');
ERROR:  duplicate key value violates unique constraint "actor_pkey"
DETAIL:  Key (actor_id)=(1) already exists. and insert doesn happend*/
/*Before insert the database read and check for constrain or if the forenkey exist ect... */

INSERT INTO
  actor(
    actor_first_name,
    actor_middle_name,
    actor_last_name
  )
VALUES('Reneta','Stoyanova','Todorova');


select
CONCAT_WS (
    ' ',
    a.actor_first_name,
    a.actor_middle_name,
    a.actor_last_name
  ) as "Actor name"
  from actor a 
  where a.actor_id=9;

/*Actor name
---------------------------
 Reneta Stoyanova Todorova
(1 row)*/



--delete movie



--actors in movie



/*=======================
LAB 5
=========================*/

--QUESTION 1
SELECT
    m.movie_id AS "Movie ID",
    m.movie_title AS "Movie_Title",
    m.movie_lang AS "LANGUAGE",
    c.cat_name AS "Category"
FROM
    movie m
    INNER JOIN category c ON m.movie_id = c.movie_id
WHERE
    movie_title = 'ALADDIN CALENDAR';

-- QUESTION 2
EXPLAIN ANALYZE
select
    a.actor_id
from
    actor a
where
    actor_id = 2;

EXPLAIN ANALYZE
select
    *
from
    actor a
where
    actor_id = 2;

;

---CREATE DATABASE movie_rental;


-- QUESTION 3 Using DB specific commands, How many VIEWS are inside of the movie_rental database? 
\ dv
/* Schema |            Name             | Type |   Owner   
 --------+-----------------------------+------+-----------
 public | actor_info                  | view | up2246775
 public | customer_list               | view | up2246775
 public | movie_list                  | view | up2246775
 public | nicer_but_slower_movie_list | view | up2246775
 public | sales_by_movie_category     | view | up2246775
 public | sales_by_store              | view | up2246775
 public | staff_list                  | view | up2246775
 (7 rows)*/




--Q4 Using the provided ERD and Data Dictionary, create a query that will return all the movie titles 
--that are in the Documentary category. Create 2 versions of the same query and in one use category
-- as string (‘documentary’) and in the other use category ID (you will need to check what is the 
--category ID for Documentary). Use the EXPLAIN ANALYZE command and see which query performs better? 

EXPLAIN ANALYZE
SELECT
    m.title as "Movie Title"
FROM
    movie m
    JOIN movie_category mc on mc.movie_id = m.movie_id
    JOIN category c on c.category_id = mc.category_id
where
    c.name = 'Documentary';

/*                                      QUERY PLAN
 ------------------------------------------------------------------------------------------------------------------------------
 Nested Loop  (cost=16.69..38.26 rows=6 width=15) (actual time=0.037..0.460 rows=68 loops=1)
 ->  Hash Join  (cost=16.41..35.06 rows=6 width=4) (actual time=0.031..0.296 rows=68 loops=1)
 Hash Cond: (mc.category_id = c.category_id)
 ->  Seq Scan on movie_category mc  (cost=0.00..16.00 rows=1000 width=8) (actual time=0.010..0.167 rows=1000 loops=1)
 ->  Hash  (cost=16.38..16.38 rows=3 width=4) (actual time=0.013..0.014 rows=1 loops=1)
 Buckets: 1024  Batches: 1  Memory Usage: 9kB
 ->  Seq Scan on category c  (cost=0.00..16.38 rows=3 width=4) (actual time=0.009..0.010 rows=1 loops=1)
 Filter: ((name)::text = 'Documentary'::text)
 Rows Removed by Filter: 15
 ->  Index Scan using movie_pkey on movie m  (cost=0.28..0.53 rows=1 width=19) (actual time=0.002..0.002 rows=1 loops=68)
 Index Cond: (movie_id = mc.movie_id)
 Planning Time: 0.321 ms
 Execution Time: 0.504 ms
 (13 rows)*/


--6 | Documentary | 

EXPLAIN ANALYZE
SELECT
    m.title as "Movie Title"
FROM
    movie m
    JOIN movie_category mc on mc.movie_id = m.movie_id
where
    mc.category_id = 6;

/*                                          QUERY PLAN- query with one JOIN 
 --------------------------------------------------------------------------------------------------------------------------
 Hash Join  (cost=19.35..88.78 rows=68 width=15) (actual time=0.140..0.430 rows=68 loops=1)
 Hash Cond: (m.movie_id = mc.movie_id)
 ->  Seq Scan on movie m  (cost=0.00..65.00 rows=1000 width=19) (actual time=0.007..0.191 rows=1000 loops=1)
 ->  Hash  (cost=18.50..18.50 rows=68 width=4) (actual time=0.114..0.114 rows=68 loops=1)
 Buckets: 1024  Batches: 1  Memory Usage: 11kB
 ->  Seq Scan on movie_category mc  (cost=0.00..18.50 rows=68 width=4) (actual time=0.012..0.101 rows=68 loops=1)
 Filter: (category_id = 6)
 Rows Removed by Filter: 932
 Planning Time: 0.246 ms
 Execution Time: 0.460 ms
 (10 rows)*/



/*                                      QUERY PLAN -- query with 2 JOIN
 ------------------------------------------------------------------------------------------------------------------------------
 Nested Loop  (cost=16.69..38.26 rows=6 width=15) (actual time=0.037..0.460 rows=68 loops=1)
 ->  Hash Join  (cost=16.41..35.06 rows=6 width=4) (actual time=0.031..0.296 rows=68 loops=1)
 Hash Cond: (mc.category_id = c.category_id)
 ->  Seq Scan on movie_category mc  (cost=0.00..16.00 rows=1000 width=8) (actual time=0.010..0.167 rows=1000 loops=1)
 ->  Hash  (cost=16.38..16.38 rows=3 width=4) (actual time=0.013..0.014 rows=1 loops=1)
 Buckets: 1024  Batches: 1  Memory Usage: 9kB
 ->  Seq Scan on category c  (cost=0.00..16.38 rows=3 width=4) (actual time=0.009..0.010 rows=1 loops=1)
 Filter: ((name)::text = 'Documentary'::text)
 Rows Removed by Filter: 15
 ->  Index Scan using movie_pkey on movie m  (cost=0.28..0.53 rows=1 width=19) (actual time=0.002..0.002 rows=1 loops=68)
 Index Cond: (movie_id = mc.movie_id)
 Planning Time: 0.321 ms
 Execution Time: 0.504 ms
 (13 rows)*/





--- Q5 Using your SQL knowledge create a query that will list all movies that have original
-- language Italian along with the release year. The movies should be listed by release year 
--in chronological order.
SELECT
    m.title AS "Movie title",
    m.release_year as "Year"
From
    movie m
where
    m.original_language_id = 2
order by
    m.release_year ASC;

SELECT
    m.title AS "Movie title",
    m.release_year as "Year"
From
    movie m
    JOIN Language l on m.original_language_id = l.language_id
where
    l.name = 'Italian'
order by
    m.release_year ASC;

###################################################################################################


EXPLAIN ANALYZE
SELECT
    m.title AS "Movie title",
    m.release_year as "Year"
From
    movie m
where
    m.original_language_id = 2
order by
    m.release_year ASC;

/*  QUERY PLAN
 ----------------------------------------------------------------------------------------------------------------------------------------------
 Sort  (cost=67.80..68.18 rows=153 width=19) (actual time=0.203..0.211 rows=153 loops=1)
 Sort Key: release_year
 Sort Method: quicksort  Memory: 35kB
 ->  Bitmap Heap Scan on movie m  (cost=5.34..62.25 rows=153 width=19) (actual time=0.034..0.156 rows=153 loops=1)
 Recheck Cond: (original_language_id = 2)
 Heap Blocks: exact=52
 ->  Bitmap Index Scan on idx_fk_original_language_id  (cost=0.00..5.30 rows=153 width=0) (actual time=0.020..0.020 rows=153 loops=1)
 Index Cond: (original_language_id = 2)
 Planning Time: 0.117 ms
 Execution Time: 0.246 ms
 (10 rows)*/

 
EXPLAIN ANALYZE
SELECT
    m.title AS "Movie title",
    m.release_year as "Year"
From
    movie m
    JOIN Language l on m.original_language_id = l.language_id
where
    l.name = 'Italian'
order by
    m.release_year ASC;

/*                                     QUERY PLAN
 -----------------------------------------------------------------------------------------------------------------------
 Sort  (cost=85.87..85.88 rows=5 width=19) (actual time=0.460..0.469 rows=153 loops=1)
 Sort Key: m.release_year
 Sort Method: quicksort  Memory: 35kB
 ->  Hash Join  (cost=18.16..85.81 rows=5 width=19) (actual time=0.066..0.416 rows=153 loops=1)
 Hash Cond: (m.original_language_id = l.language_id)
 ->  Seq Scan on movie m  (cost=0.00..65.00 rows=1000 width=23) (actual time=0.012..0.186 rows=1000 loops=1)
 ->  Hash  (cost=18.12..18.12 rows=3 width=4) (actual time=0.035..0.036 rows=1 loops=1)
 Buckets: 1024  Batches: 1  Memory Usage: 9kB
 ->  Seq Scan on language l  (cost=0.00..18.12 rows=3 width=4) (actual time=0.015..0.016 rows=1 loops=1)
 Filter: (name = 'Italian'::bpchar)
 Rows Removed by Filter: 5
 Planning Time: 0.164 ms
 Execution Time: 0.506 ms
 (13 rows)*/





--Q6 List how many  movies are in each category per original language.
-- The output should be similar to the one below.
SELECT
    c.name AS "Category",
    l.name as "orifinal language",
    count(m.movie_id) as " number of movie"
From
    language l
    join movie m on l.language_id = m.original_language_id
    join movie_category mc on mc.movie_id = m.movie_id
    join category c on c.category_id = mc.category_id
group by
    c.name,
    l.name
order by
    c.name ASC;


/*=======================
LAB 6
=========================*/
--\c movie_rental

--Q1 Connect to the movie_rental database (that you have installed in LAB5 ) and change the
-- phone number from the current one to 02392844444 for address with id 100.
-- Do not alter any other data/attribute.   
SELECT
  a.address as "address",
  a.phone as "phone"
from
  address a
where
  address_id = '100';


/* address      |   phone    
 ------------------+------------
 1308 Arecibo Way | 6171054059
 (1 row)*/
UPDATE
  address
SET
  phone = '02392844444'
WHERE
  address_id = '100';


/* address      |    phone
 ------------------+-------------
 1308 Arecibo Way | 02392844444
 (1 row)*/

--Q2 Create a query that will return all the details for the record where the phone number
-- is 02392844444 and use EXPLAIN.  Take a screenshot of the output.

EXPLAIN ANALYZE
SELECT
  *
FROM
  address a
WHERE
  phone = '02392844444';

  /* address_id |     address      | address2 | district | city_id | postal_code |    phone    |          last_update
------------+------------------+----------+----------+---------+-------------+-------------+-------------------------------
        100 | 1308 Arecibo Way |          | Georgia  |      41 | 30695       | 02392844444 | 2024-11-14 10:09:13.659643+00
(1 row)*/


/*                                       QUERY PLAN
-----------------------------------------------------------------------------------------------------
 Seq Scan on address a  (cost=0.00..15.54 rows=1 width=63) (actual time=0.097..0.098 rows=1 loops=1)
   Filter: ((phone)::text = '02392844444'::text)
   Rows Removed by Filter: 602
 Planning Time: 0.109 ms
 Execution Time: 0.116 ms
(5 rows)*/


--Q3 Apply an INDEX on the phone attribute. 

CREATE INDEX index_phone 
ON address  (phone);
/*movie_rental=# CREATE INDEX index_phone 
ON address  (phone);
CREATE INDEX */


--Q4 USE EXPLAIN AGAIN 
EXPLAIN ANALYZE
SELECT
  *
FROM
  address a
WHERE
  phone = '02392844444'; 

  /* QUERY PLAN
------------------------------------------------------------------------------------------------------------------------
 Index Scan using index_phone on address a  (cost=0.28..8.29 rows=1 width=63) (actual time=0.030..0.030 rows=1 loops=1)
   Index Cond: ((phone)::text = '02392844444'::text)
 Planning Time: 0.250 ms
 Execution Time: 0.051 ms
(4 rows)*/

-- Q5 delete index from Q3

/*DROP INDEX title_idx;*/

DROP INDEX index_phone ;

/*movie_rental=# DROP INDEX index_phone ;
DROP INDEX*/


--Create a VIEW (customer_details) that will hold the customers details exactly as below. 

CREATE VIEW customer_details AS
SELECT 
 CONCAT_WS(' ',c.first_name ,c.last_name) AS "Customer",
 CONCAT_WS (' | ',c.email,a.phone) AS "Contact Details",
 CONCAT_WS (' ', a.address,a.address2) AS "Customer address",
 ci.city AS "Customer city",
 co.country AS "Customer Country"
 FROM  customer c 
 JOIN address a on a.address_id = c.address_id 
 JOIN city ci on ci.city_id = a.city_id 
 JOIN country co on co.country_id = ci.country_id
 order by "Customer";


SELECT  * FROM customer_details ;


-- Q7 Using a subquery list all cities from the United Kingdom along with the city ID.
SELECT
  ci.city AS "City",
  ci.city_id AS "City ID"
FROM
  city ci
  JOIN country co on co.country_id = ci.country_id
WHERE
  co.country = 'United Kingdom';



---- subquery
SELECT
  ci.city_id AS "City ID",
  ci.city AS "City"
FROM
  city ci
WHERE
  ci.country_id = (
    SELECT
      co.country_id
    FROM
      country co
    WHERE
      co.country = 'United Kingdom'
  );


  --Q8 As an extension of the previous query, list the cities from the United Kingdom and France 
  --using the IN operator, this time showing the country name as well. Group them by country.


SELECT
  ci.city_id AS "City ID",
  ci.city AS "City",
  co.country AS "Country"
FROM
  city ci
  JOIN country co ON ci.country_id = co.country_id
WHERE
  co.country IN ('United Kingdom', 'France')
ORDER BY
  co.country,
  ci.city;

  /* City ID |      City       |    Country
---------+-----------------+----------------
      92 | Brest           | France
     297 | Le Mans         | France
     543 | Toulon          | France
     544 | Toulouse        | France
      88 | Bradford        | United Kingdom
     149 | Dundee          | United Kingdom
     312 | London          | United Kingdom
     494 | Southampton     | United Kingdom
     495 | Southend-on-Sea | United Kingdom
     496 | Southport       | United Kingdom
     500 | Stockport       | United Kingdom
     589 | York            | United Kingdom
(12 rows)*/




/*===========
Challenge Questions 

C1 - Using subqueries, 
list the concatenated first name and last name along with the email address - 
as a separate column - of all customers that have rented an action movie. 
List them in alphabetical order first name then last name. 

Note: This query is a difficult one and can be solved in multiple ways and multiple subqueries.
 As long as you are using at least one subquery for the correct output, it will be a valid query. 
 Look for multiple usage of  IN and USING operators.
*/

SELECT 
CONCAT_WS (' ', c. first_name, c.last_name) AS "Customer name",
c.email AS "Email"
From customer c 
where c.customer_id IN (SELECT DISTINCT r.customer_id
from rental r
join inventory i on i.inventory_id= r.inventory_id
join movie m  on m.movie_id = i.movie_id
join movie_category mc on mc.movie_id = m.movie_id 
join category ca on ca.category_id = mc.category_id 
where ca.name = 'action');



SELECT
  CONCAT_WS(' ', c.first_name, c.last_name) AS "Customer Name",
  c.email AS "Email"
FROM customer c
INNER JOIN rental r ON r.customer_id = c.customer_id
INNER JOIN inventory i ON i.inventory_id = r.inventory_id
INNER JOIN movie m ON m.movie_id = i.movie_id
INNER JOIN movie_category mc ON mc.movie_id = m.movie_id
INNER JOIN category ca ON ca.category_id = mc.category_id
WHERE ca.name = 'Action'  
ORDER BY c.first_name, c.last_name; 

/*  Customer Name     |                  Email
-----------------------+------------------------------------------
 AARON SELBY           | AARON.SELBY@sakilacustomer.org
 AARON SELBY           | AARON.SELBY@sakilacustomer.org
 ADAM GOOCH            | ADAM.GOOCH@sakilacustomer.org
 AGNES BISHOP          | AGNES.BISHOP@sakilacustomer.org
 AGNES BISHOP          | AGNES.BISHOP@sakilacustomer.org
 AGNES BISHOP          | AGNES.BISHOP@sakilacustomer.org
 ALAN KAHN             | ALAN.KAHN@sakilacustomer.org
 ALBERT CROUSE         | ALBERT.CROUSE@sakilacustomer.org
 ALBERTO HENNING       | ALBERTO.HENNING@sakilacustomer.org
 ALEX GRESHAM          | ALEX.GRESHAM@sakilacustomer.org
 ALEXANDER FENNELL     | ALEXANDER.FENNELL@sakilacustomer.org */




/*=======================
LAB 7
=========================*/

CREATE ROLE junior_analyst WITH LOGIN PASSWORD '1234';

-- във втория терминал се вписвам нормално с моя профил но след тода на ниво psql  
--слагам  това psql -h localhost -p 5432 -U junior_analyst -d movie_rental


--psql -h localhost -p 5432 -U junior_analyst -d movie_rental

DROP ROLE junior_analyst;
GRANT CONNECT ON  DATABASE movie_rental TO junior_analyst;




SELECT * FROM staff;
--before give a grant select 
/*=====
movie_rental=> SELECT * FROM staff;
ERROR:  permission denied for table staff
======*/

---GRANT SELECT ON table_name TO username;
GRANT SELECT ON staff TO junior_analyst;

--after giving a grant 
SELECT * FROM staff;
/*  1 | Mike       | Hillyer   |          3 | Mike.Hillyer@sakilastaff.com |        1 | t      | Mike     | 8cb2237d0679ca88db6464eac60da96345513964 | 2022-05-16 15:13:11.79328+00 | \x89504e470d0a5a0a
        2 | Jon        | Stephens  |          4 | Jon.Stephens@sakilastaff.com |        2 | t      | Jon      | 8cb2237d0679ca88db6464eac60da96345513964 | 2022-05-16 15:13:11.79328+00 |*/


--Q2 
    /*==========
    Following a similar process as
     above, how would you grant INSERT access to the 
     "payment_p2022_01" table to a new role called "cashier"? 
    ===========*/   
CREATE ROLE cashier WITH LOGIN PASSWORD '1234';
/*
movie_rental=# CREATE ROLE cashier WITH LOGIN PASSWORD '1234';
CREATE ROLE
*/


GRANT CONNECT ON DATABASE movie_rental TO cashier;
/*movie_rental=# GRANT CONNECT ON DATABASE movie_rental TO cashier;
GRANT
*/

GRANT INSERT ON payment_p2022_01 TO cashier;
/*movie_rental=# GRANT INSERT ON payment_p2022_01 TO cashier;
GRANT*/
---psql -h localhost -p 5432 -U cashier -d movie_rental


INSERT INTO payment_p2022_01(customer_id, staff_id, rental_id, amount, payment_date) 
VALUES (1, 1, 1, 5.99, CURRENT_TIMESTAMP);

/*permission denied for table payment_p2022_01*/

--why
GRANT USAGE ON sequence public.payment_p2022_01_payment_id_seq TO cashier;

--after giving the GRANT USAGE ON SEQUENCE
INSERT INTO payment_p2022_01(customer_id, staff_id, rental_id, amount, payment_date) 
VALUES (1, 1, 1, 5.99, CURRENT_TIMESTAMP);


/*movie_rental=> INSERT INTO payment_p2022_01(customer_id, staff_id, rental_id, amount, payment_date) 
VALUES (1, 1, 1, 5.99, CURRENT_TIMESTAMP);
INSERT 0 1*/

###################################################################################################

--Q3 Using your cashier role, try to SELECT * FROM rental;. You should not be able to do so. 

SELECT * FROM rental;
--ERROR:  permission denied for table rental

GRANT SELECT ON rental TO cashier;
--movie_rental=# GRANT SELECT ON rental TO cashier;
--GRANT

GRANT INSERT ON rental TO cashier;
---movie_rental=# GRANT INSERT ON rental TO cashier;
--GRANT


INSERT INTO rental (rental_id, rental_date, inventory_id, customer_id, return_date,     staff_id, last_update)
VALUES (17000, CURRENT_DATE,  1,  1, NULL, 1, CURRENT_TIMESTAMP);

/*movie_rental=> INSERT INTO rental (rental_id, rental_date, inventory_id, customer_id, return_date,     staff_id, last_update)
VALUES (17000, CURRENT_DATE,  1,  1, NULL, 1, CURRENT_TIMESTAMP);
INSERT 0 1*/

SELECT * FROM rental WHERE rental_id = 17000;

/* rental_id |      rental_date       | inventory_id | customer_id | return_date | staff_id |          last_update
-----------+------------------------+--------------+-------------+-------------+----------+-------------------------------
     17000 | 2024-11-28 00:00:00+00 |            1 |           1 |             |        1 | 2024-11-28 10:15:16.165039+00
(1 row)*/



GRANT DELETE ON rental to cashier;
/* GRANT DELETE ON rental to cashier;
GRANT*/


DELETE FROM rental WHERE rental_id = 17000;

/*movie_rental=> DELETE FROM rental WHERE rental_id = 17000;
DELETE 1*/

###################################################################################################
--Q4
How would you give a role named "manager" the ability 
to update the "country" table and also give them permission 
to grant this privilege to  another role called “sales”?


--A Create the role manager with all necessary permissions 
--(login, update and to grant permissions to others)

CREATE ROLE manager WITH LOGIN PASSWORD '1234';
/*movie_rental=# CREATE ROLE manager WITH LOGIN PASSWORD '1234';
CREATE ROLE*/

GRANT CONNECT ON  DATABASE movie_rental TO manager  ;
/*movie_rental=# GRANT CONNECT ON  DATABASE movie_rental TO manager  ;
GRANT*/
GRANT UPDATE ON country to manager WITH GRANT OPTION;
/*movie_rental=# GRANT UPDATE ON country to manager WITH GRANT OPTION;
GRANT*/


--B  Create a role sales but only login permissions

CREATE ROLE sales  WITH LOGIN PASSWORD '1234';
/*movie_rental=# CREATE ROLE sales  WITH LOGIN PASSWORD '1234';
CREATE ROLE*/
GRANT CONNECT ON  DATABASE movie_rental TO sales  ;
/*movie_rental=# GRANT CONNECT ON  DATABASE movie_rental TO sales  ;
GRANT*/


--C Login as manager and grant the UPDATE on COUNTRY  permission for sales role 
--psql -h localhost -p 5432 -U manager -d movie_rental
Manager give grant to sales

GRANT UPDATE ON country to sales;
/*movie_rental=> GRANT UPDATE ON country to sales;
GRANT
movie_rental=> */ 

--GRANT UPDATE ON country to sales;


--D Login as sales make the following update
psql -h localhost -p 5432 -U sales -d movie_rental


UPDATE country SET last_update = NOW() WHERE country_id = 102;

/*movie_rental=> UPDATE country SET last_update = NOW() WHERE country_id = 102;
ERROR:  permission denied for table country*/

 why?---Most likely you will have an error    https://www.postgresql.org/docs/9.1/sql-grant.html
-- Why? Think to the Transaction Analysis. Adjust the privileges for
--‘manager’ and  ‘sales’  and perform the UPDATE from ‘sales’ account. 
-- ANSWER  because i didnt give any grant to the manager for select, then update ???


/*Allows UPDATE of any column, or the specific columns listed, of the specified table. 
(In practice, any nontrivial UPDATE command will require SELECT privilege as well, since it
 must reference table columns to determine which rows to update, and/or to compute new values for 
 columns.) SELECT ... FOR UPDATE and SELECT ... FOR SHARE also require this privilege on at least 
 one column, in addition to the SELECT privilege. For sequences, this privilege allows the use of
  the nextval and setval functions. For large objects, this privilege allows writing or truncating the object.*/


GRANT SELECT ON country to manager WITH GRANT OPTION;
/*movie_rental=# GRANT SELECT ON country to manager WITH GRANT OPTION;
GRANT*/


psql -h localhost -p 5432 -U manager -d movie_rental
 --give a grant select to sales GRANT SELECT ON country to sales; 
 GRANT SELECT ON country to sales;
 /* movie_rental=> GRANT SELECT ON country to sales;
GRANT 
 */


-- After giving grant selest to manager and log in with sales 

/*movie_rental=> UPDATE country SET last_update = NOW() WHERE country_id = 102;
UPDATE 1*/

-- D Check if the update was successful as sales - for last_update you should have the current data and time.

SELECT * FROM country WHERE country_id=102;

/*country_id |    country     |          last_update          | country_code
------------+----------------+-------------------------------+--------------
        102 | United Kingdom | 2024-12-11 15:16:37.234162+00 | UK*/



-- Q5 Using the superuser role, create the following VIEW: 

CREATE VIEW customer_view AS SELECT * FROM customer;

a)How you will allow the "sales" role the ability to access the
 view without granting them direct access to the table?
-- giving grant to  manager 
GRANT SELECT ON customer_view TO manager;
--movie_rental=# GRANT SELECT ON customer_view TO manager;
--GRANT
GRANT SELECT ON customer_view TO sales;
/*movie_rental=> GRANT SELECT ON customer_view TO sales;
WARNING:  no privileges were granted for "customer_view"*/


SELECT * FROM customer_view;


 psql -h localhost -p 5432 -U manager -d movie_rental 
  psql -h localhost -p 5432 -U sales -d movie_rental




 \dp customer_view;
 \dp country;

 REVOKE SELECT ON customer_view FROM manager;

 GRANT SELECT ON customer_view  to manager WITH GRANT OPTION;
GRANT SELECT ON customer_view TO sales;



--q6

INSERT INTO staff (staff_id, first_name, last_name, address_id, email, store_id,      active, username, password, last_update, picture)
VALUES (3, 'Val','Adam', 5,'val.adam@sakilastaff.com', 1,'t', 'valadam',     '8cb2237d0679ca88db6464eac60da96345513964', CURRENT_TIMESTAMP, NULL);

a)Create a new role as “admin” that will have the capability to create new roles. 

     CREATE ROLE admin  WITH LOGIN PASSWORD '1234' CREATEROLE;
     CREATE ROLE admin WITH  CREATEROLE;

    DROP ROLE admin;










/*=======================
LAB 8
=========================*/

--Q1 List id, first name and last name of all actors that have the first name as Scarlett. 
--The query should ignore the name capitalisation. Hint: Look for the ILIKE/LIKE keywords or 
--wildcard characters. 

SELECT
  a.actor_id as "ID",
  a.first_name as "First name",
  a.last_name as "Last name"
from
  actor a
WHERE
  a.first_name ILIKE 'Scarlett';

/*ID  | First name | Last name 
-----+------------+-----------
  81 | SCARLETT   | DAMON
 124 | SCARLETT   | BENING
(2 rows)*/

-- In this case where i need to find results and ignore the name capitalisation will use ILIKE 
-- because is not case sensitive option.

--Q2How many unique last names are in actors' names? (e.g. If they are 3 Smith’s will be counted only once).  
SELECT
  count (DISTINCT a.last_name) as "Unique Last name "
from
  actor a;

/* Unique Last name  
-------------------
               121
(1 row)*/

SELECT
  COUNT (a.actor_id) as "number of actors in the table "
from
  actor a;
/*number of actors in the table
--------------------------------
                            200
(1 row)*/


--Q3 
--Following from the previous query, we know how many unique  last names are in the database.
-- However, how many of them are appearing only once? E.g. 
--OLIVIER  will be twice, so is not that unique, but PESCI will be only once making truly unique.
-- List all the true unique names)  
--List in alphabetical order the last names that are repeated only once
-- (e.g. if a last name is more than once  in the database it will not be considered).


SELECT
    a.last_name AS "Unique Last Names"
FROM 
    actor a
GROUP BY 
    a.last_name
HAVING 
    COUNT(a.last_name) = 1
ORDER BY 
    a.last_name;
-- (66 rows)

/*unique names
--------------
 ASTAIRE
 BACALL
 BALE
 BALL
 BARRYMORE
 BASINGER
 BERGEN
 BERGMAN
 BIRCH
 BLOOM
 BRIDGES
 BULLOCK
 CARREY
 CHAPLIN
 CLOSE
 COSTNER
 CROWE
 CRUISE
 CRUZ
 DAMON
 DAY-LEWIS
 DERN
 DREYFUSS
 DUNST
 GABLE
 GIBSON
 GOLDBERG
 GRANT
 HAWKE
 HESTON
 HOPE
 HUDSON
 HUNT
 HURT
 JOLIE
 JOVOVICH
 LEIGH
 LOLLOBRIGIDA
 MALDEN
 MANSFIELD
 MARX
 MCDORMAND
 MIRANDA
 NICHOLSON
 PESCI
 PFEIFFER
 PHOENIX
 PINKETT
 PITT
 POSEY
 PRESLEY
 REYNOLDS
 RYDER
 SINATRA
 SOBIESKI
 STALLONE
 SUVARI
 SWANKa
 TAUTOU
 TOMEI
 VOIGHT
 WALKEN
 WAYNE
 WILSON
 WITHERSPOON
 WRAY
(66 rows)
 */


--Q 4List the first name and last name of the actor that appear in 
--most movies and the number of movies. Hint: Look for .USING 


SELECT
  a.first_name as "First name",
  a.last_name as "Last name",
  COUNT(ma.movie_id) as "number of movie"
from
  actor a
  join movie_actor ma USING(actor_id)
group by
  a.last_name,
  a.first_name
ORDER BY
  "number of movie" DESC
LIMIT
  1;

/*First name | Last name | number of movie
------------+-----------+-----------------
 SUSAN      | DAVIS     |              54
(1 row)*/

/*First name  |  Last name   | number of movie
-------------+--------------+-----------------
 SUSAN       | DAVIS        |              54
 GINA        | DEGENERES    |              42
 WALTER      | TORN         |              41
 MARY        | KEITEL       |              40
 MATTHEW     | CARREY       |              39*/

SELECT
  a.first_name,
  a.last_name,
  COUNT(*) AS num_movies
FROM
  actor a
  JOIN movie_actor am USING (actor_id)
GROUP BY
  a.first_name,
  a.last_name
ORDER BY
  num_movies DESC
LIMIT
  5;


/*irst_name | last_name | num_movies
------------+-----------+------------
 SUSAN      | DAVIS     |         54
 GINA       | DEGENERES |         42
 WALTER     | TORN      |         41
 MARY       | KEITEL    |         40
 MATTHEW    | CARREY    |         39
(5 rows)*/

/* ===== example 
SELECT e.EMPLOYEE_ID, e.LAST_NAME, d.LOCATION_ID
FROM Employees e JOIN Departments d
USING(DEPARTMENT_ID);*/


--- Q5 Each store has several copies of each movie. List the available store 1
--inventory for the movie named ‘Purple Movie’. How many copies are available and 
--what are the inventory IDs? 
SELECT
  i.inventory_id,
  COUNT(i.inventory_id) AS "Number of copies"
FROM
  inventory i
  JOIN movie m ON i.movie_id = m.movie_id
  JOIN store s ON i.store_id = s.store_id
WHERE
  m.title = 'Purple Movie'
  AND s.store_id = 1
GROUP BY
  i.inventory_id;

/*inventory_id | Number of copies
--------------+------------------
(0 rows)*/


--Q6 List staff name and last name, along with their home address, 
--city and email address. The data should be  presented in a nice format (exactly as below). 


SELECT
  CONCAT (s.first_name, ' ', s.last_name) AS "Staff Name",
  CONCAT(a.address, ' ', a.address2) AS "Staff Address",
  c.city AS "City",
  s.email AS "Staff Email"
FROM
  staff s
  join address a on s.address_id = a.address_id
  join city c on c.city_id = a.city_id;

/*Staff Name  |     Staff Address     |    City    |         Staff Email
--------------+-----------------------+------------+------------------------------
 Mike Hillyer | 23 Workhaven Lane     | Lethbridge | Mike.Hillyer@sakilastaff.com
 Jon Stephens | 1411 Lillydale Drive  | Woodridge  | Jon.Stephens@sakilastaff.com
(2 rows)*/



--Q7
--List the name and the last name in alphabetical order (on surname) 
--of all actors that have acted in the movie named ‘Agent Truman’. 
--The names should appear in a single column just the name of the actors, not the movie. 
 
SELECT
  m.title AS "Movie Title",
  CONCAT(a.first_name, ' ', a.last_name) AS "Actors in the movie"
FROM
  movie m
  JOIN movie_actor ma ON m.movie_id = ma.movie_id
  JOIN actor a ON ma.actor_id = a.actor_id
WHERE
  m.title = 'AGENT TRUMAN'
GROUP BY
  m.title,
  "Actors in the movie";

/*Movie Title  | Actors in the movie
--------------+---------------------
 AGENT TRUMAN | JAYNE NEESON
 AGENT TRUMAN | KENNETH HOFFMAN
 AGENT TRUMAN | KIRSTEN PALTROW
 AGENT TRUMAN | MORGAN WILLIAMS
 AGENT TRUMAN | REESE WEST
 AGENT TRUMAN | SANDRA KILMER
 AGENT TRUMAN | WARREN NOLTE
(7 rows)*/



---CHALANGE 
SELECT
  m.title AS "Movie Title",
  STRING_AGG(CONCAT(a.first_name, ' ', a.last_name), ', ') AS "Actors in the movie"
FROM
  movie m
  JOIN movie_actor ma ON m.movie_id = ma.movie_id
  JOIN actor a ON ma.actor_id = a.actor_id
WHERE
  m.title = 'AGENT TRUMAN'
GROUP BY
  m.title;

/* Movie Title  |                                           Actors in the movie
--------------+----------------------------------------------------------------------------------------------------------
 AGENT TRUMAN | KIRSTEN PALTROW, SANDRA KILMER, JAYNE NEESON, WARREN NOLTE, MORGAN WILLIAMS, KENNETH HOFFMAN, REESE WEST
(1 row)*/



SELECT
  m.title AS "Movie Title",
  m.movie_id AS "Movie ID"
FROM
  movie m
WHERE
  m.title = 'Agent Truman';

/*=======================
LAB 9
=========================*/



-- Q1 List all the functions available in the movie_rental database.  

/*movie_rental=# \df
                                                         List of functions
 Schema |            Name            | Result data type |                        Argument data types                         | Type
--------+----------------------------+------------------+--------------------------------------------------------------------+------
 public | get_customer_balance       | numeric          | p_customer_id integer, p_effective_date timestamp with time zone   | func
 public | group_concat               | text             | text                                                               | agg
 public | group_concat               | text             | text, text                                                         | func
 public | inventory_held_by_customer | integer          | p_inventory_id integer                                             | func
 public | inventory_in_stock         | boolean          | p_inventory_id integer                                             | func
 public | last_day                   | date             | timestamp with time zone                                           | func
 public | last_updated               | trigger          |                                                                    | func
 public | movie_in_stock             | SETOF integer    | p_movie_id integer, p_store_id integer, OUT p_movie_count integer  | func
 public | movie_not_in_stock         | SETOF integer    | p_movie_id integer, p_store_id integer, OUT p_movie_count integer  | func
 public | rewards_report             | SETOF customer   | min_monthly_purchases integer, min_dollar_amount_purchased numeric | func
(10 rows)*/

--Q2 In the database is a function (movie_in_stock), with two INT parameters 
--(p_movie_id and p_store_id ), that will return all available copies of a given movie in a
-- particular store. Using the named function, find the number of copies of the movie Named  
--“Angels Life” in store 1. 
--Hint: Look for named notation syntax format to call a function parameter. 
--The output should look like below.

select (“Angels Life”)

select movie_id from movie where title  ILIKE 'Angels Life';-- 25
select movie_in_stock(25,1);

/* movie_in_stock 
----------------
            124
            125
            126
            127
(4 rows)
*/




--Q3 
/*Create a stored procedure (sp_add_new_actor) that will automatically insert a new actor.
Insert your own name through stored procedure CALL e.g.  CALL sp_add_new_actor('Val', 'Adamescu'); 
You don’t need to allocate any ID as is automatically added by SERIAL PK and the last_update is
 automatically updated by another function.
  The procedure should take only two parameters (First Name & Last Name).  
*/
https://devdocs.io/postgresql~14/sql-createprocedure


CREATE OR REPLACE procedure sp_add_new_actor (
    first_name  VARCHAR,
    last_name VARCHAR 
)
Language plpgsql
AS $$
BEGIN
    INSERT INTO actor (first_name, last_name)
    VALUES (first_name, last_name);
END;
$$;

CALL sp_add_new_actor('Reni', 'Todorova');

select * from  actor where first_name = 'Reni';

/* actor_id | first_name | last_name |          last_update
----------+------------+-----------+-------------------------------
      201 | Reni       | Todorova  | 2024-12-07 15:37:15.275148+00
(1 row)*/



-- q4 Create a new column in the country table named country_code as VARCHAR. 

/d country

/* Column    |           Type           | Collation | Nullable |                   Default
-------------+--------------------------+-----------+----------+---------------------------------------------
 country_id  | integer                  |           | not null | nextval('country_country_id_seq'::regclass)
 country     | character varying(100)   |           | not null |
 last_update | timestamp with time zone |           | not null | now()*/

/*==== Syntax ADD COLUMN
ALTER TABLE table_name
ADD column_name datatype;
========*/

ALTER TABLE
  country
ADD
  country_code VARCHAR;-- varchar(10) if you add this you are not able to changhe it with smaller lenght ;)


\d country

/* Column    |           Type           | Collation | Nullable |                   Default
--------------+--------------------------+-----------+----------+---------------------------------------------
 country_id   | integer                  |           | not null | nextval('country_country_id_seq'::regclass)
 country      | character varying(100)   |           | not null |
 last_update  | timestamp with time zone |           | not null | now()
 country_code | character varying(10)    |           |          |*/

-- alter column and add only varchar

ALTER TABLE
  country DROP COLUMN country_code;

/*Column    |           Type           | Collation | Nullable |                   Default
--------------+--------------------------+-----------+----------+---------------------------------------------
 country_id   | integer                  |           | not null | nextval('country_country_id_seq'::regclass)
 country_id   | integer                  |           | not null | nextval('country_country_id_seq'::regclass)
 country      | character varying(100)   |           | not null |
 last_update  | timestamp with time zone |           | not null | now()
 country_code | character varying        |           |          |*/


--oops, my bad.. CHAR(2)  data type will be more efficient. Modify the country_code 
--from VARCHAR to CHAR(2) and to have only unique values for the column country_code. 
--Use \d country and take a screenshot of the table details.   

/*=====  Syntax ALTER/MODIFY DATATYPE
ALTER TABLE table_name
ALTER COLUMN column_name datatype;
============*/


ALTER TABLE country
ALTER COLUMN country_code CHAR(2);

/*ERROR:  syntax error at or near "CHAR"
LINE 2: ALTER COLUMN country_code CHAR(2);*/


ALTER TABLE
  country DROP COLUMN country_code;


ALTER TABLE
  country
ADD
  country_code CHAR(2);

/*Column    |           Type           | Collation | Nullable |                   Default
--------------+--------------------------+-----------+----------+---------------------------------------------
 country_id   | integer                  |           | not null | nextval('country_country_id_seq'::regclass)
 country      | character varying(100)   |           | not null |
 last_update  | timestamp with time zone |           | not null | now()
 country_code | character(2)             |           |          |*/





-- Q6  Now if everything is ready, insert the country code as UK for the United Kingdom 
--and create the output as country id, country name and country code. 


/*==== update  syntax
UPDATE my_table
SET new_column = 'some information'
WHERE id = 123;*/ 

UPDATE
  country
SET
  country_code = 'UK'
WHERE
  country = 'United Kingdom';


/*country_id |    country     |          last_update          | country_code
------------+----------------+-------------------------------+--------------
        102 | United Kingdom | 2024-12-07 16:03:28.638401+00 | UK
(1 row)*/

 select * from country WHERE  country = 'United Kingdom';

 --Q7 We are planning some migration of our data but we don’t want to transfer everything..
 -- Create a new table (new_staff) and copy only  id, first & last name and email address. 

CREATE TABLE
  new_staff AS
SELECT
  staff_id,
  first_name,
  last_name,
  email
FROM
  staff;

select * from new_staff;

  --Q8 We have so many copies of each movie for rental but how many? The output of the movies in
  -- inventory must be exactly as below. Column naming, text formatting, number of copies starting 
  --from the movies with most copies until the ones with less copies.   



SELECT
 m.title AS "Movie title",
COUNT(i.inventory_id) AS "Number of copies"   
FROM movie m
JOIN inventory i ON i.movie_id = m.movie_id
GROUP BY m.title
ORDER BY COUNT(i.inventory_id) DESC, m.title;



 --Q9 What is the average movie length per category? 
 --Round it to the nearest two decimal places in descending order as  below.

SELECT
  c.name AS "Category",
  ROUND(AVG(m.length), 2) AS "Avarage Movie Lenght in Minutes"
FROM
  movie m
  JOIN movie_category mc on mc.movie_id = m.movie_id
  JOIN category c on mc.category_id = c.category_id
GROUP BY
  c.name;
  /*Category   | Avarage Movie Lenght in Minutes 
-------------+---------------------------------
 Sports      |                          128.20
 Classics    |                          111.67
 New         |                          111.13
 Family      |                          114.78
 Comedy      |                          115.83
 Animation   |                          111.02
 Travel      |                          113.32
 Music       |                          113.65
 Drama       |                          120.84
 Horror      |                          112.48
 Sci-Fi      |                          108.20
 Games       |                          127.84
 Documentary |                          108.75
 Foreign     |                          121.70
 Action      |                          111.61
 Children    |                          109.80
(16 rows)*/



SELECT ROUND(AVG(length),2) AS "avg movie length"
FROM movie;
/** avg movie length
------------------
           115.27*/


  SELECT
  c.name AS "Category",
  ROUND(AVG(m.length), 2) AS "Avarage Movie Lenght in Minutes"
FROM
  movie m
  JOIN movie_category mc on mc.movie_id = m.movie_id
  JOIN category c on mc.category_id = c.category_id
  GROUP BY
  c.name
HAVING
  ROUND(AVG(m.length), 2) > (SELECT ROUND(AVG(length),2) FROM movie)
ORDER BY
  "Avarage Movie Lenght in Minutes" DESC;


  /*Category | Avarage Movie Lenght in Minutes
----------+---------------------------------
 Sports   |                          128.20
 Comedy   |                          115.83
 Drama    |                          120.84
 Games    |                          127.84
 Foreign  |                          121.70
(5 rows)*/

