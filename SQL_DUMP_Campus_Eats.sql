-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema campus_eats_fall
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema campus_eats_fall
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `campus_eats_fall` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `campus_eats_fall` ;

-- -----------------------------------------------------
-- Table `campus_eats_fall`.`person`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `campus_eats_fall`.`person` (
  `person_id` INT NOT NULL AUTO_INCREMENT,
  `person_name` VARCHAR(300) NULL DEFAULT NULL,
  `person_email` VARCHAR(150) NULL DEFAULT NULL,
  `cell` BIGINT NULL DEFAULT NULL,
  PRIMARY KEY (`person_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 206
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `campus_eats_fall`.`student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `campus_eats_fall`.`student` (
  `student_id` INT NOT NULL AUTO_INCREMENT,
  `person_id` INT NOT NULL,
  `graduation_year` INT NULL DEFAULT NULL,
  `major` VARCHAR(75) NULL DEFAULT NULL,
  `type` VARCHAR(75) NULL DEFAULT NULL,
  PRIMARY KEY (`student_id`),
  INDEX `fk_St_person_id` (`person_id` ASC) VISIBLE,
  CONSTRAINT `fk_St_person_id`
    FOREIGN KEY (`person_id`)
    REFERENCES `campus_eats_fall`.`person` (`person_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 152
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `campus_eats_fall`.`driver`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `campus_eats_fall`.`driver` (
  `driver_id` INT NOT NULL AUTO_INCREMENT,
  `student_id` INT NOT NULL,
  `license_number` VARCHAR(75) NULL DEFAULT NULL,
  `date_hired` DATE NULL DEFAULT NULL,
  `rating` FLOAT NULL DEFAULT NULL,
  PRIMARY KEY (`driver_id`),
  INDEX `fk_D_student_id` (`student_id` ASC) VISIBLE,
  CONSTRAINT `fk_D_student_id`
    FOREIGN KEY (`student_id`)
    REFERENCES `campus_eats_fall`.`student` (`student_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `campus_eats_fall`.`vehicle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `campus_eats_fall`.`vehicle` (
  `vehicle_id` INT NOT NULL AUTO_INCREMENT,
  `vehicle_plate` VARCHAR(75) NULL DEFAULT NULL,
  `model` VARCHAR(75) NULL DEFAULT NULL,
  `make` VARCHAR(75) NULL DEFAULT NULL,
  PRIMARY KEY (`vehicle_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 21
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `campus_eats_fall`.`delivery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `campus_eats_fall`.`delivery` (
  `delivery_id` INT NOT NULL AUTO_INCREMENT,
  `driver_id` INT NOT NULL,
  `vehicle_id` INT NOT NULL,
  `delivery_time` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`delivery_id`),
  INDEX `fk_delivery_driver_id` (`driver_id` ASC) VISIBLE,
  INDEX `fk_delivery_vehicle_id` (`vehicle_id` ASC) VISIBLE,
  CONSTRAINT `fk_delivery_driver_id`
    FOREIGN KEY (`driver_id`)
    REFERENCES `campus_eats_fall`.`driver` (`driver_id`),
  CONSTRAINT `fk_delivery_vehicle_id`
    FOREIGN KEY (`vehicle_id`)
    REFERENCES `campus_eats_fall`.`vehicle` (`vehicle_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 102
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `campus_eats_fall`.`faculty`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `campus_eats_fall`.`faculty` (
  `faculty_id` INT NOT NULL AUTO_INCREMENT,
  `person_id` INT NOT NULL,
  `title` VARCHAR(75) NULL DEFAULT NULL,
  `degree_college` VARCHAR(75) NULL DEFAULT NULL,
  `highest_degree` VARCHAR(75) NULL DEFAULT NULL,
  PRIMARY KEY (`faculty_id`),
  INDEX `fk_F_person_id` (`person_id` ASC) VISIBLE,
  CONSTRAINT `fk_F_person_id`
    FOREIGN KEY (`person_id`)
    REFERENCES `campus_eats_fall`.`person` (`person_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 27
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `campus_eats_fall`.`location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `campus_eats_fall`.`location` (
  `location_id` INT NOT NULL AUTO_INCREMENT,
  `location_name` VARCHAR(75) NULL DEFAULT NULL,
  `location_address` VARCHAR(75) NULL DEFAULT NULL,
  `latitude` VARCHAR(75) NULL DEFAULT NULL,
  `longitude` VARCHAR(75) NULL DEFAULT NULL,
  `drop_off_point` VARCHAR(75) NULL DEFAULT NULL,
  PRIMARY KEY (`location_id`),
  UNIQUE INDEX `location_index_desc` (`location_id` DESC) VISIBLE,
  INDEX `idx_location_location_name` (`location_name` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 101
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `campus_eats_fall`.`restaurant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `campus_eats_fall`.`restaurant` (
  `restaurant_id` INT NOT NULL AUTO_INCREMENT,
  `location` VARCHAR(75) NULL DEFAULT NULL,
  `restaurant_name` VARCHAR(75) NULL DEFAULT NULL,
  `schedule` VARCHAR(75) NULL DEFAULT NULL,
  `website` VARCHAR(75) NULL DEFAULT NULL,
  PRIMARY KEY (`restaurant_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 101
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `campus_eats_fall`.`order`
-- -----------------------------------------------------
--
DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) NOT NULL,
  `delivery_id` int(11) NOT NULL,
  `location_id` int(11) NOT NULL,
  `driver_id` int(11) NOT NULL,
  `restaurant_id` int(11) NOT NULL,
  `total_price` float NOT NULL,
  `delivery_charge` float DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `fk_O_person_id` (`person_id`),
  KEY `fk_O_delivery_id` (`delivery_id`),
  KEY `fk_O_location_id` (`location_id`),
  KEY `fk_O_driver_id` (`driver_id`),
  KEY `fk_O_restaurant_id` (`restaurant_id`),
  CONSTRAINT `fk_O_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `delivery` 
(`delivery_id`),
  CONSTRAINT `fk_O_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `driver` 
(`driver_id`),
  CONSTRAINT `fk_O_location_id` FOREIGN KEY (`location_id`) REFERENCES `location` 
(`location_id`),
  CONSTRAINT `fk_O_person_id` FOREIGN KEY (`person_id`) REFERENCES `person` 
(`person_id`),
  CONSTRAINT `fk_O_restaurant_id` FOREIGN KEY (`restaurant_id`) REFERENCES 
`restaurant` (`restaurant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
--
-- Dumping data for table `order`

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (1,1,1,1,1,1,15.63,6.63),(2,2,2,2,2,2,18.03,9.43),
(3,3,3,3,3,3,11.91,7.42),(4,4,4,4,4,4,19.13,6.26),(5,5,5,5,5,5,13.76,6.24),
(6,6,6,6,6,6,5.4,4.83),(7,7,7,7,7,7,14.05,8.57),(8,8,8,8,8,8,3.81,2.38),
(9,9,9,9,1,9,17.1,6.72),(10,10,10,10,2,10,12.71,1.82),(11,11,11,11,3,11,3.9,7.26),
(12,12,12,12,4,12,6.82,7.4),(13,13,13,13,5,13,4.73,7.43),
(14,14,14,14,6,14,12.08,1.21),(15,15,15,15,7,15,3.83,4.77),
(16,16,16,16,8,16,12.43,2.76),(17,17,17,17,1,17,6.61,4.85),
(18,18,18,18,2,18,7.89,5.69),(19,19,19,19,3,19,16.54,4.88),
(20,20,20,20,4,20,3.21,4.98),(21,21,21,21,5,21,5.19,4.17),
(22,22,22,22,6,22,19,1.39),(23,23,23,23,7,23,14.5,3.28),
(24,24,24,24,8,24,11.81,2.71),(25,25,25,25,1,25,6.83,4.85),
(26,26,26,26,2,26,7.24,5.65),(27,27,27,27,3,27,10.56,1.73),
(28,28,28,28,4,28,4.25,4.98),(29,29,29,29,5,29,6.68,8.66),
(30,30,30,30,6,30,14.5,6.47),(31,31,31,31,7,31,14.92,9.53),
(32,32,32,32,8,32,4.12,9.42),(33,33,33,33,1,33,7.02,7.99),
(34,34,34,34,2,34,8.6,6.69),(35,35,35,35,3,35,8.98,4.72),
(36,36,36,36,4,36,7.94,4.78),(37,37,37,37,5,37,14.8,2.13),
(38,38,38,38,6,38,19.05,6.61),(39,39,39,39,7,39,12.49,5.97),
(40,40,40,40,8,40,15.56,6.01),(41,41,41,41,1,41,8.85,7.06),
(42,42,42,42,2,42,12.28,5.52),(43,43,43,43,3,43,9.28,9.63),
(44,44,44,44,4,44,9.78,8),(45,45,45,45,5,45,12.43,5.11),
(46,46,46,46,6,46,4.11,9.65),(47,47,47,47,7,47,14.29,6.65),
(48,48,48,48,8,48,5.69,3.31),(49,49,49,49,1,49,12.52,6.38),
(50,50,50,50,2,50,8.84,9.92),(51,51,51,51,3,51,5.69,1.5),
(52,52,52,52,4,52,14.53,4.58),(53,53,53,53,5,53,10.23,3.61),
(54,54,54,54,6,54,10.7,7.36),(55,55,55,55,7,55,14.03,8.66),
(56,56,56,56,8,56,13.46,1.26),(57,57,57,57,1,57,13.98,8.85),
(58,58,58,58,2,58,15.21,6.59),(59,59,59,59,3,59,4.6,8.25),
(60,60,60,60,4,60,3.27,6.39),(61,61,61,61,5,61,9.39,2.63),
(62,62,62,62,6,62,3.7,2.47),(63,63,63,63,7,63,18.49,7.01),
(64,64,64,64,8,64,15.51,8.26),(65,65,65,65,1,65,6.8,9.41),
(66,66,66,66,2,66,12.57,1.88),(67,67,67,67,3,67,8.69,6.21),
(68,68,68,68,4,68,9.38,9.56),(69,69,69,69,5,69,18.23,3.89),
(70,70,70,70,6,70,13.39,9.65),(71,71,71,71,7,71,17.71,3.01),
(72,72,72,72,8,72,10.59,2.03),(73,73,73,73,1,73,6.99,9.8),
(74,74,74,74,2,74,14.14,3.98),(75,75,75,75,3,75,16.73,7.27),
(76,76,76,76,4,76,6.64,5.09),(77,77,77,77,5,77,16.48,1.15),
(78,78,78,78,6,78,18.61,6.49),(79,79,79,79,7,79,18.66,8.19),
(80,80,80,80,8,80,7.6,9.54),(81,81,81,81,1,81,16.72,4.05),
(82,82,82,82,2,82,5.64,7.18),(83,83,83,83,3,83,7.39,9.14),
(84,84,84,84,4,84,11.61,1.57),(85,85,85,85,5,85,16.74,8.84),
(86,86,86,86,6,86,19.88,2.43),(87,87,87,87,7,87,7.52,4.32),
(88,88,88,88,8,88,14.63,4.4),(89,89,89,89,1,89,19.45,9.89),
(90,90,90,90,2,90,12.5,8.23),(91,91,91,91,3,91,10.34,3.69),
(92,92,92,92,4,92,11.34,6.34),(93,93,93,93,5,93,15.05,8.26),
(94,94,94,94,6,94,7.89,7.05),(95,95,95,95,7,95,16.69,9.19),
(96,96,96,96,8,96,5.71,8.39),(97,97,97,97,1,97,16.9,9.15),
(98,98,98,98,2,98,15.63,8.92),(99,99,99,99,3,99,3.71,2.53),
(100,100,100,100,4,100,5.08,2.74),(101,1,2,3,4,5,6,1);
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

-- -----------------------------------------------------
-- Table `campus_eats_fall`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `campus_eats_fall`.`staff` (
  `staff_id` INT NOT NULL AUTO_INCREMENT,
  `person_id` INT NULL DEFAULT NULL,
  `position` VARCHAR(75) NULL DEFAULT NULL,
  `is_admin` VARCHAR(1) NULL DEFAULT 'N',
  PRIMARY KEY (`staff_id`),
  INDEX `fk_S_person_id` (`person_id` ASC) VISIBLE,
  CONSTRAINT `fk_S_person_id`
    FOREIGN KEY (`person_id`)
    REFERENCES `campus_eats_fall`.`person` (`person_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 26
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `campus_eats_fall`.`menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `campus_eats_fall`.`menu` (
  `item_id` INT NOT NULL,
  `price` FLOAT NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `restaurant_id` INT NOT NULL,
  PRIMARY KEY (`item_id`, `restaurant_id`),
  INDEX `fk_menu_restaurant1_idx` (`restaurant_id` ASC) VISIBLE,
  CONSTRAINT `fk_menu_restaurant1`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `campus_eats_fall`.`restaurant` (`restaurant_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `campus_eats_fall`.`ordered_items`
-- -----------------------------------------------------

drop table if exists ordered_items;
CREATE TABLE `ordered_items` (
  `item_id` int NOT NULL,
  `order_id` int NOT NULL,
  `quantity` int NOT NULL,
  `special_instruction` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`item_id`,`order_id`),
  KEY `fk_menu_has_order_order1_idx` (`order_id`),
  KEY `fk_menu_has_order_menu1_idx` (`item_id`),
  CONSTRAINT `fk_menu_has_order_menu1` FOREIGN KEY (`item_id`) REFERENCES `menu` (`item_id`),
  CONSTRAINT `fk_menu_has_order_order1` FOREIGN KEY (`order_id`) REFERENCES `order` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- -----------------------------------------------------
-- Table `campus_eats_fall`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `campus_eats_fall`.`payment` (
  `payment_id` INT NOT NULL,
  `payment_method` VARCHAR(100) NOT NULL,
  `card_type` VARCHAR(45) NOT NULL,
  `card_number` VARCHAR(20) NOT NULL,
  `CVV` VARCHAR(3) NOT NULL,
  `name_on_card` VARCHAR(100) NOT NULL,
  `order_order_id` INT NOT NULL,
  PRIMARY KEY (`payment_id`),
  INDEX `fk_payment_order1_idx` (`order_order_id` ASC) VISIBLE,
  CONSTRAINT `fk_payment_order1`
    FOREIGN KEY (`order_order_id`)
    REFERENCES `campus_eats_fall`.`order` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `campus_eats_fall`.`invoice`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `campus_eats_fall`.`invoice` (
  `invoice_id` INT NOT NULL,
  `tip_driver` FLOAT NULL DEFAULT 0,
  `payment_payment_id` INT NOT NULL,
  PRIMARY KEY (`invoice_id`),
  INDEX `fk_invoice_payment1_idx` (`payment_payment_id` ASC) VISIBLE,
  CONSTRAINT `fk_invoice_payment1`
    FOREIGN KEY (`payment_payment_id`)
    REFERENCES `campus_eats_fall`.`payment` (`payment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `campus_eats_fall` ;

-- -----------------------------------------------------
-- procedure add_person
-- -----------------------------------------------------

DELIMITER $$
USE `campus_eats_fall`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_person`(in person_name varchar(300), in email varchar(150), cellno bigint (15), person_type varchar(10))
BEGIN
insert into person (person_name, person_email, cell) values(person_name, email, cellno);
if(person_type = 'student') then
insert into student (person_id, graduation_year, major, type) values 
((select person_id from person where cell = cellno), 2019, 'Computer Science', 'Graduate');
elseif(person_type = 'faculty') then
insert into faculty (person_id, title, degree_college, highest_degree) values 
((select person_id from person where cell = cellno), 'Assistant Professor', 'UCLA', 'PhD');
elseif(person_type = 'staff') then
insert into student (person_id, position, is_admin) values 
((select person_id from person where cell = cellno), 'Bus Driver', 'N');
end if;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure proc_restaurants
-- -----------------------------------------------------

DELIMITER $$
USE `campus_eats_fall`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_restaurants`(IN person_no INT)
BEGIN
	SELECT restaurant_name
    FROM campus_eats_fall.order AS o
    INNER JOIN restaurant AS r
    ON o.restaurant_id = r.restaurant_id
    WHERE person_id = person_no;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure proc_total_deliveries
-- -----------------------------------------------------

DELIMITER $$
USE `campus_eats_fall`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_total_deliveries`(IN driver_no INT, OUT total_deliveries INT)
BEGIN
	SELECT COUNT(*) INTO total_deliveries
    FROM delivery
    WHERE driver_id = driver_no;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sample
-- -----------------------------------------------------

DELIMITER $$
USE `campus_eats_fall`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sample`()
BEGIN
	SELECT * FROM driver LIMIT 10;
END$$

DELIMITER ;
USE `campus_eats_fall`;

DELIMITER $$
USE `campus_eats_fall`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `campus_eats_fall`.`order_AFTER_INSERT`
AFTER INSERT ON `campus_eats_fall`.`order`
FOR EACH ROW
BEGIN
	insert into niner_eats.delivery (driver_id, vehicle_id) values(new.driver_id, 2);
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
-- MENU TABLE INSERTION HAS BEEN DONE
SET FOREIGN_KEY_CHECKS=0;
INSERT INTO menu values(1,20,'thin crepe','Dosa',2),
(2,45,'rice cakse','Idly',1),
(3,23,'crepe','Vada',1),
(4,45,'bread','Paratha',2),
(5,78,'Wheat Bread','Roti',2),
(6,89,'Maida Bread','Naan',2),
(7,78,'lentil Soup','Sambar',3),
(8,34,'Pepper Soup','Rasam',3),
(9,56,'BreakFast meal','Poha',3),
(10,45,'Desert','Curd',4),
(11,30,'Bun','Bun',4),
(12,20,'thin crepe','Cake',4),
(13,20,'thin crepe','Dosa',5),
(14,68,'thin crepe','Badushah',5),
(15,70,'thin crepe','Sweet',5),
(16,10,'thin crepe','Burrito',6),
(17,40,'thin crepe','Ice Cream',6),
(18,60,'thin crepe','Crispy Chicken',6),
(19,40,'thin crepe','Pizza',6)
;
-- ---------------------------------------
-- PAYMENT TABLE INSERTION HAS BEEN DONE
SET FOREIGN_KEY_CHECKS=0;
INSERT INTO payment VALUES(1, 'card', 'credit', 123, 789, 'smith', 2),
 (2, 'card', 'credit', 937, 889, 'will', 3),
 (3, 'card', 'credit', 163, 233, 'shilpa', 4),
 (4, 'card', 'debit', 573, 667, 'swetha', 5),
 (5, 'card', 'credit', 185, 709, 'sara', 6),
 (6, 'card', 'debit', 122, 988, 'sam', 7),
 (7, 'card', 'credit', 127, 233, 'ram', 8),
 (8, 'card', 'credit', 956, 776, 'macy', 9),
 (9, 'card', 'debit', 753, 557, 'john', 10),
 (10, 'card', 'debit', 536, 899, 'varun', 1),
 (11, 'card', 'credit', 856, 334, 'tarun', 12),
 (12, 'card', 'debit', 986, 776, 'karan', 13),
 (13, 'card', 'debit', 673, 566, 'teja', 14),
 (14, 'card', 'credit', 934, 722, 'ash', 15),
 (15, 'card', 'debit', 908, 226, 'green', 16),
 (16, 'card', 'credit', 469, 759, 'charlotte', 1);
 
 ---------------------------------------------------

-- INVOICE TABLE HAS BEEN INSERTED
INSERT INTO invoice VALUES( 1,1,1),
(2,5,2),
(3,4,3),
(4,4,4),
(5,3,5),
(6,2,6),
(7,6,7),
(8,5,8),
(9,4,9),
(10,2,10),
(11,3,11),
(12,3,12),
(13,7,13),
(14,5,14),
(15,4,15);
 -- ---------------------------------------------
 -- ORDERED_ITEMS TABLE HAS BEEN INSERTED
 
INSERT INTO ordered_items (item_id, order_id, quantity) VALUES(1,2,3),
(2,3,1),
(3,4,1),
(4,5,2),
(5,6,1),
(6,7,1),
(7,8,2),
(8,9,3),
(9,10,1),
(10,11,1),
(11,12,1),
(12,13,1),
(13,14,1),
(14,1,2);

-- -----------------------------------
 use campus_eats_fall;
 drop table IF  EXISTS restaurant_rating;
CREATE TABLE `campus_eats_fall`.`restaurant_rating` (
  `restaurant_id` INT NOT NULL,
  `order_id` INT NOT NULL,
  `food_quality` INT NOT NULL,
  `service` INT NOT NULL,
  `atmosphere` INT NOT NULL,
  `affordability` INT NOT NULL,
  `restaurant_total_rating` FLOAT NOT NULL,
   INDEX `order_id_rating_UNIQUE` (`order_id` ASC) VISIBLE,
   INDEX `restaurant_id_rating_UNIQUE` (`restaurant_id` ASC) INVISIBLE,
  CONSTRAINT `fk_order_id_ratings`
    FOREIGN KEY (`order_id`)
    REFERENCES `campus_eats_fall`.`order` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_restaurant_id_ratings`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `campus_eats_fall`.`restaurant` (`restaurant_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

drop table IF  EXISTS driver_rating;
CREATE TABLE `campus_eats_fall`.`driver_rating` (
`driver_id` INT NOT NULL,
  `order_id` INT NOT NULL,
  `rating` INT NOT NULL,

   INDEX `order_id_rating_UNIQUE` (`order_id` ASC) VISIBLE,
   INDEX `driver_id_rating_UNIQUE` (`driver_id` ASC) INVISIBLE,
  CONSTRAINT `fk_order_id_rating`
    FOREIGN KEY (`order_id`)
    REFERENCES `campus_eats_fall`.`order` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_driver_id_rating`
    FOREIGN KEY (`driver_id`)
    REFERENCES `campus_eats_fall`.`driver` (`driver_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
    
SET FOREIGN_KEY_CHECKS=0;    

INSERT INTO driver_rating (rating, driver_id, order_id) VALUES 
(4,1,2),
(5,2,3),
(3,3,4),
(5,4,5),
(5,5,6),
(4,6,7),
(4,7,8),
(3,8,9),
(2,9,10),
(5,10,11),
(5,11,12),
(4,12,13),
(3,13,14);
SET FOREIGN_KEY_CHECKS=0;
 INSERT INTO restaurant_rating (food_quality, service, atmosphere, affordability, restaurant_total_rating, restaurant_id, order_id) VALUES
(3,2,4,3,3,2,1),
(3,3,5,5,4,3,2),
(4,5,4,5,4.5,2,3),
(4,4,4,4,4,3,4),
(3,5,5,3,4,3,5),
(4,2,4,2,3,3,6),
(2,4,2,4,3,4,7),
(3,3,3,3,3,4,8),
(5,5,3,3,4,5,9),
(3,3,5,5,3,1,10),
(2,2,4,4,3,5,11),
(3,5,5,3,4,6,12),
(5,5,5,5,5,4,13),
(2,2,4,4,3,1,14);