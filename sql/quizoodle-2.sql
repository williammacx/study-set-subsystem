-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Feb 10, 2026 at 11:19 PM
-- Server version: 11.4.9-MariaDB
-- PHP Version: 8.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `quizoodle`
--

-- --------------------------------------------------------

--
-- Table structure for table `app_user`
--

DROP TABLE IF EXISTS `app_user`;
CREATE TABLE IF NOT EXISTS `app_user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `full_name` varchar(120) NOT NULL,
  `email` varchar(255) NOT NULL,
  `role` varchar(30) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`) USING HASH
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `app_user`
--

INSERT INTO `app_user` (`user_id`, `full_name`, `email`, `role`, `created_at`) VALUES
(1, 'Mia Englender', 'miaenglender@oakland.edu', 'student', '2026-01-05 05:00:00'),
(2, 'Vincent Griest', 'vincentgriest@oakland.edu', 'student', '2026-01-05 05:00:00'),
(3, 'William MacLean', 'williammaclean@oakland.edu', 'student', '2026-01-05 05:00:00'),
(4, 'Hunter Parcells', 'hunterparcells@oakland.edu', 'student', '2026-01-05 05:00:00'),
(5, 'Sam Purrenhage', 'sampurrenhage@oakland.edu', 'student', '2026-01-05 05:00:00'),
(6, 'Emily Carter', 'emilycarter@oakland.edu', 'student', '2026-01-06 05:00:00'),
(7, 'Jacob Wilson', 'jacobwilson@oakland.edu', 'student', '2026-01-06 05:00:00'),
(8, 'Olivia Martinez', 'oliviamartinez@oakland.edu', 'student', '2026-01-06 05:00:00'),
(9, 'Noah Brooks', 'noahbrooks@oakland.edu', 'study_set_creator', '2026-01-06 05:00:00'),
(10, 'Ava Patel', 'avapatel@oakland.edu', 'study_set_creator', '2026-01-06 05:00:00'),
(11, 'Dr. Hadeel Jawad', 'hjawad@oakland.edu', 'instructor', '2026-01-01 05:00:00'),
(12, 'Dr. Robert Hayes', 'rhayes@oakland.edu', 'instructor', '2026-01-01 05:00:00'),
(13, 'Dr. Lisa Thompson', 'lthompson@oakland.edu', 'instructor', '2026-01-01 05:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `assignment`
--

DROP TABLE IF EXISTS `assignment`;
CREATE TABLE IF NOT EXISTS `assignment` (
  `assignment_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `course_id` bigint(20) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `due_at` datetime NOT NULL,
  `created_by` bigint(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`assignment_id`),
  KEY `fk_assignment_created_by` (`created_by`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `assignment`
--

INSERT INTO `assignment` (`assignment_id`, `course_id`, `title`, `description`, `due_at`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 4999, 'Capstone - Project Idea Report', 'Submit project idea report and team info.', '2026-02-07 23:59:00', 11, '2026-02-01 14:00:00', '2026-02-01 14:00:00'),
(2, 4700, 'Software Security Lab 1', 'Linux permissions + basic security tasks.', '2026-02-14 23:59:00', 12, '2026-02-02 15:00:00', '2026-02-02 15:00:00'),
(3, 4810, 'Data Mining HW2', 'Train a classifier and report accuracy.', '2026-02-18 23:59:00', 13, '2026-02-03 16:00:00', '2026-02-03 16:00:00'),
(4, 4500, 'Operating Systems Checkpoint', 'Scheduling writeup + code checkpoint.', '2026-02-20 23:59:00', 12, '2026-02-04 14:30:00', '2026-02-04 14:30:00'),
(5, 4999, 'Capstone - ERD Draft', 'Draft ERD for core tables.', '2026-02-21 23:59:00', 11, '2026-02-05 13:30:00', '2026-02-05 13:30:00'),
(6, 3450, 'Database HW1', 'Create ER diagram and normalize tables to 3NF.', '2026-03-01 23:59:00', 13, '2026-02-10 18:54:17', NULL),
(7, 3450, 'SQL Practice Lab', 'Write SELECT, JOIN, and GROUP BY queries.', '2026-03-08 23:59:00', 13, '2026-02-10 18:54:17', NULL),
(8, 4500, 'Process Scheduling Assignment', 'Analyze FCFS, SJF, and Round Robin scheduling.', '2026-03-05 23:59:00', 12, '2026-02-10 18:54:17', NULL),
(9, 3370, 'Sprint Planning Report', 'Submit sprint backlog and velocity estimates.', '2026-03-04 23:59:00', 11, '2026-02-10 18:54:17', NULL),
(10, 2470, 'Networking Lab 1', 'Configure IP addresses and test connectivity.', '2026-03-06 23:59:00', 13, '2026-02-10 18:54:17', NULL),
(11, 4999, 'Capstone Final Presentation', 'Prepare slides and present final project.', '2026-04-01 23:59:00', 11, '2026-02-10 18:54:17', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `assignment_status`
--

DROP TABLE IF EXISTS `assignment_status`;
CREATE TABLE IF NOT EXISTS `assignment_status` (
  `assignment_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `status` varchar(20) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`assignment_id`,`user_id`),
  KEY `fk_asgstat_user` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `assignment_status`
--

INSERT INTO `assignment_status` (`assignment_id`, `user_id`, `status`, `updated_at`) VALUES
(1, 1, 'in_progress', '2026-02-10 23:17:21'),
(1, 2, 'done', '2026-02-05 16:21:01'),
(1, 3, 'done', '2026-02-05 16:21:01'),
(1, 4, 'done', '2026-02-05 16:21:01'),
(1, 5, 'done', '2026-02-05 16:21:01'),
(2, 1, 'done', '2026-02-10 22:58:07'),
(2, 2, 'to_do', '2026-02-05 16:21:01'),
(2, 3, 'in_progress', '2026-02-05 16:21:01'),
(2, 6, 'to_do', '2026-02-05 16:21:01'),
(3, 4, 'to_do', '2026-02-05 16:21:01'),
(3, 5, 'in_progress', '2026-02-05 16:21:01'),
(3, 7, 'in_progress', '2026-02-05 16:21:01'),
(3, 8, 'to_do', '2026-02-05 16:21:01'),
(4, 3, 'in_progress', '2026-02-05 16:21:01'),
(4, 4, 'to_do', '2026-02-05 16:21:01'),
(4, 5, 'to_do', '2026-02-05 16:21:01'),
(5, 1, 'in_progress', '2026-02-05 16:21:01'),
(5, 2, 'to_do', '2026-02-05 16:21:01'),
(5, 6, 'to_do', '2026-02-05 16:21:01'),
(5, 7, 'to_do', '2026-02-05 16:21:01'),
(6, 1, 'in_progress', '2026-02-10 18:54:30'),
(6, 2, 'to_do', '2026-02-10 18:54:30'),
(6, 3, 'to_do', '2026-02-10 18:54:30'),
(6, 6, 'in_progress', '2026-02-10 18:54:30'),
(7, 1, 'to_do', '2026-02-10 18:54:30'),
(7, 4, 'in_progress', '2026-02-10 18:54:30'),
(7, 5, 'to_do', '2026-02-10 18:54:30'),
(7, 7, 'in_progress', '2026-02-10 18:54:30'),
(8, 3, 'in_progress', '2026-02-10 18:54:31'),
(8, 4, 'to_do', '2026-02-10 18:54:31'),
(8, 5, 'to_do', '2026-02-10 18:54:31'),
(8, 6, 'in_progress', '2026-02-10 18:54:31'),
(9, 2, 'to_do', '2026-02-10 18:54:31'),
(9, 4, 'in_progress', '2026-02-10 18:54:31'),
(9, 7, 'to_do', '2026-02-10 18:54:31'),
(9, 8, 'in_progress', '2026-02-10 18:54:31'),
(10, 1, 'done', '2026-02-10 18:54:31'),
(10, 2, 'in_progress', '2026-02-10 18:54:31'),
(10, 6, 'to_do', '2026-02-10 18:54:31'),
(10, 8, 'to_do', '2026-02-10 18:54:31'),
(11, 1, 'to_do', '2026-02-10 18:54:31'),
(11, 2, 'to_do', '2026-02-10 18:54:31'),
(11, 3, 'to_do', '2026-02-10 18:54:31'),
(11, 4, 'to_do', '2026-02-10 18:54:31'),
(11, 5, 'to_do', '2026-02-10 18:54:31');

-- --------------------------------------------------------

--
-- Table structure for table `chat`
--

DROP TABLE IF EXISTS `chat`;
CREATE TABLE IF NOT EXISTS `chat` (
  `chat_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `course_id` bigint(20) DEFAULT NULL,
  `chat_name` varchar(255) DEFAULT NULL,
  `is_direct` tinyint(1) NOT NULL DEFAULT 0,
  `created_by` bigint(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`chat_id`),
  KEY `fk_chat_course` (`course_id`),
  KEY `fk_chat_creator` (`created_by`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `chat`
--

INSERT INTO `chat` (`chat_id`, `course_id`, `chat_name`, `is_direct`, `created_by`, `created_at`) VALUES
(1, 4999, 'CSI-4999 Team Chat', 0, 1, '2026-02-01 14:00:00'),
(2, 4700, 'CSI-4700 Lab Help', 0, 12, '2026-02-02 18:00:00'),
(3, 4810, 'CSI-4810 Homework Q&A', 0, 13, '2026-02-03 20:00:00'),
(4, NULL, 'Direct: Mia ↔ Dr. Jawad', 1, 1, '2026-02-04 15:00:00'),
(5, 1420, 'CSI1420 Homework Help', 0, 12, '2026-02-11 14:00:00'),
(6, 1420, 'CSI1420 Study Group', 0, 1, '2026-02-11 14:05:00'),
(7, 2300, 'CSI2300 Project Discussion', 0, 11, '2026-02-11 15:00:00'),
(8, 2310, 'CSI2310 Exam Review', 0, 13, '2026-02-11 15:30:00'),
(9, 3450, 'CSI3450 SQL Help', 0, 13, '2026-02-11 16:00:00'),
(10, 4480, 'CSI4480 Security Q&A', 0, 12, '2026-02-11 16:30:00'),
(11, NULL, 'Direct: Mia ↔ Dr. Hayes', 1, 1, '2026-02-12 14:00:00'),
(12, NULL, 'Direct: Vincent ↔ Dr. Jawad', 1, 2, '2026-02-12 14:05:00'),
(13, NULL, 'Direct: William ↔ Dr. Thompson', 1, 3, '2026-02-12 14:10:00'),
(14, NULL, 'Direct: Hunter ↔ Dr. Hayes', 1, 4, '2026-02-12 14:15:00'),
(15, NULL, 'Direct: Sam ↔ Dr. Jawad', 1, 5, '2026-02-12 14:20:00'),
(16, NULL, 'Direct: Mia ↔ Vincent', 1, 1, '2026-02-12 14:30:00'),
(17, NULL, 'Direct: William ↔ Hunter', 1, 3, '2026-02-12 14:35:00'),
(18, NULL, 'Direct: Sam ↔ Emily', 1, 5, '2026-02-12 14:40:00'),
(19, NULL, 'Direct: Jacob ↔ Olivia', 1, 7, '2026-02-12 14:45:00'),
(20, NULL, 'Direct: Daniel ↔ Sophia', 1, 14, '2026-02-12 14:50:00'),
(21, NULL, 'Direct: Mia ↔ Sam (Capstone)', 1, 1, '2026-02-13 14:00:00'),
(22, NULL, 'Direct: Vincent ↔ William (DS)', 1, 2, '2026-02-13 14:05:00'),
(23, NULL, 'Direct: Hunter ↔ Emily (OS)', 1, 4, '2026-02-13 14:10:00'),
(24, NULL, 'Direct: Jacob ↔ Olivia (ML)', 1, 7, '2026-02-13 14:15:00'),
(25, NULL, 'Direct: Daniel ↔ Sophia (DB)', 1, 14, '2026-02-13 14:20:00'),
(26, 4999, 'Direct: Mia ↔ Dr. Jawad (Capstone)', 1, 1, '2026-02-13 15:00:00'),
(27, 4500, 'Direct: Vincent ↔ Dr. Hayes (OS)', 1, 2, '2026-02-13 15:05:00'),
(28, 3450, 'Direct: William ↔ Dr. Thompson (DB)', 1, 3, '2026-02-13 15:10:00'),
(29, 2470, 'Direct: Hunter ↔ Dr. Thompson (Networks)', 1, 4, '2026-02-13 15:15:00'),
(30, 4480, 'Direct: Sam ↔ Dr. Hayes (Security)', 1, 5, '2026-02-13 15:20:00');

-- --------------------------------------------------------

--
-- Table structure for table `chat_member`
--

DROP TABLE IF EXISTS `chat_member`;
CREATE TABLE IF NOT EXISTS `chat_member` (
  `chat_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `joined_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`chat_id`,`user_id`),
  KEY `fk_member_user` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `chat_member`
--

INSERT INTO `chat_member` (`chat_id`, `user_id`, `joined_at`) VALUES
(1, 1, '2026-02-06 16:46:34'),
(1, 2, '2026-02-06 16:46:34'),
(1, 3, '2026-02-06 16:46:34'),
(1, 4, '2026-02-06 16:46:34'),
(1, 5, '2026-02-06 16:46:34'),
(2, 12, '2026-02-06 16:46:34'),
(2, 1, '2026-02-06 16:46:34'),
(2, 2, '2026-02-06 16:46:34'),
(2, 3, '2026-02-06 16:46:34'),
(2, 6, '2026-02-06 16:46:34'),
(3, 13, '2026-02-06 16:46:34'),
(3, 4, '2026-02-06 16:46:34'),
(3, 5, '2026-02-06 16:46:34'),
(3, 7, '2026-02-06 16:46:34'),
(3, 8, '2026-02-06 16:46:34'),
(4, 1, '2026-02-06 16:46:34'),
(4, 11, '2026-02-06 16:46:34');

-- --------------------------------------------------------

--
-- Table structure for table `chat_message`
--

DROP TABLE IF EXISTS `chat_message`;
CREATE TABLE IF NOT EXISTS `chat_message` (
  `message_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `chat_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `message_text` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`message_id`),
  KEY `fk_msg_chat` (`chat_id`),
  KEY `fk_msg_user` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `chat_message`
--

INSERT INTO `chat_message` (`message_id`, `chat_id`, `user_id`, `message_text`, `created_at`, `updated_at`, `is_deleted`) VALUES
(1, 1, 1, 'Hey team, I uploaded the updated DB script. Please pull the latest version.', '2026-02-01 14:05:00', NULL, 0),
(2, 1, 2, 'Got it. I’ll start on the course screens today.', '2026-02-01 14:06:00', NULL, 0),
(3, 1, 4, 'I can handle the messaging UI + basic CRUD.', '2026-02-01 14:08:00', NULL, 0),
(4, 2, 12, 'Reminder: Lab 1 is due Friday night. Ask questions here.', '2026-02-02 18:02:00', NULL, 0),
(5, 2, 1, 'For chmod, do we need symbolic and numeric examples?', '2026-02-02 18:10:00', NULL, 0),
(6, 2, 12, 'Yes — include both in your submission.', '2026-02-02 18:12:00', NULL, 0),
(7, 3, 4, 'Is F1 better than accuracy for imbalanced data?', '2026-02-03 20:15:00', NULL, 0),
(8, 3, 13, 'Usually, yes — F1 balances precision/recall when classes are uneven.', '2026-02-03 20:17:00', NULL, 0),
(9, 4, 1, 'Hi Dr. Jawad, can you confirm the project idea report format?', '2026-02-04 15:05:00', NULL, 0),
(10, 4, 11, 'Yes — follow the rubric sections and include the video link on the cover page.', '2026-02-04 15:10:00', NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
CREATE TABLE IF NOT EXISTS `course` (
  `course_id` bigint(20) NOT NULL,
  `course_code` varchar(20) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `created_by` bigint(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`course_id`),
  KEY `fk_course_created_by` (`created_by`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `course`
--

INSERT INTO `course` (`course_id`, `course_code`, `title`, `description`, `created_by`, `created_at`, `updated_at`) VALUES
(4999, 'CSI-4999', 'Senior Capstone', 'Capstone planning, deliverables, and project execution.', 11, '2026-01-10 14:00:00', NULL),
(4700, 'CSI-4700', 'Software & System Security', 'Security fundamentals and labs.', 12, '2026-01-10 14:10:00', NULL),
(4810, 'CSI-4810', 'Data Mining / ML', 'Classification, evaluation, and model training.', 13, '2026-01-10 14:20:00', NULL),
(4500, 'CSI-4500', 'Operating Systems', 'Processes, scheduling, and OS design.', 12, '2026-01-10 14:30:00', NULL),
(1420, 'CSI 1420', 'Intro to C Programming & Unix', 'Introduction to C programming and Unix fundamentals.', 12, '2022-09-01 13:00:00', NULL),
(2300, 'CSI 2300', 'Object-Oriented Computing', 'Object-oriented design and programming concepts.', 12, '2023-01-10 14:00:00', NULL),
(2310, 'CSI 2310', 'Data Structures', 'Data structures, complexity basics, and implementation.', 12, '2023-09-01 13:00:00', NULL),
(2470, 'CSI 2470', 'Intro to Computer Networks', 'Networking fundamentals: layers, protocols, TCP/UDP.', 13, '2024-01-10 14:00:00', NULL),
(2999, 'CSI 2999', 'Sophomore Project', 'Team project focused on software design and development.', 11, '2024-01-10 14:05:00', NULL),
(3370, 'CSI 3370', 'Software Engineer and Practice', 'Software engineering process, teamwork, and best practices.', 11, '2025-01-10 14:00:00', NULL),
(3430, 'CSI 3430', 'Theory of Computation', 'Automata, formal languages, and computability basics.', 13, '2025-01-10 14:05:00', NULL),
(3450, 'CSI 3450', 'Database Dsgn & Implementation', 'Relational design, SQL, normalization, and implementation.', 13, '2025-01-10 14:10:00', NULL),
(3610, 'CSI 3610', 'Design and Analys of Algorithm', 'Algorithm design techniques and complexity analysis.', 12, '2024-09-01 13:00:00', NULL),
(3640, 'CSI 3640', 'Computer Organization', 'Computer architecture, memory, CPU organization.', 12, '2024-09-01 13:05:00', NULL),
(4350, 'CSI 4350', 'Programming Languages', 'Programming paradigms and language concepts.', 11, '2026-01-10 14:00:00', NULL),
(4480, 'CSI 4480', 'Information Security Practices', 'Security concepts and hands-on practice labs.', 12, '2025-09-01 13:00:00', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `course_enrollment`
--

DROP TABLE IF EXISTS `course_enrollment`;
CREATE TABLE IF NOT EXISTS `course_enrollment` (
  `course_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `joined_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`course_id`,`user_id`),
  KEY `fk_enroll_user` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `course_enrollment`
--

INSERT INTO `course_enrollment` (`course_id`, `user_id`, `joined_at`) VALUES
(4999, 1, '2026-02-06 16:46:34'),
(4999, 2, '2026-02-06 16:46:34'),
(4999, 3, '2026-02-06 16:46:34'),
(4999, 4, '2026-02-06 16:46:34'),
(4999, 5, '2026-02-06 16:46:34'),
(4700, 1, '2026-02-06 16:46:34'),
(4700, 2, '2026-02-06 16:46:34'),
(4700, 3, '2026-02-06 16:46:34'),
(4700, 6, '2026-02-06 16:46:34'),
(4810, 4, '2026-02-06 16:46:34'),
(4810, 5, '2026-02-06 16:46:34'),
(4810, 7, '2026-02-06 16:46:34'),
(4810, 8, '2026-02-06 16:46:34'),
(4500, 3, '2026-02-06 16:46:34'),
(4500, 4, '2026-02-06 16:46:34'),
(4500, 5, '2026-02-06 16:46:34'),
(4500, 6, '2026-02-06 16:46:34'),
(4500, 7, '2026-02-06 16:46:34');

-- --------------------------------------------------------

--
-- Table structure for table `course_resource`
--

DROP TABLE IF EXISTS `course_resource`;
CREATE TABLE IF NOT EXISTS `course_resource` (
  `resource_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `course_id` bigint(20) NOT NULL,
  `title` varchar(255) NOT NULL,
  `resource_type` varchar(30) NOT NULL,
  `url` varchar(600) NOT NULL,
  `created_by` bigint(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`resource_id`),
  KEY `fk_resource_course` (`course_id`),
  KEY `fk_resource_creator` (`created_by`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `course_resource`
--

INSERT INTO `course_resource` (`resource_id`, `course_id`, `title`, `resource_type`, `url`, `created_by`, `created_at`) VALUES
(1, 4999, 'Capstone Syllabus', 'pdf', 'https://oakland.edu/capstone/syllabus', 11, '2026-01-12 15:00:00'),
(2, 4999, 'Project Deliverables Checklist', 'link', 'https://oakland.edu/capstone/deliverables', 11, '2026-01-12 15:05:00'),
(3, 4700, 'Lab 1 Instructions', 'pdf', 'https://oakland.edu/security/lab1', 12, '2026-01-13 17:00:00'),
(4, 4810, 'Lecture Slides - Classification', 'slides', 'https://oakland.edu/ml/slides/classification', 13, '2026-01-14 19:00:00'),
(5, 4500, 'Scheduling Notes', 'link', 'https://oakland.edu/os/scheduling', 12, '2026-01-15 14:00:00'),
(6, 1420, 'C Programming Basics', 'pdf', 'https://oakland.edu/cs1420/c-basics.pdf', 12, '2026-02-10 14:00:00'),
(7, 1420, 'Unix Command Reference', 'link', 'https://oakland.edu/cs1420/unix-commands', 12, '2026-02-10 14:05:00'),
(8, 2310, 'Linked Lists Tutorial', 'pdf', 'https://oakland.edu/cs2310/linked-lists.pdf', 12, '2026-02-11 15:00:00'),
(9, 3450, 'Normalization Guide', 'pdf', 'https://oakland.edu/cs3450/normalization.pdf', 13, '2026-02-12 16:00:00'),
(10, 3450, 'SQL Joins Examples', 'link', 'https://oakland.edu/cs3450/sql-joins', 13, '2026-02-12 16:05:00'),
(11, 4500, 'Process Scheduling Slides', 'slides', 'https://oakland.edu/cs4500/scheduling-slides', 12, '2026-02-13 17:00:00'),
(12, 3370, 'Agile Workflow Diagram', 'pdf', 'https://oakland.edu/cs3370/agile-workflow.pdf', 11, '2026-02-14 18:00:00'),
(13, 2470, 'TCP vs UDP Comparison', 'pdf', 'https://oakland.edu/cs2470/tcp-udp.pdf', 13, '2026-02-15 19:00:00'),
(14, 4350, 'Language Paradigms Overview', 'slides', 'https://oakland.edu/cs4350/paradigms-slides', 11, '2026-02-16 20:00:00'),
(15, 4999, 'Final Project Rubric', 'pdf', 'https://oakland.edu/cs4999/final-rubric.pdf', 11, '2026-02-17 21:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `study_set`
--

DROP TABLE IF EXISTS `study_set`;
CREATE TABLE IF NOT EXISTS `study_set` (
  `study_set_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `course_id` bigint(20) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `visibility` varchar(20) NOT NULL,
  `created_by` bigint(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`study_set_id`),
  KEY `fk_studyset_course` (`course_id`),
  KEY `fk_studyset_creator` (`created_by`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `study_set`
--

INSERT INTO `study_set` (`study_set_id`, `course_id`, `title`, `description`, `visibility`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 4700, 'Security Lab 1 - Key Terms', 'Quick flashcards for permissions, users, groups.', 'public', 9, '2026-01-21 04:00:00', NULL),
(2, 4810, 'ML Metrics Cheat Sheet', 'Precision/Recall/F1 + confusion matrix basics.', 'public', 10, '2026-01-22 00:30:00', NULL),
(3, 4500, 'OS Scheduling Algorithms', 'FCFS, SJF, RR, priority scheduling review.', 'unlisted', 9, '2026-01-23 05:10:00', NULL),
(4, NULL, 'General Study Habits', 'Short reminders + tips for weekly planning.', 'private', 10, '2026-01-23 19:00:00', NULL),
(5, 1420, 'C Pointers Basics', 'Pointers, memory addresses, and common mistakes.', 'public', 9, '2026-02-08 15:00:00', NULL),
(6, 2300, 'OOP Review', 'Classes, objects, inheritance, polymorphism.', 'public', 10, '2026-02-08 15:05:00', NULL),
(7, 2310, 'Data Structures - Big O', 'Time complexity notes + examples.', 'public', 9, '2026-02-08 15:10:00', NULL),
(8, 3430, 'TOC - Automata', 'DFA/NFA, regex, and language basics.', 'unlisted', 10, '2026-02-08 15:15:00', NULL),
(9, 4480, 'Security Practices - Common Attacks', 'Phishing, SQL injection, and mitigation basics.', 'public', 9, '2026-02-08 15:20:00', NULL),
(10, 4650, 'Parallel & Distributed - Concepts', 'Threads vs processes, synchronization, and speedup.', 'public', 10, '2026-02-08 15:25:00', NULL),
(11, 1420, 'CSI1420 - C Pointers', 'Pointers, memory, & common pitfalls.', 'public', 9, '2026-02-08 15:00:00', NULL),
(12, 1420, 'CSI1420 - Unix Commands', 'Core Unix commands for labs.', 'public', 10, '2026-02-08 15:05:00', NULL),
(13, 2300, 'CSI2300 - OOP Concepts', 'Classes, inheritance, polymorphism review.', 'public', 9, '2026-02-08 15:10:00', NULL),
(14, 2310, 'CSI2310 - Big O', 'Time complexity cheat sheet + examples.', 'public', 10, '2026-02-08 15:15:00', NULL),
(15, 2470, 'CSI2470 - TCP vs UDP', 'Transport layer differences + use cases.', 'public', 9, '2026-02-08 15:20:00', NULL),
(16, 3370, 'CSI3370 - Agile & Scrum', 'Roles, ceremonies, sprint flow.', 'public', 10, '2026-02-08 15:25:00', NULL),
(17, 3430, 'CSI3430 - Automata', 'DFA/NFA and regular languages basics.', 'unlisted', 9, '2026-02-08 15:30:00', NULL),
(18, 3450, 'CSI3450 - SQL Joins', 'JOIN types with quick examples.', 'public', 10, '2026-02-08 15:35:00', NULL),
(19, 4480, 'CSI4480 - Common Attacks', 'Phishing, SQLi, XSS, and prevention.', 'public', 9, '2026-02-08 15:40:00', NULL),
(20, 4650, 'CSI4650 - Concurrency', 'Threads, locks, race conditions.', 'public', 10, '2026-02-08 15:45:00', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `study_set_item`
--

DROP TABLE IF EXISTS `study_set_item`;
CREATE TABLE IF NOT EXISTS `study_set_item` (
  `item_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `study_set_id` bigint(20) NOT NULL,
  `front_text` varchar(500) NOT NULL,
  `back_text` varchar(1000) NOT NULL,
  `order_index` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`item_id`),
  KEY `fk_item_studyset` (`study_set_id`)
) ENGINE=MyISAM AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `study_set_item`
--

INSERT INTO `study_set_item` (`item_id`, `study_set_id`, `front_text`, `back_text`, `order_index`, `created_at`) VALUES
(1, 1, 'chmod', 'Command used to change file permissions in Linux.', 1, '2026-02-06 16:46:34'),
(2, 1, 'chown', 'Changes file owner and/or group.', 2, '2026-02-06 16:46:34'),
(3, 1, 'rwx', 'Read / Write / Execute permission bits.', 3, '2026-02-06 16:46:34'),
(4, 1, 'umask', 'Default permission mask applied to newly created files.', 4, '2026-02-06 16:46:34'),
(5, 2, 'Precision', 'TP / (TP + FP) — how many predicted positives were correct.', 1, '2026-02-06 16:46:34'),
(6, 2, 'Recall', 'TP / (TP + FN) — how many actual positives were found.', 2, '2026-02-06 16:46:34'),
(7, 2, 'F1 Score', 'Harmonic mean of precision and recall.', 3, '2026-02-06 16:46:34'),
(8, 2, 'Confusion Matrix', 'Table showing TP/FP/FN/TN counts by class.', 4, '2026-02-06 16:46:34'),
(9, 3, 'FCFS', 'First-Come First-Served: non-preemptive, simplest scheduling.', 1, '2026-02-06 16:46:34'),
(10, 3, 'Round Robin', 'Time-slice scheduling, preemptive, improves fairness.', 2, '2026-02-06 16:46:34'),
(11, 3, 'SJF', 'Shortest Job First: minimizes average waiting time (idealized).', 3, '2026-02-06 16:46:34'),
(12, 5, 'Dereference (*)', 'Access the value stored at the address a pointer points to.', 3, '2026-02-07 20:52:43'),
(13, 5, '& operator', 'Gets the memory address of a variable.', 4, '2026-02-07 20:52:43'),
(14, 5, 'Pointer arithmetic', 'Adding/subtracting moves by sizeof(type).', 5, '2026-02-07 20:52:43'),
(15, 6, 'Inheritance', 'A class can extend another class to reuse/override behavior.', 3, '2026-02-07 20:52:43'),
(16, 6, 'Abstraction', 'Expose only what matters; hide implementation details.', 4, '2026-02-07 20:52:43'),
(17, 6, 'Override vs Overload', 'Override changes inherited method; overload changes params.', 5, '2026-02-07 20:52:43'),
(18, 7, 'O(n)', 'Linear time: grows with input size.', 3, '2026-02-07 20:52:43'),
(19, 7, 'O(log n)', 'Logarithmic time: halves the problem each step (binary search).', 4, '2026-02-07 20:52:43'),
(20, 7, 'Amortized analysis', 'Average cost over many operations (e.g., dynamic arrays).', 5, '2026-02-07 20:52:43'),
(21, 8, 'Regular language', 'A language recognized by a finite automaton.', 3, '2026-02-07 20:52:43'),
(22, 8, 'ε-transition', 'NFA transition that consumes no input symbol.', 4, '2026-02-07 20:52:43'),
(23, 8, 'DFA vs NFA', 'Equivalent power; NFA may be simpler; DFA deterministic.', 5, '2026-02-07 20:52:43'),
(24, 9, 'Phishing', 'Tricking users into revealing credentials or sensitive data.', 3, '2026-02-07 20:52:43'),
(25, 9, 'Mitigation: parameterized queries', 'Prevents SQL injection by separating code and data.', 4, '2026-02-07 20:52:43'),
(26, 9, 'Mitigation: output encoding', 'Reduces XSS by safely rendering user input.', 5, '2026-02-07 20:52:44'),
(27, 10, 'Critical section', 'Code region that must not be executed by multiple threads at once.', 3, '2026-02-07 20:52:44'),
(28, 10, 'Deadlock', 'Threads waiting forever due to circular resource waits.', 4, '2026-02-07 20:52:44'),
(29, 10, 'Speedup', 'Parallel runtime improvement: T_serial / T_parallel.', 5, '2026-02-07 20:52:44'),
(30, 11, 'Pointer', 'A variable that stores a memory address.', 1, '2026-02-10 18:55:31'),
(31, 11, 'NULL pointer', 'A pointer that points to nothing (0).', 2, '2026-02-10 18:55:31'),
(32, 12, 'ls', 'Lists files in a directory.', 1, '2026-02-10 18:55:31'),
(33, 12, 'chmod', 'Changes file permissions.', 2, '2026-02-10 18:55:31'),
(34, 13, 'Encapsulation', 'Bundling data + methods; hiding internal state.', 1, '2026-02-10 18:55:31'),
(35, 13, 'Polymorphism', 'Same interface, different behavior (override).', 2, '2026-02-10 18:55:31'),
(36, 14, 'O(1)', 'Constant time.', 1, '2026-02-10 18:55:31'),
(37, 14, 'O(n log n)', 'Typical for efficient sorts (merge/heap sort).', 2, '2026-02-10 18:55:31'),
(38, 15, 'TCP', 'Reliable, connection-oriented, ordered delivery.', 1, '2026-02-10 18:55:31'),
(39, 15, 'UDP', 'Unreliable, connectionless, lower overhead.', 2, '2026-02-10 18:55:31'),
(40, 16, 'Sprint', 'Fixed-length iteration to deliver work.', 1, '2026-02-10 18:55:31'),
(41, 16, 'Product backlog', 'Prioritized list of work items.', 2, '2026-02-10 18:55:31'),
(42, 17, 'DFA', 'Deterministic finite automaton: one transition per symbol.', 1, '2026-02-10 18:55:32'),
(43, 17, 'NFA', 'Non-deterministic: can have multiple transitions per symbol.', 2, '2026-02-10 18:55:32'),
(44, 18, 'INNER JOIN', 'Only matching rows from both tables.', 1, '2026-02-10 18:55:32'),
(45, 18, 'LEFT JOIN', 'All left rows + matching right rows; NULL if no match.', 2, '2026-02-10 18:55:32'),
(46, 19, 'SQL Injection', 'Injecting SQL through input to manipulate queries.', 1, '2026-02-10 18:55:32'),
(47, 19, 'XSS', 'Injecting scripts into pages viewed by other users.', 2, '2026-02-10 18:55:32'),
(48, 20, 'Race condition', 'Output depends on thread timing; unsafe shared access.', 1, '2026-02-10 18:55:32'),
(49, 20, 'Mutex', 'Lock to protect critical sections.', 2, '2026-02-10 18:55:32'),
(50, 5, 'Dereference (*)', 'Access the value stored at the address a pointer points to.', 3, '2026-02-10 18:56:57'),
(51, 5, '& operator', 'Gets the memory address of a variable.', 4, '2026-02-10 18:56:57'),
(52, 5, 'Pointer arithmetic', 'Adding/subtracting moves by sizeof(type).', 5, '2026-02-10 18:56:57'),
(53, 6, 'Inheritance', 'A class can extend another class to reuse/override behavior.', 3, '2026-02-10 18:56:57'),
(54, 6, 'Abstraction', 'Expose only what matters; hide implementation details.', 4, '2026-02-10 18:56:57'),
(55, 6, 'Override vs Overload', 'Override changes inherited method; overload changes params.', 5, '2026-02-10 18:56:57'),
(56, 7, 'O(n)', 'Linear time: grows with input size.', 3, '2026-02-10 18:56:57'),
(57, 7, 'O(log n)', 'Logarithmic time: halves the problem each step (binary search).', 4, '2026-02-10 18:56:57'),
(58, 7, 'Amortized analysis', 'Average cost over many operations (e.g., dynamic arrays).', 5, '2026-02-10 18:56:57'),
(59, 8, 'Regular language', 'A language recognized by a finite automaton.', 3, '2026-02-10 18:56:57'),
(60, 8, 'ε-transition', 'NFA transition that consumes no input symbol.', 4, '2026-02-10 18:56:58'),
(61, 8, 'DFA vs NFA', 'Equivalent power; NFA may be simpler; DFA deterministic.', 5, '2026-02-10 18:56:58'),
(62, 9, 'Phishing', 'Tricking users into revealing credentials or sensitive data.', 3, '2026-02-10 18:56:58'),
(63, 9, 'Mitigation: parameterized queries', 'Prevents SQL injection by separating code and data.', 4, '2026-02-10 18:56:58'),
(64, 9, 'Mitigation: output encoding', 'Reduces XSS by safely rendering user input.', 5, '2026-02-10 18:56:58'),
(65, 10, 'Critical section', 'Code region that must not be executed by multiple threads at once.', 3, '2026-02-10 18:56:58'),
(66, 10, 'Deadlock', 'Threads waiting forever due to circular resource waits.', 4, '2026-02-10 18:56:58'),
(67, 10, 'Speedup', 'Parallel runtime improvement: T_serial / T_parallel.', 5, '2026-02-10 18:56:58');

-- --------------------------------------------------------

--
-- Table structure for table `study_set_pin`
--

DROP TABLE IF EXISTS `study_set_pin`;
CREATE TABLE IF NOT EXISTS `study_set_pin` (
  `study_set_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `pinned_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`study_set_id`,`user_id`),
  KEY `fk_pin_user` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `study_set_pin`
--

INSERT INTO `study_set_pin` (`study_set_id`, `user_id`, `pinned_at`) VALUES
(1, 1, '2026-02-01 17:05:00'),
(2, 4, '2026-02-02 21:10:00'),
(2, 5, '2026-02-02 21:11:00'),
(3, 3, '2026-02-03 14:00:00'),
(5, 2, '2026-02-10 15:02:00'),
(5, 1, '2026-02-10 15:00:00'),
(6, 4, '2026-02-10 15:06:00'),
(6, 3, '2026-02-10 15:05:00'),
(7, 6, '2026-02-10 15:12:00'),
(7, 5, '2026-02-10 15:10:00'),
(8, 8, '2026-02-10 15:16:00'),
(8, 7, '2026-02-10 15:15:00'),
(9, 2, '2026-02-10 15:22:00'),
(9, 1, '2026-02-10 15:20:00'),
(10, 4, '2026-02-10 15:26:00'),
(10, 3, '2026-02-10 15:25:00'),
(11, 1, '2026-02-10 15:00:00'),
(12, 2, '2026-02-10 15:02:00'),
(13, 3, '2026-02-10 15:04:00'),
(14, 4, '2026-02-10 15:06:00'),
(15, 5, '2026-02-10 15:08:00'),
(16, 6, '2026-02-10 15:10:00'),
(17, 7, '2026-02-10 15:12:00'),
(18, 8, '2026-02-10 15:14:00'),
(19, 1, '2026-02-10 15:16:00'),
(20, 2, '2026-02-10 15:18:00');

-- --------------------------------------------------------

--
-- Table structure for table `study_set_rating`
--

DROP TABLE IF EXISTS `study_set_rating`;
CREATE TABLE IF NOT EXISTS `study_set_rating` (
  `study_set_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `rating` tinyint(4) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`study_set_id`,`user_id`),
  KEY `fk_rating_user` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `study_set_rating`
--

INSERT INTO `study_set_rating` (`study_set_id`, `user_id`, `rating`, `created_at`) VALUES
(1, 1, 5, '2026-02-01 17:00:00'),
(1, 2, 4, '2026-02-01 17:10:00'),
(2, 4, 5, '2026-02-02 21:00:00'),
(2, 5, 4, '2026-02-02 21:05:00'),
(2, 7, 5, '2026-02-03 16:20:00'),
(5, 2, 4, '2026-02-09 14:02:00'),
(5, 1, 5, '2026-02-09 14:00:00'),
(6, 4, 4, '2026-02-09 14:06:00'),
(6, 3, 5, '2026-02-09 14:05:00'),
(7, 6, 4, '2026-02-09 14:12:00'),
(7, 5, 5, '2026-02-09 14:10:00'),
(8, 8, 5, '2026-02-09 14:16:00'),
(8, 7, 4, '2026-02-09 14:15:00'),
(9, 2, 4, '2026-02-09 14:22:00'),
(9, 1, 5, '2026-02-09 14:20:00'),
(10, 4, 5, '2026-02-09 14:26:00'),
(10, 3, 4, '2026-02-09 14:25:00'),
(1, 5, 4, '2026-02-06 15:04:00'),
(1, 4, 5, '2026-02-06 15:02:00'),
(1, 3, 4, '2026-02-06 15:00:00'),
(2, 6, 5, '2026-02-06 16:04:00'),
(2, 2, 4, '2026-02-06 16:02:00'),
(2, 1, 5, '2026-02-06 16:00:00'),
(3, 8, 5, '2026-02-06 17:02:00'),
(3, 7, 4, '2026-02-06 17:00:00'),
(4, 7, 5, '2026-02-06 18:04:00'),
(4, 6, 4, '2026-02-06 18:02:00'),
(4, 2, 3, '2026-02-06 18:00:00'),
(11, 1, 5, '2026-02-09 14:00:00'),
(12, 2, 4, '2026-02-09 14:02:00'),
(13, 3, 5, '2026-02-09 14:04:00'),
(14, 4, 4, '2026-02-09 14:06:00'),
(15, 5, 5, '2026-02-09 14:08:00'),
(16, 6, 4, '2026-02-09 14:10:00'),
(17, 7, 4, '2026-02-09 14:12:00'),
(18, 8, 5, '2026-02-09 14:14:00'),
(19, 1, 5, '2026-02-09 14:16:00'),
(20, 2, 4, '2026-02-09 14:18:00');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
