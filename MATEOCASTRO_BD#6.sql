
SELECT last_name, GROUP_CONCAT(CONCAT(first_name, ' ', last_name) ORDER BY first_name SEPARATOR ', ') AS actors
FROM actor
GROUP BY last_name
HAVING COUNT(*) > 1
ORDER BY last_name;

SELECT a.first_name, a.last_name 
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
WHERE fa.actor_id IS NULL;

SELECT c.first_name, c.last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id
HAVING COUNT(DISTINCT r.inventory_id) = 1;

SELECT c.first_name, c.last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id
HAVING COUNT(DISTINCT r.inventory_id) > 1;

SELECT DISTINCT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title IN ('BETRAYED REAR', 'CATCH AMISTAD');

SELECT DISTINCT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title = 'BETRAYED REAR'
AND a.actor_id NOT IN (
  SELECT fa2.actor_id
  FROM film_actor fa2
  JOIN film f2 ON fa2.film_id = f2.film_id
  WHERE f2.title = 'CATCH AMISTAD'
);

SELECT DISTINCT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa1 ON a.actor_id = fa1.actor_id
JOIN film f1 ON fa1.film_id = f1.film_id
JOIN film_actor fa2 ON a.actor_id = fa2.actor_id
JOIN film f2 ON fa2.film_id = f2.film_id
WHERE f1.title = 'BETRAYED REAR' AND f2.title = 'CATCH AMISTAD';

SELECT a.first_name, a.last_name
FROM actor a
WHERE a.actor_id NOT IN (
  SELECT fa.actor_id
  FROM film_actor fa
  JOIN film f ON fa.film_id = f.film_id
  WHERE f.title IN ('BETRAYED REAR', 'CATCH AMISTAD')
);
