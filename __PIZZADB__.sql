CREATE DATABASE IF NOT EXISTS `pizzadb`;
USE `pizzadb`;

-- Table structure for table `crusttypes`
DROP TABLE IF EXISTS `crusttypes`;
CREATE TABLE `crusttypes` (
  `crustTypeId` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`crustTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Data for table `crusttypes`
LOCK TABLES `crusttypes` WRITE;
INSERT INTO `crusttypes` VALUES (1,'Ezekiel'),(2,'Original'),(3,'Gluten Free'),(6,'Whole Wheat'),(7,'Stuffed'),(8,'Thin');
UNLOCK TABLES;

-- Table structure for table `customer`
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `customerid` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(45) NOT NULL,
  `lastName` varchar(45) NOT NULL,
  `phoneNumber` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `houseNumber` int(11) DEFAULT NULL,
  `street` varchar(45) DEFAULT NULL,
  `province` varchar(2) DEFAULT NULL,
  `postalCode` varchar(7) DEFAULT NULL,
  PRIMARY KEY (`customerid`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;


-- Table structure for table `employee`
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee` (
  `employeeid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`employeeid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Data for table `employee` (INTENTIONAL PLAIN TEXT PASSWORD FOR DEMO PURPOSES)
LOCK TABLES `employee` WRITE;
INSERT INTO `employee` VALUES (1,'admin','12345');
UNLOCK TABLES;

-- Table structure for table `orders`
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `orderId` int(11) NOT NULL AUTO_INCREMENT,
  `totalPrice` float NOT NULL DEFAULT 0,
  `deliveryDateTime` datetime NOT NULL DEFAULT current_timestamp(),
  `placedDateTime` datetime NOT NULL DEFAULT current_timestamp(),
  `customerId` int(11) NOT NULL,
  `orderStatus` varchar(45) NOT NULL DEFAULT 'PENDING',
  `paymentStatus` enum('Pending','Paid') DEFAULT NULL,
  `orderMethod` enum('Pickup','Delivery') DEFAULT NULL,
  PRIMARY KEY (`orderId`),
  KEY `customeridFK_idx` (`customerId`),
  CONSTRAINT `customeridFK` FOREIGN KEY (`customerId`) REFERENCES `customer` (`customerid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;



-- Table structure for table `pizza`
DROP TABLE IF EXISTS `pizza`;
CREATE TABLE `pizza` (
  `pizzaId` int(11) NOT NULL AUTO_INCREMENT,
  `sizeId` int(11) NOT NULL,
  `isFinished` tinyint(4) NOT NULL DEFAULT 0,
  `crustTypeId` int(11) NOT NULL,
  `price` float NOT NULL,
  `orderId` int(11) NOT NULL,
  `quantity` int(5) DEFAULT NULL,
  PRIMARY KEY (`pizzaId`),
  KEY `crusttypeFK_idx` (`crustTypeId`),
  KEY `sizeidFK_idx` (`sizeId`),
  KEY `orderidFK_idx` (`orderId`),
  CONSTRAINT `crusttypeFK` FOREIGN KEY (`crustTypeId`) REFERENCES `crusttypes` (`crustTypeId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `orderidFK` FOREIGN KEY (`orderId`) REFERENCES `orders` (`orderId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `sizeidFK` FOREIGN KEY (`sizeId`) REFERENCES `sizes` (`sizeid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;



-- Table structure for table `pizza_toppings_map`
DROP TABLE IF EXISTS `pizza_toppings_map`;
CREATE TABLE `pizza_toppings_map` (
  `toppingId` int(11) NOT NULL,
  `pizzaId` int(11) NOT NULL,
  `pizza_toppings_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`pizza_toppings_id`),
  KEY `pizzaidFK_idx` (`pizzaId`),
  KEY `toppingidFK` (`toppingId`),
  CONSTRAINT `pizzaidFK` FOREIGN KEY (`pizzaId`) REFERENCES `pizza` (`pizzaId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `toppingidFK` FOREIGN KEY (`toppingId`) REFERENCES `toppings` (`toppingId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=190 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;



-- Table structure for table `sizes`
DROP TABLE IF EXISTS `sizes`;
CREATE TABLE `sizes` (
  `sizeid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`sizeid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Data for table `sizes`
LOCK TABLES `sizes` WRITE;
INSERT INTO `sizes` VALUES (1,'David (Small)'),(2,'Medium'),(3,'Goliath (Large)');
UNLOCK TABLES;

-- Table structure for table `toppings`
DROP TABLE IF EXISTS `toppings`;
CREATE TABLE `toppings` (
  `toppingId` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `price` float NOT NULL DEFAULT 0,
  `createdate` timestamp NOT NULL DEFAULT current_timestamp(),
  `empAddedBy` int(11) NOT NULL,
  `isActive` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`toppingId`),
  KEY `employeeidFK_idx` (`empAddedBy`),
  CONSTRAINT `employeeidFK` FOREIGN KEY (`empAddedBy`) REFERENCES `employee` (`employeeid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Data for table `toppings`
LOCK TABLES `toppings` WRITE;
INSERT INTO `toppings` VALUES (6,'Extra Cheese',1.99,'2017-11-04 23:35:40',1,1),(13,'Cheese',0,'2024-12-03 02:17:00',1,1),(14,'Anchovies',2,'2024-12-03 02:18:32',1,1),(15,'Lamb',3,'2024-12-03 02:41:43',1,1),(16,'Olives',4,'2024-12-03 02:43:11',1,1),(18,'Bacon',5,'2024-12-08 01:48:10',1,1),(19,'Lettuce',2,'2024-12-08 02:02:34',1,1);
UNLOCK TABLES;