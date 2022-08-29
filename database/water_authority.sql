-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Mar 10, 2020 at 07:28 AM
-- Server version: 5.7.26
-- PHP Version: 7.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `water_authority`
--

-- --------------------------------------------------------

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
CREATE TABLE IF NOT EXISTS `account` (
  `accountNo` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `bank` varchar(45) NOT NULL,
  `cardProvider` varchar(45) NOT NULL,
  `cardKey` varchar(45) NOT NULL,
  `cardType` varchar(45) NOT NULL,
  `cardExp` varchar(45) NOT NULL,
  `balance` varchar(45) NOT NULL,
  PRIMARY KEY (`accountNo`)
) ENGINE=InnoDB AUTO_INCREMENT=323233 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `account`
--

INSERT INTO `account` (`accountNo`, `bank`, `cardProvider`, `cardKey`, `cardType`, `cardExp`, `balance`) VALUES
(323232, 'SBI', 'Debit card', '6666', 'Master', '2021-12-12', '750000');

-- --------------------------------------------------------

--
-- Table structure for table `alerts`
--

DROP TABLE IF EXISTS `alerts`;
CREATE TABLE IF NOT EXISTS `alerts` (
  `alertid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `consumer_no` int(10) UNSIGNED NOT NULL,
  `limit` int(10) UNSIGNED NOT NULL,
  `status` varchar(45) NOT NULL,
  PRIMARY KEY (`alertid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `bank`
--

DROP TABLE IF EXISTS `bank`;
CREATE TABLE IF NOT EXISTS `bank` (
  `ac_no` varchar(45) NOT NULL,
  `cvv_no` varchar(45) NOT NULL,
  `card_no` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  `card_pin` varchar(45) NOT NULL,
  `exp_year` varchar(45) NOT NULL DEFAULT '',
  `exp_month` varchar(5) DEFAULT NULL,
  `amount` double(12,4) NOT NULL DEFAULT '0.0000',
  PRIMARY KEY (`ac_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `bank`
--

INSERT INTO `bank` (`ac_no`, `cvv_no`, `card_no`, `name`, `card_pin`, `exp_year`, `exp_month`, `amount`) VALUES
('12345678901234', '123', '1234 5678 8900', 'Ajay', '3456', '2018', '03', 3739322.0000),
('9999', '999', '9999', 'ABC', '999', '2021', '10', 21930840.0000);

-- --------------------------------------------------------

--
-- Table structure for table `bill`
--

DROP TABLE IF EXISTS `bill`;
CREATE TABLE IF NOT EXISTS `bill` (
  `bill_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `consumer_no` varchar(45) NOT NULL,
  `createdDate` varchar(45) NOT NULL,
  `amount` double NOT NULL,
  `paidDate` varchar(45) NOT NULL,
  `billStatus` varchar(45) NOT NULL,
  `fineDate` varchar(45) NOT NULL,
  `lastDate` varchar(45) NOT NULL,
  `netamt` varchar(45) NOT NULL,
  `account` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`bill_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bill`
--

INSERT INTO `bill` (`bill_id`, `consumer_no`, `createdDate`, `amount`, `paidDate`, `billStatus`, `fineDate`, `lastDate`, `netamt`, `account`) VALUES
(1, '1212', '26-02-2019', 18954, '26-02-2019', 'Paid', '28-03-2019', '2019-2-11', '18954', 1),
(3, '1212', '22-03-2019', 46818, '22-03-2019', 'New', '21-04-2019', '20-04-2019', '46818', 1),
(4, '1212', '22-03-2019', 0, '22-03-2019', 'New', '21-04-2019', '20-04-2019', '0', 1),
(5, '1212', '28-03-2019', 2997, '28-03-2019', 'Paid', '27-04-2019', '2019-02-15', '2997', 1),
(9, '1212', '30-03-2019', 16200, '30-03-2019', 'Paid', '29-04-2019', '2019-1-28', '16200', 1),
(14, 'co1221', '01-04-2019', 9200, '01-04-2019', 'New', '01-05-2019', '2019-4-30', '9200', 1),
(15, 'co1221', '01-04-2019', 174000, '01-04-2019', 'New', '01-05-2019', '2019-4-30', '174000', 1),
(16, 'co1221', '01-04-2019', 174000, '01-04-2019', 'New', '01-05-2019', '2019-4-30', '174000', 1);

-- --------------------------------------------------------

--
-- Table structure for table `bill_history`
--

DROP TABLE IF EXISTS `bill_history`;
CREATE TABLE IF NOT EXISTS `bill_history` (
  `hid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `payment_date` datetime NOT NULL,
  `usage` int(10) UNSIGNED NOT NULL,
  `consumer_no` varchar(45) NOT NULL,
  `total_amount` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`hid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bill_history`
--

INSERT INTO `bill_history` (`hid`, `payment_date`, `usage`, `consumer_no`, `total_amount`) VALUES
(1, '2019-12-19 00:00:00', 178, 'cons1000', 5340);

-- --------------------------------------------------------

--
-- Table structure for table `branch`
--

DROP TABLE IF EXISTS `branch`;
CREATE TABLE IF NOT EXISTS `branch` (
  `branch_id` varchar(20) NOT NULL,
  `address` varchar(450) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `email` varchar(20) NOT NULL,
  `password` varchar(45) NOT NULL,
  PRIMARY KEY (`branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `branch`
--

INSERT INTO `branch` (`branch_id`, `address`, `phone`, `email`, `password`) VALUES
('123df', 'dfdzfdzdfghdfghdfhdh', '1234567890', 'a@gmail.com', '12345'),
('3245', 'sgsdvsdv', '1234567890', 'e@g.com', '12345'),
('dor12', 'fsdf', '1234567890', 'a@gmail.com', '12345'),
('saam', 'hdfhdfhdhdh', '1234567890', 'a@gmail.com', '12345');

-- --------------------------------------------------------

--
-- Table structure for table `branch_pincode`
--

DROP TABLE IF EXISTS `branch_pincode`;
CREATE TABLE IF NOT EXISTS `branch_pincode` (
  `branch_pincode_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `branch_id` varchar(20) NOT NULL,
  `pincode` varchar(20) NOT NULL,
  PRIMARY KEY (`branch_pincode_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `branch_pincode`
--

INSERT INTO `branch_pincode` (`branch_pincode_id`, `branch_id`, `pincode`) VALUES
(1, 'kl001', '6820252222222'),
(2, 'pl001', '682023 '),
(5, '123df', '123456'),
(6, '3245', '01234567'),
(7, 'saam', '04444'),
(8, 'dor12', '0');

-- --------------------------------------------------------

--
-- Table structure for table `complaints`
--

DROP TABLE IF EXISTS `complaints`;
CREATE TABLE IF NOT EXISTS `complaints` (
  `comp_no` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `consumer_no` varchar(45) NOT NULL,
  `category` varchar(45) NOT NULL,
  `description` varchar(45) NOT NULL,
  `person` varchar(45) NOT NULL,
  `addres` varchar(45) NOT NULL,
  `mobile` varchar(45) NOT NULL,
  `areas` varchar(45) NOT NULL,
  `pincode` varchar(45) NOT NULL,
  `dates` varchar(45) NOT NULL,
  `reply` varchar(45) NOT NULL,
  `status` varchar(45) NOT NULL,
  PRIMARY KEY (`comp_no`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `complaints`
--

INSERT INTO `complaints` (`comp_no`, `consumer_no`, `category`, `description`, `person`, `addres`, `mobile`, `areas`, `pincode`, `dates`, `reply`, `status`) VALUES
(20, 'cons1000', 'general', 'no current', 'albert', 'kurishingal', '7412589635', 'dheshabimani', '682025', '2019-12-18', 'ghdfhffh', 'replied'),
(21, 'cons1000', 'general', 'no current', 'albert', 'kurishingal', '7412589635', 'dheshabimani', '682025', '2019-12-18', 'xxczcxzz', 'replied');

-- --------------------------------------------------------

--
-- Table structure for table `consumer`
--

DROP TABLE IF EXISTS `consumer`;
CREATE TABLE IF NOT EXISTS `consumer` (
  `consumer_no` varchar(20) NOT NULL,
  `cname` varchar(45) NOT NULL,
  `address` varchar(45) NOT NULL,
  `dob` varchar(45) NOT NULL,
  `pincode` varchar(20) NOT NULL,
  `area` varchar(45) NOT NULL,
  `city` varchar(45) NOT NULL,
  `phone` longtext NOT NULL,
  `mobile` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `con_status` varchar(45) NOT NULL,
  `password` varchar(25) NOT NULL,
  PRIMARY KEY (`consumer_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `consumer`
--

INSERT INTO `consumer` (`consumer_no`, `cname`, `address`, `dob`, `pincode`, `area`, `city`, `phone`, `mobile`, `email`, `con_status`, `password`) VALUES
('13ee', 'dsad', 'sasad', '2020-11-25', '0666', 'gfd', 'gdfgdfg', '1234567890', '0987654321', 'admin@gmail.com', 'registered', '12345'),
('23sdfe', 'rgdfg', 'ggrgg', '2020-02-25', '09877', 'fsdfsdf', 'sgdsgg', '1234567890', '1234567890', 'admin@gmail.com', 'registered', '1234');

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
CREATE TABLE IF NOT EXISTS `employee` (
  `emp_id` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  `address` varchar(45) NOT NULL,
  `contact` varchar(45) NOT NULL,
  `designation` varchar(45) NOT NULL,
  `branch_id` varchar(25) NOT NULL,
  `password` varchar(20) NOT NULL,
  PRIMARY KEY (`emp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`emp_id`, `name`, `address`, `contact`, `designation`, `branch_id`, `password`) VALUES
('12', 'doris', 'csdfcdff', '1234567890', 'desinerrfr', '2', '12345'),
('12anisha', 'anisha', 'csdfcdff', '1234567890', 'devoloper', 'saam', '12345');

-- --------------------------------------------------------

--
-- Table structure for table `emp_assign_area`
--

DROP TABLE IF EXISTS `emp_assign_area`;
CREATE TABLE IF NOT EXISTS `emp_assign_area` (
  `assign_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `emp_id` varchar(45) NOT NULL,
  `pincode` varchar(45) NOT NULL,
  `branch_id` varchar(20) NOT NULL,
  PRIMARY KEY (`assign_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `emp_assign_area`
--

INSERT INTO `emp_assign_area` (`assign_id`, `emp_id`, `pincode`, `branch_id`) VALUES
(18, 'emp001', '682027', 'kl001'),
(19, 'emp002', '112025 ', 'kl001'),
(20, '12anisha', '01111', 'saam'),
(21, '12sss', '0', 'dor12');

-- --------------------------------------------------------

--
-- Table structure for table `loads`
--

DROP TABLE IF EXISTS `loads`;
CREATE TABLE IF NOT EXISTS `loads` (
  `load_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `consumer_no` varchar(45) NOT NULL,
  `total` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`load_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `loads`
--

INSERT INTO `loads` (`load_id`, `consumer_no`, `total`) VALUES
(1, '1212', 99),
(2, 'cons1000', 178),
(3, 'co1222', 178);

-- --------------------------------------------------------

--
-- Table structure for table `load_history`
--

DROP TABLE IF EXISTS `load_history`;
CREATE TABLE IF NOT EXISTS `load_history` (
  `his_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `consumer_no` varchar(45) NOT NULL,
  `history_date` varchar(45) NOT NULL,
  `load` varchar(45) NOT NULL,
  PRIMARY KEY (`his_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `load_history`
--

INSERT INTO `load_history` (`his_id`, `consumer_no`, `history_date`, `load`) VALUES
(1, '1212', '2018-12-2', '250'),
(2, '1212', '2019-1-31', '320');

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

DROP TABLE IF EXISTS `login`;
CREATE TABLE IF NOT EXISTS `login` (
  `login_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `role` varchar(45) NOT NULL,
  PRIMARY KEY (`login_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`login_id`, `username`, `password`, `role`) VALUES
(1, 'admin', '12345', 'admin'),
(2, 'saam', '12345', 'branch'),
(9, '12', '12345', 'employe'),
(16, '12anisha', '12345', 'employe'),
(17, 'dor12', '12345', 'branch'),
(19, '13ee', '12345', 'consumer'),
(22, '23sdfe', '1234', 'consumer');

-- --------------------------------------------------------

--
-- Table structure for table `setlimit`
--

DROP TABLE IF EXISTS `setlimit`;
CREATE TABLE IF NOT EXISTS `setlimit` (
  `consumer_no` varchar(45) NOT NULL,
  `lm` int(10) UNSIGNED NOT NULL,
  `msg_status` varchar(45) NOT NULL,
  PRIMARY KEY (`consumer_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `setlimit`
--

INSERT INTO `setlimit` (`consumer_no`, `lm`, `msg_status`) VALUES
('1212', 2000, '1'),
('co1221', 400, '1'),
('cons1000', 120, '1');

-- --------------------------------------------------------

--
-- Table structure for table `suggestion`
--

DROP TABLE IF EXISTS `suggestion`;
CREATE TABLE IF NOT EXISTS `suggestion` (
  `suggestion_id` int(11) NOT NULL AUTO_INCREMENT,
  `suggestion` varchar(45) NOT NULL,
  `cons_no` varchar(20) NOT NULL,
  `suggestion_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `reply` varchar(45) NOT NULL,
  `reply_date` date NOT NULL,
  PRIMARY KEY (`suggestion_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `suggestion`
--

INSERT INTO `suggestion` (`suggestion_id`, `suggestion`, `cons_no`, `suggestion_date`, `reply`, `reply_date`) VALUES
(3, 'gdfgdfg', 'cons1000', '2020-02-20 10:07:15', 'sdgsdf', '2020-02-20'),
(4, 'dfdf', 'cons1000', '2020-02-20 10:07:45', 'tyutj', '2020-02-20');

-- --------------------------------------------------------

--
-- Table structure for table `unit_price`
--

DROP TABLE IF EXISTS `unit_price`;
CREATE TABLE IF NOT EXISTS `unit_price` (
  `unit_price_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `h_price` varchar(10) NOT NULL,
  PRIMARY KEY (`unit_price_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `unit_price`
--

INSERT INTO `unit_price` (`unit_price_id`, `h_price`) VALUES
(4, '0444');

-- --------------------------------------------------------

--
-- Table structure for table `water_failure`
--

DROP TABLE IF EXISTS `water_failure`;
CREATE TABLE IF NOT EXISTS `water_failure` (
  `power_failure_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `branch_id` varchar(45) NOT NULL,
  `failure_date` date NOT NULL,
  `from_time` varchar(45) NOT NULL,
  `to_time` varchar(45) NOT NULL,
  `deail_description` varchar(450) NOT NULL,
  PRIMARY KEY (`power_failure_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `water_failure`
--

INSERT INTO `water_failure` (`power_failure_id`, `branch_id`, `failure_date`, `from_time`, `to_time`, `deail_description`) VALUES
(1, 'kl001', '2020-01-31', '1.00 pm', '2.00 pm', 'kllgjhfghd'),
(2, 'kl001', '2020-01-30', '12.00an', '1.00pm', 'power cut'),
(3, 'saam', '2020-11-25', '4.30', '2.35', 'sfsdfsdf'),
(4, 'saam', '2020-09-25', '22:12', '06:12', 'ouho');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
