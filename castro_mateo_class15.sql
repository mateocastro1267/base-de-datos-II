
CREATE OR REPLACE VIEW list_of_customers AS
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    a.address,
    a.postal_code,
    a.phone,
    ci.city,
    co.country,
    CASE 
        WHEN c.active = 1 THEN 'activa'
        ELSE 'inactiva'
    END AS estado,
    c.store_id
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;


CREATE OR REPLACE VIEW film_details AS
SELECT 
    f.film_id,
    f.title,
    f.description,
    c.name AS category,
    f.rental_rate AS precio,
    f.length AS duracion,
    f.rating,
    GROUP_CONCAT(CONCAT(a.first_name, ' ', a.last_name) SEPARATOR ', ') AS actores
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id
GROUP BY f.film_id;


CREATE OR REPLACE VIEW sales_by_film_category AS
SELECT 
    c.name AS categoria,
    SUM(p.amount) AS total_alquiler
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name;


CREATE OR REPLACE VIEW actor_information AS
SELECT 
    a.actor_id,
    a.first_name,
    a.last_name,
    COUNT(fa.film_id) AS cantidad_peliculas
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id;

--5.
-- La vista actor_info agrupa los datos de los actores junto con sus películas.
-- Se usa LEFT JOIN para incluir actores sin películas.
-- GROUP_CONCAT junta los títulos en una sola cadena por actor.


CREATE OR REPLACE VIEW actor_info AS
SELECT
    a.actor_id,
    a.first_name,
    a.last_name,
    GROUP_CONCAT(DISTINCT f.title ORDER BY f.title SEPARATOR ', ') AS film_info
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
LEFT JOIN film f ON fa.film_id = f.film_id
GROUP BY a.actor_id;

-- 6. 
-- Una vista materializada guarda físicamente el resultado de una consulta
-- Se usa para mejorar rendimiento en consultas complejas o de agregación
-- Se actualizan manualmente o de forma programada
-- No existen directamente en MySQL, pero sí en:
-- - PostgreSQL: CREATE MATERIALIZED VIEW
-- - Oracle
-- - BigQuery
-- - SQL Server (Indexed Views)
-- Alternativas en MySQL:
-- - Crear tablas resumen actualizadas por triggers o eventos programados.

