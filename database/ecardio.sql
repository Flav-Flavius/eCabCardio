-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 08, 2025 at 07:30 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ecardio`
--

-- --------------------------------------------------------

--
-- Table structure for table `consult_exam`
--

CREATE TABLE `consult_exam` (
  `consult_id` int(11) NOT NULL,
  `exam_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `consult_lab_test`
--

CREATE TABLE `consult_lab_test` (
  `consult_id` int(11) NOT NULL,
  `test_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `consult_sheets`
--

CREATE TABLE `consult_sheets` (
  `id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `consult_at` datetime NOT NULL DEFAULT current_timestamp(),
  `reason` text NOT NULL,
  `observations` text NOT NULL,
  `diagnosis` text NOT NULL,
  `treatment` text NOT NULL,
  `recommendations` text NOT NULL,
  `phsyological_history` text NOT NULL,
  `pathological_history` text NOT NULL,
  `hereditary_history` text NOT NULL,
  `environmental_conditions` text DEFAULT NULL,
  `current_state` text NOT NULL,
  `circulatory_system` text DEFAULT NULL,
  `local_exems` text NOT NULL,
  `letter_html` longtext NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `paid` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `exams`
--

CREATE TABLE `exams` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `files`
--

CREATE TABLE `files` (
  `id` int(30) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_path` text NOT NULL,
  `uploade_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `patient_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `files`
--

INSERT INTO `files` (`id`, `file_name`, `file_path`, `uploade_at`, `patient_id`) VALUES
(2, 'ecg_scan.pdf', '/uploads/ecg_scan.pdf', '2025-06-08 16:33:05', 1);



-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

CREATE TABLE `invoices` (
  `id` int(11) NOT NULL,
  `consult_id` int(30) NOT NULL,
  `issued_by` int(30) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `currency` char(3) NOT NULL,
  `paid` tinyint(1) NOT NULL,
  `issued_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `invoice_items`
--

CREATE TABLE `invoice_items` (
  `id` int(30) NOT NULL,
  `invoice_id` int(30) NOT NULL,
  `type` enum('exam','lab_test','custom') NOT NULL,
  `description` text NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `qty` int(30) NOT NULL DEFAULT 1,
  `line_total` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lab_tests`
--

CREATE TABLE `lab_tests` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `patients`
--

CREATE TABLE `patients` (
  `id` int(11) NOT NULL,
  `patient_number` varchar(20) DEFAULT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `birth_date` date NOT NULL,
  `county` varchar(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `occupation` varchar(100) DEFAULT NULL,
  `workplace` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `cnp` varchar(20) NOT NULL,
  `marital_status` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `patients`
--

INSERT INTO `patients` (`id`, `patient_number`, `first_name`, `last_name`, `birth_date`, `county`, `city`, `address`, `occupation`, `workplace`, `phone`, `email`, `cnp`, `marital_status`, `created_at`) VALUES
(1, 'P001', 'Ion', 'Popescu', '1970-01-01', NULL, NULL, NULL, NULL, NULL, NULL, 'ion.popescu@email.com', '1970101123456', NULL, '2025-06-08 16:31:10');
INSERT INTO `patients` (`id`, `patient_number`, `first_name`, `last_name`, `birth_date`, `county`, `city`, `address`, `occupation`, `workplace`, `phone`, `email`, `cnp`, `marital_status`, `created_at`) VALUES
(2, 'P002', 'Maria', 'Ionescu', '1980-02-14', 'Cluj', 'Cluj-Napoca', 'Str. Primăverii 10', 'Medic', 'Spital Municipal', '0741000001', 'maria.ionescu@email.com', '2800214123456', 'Necăsătorit', NOW()),
(3, 'P003', 'Andrei', 'Pop', '1990-05-22', 'Bihor', 'Oradea', 'Str. Libertății 5', 'Avocat', 'Cabinet Pop', '0741000002', 'andrei.pop@email.com', '1900522123456', 'Căsătorit', NOW()),
(4, 'P004', 'Ioana', 'Georgescu', '1975-11-10', 'Brașov', 'Brașov', 'Bd. Saturn 3', 'Profesor', 'Liceul 1', '0741000003', 'ioana.geo@email.com', '2751110123456', 'Necăsătorit', NOW()),
(5, 'P005', 'Cristian', 'Stan', '1988-06-30', 'Iași', 'Iași', 'Str. Copou 7', 'IT-ist', 'SoftVision', '0741000004', 'cristian.stan@email.com', '1880630123456', 'Căsătorit', NOW()),
(6, 'P006', 'Laura', 'Munteanu', '1995-12-05', 'Timiș', 'Timișoara', 'Str. Take Ionescu 2', 'Farmacist', 'HelpNet', '0741000005', 'laura.m@email.com', '2951205123456', 'Necăsătorit', NOW()),
(7, 'P007', 'Vlad', 'Nistor', '1983-03-17', 'Constanța', 'Constanța', 'Bd. Tomis 100', 'Inginer', 'Petrom', '0741000006', 'vlad.nistor@email.com', '1830317123456', 'Căsătorit', NOW()),
(8, 'P008', 'Elena', 'Radu', '1992-09-09', 'Sibiu', 'Sibiu', 'Str. Victoriei 8', 'Contabil', 'Deloitte', '0741000007', 'elena.radu@email.com', '2920909123456', 'Necăsătorit', NOW()),
(9, 'P009', 'Mihai', 'Drăgan', '1978-04-18', 'București', 'București', 'Str. Aviatorilor 25', 'Jurnalist', 'TVR', '0741000008', 'mihai.dragan@email.com', '1780418123456', 'Căsătorit', NOW()),
(10, 'P010', 'Ana', 'Petrescu', '1984-07-23', 'Galați', 'Galați', 'Str. Brăilei 120', 'Psiholog', 'Centrul Psiho', '0741000009', 'ana.petrescu@email.com', '2840723123456', 'Necăsătorit', NOW()),
(11, 'P011', 'George', 'Tudor', '1969-08-01', 'Argeș', 'Pitești', 'Str. Exercițiu 9', 'Economist', 'BCR', '0741000010', 'george.tudor@email.com', '1690801123456', 'Căsătorit', NOW());

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`) VALUES
(1, 'medic');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `full_name` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `full_name`, `created_at`) VALUES
(1, 'dr.ionescu', 'parolaCriptata123', 'Dr. Ionescu Andrei', '2025-06-08 16:35:16');

-- --------------------------------------------------------

--
-- Table structure for table `user_roles`
--

CREATE TABLE `user_roles` (
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `user_roles`
--

INSERT INTO `user_roles` (`user_id`, `role_id`) VALUES
(1, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `consult_exam`
--
ALTER TABLE `consult_exam`
  ADD PRIMARY KEY (`consult_id`,`exam_id`),
  ADD KEY `exam_id` (`exam_id`);

--
-- Indexes for table `consult_lab_test`
--
ALTER TABLE `consult_lab_test`
  ADD PRIMARY KEY (`consult_id`,`test_id`),
  ADD KEY `test_id` (`test_id`);

--
-- Indexes for table `consult_sheets`
--
ALTER TABLE `consult_sheets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_consult_user` (`user_id`),
  ADD KEY `fk_consult_patient` (`patient_id`);

--
-- Indexes for table `exams`
--
ALTER TABLE `exams`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `files`
--
ALTER TABLE `files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_files_patient` (`patient_id`);

--
-- Indexes for table `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_invoice_consult` (`consult_id`),
  ADD KEY `fk_invoice_user` (`issued_by`);

--
-- Indexes for table `invoice_items`
--
ALTER TABLE `invoice_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_item_invoice` (`invoice_id`);

--
-- Indexes for table `lab_tests`
--
ALTER TABLE `lab_tests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `patients`
--
ALTER TABLE `patients`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cnp` (`cnp`),
  ADD UNIQUE KEY `patient_number` (`patient_number`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `fk_user_roles_role_id` (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `consult_sheets`
--
ALTER TABLE `consult_sheets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `exams`
--
ALTER TABLE `exams`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `files`
--
ALTER TABLE `files`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `invoices`
--
ALTER TABLE `invoices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `invoice_items`
--
ALTER TABLE `invoice_items`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lab_tests`
--
ALTER TABLE `lab_tests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `patients`
--
ALTER TABLE `patients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `consult_exam`
--
ALTER TABLE `consult_exam`
  ADD CONSTRAINT `consult_exam_ibfk_1` FOREIGN KEY (`consult_id`) REFERENCES `consult_sheets` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `consult_exam_ibfk_2` FOREIGN KEY (`exam_id`) REFERENCES `exams` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `consult_lab_test`
--
ALTER TABLE `consult_lab_test`
  ADD CONSTRAINT `consult_lab_test_ibfk_1` FOREIGN KEY (`consult_id`) REFERENCES `consult_sheets` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `consult_lab_test_ibfk_2` FOREIGN KEY (`test_id`) REFERENCES `lab_tests` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `consult_sheets`
--
ALTER TABLE `consult_sheets`
  ADD CONSTRAINT `fk_consult_patient` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_consult_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `files`
--
ALTER TABLE `files`
  ADD CONSTRAINT `fk_files_patient` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `invoices`
--
ALTER TABLE `invoices`
  ADD CONSTRAINT `fk_invoice_consult` FOREIGN KEY (`consult_id`) REFERENCES `consult_sheets` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_invoice_user` FOREIGN KEY (`issued_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `invoice_items`
--
ALTER TABLE `invoice_items`
  ADD CONSTRAINT `fk_item_invoice` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD CONSTRAINT `fk_user_roles_role_id` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_user_roles_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
