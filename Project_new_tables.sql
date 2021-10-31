
Use Campus_Eats_Fall2020;
drop table if exists Menu ;
CREATE TABLE `Menu` (
  `restaurant_id` int(11) NOT NULL,
  `items_id` int(11) NOT NULL ,
  `items` varchar(75) NOT NULL , 
  PRIMARY KEY (`items_id`),
  KEY `fk_M_restaurant_id` (`restaurant_id`),
  CONSTRAINT `fk_M_restaurant_id` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurant`
  (`restaurant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
DROP TABLE IF EXISTS `Item_File`;
CREATE TABLE `Item_File` (
  `order_id` int(11) NOT NULL,
  `items_id` int(11) NOT NULL,
  `quantity` int(100) NOT NULL,
  `special_instructions` varchar(75) DEFAULT NULL,
  KEY `fk_order_id` (`order_id`),
  KEY `fk_items_id` (`items_id`),
  CONSTRAINT `fk_order_id` FOREIGN KEY (`order_id`) REFERENCES `order` 
  (`order_id`),
  CONSTRAINT `fk_items_id` FOREIGN KEY (`items_id`) REFERENCES `Menu`
  (`items_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `Rating`;
CREATE TABLE `Rating` (
  `restaurant_id` int(11) NOT NULL,
  `driver_id` int(11) NOT NULL,
  `rating` int(5) DEFAULT NULL, 
  `picture` blob,
  `comments` varchar(1000),
  KEY `fk_R_restaurant_id` (`restaurant_id`),
  KEY `fk_R_driver_id` (`driver_id`),
  CONSTRAINT `fk_R_restaurant_id` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurant` (`restaurant_id`),
  CONSTRAINT `fk_R_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `driver` (`driver_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
DROP TABLE IF EXISTS `payment`;
CREATE TABLE `payment` (
  `person_id` int(11) NOT NULL,
  `Payment_id` int(11) NOT NULL,
  `Payment_method` varchar(100) NOT NULL,
  `Cardtype` varchar(50) NOT NULL,
  `CardNumber` int(16) NOT NULL,
  `CVV` int(5) NOT NULL, 
  `Name_of_Card` varchar(100) NOT NULL,
  PRIMARY KEY (`Payment_id`),
  KEY `fk_p_person_id` (`person_id`),
  CONSTRAINT `fk_p_person_id` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1; 
DROP TABLE IF EXISTS `invoice`;
CREATE TABLE `invoice` (
  `Payment_id` int(11) NOT NULL,
  `Invoice_id` int(11) NOT NULL,
  `flat fee`   float DEFAULT 5,
  `Tip` float,
  `Total_Cost` float, 
  KEY `fk_Payment_id` (`Payment_id`),
  CONSTRAINT `fk_Payment_id` FOREIGN KEY (`Payment_id`) REFERENCES `payment` (`Payment_id`)
  
) ENGINE=InnoDB DEFAULT CHARSET=latin1;







