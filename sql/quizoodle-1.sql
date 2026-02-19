-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Feb 06, 2026 at 04:58 PM
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
) ;

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
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `assignment`
--

INSERT INTO `assignment` (`assignment_id`, `course_id`, `title`, `description`, `due_at`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 4999, 'Capstone - Project Idea Report', 'Submit project idea report and team info.', '2026-02-07 23:59:00', 11, '2026-02-01 14:00:00', '2026-02-01 14:00:00'),
(2, 4700, 'Software Security Lab 1', 'Linux permissions + basic security tasks.', '2026-02-14 23:59:00', 12, '2026-02-02 15:00:00', '2026-02-02 15:00:00'),
(3, 4810, 'Data Mining HW2', 'Train a classifier and report accuracy.', '2026-02-18 23:59:00', 13, '2026-02-03 16:00:00', '2026-02-03 16:00:00'),
(4, 4500, 'Operating Systems Checkpoint', 'Scheduling writeup + code checkpoint.', '2026-02-20 23:59:00', 12, '2026-02-04 14:30:00', '2026-02-04 14:30:00'),
(5, 4999, 'Capstone - ERD Draft', 'Draft ERD for core tables.', '2026-02-21 23:59:00', 11, '2026-02-05 13:30:00', '2026-02-05 13:30:00');

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
) ;

--
-- Dumping data for table `assignment_status`
--

INSERT INTO `assignment_status` (`assignment_id`, `user_id`, `status`, `updated_at`) VALUES
(1, 1, 'done', '2026-02-05 16:21:01'),
(1, 2, 'done', '2026-02-05 16:21:01'),
(1, 3, 'done', '2026-02-05 16:21:01'),
(1, 4, 'done', '2026-02-05 16:21:01'),
(1, 5, 'done', '2026-02-05 16:21:01'),
(2, 1, 'in_progress', '2026-02-05 16:21:01'),
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
(5, 7, 'to_do', '2026-02-05 16:21:01');

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
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `chat`
--

INSERT INTO `chat` (`chat_id`, `course_id`, `chat_name`, `is_direct`, `created_by`, `created_at`) VALUES
(1, 4999, 'CSI-4999 Team Chat', 0, 1, '2026-02-01 14:00:00'),
(2, 4700, 'CSI-4700 Lab Help', 0, 12, '2026-02-02 18:00:00'),
(3, 4810, 'CSI-4810 Homework Q&A', 0, 13, '2026-02-03 20:00:00'),
(4, NULL, 'Direct: Mia ↔ Dr. Jawad', 1, 1, '2026-02-04 15:00:00');

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
(4500, 'CSI-4500', 'Operating Systems', 'Processes, scheduling, and OS design.', 12, '2026-01-10 14:30:00', NULL);

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
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `course_resource`
--

INSERT INTO `course_resource` (`resource_id`, `course_id`, `title`, `resource_type`, `url`, `created_by`, `created_at`) VALUES
(1, 4999, 'Capstone Syllabus', 'pdf', 'https://oakland.edu/capstone/syllabus', 11, '2026-01-12 15:00:00'),
(2, 4999, 'Project Deliverables Checklist', 'link', 'https://oakland.edu/capstone/deliverables', 11, '2026-01-12 15:05:00'),
(3, 4700, 'Lab 1 Instructions', 'pdf', 'https://oakland.edu/security/lab1', 12, '2026-01-13 17:00:00'),
(4, 4810, 'Lecture Slides - Classification', 'slides', 'https://oakland.edu/ml/slides/classification', 13, '2026-01-14 19:00:00'),
(5, 4500, 'Scheduling Notes', 'link', 'https://oakland.edu/os/scheduling', 12, '2026-01-15 14:00:00');

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
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `study_set`
--

INSERT INTO `study_set` (`study_set_id`, `course_id`, `title`, `description`, `visibility`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 4700, 'Security Lab 1 - Key Terms', 'Quick flashcards for permissions, users, groups.', 'public', 9, '2026-01-20 23:00:00', NULL),
(2, 4810, 'ML Metrics Cheat Sheet', 'Precision/Recall/F1 + confusion matrix basics.', 'public', 10, '2026-01-21 19:30:00', NULL),
(3, 4500, 'OS Scheduling Algorithms', 'FCFS, SJF, RR, priority scheduling review.', 'unlisted', 9, '2026-01-23 00:10:00', NULL),
(4, NULL, 'General Study Habits', 'Short reminders + tips for weekly planning.', 'private', 10, '2026-01-23 14:00:00', NULL);
(5, 4700, 'Security Lab 2 - Cryptography Basics', 'Flashcards for symmetric/asymmetric encryption, hashing, and digital signatures.', 'public', 9, '2026-02-07 10:00:00'),
(6, 4810, 'Data Mining Algorithms', 'Decision trees, k-NN, SVM, and neural network concepts.', 'public', 10, '2026-02-08 14:30:00'),
(7, 4500, 'Memory Management Concepts', 'Paging, segmentation, virtual memory, and caching.', 'public', 9, '2026-02-09 16:45:00'),
(8, 4999, 'Capstone Project Management Terms', 'Agile, Scrum, Gantt charts, and project documentation.', 'public', 10, '2026-02-10 11:20:00'),
(9, 4700, 'Network Security Fundamentals', 'Firewalls, VPNs, IDS/IPS, and secure protocols.', 'unlisted', 9, '2026-02-11 09:15:00'),
(10, 4810, 'Python Libraries for Data Science', 'Pandas, NumPy, Scikit-learn, Matplotlib essentials.', 'private', 10, '2026-02-12 13:40:00'),
(11, 4500, 'Process Synchronization', 'Mutex, semaphores, monitors, and deadlock prevention.', 'public', 9, '2026-02-13 15:25:00'),
(12, NULL, 'General Programming Concepts', 'OOP, data structures, algorithms, and design patterns.', 'public', 10, '2026-02-14 12:10:00');

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
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(11, 3, 'SJF', 'Shortest Job First: minimizes average waiting time (idealized).', 3, '2026-02-06 16:46:34');

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
(3, 3, '2026-02-03 14:00:00');

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
(2, 7, 5, '2026-02-03 16:20:00');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
