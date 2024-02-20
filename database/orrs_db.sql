-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 18, 2023 at 07:12 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `orrs_db`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `Add_new_train` (IN `n_id` INT(30), IN `n_code` VARCHAR(100) CHARSET utf8mb4, IN `n_name` TEXT CHARSET utf8mb4, IN `n_first_class_capacity` FLOAT, IN `n_economy_capacity` FLOAT)   BEGIN
INSERT INTO
train_list(id,code,name,first_class_capacity,economy_capacity)VALUES(n_id,n_code,n_name,n_first_class_capacity,n_economy_capacity);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `user_details` ()   SELECT * FROM users$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `deleted_schedule_list`
--

CREATE TABLE `deleted_schedule_list` (
  `code` varchar(100) NOT NULL,
  `train_id` int(30) NOT NULL,
  `route_from` text NOT NULL,
  `route_to` text NOT NULL,
  `date_schedule` date DEFAULT NULL,
  `time_schedule` time NOT NULL,
  `first_class_fare` float NOT NULL DEFAULT 0,
  `economy_fare` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `deleted_schedule_list`
--

INSERT INTO `deleted_schedule_list` (`code`, `train_id`, `route_from`, `route_to`, `date_schedule`, `time_schedule`, `first_class_fare`, `economy_fare`) VALUES
('202301-0005', 7, 'KSR Bengaluru City Junction', 'Jodhpur Junction', '2023-01-01', '12:30:00', 1500, 750);

-- --------------------------------------------------------

--
-- Table structure for table `message_list`
--

CREATE TABLE `message_list` (
  `id` int(30) NOT NULL,
  `fullname` text NOT NULL,
  `contact` text NOT NULL,
  `email` text NOT NULL,
  `message` text NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `message_list`
--

INSERT INTO `message_list` (`id`, `fullname`, `contact`, `email`, `message`, `status`, `date_created`) VALUES
(4, 'Akash K N', '9019753976', 'akashkn@gmail.com', 'Could you please inform me when my ticket will be canceled.', 0, '2023-01-10 22:58:35'),
(5, 'B P Yashas', '7032536166', 'yashasbp@gmail.com', 'Could you please let me know if my reservation has been confirmed', 1, '2023-01-10 22:59:58'),
(6, 'Nithin', '9019756876', 'nithinreddy@gmail.com', 'I would like to know when my train is scheduled to arrive', 0, '2023-01-10 23:05:13');

--
-- Triggers `message_list`
--
DELIMITER $$
CREATE TRIGGER `contact` BEFORE INSERT ON `message_list` FOR EACH ROW BEGIN
  IF LENGTH(NEW.contact) > 10 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Number cannot exceed 10 digits';
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `reservation_list`
--

CREATE TABLE `reservation_list` (
  `id` int(30) NOT NULL,
  `seat_num` varchar(50) NOT NULL,
  `schedule_id` int(30) NOT NULL,
  `schedule` datetime NOT NULL,
  `firstname` text NOT NULL,
  `middlename` text NOT NULL,
  `lastname` text NOT NULL,
  `seat_type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1=First Class, 2 = Economy',
  `fare_amount` float NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reservation_list`
--

INSERT INTO `reservation_list` (`id`, `seat_num`, `schedule_id`, `schedule`, `firstname`, `middlename`, `lastname`, `seat_type`, `fare_amount`, `date_created`, `date_updated`) VALUES
(12, 'FC-001', 8, '2023-01-09 22:30:00', 'Akash', '', 'K N', 1, 2000, '2023-01-08 22:24:06', NULL),
(13, 'FC-002', 8, '2023-01-09 22:30:00', 'Yashas', '', 'B P', 1, 2000, '2023-01-08 22:24:06', NULL),
(14, 'E-001', 7, '2023-01-16 21:30:00', 'Nithin', '', 'Reddy', 2, 200, '2023-01-08 22:25:30', NULL),
(15, 'E-001', 6, '2023-01-09 22:30:00', 'Sreenivas', '', 'Sai', 2, 900, '2023-01-08 22:26:07', '2023-01-11 16:35:52');

-- --------------------------------------------------------

--
-- Table structure for table `schedule_list`
--

CREATE TABLE `schedule_list` (
  `id` int(30) NOT NULL,
  `code` varchar(100) NOT NULL,
  `train_id` int(30) NOT NULL,
  `route_from` text NOT NULL,
  `route_to` text NOT NULL,
  `type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1 = daily, 2= One-Time Schedule',
  `date_schedule` date DEFAULT NULL,
  `time_schedule` time NOT NULL,
  `first_class_fare` float NOT NULL DEFAULT 0,
  `economy_fare` float NOT NULL DEFAULT 0,
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `schedule_list`
--

INSERT INTO `schedule_list` (`id`, `code`, `train_id`, `route_from`, `route_to`, `type`, `date_schedule`, `time_schedule`, `first_class_fare`, `economy_fare`, `delete_flag`, `date_created`, `date_updated`) VALUES
(6, '202301-0002', 6, 'Mysuru Junction', 'SSS Hubballi Junction', 1, NULL, '00:00:00', 1000, 300, 0, '2023-01-08 22:07:38', NULL),
(7, '202301-0003', 8, 'Kacheguda Junction', 'Mysore Junction', 1, NULL, '21:30:00', 800, 200, 0, '2023-01-08 22:09:08', NULL),
(8, '202301-0004', 9, 'Guruvayur Junction', 'Chennai Egmore Junction', 2, '2023-01-09', '22:30:00', 2000, 900, 0, '2023-01-08 22:10:06', '2023-01-08 22:11:13');

--
-- Triggers `schedule_list`
--
DELIMITER $$
CREATE TRIGGER `Deleted_Schedule` AFTER DELETE ON `schedule_list` FOR EACH ROW INSERT INTO deleted_schedule_list VALUES(old.code,old.train_id,old.route_from,old.route_to,old.date_schedule,old.time_schedule,old.first_class_fare,old.economy_fare)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `system_info`
--

CREATE TABLE `system_info` (
  `id` int(30) NOT NULL,
  `meta_field` text NOT NULL,
  `meta_value` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `system_info`
--

INSERT INTO `system_info` (`id`, `meta_field`, `meta_value`) VALUES
(1, 'name', 'Online Railway Reservation '),
(6, 'short_name', 'N-S Railways'),
(11, 'logo', 'uploads/logo-1641351863.png'),
(13, 'user_avatar', 'uploads/user_avatar.jpg'),
(14, 'cover', 'uploads/cover-1641351863.png'),
(15, 'content', 'Array'),
(16, 'email', 'bhuvanvishwa@railway.com'),
(17, 'contact', '9019753976 / 7032536166'),
(18, 'from_time', '11:00'),
(19, 'to_time', '21:30'),
(20, 'address', 'Registered Office / Corporate Office\r\nIndian Railway Corporation Ltd.,\r\nB-148, 11th Floor, Statesman House,\r\nBarakhamba Road, New Delhi 110001');

-- --------------------------------------------------------

--
-- Table structure for table `train_list`
--

CREATE TABLE `train_list` (
  `id` int(30) NOT NULL,
  `code` varchar(100) NOT NULL,
  `name` text NOT NULL,
  `first_class_capacity` float NOT NULL DEFAULT 0,
  `economy_capacity` float NOT NULL DEFAULT 0,
  `delete_flag` tinyint(1) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `train_list`
--

INSERT INTO `train_list` (`id`, `code`, `name`, `first_class_capacity`, `economy_capacity`, `delete_flag`, `date_created`, `date_updated`) VALUES
(6, '16592', 'Hampi Express', 200, 500, 0, '2023-01-08 21:58:57', '2023-01-08 22:04:54'),
(7, '16534', 'Jodhpur Express', 500, 600, 0, '2023-01-08 22:00:55', '2023-01-08 22:05:33'),
(8, '12785', 'Mysuru SF Express', 200, 300, 0, '2023-01-08 22:01:47', '2023-01-08 22:06:01'),
(9, '16128', 'Chennai Egmore Express', 300, 700, 0, '2023-01-08 22:03:56', '2023-01-08 22:05:14');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(50) NOT NULL,
  `firstname` varchar(250) NOT NULL,
  `middlename` text DEFAULT NULL,
  `lastname` varchar(250) NOT NULL,
  `username` text NOT NULL,
  `password` text NOT NULL,
  `avatar` text DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `type` tinyint(1) NOT NULL DEFAULT 0,
  `status` int(1) NOT NULL DEFAULT 1 COMMENT '0=not verified, 1 = verified',
  `date_added` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `firstname`, `middlename`, `lastname`, `username`, `password`, `avatar`, `last_login`, `type`, `status`, `date_added`, `date_updated`) VALUES
(1, 'Adminstrator', NULL, 'Admin', 'ADMIN', '0192023a7bbd73250516f069df18b500', 'uploads/avatar-1.png?v=1639468007', NULL, 1, 1, '2021-01-20 14:02:37', '2023-01-09 01:11:47'),
(4, 'Bhuvan', NULL, 'Gopal', 'HBGR', 'ccc70c79790e1d701788a7c52bced888', 'uploads/avatar-4.png?v=1673194985', NULL, 2, 1, '2022-01-05 09:36:56', '2023-01-09 01:13:49'),
(6, 'Vishwa', NULL, 'Vardhan', 'BVVR', '59D4DF8ED50BA7595428B123928A413C', 'uploads/avatar-6.png?v=1673195135', NULL, 2, 1, '2023-01-08 21:55:35', '2023-01-08 21:55:35');

--
-- Triggers `users`
--
DELIMITER $$
CREATE TRIGGER `username` BEFORE INSERT ON `users` FOR EACH ROW SET NEW.username=UPPER(NEW.username)
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `message_list`
--
ALTER TABLE `message_list`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reservation_list`
--
ALTER TABLE `reservation_list`
  ADD PRIMARY KEY (`id`),
  ADD KEY `schedule_id` (`schedule_id`);

--
-- Indexes for table `schedule_list`
--
ALTER TABLE `schedule_list`
  ADD PRIMARY KEY (`id`),
  ADD KEY `train_id` (`train_id`);

--
-- Indexes for table `system_info`
--
ALTER TABLE `system_info`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `train_list`
--
ALTER TABLE `train_list`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `message_list`
--
ALTER TABLE `message_list`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `reservation_list`
--
ALTER TABLE `reservation_list`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `schedule_list`
--
ALTER TABLE `schedule_list`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `system_info`
--
ALTER TABLE `system_info`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `train_list`
--
ALTER TABLE `train_list`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `reservation_list`
--
ALTER TABLE `reservation_list`
  ADD CONSTRAINT `reservation_list_ibfk_1` FOREIGN KEY (`schedule_id`) REFERENCES `schedule_list` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `schedule_list`
--
ALTER TABLE `schedule_list`
  ADD CONSTRAINT `schedule_list_ibfk_1` FOREIGN KEY (`train_id`) REFERENCES `train_list` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
