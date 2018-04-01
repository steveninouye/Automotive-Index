-- Create a new postgres user named indexed_cars_user
CREATE USER indexed_cars_user;
-- Create a new database named indexed_cars owned by indexed_cars_user
CREATE DATABASE indexed_cars
OWNER indexed_cars_user;

-- Run the provided scripts/car_models.sql script on the indexed_cars database
\c indexed_cars;
\i scripts/car_models.sql;

-- Run the provided scripts/car_model_data.sql script on the indexed_cars database 10 times
-- there should be 223380 rows in car_models
\i scripts/car_model_data.sql;
\i scripts/car_model_data.sql;
\i scripts/car_model_data.sql;
\i scripts/car_model_data.sql;
\i scripts/car_model_data.sql;
\i scripts/car_model_data.sql;
\i scripts/car_model_data.sql;
\i scripts/car_model_data.sql;
\i scripts/car_model_data.sql;
\i scripts/car_model_data.sql;


-- Timing Select Statements
-- Enable timing queries in Postgres by toggling the \timing command in the psql shell.
\timing
-- Run a query to get a list of all make_title values from the car_models table where the make_code is 'LAM', without any duplicate rows, and note the time somewhere. (should have 1 result)
-- 38.225ms
SELECT DISTINCT ON
(make_title) make_title FROM car_models
WHERE make_code = 'LAM';
-- Run a query to list all model_title values where the make_code is 'NISSAN', and the model_code is 'GT-R' without any duplicate rows, and note the time somewhere. (should have 1 result)
-- 53.068 ms
SELECT DISTINCT ON
(make_code,model_code) model_title
FROM car_models
WHERE make_code = 'NISSAN'
AND model_code = 'GT-R';
-- Run a query to list all make_code, model_code, model_title, and year from car_models where the make_code is 'LAM', and note the time somewhere. (should have 1360 rows)
--48.799 ms
SELECT make_code, model_code, model_title, year
FROM car_models
WHERE make_code = 'LAM';
-- Run a query to list all fields from all car_models in years between 2010 and 2015, and note the time somewhere (should have 78840 rows)
--147.339 ms
SELECT *
FROM car_models
WHERE year BETWEEN 2010 AND 2015;
-- Run a query to list all fields from all car_models in the year of 2010, and note the time somewhere (should have 13140 rows)
--57.625 ms
SELECT *
FROM car_models
WHERE year = 2010;
-- Indexing
-- Given the current query requirements, "should get all make_titles", "should get a list of all model_titles by the make_code", etc.
-- Create indexes on the columns that would improve query performance.
-- To add an index:
-- CREATE INDEX [index name]
--   ON [table name] ([column name(s) index]);
-- Record your index statements in indexing.sql
-- Write the following statements in indexing.sql
CREATE INDEX make_title ON car_models (make_title);
CREATE INDEX model_title ON car_models (model_title);
CREATE INDEX make_model_year ON car_models (make_code, model_code, model_title, year);
-- Create a query to get a list of all make_title values from the car_models table where the make_code is 'LAM', without any duplicate rows, and note the time somewhere. (should have 1 result)
--1.515 ms
SELECT make_title
FROM car_models
WHERE make_code = 'LAM';
-- Create a query to list all model_title values where the make_code is 'NISSAN', and the model_code is 'GT-R' without any duplicate rows, and note the time somewhere. (should have 1 result)
--1.154 ms
SELECT DISTINCT ON
(make_code,model_code) model_title
FROM car_models
WHERE make_code = 'NISSAN'
AND model_code = 'GT-R';
-- Create a query to list all make_code, model_code, model_title, and year from car_models where the make_code is 'LAM', and note the time somewhere. (should have 1360 rows)
--2.158 ms
SELECT make_code, model_code, model_title, year
FROM car_models
WHERE make_code = 'LAM';
-- Create a query to list all fields from all car_models in years between 2010 and 2015, and note the time somewhere (should have 78840 rows)
--164.410 ms
SELECT *
FROM car_models
WHERE year BETWEEN 2010 AND 2015;
-- Create a query to list all fields from all car_models in the year of 2010, and note the time somewhere (should have 13140 rows)
--67.378 ms
SELECT *
FROM car_models
WHERE year = 2010;


-- Compare the times of the queries before and after the table has been indexes.

-- Why are queries #4 and #5 not running faster?

-- Indexing on table create
-- Add your recorded indexing statements to the scripts/car_models.sql
-- Delete the car_models table
-- Run the provided scripts/car_models.sql script on the indexed_cars database
-- Run the provided scripts/car_model_data.sql script on the indexed_cars database 10 times
-- there should be 223380 rows in car_models