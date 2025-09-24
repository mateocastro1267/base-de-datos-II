
SET profiling = 1;

-- 1
SELECT address_id, address, district, postal_code
FROM address
WHERE postal_code IN ('52137', '83579', '17886');

-- 2
SELECT address_id, address, district, postal_code
FROM address
WHERE postal_code NOT IN ('52137', '83579');

-- 3
SELECT a.address_id, a.address, a.postal_code, c.city, co.country
FROM address a
JOIN city c ON a.city_id = c.city_id
JOIN country co ON c.country_id = co.country_id
WHERE a.postal_code = '52137';

SHOW PROFILES;

-- Crear índice en postal_code
CREATE INDEX idx_postal_code ON address(postal_code);

-- Repetir queries para comparar tiempos
SELECT address_id, address, district, postal_code
FROM address
WHERE postal_code IN ('52137', '83579', '17886');

SELECT address_id, address, district, postal_code
FROM address
WHERE postal_code NOT IN ('52137', '83579');

SELECT a.address_id, a.address, a.postal_code, c.city, co.country
FROM address a
JOIN city c ON a.city_id = c.city_id
JOIN country co ON c.country_id = co.country_id
WHERE a.postal_code = '52137';

SHOW PROFILES;

-- EXPLICACION:
-- Antes del índice: se realiza un FULL TABLE SCAN.
-- Después del índice: se realiza un INDEX LOOKUP más eficiente.
-- La mejora es mayor en tablas grandes y con columnas muy selectivas.



SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'NICK';


SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name = 'WAHLBERG';

-- Crear índices para optimizar
CREATE INDEX idx_actor_first_name ON actor(first_name);
CREATE INDEX idx_actor_last_name ON actor(last_name);


SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'NICK';

SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name = 'WAHLBERG';

-- EXPLICACION:
-- - Sin índices: ambas búsquedas hacen FULL TABLE SCAN.
-- - Con índices: MySQL puede usar INDEX SCAN.
-- - Diferencia: last_name suele ser más selectivo que first_name,
--   entonces el índice en last_name es más útil.



SELECT film_id, title, description
FROM film
WHERE description LIKE '%Documentary%';


SELECT film_id, title, description
FROM film_text
WHERE MATCH(description) AGAINST('Documentary');

-- EXPLICACION:
-- - LIKE '%texto%': no usa índices → lento, escanea toda la tabla.
-- - MATCH ... AGAINST: usa índice FULLTEXT → rápido y eficiente.
-- - Además MATCH devuelve relevancia (ranking de coincidencia).

/*
   CONCLUSION 

1 Índices normales (B-TREE): aceleran búsquedas exactas (=, IN, BETWEEN).
2 Índices FULLTEXT: especializados en búsquedas de texto (palabras).
3 Los índices consumen espacio y ralentizan un poco los INSERT/UPDATE/DELETE,
   pero aceleran muchísimo los SELECT.
4 La selectividad de la columna es clave: a mayor variedad de valores,
   más útil es el índice.
*/
