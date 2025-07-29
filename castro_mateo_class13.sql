
INSERT INTO customer (store_id, first_name, last_name, email, address_id, active, create_date)
VALUES (
    1,
    'John',
    'Doe',
    'johndoe@example.com',
    (
        SELECT MAX(address_id)
        FROM address
        JOIN city USING (city_id)
        JOIN country USING (country_id)
        WHERE country = 'United States'
    ),
    1,
    NOW()
);


INSERT INTO rental (rental_date, inventory_id, customer_id, staff_id)
VALUES (
    NOW(),
    (
        SELECT MAX(inventory_id)
        FROM inventory
        JOIN film USING (film_id)
        WHERE title LIKE '%película%'
    ),
    (SELECT customer_id FROM customer ORDER BY RAND() LIMIT 1),
    (SELECT staff_id FROM staff WHERE store_id = 2 LIMIT 1)
);


UPDATE film SET release_year = 2001 WHERE rating = 'G';
UPDATE film SET release_year = 2002 WHERE rating = 'PG';
UPDATE film SET release_year = 2003 WHERE rating = 'PG-13';
UPDATE film SET release_year = 2004 WHERE rating = 'R';
UPDATE film SET release_year = 2005 WHERE rating = 'NC-17';


UPDATE rental
SET return_date = NOW()
WHERE rental_id = (
    SELECT rental_id
    FROM (
        SELECT rental_id
        FROM rental
        WHERE return_date IS NULL
        ORDER BY rental_date DESC
        LIMIT 1
    ) AS temp
);


DELETE FROM film_text
WHERE film_id = (SELECT film_id FROM film WHERE title = 'PELÍCULA');

DELETE FROM film_actor
WHERE film_id = (SELECT film_id FROM film WHERE title = 'PELÍCULA');

DELETE FROM film_category
WHERE film_id = (SELECT film_id FROM film WHERE title = 'PELÍCULA');

DELETE FROM inventory
WHERE film_id = (SELECT film_id FROM film WHERE title = 'PELÍCULA');

DELETE FROM film
WHERE title = 'PELÍCULA';


SELECT inventory_id
FROM inventory i
WHERE NOT EXISTS (
    SELECT 1
    FROM rental r
    WHERE r.inventory_id = i.inventory_id AND r.return_date IS NULL
)
LIMIT 1;


INSERT INTO rental (rental_date, inventory_id, customer_id, staff_id)
VALUES (
    NOW(),
    1234,
    (SELECT customer_id FROM customer ORDER BY RAND() LIMIT 1),
    (SELECT staff_id FROM staff ORDER BY RAND() LIMIT 1)
);


INSERT INTO payment (customer_id, staff_id, rental_id, amount, payment_date)
VALUES (
    (SELECT customer_id FROM customer ORDER BY RAND() LIMIT 1),
    (SELECT staff_id FROM staff ORDER BY RAND() LIMIT 1),
    (SELECT MAX(rental_id) FROM rental),
    5.99,
    NOW()
);


