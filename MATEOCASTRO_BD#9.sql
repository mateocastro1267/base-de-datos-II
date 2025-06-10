
SELECT co.country_id, co.country, COUNT(ci.city_id) AS city_count
FROM country co
JOIN city ci ON co.country_id = ci.country_id
GROUP BY co.country_id, co.country
ORDER BY co.country_id, co.country;

SELECT co.country_id, co.country, COUNT(ci.city_id) AS city_count
FROM country co
JOIN city ci ON co.country_id = ci.country_id
GROUP BY co.country_id, co.country
HAVING COUNT(ci.city_id) > 10
ORDER BY city_count DESC;

SELECT c.first_name, c.last_name, a.address, 
       COUNT(r.rental_id) AS total_rentals, 
       SUM(p.amount) AS total_spent
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN rental r ON c.customer_id = r.customer_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.customer_id, c.first_name, c.last_name, a.address
ORDER BY total_spent DESC;

SELECT ca.name AS category, AVG(f.length) AS avg_duration
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category ca ON fc.category_id = ca.category_id
GROUP BY ca.name
ORDER BY avg_duration DESC;

SELECT f.title, f.rating, SUM(p.amount) AS total_sales
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY f.film_id, f.title, f.rating
ORDER BY total_sales DESC;
