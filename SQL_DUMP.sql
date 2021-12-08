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
CREATE TABLE IF NOT EXISTS `campus_eats_fall`.`order` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `person_id` INT NOT NULL,
  `delivery_id` INT NOT NULL,
  `location_id` INT NOT NULL,
  `driver_id` INT NOT NULL,
  `restaurant_id` INT NOT NULL,
  `total_price` FLOAT NOT NULL,
  `delivery_charge` FLOAT NOT NULL DEFAULT 5,
  `ordered_date_time` DATETIME NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `fk_O_person_id` (`person_id` ASC) VISIBLE,
  INDEX `fk_O_delivery_id` (`delivery_id` ASC) VISIBLE,
  INDEX `fk_O_location_id` (`location_id` ASC) VISIBLE,
  INDEX `fk_O_driver_id` (`driver_id` ASC) VISIBLE,
  INDEX `fk_O_restaurant_id` (`restaurant_id` ASC) VISIBLE,
  CONSTRAINT `fk_O_delivery_id`
    FOREIGN KEY (`delivery_id`)
    REFERENCES `campus_eats_fall`.`delivery` (`delivery_id`),
  CONSTRAINT `fk_O_driver_id`
    FOREIGN KEY (`driver_id`)
    REFERENCES `campus_eats_fall`.`driver` (`driver_id`),
  CONSTRAINT `fk_O_location_id`
    FOREIGN KEY (`location_id`)
    REFERENCES `campus_eats_fall`.`location` (`location_id`),
  CONSTRAINT `fk_O_person_id`
    FOREIGN KEY (`person_id`)
    REFERENCES `campus_eats_fall`.`person` (`person_id`),
  CONSTRAINT `fk_O_restaurant_id`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `campus_eats_fall`.`restaurant` (`restaurant_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 102
DEFAULT CHARACTER SET = latin1;


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