# Event Driven Live Demo - Salesforce + Mulesoft + MySQL + Twilio

Please Find the SQL Queries for your reference

## Create Customer Table

`CREATE TABLE `customers` (
  `customerNumber` int NOT NULL,
  `customerName` varchar(50) NOT NULL,
  `contactLastName` varchar(50) NOT NULL,
  `contactFirstName` varchar(50) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `addressLine1` varchar(50) NOT NULL,
  `addressLine2` varchar(50) DEFAULT NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(50) DEFAULT NULL,
  `postalCode` varchar(15) DEFAULT NULL,
  `country` varchar(50) NOT NULL,
  `salesRepEmployeeNumber` int DEFAULT NULL,
  `creditLimit` decimal(10,2) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`customerNumber`),
  KEY `salesRepEmployeeNumber` (`salesRepEmployeeNumber`),
  CONSTRAINT `customers_ibfk_1` FOREIGN KEY (`salesRepEmployeeNumber`) REFERENCES `employees` (`employeeNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1; `

## Create Orders Table

CREATE TABLE `orders` (
  `orderNumber` int NOT NULL,
  `orderDate` date NOT NULL,
  `requiredDate` date NOT NULL,
  `shippedDate` date DEFAULT NULL,
  `status` varchar(100) NOT NULL,
  `comments` text,
  `customerNumber` int NOT NULL,
  `orderId` varchar(45) DEFAULT NULL,
  `amount` int NOT NULL,
  `phone` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`orderNumber`),
  KEY `customerNumber` (`customerNumber`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customerNumber`) REFERENCES `customers` (`customerNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


## Create Payment Table

CREATE TABLE `payment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customerNumber` int NOT NULL,
  `checkNumber` varchar(50) NOT NULL,
  `paymentDate` date NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `payments_ibfk_1` (`customerNumber`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`customerNumber`) REFERENCES `customers` (`customerNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
