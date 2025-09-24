

#1)
DROP USER IF EXISTS 'data_analyst'@'localhost';
CREATE USER 'data_analyst'@'localhost' IDENTIFIED BY 'password123';

#2)
GRANT SELECT, UPDATE, DELETE ON sakila.* TO 'data_analyst'@'localhost';

SHOW GRANTS FOR 'data_analyst'@'localhost';


#3) 
-- Ejecutar como data_analyst:
CREATE TABLE prueba (id INT PRIMARY KEY, nombre VARCHAR(50));

#4) 
-- Ejecutar como data_analyst:
UPDATE sakila.film
SET title = 'NEW MOVIE TITLE'
WHERE film_id = 1;

-- Verificar el cambio
SELECT film_id, title FROM sakila.film WHERE film_id = 1;

# 5) 
REVOKE UPDATE ON sakila.* FROM 'data_analyst'@'localhost';


SHOW GRANTS FOR 'data_analyst'@'localhost';


#6) 
UPDATE sakila.film
SET title = 'ANOTHER TITLE'
WHERE film_id = 1;


