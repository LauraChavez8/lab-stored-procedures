USE sakila;

DELIMITER //
CREATE PROCEDURE customer_rent()
BEGIN
	SELECT DISTINCT c.first_name, c.last_name, c.email FROM customer c
	JOIN rental r ON c.customer_id = r.customer_id
	JOIN inventory i ON r.inventory_id = i.inventory_id
	JOIN film_category f ON i.film_id = f.film_id
	JOIN category t ON t.category_id = f.category_id
	WHERE t.name = 'Action';
END //
DELIMITER ;

CALL customer_rent();

DELIMITER //
CREATE PROCEDURE customer_rent_category(IN category VARCHAR(255))
BEGIN
	SELECT DISTINCT c.first_name, c.last_name, c.email FROM customer c
	JOIN rental r ON c.customer_id = r.customer_id
	JOIN inventory i ON r.inventory_id = i.inventory_id
	JOIN film_category f ON i.film_id = f.film_id
	JOIN category t ON t.category_id = f.category_id
	WHERE t.name = category;
END //
DELIMITER ;

CALL customer_rent_category('action');

CALL customer_rent_category('animation');

CALL customer_rent_category('children');

CALL customer_rent_category('classics');

SELECT t.name, COUNT(f.film_id) AS Total FROM film_category f
JOIN category t ON t.category_id = f.category_id
GROUP BY t.name;

DROP PROCEDURE IF EXISTS number_rent_category;
DELIMITER //
CREATE PROCEDURE number_rent_category(IN num_movie INT)
BEGIN
	SELECT t.name, COUNT(f.film_id) FROM film_category f
	JOIN category t ON t.category_id = f.category_id
    GROUP BY t.name
    HAVING COUNT(f.film_id) > num_movie;
END //
DELIMITER ;

CALL number_rent_category(64)