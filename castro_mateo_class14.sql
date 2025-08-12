USE sakila;

-- 1)  Write a query that gets all the customers that live in Argentina. Show the first and last name in one column, the address and the city.
SELECT 
    CONCAT_WS(' ', c.first_name, c.last_name) AS nombre_completo,
    a.address AS direccion,
    ci.city AS ciudad
FROM customer AS c
JOIN address AS a USING (address_id)
JOIN city AS ci USING (city_id)
JOIN country AS co USING (country_id)
WHERE co.country = 'Argentina';


-- 2) Write a query that shows the film title, language and rating. Rating shall be shown as the full text described 
SELECT 
    f.title AS titulo,
    l.name AS idioma,
    CASE f.rating
        WHEN 'G' THEN 'G (Apto para todo público)'
        WHEN 'PG' THEN 'PG (Se sugiere guía parental)'
        WHEN 'PG-13' THEN 'PG-13 (No recomendado para menores de 13 años)'
        WHEN 'R' THEN 'R (Menores de 17 con un adulto)'
        WHEN 'NC-17' THEN 'NC-17 (Solo para adultos, nadie menor de 17)'
        ELSE 'NR (Sin clasificación)'
    END AS descripcion_rating
FROM film AS f
JOIN language AS l USING (language_id);


-- 3) Write a search query that shows all the films (title and release year) an actor was part of. 
-- Assume the actor comes from a text box introduced by hand from a web page. Make sure to "adjust" the input 
-- text to try to find the films as effectively as you think is possible.
SET @busqueda_actor = 'Tom';

SELECT 
    f.title AS titulo,
    f.release_year AS año_estreno,
    CONCAT_WS(' ', a.first_name, a.last_name) AS actor
FROM film AS f
JOIN film_actor AS fa USING (film_id)
JOIN actor AS a USING (actor_id)
WHERE UPPER(CONCAT(a.first_name, ' ', a.last_name)) LIKE CONCAT('%', UPPER(@busqueda_actor), '%');


-- 4) Find all the rentals done in the months of May and June. Show the film title, customer name and if it 
-- was returned or not. There should be returned column with two possible values 'Yes' and 'No'.
SELECT 
    f.title AS titulo,
    CONCAT_WS(' ', c.first_name, c.last_name) AS cliente,
    CASE 
        WHEN r.return_date IS NULL THEN 'No'
        ELSE 'Sí'
    END AS devuelto
FROM rental AS r
JOIN inventory AS i USING (inventory_id)
JOIN film AS f USING (film_id)
JOIN customer AS c USING (customer_id)
WHERE MONTH(r.rental_date) IN (5, 6);


-- 5) Investigate CAST and CONVERT functions. Explain the differences if any, write examples based on sakila DB.
-- CAST estándar SQL / CONVERT específico de MySQL
SELECT f.title AS titulo, CAST(f.rating AS CHAR) AS rating_texto
FROM film AS f;

SELECT f.title AS titulo, CONVERT(f.rating, CHAR) AS rating_texto
FROM film AS f;


-- 6) Funciones para manejar valores NULL: IFNULL, COALESCE, etc.
-- IFNULL(valor, reemplazo) → devuelve el reemplazo si el valor es NULL
-- COALESCE(v1, v2, v3...) → devuelve el primer valor no NULL
-- ISNULL() → en MySQL es operador, no función como en SQL Server
-- NVL() → solo en Oracle, en MySQL se reemplaza por IFNULL()

-- Ejemplo con IFNULL:
SELECT 
    f.title AS titulo,
    CONCAT_WS(' ', c.first_name, c.last_name) AS cliente,
    IFNULL(r.return_date, 'No devuelta') AS fecha_devolucion
FROM rental AS r
JOIN inventory AS i USING (inventory_id)
JOIN film AS f USING (film_id)
JOIN customer AS c USING (customer_id);

-- Ejemplo con COALESCE:
SELECT 
    f.title AS titulo,
    CONCAT_WS(' ', c.first_name, c.last_name) AS cliente,
    COALESCE(r.return_date, 'No devuelta') AS fecha_devolucion
FROM rental AS r
JOIN inventory AS i USING (inventory_id)
JOIN film AS f USING (film_id)
JOIN customer AS c USING (customer_id);