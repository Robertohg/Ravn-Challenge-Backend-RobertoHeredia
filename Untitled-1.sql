/* 1. Who are the first 10 authors ordered by date_of_birth? 
2. What is the sales total for the author named “Lorelai Gilmore”? 
3. What are the top 10 performing authors, ranked by sales revenue? */

CREATE TABLE authors ( id serial PRIMARY KEY, name text, date_of_birth timestamp );

CREATE TABLE books ( id serial PRIMARY KEY, author_id integer REFERENCES authors (id), isbn text, );

CREATE TABLE sale_items ( id serial PRIMARY KEY, book_id integer REFERENCES books (id), customer_name text, item_price money, quantity integer );

/* Query 1*/
SELECT  TOP 10 a.authros
FROM authors a
ORDER BY date_of_birth;
/* Query 2*/
SELECT  SUM(si.item_price * si.quantity)
FROM sales_items si
WHERE si.book_id =(
SELECT  b.id
FROM books b
WHERE a.authors_id =(
SELECT  a.id
FROM authors a
WHERE a.name = 'Lorelai Gilmore'));
/* Query 3*/

SELECT TOP 10 si.customer_name, sum(si.item_price * si.quantity) AS venta FROM sale_items si 
INNER JOIN books b ON si.book_id =b.id 
INNER JOIN authors a ON b.author_id =a.id
GROUP BY si.customer_name
ORDER BY 2 DESC;
