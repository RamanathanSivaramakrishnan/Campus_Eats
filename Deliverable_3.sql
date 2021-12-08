/* A */
USE campus_eats_fall2020;
DROP PROCEDURE IF EXISTS feature_ratings;
DELIMITER //

CREATE PROCEDURE feature_ratings (IN restaurant_id INT)
BEGIN
 SELECT restaurant_id,MAX(food_quality) AS max_food_quality,MAX(service) AS max_service,MAX(atmosphere) AS max_atmosphere,MAX(affordability) AS max_affordability,
 MIN(food_quality) AS min_food_quality,MIN(service) AS min_service,MIN(atmosphere) AS min_atmosphere,MIN(affordability) AS min_affordability,
 AVG(food_quality) AS avg_food_quality,AVG(service) AS avg_service,AVG(atmosphere) AS avg_atmosphere,AVG(affordability) AS avg_affordability
 FROM restaurant_rating
 WHERE restaurant_id = restaurant_id;
END//
CALL feature_ratings(2);

/* B */
DROP PROCEDURE IF EXISTS count_orders;
DELIMITER //

CREATE PROCEDURE count_orders (IN person_id INT)
BEGIN
 SELECT c.person_id,COUNT(a.order_id) AS total_order,DATE_FORMAT(b.delivery_time, '%Y-%m-%d') AS delivery_time FROM campus_eats_fall2020.order as a 
INNER JOIN campus_eats_fall2020.delivery b ON a.delivery_id=b.delivery_id 
INNER JOIN campus_eats_fall2020.person c ON a.person_id=c.person_id
WHERE  DATE_FORMAT(b.delivery_time, '%Y/%m/%d') BETWEEN '1970/01/11' AND '2017/01/01' AND a.person_id=person_id  GROUP BY c.person_id ;
END//
CALL count_orders(1);

 
/* C */
DROP VIEW IF EXISTS  Totalprice_each_customer;
CREATE VIEW Totalprice_each_customer AS
SELECT p.person_id,ROUND(SUM(o.total_price),2) AS total_price FROM campus_eats_fall2020.order o
INNER JOIN  campus_eats_fall2020.person p    ON o.person_id=p.person_id
INNER JOIN campus_eats_fall2020.delivery d ON o.delivery_id=d.delivery_id 
WHERE  DATE_FORMAT(d.delivery_time, '%Y/%m/%d') BETWEEN '1970/01/11' AND '2017/01/01' GROUP BY o.person_id ;
SELECT  FROM campus_eats_fall2020.Totalprice_each_customer;

/* D */
SELECT restaurant_total_rating
FROM restaurant_rating AS r
INNER JOIN campus_eats_fall2020.order AS o
ON r.order_id = o.order_id
WHERE person_id = 2;

DROP PROCEDURE IF EXISTS customer_rating;
DELIMITER //
/* Using stored procedure*/
CREATE PROCEDURE customer_rating (IN person INT)
BEGIN
SELECT restaurant_total_rating
FROM restaurant_rating AS r
INNER JOIN campus_eats_fall2020.order AS o
ON r.order_id = o.order_id
WHERE person_id = person;
END//

CALL customer_rating(2);

/* E */
DROP VIEW IF EXISTS  Totalprice_each_customer;
CREATE VIEW Totalprice_each_customer AS
SELECT p.person_id,ROUND(SUM(o.total_price),2) AS total_price FROM campus_eats_fall2020.order o
INNER JOIN  campus_eats_fall2020.person p    ON o.person_id=p.person_id
INNER JOIN campus_eats_fall2020.delivery d ON o.delivery_id=d.delivery_id 
WHERE  DATE_FORMAT(d.delivery_time, '%Y/%m/%d') BETWEEN '1970/01/11' AND '2017/01/01' GROUP BY o.person_id ;
SELECT  FROM campus_eats_fall2020.Totalprice_each_customer;

/* F */
CREATE PROCEDURE count_orders (IN person_id INT)
BEGIN
 SELECT c.person_id,COUNT(a.order_id) AS total_order,DATE_FORMAT(b.delivery_time, '%Y-%m-%d') AS delivery_time FROM campus_eats_fall2020.order as a 
INNER JOIN campus_eats_fall2020.delivery b ON a.delivery_id=b.delivery_id 
INNER JOIN campus_eats_fall2020.person c ON a.person_id=c.person_id
WHERE  DATE_FORMAT(b.delivery_time, '%Y/%m/%d') BETWEEN '1970/01/11' AND '2017/01/01' AND a.person_id=person_id  GROUP BY c.person_id ;
END//
CALL count_orders(1);