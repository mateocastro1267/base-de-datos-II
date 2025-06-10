-- 
SELECT title, rating
  FROM film
 WHERE length = (SELECT MIN(length) FROM film);

-- 
SELECT title
  FROM film
 WHERE length = (SELECT MIN(length) FROM film)
GROUP BY title
HAVING COUNT(*) = 1;

-- 
SELECT c.customer_id, c.first_name, c.last_name,
       a.address, MIN(p.amount) AS lowest_payment
  FROM customer c
  JOIN address a ON c.address_id = a.address_id
  JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, a.address;

-- 
SELECT c.customer_id, c.first_name, c.last_name,
       a.address, p.amount AS lowest_payment
  FROM customer c
  JOIN address a ON c.address_id = a.address_id
  JOIN payment p ON c.customer_id = p.customer_id
 WHERE p.amount <= ALL (
       SELECT p2.amount
         FROM payment p2
        WHERE p2.customer_id = c.customer_id
      );

--
SELECT c.customer_id, c.first_name, c.last_name,
       (SELECT MAX(p.amount)
          FROM payment p
         WHERE p.customer_id = c.customer_id) AS max_payment,
       (SELECT MIN(p.amount)
          FROM payment p
         WHERE p.customer_id = c.customer_id) AS min_payment
  FROM customer c;