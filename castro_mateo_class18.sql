
#1)
DELIMITER //
CREATE PROCEDURE GetAllProducts()
BEGIN
   SELECT * FROM products;
END //
DELIMITER ;

CALL GetAllProducts();

#2) 

DELIMITER //
CREATE PROCEDURE CountProducts()
BEGIN
   DECLARE total_products INT DEFAULT 0;

   SELECT COUNT(*) INTO total_products
   FROM products;

   SELECT total_products AS total;
END //
DELIMITER ;
CALL CountProducts();


#3) 

DELIMITER //
CREATE PROCEDURE GetOfficeByCountry(IN countryName VARCHAR(255))
BEGIN
   SELECT *
   FROM offices
   WHERE country = countryName;
END //
DELIMITER ;

CALL GetOfficeByCountry('USA');
CALL GetOfficeByCountry('France');

#4)

DELIMITER //
CREATE PROCEDURE CountOrderByStatus(
   IN orderStatus VARCHAR(25),
   OUT total INT
)
BEGIN
   SELECT COUNT(orderNumber)
   INTO total
   FROM orders
   WHERE status = orderStatus;
END //
DELIMITER ;
CALL CountOrderByStatus('Shipped', @total);
SELECT @total AS total_shipped;
CALL CountOrderByStatus('In Process', @total);
SELECT @total AS total_in_process;

#5)

DELIMITER //
CREATE PROCEDURE set_counter(INOUT counter INT, IN inc INT)
BEGIN
   SET counter = counter + inc;
END //
DELIMITER ;

-- ej
SET @c = 1;
CALL set_counter(@c, 1);   -- @c = 2
CALL set_counter(@c, 1);   -- @c = 3
CALL set_counter(@c, 5);   -- @c = 8
SELECT @c AS final_counter;

