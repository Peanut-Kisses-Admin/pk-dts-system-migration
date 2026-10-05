-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 05, 2026 at 06:08 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `document_tracking`
--

-- --------------------------------------------------------

--
-- Table structure for table `account_registration_requests`
--

CREATE TABLE `account_registration_requests` (
  `registration_id` bigint(20) NOT NULL,
  `reference_code` varchar(40) NOT NULL,
  `firstname` varchar(100) NOT NULL,
  `lastname` varchar(100) NOT NULL,
  `middlename` varchar(100) DEFAULT NULL,
  `username` varchar(150) NOT NULL,
  `position_title` varchar(100) DEFAULT NULL,
  `applicant_remarks` text DEFAULT NULL,
  `password_hash` varchar(255) NOT NULL,
  `status` enum('PENDING','APPROVED','REJECTED') NOT NULL DEFAULT 'PENDING',
  `review_remarks` text DEFAULT NULL,
  `requested_role_id` bigint(20) NOT NULL,
  `assigned_role_id` bigint(20) DEFAULT NULL,
  `reviewed_by_user_id` bigint(20) DEFAULT NULL,
  `reviewed_at` datetime(3) DEFAULT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updated_at` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `areas`
--

CREATE TABLE `areas` (
  `area_id` bigint(20) NOT NULL,
  `area_name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `areas`
--

INSERT INTO `areas` (`area_id`, `area_name`) VALUES
(1, 'ADMIN OFFICE'),
(2, 'UNSPECIFIED AREA'),
(3, 'PRODUCTION OFFICE'),
(4, 'MAINTENANCE OFFICE');

-- --------------------------------------------------------

--
-- Table structure for table `asset_numbers`
--

CREATE TABLE `asset_numbers` (
  `asset_id` bigint(20) NOT NULL,
  `asset_number` varchar(100) NOT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `specific_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `asset_numbers`
--

INSERT INTO `asset_numbers` (`asset_id`, `asset_number`, `created_at`, `specific_id`) VALUES
(1, 'PK-PNK-00106945', '2026-07-11 03:31:54.627', NULL),
(2, 'PK - PNK - 00106947', '2026-07-11 03:31:55.763', NULL),
(3, 'PK-PNK-00106948', '2026-07-11 03:31:56.020', NULL),
(4, 'PK - PNK - 00107744', '2026-07-11 03:31:57.622', NULL),
(5, '012-0000424500004', '2026-07-11 03:32:05.420', NULL),
(6, '012-0000424500001', '2026-07-11 03:32:05.810', NULL),
(7, '012-0000424500002', '2026-07-11 03:32:06.930', NULL),
(8, '012-0000424500003', '2026-07-11 03:32:07.502', NULL),
(9, '012-0000424500005', '2026-07-11 03:32:08.743', NULL),
(10, '012-0000424500006', '2026-07-11 03:32:09.701', NULL),
(11, '0012-0000424500007', '2026-08-15 07:53:57.915', NULL),
(12, '0012-0000424500008', '2026-08-15 07:54:36.507', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `audit_log_id` bigint(20) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `user_name` varchar(220) NOT NULL,
  `user_username` varchar(150) NOT NULL,
  `role_name` varchar(100) NOT NULL,
  `action` varchar(30) NOT NULL,
  `module` varchar(100) NOT NULL,
  `description` varchar(500) NOT NULL,
  `method` varchar(10) NOT NULL,
  `path` varchar(500) NOT NULL,
  `entity_id` varchar(100) DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `before_state` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`before_state`)),
  `after_state` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`after_state`)),
  `reason` text DEFAULT NULL,
  `workflow_context` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`workflow_context`)),
  `ip_address` varchar(100) DEFAULT NULL,
  `user_agent` varchar(500) DEFAULT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `audit_logs`
--

INSERT INTO `audit_logs` (`audit_log_id`, `user_id`, `user_name`, `user_username`, `role_name`, `action`, `module`, `description`, `method`, `path`, `entity_id`, `metadata`, `before_state`, `after_state`, `reason`, `workflow_context`, `ip_address`, `user_agent`, `created_at`) VALUES
(1, NULL, 'Admin User', 'admin', 'Admin', 'LOGIN', 'auth', 'signed in successfully', 'POST', '/api/v1/auth/login', '1', '{\"username\":\"admin\"}', NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-05 01:28:43.730'),
(2, NULL, 'Admin User', 'admin', 'Admin', 'CREATE', 'backup-restore', 'created backups', 'POST', '/api/v1/backup-restore/backups', NULL, '{\"params\":{},\"query\":{},\"body\":{}}', '{}', '{\"success\":true,\"path\":\"/api/v1/backup-restore/backups\",\"timestamp\":\"2026-10-05T01:29:33.522Z\",\"data\":{\"backup_id\":\"backup-2026-10-05_01-29-33-500Z-q8zoj4\",\"file_name\":\"backup-2026-10-05_01-29-33-500Z-q8zoj4.zip\",\"created_at\":\"2026-10-05T01:29:33.500Z\",\"created_by\":\"admin\",\"size_bytes\":4545,\"record_count\":298,\"schema_version\":3}}', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 01:29:33.525'),
(3, NULL, 'Admin User', 'admin', 'Admin', 'CREATE', 'backup-restore', 'created backups', 'POST', '/api/v1/backup-restore/backups', NULL, '{\"params\":{},\"query\":{},\"body\":{}}', '{}', '{\"success\":true,\"path\":\"/api/v1/backup-restore/backups\",\"timestamp\":\"2026-10-05T01:29:39.803Z\",\"data\":{\"backup_id\":\"backup-2026-10-05_01-29-39-796Z-jgoqvb\",\"file_name\":\"backup-2026-10-05_01-29-39-796Z-jgoqvb.zip\",\"created_at\":\"2026-10-05T01:29:39.796Z\",\"created_by\":\"admin\",\"size_bytes\":4546,\"record_count\":298,\"schema_version\":3}}', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 01:29:39.806'),
(4, NULL, 'Unknown user', 'jhosh86confi@gmail.com', 'UNKNOWN', 'LOGIN_FAILED', 'auth', 'failed to sign in', 'POST', '/api/v1/auth/login', NULL, '{\"username\":\"jhosh86confi@gmail.com\"}', NULL, NULL, 'Invalid username or password.', NULL, NULL, NULL, '2026-10-05 02:08:47.262'),
(5, NULL, 'Unknown user', 'jhosh86confi@gmail.com', 'UNKNOWN', 'LOGIN_FAILED', 'auth', 'failed to sign in', 'POST', '/api/v1/auth/login', NULL, '{\"username\":\"jhosh86confi@gmail.com\"}', NULL, NULL, 'Invalid username or password.', NULL, NULL, NULL, '2026-10-05 02:08:52.940'),
(6, NULL, 'Admin User', 'admin', 'Admin', 'LOGIN', 'auth', 'signed in successfully', 'POST', '/api/v1/auth/login', '1', '{\"username\":\"admin\"}', NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-05 02:09:27.069'),
(7, NULL, 'Admin User', 'admin', 'Admin', 'LOGIN', 'auth', 'signed in successfully', 'POST', '/api/v1/auth/login', '1', '{\"username\":\"admin\"}', NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-05 02:09:47.210'),
(8, NULL, 'Admin User', 'admin', 'Admin', 'LOGIN', 'auth', 'signed in successfully', 'POST', '/api/v1/auth/login', '1', '{\"username\":\"admin\"}', NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-05 02:44:41.324'),
(10, 2, 'Admin User', 'admin', 'Admin', 'LOGIN', 'auth', 'signed in successfully', 'POST', '/api/v1/auth/login', '2', '{\"username\":\"admin\"}', NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-05 02:48:53.056'),
(11, 8, 'John Paul Curib', 'curibtech@gmail.com', 'Documentation Officer', 'LOGIN', 'auth', 'signed in successfully', 'POST', '/api/v1/auth/login', '8', '{\"username\":\"curibtech@gmail.com\"}', NULL, NULL, NULL, NULL, NULL, NULL, '2026-10-05 02:50:25.377');

-- --------------------------------------------------------

--
-- Table structure for table `documents`
--

CREATE TABLE `documents` (
  `document_id` bigint(20) NOT NULL,
  `document_title` varchar(255) NOT NULL,
  `document_type` enum('SOFTCOPY','HARDCOPY') NOT NULL,
  `status` enum('Draft','PendingApproval','ForNotedBy','ForPlantManagerApproval','ForDocumentControllerAdmin','ForApproval','ForTransfer','Transferred','PendingRecipientAcceptance','Approved','Completed','ReturnedForCorrection','Cancelled','Rejected','ForRevision','Disposed') NOT NULL DEFAULT 'Draft',
  `request_date` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `department` varchar(150) DEFAULT NULL,
  `business_document_type` enum('Forms','Manual','Procedures','WorkInstruction','Monitoring','Others') DEFAULT NULL,
  `action_requested` enum('CREATE','REVISE','CREATE_REVISE','CANCELLATION') NOT NULL DEFAULT 'CREATE_REVISE',
  `from_party` varchar(150) DEFAULT NULL,
  `to_party` varchar(150) DEFAULT NULL,
  `reason_for_change` enum('Improvement','CorrectionOfPreviousReleases','Others') DEFAULT NULL,
  `brief_description` text DEFAULT NULL,
  `proposed_change` text DEFAULT NULL,
  `revision_level_from` varchar(50) DEFAULT NULL,
  `revision_level_to` varchar(50) DEFAULT NULL,
  `previous_effective_date` datetime(3) DEFAULT NULL,
  `new_effective_date` datetime(3) DEFAULT NULL,
  `date_received` datetime(3) DEFAULT NULL,
  `date_released` datetime(3) DEFAULT NULL,
  `approval_date` datetime(3) DEFAULT NULL,
  `legacy_imported` tinyint(1) NOT NULL DEFAULT 0,
  `creation_source` varchar(30) NOT NULL DEFAULT 'DCR',
  `creation_reason` text DEFAULT NULL,
  `direct_created_at` datetime(3) DEFAULT NULL,
  `legacy_import_note` text DEFAULT NULL,
  `status_before_disposal` enum('Draft','PendingApproval','ForNotedBy','ForPlantManagerApproval','ForDocumentControllerAdmin','ForApproval','ForTransfer','Transferred','PendingRecipientAcceptance','Approved','Completed','ReturnedForCorrection','Cancelled','Rejected','ForRevision','Disposed') DEFAULT NULL,
  `requested_by_name` varchar(150) DEFAULT NULL,
  `disposal_remarks` text DEFAULT NULL,
  `disposal_action` enum('Shred','Scratch','Reuse','Other') DEFAULT NULL,
  `disposal_action_other` varchar(150) DEFAULT NULL,
  `disposed_at` datetime(3) DEFAULT NULL,
  `disposed_by_name` varchar(150) DEFAULT NULL,
  `created_by` bigint(20) NOT NULL,
  `requested_by_user_id` bigint(20) DEFAULT NULL,
  `disposed_by_user_id` bigint(20) DEFAULT NULL,
  `reviewed_by_user_id` bigint(20) DEFAULT NULL,
  `reviewed_at` datetime(3) DEFAULT NULL,
  `reviewer_remarks` text DEFAULT NULL,
  `workflow_version_id` bigint(20) DEFAULT NULL,
  `workflow_snapshot` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`workflow_snapshot`)),
  `workflow_current_node_key` varchar(100) DEFAULT NULL,
  `source_document_id` bigint(20) DEFAULT NULL,
  `source_document_updated_at` datetime(3) DEFAULT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updated_at` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `documents`
--

INSERT INTO `documents` (`document_id`, `document_title`, `document_type`, `status`, `request_date`, `department`, `business_document_type`, `action_requested`, `from_party`, `to_party`, `reason_for_change`, `brief_description`, `proposed_change`, `revision_level_from`, `revision_level_to`, `previous_effective_date`, `new_effective_date`, `date_received`, `date_released`, `approval_date`, `legacy_imported`, `creation_source`, `creation_reason`, `direct_created_at`, `legacy_import_note`, `status_before_disposal`, `requested_by_name`, `disposal_remarks`, `disposal_action`, `disposal_action_other`, `disposed_at`, `disposed_by_name`, `created_by`, `requested_by_user_id`, `disposed_by_user_id`, `reviewed_by_user_id`, `reviewed_at`, `reviewer_remarks`, `workflow_version_id`, `workflow_snapshot`, `workflow_current_node_key`, `source_document_id`, `source_document_updated_at`, `created_at`, `updated_at`) VALUES
(1, 'EXTERNAL MEMO', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:54.632', '2026-07-11 03:31:54.632'),
(2, 'IN-HOUSE MEMO', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:54.708', '2026-07-11 03:31:54.708'),
(3, 'IN-HOUSE INCIDENT REPORT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:54.720', '2026-07-11 03:31:54.720'),
(4, 'QA - INCIDENT REPORT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:54.732', '2026-07-11 03:31:54.732'),
(5, 'APPROVED INTERNAL REQUEST', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:54.744', '2026-07-11 03:31:54.744'),
(6, 'SSD REPORT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:54.755', '2026-07-11 03:31:54.755'),
(7, 'HR RELATED DOCUMENTS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:54.767', '2026-07-11 03:31:54.767'),
(8, 'FDA & IPO', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:54.777', '2026-07-11 03:31:54.777'),
(9, 'APPROVED NEW PRICES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:54.789', '2026-07-11 03:31:54.789'),
(10, 'PRODUCT - PEANUT KISSES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:54.801', '2026-07-11 03:31:54.801'),
(11, 'PRODUCT - BISCOTTI', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:54.809', '2026-07-11 03:31:54.809'),
(12, 'PRODUCT - PEANUT HOPIA', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:54.819', '2026-07-11 03:31:54.819'),
(13, 'PRODUCT - CRUNCHY COOKIES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:54.827', '2026-07-11 03:31:54.827'),
(14, 'SUBORDINATES MISCONDUCT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:54.835', '2026-07-11 03:31:54.835'),
(15, 'COMPANY UNIFORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:54.845', '2026-07-11 03:31:54.845'),
(16, 'EMERGENCY RESPONSE TEAM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:54.859', '2026-07-11 03:31:54.859'),
(17, 'HOUSE RULE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:54.870', '2026-07-11 03:31:54.870'),
(18, 'MARKETING PROMOS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:54.879', '2026-07-11 03:31:54.879'),
(19, 'PROCESS FLOWS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:54.887', '2026-07-11 03:31:54.887'),
(20, 'PUNCHLIST', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:54.897', '2026-07-11 03:31:54.897'),
(21, 'ADMIN MEMOS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:54.905', '2026-07-11 03:31:54.905'),
(22, 'APPROVED EXTERNAL REQUEST', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:54.916', '2026-07-11 03:31:54.916'),
(23, 'TRADE CHANNEL SUPPORT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:54.928', '2026-07-11 03:31:54.928'),
(24, 'CLEANING AND SANITATION AUDIT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:54.940', '2026-07-11 03:31:54.940'),
(25, 'CORRECTED LETTERS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:54.951', '2026-07-11 03:31:54.951'),
(26, 'EMAILED DOCUMENTS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:54.962', '2026-07-11 03:31:54.962'),
(27, 'EMAILED QUOTATION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:54.972', '2026-07-11 03:31:54.972'),
(28, 'EXTERNAL SUPPLIER COMPLAINT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:54.983', '2026-07-11 03:31:54.983'),
(29, 'GOVERNMENT RELATED DOCS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:54.992', '2026-07-11 03:31:54.992'),
(30, 'HOT WORK PERMIT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.006', '2026-07-11 03:31:55.006'),
(31, 'IN-HOUSE POLICIES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.016', '2026-07-11 03:31:55.016'),
(32, 'INTERNAL SUPPLIER COMPLAINT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.024', '2026-07-11 03:31:55.024'),
(33, 'MEETING ATTENDANCE - INTERNAL', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.036', '2026-07-11 03:31:55.036'),
(34, 'MINUTES OF MEETING -SUPPORT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.046', '2026-07-11 03:31:55.046'),
(35, 'MINUTES OF MEETING - SUPPLIER', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.054', '2026-07-11 03:31:55.054'),
(36, 'MONTHLY C&S CONSUMPTION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.065', '2026-07-11 03:31:55.065'),
(37, 'OBSOLETE ASSETS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.076', '2026-07-11 03:31:55.076'),
(38, 'PACKAGING MATERIAL EVALUATION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.086', '2026-07-11 03:31:55.086'),
(39, 'PACKAGING MATERIAL SPECS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.095', '2026-07-11 03:31:55.095'),
(40, 'PENDING EXTERNAL REQUEST', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.105', '2026-07-11 03:31:55.105'),
(41, 'MARKET PROFILE/MARKETING STRAT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.117', '2026-07-11 03:31:55.117'),
(42, 'PROJECT REPAIR', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.129', '2026-07-11 03:31:55.129'),
(43, 'PRODUCTION FORECAST', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.139', '2026-07-11 03:31:55.139'),
(44, 'PROJECTS & INNOVATIONS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.151', '2026-07-11 03:31:55.151'),
(45, 'TRADE PARTNER - MAX\'S GROUP', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.162', '2026-07-11 03:31:55.162'),
(46, 'PEST CONTROLLER - ENTECH', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.172', '2026-07-11 03:31:55.172'),
(47, 'QUALITY AUDIT RESULTS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.181', '2026-07-11 03:31:55.181'),
(48, 'QUOTATION FROM SUPPLIERS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.190', '2026-07-11 03:31:55.190'),
(49, 'R&D REPORTS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.200', '2026-07-11 03:31:55.200'),
(50, 'RAW MATERIAL EVALUATION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.212', '2026-07-11 03:31:55.212'),
(51, 'RAW PEANUTS INFORMATION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.223', '2026-07-11 03:31:55.223'),
(52, 'REQUEST FOR AN INVESTIGATION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.232', '2026-07-11 03:31:55.232'),
(53, 'SERVICE/CONTRACT TERMINATION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.240', '2026-07-11 03:31:55.240'),
(54, 'SUPPLIER - CEBU BSR', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.250', '2026-07-11 03:31:55.250'),
(55, 'THERMOKING SV-SERIES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.262', '2026-07-11 03:31:55.262'),
(56, 'TRADE CHANNEL MEMOS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.272', '2026-07-11 03:31:55.272'),
(57, 'TRADE PARTNER - KORCHINA', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.284', '2026-07-11 03:31:55.284'),
(58, 'EMPLOYEE\'S WAIVER', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.295', '2026-07-11 03:31:55.295'),
(59, 'WELLNESS PROGRAM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.306', '2026-07-11 03:31:55.306'),
(60, 'PROJECT TURN-OVER CERTIFICATE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.318', '2026-07-11 03:31:55.318'),
(61, 'OTHERS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.329', '2026-07-11 03:31:55.329'),
(62, 'SUPPLIER COMPLAINT FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.338', '2026-07-11 03:31:55.338'),
(63, 'FINISHED PRODUCT SPECIFICATION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.364', '2026-07-11 03:31:55.364'),
(64, 'TRADE PARTNER - TPC', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.385', '2026-07-11 03:31:55.385'),
(65, 'QUALITY AUDIT RESULTS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.396', '2026-07-11 03:31:55.396'),
(66, 'SOP - EGG BREAKING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.407', '2026-07-11 03:31:55.407'),
(67, 'SOP - FORMING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.418', '2026-07-11 03:31:55.418'),
(68, 'SOP - PEANUT SECTION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.426', '2026-07-11 03:31:55.426'),
(69, 'DISTRIBUTOR MANAGEMENT POLICY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.468', '2026-07-11 03:31:55.468'),
(70, 'MERCHANDIDING POLICY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.481', '2026-07-11 03:31:55.481'),
(71, 'PRICING POLICY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.495', '2026-07-11 03:31:55.495'),
(72, 'RECOGNITION PROGRAM - WALL OF FAME', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.505', '2026-07-11 03:31:55.505'),
(73, 'COVID-19 POLICY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.515', '2026-07-11 03:31:55.515'),
(74, 'TUNNEL OVEN MANUAL', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.523', '2026-07-11 03:31:55.523'),
(75, 'ROBINSON\'S HANDBOOK', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.534', '2026-07-11 03:31:55.534'),
(76, 'BANK DEPOSIT PROCESS FLOW', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.543', '2026-07-11 03:31:55.543'),
(77, 'FIRE INSURANCE POLICY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.551', '2026-07-11 03:31:55.551'),
(78, 'EMPLOYEE\'S CERTIFICATE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.561', '2026-07-11 03:31:55.561'),
(79, 'PRODUCTION OFFICE SUPPLIES POLICY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.570', '2026-07-11 03:31:55.570'),
(80, 'TRAINING ROADMAP', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.578', '2026-07-11 03:31:55.578'),
(81, 'GS1 BARCODE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.590', '2026-07-11 03:31:55.590'),
(82, 'NESCO CONTRACT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.601', '2026-07-11 03:31:55.601'),
(83, 'BUSINESS CONTINGENCY PLAN', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.612', '2026-07-11 03:31:55.612'),
(84, 'FIRE EXTINGUISHER INSPECTION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.621', '2026-07-11 03:31:55.621'),
(85, 'ADCOM MEETING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.633', '2026-07-11 03:31:55.633'),
(86, 'GAS DAILY USAGE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.642', '2026-07-11 03:31:55.642'),
(87, 'SALARY ADJUSTMENT (PRINTED)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.652', '2026-07-11 03:31:55.652'),
(88, 'PEANUT KISSES LAYOUT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.662', '2026-07-11 03:31:55.662'),
(89, 'FLEET MONITORING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.674', '2026-07-11 03:31:55.674'),
(90, 'DISPLAY RACK MONITORING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.685', '2026-07-11 03:31:55.685'),
(91, 'NEW PK FIXED ASSETS MONITORING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.697', '2026-07-11 03:31:55.697'),
(92, 'SUGAR R.S', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.705', '2026-07-11 03:31:55.705'),
(93, 'VANILLA R.S', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.715', '2026-07-11 03:31:55.715'),
(94, 'CARLO MASTER R.S', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.725', '2026-07-11 03:31:55.725'),
(95, 'EGG R.S & DISPOSAL R.S', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.734', '2026-07-11 03:31:55.734'),
(96, 'PEANUT R.S', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.746', '2026-07-11 03:31:55.746'),
(97, 'BORROWERS SLIP-FIXED ASSETS MONITORING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.753', '2026-07-11 03:31:55.753'),
(98, 'INACTIVE 201 FILES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.765', '2026-07-11 03:31:55.765'),
(99, 'INACTIVE NESCO FILES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.774', '2026-07-11 03:31:55.774'),
(100, 'EMPLOYEE\'S PROFILE SUMMARY-2010 & BELOW', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.787', '2026-07-11 03:31:55.787'),
(101, 'EMPLOYEE\'S PROFILE SUMMARY-2011', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.797', '2026-07-11 03:31:55.797');
INSERT INTO `documents` (`document_id`, `document_title`, `document_type`, `status`, `request_date`, `department`, `business_document_type`, `action_requested`, `from_party`, `to_party`, `reason_for_change`, `brief_description`, `proposed_change`, `revision_level_from`, `revision_level_to`, `previous_effective_date`, `new_effective_date`, `date_received`, `date_released`, `approval_date`, `legacy_imported`, `creation_source`, `creation_reason`, `direct_created_at`, `legacy_import_note`, `status_before_disposal`, `requested_by_name`, `disposal_remarks`, `disposal_action`, `disposal_action_other`, `disposed_at`, `disposed_by_name`, `created_by`, `requested_by_user_id`, `disposed_by_user_id`, `reviewed_by_user_id`, `reviewed_at`, `reviewer_remarks`, `workflow_version_id`, `workflow_snapshot`, `workflow_current_node_key`, `source_document_id`, `source_document_updated_at`, `created_at`, `updated_at`) VALUES
(102, 'EMPLOYEE\'S PROFILE SUMMARY-2012', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.805', '2026-07-11 03:31:55.805'),
(103, 'EMPLOYEE\'S PROFILE SUMMARY-2013', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.813', '2026-07-11 03:31:55.813'),
(104, 'EMPLOYEE\'S PROFILE A-Z 2022', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.821', '2026-07-11 03:31:55.821'),
(105, 'EMPLOYEE\'S PROFILE A-Z 2022-2023', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.829', '2026-07-11 03:31:55.829'),
(106, 'BFPC MEMO - HR\'S COPY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.836', '2026-07-11 03:31:55.836'),
(107, 'MFI MEMO - HR\'S COPY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.846', '2026-07-11 03:31:55.846'),
(108, 'COMPOUND MEMO', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.853', '2026-07-11 03:31:55.853'),
(109, 'X-RAY RESULT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.861', '2026-07-11 03:31:55.861'),
(110, 'PERSONNEL REQUISITION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.869', '2026-07-11 03:31:55.869'),
(111, 'SSD INCIDENT REPORT - HR\'S COPY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.878', '2026-07-11 03:31:55.878'),
(112, 'ENDORSEMENT LETTER', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.885', '2026-07-11 03:31:55.885'),
(113, 'ORIENTATION MANUAL FOR NEWLY HIRED EMPLOYEE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.894', '2026-07-11 03:31:55.894'),
(114, 'INCIDENT REPORT- BFPC-PK', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.902', '2026-07-11 03:31:55.902'),
(115, 'INCIDENT REPORT- MFI-NF', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.910', '2026-07-11 03:31:55.910'),
(116, 'SPECIAL BRIEFING MANUAL', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.918', '2026-07-11 03:31:55.918'),
(117, 'SPOT REPORT HR\'S COPY 2025', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.926', '2026-07-11 03:31:55.926'),
(118, 'CERTIFICATE OF ORIENTATION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.935', '2026-07-11 03:31:55.935'),
(119, 'KEY RESPONSIBILITY AREA', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.945', '2026-07-11 03:31:55.945'),
(120, 'EMPLOYEE\'S INJURY/ILLNESS REPORT FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.952', '2026-07-11 03:31:55.952'),
(121, 'HOUSE RULES HR\'S COPY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.960', '2026-07-11 03:31:55.960'),
(122, 'IMMERSION MOA', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.969', '2026-07-11 03:31:55.969'),
(123, 'SPOT REPORT HR\'S COPY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.979', '2026-07-11 03:31:55.979'),
(124, 'CLINIC MEMOS HR\'S COPY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.986', '2026-07-11 03:31:55.986'),
(125, 'WRITTEN EXPLANATION FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:55.995', '2026-07-11 03:31:55.995'),
(126, 'BANK STATEMENT- BDO', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.005', '2026-07-11 03:31:56.005'),
(127, 'BANK STATEMENT- BPI (PAG-IBIG)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.013', '2026-07-11 03:31:56.013'),
(128, 'BANK STATEMENT- BPI (SAVINGS)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.021', '2026-07-11 03:31:56.021'),
(129, 'PAYROLL SUMMARY - INTERNAL AUDIT 2020', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.030', '2026-07-11 03:31:56.030'),
(130, 'PAYROLL SUMMARY - INTERNAL AUDIT 2021', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.039', '2026-07-11 03:31:56.039'),
(131, 'DEPOSIT SLIPS - FCB', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.050', '2026-07-11 03:31:56.050'),
(132, 'DEPOSIT SLIPS - FCB 2023 - PRESENT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.058', '2026-07-11 03:31:56.058'),
(133, 'RECEITS FROM INTERNAL AUDIT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.068', '2026-07-11 03:31:56.068'),
(134, 'DEATH AIDE SUMMARY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.076', '2026-07-11 03:31:56.076'),
(135, 'MAYOR\'S PERMIT - 2023', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.084', '2026-07-11 03:31:56.084'),
(136, 'MAYOR\'S PERMIT - 2024', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.094', '2026-07-11 03:31:56.094'),
(137, 'AUDITED DAILY SALES REPORT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.104', '2026-07-11 03:31:56.104'),
(138, 'STATEMENT OF ACCOUNT - PNB', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.112', '2026-07-11 03:31:56.112'),
(139, 'LANDBANK PAYROLL ACCOUNT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.122', '2026-07-11 03:31:56.122'),
(140, 'LANDBANK PAYROLL 2024', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.130', '2026-07-11 03:31:56.130'),
(141, 'PAYROLL AE 2024', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.138', '2026-07-11 03:31:56.138'),
(142, 'AUDITED SALES SUMMARY 2024-2025', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.151', '2026-07-11 03:31:56.151'),
(143, 'AUDITED DAILY SALES REPORT CURRENT YEAR', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.163', '2026-07-11 03:31:56.163'),
(144, 'TRADE CHANNEL RECEIPTS - MAX\'S GROUP INC.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.174', '2026-07-11 03:31:56.174'),
(145, 'TRADE CHANNEL RECEIPTS - COLONNADE COLON', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.185', '2026-07-11 03:31:56.185'),
(146, 'TRADE CHANNEL RECEIPTS - COLONNADE MANDAUE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.194', '2026-07-11 03:31:56.194'),
(147, 'TRADE CHANNEL RECEIPTS - JAMITO, MATEO', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.202', '2026-07-11 03:31:56.202'),
(148, 'TRADE CHANNEL RECEIPTS - SHAMROCK BAKERY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.210', '2026-07-11 03:31:56.210'),
(149, 'TRADE CHANNEL RECEIPTS - GRANDMALL', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.218', '2026-07-11 03:31:56.218'),
(150, 'TRADE CHANNEL RECEIPTS - METRO GROUP', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.228', '2026-07-11 03:31:56.228'),
(151, 'TRADE CHANNEL RECEIPTS - PIE ALTURAS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.237', '2026-07-11 03:31:56.237'),
(152, 'TRADE CHANNEL RECEIPTS - LORENZO PADILLA / SIPA KING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.247', '2026-07-11 03:31:56.247'),
(153, 'TRADE CHANNEL RECEIPTS - PAX MONTERONA / CEBU RIFFIC', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.257', '2026-07-11 03:31:56.257'),
(154, 'TRADE CHANNEL RECEIPTS - R & L TRADING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.267', '2026-07-11 03:31:56.267'),
(155, 'TRADE CHANNEL RECEIPTS - GUIDO YLANA CORP.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.277', '2026-07-11 03:31:56.277'),
(156, 'TRADE CHANNEL RECEIPTS - BONGBONG PIAYA', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.285', '2026-07-11 03:31:56.285'),
(157, 'TRADE CHANNEL RECEIPTS - TEODOLO RASONABE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.292', '2026-07-11 03:31:56.292'),
(158, 'TRADE CHANNEL RECEIPTS - LIYAN ENTERPRISES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.302', '2026-07-11 03:31:56.302'),
(159, 'TRADE CHANNEL RECEIPTS - BABY GENE ABAD', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.311', '2026-07-11 03:31:56.311'),
(160, 'TRADE CHANNEL RECEIPTS - MANILA SALES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.319', '2026-07-11 03:31:56.319'),
(161, 'TRADE CHANNEL RECEIPTS - NIÑA & VINCE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.328', '2026-07-11 03:31:56.328'),
(162, 'TRADE CHANNEL RECEIPTS - ELORA SUPERMARKET', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.335', '2026-07-11 03:31:56.335'),
(163, 'TRADE CHANNEL RECEIPTS - ISLAND PASALUBONG MALL', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.344', '2026-07-11 03:31:56.344'),
(164, 'TRADE CHANNEL RECEIPTS - EVELYN MACROJON', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.353', '2026-07-11 03:31:56.353'),
(165, 'TRADE CHANNEL RECEIPTS - MEMER CEBU', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.362', '2026-07-11 03:31:56.362'),
(166, 'TRADE CHANNEL RECEIPTS - DSG SONS GROUP INC.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.370', '2026-07-11 03:31:56.370'),
(167, 'TRADE CHANNEL RECEIPTS - KRISTINE BALILA', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.379', '2026-07-11 03:31:56.379'),
(168, 'TRADE CHANNEL RECEIPTS - GRAND MOVER', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.387', '2026-07-11 03:31:56.387'),
(169, 'TRADE CHANNEL RECEIPTS - SM/CVI/SMC', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.397', '2026-07-11 03:31:56.397'),
(170, 'TRADE CHANNEL RECEIPTS - EARTH GRAIN INC.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.407', '2026-07-11 03:31:56.407'),
(171, 'TRADE CHANNEL RECEIPTS - GAISANO SUPERSTORE BUTUAN', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.417', '2026-07-11 03:31:56.417'),
(172, 'TRADE CHANNEL RECEIPTS - GAISANO PUERTO', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.428', '2026-07-11 03:31:56.428'),
(173, 'TRADE CHANNEL RECEIPTS - GAISANO CITI SUPERMALL BULUA BRANCH', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.438', '2026-07-11 03:31:56.438'),
(174, 'TRADE CHANNEL RECEIPTS - EUROPACE INCORPORATED', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.450', '2026-07-11 03:31:56.450'),
(175, 'TRADE CHANNEL RECEIPTS - GAISANO CITY - UPTOWN', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.461', '2026-07-11 03:31:56.461'),
(176, 'TRADE CHANNEL RECEIPTS - GAISANO CITY - VALENCIA', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.469', '2026-07-11 03:31:56.469'),
(177, 'TRADE CHANNEL RECEIPTS - GAISANO CITI SUPERMALL/ILLIGAN', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.477', '2026-07-11 03:31:56.477'),
(178, 'TRADE CHANNEL RECEIPTS - GAISANO CAMIGUIN', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.488', '2026-07-11 03:31:56.488'),
(179, 'TRADE CHANNEL RECEIPTS - ISLAND CITY MALL SUPERMARKET', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.498', '2026-07-11 03:31:56.498'),
(180, 'TRADE CHANNEL RECEIPTS - DSG SONS GROUP INC.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.506', '2026-07-11 03:31:56.506'),
(181, 'TRADE CHANNEL RECEIPTS - DALI', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.535', '2026-07-11 03:31:56.535'),
(182, 'TRADE CHANNEL RECEIPTS - KOMPASS RESORT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.554', '2026-07-11 03:31:56.554'),
(183, 'TRADE CHANNEL RECEIPTS - EARTH GRAIN INC.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.571', '2026-08-15 03:13:06.958'),
(184, 'PAYMAYA PAYMENTS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.589', '2026-07-11 03:31:56.589'),
(185, 'TRADE CHANNEL RECEIPTS - GLOBEMERCHANTS INC. BOHOL', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.610', '2026-07-11 03:31:56.610'),
(186, 'TRADE CHANNEL RECEIPTS - GLOBEMERCHANTS INC. CEBU', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.626', '2026-07-11 03:31:56.626'),
(187, 'TRADE CHANNEL RECEIPTS - YELOYOLO', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.643', '2026-07-11 03:31:56.643'),
(188, 'TRADE CHANNEL RECEIPTS - MARILOU GABITO', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.671', '2026-07-11 03:31:56.671'),
(189, 'TRADE CHANNEL RECEIPTS - BAMDECORP', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.680', '2026-07-11 03:31:56.680'),
(190, 'RETURNS, DISPOSAL REPRESENTATION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.690', '2026-07-11 03:31:56.690'),
(191, 'EGGYOLK FORECAST', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.700', '2026-07-11 03:31:56.700'),
(192, 'ACCOMPLISH CHARGE INVOICE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.709', '2026-07-11 03:31:56.709'),
(193, 'SD MONITORING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.717', '2026-07-11 03:31:56.717'),
(194, 'PO FILES CEBU & BOHOL', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.779', '2026-07-11 03:31:56.779'),
(195, 'LIQUADATION CHRISTMAS PARTY, TEAM BUILDING & ANNIVERSARY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.795', '2026-07-11 03:31:56.795'),
(196, 'GIVEAWAYS MONITORING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.809', '2026-07-11 03:31:56.809'),
(197, 'ACCOMPLISHED CONFERENCE RESERVATION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.821', '2026-07-11 03:31:56.821'),
(198, 'ACCOMPLISHED DRIVER SERVICE FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.832', '2026-07-11 03:31:56.832'),
(199, 'FOR FILLING RECEIPTS/SLIP/BILLING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.861', '2026-07-11 03:31:56.861');
INSERT INTO `documents` (`document_id`, `document_title`, `document_type`, `status`, `request_date`, `department`, `business_document_type`, `action_requested`, `from_party`, `to_party`, `reason_for_change`, `brief_description`, `proposed_change`, `revision_level_from`, `revision_level_to`, `previous_effective_date`, `new_effective_date`, `date_received`, `date_released`, `approval_date`, `legacy_imported`, `creation_source`, `creation_reason`, `direct_created_at`, `legacy_import_note`, `status_before_disposal`, `requested_by_name`, `disposal_remarks`, `disposal_action`, `disposal_action_other`, `disposed_at`, `disposed_by_name`, `created_by`, `requested_by_user_id`, `disposed_by_user_id`, `reviewed_by_user_id`, `reviewed_at`, `reviewer_remarks`, `workflow_version_id`, `workflow_snapshot`, `workflow_current_node_key`, `source_document_id`, `source_document_updated_at`, `created_at`, `updated_at`) VALUES
(200, 'WELLNES LIQUADATION FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.874', '2026-07-11 03:31:56.874'),
(201, 'PENDING DOCUMENTS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.892', '2026-07-11 03:31:56.892'),
(202, 'OJT\'s ALLOWANCE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.902', '2026-07-11 03:31:56.902'),
(203, 'Untitled Imported Hardcopy Row 205', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.913', '2026-07-11 03:31:56.913'),
(204, '2307 PURCHASE FILE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.927', '2026-07-11 03:31:56.927'),
(205, 'PETTY CASH VOUCHER FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.936', '2026-07-11 03:31:56.936'),
(206, 'PETTY CASH FUND AUDITED', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.950', '2026-07-11 03:31:56.950'),
(207, 'SHIPMENTS FILE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.961', '2026-07-11 03:31:56.961'),
(208, 'DAILY CASH & RECONCILATION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.970', '2026-07-11 03:31:56.970'),
(209, 'CANCELLED CHECKS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.980', '2026-07-11 03:31:56.980'),
(210, 'PURCHASE INVOICE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:56.989', '2026-07-11 03:31:56.989'),
(211, 'CASH BOOK (SEPT 12, 2022 - PRESENT)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.000', '2026-07-11 03:31:57.000'),
(212, 'IAD RECEIVING LOGBOOK', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.008', '2026-07-11 03:31:57.008'),
(213, 'ISSUEANCE LOGBOOK SEPT 7, 2022-PRESENT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.016', '2026-07-11 03:31:57.016'),
(214, 'BILLING STATEMENT & ISSUED PAYMENTS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.028', '2026-07-11 03:31:57.028'),
(215, 'DUE TO FROM HO', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.036', '2026-07-11 03:31:57.036'),
(216, 'PETTY CASH FUND', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.051', '2026-07-11 03:31:57.051'),
(217, 'DEPOSIT SLIP FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.061', '2026-07-11 03:31:57.061'),
(218, 'CHECK BOOKLET', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.070', '2026-07-11 03:31:57.070'),
(219, 'FCB PASSBOOK', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.078', '2026-07-11 03:31:57.078'),
(220, 'CWO FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.085', '2026-07-11 03:31:57.085'),
(221, 'DUE TO FROM HO', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.095', '2026-07-11 03:31:57.095'),
(222, 'FCB TIME DEPOSIT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.102', '2026-07-11 03:31:57.102'),
(223, 'RAW MATS & FINISHED GOOD NOTEBOOK', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.111', '2026-07-11 03:31:57.111'),
(224, 'RAW MATS, PACKAGING & FACTORY SUPPLIES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.119', '2026-07-11 03:31:57.119'),
(225, 'HO CV CEBU OFFICE (BACKLOAD)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.129', '2026-07-11 03:31:57.129'),
(226, 'INCORPORATORS PERSONAL INFORMATION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.138', '2026-07-11 03:31:57.138'),
(227, 'BANK STATEMENT WEALTH BANK', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.147', '2026-07-11 03:31:57.147'),
(228, 'BANK STATEMENT ROBINSONS BANK', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.156', '2026-07-11 03:31:57.156'),
(229, 'COLLECTION REPORT 2024', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.169', '2026-07-11 03:31:57.169'),
(230, 'AUDITED DAILY SALES REPORT JULY 2023', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.184', '2026-07-11 03:31:57.184'),
(231, 'AUDITED DAILY SALES REPORT AUGUST 2023', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.194', '2026-07-11 03:31:57.194'),
(232, 'COLLECTION REPORT 2024', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.203', '2026-07-11 03:31:57.203'),
(233, 'AUDITED SALES REPORT NOVEMBER 2022', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.217', '2026-07-11 03:31:57.217'),
(234, 'AUDITED SALES REPORT DECEMBER 2022', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.228', '2026-07-11 03:31:57.228'),
(235, 'AUDITED SALES REPORT JANUARY 2023', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.238', '2026-07-11 03:31:57.238'),
(236, 'AUDITED SALES REPORT FEBRUARY 2023', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.250', '2026-07-11 03:31:57.250'),
(237, 'AUDITED SALES REPORT MARCH 2023', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.258', '2026-07-11 03:31:57.258'),
(238, 'AUDITED SALES REPORT APRIL 2023', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.268', '2026-07-11 03:31:57.268'),
(239, 'AUDITED SALES REPORT MAY 2023', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.276', '2026-07-11 03:31:57.276'),
(240, 'AUDITED SALES REPORT JUNE 2023', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.286', '2026-07-11 03:31:57.286'),
(241, 'COLLECTION REPORT 2024', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.296', '2026-07-11 03:31:57.296'),
(242, 'AUDITED DAILY SALES REPORT APRIL 2022', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.310', '2026-07-11 03:31:57.310'),
(243, 'AUDITED DAILY SALES REPORT MAY 2022', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.319', '2026-07-11 03:31:57.319'),
(244, 'AUDITED DAILY SALES REPORT JUNE 2022', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.327', '2026-07-11 03:31:57.327'),
(245, 'AUDITED DAILY SALES REPORT JULY 2022', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.335', '2026-07-11 03:31:57.335'),
(246, 'AUDITED DAILY SALES REPORT AUGUST 2022', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.344', '2026-07-11 03:31:57.344'),
(247, 'AUDITED DAILY SALES REPORT SEPTEMBER 2022', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.353', '2026-07-11 03:31:57.353'),
(248, 'AUDITED DAILY SALES REPORT OCTOBER 2022', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.362', '2026-07-11 03:31:57.362'),
(249, 'AUDITED DAILY SALES REPORT - JANUARY 2021', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.373', '2026-07-11 03:31:57.373'),
(250, 'AUDITED DAILY SALES REPORT - FEBRUARY 2021', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.381', '2026-07-11 03:31:57.381'),
(251, 'AUDITED DAILY SALES REPORT - MARCH 2021', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.392', '2026-07-11 03:31:57.392'),
(252, 'AUDITED DAILY SALES REPORT - MAY 2021', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.400', '2026-07-11 03:31:57.400'),
(253, 'AUDITED DAILY SALES REPORT - JUNE 2021', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.413', '2026-07-11 03:31:57.413'),
(254, 'AUDITED DAILY SALES REPORT - JULY 2021', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.422', '2026-07-11 03:31:57.422'),
(255, 'AUDITED DAILY SALES REPORT - AUGUST 2021', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.434', '2026-07-11 03:31:57.434'),
(256, 'AUDITED DAILY SALES REPORT - SEPTEMBER 2021', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.452', '2026-07-11 03:31:57.452'),
(257, 'AUDITED DAILY SALES REPORT - OCTOBER 2021', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.465', '2026-07-11 03:31:57.465'),
(258, 'AUDITED DAILY SALES REPORT - NOVEMBER 2021', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.481', '2026-07-11 03:31:57.481'),
(259, 'AUDITED DAILY SALES REPORT - DECEMBER 2021', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.492', '2026-07-11 03:31:57.492'),
(260, 'AUDITED DAILY SALES REPORT - JANUARY 2022', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.504', '2026-07-11 03:31:57.504'),
(261, 'AUDITED DAILY SALES REPORT - FEBRUARY 2022', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.516', '2026-07-11 03:31:57.516'),
(262, 'AUDITED DAILY SALES REPORT - MARCH 2022', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.527', '2026-07-11 03:31:57.527'),
(263, 'Untitled Imported Hardcopy Row 265', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.537', '2026-07-11 03:31:57.537'),
(264, 'Untitled Imported Hardcopy Row 266', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.558', '2026-07-11 03:31:57.558'),
(265, 'Untitled Imported Hardcopy Row 267', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.581', '2026-07-11 03:31:57.581'),
(266, 'Untitled Imported Hardcopy Row 268', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.592', '2026-07-11 03:31:57.592'),
(267, 'Untitled Imported Hardcopy Row 269', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.604', '2026-07-11 03:31:57.604'),
(268, 'MANUAL', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.613', '2026-07-11 03:31:57.613'),
(269, 'CIS SUPPLIERS CREDIT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.623', '2026-07-11 03:31:57.623'),
(270, 'CEBU HAI RON/SANDEN', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.633', '2026-07-11 03:31:57.633'),
(271, 'GENERAL BOX', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.644', '2026-07-11 03:31:57.644'),
(272, 'BIR AUTHORITY TO PRINT BIR 2303', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.651', '2026-07-11 03:31:57.651'),
(273, 'FIX ASSETS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.660', '2026-07-11 03:31:57.660'),
(274, 'SUPERIOR PACK', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.669', '2026-07-11 03:31:57.669'),
(275, 'MACRO FURNITURE/HERMACO', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.678', '2026-07-11 03:31:57.678'),
(276, 'PEANUT KISSES PERMITS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.686', '2026-07-11 03:31:57.686'),
(277, 'ECOTHERM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.694', '2026-07-11 03:31:57.694'),
(278, 'TECHNO TRADE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.701', '2026-07-11 03:31:57.701'),
(279, 'RS BUILDERS/KRC ENGINEERING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.710', '2026-07-11 03:31:57.710'),
(280, 'NEW PLASTIMATE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.719', '2026-07-11 03:31:57.719'),
(281, 'ASIA INTEGRATED MACHINE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.727', '2026-07-11 03:31:57.727'),
(282, 'TWINBEE/SLEEVES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.738', '2026-07-11 03:31:57.738'),
(283, 'BAKELS CHEMICALS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.747', '2026-07-11 03:31:57.747'),
(284, 'CANCELLED P.O & P. ERROR', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.753', '2026-07-11 03:31:57.753'),
(285, 'CONCHING\'S ELECTRICAL SUPPLY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.762', '2026-07-11 03:31:57.762'),
(286, 'SBP PRINTERS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.771', '2026-07-11 03:31:57.771'),
(287, 'APO MERCHANTILE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.779', '2026-07-11 03:31:57.779'),
(288, 'OBERON', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.787', '2026-07-11 03:31:57.787'),
(289, 'TT8 & ADVANCE UNIFLEX', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.794', '2026-07-11 03:31:57.794'),
(290, 'SCHELEM/NUTEX', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.803', '2026-07-11 03:31:57.803'),
(291, 'DEH PACKAGING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.815', '2026-07-11 03:31:57.815'),
(292, 'JOLLIBEE - DCM OVEN', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.827', '2026-07-11 03:31:57.827'),
(293, 'FIRST PHILIPPINE SCALE INC.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.839', '2026-07-11 03:31:57.839'),
(294, 'NEWTON ALL LINKS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.847', '2026-07-11 03:31:57.847'),
(295, 'COMPILATION OF OLD QUOTATIONS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.857', '2026-07-11 03:31:57.857'),
(296, 'ASC GLASS SERVICES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.868', '2026-07-11 03:31:57.868'),
(297, 'BMAP PRINTING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.879', '2026-07-11 03:31:57.879'),
(298, 'EPTAL COLENT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.888', '2026-07-11 03:31:57.888'),
(299, 'YALE - INFINITE PROTECH', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.900', '2026-07-11 03:31:57.900');
INSERT INTO `documents` (`document_id`, `document_title`, `document_type`, `status`, `request_date`, `department`, `business_document_type`, `action_requested`, `from_party`, `to_party`, `reason_for_change`, `brief_description`, `proposed_change`, `revision_level_from`, `revision_level_to`, `previous_effective_date`, `new_effective_date`, `date_received`, `date_released`, `approval_date`, `legacy_imported`, `creation_source`, `creation_reason`, `direct_created_at`, `legacy_import_note`, `status_before_disposal`, `requested_by_name`, `disposal_remarks`, `disposal_action`, `disposal_action_other`, `disposed_at`, `disposed_by_name`, `created_by`, `requested_by_user_id`, `disposed_by_user_id`, `reviewed_by_user_id`, `reviewed_at`, `reviewer_remarks`, `workflow_version_id`, `workflow_snapshot`, `workflow_current_node_key`, `source_document_id`, `source_document_updated_at`, `created_at`, `updated_at`) VALUES
(300, 'IPAK', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.908', '2026-07-11 03:31:57.908'),
(301, 'ATLAS COPCO', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.919', '2026-07-11 03:31:57.919'),
(302, 'BONGRE/INCA/INDOPLAS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.928', '2026-07-11 03:31:57.928'),
(303, 'ABENSON & ASC TECH', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.937', '2026-07-11 03:31:57.937'),
(304, 'CARRIER & MAGIC AIRE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.948', '2026-07-11 03:31:57.948'),
(305, 'GB&G PROVIDER', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.957', '2026-07-11 03:31:57.957'),
(306, 'FIXRITE MACODER', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.968', '2026-07-11 03:31:57.968'),
(307, 'PRECEPT COMMERCIAL CORP.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.977', '2026-07-11 03:31:57.977'),
(308, 'ASC PLANNING CONSTRUCTION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.988', '2026-07-11 03:31:57.988'),
(309, 'SERVICE REPORT JCG', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:57.997', '2026-07-11 03:31:57.997'),
(310, 'COFTA MOULDINGS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.005', '2026-07-11 03:31:58.005'),
(311, 'UNI - FAB', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.014', '2026-07-11 03:31:58.014'),
(312, 'ADS & PRINTS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.025', '2026-07-11 03:31:58.025'),
(313, 'KEYSTONE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.035', '2026-07-11 03:31:58.035'),
(314, 'GERESONIC & TWO GUYS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.044', '2026-07-11 03:31:58.044'),
(315, 'KALINISAN & DCP PROTECH', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.055', '2026-07-11 03:31:58.055'),
(316, 'SOUTHERN SYN', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.064', '2026-07-11 03:31:58.064'),
(317, 'GT INDUSTRIAL', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.077', '2026-07-11 03:31:58.077'),
(318, 'BIG STONE/BEERICH', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.087', '2026-07-11 03:31:58.087'),
(319, 'CEBU TRISTAR COPR.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.097', '2026-07-11 03:31:58.097'),
(320, 'I.T DECLARATIONS DAMAGE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.105', '2026-07-11 03:31:58.105'),
(321, 'SUPPLIERS U-DATE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.118', '2026-07-11 03:31:58.118'),
(322, 'FASTLAB Q.A P. QUOTE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.127', '2026-07-11 03:31:58.127'),
(323, 'KOOLER', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.136', '2026-07-11 03:31:58.136'),
(324, 'EVER CONSUMER', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.148', '2026-07-11 03:31:58.148'),
(325, 'DORFLEX AUS PRODUCT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.161', '2026-07-11 03:31:58.161'),
(326, 'CARLO MASTER', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.172', '2026-07-11 03:31:58.172'),
(327, 'CYDEM J. MARKETING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.181', '2026-07-11 03:31:58.181'),
(328, 'ELIXIR CEBU', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.195', '2026-07-11 03:31:58.195'),
(329, 'CEBU BSR', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.204', '2026-07-11 03:31:58.204'),
(330, 'UNIFORM FILES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.214', '2026-07-11 03:31:58.214'),
(331, 'PLASTIMER FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.231', '2026-07-11 03:31:58.231'),
(332, 'KRYPTON/COMPASS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.243', '2026-07-11 03:31:58.243'),
(333, 'SINMAG BAKERY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.252', '2026-07-11 03:31:58.252'),
(334, 'FIRST PINNACLE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.261', '2026-07-11 03:31:58.261'),
(335, 'CEBU FAR EASTERN', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.269', '2026-07-11 03:31:58.269'),
(336, 'ISLA LPG', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.278', '2026-07-11 03:31:58.278'),
(337, 'FOMPAC', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.286', '2026-07-11 03:31:58.286'),
(338, 'CENIT - IBSI', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.297', '2026-07-11 03:31:58.297'),
(339, 'CEBU POLAR & JUSTIC CORP', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.306', '2026-07-11 03:31:58.306'),
(340, 'FIRST OPTION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.317', '2026-07-11 03:31:58.317'),
(341, 'OBSOLETE PK', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.328', '2026-07-11 03:31:58.328'),
(342, 'MS\' WHEELTECH/RCP', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.338', '2026-07-11 03:31:58.338'),
(343, 'RCP MAN', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.349', '2026-07-11 03:31:58.349'),
(344, 'MICROLAB', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.358', '2026-07-11 03:31:58.358'),
(345, 'MAX\'S RESTAURANT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.377', '2026-07-11 03:31:58.377'),
(346, 'LRC WORLD TRADE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.486', '2026-07-11 03:31:58.486'),
(347, 'WRENLEY\'S APPLIANCE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.502', '2026-07-11 03:31:58.502'),
(348, 'JJ\'S APPLIANCE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.522', '2026-07-11 03:31:58.522'),
(349, 'HOPEWELL', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.534', '2026-07-11 03:31:58.534'),
(350, 'CHEMTRUST CHEMICAL', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.544', '2026-07-11 03:31:58.544'),
(351, 'FALCON URINAL', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.554', '2026-07-11 03:31:58.554'),
(352, 'CEBU BIONEC', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.620', '2026-07-11 03:31:58.620'),
(353, 'COOL WORKS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.636', '2026-07-11 03:31:58.636'),
(354, 'BAKESHOP COMMISSARY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.648', '2026-07-11 03:31:58.648'),
(355, 'JCG MARKETING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.660', '2026-07-11 03:31:58.660'),
(356, 'SUNDAY PLASTIC', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.669', '2026-07-11 03:31:58.669'),
(357, 'ACCUPLAS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.678', '2026-07-11 03:31:58.678'),
(358, 'PEDROLLO PHILIPPINES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.687', '2026-07-11 03:31:58.687'),
(359, 'UNIFORM & OTHER DEDUCTIONS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.697', '2026-07-11 03:31:58.697'),
(360, 'RAW MATS/PACKAGING EVALUATION REPORT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.705', '2026-07-11 03:31:58.705'),
(361, 'IMPORTED SUPPLIER FILES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.714', '2026-07-11 03:31:58.714'),
(362, 'PPA - PERMIT TO OPERATE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.723', '2026-07-11 03:31:58.723'),
(363, 'MEMO LETTERS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.734', '2026-07-11 03:31:58.734'),
(364, 'WAR SOA MONITORING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.741', '2026-07-11 03:31:58.741'),
(365, 'DAILY INVENTORY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.751', '2026-07-11 03:31:58.751'),
(366, 'SIR DENNIS MONTHLY REPORT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.760', '2026-07-11 03:31:58.760'),
(367, 'SUGAR PAYABLE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.768', '2026-07-11 03:31:58.768'),
(368, 'EGGS PAYABLE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.777', '2026-07-11 03:31:58.777'),
(369, 'ODETTE FILES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.783', '2026-07-11 03:31:58.783'),
(370, 'MITSUBISHI MOTORS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.795', '2026-07-11 03:31:58.795'),
(371, 'HOE 610 FILES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.804', '2026-07-11 03:31:58.804'),
(372, 'GAM 9128', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.815', '2026-07-11 03:31:58.815'),
(373, 'GAG 2369', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.824', '2026-07-11 03:31:58.824'),
(374, 'Untitled Imported Hardcopy Row 376', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.837', '2026-07-11 03:31:58.837'),
(375, 'SCHALEN SALES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.851', '2026-07-11 03:31:58.851'),
(376, 'WAGE PUBLIC CONSULTATION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.861', '2026-07-11 03:31:58.861'),
(377, 'SMART COMMUNICATIONS (ADMIN)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.871', '2026-07-11 03:31:58.871'),
(378, 'SMART COMMUNICATIONS (MANAGER)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.881', '2026-07-11 03:31:58.881'),
(379, 'SMART COMMUNICATIONS (PRODUCTION ODFFICE)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.889', '2026-07-11 03:31:58.889'),
(380, 'SMART COMMUNICATIONS (DRIVER)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.897', '2026-07-11 03:31:58.897'),
(381, 'SMART COMMUNICATIONS (HR)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.905', '2026-07-11 03:31:58.905'),
(382, 'SANDEN', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.916', '2026-07-11 03:31:58.916'),
(383, 'U DRAGON CORPS - UDS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.924', '2026-07-11 03:31:58.924'),
(384, 'SHOPPERS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.933', '2026-07-11 03:31:58.933'),
(385, 'ROAST & TOAST FOODLINE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.942', '2026-07-11 03:31:58.942'),
(386, 'SEABOURNE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.950', '2026-07-11 03:31:58.950'),
(387, 'SINMAG', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.960', '2026-07-11 03:31:58.960'),
(388, 'SBP PRINTERS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.967', '2026-07-11 03:31:58.967'),
(389, 'RELL FX', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.977', '2026-07-11 03:31:58.977'),
(390, 'TRAVEL EXPENSES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.984', '2026-07-11 03:31:58.984'),
(391, 'RCP MANUFACTURING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:58.993', '2026-07-11 03:31:58.993'),
(392, 'SYNERGY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.003', '2026-07-11 03:31:59.003'),
(393, 'PLASTIMER', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.012', '2026-07-11 03:31:59.012'),
(394, 'JOJO JUTAR PEANUTS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.020', '2026-07-11 03:31:59.020'),
(395, 'TREASURE ISLAND', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.028', '2026-07-11 03:31:59.028'),
(396, 'YALE HARDWARE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.037', '2026-07-11 03:31:59.037'),
(397, 'PLDT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.045', '2026-07-11 03:31:59.045'),
(398, 'TWO-GUYS BUILDERS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.056', '2026-07-11 03:31:59.056'),
(399, 'PLAZA MARCELA', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.066', '2026-07-11 03:31:59.066'),
(400, 'PETTY CASH FUND AUDITED (CEBU)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.074', '2026-07-11 03:31:59.074'),
(401, 'PEDROLLO PHILIPPINES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.086', '2026-07-11 03:31:59.086');
INSERT INTO `documents` (`document_id`, `document_title`, `document_type`, `status`, `request_date`, `department`, `business_document_type`, `action_requested`, `from_party`, `to_party`, `reason_for_change`, `brief_description`, `proposed_change`, `revision_level_from`, `revision_level_to`, `previous_effective_date`, `new_effective_date`, `date_received`, `date_released`, `approval_date`, `legacy_imported`, `creation_source`, `creation_reason`, `direct_created_at`, `legacy_import_note`, `status_before_disposal`, `requested_by_name`, `disposal_remarks`, `disposal_action`, `disposal_action_other`, `disposed_at`, `disposed_by_name`, `created_by`, `requested_by_user_id`, `disposed_by_user_id`, `reviewed_by_user_id`, `reviewed_at`, `reviewer_remarks`, `workflow_version_id`, `workflow_snapshot`, `workflow_current_node_key`, `source_document_id`, `source_document_updated_at`, `created_at`, `updated_at`) VALUES
(402, 'UNI FAB - METAL INDUSTRIES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.094', '2026-07-11 03:31:59.094'),
(403, 'PRECEPT COMMERCIAL', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.103', '2026-07-11 03:31:59.103'),
(404, 'PATENT FILE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.111', '2026-07-11 03:31:59.111'),
(405, 'TRADEMARK', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.123', '2026-07-11 03:31:59.123'),
(406, 'ROSE EN HONEY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.131', '2026-07-11 03:31:59.131'),
(407, 'SUNDAY MILL CORPORATION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.143', '2026-07-11 03:31:59.143'),
(408, 'SVI DISTRIBUTION CORPORATION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.150', '2026-07-11 03:31:59.150'),
(409, 'SGS PHILIPPINE INC.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.190', '2026-07-11 03:31:59.190'),
(410, 'SBP PRINTERS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.199', '2026-07-11 03:31:59.199'),
(411, 'SLEEVES ENTERPRISES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.206', '2026-07-11 03:31:59.206'),
(412, 'PRICE INCREASE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.217', '2026-07-11 03:31:59.217'),
(413, 'ORO DRAGON', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.225', '2026-07-11 03:31:59.225'),
(414, 'INCA PH INC.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.234', '2026-07-11 03:31:59.234'),
(415, 'MFI NOODLES FACTORY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.245', '2026-07-11 03:31:59.245'),
(416, 'JGY INGREDIENTS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.252', '2026-07-11 03:31:59.252'),
(417, 'JCG MARKETING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.263', '2026-07-11 03:31:59.263'),
(418, 'COMPASS INTERNATIONAL SALES OPC', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.271', '2026-07-11 03:31:59.271'),
(419, 'HARI GARMENTS/TT8', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.281', '2026-07-11 03:31:59.281'),
(420, 'HOPEWELL SALES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.291', '2026-07-11 03:31:59.291'),
(421, 'MFI COMMISSARY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.299', '2026-07-11 03:31:59.299'),
(422, 'COLD STORAGE & R&D', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.309', '2026-07-11 03:31:59.309'),
(423, 'ICM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.317', '2026-07-11 03:31:59.317'),
(424, 'ISLA LPG 2024', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.324', '2026-07-11 03:31:59.324'),
(425, 'COMMISSARY BAKESHOP', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.335', '2026-07-11 03:31:59.335'),
(426, 'MFI POULTRY 8/2024', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.345', '2026-07-11 03:31:59.345'),
(427, 'INSURANCE POLICY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.353', '2026-07-11 03:31:59.353'),
(428, 'INTERNAL AUDIT PCF & ECAF', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.365', '2026-07-11 03:31:59.365'),
(429, 'JUSTIC CORP', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.373', '2026-07-11 03:31:59.373'),
(430, 'JJ\'S APPLIANCE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.382', '2026-07-11 03:31:59.382'),
(431, 'KALINISAN', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.392', '2026-07-11 03:31:59.392'),
(432, 'KOOLER INDUSTRIES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.401', '2026-07-11 03:31:59.401'),
(433, 'KAUNLARAN TRUCK BODY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.413', '2026-07-11 03:31:59.413'),
(434, 'KRC ENGINEERING SERVICES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.427', '2026-07-11 03:31:59.427'),
(435, 'KRYPTON SALES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.436', '2026-07-11 03:31:59.436'),
(436, 'LRC WORLD', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.447', '2026-07-11 03:31:59.447'),
(437, 'MAGIC AIRE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.459', '2026-07-11 03:31:59.459'),
(438, 'MICRO LAB', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.470', '2026-07-11 03:31:59.470'),
(439, 'LANDBANK PAYROLL 2024', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.483', '2026-07-11 03:31:59.483'),
(440, 'MFI COMMISSARY & R&D', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.493', '2026-07-11 03:31:59.493'),
(441, 'KEYSTONE INSTRUMENTS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.503', '2026-07-11 03:31:59.503'),
(442, 'MFI - FEEDMILL', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.516', '2026-07-11 03:31:59.516'),
(443, 'LEASE OF CONTRACT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.528', '2026-07-11 03:31:59.528'),
(444, 'APPLICATIONS FOR BARCODE/GS1 PHILIPPINES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.542', '2026-07-11 03:31:59.542'),
(445, 'GLOBE LINES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.553', '2026-07-11 03:31:59.553'),
(446, 'GRB ENTERPRISES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.562', '2026-07-11 03:31:59.562'),
(447, 'ALTURAS GLASS SERVICE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.573', '2026-07-11 03:31:59.573'),
(448, 'ALTURAS SUPERMARKET', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.586', '2026-07-11 03:31:59.586'),
(449, 'ASC - TECH', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.601', '2026-07-11 03:31:59.601'),
(450, 'CEBO DEVELOPMENT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.612', '2026-07-11 03:31:59.612'),
(451, 'CENTRAL DISTRIBUTION CENTER', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.621', '2026-07-11 03:31:59.621'),
(452, 'ATLAS COPCO', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.631', '2026-07-11 03:31:59.631'),
(453, 'APO MERCHANTILE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.641', '2026-07-11 03:31:59.641'),
(454, 'ASC (DELIVERY & TRUCKING)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.652', '2026-07-11 03:31:59.652'),
(455, 'AVIV CLOTHING & TAILORING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.666', '2026-07-11 03:31:59.666'),
(456, 'COOLENT MARKETING PHILS. INC', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.680', '2026-07-11 03:31:59.680'),
(457, 'COMNET', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.688', '2026-07-11 03:31:59.688'),
(458, 'A.H SHOPPERS MART', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.698', '2026-07-11 03:31:59.698'),
(459, 'ADS & PRINTS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.707', '2026-07-11 03:31:59.707'),
(460, 'ADVANCE UNIFLEX TECH', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.717', '2026-07-11 03:31:59.717'),
(461, 'ALL - LINKS TRADING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.729', '2026-07-11 03:31:59.729'),
(462, 'ASC VEHICLE RENEWAL', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.739', '2026-07-11 03:31:59.739'),
(463, 'BMAP PRINTING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.754', '2026-07-11 03:31:59.754'),
(464, 'AEROPHONE ENTERPRISES & CO.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.769', '2026-07-11 03:31:59.769'),
(465, 'ALTURAS ABENSON', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.778', '2026-07-11 03:31:59.778'),
(466, 'BON GRE CORP', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.786', '2026-07-11 03:31:59.786'),
(467, 'BEERICH CLOTHING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.797', '2026-07-11 03:31:59.797'),
(468, 'BIGSTONE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.804', '2026-07-11 03:31:59.804'),
(469, 'BEEDEE GARMENTS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.811', '2026-07-11 03:31:59.811'),
(470, 'BES PACIFIC', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.820', '2026-07-11 03:31:59.820'),
(471, 'BJV PRINTING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.827', '2026-07-11 03:31:59.827'),
(472, 'BAMDECORP', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.835', '2026-07-11 03:31:59.835'),
(473, 'CYDEM VENTURES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.844', '2026-07-11 03:31:59.844'),
(474, 'CARRIER - CONCEPCION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.853', '2026-07-11 03:31:59.853'),
(475, 'COFTA MOULDINGS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.863', '2026-07-11 03:31:59.863'),
(476, 'CEBU EASTERN DRUG', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.872', '2026-07-11 03:31:59.872'),
(477, 'CHAMPION GLUE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.884', '2026-07-11 03:31:59.884'),
(478, 'CONCHING\'S ELECTRICAL SUPPLY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.893', '2026-07-11 03:31:59.893'),
(479, 'DOST 7', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.904', '2026-07-11 03:31:59.904'),
(480, 'D\'GENERAL BOX', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.912', '2026-07-11 03:31:59.912'),
(481, 'ADVANCES TO OFFICERS (ATTY. LAGUNAY)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.921', '2026-07-11 03:31:59.921'),
(482, 'CHEMTRUST CHEMICAL', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.932', '2026-07-11 03:31:59.932'),
(483, 'CEBU PSI HOSE CENTER', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.940', '2026-07-11 03:31:59.940'),
(484, 'CEBU POLAR MARKETING COPR.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.951', '2026-07-11 03:31:59.951'),
(485, 'CEBU TRISTAR', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.960', '2026-07-11 03:31:59.960'),
(486, 'CEBU BSR ETHANIM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.968', '2026-07-11 03:31:59.968'),
(487, 'DRAGON PAY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.976', '2026-07-11 03:31:59.976'),
(488, 'EVER CONSUMER SALES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.982', '2026-07-11 03:31:59.982'),
(489, 'ECOTHERM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.990', '2026-07-11 03:31:59.990'),
(490, 'FAST LABORATORIES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:31:59.999', '2026-07-11 03:31:59.999'),
(491, 'DEH PACKAGING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.010', '2026-07-11 03:32:00.010'),
(492, 'ELIXIR', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.020', '2026-07-11 03:32:00.020'),
(493, 'FIRST PINNACLE TRADING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.043', '2026-07-11 03:32:00.043'),
(494, 'FIRST OPTION ELECTRICAL 2024', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.053', '2026-07-11 03:32:00.053'),
(495, 'STORE/VENDOR AGREEMENT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.066', '2026-07-11 03:32:00.066'),
(496, 'DORFLEX AUS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.076', '2026-07-11 03:32:00.076'),
(497, 'CHERRY LAMATAO', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.086', '2026-07-11 03:32:00.086'),
(498, 'DCP PROTEECH INDUSTRIES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.096', '2026-07-11 03:32:00.096'),
(499, 'FOMPAC', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.109', '2026-07-11 03:32:00.109'),
(500, 'CHECK VOUCHER JANUARY 2020', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.123', '2026-07-11 03:32:00.123'),
(501, 'CHECK VOUCHER FEBRUARY 2020', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.134', '2026-07-11 03:32:00.134'),
(502, 'CHECK VOUCHER MARCH 2020', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.147', '2026-07-11 03:32:00.147'),
(503, 'CHECK VOUCHER APRIL 2020', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.158', '2026-07-11 03:32:00.158');
INSERT INTO `documents` (`document_id`, `document_title`, `document_type`, `status`, `request_date`, `department`, `business_document_type`, `action_requested`, `from_party`, `to_party`, `reason_for_change`, `brief_description`, `proposed_change`, `revision_level_from`, `revision_level_to`, `previous_effective_date`, `new_effective_date`, `date_received`, `date_released`, `approval_date`, `legacy_imported`, `creation_source`, `creation_reason`, `direct_created_at`, `legacy_import_note`, `status_before_disposal`, `requested_by_name`, `disposal_remarks`, `disposal_action`, `disposal_action_other`, `disposed_at`, `disposed_by_name`, `created_by`, `requested_by_user_id`, `disposed_by_user_id`, `reviewed_by_user_id`, `reviewed_at`, `reviewer_remarks`, `workflow_version_id`, `workflow_snapshot`, `workflow_current_node_key`, `source_document_id`, `source_document_updated_at`, `created_at`, `updated_at`) VALUES
(504, 'CHECK VOUCHER MAY 2020', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.168', '2026-07-11 03:32:00.168'),
(505, 'CHECK VOUCHER JUNE 2020', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.178', '2026-07-11 03:32:00.178'),
(506, 'CHECK VOUCHER JULY 2020', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.189', '2026-07-11 03:32:00.189'),
(507, 'CHECK VOUCHER AUGUST 2020', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.202', '2026-07-11 03:32:00.202'),
(508, 'CHECK VOUCHER SEPTEMBER 2020', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.213', '2026-07-11 03:32:00.213'),
(509, 'CHECK VOUCHER OCTOBER 2020', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.220', '2026-07-11 03:32:00.220'),
(510, 'CHECK VOUCHER NOVEMBER 2020', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.231', '2026-07-11 03:32:00.231'),
(511, 'CHECK VOUCHER DECEMBER 2020', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.240', '2026-07-11 03:32:00.240'),
(512, 'CHECK VOUCHER JANUARY 2021', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.251', '2026-07-11 03:32:00.251'),
(513, 'CHECK VOUCHER FEBRUARY 2021', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.260', '2026-07-11 03:32:00.260'),
(514, 'CHECK VOUCHER MARCH 2021', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.267', '2026-07-11 03:32:00.267'),
(515, 'CHECK VOUCHER MAY 2021', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.275', '2026-07-11 03:32:00.275'),
(516, 'CHECK VOUCHER JUNE 2021', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.283', '2026-07-11 03:32:00.283'),
(517, 'CHECK VOUCHER JULY 2021', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.294', '2026-07-11 03:32:00.294'),
(518, 'CHECK VOUCHER AUGUST 2021', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.303', '2026-07-11 03:32:00.303'),
(519, 'CHECK VOUCHER SEPTEMBER 2021', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.312', '2026-07-11 03:32:00.312'),
(520, 'CHECK VOUCHER OCTOBER 2021', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.321', '2026-07-11 03:32:00.321'),
(521, 'CHECK VOUCHER NOVEMBER 2021', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.330', '2026-07-11 03:32:00.330'),
(522, 'CHECK VOUCHER DECEMBER 2021', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.338', '2026-07-11 03:32:00.338'),
(523, 'FS & QA OFFICER LOGBOOK', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.352', '2026-07-11 03:32:00.352'),
(524, 'IN-HOUSE INTERNAL AUDIT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.360', '2026-07-11 03:32:00.360'),
(525, 'CERTIFICATE OF WATER POTABILITY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.379', '2026-07-11 03:32:00.379'),
(526, 'NOTES & RESEARCH', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.397', '2026-07-11 03:32:00.397'),
(527, 'QUALITY MANUAL', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.405', '2026-07-11 03:32:00.405'),
(528, 'CEBU BSR ETHANIM CHEMICALS INC. PERMITS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.413', '2026-07-11 03:32:00.413'),
(529, 'GMP', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.422', '2026-07-11 03:32:00.422'),
(530, 'WHOLE EGG RECEIVING PROCEDURE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.433', '2026-07-11 03:32:00.433'),
(531, 'DAMAGED DISPOSAL POLICY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.444', '2026-07-11 03:32:00.444'),
(532, 'BLANK FORMS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.454', '2026-07-11 03:32:00.454'),
(533, 'TEST WEIGHT CALIBRATION CERTIFICATE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.463', '2026-07-11 03:32:00.463'),
(534, 'FROZEN EGGYOLK W/ 5% SUGAR', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.476', '2026-07-11 03:32:00.476'),
(535, 'CAPA PEANUT KISSES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.486', '2026-07-11 03:32:00.486'),
(536, 'RMREF - VANILLA CONCENTRATED', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.498', '2026-07-11 03:32:00.498'),
(537, 'CUSTOMER COMPLAINT /CAPA-ACCUPLAS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.508', '2026-07-11 03:32:00.508'),
(538, 'RMREF - PAN RELEASE AGENT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.517', '2026-07-11 03:32:00.517'),
(539, 'IN-PROCESS EVALUATION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.527', '2026-07-11 03:32:00.527'),
(540, 'RMREF - WHOLE EGG', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.537', '2026-07-11 03:32:00.537'),
(541, 'FINISHED PRODUCT EVALUATION (WEEKLY)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.547', '2026-07-11 03:32:00.547'),
(542, 'FINISHED PRODUCT EVALUATION (RETENTION)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.588', '2026-07-11 03:32:00.588'),
(543, 'MEMF - FROZEN EGGYOLK GOLDILOCKS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.600', '2026-07-11 03:32:00.600'),
(544, 'THERMOHYGROMETER TESTO', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.611', '2026-07-11 03:32:00.611'),
(545, 'NUTRITION FACTS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.620', '2026-07-11 03:32:00.620'),
(546, 'HANNA UNIT CALBRATION CERTIFICATE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.632', '2026-07-11 03:32:00.632'),
(547, 'ACCUPLAS EXTENSION LETTER', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.641', '2026-07-11 03:32:00.641'),
(548, 'FROZEN EGGYOLK SPECIFICATION (MAX)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.652', '2026-07-11 03:32:00.652'),
(549, 'FINISHED PRODUCT STANDARD RANGE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.661', '2026-07-11 03:32:00.661'),
(550, 'PAN RELEASE AGENT EXTENSION LETTER', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.670', '2026-07-11 03:32:00.670'),
(551, 'WORK INSTRUCTION - R&D MOISTURE ANALYZER', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.679', '2026-07-11 03:32:00.679'),
(552, 'HOPIA & PEANUT COOKIES PROCESS FLOW', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.686', '2026-07-11 03:32:00.686'),
(553, 'ACCUPOINT ADVANCE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.694', '2026-07-11 03:32:00.694'),
(554, 'SUNDAY PLASTIC MILL', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.703', '2026-07-11 03:32:00.703'),
(555, 'R& REJECTED MATERIALS EVALUATION FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.712', '2026-07-11 03:32:00.712'),
(556, 'LINX (INKJET MACHINE)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.720', '2026-07-11 03:32:00.720'),
(557, 'KIMBERLY CLARK', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.730', '2026-07-11 03:32:00.730'),
(558, 'IN-PROCESS SPECIFICATION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.740', '2026-07-11 03:32:00.740'),
(559, 'RAW MATERIALS STANDARD RANGE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.749', '2026-07-11 03:32:00.749'),
(560, 'RAW MATERIALS SPECIFICATION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.759', '2026-07-11 03:32:00.759'),
(561, 'MATERIAL & FINISHED PRODUCT TAGGING PROCEDURE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.767', '2026-07-11 03:32:00.767'),
(562, 'TRANSMITTAL MONITORING FORM OF FINISHED PRODUCT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.777', '2026-07-11 03:32:00.777'),
(563, 'BAND AID REQUISITION MONITORING FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.787', '2026-07-11 03:32:00.787'),
(564, 'PACKAGING MATERIALS SPECIFICATION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.797', '2026-07-11 03:32:00.797'),
(565, 'INCIDENT REPORT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.807', '2026-07-11 03:32:00.807'),
(566, 'FINISHED PRODUCT SPECIFICATION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.815', '2026-07-11 03:32:00.815'),
(567, 'COA GOLDILOCKS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.823', '2026-07-11 03:32:00.823'),
(568, 'PEANUT KISSES PROCESS FLOW', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.831', '2026-07-11 03:32:00.831'),
(569, 'CERTIFICATE OF ANALYSIS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.839', '2026-07-11 03:32:00.839'),
(570, 'GOLDILOCKS PROCESS FLOW', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.850', '2026-07-11 03:32:00.850'),
(571, 'BALLPEN REQUISITION MONITORING FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.860', '2026-07-11 03:32:00.860'),
(572, 'INTERNAL AUDIT RESULT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.867', '2026-07-11 03:32:00.867'),
(573, 'REQUISITION FORM (DOST & FAST LAB)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.875', '2026-07-11 03:32:00.875'),
(574, 'SUMMARY OF INCIDENT REPORT 2023', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.883', '2026-07-11 03:32:00.883'),
(575, 'FDA AUDIT RESULT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.893', '2026-07-11 03:32:00.893'),
(576, 'SUPPLIER AUDIT RESULT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.900', '2026-07-11 03:32:00.900'),
(577, 'SAMPLE OF INTERNAL AUDIT FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.909', '2026-07-11 03:32:00.909'),
(578, 'MONTHLY FINISHED PRODUCT ANALYSIS REPORT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.917', '2026-07-11 03:32:00.917'),
(579, 'CERTIFICATE OF WATER POTABILITY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.924', '2026-07-11 03:32:00.924'),
(580, 'CITY HEALTH GOVERNMENT AUDIT RESULTS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.934', '2026-07-11 03:32:00.934'),
(581, 'SUMMARY OF PRODUCT ANALYSIS REPORT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.942', '2026-07-11 03:32:00.942'),
(582, 'INTERNAL AUDOT RESULT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.951', '2026-07-11 03:32:00.951'),
(583, 'SAMPLE OF INTERNAL AUDIT FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.960', '2026-07-11 03:32:00.960'),
(584, 'PACKAGING MATERIAL RECEIVING MONITORING FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.968', '2026-07-11 03:32:00.968'),
(585, 'IN-HOUSE AUDIT RESULT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.977', '2026-07-11 03:32:00.977'),
(586, 'PRICE QUOTATION (DOST & FAST LAB)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.986', '2026-07-11 03:32:00.986'),
(587, 'WEIGHING SCALE SERVICE REPORT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:00.995', '2026-07-11 03:32:00.995'),
(588, 'WEIGHING SCALE CALIBRATION REPORT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.003', '2026-07-11 03:32:01.003'),
(589, 'WEIGHING SCALE SERVICE REQUEST', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.012', '2026-07-11 03:32:01.012'),
(590, 'TRANSMITTAL MONITORING FORM OF RAW PEANUTS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.020', '2026-07-11 03:32:01.020'),
(591, 'TRANSMITTAL', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.030', '2026-07-11 03:32:01.030'),
(592, 'CALIBRATION CERTIFICATE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.040', '2026-07-11 03:32:01.040'),
(593, 'R&D REPORTS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.049', '2026-07-11 03:32:01.049'),
(594, 'PROCEDURES & POLICIES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.059', '2026-07-11 03:32:01.059'),
(595, 'ANALYSIS RESULT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.068', '2026-07-11 03:32:01.068'),
(596, 'FINISHED PRODUCT EVALUATION DAILY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.079', '2026-07-11 03:32:01.079'),
(597, 'RMREF RAW PEANUTS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.090', '2026-07-11 03:32:01.090'),
(598, 'CERTIFICATE OF ANALYSIS MATERIAL SAFETY DATA SHEET', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.100', '2026-07-11 03:32:01.100'),
(599, 'FINISHED PRODUCT EVALUATION WEEKLY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.111', '2026-07-11 03:32:01.111'),
(600, 'PACKAGING MATERIALS EVALUATION FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.118', '2026-07-11 03:32:01.118'),
(601, 'RMREF - FROZEN EGGYOLK GOLDILOCKS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.128', '2026-07-11 03:32:01.128'),
(602, 'LSDI', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.141', '2026-07-11 03:32:01.141'),
(603, 'PEANUT KISSES TEAM & COMMITTEE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.155', '2026-07-11 03:32:01.155');
INSERT INTO `documents` (`document_id`, `document_title`, `document_type`, `status`, `request_date`, `department`, `business_document_type`, `action_requested`, `from_party`, `to_party`, `reason_for_change`, `brief_description`, `proposed_change`, `revision_level_from`, `revision_level_to`, `previous_effective_date`, `new_effective_date`, `date_received`, `date_released`, `approval_date`, `legacy_imported`, `creation_source`, `creation_reason`, `direct_created_at`, `legacy_import_note`, `status_before_disposal`, `requested_by_name`, `disposal_remarks`, `disposal_action`, `disposal_action_other`, `disposed_at`, `disposed_by_name`, `created_by`, `requested_by_user_id`, `disposed_by_user_id`, `reviewed_by_user_id`, `reviewed_at`, `reviewer_remarks`, `workflow_version_id`, `workflow_snapshot`, `workflow_current_node_key`, `source_document_id`, `source_document_updated_at`, `created_at`, `updated_at`) VALUES
(604, 'TRAINING MODULE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.188', '2026-07-11 03:32:01.188'),
(605, 'FOOD HANDLER PERMIT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.216', '2026-07-11 03:32:01.216'),
(606, 'LIST OF EMPLOYEES W/ EDUCATIONAL ATTAINMENT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.229', '2026-07-11 03:32:01.229'),
(607, 'SUPPLIER PERMIT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.240', '2026-07-11 03:32:01.240'),
(608, 'LIST OF SUPPLIERS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.252', '2026-07-11 03:32:01.252'),
(609, 'PERSONNEL AREA OF RESPONSIBILITIES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.264', '2026-07-11 03:32:01.264'),
(610, 'CRITERIA FOR APPROVAL, ON HOLD AND REJECTION MANUAL (RAW MATERIALS)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.274', '2026-07-11 03:32:01.274'),
(611, 'POTABLE WATER FREE CHLORINE LEVEL MONITORING FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.304', '2026-07-11 03:32:01.304'),
(612, 'SOP PEANUT SELECTION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.317', '2026-08-28 08:56:15.953'),
(613, 'GMP MANUAL', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.339', '2026-08-28 08:43:18.358'),
(614, 'PERMITS & COMPANY PROFILE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.381', '2026-07-11 03:32:01.381'),
(615, 'REPORT SUMMARY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.409', '2026-07-11 03:32:01.409'),
(616, 'SSOP MANUAL', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.429', '2026-08-28 08:55:29.026'),
(617, 'FS & QA OFFICER WORKS SCHEDULE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.451', '2026-07-11 03:32:01.451'),
(618, 'MINUTES OF MEETING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.469', '2026-07-11 03:32:01.469'),
(619, 'MEMORANDUM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.481', '2026-07-11 03:32:01.481'),
(620, 'LOCKER CONTROL NUMBER', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.495', '2026-07-11 03:32:01.495'),
(621, 'FS&QA OFFICER SHIFTING SCHEDULE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.504', '2026-07-11 03:32:01.504'),
(622, 'IN-HOUSE RULES POLICY & ORIENTATION ATTENDANCE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.520', '2026-07-11 03:32:01.520'),
(623, 'CONTIGENCY PLAN', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.541', '2026-07-11 03:32:01.541'),
(624, 'COA OF HANNA RE-AGENT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.671', '2026-07-11 03:32:01.671'),
(625, 'MATERIAL RECEIVING REPORT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.685', '2026-07-11 03:32:01.685'),
(626, 'EXTERNAL SUPPLIER COMPLAINT FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.698', '2026-07-11 03:32:01.698'),
(627, 'INTERNAL SUPPLIER COMPLAINT FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.707', '2026-07-11 03:32:01.707'),
(628, 'CUSTOMER COMPLAINT FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.720', '2026-07-11 03:32:01.720'),
(629, 'CUSTOMER COMPLAINT FEEDBACK FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.732', '2026-07-11 03:32:01.732'),
(630, 'PERSONNEL HANDWASHING MONITORING FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.745', '2026-07-11 03:32:01.745'),
(631, 'HANNAH CALIBRATION VERIFICATION FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.767', '2026-07-11 03:32:01.767'),
(632, 'POTABLE WATER PIPELINES FLUSHING & DISINFECTION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.781', '2026-07-11 03:32:01.781'),
(633, 'DAILY PERSONNEL HYGIENE MONITORING FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.796', '2026-07-11 03:32:01.796'),
(634, 'EGGYOLK STORAGE MONITORING FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.812', '2026-07-11 03:32:01.812'),
(635, 'RAW PEANUTS MOISTURE MONITORING FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.826', '2026-07-11 03:32:01.826'),
(636, 'FINISHED PRODUCT TAGGING MONITORING FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.851', '2026-07-11 03:32:01.851'),
(637, 'DAILY MIXTURE BAKE ANALYSIS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.864', '2026-07-11 03:32:01.864'),
(638, 'DELIVERY VEHICLE MONITORING FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.872', '2026-07-11 03:32:01.872'),
(639, 'REFINED SUGAR', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.885', '2026-07-11 03:32:01.885'),
(640, 'PACKAGING MATERIALS TAGGING MONITORING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.894', '2026-07-11 03:32:01.894'),
(641, 'PEANUT STORAGE TEMPERATURE MONITORING FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.903', '2026-07-11 03:32:01.903'),
(642, 'HAZARDS MONITORING FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.914', '2026-07-11 03:32:01.914'),
(643, 'VISITOR MONITORING FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.922', '2026-07-11 03:32:01.922'),
(644, 'CLOG WASHING MONITORING FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.934', '2026-07-11 03:32:01.934'),
(645, 'LOOSE ITEM MONITORING FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.943', '2026-07-11 03:32:01.943'),
(646, 'FINISHED PRODUCT TEMPERATURE MONITORING FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.952', '2026-07-11 03:32:01.952'),
(647, 'RAW MATS TAGGING MONITORING - WHOLE EGG', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.962', '2026-07-11 03:32:01.962'),
(648, 'TUNNEL OVEN TEMPERATURE MONITORING FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.972', '2026-07-11 03:32:01.972'),
(649, 'WHOLE EGG RECEIVING MONITORING FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.983', '2026-07-11 03:32:01.983'),
(650, 'SOP FORMING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:01.993', '2026-07-11 03:32:01.993'),
(651, 'SOP EGG PREP', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.003', '2026-07-11 03:32:02.003'),
(652, 'SOP PRIMARY PACKAGING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.011', '2026-07-11 03:32:02.011'),
(653, 'EGG WHITE & EGGYOLK TEMPERATURE MONITORING FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.019', '2026-08-28 08:36:50.940'),
(654, 'WEIGHING SCALE PERFORMANCE VERIFICATION FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.028', '2026-07-11 03:32:02.028'),
(655, 'INCOMING DELIVERY VEHICLE MONITORING FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.038', '2026-07-11 03:32:02.038'),
(656, 'DAILY PLANT SANITATION INSPECTION FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.048', '2026-07-11 03:32:02.048'),
(657, 'SANITIZER CONCENTRATION MONITORING FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.056', '2026-07-11 03:32:02.056'),
(658, 'PERSONNEL HANDWASHING MONITORING FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.065', '2026-07-11 03:32:02.065'),
(659, 'FINISHED PRODUCT EVALUATION (RETENTION)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.074', '2026-07-11 03:32:02.074'),
(660, 'LOOSE ITEM MONITORING FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.084', '2026-07-11 03:32:02.084'),
(661, 'TUNNEL OVEN TEMPERATURE MONITORING FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.096', '2026-07-11 03:32:02.096'),
(662, 'FINISHED PRODUCT RETENTION MONITORING FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.108', '2026-07-11 03:32:02.108'),
(663, 'IN - PROCESS MONITORING FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.117', '2026-07-11 03:32:02.117'),
(664, 'HAND WASHING & CLEANING VERIFICATION FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.126', '2026-07-11 03:32:02.126'),
(665, 'THERMOHYGROMETER MONITORING FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.134', '2026-07-11 03:32:02.134'),
(666, 'INTERNAL AUDIT RESULT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.150', '2026-07-11 03:32:02.150'),
(667, 'FDA AUDIT RESULT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.167', '2026-07-11 03:32:02.167'),
(668, 'MONTHLY PREVENTIVE MAINTENANCE PROGRAM MIXER (MPMP)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.194', '2026-07-11 03:32:02.194'),
(669, 'DAILY MONITORING OITSIDE AREA PK BUILDING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.204', '2026-07-11 03:32:02.204'),
(670, 'DAILY MONITORING - BAKING OVEN', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.215', '2026-07-11 03:32:02.215'),
(671, 'DAILY MONITORING - ROASTING AREA', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.224', '2026-07-11 03:32:02.224'),
(672, 'DAILY MONITORING - AEROS AREA', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.235', '2026-07-11 03:32:02.235'),
(673, 'EQUIPMENT MONITORING SYSTEM - FIRE EXTINGUISHER MONTHLY MONITORING REPORT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.244', '2026-07-11 03:32:02.244'),
(674, 'EQUIPMENT MONITORING SYSTEM - MONTHLY & QUARTERLY CHECKLIST PREVENTIVE MAINTENANCE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.255', '2026-07-11 03:32:02.255'),
(675, 'EQUIPMENT MONITORING SYSTEM - EQUIPMENT INFORMATION SHEET', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.266', '2026-07-11 03:32:02.266'),
(676, 'EQUIPMENT MONITORING SYSTEM - MONTHLY PREVENTIVE BAND SEALER & HAND SEALER', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.276', '2026-07-11 03:32:02.276'),
(677, 'QUALITY CONTROL SYSTEM - LIGHT MONITORING CHECKLIST', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.285', '2026-07-11 03:32:02.285'),
(678, 'QUALITY CONTROL SYSTEM - GLASS MONITORING INSPECTION FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.293', '2026-07-11 03:32:02.293'),
(679, 'QUALITY CONTROL SYSTEM - EMERGENCY LIGHT & UV INSECUTOR CHECKLIST', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.301', '2026-07-11 03:32:02.301'),
(680, 'HAZARD IDENTIFICATINON RISK ASSESSTMENT CONTROL', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.311', '2026-07-11 03:32:02.311'),
(681, 'GREASE VAULT MONITORING FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.319', '2026-07-11 03:32:02.319'),
(682, 'MONTHLY PREVENTIVE MAINTENANCE PROGRAM - MIXER', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.328', '2026-07-11 03:32:02.328'),
(683, 'PANEL BOARD MONITORING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.339', '2026-07-11 03:32:02.339'),
(684, 'FOOD GRADE OIL & GREASE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.349', '2026-07-11 03:32:02.349'),
(685, 'DAILY MONITORING - MIXING AREA', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.360', '2026-07-11 03:32:02.360'),
(686, 'DAILY MONITORING FORM - SMOKE & HEAT DETECTOR', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.377', '2026-07-11 03:32:02.377'),
(687, 'FAUCETS MONITORING FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.423', '2026-07-11 03:32:02.423'),
(688, 'WINDOW MONITORING FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.437', '2026-07-11 03:32:02.437'),
(689, 'LIGHT MONITORING CHECKLIST', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.454', '2026-07-11 03:32:02.454'),
(690, 'Cover Page', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.466', '2026-07-11 03:32:02.466'),
(691, 'Quarterly (Water-based fire supression system)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.478', '2026-07-11 03:32:02.478'),
(692, 'Semi - Annually (Fire detection and Alarm System)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.489', '2026-07-11 03:32:02.489'),
(693, 'Weekly (Water-based fire supression system)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.498', '2026-07-11 03:32:02.498'),
(694, 'Monthly (Exit and Engress)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.507', '2026-07-11 03:32:02.507'),
(695, 'PREVENTIVE MAINTENANCE PROGRAM FOR EQUIPMENT 2026', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.516', '2026-07-11 03:32:02.516'),
(696, 'EMS - MASTER LIST', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.527', '2026-07-11 03:32:02.527'),
(697, 'EMS - PMS WALL FAN AND INDUSTRIAL', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.536', '2026-07-11 03:32:02.536'),
(698, 'EMS - PMS PLANETARY MIXER', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.548', '2026-07-11 03:32:02.548'),
(699, 'EMS - PMS OVEN MACHINE LINE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.556', '2026-07-11 03:32:02.556'),
(700, 'EMS - PMS EXHAUST, BLOWER AND HEAT PUMP', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.566', '2026-07-11 03:32:02.566'),
(701, 'EMS - PMS BAND SEALER, HAND SEALER AND FOOT SEALER', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.576', '2026-07-11 03:32:02.576');
INSERT INTO `documents` (`document_id`, `document_title`, `document_type`, `status`, `request_date`, `department`, `business_document_type`, `action_requested`, `from_party`, `to_party`, `reason_for_change`, `brief_description`, `proposed_change`, `revision_level_from`, `revision_level_to`, `previous_effective_date`, `new_effective_date`, `date_received`, `date_released`, `approval_date`, `legacy_imported`, `creation_source`, `creation_reason`, `direct_created_at`, `legacy_import_note`, `status_before_disposal`, `requested_by_name`, `disposal_remarks`, `disposal_action`, `disposal_action_other`, `disposed_at`, `disposed_by_name`, `created_by`, `requested_by_user_id`, `disposed_by_user_id`, `reviewed_by_user_id`, `reviewed_at`, `reviewer_remarks`, `workflow_version_id`, `workflow_snapshot`, `workflow_current_node_key`, `source_document_id`, `source_document_updated_at`, `created_at`, `updated_at`) VALUES
(702, 'EMS - PMS AERATOR MACHINE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.586', '2026-07-11 03:32:02.586'),
(703, 'EMS - PMS PEANUT ROASTER LINE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.597', '2026-07-11 03:32:02.597'),
(704, 'EMS - PMS REFRIGERATION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.605', '2026-07-11 03:32:02.605'),
(705, 'EMS - PMS AIR - CONDITIONING UNIT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.614', '2026-07-11 03:32:02.614'),
(706, 'RAW PEANUTS RECEIVED', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.628', '2026-07-11 03:32:02.628'),
(707, 'MOISTURE PEANUTS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.639', '2026-07-11 03:32:02.639'),
(708, 'INCIDENT REPORT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.653', '2026-07-11 03:32:02.653'),
(709, 'RAW PEANUT STOCKING & STORAGE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.665', '2026-07-11 03:32:02.665'),
(710, 'MONITORING FORM (COLD STORAGE)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.675', '2026-07-11 03:32:02.675'),
(711, 'COA - CERTIFICATE OF ANALYSIS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.688', '2026-07-11 03:32:02.688'),
(712, 'GOLDILOCKS PRODUCT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.711', '2026-07-11 03:32:02.711'),
(713, 'EGG BREAKING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.723', '2026-07-11 03:32:02.723'),
(714, 'RAW PEANUTS RECEIVING PPM REPORT 2023', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.733', '2026-07-11 03:32:02.733'),
(715, 'PRE - PROCESSING GLOVES & SUPPLIER MONITORING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.745', '2026-07-11 03:32:02.745'),
(716, 'SUGAR RECEIVING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.754', '2026-07-11 03:32:02.754'),
(717, 'EMPLOYEE EGG BREAKING, PEANUT SELECTION & BAKING MISCONDUYCT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.766', '2026-07-11 03:32:02.766'),
(718, 'INCIDENT REPORT (PEANUT REJECTED REPORT) EGGYOLK FORWARD & WITHDRAWAL REPORTS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.775', '2026-07-11 03:32:02.775'),
(719, 'CLEANING & SANITATION PROGRAM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.788', '2026-07-11 03:32:02.788'),
(720, 'CLEANING PROCEDURE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.799', '2026-07-11 03:32:02.799'),
(721, 'CLEANING SCHEDULE MONITORING FORM CLEANING SANITATION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.810', '2026-07-11 03:32:02.810'),
(722, 'GENERAL CLEANING MONITORING FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.819', '2026-07-11 03:32:02.819'),
(723, 'DAILY CHEMICAL WITHDRAWAL FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.831', '2026-07-11 03:32:02.831'),
(724, 'DISPENSERS CLEANING MONITORING FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.844', '2026-07-11 03:32:02.844'),
(725, 'PEST CONTROL CHEMICAL MONITORING FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.870', '2026-07-11 03:32:02.870'),
(726, 'MONTHLY CHEMICAL CONSUMPTION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:02.959', '2026-07-11 03:32:02.959'),
(727, 'GARBAGE DISPOSAL', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:03.038', '2026-07-11 03:32:03.038'),
(728, 'GENERAL CLEANING MONITORING FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:03.091', '2026-07-11 03:32:03.091'),
(729, 'DAILY & CHEMICAL CONSUMPTION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:03.162', '2026-07-11 03:32:03.162'),
(730, 'MACHINE PREVENTIVE CLEANING & SANITATION CHECKLIST', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:03.222', '2026-07-11 03:32:03.222'),
(731, 'FOOD CONTACT SURFACES MONITORING CHECKLIST', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:03.263', '2026-07-11 03:32:03.263'),
(732, 'DAILY SANITATION CHECKLIST', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:03.304', '2026-07-11 03:32:03.304'),
(733, 'SOLID WASTE PROGRAM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:03.356', '2026-07-11 03:32:03.356'),
(734, 'DAILY CHEMICAL DILUTION MONITORING FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:03.402', '2026-07-11 03:32:03.402'),
(735, 'TRANSMITTAL FOR LAUNDRY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:03.451', '2026-07-11 03:32:03.451'),
(736, 'CHEMICAL RECEIVING MONITORING FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:03.510', '2026-07-11 03:32:03.510'),
(737, 'LIGHT DISPOSAL', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:03.614', '2026-07-11 03:32:03.614'),
(738, 'ENTECH REPORT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:03.658', '2026-07-11 03:32:03.658'),
(739, 'COA CHEMICALS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:03.702', '2026-07-11 03:32:03.702'),
(740, 'CLEANING & SANITATION PROGRAM - VIEWING DECK', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:03.734', '2026-07-11 03:32:03.734'),
(741, 'SOLID WASTE MANAGEMENT PROGRAM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:03.772', '2026-07-11 03:32:03.772'),
(742, 'CLEANING SANITATION CHECKLIST', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:03.849', '2026-07-11 03:32:03.849'),
(743, 'TRANSMITTAL', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:03.920', '2026-07-11 03:32:03.920'),
(744, 'PEST CONTROL CLEARANCE CHECKLIST', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.035', '2026-07-11 03:32:04.035'),
(745, 'PEST CONTROL PROGRAM 2025', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.075', '2026-07-11 03:32:04.075'),
(746, 'DAILY CHEMICAL DILUTION MONITORING FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.128', '2026-07-11 03:32:04.128'),
(747, 'ENTECH PROGRAM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.160', '2026-07-11 03:32:04.160'),
(748, 'PRODUCTION PROCESS MONITORING PRIMARY PACKAGING - 100G', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.180', '2026-07-11 03:32:04.180'),
(749, 'PRODUCTION PROCESS MONITPRING PRIMARY PACKAGING - 20G JAN-JUNE 2023', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.192', '2026-07-11 03:32:04.192'),
(750, 'PLAIN PACKAGING RELEASING MONITORING FORM 2023', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.202', '2026-07-11 03:32:04.202'),
(751, 'TERTIARY PACKAGING 2023', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.212', '2026-07-11 03:32:04.212'),
(752, 'PRIMARY PACKAGING 20G JULY-DEC 2023', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.224', '2026-07-11 03:32:04.224'),
(753, 'PRODUCTION PROCESS MONITORING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.235', '2026-07-11 03:32:04.235'),
(754, 'BAKED RECEIVED JAN-MAY 2023', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.246', '2026-07-11 03:32:04.246'),
(755, 'PRODUCT PROCESS MONITORING JAN-FEB 2023 EGG PREPARATION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.259', '2026-07-11 03:32:04.259'),
(756, 'PRODUCT PROCESS MONITORING JAN-FEB 2023 MIXING AREA', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.269', '2026-07-11 03:32:04.269'),
(757, 'PRODUCT PROCESS MONITORING JAN-FEB 2023 PEANUT SECTION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.279', '2026-07-11 03:32:04.279'),
(758, 'BLANK FORMS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.289', '2026-07-11 03:32:04.289'),
(759, 'BLANK FORMS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.302', '2026-07-11 03:32:04.302'),
(760, 'EMPLOYEE TRAINING MODULE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.317', '2026-07-11 03:32:04.317'),
(761, 'PK EMLOYEE MISCONDUCT REPORT PACKING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.327', '2026-07-11 03:32:04.327'),
(762, 'PEANUT KISSES EMPLOYEE MISCONDUCT REPORT FORMING & BAKING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.340', '2026-07-11 03:32:04.340'),
(763, 'PEANUT KISSES EMPLOYEE MISCONDUCT REPORT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.351', '2026-07-11 03:32:04.351'),
(764, 'FORMING ATTENDANCE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.362', '2026-07-11 03:32:04.362'),
(765, 'FORMING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.371', '2026-07-11 03:32:04.371'),
(766, 'PAN GREASE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.383', '2026-07-11 03:32:04.383'),
(767, 'BAKERY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.394', '2026-07-11 03:32:04.394'),
(768, 'ACMAD, JIFFY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.404', '2026-07-11 03:32:04.404'),
(769, 'AMONCIO, EDRIAN', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.413', '2026-07-11 03:32:04.413'),
(770, 'AÑASCO, JESIELO A.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.424', '2026-07-11 03:32:04.424'),
(771, 'ANGGO, ALBERTO', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.435', '2026-07-11 03:32:04.435'),
(772, 'AYCO, GRACIANO', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.444', '2026-07-11 03:32:04.444'),
(773, 'APOLONA, IRENE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.458', '2026-07-11 03:32:04.458'),
(774, 'BALITE, ROWEL', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.469', '2026-07-11 03:32:04.469'),
(775, 'BALICOG, ROLAN', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.481', '2026-07-11 03:32:04.481'),
(776, 'BALO, RUEL', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.493', '2026-07-11 03:32:04.493'),
(777, 'BANTUGAN, RUBERT JIREH', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.654', '2026-07-11 03:32:04.654'),
(778, 'BARANGAN, EDLEN', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.664', '2026-07-11 03:32:04.664'),
(779, 'BERNALES, JAMES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.672', '2026-07-11 03:32:04.672'),
(780, 'BARRETE, WINDYL B.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.681', '2026-07-11 03:32:04.681'),
(781, 'BONGALOA, RHANEL', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.689', '2026-07-11 03:32:04.689'),
(782, 'BROÑOLA, ELDRIAN R.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.699', '2026-07-11 03:32:04.699'),
(783, 'BUSTRILLO, MARJOE REY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.709', '2026-07-11 03:32:04.709'),
(784, 'CALACAT, JOHN LYOD', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.717', '2026-07-11 03:32:04.717'),
(785, 'CALIMBAYAN, JOCELYN', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.725', '2026-07-11 03:32:04.725'),
(786, 'CARZO, IAN', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.734', '2026-07-11 03:32:04.734'),
(787, 'CASTRODES, ALMA', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.744', '2026-07-11 03:32:04.744'),
(788, 'COQUILLA ANGELIE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.757', '2026-07-11 03:32:04.757'),
(789, 'COTO, CRISTIAN', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.767', '2026-07-11 03:32:04.767'),
(790, 'DAGONDON, GIERALD P.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.777', '2026-07-11 03:32:04.777'),
(791, 'DELA PEÑA , MARK', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.788', '2026-07-11 03:32:04.788'),
(792, 'DELUSA, DAISY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.796', '2026-07-11 03:32:04.796'),
(793, 'DINOY, JOHN BERT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.803', '2026-07-11 03:32:04.803'),
(794, 'ERSAN, JONA MAE P.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.814', '2026-07-11 03:32:04.814'),
(795, 'ESCLITO, JUSTINE G.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.824', '2026-07-11 03:32:04.824'),
(796, 'FLORES, CHRISHARVEY M.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.833', '2026-07-11 03:32:04.833'),
(797, 'GABINES, ARSIEL', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.842', '2026-07-11 03:32:04.842'),
(798, 'GAMALO, JOHN', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.852', '2026-07-11 03:32:04.852'),
(799, 'GOJOL, EFREN', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.860', '2026-07-11 03:32:04.860'),
(800, 'GUMOP-AS, NATHANIEL M.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.868', '2026-07-11 03:32:04.868'),
(801, 'HERMOCILLA, ELY P.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.877', '2026-07-11 03:32:04.877');
INSERT INTO `documents` (`document_id`, `document_title`, `document_type`, `status`, `request_date`, `department`, `business_document_type`, `action_requested`, `from_party`, `to_party`, `reason_for_change`, `brief_description`, `proposed_change`, `revision_level_from`, `revision_level_to`, `previous_effective_date`, `new_effective_date`, `date_received`, `date_released`, `approval_date`, `legacy_imported`, `creation_source`, `creation_reason`, `direct_created_at`, `legacy_import_note`, `status_before_disposal`, `requested_by_name`, `disposal_remarks`, `disposal_action`, `disposal_action_other`, `disposed_at`, `disposed_by_name`, `created_by`, `requested_by_user_id`, `disposed_by_user_id`, `reviewed_by_user_id`, `reviewed_at`, `reviewer_remarks`, `workflow_version_id`, `workflow_snapshot`, `workflow_current_node_key`, `source_document_id`, `source_document_updated_at`, `created_at`, `updated_at`) VALUES
(802, 'LACEA, JEFFREY B.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.884', '2026-07-11 03:32:04.884'),
(803, 'LAGRIMAS, JANISSA C.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.894', '2026-07-11 03:32:04.894'),
(804, 'LIBA, JAMES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.901', '2026-07-11 03:32:04.901'),
(805, 'LIBOT, ANDIE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.909', '2026-07-11 03:32:04.909'),
(806, 'LIGUA, JOBERT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.919', '2026-07-11 03:32:04.919'),
(807, 'LINGATONG CHRISTIAN IVAN T.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.930', '2026-07-11 03:32:04.930'),
(808, 'LINO, TASIC J.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.940', '2026-07-11 03:32:04.940'),
(809, 'LOGROñÑO, JESUSA', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.951', '2026-07-11 03:32:04.951'),
(810, 'LOMOCSO, JOEL', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.959', '2026-07-11 03:32:04.959'),
(811, 'LOON, MARK LESTER', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.967', '2026-07-11 03:32:04.967'),
(812, 'LUPIBA, MARK STEVEN', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.975', '2026-07-11 03:32:04.975'),
(813, 'MACABODBOD, ROSELYN', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.984', '2026-07-11 03:32:04.984'),
(814, 'MAGALE, JAMES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:04.995', '2026-07-11 03:32:04.995'),
(815, 'MAPUTOL, ALFRED H.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.002', '2026-07-11 03:32:05.002'),
(816, 'MEGUILLO, DEO NECO L.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.010', '2026-07-11 03:32:05.010'),
(817, 'MEJORADA, JEMUEL', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.019', '2026-07-11 03:32:05.019'),
(818, 'MURILLO, MARIA GAY D.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.028', '2026-07-11 03:32:05.028'),
(819, 'NIÑOFRANCO, JAYMAR', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.035', '2026-07-11 03:32:05.035'),
(820, 'OBISPO, ANNE CHRIST B.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.045', '2026-07-11 03:32:05.045'),
(821, 'ORBUDA, NADOR JR. P.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.052', '2026-07-11 03:32:05.052'),
(822, 'PANGANORON, LUCILE D.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.060', '2026-07-11 03:32:05.060'),
(823, 'PAYOT, NEIL', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.068', '2026-07-11 03:32:05.068'),
(824, 'PEREZ, JOHN CLIFFORD', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.076', '2026-07-11 03:32:05.076'),
(825, 'PERGES, HERO', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.085', '2026-07-11 03:32:05.085'),
(826, 'PODPOD, JERALD', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.094', '2026-07-11 03:32:05.094'),
(827, 'RANAS, JUMAEL S.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.102', '2026-07-11 03:32:05.102'),
(828, 'REGALADO, EMMANUEL JR. T.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.111', '2026-07-11 03:32:05.111'),
(829, 'RESUSTA, JOHN WILMARC P.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.119', '2026-07-11 03:32:05.119'),
(830, 'REQUINA, DIO ALDWIN', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.127', '2026-07-11 03:32:05.127'),
(831, 'ROSALES, ELYN', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.136', '2026-07-11 03:32:05.136'),
(832, 'ROXAS, JENO', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.144', '2026-07-11 03:32:05.144'),
(833, 'SAGAL, KYLE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.153', '2026-07-11 03:32:05.153'),
(834, 'SALCEDO, MARK BELL M.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.165', '2026-07-11 03:32:05.165'),
(835, 'SOBSOBAN, EDRIAN', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.173', '2026-07-11 03:32:05.173'),
(836, 'TORIBIO, JULIO', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.184', '2026-07-11 03:32:05.184'),
(837, 'TUMAMPOS, KRYSADEL', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.193', '2026-07-11 03:32:05.193'),
(838, 'FORMING PPM - 023', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.203', '2026-07-11 03:32:05.203'),
(839, 'BAKING PPM - 022 OUTFEEDING FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.214', '2026-07-11 03:32:05.214'),
(840, 'BAKING PPM - 014', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.222', '2026-07-11 03:32:05.222'),
(841, 'FORMING PPM - 012', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.232', '2026-07-11 03:32:05.232'),
(842, 'PK IN-HOUSE MEMO\'S', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.243', '2026-07-11 03:32:05.243'),
(843, 'PRODUCTION INCIDENT REPORT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.252', '2026-07-11 03:32:05.252'),
(844, 'CHARGE SLIP', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.260', '2026-07-11 03:32:05.260'),
(845, 'RESIGNED & CLEARED', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.270', '2026-07-11 03:32:05.270'),
(846, 'PK DAILY SENSORY EVALUATION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.281', '2026-07-11 03:32:05.281'),
(847, 'COMMISSARY COMPOUND MEMO', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.289', '2026-07-11 03:32:05.289'),
(848, 'FS&QA MEMOS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.299', '2026-07-11 03:32:05.299'),
(849, 'MEMO', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.307', '2026-07-11 03:32:05.307'),
(850, 'PACKAGING GLOVES MONITORING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.318', '2026-07-11 03:32:05.318'),
(851, 'EMPLOYEE WAIVER MONITORING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.328', '2026-07-11 03:32:05.328'),
(852, 'EMPLOYEE INJURY/ILLNESS REPORT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.336', '2026-07-11 03:32:05.336'),
(853, 'PRODUCTION PROCESS MONITORING FOR THE MONTH OF SEPTEMBER', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.348', '2026-07-11 03:32:05.348'),
(854, 'OVEN CLEANING SCHEDULE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.356', '2026-07-11 03:32:05.356'),
(855, 'MINUTES OF MEETING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.367', '2026-07-11 03:32:05.367'),
(856, 'MEDICINE MONITORING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.375', '2026-07-11 03:32:05.375'),
(857, 'DAILY MACHINES AT THE BACK OF PK', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.383', '2026-07-11 03:32:05.383'),
(858, 'FPEF (8 MONTHS EXPIRY)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.391', '2026-07-11 03:32:05.391'),
(859, 'INCIDENT REPORT & DISPOSAL REPORT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.401', '2026-07-11 03:32:05.401'),
(860, 'PRODUCTION PROCESS MONITORING FOR THE MONTH OF FEBRUARY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.410', '2026-07-11 03:32:05.410'),
(861, 'SOA - SOUTH PALM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.421', '2026-07-11 03:32:05.421'),
(862, 'SOA - CENTRAL DISTRIBUTION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.430', '2026-07-11 03:32:05.430'),
(863, 'SOA - ALTURAS TALIBON', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.438', '2026-07-11 03:32:05.438'),
(864, 'SOA - ALTURAS TUBIGON', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.449', '2026-07-11 03:32:05.449'),
(865, 'SOA - PLAZA MARCELA BREAD COTTAGE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.458', '2026-07-11 03:32:05.458'),
(866, 'SOA - PLAZA MARCELA SUPERMARKET', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.468', '2026-07-11 03:32:05.468'),
(867, 'SOA - ICM BREAD COTTAGE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.486', '2026-07-11 03:32:05.486'),
(868, 'SOA - ALTURAS MALL BREAD COTTAGE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.496', '2026-07-11 03:32:05.496'),
(869, 'SOA - ALTURAS SUPERMARKET', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.505', '2026-07-11 03:32:05.505'),
(870, 'SOA - DRESSING PLANT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.518', '2026-07-11 03:32:05.518'),
(871, 'SOA - ENS TRADING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.527', '2026-07-11 03:32:05.527'),
(872, 'SOA - BAMDECORP', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.535', '2026-07-11 03:32:05.535'),
(873, 'SOA - ALTURAS PANGLAO', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.544', '2026-07-11 03:32:05.544'),
(874, 'SOA - NORTHZEN', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.553', '2026-07-11 03:32:05.553'),
(875, 'SOA - OCEANICA', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.563', '2026-07-11 03:32:05.563'),
(876, 'SOA - ICM DEPARTMENT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.573', '2026-07-11 03:32:05.573'),
(877, 'SOA - ICM SUPERMARKET', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.582', '2026-07-11 03:32:05.582'),
(878, 'ARLAN LIM DEBALUCOS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.590', '2026-07-11 03:32:05.590'),
(879, 'TRADE CHANNEL - CECELIA GENITE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.599', '2026-07-11 03:32:05.599'),
(880, 'TRADE CHANNEL - PRAWN FARM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.609', '2026-07-11 03:32:05.609'),
(881, 'WHOLE SALE GROUP DISTRIBUTION FR', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.618', '2026-07-11 03:32:05.618'),
(882, 'ASSORTEED SOA UNPAID', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.626', '2026-07-11 03:32:05.626'),
(883, 'UNPAID SOA', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.635', '2026-07-11 03:32:05.635'),
(884, 'TRADE CHANNEL - APRONIANA', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.651', '2026-07-11 03:32:05.651'),
(885, 'SOA - ICM CANTEEN', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.662', '2026-07-11 03:32:05.662'),
(886, 'TRADE CHANNEL - MEMO (ACCTG COPY)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.671', '2026-07-11 03:32:05.671'),
(887, 'ACCOUNT - CALIFORNIA FOOD GIFT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.680', '2026-07-11 03:32:05.680'),
(888, 'ACCOUNT - ISLAND PASALUBONG', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.687', '2026-07-11 03:32:05.687'),
(889, 'PURCHASE ORDER CEBU', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.698', '2026-07-11 03:32:05.698'),
(890, 'PRICE QUOTATION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.707', '2026-07-11 03:32:05.707'),
(891, 'SOA - SUPPLIER\'S MART', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.717', '2026-07-11 03:32:05.717'),
(892, 'SOA - BOHOL QUALITY MALL', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.730', '2026-07-11 03:32:05.730'),
(893, 'SOA - PLAZA MARCELA FOODWALK', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.738', '2026-07-11 03:32:05.738'),
(894, 'SOA - ICM FOODWALK', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.747', '2026-07-11 03:32:05.747'),
(895, 'SOA - ALTURAS TALIBON FOODWALK', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.754', '2026-07-11 03:32:05.754'),
(896, 'SOA - ALTURAS MALL FASTFOOD', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.766', '2026-07-11 03:32:05.766'),
(897, 'SOA - BS COMMISSARY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.777', '2026-07-11 03:32:05.777'),
(898, 'SOA - ALLTA CITTA', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.788', '2026-07-11 03:32:05.788'),
(899, 'SOA - CORPORATE/HO', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.799', '2026-07-11 03:32:05.799'),
(900, '201 FILE-BFPC-AE-ALAAN, WARPHY J.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.811', '2026-07-11 03:32:05.811'),
(901, '201 FILE-BFPC-AE-AMADEO, RON DICKENS P.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.820', '2026-07-11 03:32:05.820'),
(902, '201 FILE-BFPC-AE-ANGGO, ALBERTO L. JR.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.828', '2026-07-11 03:32:05.828');
INSERT INTO `documents` (`document_id`, `document_title`, `document_type`, `status`, `request_date`, `department`, `business_document_type`, `action_requested`, `from_party`, `to_party`, `reason_for_change`, `brief_description`, `proposed_change`, `revision_level_from`, `revision_level_to`, `previous_effective_date`, `new_effective_date`, `date_received`, `date_released`, `approval_date`, `legacy_imported`, `creation_source`, `creation_reason`, `direct_created_at`, `legacy_import_note`, `status_before_disposal`, `requested_by_name`, `disposal_remarks`, `disposal_action`, `disposal_action_other`, `disposed_at`, `disposed_by_name`, `created_by`, `requested_by_user_id`, `disposed_by_user_id`, `reviewed_by_user_id`, `reviewed_at`, `reviewer_remarks`, `workflow_version_id`, `workflow_snapshot`, `workflow_current_node_key`, `source_document_id`, `source_document_updated_at`, `created_at`, `updated_at`) VALUES
(903, '201 FILE-BFPC-AE-APOLONA, IRENE J.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.840', '2026-07-11 03:32:05.840'),
(904, '201 FILE-BFPC-AE-AUDITOR, ALICE A.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.849', '2026-07-11 03:32:05.849'),
(905, '201 FILE-BFPC-AE-AYCO, GRACIANO D.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.860', '2026-07-11 03:32:05.860'),
(906, '201 FILE-BFPC-AE-BALICOG, ROLAN R.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.869', '2026-07-11 03:32:05.869'),
(907, '201 FILE-BFPC-AE-BALIONG, EVELYN S.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.877', '2026-07-11 03:32:05.877'),
(908, '201 FILE-BFPC-AE-BALITE, ROWEL M.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.886', '2026-07-11 03:32:05.886'),
(909, '201 FILE-BFPC-AE-BALO, RUEL P.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.895', '2026-07-11 03:32:05.895'),
(910, '201 FILE-BFPC-AE-BANTUGAN, RUBERT JIREH T.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.905', '2026-07-11 03:32:05.905'),
(911, '201 FILE-BFPC-AE-BARANGAN, EDLEN B.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.915', '2026-07-11 03:32:05.915'),
(912, '201 FILE-BFPC-AE-BATION, SHERYLYN B.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.922', '2026-07-11 03:32:05.922'),
(913, '201 FILE-BFPC-AE-BATUTAY, PEDRO O.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.950', '2026-07-11 03:32:05.950'),
(914, '201 FILE-BFPC-AE-BAUGBOG, JERICHO N.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.963', '2026-07-11 03:32:05.963'),
(915, '201 FILE-BFPC-AE-BELLEZAS, JOMAR', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.971', '2026-07-11 03:32:05.971'),
(916, '201 FILE-BFPC-AE-BERNALES, JAMES P.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.983', '2026-07-11 03:32:05.983'),
(917, '201 FILE-BFPC-AE-BERONILLA, DEXTER JOHN R.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:05.994', '2026-07-11 03:32:05.994'),
(918, '201 FILE-BFPC-AE-BITAS, JEMMA B.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.004', '2026-07-11 03:32:06.004'),
(919, '201 FILE-BFPC-AE-BUCAG, JERIC O.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.015', '2026-07-11 03:32:06.015'),
(920, '201 FILE-BFPC-AE-BUTLIG, JOVILYN A.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.025', '2026-07-11 03:32:06.025'),
(921, '201 FILE-BFPC-AE-CALIMBAYAN, JOCELYN R.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.033', '2026-07-11 03:32:06.033'),
(922, '201 FILE-BFPC-AE-CARZO, IAN JAY P.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.042', '2026-07-11 03:32:06.042'),
(923, '201 FILE-BFPC-AE-CASTRODES, ALMA C.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.053', '2026-07-11 03:32:06.053'),
(924, '201 FILE-BFPC-AE-COMAMAO, PRINCE JOHN C.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.065', '2026-07-11 03:32:06.065'),
(925, '201 FILE-BFPC-AE-CRUSIT, RENATO A. JR.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.075', '2026-07-11 03:32:06.075'),
(926, '201 FILE-BFPC-AE-DAG-UM, JOSEPHINE S.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.085', '2026-07-11 03:32:06.085'),
(927, '201 FILE-BFPC-AE-DALISAY, AMELYN Q.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.095', '2026-07-11 03:32:06.095'),
(928, '201 FILE-BFPC-AE-DAQUIPIL, DONATA P.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.104', '2026-07-11 03:32:06.104'),
(929, '201 FILE-BFPC-AE-DEPOSA, LEVI D.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.114', '2026-07-11 03:32:06.114'),
(930, '201 FILE-BFPC-AE-DELA PEÑA, MARK', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.125', '2026-07-11 03:32:06.125'),
(931, '201 FILE-BFPC-AE-ECHAVARI, THERESSE JANE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.133', '2026-07-11 03:32:06.133'),
(932, '201 FILE-BFPC-AE-EDUBAS, JERALD P.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.148', '2026-07-11 03:32:06.148'),
(933, '201 FILE-BFPC-AE-ESCLITO, JUSTINE G.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.159', '2026-07-11 03:32:06.159'),
(934, '201 FILE-BFPC-AE-ESTILLORE, VIRGINITA A.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.170', '2026-07-11 03:32:06.170'),
(935, '201 FILE-BFPC-AE-GABATO, DENNIS T.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.183', '2026-07-11 03:32:06.183'),
(936, '201 FILE-BFPC-AE-GABINES, ARSIEL V.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.194', '2026-07-11 03:32:06.194'),
(937, '201 FILE-BFPC-AE-GAMALO, JOHN G.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.203', '2026-07-11 03:32:06.203'),
(938, '201 FILE-BFPC-AE-GANUB, JENNIFER U.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.215', '2026-07-11 03:32:06.215'),
(939, '201 FILE-BFPC-AE-GASTONES, NORBERTO R.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.226', '2026-07-11 03:32:06.226'),
(940, '201 FILE-BFPC-AE-GELICAME, RIZA MAE B.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.235', '2026-07-11 03:32:06.235'),
(941, '201 FILE-BFPC-AE-GOHOL,EFREN M.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.244', '2026-07-11 03:32:06.244'),
(942, '201 FILE-BFPC-AE-GONZALES, LYXFER', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.276', '2026-07-11 03:32:06.276'),
(943, '201 FILE-BFPC-AE-GUCOR, CRESANTA J.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.285', '2026-07-11 03:32:06.285'),
(944, '201 FILE-BFPC-AE-IDAGO, MARIVIC T.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.293', '2026-07-11 03:32:06.293'),
(945, '201 FILE-BFPC-AE-JAMIS, JIMBOY O.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.301', '2026-07-11 03:32:06.301'),
(946, '201 FILE-BFPC-AE-JULIO, TORIBIO P. JR.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.312', '2026-07-11 03:32:06.312'),
(947, '201 FILE-BFPC-AE-JUMAWAN, RAZEL C.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.327', '2026-07-11 03:32:06.327'),
(948, '201 FILE-BFPC-AE-JUNIO, ARNEL G.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.336', '2026-07-11 03:32:06.336'),
(949, '201 FILE-BFPC-AE-LABADLABAD, ARNEL O.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.343', '2026-07-11 03:32:06.343'),
(950, '201 FILE-BFPC-AE-LACEA, JEFFREY B.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.350', '2026-07-11 03:32:06.350'),
(951, '201 FILE-BFPC-AE-LADRA, RICHARD B.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.360', '2026-07-11 03:32:06.360'),
(952, '201 FILE-BFPC-AE-LAGRIMAS, JANISSA C.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.368', '2026-07-11 03:32:06.368'),
(953, '201 FILE-BFPC-AE-LIBA, ARIEL M.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.377', '2026-07-11 03:32:06.377'),
(954, '201 FILE-BFPC-AE-LIBA, JAMES IAN M.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.386', '2026-07-11 03:32:06.386'),
(955, '201 FILE-BFPC-AE-LIBADISOS, AIVAN HERMES B.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.396', '2026-07-11 03:32:06.396'),
(956, '201 FILE-BFPC-AE-LIBOT, ANDIE P.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.405', '2026-07-11 03:32:06.405'),
(957, '201 FILE-BFPC-AE-LOGROÑO, JESUSA O.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.432', '2026-07-11 03:32:06.432'),
(958, '201 FILE-BFPC-AE-LOMOCSO, JOEL B.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.443', '2026-07-11 03:32:06.443'),
(959, '201 FILE-BFPC-AE-MACABODBOD, ROSELYN A.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.462', '2026-07-11 03:32:06.462'),
(960, '201 FILE-BFPC-AE-MAGALLEN, NOVA MAE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.492', '2026-07-11 03:32:06.492'),
(961, '201 FILE-BFPC-AE-MANILA, MARVIN M.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.501', '2026-07-11 03:32:06.501'),
(962, '201 FILE-BFPC-AE-MATIVO, JUPER P.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.510', '2026-07-11 03:32:06.510'),
(963, '201 FILE-BFPC-AE-MOLINA, IRRAMAE P.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.517', '2026-07-11 03:32:06.517'),
(964, '201 FILE-BFPC-AE-MONTERMORSO, FEBRICH DEC M.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.526', '2026-07-11 03:32:06.526'),
(965, '201 FILE-BFPC-AE-MONTERO, JHONA MARY C.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.533', '2026-07-11 03:32:06.533'),
(966, '201 FILE-BFPC-AE-MONTERO, JHONA MARY C.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.541', '2026-07-11 03:32:06.541'),
(967, '201 FILE-BFPC-AE-MURILLO, MARIA GAY D.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.548', '2026-07-11 03:32:06.548'),
(968, '201 FILE-BFPC-AE-NIÑOFRANCO, JAYMAR M.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.558', '2026-07-11 03:32:06.558'),
(969, '201 FILE-BFPC-AE-ONRUBIA, JOHN ALBERT J.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.567', '2026-07-11 03:32:06.567'),
(970, '201 FILE-BFPC-AE-ORBUDA, NADOR JR. P.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.579', '2026-07-11 03:32:06.579'),
(971, '201 FILE-BFPC-AE-ORRICA, MA. JEMIELYN M.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.587', '2026-07-11 03:32:06.587'),
(972, '201 FILE-BFPC-AE-PAGA, ALEX M.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.597', '2026-07-11 03:32:06.597'),
(973, '201 FILE-BFPC-AE-PANOY, ROBERTO JR. P.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.607', '2026-07-11 03:32:06.607'),
(974, '201 FILE-BFPC-AE-PAYOT, JOHN MELBERT O.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.616', '2026-07-11 03:32:06.616'),
(975, '201 FILE-BFPC-AE-PAYOT, NEIL Y.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.626', '2026-07-11 03:32:06.626'),
(976, '201 FILE-BFPC-AE-PERGES, HERO', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.635', '2026-07-11 03:32:06.635'),
(977, '201 FILE-BFPC-AE-PIGTE, IRENEO S.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.647', '2026-07-11 03:32:06.647'),
(978, '201 FILE-BFPC-AE-PODPOD, JERALD T.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.659', '2026-07-11 03:32:06.659'),
(979, '201 FILE-BFPC-AE-PORLARES, ORENCIO M. JR.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.669', '2026-07-11 03:32:06.669'),
(980, '201 FILE-BFPC-AE-RAMIREZ, KERBY BRYAN A.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.677', '2026-07-11 03:32:06.677'),
(981, '201 FILE-BFPC-AE-RATILLA, JHEA S.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.687', '2026-07-11 03:32:06.687'),
(982, '201 FILE BFPC-AE-REGALADO, EMMANUEL JR. T.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.699', '2026-07-11 03:32:06.699'),
(983, '201 FILE-BFPC-AE-RENEGADO, SHERWIN B.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.709', '2026-07-11 03:32:06.709'),
(984, '201 FILE-BFPC-AE-REQUILLO, DARLENE IJIE M.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.718', '2026-07-11 03:32:06.718'),
(985, '201 FILE-BFPC-AE-REQUINA, DIO ALDWIN', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.727', '2026-07-11 03:32:06.727'),
(986, '201 FILE-BFPC-AE-RODRIGUEZ, CHRISTOPHER A.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.735', '2026-07-11 03:32:06.735'),
(987, '201 FILE-BFPC-AE-ROSALES, ELYN G.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.743', '2026-07-11 03:32:06.743'),
(988, '201 FILE-BFPC-AE-RUFIN, RAINIER', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.751', '2026-07-11 03:32:06.751'),
(989, '201 FILE-BFPC-AE-SACO, JUNREY C.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.759', '2026-07-11 03:32:06.759'),
(990, '201 FILE-BFPC-AE-SAGAL, KYLE S.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.770', '2026-07-11 03:32:06.770'),
(991, '201 FILE-BFPC-AE-SALCEDO, MARK BELL M.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.781', '2026-07-11 03:32:06.781'),
(992, '201 FILE-BFPC-AE-SAREN, MARICOR B.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.790', '2026-07-11 03:32:06.790'),
(993, '201 FILE-BFPC-AE-SEMPRON, JERNA LYN J.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.800', '2026-07-11 03:32:06.800'),
(994, '201 FILE-BFPC-AE-SOBSOBAN, EDRIAN O.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.809', '2026-07-11 03:32:06.809'),
(995, '201 FILE-BFPC-AE-SUMINGGIT, DENNIS V.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.820', '2026-07-11 03:32:06.820'),
(996, '201 FILE-BFPC-AE-TAGA-AN, WILLMA N.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.829', '2026-07-11 03:32:06.829'),
(997, '201 FILE-BFPC-AE-TARAY, JOHN CARL D.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.838', '2026-07-11 03:32:06.838'),
(998, '201 FILE-BFPC-AE-TASIC, LINO J.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.852', '2026-07-11 03:32:06.852'),
(999, '201 FILE-BFPC-AE-TASIC, LINO J.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.864', '2026-07-11 03:32:06.864'),
(1000, '201 FILE-BFPC-AE-TENDENCIA, JADE E.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.875', '2026-07-11 03:32:06.875');
INSERT INTO `documents` (`document_id`, `document_title`, `document_type`, `status`, `request_date`, `department`, `business_document_type`, `action_requested`, `from_party`, `to_party`, `reason_for_change`, `brief_description`, `proposed_change`, `revision_level_from`, `revision_level_to`, `previous_effective_date`, `new_effective_date`, `date_received`, `date_released`, `approval_date`, `legacy_imported`, `creation_source`, `creation_reason`, `direct_created_at`, `legacy_import_note`, `status_before_disposal`, `requested_by_name`, `disposal_remarks`, `disposal_action`, `disposal_action_other`, `disposed_at`, `disposed_by_name`, `created_by`, `requested_by_user_id`, `disposed_by_user_id`, `reviewed_by_user_id`, `reviewed_at`, `reviewer_remarks`, `workflow_version_id`, `workflow_snapshot`, `workflow_current_node_key`, `source_document_id`, `source_document_updated_at`, `created_at`, `updated_at`) VALUES
(1001, '201 FILE-BFPC-AE-TUMALA, VERONICA C.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.885', '2026-07-11 03:32:06.885'),
(1002, 'NESCO PEANUT KISSES EMPLOYEE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.897', '2026-07-11 03:32:06.897'),
(1003, 'NESCO PEANUT KISSES EMPLOYEE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.909', '2026-07-11 03:32:06.909'),
(1004, 'RESIGNED PK EMPLOYEE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.920', '2026-07-11 03:32:06.920'),
(1005, 'TRM AE - AMADEO, RON DICKENS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.931', '2026-07-11 03:32:06.931'),
(1006, 'TRM AE - AUDITOR, ALICE A.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.942', '2026-07-11 03:32:06.942'),
(1007, 'TRM AE - BUSLON, CHRISTIAN KENNEDY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.951', '2026-07-11 03:32:06.951'),
(1008, 'TRM AE - BUSTRILLO, MARJOE REY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.961', '2026-07-11 03:32:06.961'),
(1009, 'TRM AE - CAJES, ALEX O.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.968', '2026-07-11 03:32:06.968'),
(1010, 'TRM AE - DINOY JOHN BERT T.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.977', '2026-07-11 03:32:06.977'),
(1011, 'TRM AE - ESCLITO, JUSTINE G.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.986', '2026-07-11 03:32:06.986'),
(1012, 'TRM AE - GAMALO, JOHN G.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:06.995', '2026-07-11 03:32:06.995'),
(1013, 'TRM AE - LABADLABAD, ARNEL O.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.004', '2026-07-11 03:32:07.004'),
(1014, 'TRM AE - LIBA, JAMES IAN M.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.015', '2026-07-11 03:32:07.015'),
(1015, 'TRM AE - LOGAOS, ARGIE G.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.024', '2026-07-11 03:32:07.024'),
(1016, 'TRM AE - LOON, MARK LESTER C.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.040', '2026-07-11 03:32:07.040'),
(1017, 'TRM AE - MAGALE, JAMES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.060', '2026-07-11 03:32:07.060'),
(1018, 'TRM AE - MAGALLEN, NOVA MAE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.070', '2026-07-11 03:32:07.070'),
(1019, 'TRM AE - MATIVO, JUPER G.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.080', '2026-07-11 03:32:07.080'),
(1020, 'TRM AE - MENCIAS, CHRISTIAN', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.089', '2026-07-11 03:32:07.089'),
(1021, 'TRM AE - PEREZ, JOHN CLIFFORD J.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.100', '2026-07-11 03:32:07.100'),
(1022, 'TRM AE - PIGTE, IRENEO', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.109', '2026-07-11 03:32:07.109'),
(1023, 'TRM AE - SALCEDO, MARK BELL M.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.118', '2026-07-11 03:32:07.118'),
(1024, 'TRM AE - SAJUL, BERNALITO', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.127', '2026-07-11 03:32:07.127'),
(1025, 'TRM AE - UCAB, CELSO L.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.146', '2026-07-11 03:32:07.146'),
(1026, 'TRM NESCO - ALBARICO, JAY LORD', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.169', '2026-07-11 03:32:07.169'),
(1027, 'TRM NESCO - AMONCIO, EDRIAN', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.183', '2026-07-11 03:32:07.183'),
(1028, 'TRM NESCO - AÑASCO, JESIELO A.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.193', '2026-07-11 03:32:07.193'),
(1029, 'TRM NESCO - ARNADO, EJ', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.202', '2026-07-11 03:32:07.202'),
(1030, 'TRM NESCO - BAILLO, JYSON A.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.215', '2026-07-11 03:32:07.215'),
(1031, 'TRM NESCO - BARRETE, WINDYL B.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.227', '2026-07-11 03:32:07.227'),
(1032, 'TRM NESCO - BECUNIA, ANTHONY B.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.237', '2026-07-11 03:32:07.237'),
(1033, 'TRM NESCO - CADAY, MC LAWRENCE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.246', '2026-07-11 03:32:07.246'),
(1034, 'TRM NESCO - CERVANTES JAY MARK J.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.254', '2026-07-11 03:32:07.254'),
(1035, 'TRM NESCO - DACULLO, SHER JOHN REY A.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.263', '2026-07-11 03:32:07.263'),
(1036, 'TRM NESCO - DAGONDON, GIERALD P.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.273', '2026-07-11 03:32:07.273'),
(1037, 'TRM NESCO - ERSAN, JONA MAE P.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.283', '2026-07-11 03:32:07.283'),
(1038, 'TRM NESCO - JANSOL, MARK G.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.294', '2026-07-11 03:32:07.294'),
(1039, 'TRM NESCO - LINGATONG, CHRISTIAN IVAN', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.303', '2026-07-11 03:32:07.303'),
(1040, 'TRM NESCO - LOMOCSO, JOEL B.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.315', '2026-07-11 03:32:07.315'),
(1041, 'TRM NESCO - OBISPO, ANNIE CHRIST B.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.323', '2026-07-11 03:32:07.323'),
(1042, 'TRM NESCO - ORBUDA, NADOR JR. P.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.331', '2026-07-11 03:32:07.331'),
(1043, 'TRM NESCO - PACOT, EDRIAN M.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.341', '2026-07-11 03:32:07.341'),
(1044, 'TRM NESCO - PARILLA, JOVEL E.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.349', '2026-07-11 03:32:07.349'),
(1045, 'TRM NESCO - RABAC, ADRIAN CARL E.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.359', '2026-07-11 03:32:07.359'),
(1046, 'TRM NESCO - RAMISO, CRISCELLY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.368', '2026-07-11 03:32:07.368'),
(1047, 'TRM NESCO - RANAS, JUMAEL S.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.377', '2026-07-11 03:32:07.377'),
(1048, 'TRM NESCO - RAVELA, JHON', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.385', '2026-07-11 03:32:07.385'),
(1049, 'TRM NESCO - RONDAEL, ALEXCIS C.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.393', '2026-07-11 03:32:07.393'),
(1050, 'TRM NESCO - RUALES, JOHNLAND G.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.403', '2026-07-11 03:32:07.403'),
(1051, 'TRM NESCO - SUANO, JEFF', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.413', '2026-07-11 03:32:07.413'),
(1052, 'TRM NESCO - TENDENCIA, JADE E.', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.421', '2026-07-11 03:32:07.421'),
(1053, 'TRM NESCO - TONGCO, JUNRAY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.430', '2026-07-11 03:32:07.430'),
(1054, 'INACTIVE 201 FILE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.446', '2026-07-11 03:32:07.446'),
(1055, 'INACTIVE 201 FILE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.462', '2026-07-11 03:32:07.462'),
(1056, 'TRAINING ROADMAP', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.476', '2026-07-11 03:32:07.476'),
(1057, 'INACTIVE 201 FILE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.488', '2026-07-11 03:32:07.488'),
(1058, 'Untitled Imported Hardcopy Row 1060', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.505', '2026-07-11 03:32:07.505'),
(1059, 'R&D ANALYSIS DISPOSAL REPORT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.518', '2026-07-11 03:32:07.518'),
(1060, 'R&D BISCOTTI TRIAL', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.529', '2026-07-11 03:32:07.529'),
(1061, 'R&D EXPIREMENTAL DESIGN', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.537', '2026-07-11 03:32:07.537'),
(1062, 'R&D MEMORANDUM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.546', '2026-07-11 03:32:07.546'),
(1063, 'R&D PACKAGING DEVELOPMENT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.554', '2026-07-11 03:32:07.554'),
(1064, 'PACKAGING MATERIAL COA & MSDS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.564', '2026-07-11 03:32:07.564'),
(1065, 'RAW/PACKAGING MATERIAL RECEIVING REPORT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.574', '2026-07-11 03:32:07.574'),
(1066, 'PACKAGING MATERIAL REVISION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.582', '2026-07-11 03:32:07.582'),
(1067, 'PACKAGING SPECIFICATION SUMMARY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.591', '2026-07-11 03:32:07.591'),
(1068, 'PACKAGING MATERIAL - ACCEPTED', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.599', '2026-07-11 03:32:07.599'),
(1069, 'PACKAGING MATERIAL - NEEDS IMPROVEMENTS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.608', '2026-07-11 03:32:07.608'),
(1070, 'PACKAGING MATERIAL - REJECTED', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.617', '2026-07-11 03:32:07.617'),
(1071, 'RAW MATERIAL - ACCEPTED', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.626', '2026-07-11 03:32:07.626'),
(1072, 'RAW MATERIAL - NEEDS IMPROVEMENTS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.633', '2026-07-11 03:32:07.633'),
(1073, 'RAW MATERIAL - REJECTED', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.641', '2026-07-11 03:32:07.641'),
(1074, 'R&D PROCESS FLOW', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.651', '2026-07-11 03:32:07.651'),
(1075, 'PRODUCT FOR COSTING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.660', '2026-07-11 03:32:07.660'),
(1076, 'R&D PRODUCT INFORMATION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.669', '2026-07-11 03:32:07.669'),
(1077, 'R&D PRODUCT SPECIFICATION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.678', '2026-07-11 03:32:07.678'),
(1078, 'PEANUT KERNESL SPECS & RECEIVING REPORT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.687', '2026-07-11 03:32:07.687'),
(1079, 'R&D RAW MATERIALS EF/ER', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.698', '2026-07-11 03:32:07.698'),
(1080, 'RECIPE SCALERS GUIDE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.706', '2026-07-11 03:32:07.706'),
(1081, 'R&D REQUEST FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.715', '2026-07-11 03:32:07.715'),
(1082, 'R&D YEAR-END REPORT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.724', '2026-07-11 03:32:07.724'),
(1083, 'CC COA SAFETY DATA SHEET 2024-PRESENT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.735', '2026-07-11 03:32:07.735'),
(1084, 'CC CUSTOMER COMPLAINT FEEDBACK FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.747', '2026-07-11 03:32:07.747'),
(1085, 'INCIDENT REPORTS 2024', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.755', '2026-07-11 03:32:07.755'),
(1086, 'BUTTER COOKIES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.767', '2026-07-11 03:32:07.767'),
(1087, 'MAX\'S FROZEN EGGYOLK W/ 5% SUGAR', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.776', '2026-07-11 03:32:07.776'),
(1088, 'ACCEPTED PACKAGING MATERIAL 2012-2018', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.783', '2026-07-11 03:32:07.783'),
(1089, 'ACCEPTED PACKAGING MATERIAL 2019-2023', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.791', '2026-07-11 03:32:07.791'),
(1090, 'NEEDS IMPROVEMENT MATERIAL 2019-2021', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.802', '2026-07-11 03:32:07.802'),
(1091, 'REJECTED PACKAGING MATERIAL 2020-2023', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.812', '2026-07-11 03:32:07.812'),
(1092, 'ACCEPTED RAW MATERIALS 2012-2018', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.822', '2026-07-11 03:32:07.822'),
(1093, 'ACCEPTED RAW MATERIALS 2019-2023', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.831', '2026-07-11 03:32:07.831'),
(1094, 'NEEDS IMPROVEMENT RAW MATERIAL 2019-2023', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.840', '2026-07-11 03:32:07.840'),
(1095, 'NEEDS IMPROVEMENT RAW MATERIAL 2019-2023', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.848', '2026-07-11 03:32:07.848'),
(1096, 'COA SAFETY DATA SHEET (GOLDILOCKS)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.856', '2026-07-11 03:32:07.856'),
(1097, 'PK CPR RENEWAL', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.866', '2026-07-11 03:32:07.866'),
(1098, 'PK PRODUCT REGISTRATION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.878', '2026-07-11 03:32:07.878'),
(1099, 'INCIDENT REPORTS 2015-2018', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.886', '2026-07-11 03:32:07.886');
INSERT INTO `documents` (`document_id`, `document_title`, `document_type`, `status`, `request_date`, `department`, `business_document_type`, `action_requested`, `from_party`, `to_party`, `reason_for_change`, `brief_description`, `proposed_change`, `revision_level_from`, `revision_level_to`, `previous_effective_date`, `new_effective_date`, `date_received`, `date_released`, `approval_date`, `legacy_imported`, `creation_source`, `creation_reason`, `direct_created_at`, `legacy_import_note`, `status_before_disposal`, `requested_by_name`, `disposal_remarks`, `disposal_action`, `disposal_action_other`, `disposed_at`, `disposed_by_name`, `created_by`, `requested_by_user_id`, `disposed_by_user_id`, `reviewed_by_user_id`, `reviewed_at`, `reviewer_remarks`, `workflow_version_id`, `workflow_snapshot`, `workflow_current_node_key`, `source_document_id`, `source_document_updated_at`, `created_at`, `updated_at`) VALUES
(1100, 'INCIDENT REPORTS 2019', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.895', '2026-07-11 03:32:07.895'),
(1101, 'INCIDENT REPORTS 2020-2023', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.907', '2026-07-11 03:32:07.907'),
(1102, 'MATERIAL RECEIVING REPORT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.918', '2026-07-11 03:32:07.918'),
(1103, 'INCIDENT REPORTS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.926', '2026-07-11 03:32:07.926'),
(1104, 'MEMORANDUM 2017-2023', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.934', '2026-07-11 03:32:07.934'),
(1105, 'PHYSICO-CHEM ANALYSIS RESULT TRANSMITTAL', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.942', '2026-07-11 03:32:07.942'),
(1106, 'RMR MONTHLY ANALYSIS REPORT 2016', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.952', '2026-07-11 03:32:07.952'),
(1107, 'RMR QUARTERLY ANALYSIS REPORT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.961', '2026-07-11 03:32:07.961'),
(1108, 'CALIBRATIONS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.971', '2026-07-11 03:32:07.971'),
(1109, 'CERTIFICATE OF ANALYSIS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.979', '2026-07-11 03:32:07.979'),
(1110, 'R&D SHELF LIFE-STUDY DATA', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.987', '2026-07-11 03:32:07.987'),
(1111, 'FS - EXTERNAL SUPPLIER COMPLAINT FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:07.996', '2026-07-11 03:32:07.996'),
(1112, 'FS - INTERNAL SUPPLIER COMPLAINT FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.006', '2026-07-11 03:32:08.006'),
(1113, 'CORRECTIVE AND PREVENTIVE ACTION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.016', '2026-07-11 03:32:08.016'),
(1114, 'MISCONDUCT REPORT (COMAMAO)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.027', '2026-07-11 03:32:08.027'),
(1115, 'MISCONDUCT REPORT (BITAS)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.036', '2026-07-11 03:32:08.036'),
(1116, 'MISCONDUCT REPORT (REQUILLO)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.044', '2026-07-11 03:32:08.044'),
(1117, 'FS&Q SCHEDULE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.051', '2026-07-11 03:32:08.051'),
(1118, 'JOB TRANSFER', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.059', '2026-07-11 03:32:08.059'),
(1119, 'Untitled Imported Hardcopy Row 1121', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.069', '2026-07-11 03:32:08.069'),
(1120, 'PRODUCTION MONITORING BLANK FORMS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.079', '2026-07-11 03:32:08.079'),
(1121, 'CEBU & CAGAYAN CUSTOMER', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.095', '2026-07-11 03:32:08.095'),
(1122, 'PRICE QUOTATION FILES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.105', '2026-07-11 03:32:08.105'),
(1123, 'BUSINESS PROPOSAL', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.116', '2026-07-11 03:32:08.116'),
(1124, 'PEANUT KISSES SHOWROOM/TOUR POLICY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.127', '2026-07-11 03:32:08.127'),
(1125, 'LETTER FOR EDUCATIONAL TOUR', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.140', '2026-07-11 03:32:08.140'),
(1126, 'PEANUT KISSES HISTORY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.149', '2026-07-11 03:32:08.149'),
(1127, 'EXTERNAL & INTERNAL CUSTOMER', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.164', '2026-07-11 03:32:08.164'),
(1128, 'COMPANY PROFILE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.178', '2026-07-11 03:32:08.178'),
(1129, 'GAISANO MALL CAGAYAN', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.187', '2026-07-11 03:32:08.187'),
(1130, 'MSR FOOD PRODUCTS TRADING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.202', '2026-07-11 03:32:08.202'),
(1131, 'SANDUGO TRADE EXPO', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.214', '2026-07-11 03:32:08.214'),
(1132, 'CUSTOMER COMPLAINT FEEDBACK FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.223', '2026-07-11 03:32:08.223'),
(1133, 'CUSTOMER COMPLAINT FEEDBACK FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.234', '2026-07-11 03:32:08.234'),
(1134, 'CHRISTMAS SOLICITATION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.247', '2026-07-11 03:32:08.247'),
(1135, 'PRICING/DISTRIBUTION POLICY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.256', '2026-07-11 03:32:08.256'),
(1136, 'ADVERTISEMENT PROMOTION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.265', '2026-07-11 03:32:08.265'),
(1137, 'PEANUT KISSES TRADE ADVISORY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.274', '2026-07-11 03:32:08.274'),
(1138, 'PRICE ADJUSTMENT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.284', '2026-07-11 03:32:08.284'),
(1139, 'PEANUT KISSES BILLBOARD', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.299', '2026-07-11 03:32:08.299'),
(1140, 'HARD DISCOUNT PHILIPPINES - DALI', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.308', '2026-07-11 03:32:08.308'),
(1141, 'PHILIPPINE AIRLINES MISHANDLING COMPLAINT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.324', '2026-07-11 03:32:08.324'),
(1142, 'CHRISTMAS GIVEAWAYS MONITORING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.335', '2026-07-11 03:32:08.335'),
(1143, 'ICM KIOSK CONTRACT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.362', '2026-07-11 03:32:08.362'),
(1144, 'A\'S FOOD PRODUCTS TRADING (ARSENIA CASTILLO)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.378', '2026-07-11 03:32:08.378'),
(1145, 'TRADE CHANNEL QUOTATIONS - LPB', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.393', '2026-07-11 03:32:08.393'),
(1146, 'TRADE CHANNEL QUOTATIONS - LPA', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.406', '2026-07-11 03:32:08.406'),
(1147, 'CUSTOMER SURVEY FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.414', '2026-07-11 03:32:08.414'),
(1148, 'METRO RETAIL AGREEMENT AND OTHERS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.422', '2026-07-11 03:32:08.422'),
(1149, 'VEHICLE TRACKING MONITORING FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.431', '2026-07-11 03:32:08.431'),
(1150, 'DOCUMENT CONTROL REQUEST FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.441', '2026-07-11 03:32:08.441'),
(1151, 'SECRETARY\'S CERTIFICATE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.448', '2026-07-11 03:32:08.448'),
(1152, 'MAYA FILES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.456', '2026-07-11 03:32:08.456'),
(1153, 'PROPERTY TAXES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.467', '2026-07-11 03:32:08.467'),
(1154, 'MAYORS PERMIT 2022', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.476', '2026-07-11 03:32:08.476'),
(1155, 'EMPLOYEES X-RAY 2023', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.488', '2026-07-11 03:32:08.488'),
(1156, 'MAYORS PERMIT 2023', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.499', '2026-07-11 03:32:08.499'),
(1157, 'MAYORS PERMIT 2024', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.507', '2026-07-11 03:32:08.507'),
(1158, 'MACHINERY TAXES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.515', '2026-07-11 03:32:08.515'),
(1159, 'PAYROLL FILE 2018-2020', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.527', '2026-07-11 03:32:08.527'),
(1160, 'PAYROLL FILE 2021', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.534', '2026-07-11 03:32:08.534'),
(1161, 'PAYROLL FILE 2016-2017', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.543', '2026-07-11 03:32:08.543'),
(1162, 'PAYROLL FILE 2019', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.552', '2026-07-11 03:32:08.552'),
(1163, 'DEDUCTION SUMMARY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.565', '2026-07-11 03:32:08.565'),
(1164, 'PAYROLL SUMMARY AE 2024', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.610', '2026-07-11 03:32:08.610'),
(1165, 'ALTURAS BANK TRANSFER', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.629', '2026-07-11 03:32:08.629'),
(1166, 'CERTIFICATE OF BUSINESS NAME DTI', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.642', '2026-07-11 03:32:08.642'),
(1167, 'BUCAREZ OLD FILE LOT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.653', '2026-07-11 03:32:08.653'),
(1168, 'BUCAREZ L300 OLD FILES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.664', '2026-07-11 03:32:08.664'),
(1169, 'BANK STATEMENT UCPB 2019', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.672', '2026-07-11 03:32:08.672'),
(1170, 'BANK STATEMENT UCPB 2018', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.683', '2026-07-11 03:32:08.683'),
(1171, 'BSNK STATEMNET UCPB 2017', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.695', '2026-07-11 03:32:08.695'),
(1172, 'BANK STATEMENT UCPB 2020', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.703', '2026-07-11 03:32:08.703'),
(1173, 'BANK STATEMNET UCPB 2024', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.715', '2026-07-11 03:32:08.715'),
(1174, 'Untitled Imported Hardcopy Row 1176', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.728', '2026-07-11 03:32:08.728'),
(1175, 'CHECK VOUCHER JANUARY 2024', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.744', '2026-07-11 03:32:08.744'),
(1176, 'CHECK VOUCHER FEBRUARY 2024', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.752', '2026-07-11 03:32:08.752'),
(1177, 'CHECK VOUCHER MARCH 2024', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.761', '2026-07-11 03:32:08.761'),
(1178, 'CHECK VOUCHER APRIL 2024', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.771', '2026-07-11 03:32:08.771'),
(1179, 'CHECK VOUCHER MAY 2024', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.780', '2026-07-11 03:32:08.780'),
(1180, 'CHECK VOUCHER JUNE 2024', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.791', '2026-07-11 03:32:08.791'),
(1181, 'CHECK VOUCHER JULY 2024', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.800', '2026-07-11 03:32:08.800'),
(1182, 'CHECK VOUCHER AUGUST 2024', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.810', '2026-07-11 03:32:08.810'),
(1183, 'CHECK VOUCHER SEPTEMBER 2024', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.819', '2026-07-11 03:32:08.819'),
(1184, 'CHECK VOUCHER OCTOBER 2024', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.829', '2026-07-11 03:32:08.829'),
(1185, 'CHECK VOUCHER JANUARY 2021', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.842', '2026-07-11 03:32:08.842'),
(1186, 'CHECK VOUCHER FEBRUARY 2021', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.852', '2026-07-11 03:32:08.852'),
(1187, 'CHECK VOUCHER MARCH 2021', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.862', '2026-07-11 03:32:08.862'),
(1188, 'CHECK VOUCHER APRIL 2021', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.872', '2026-07-11 03:32:08.872'),
(1189, 'CHECK VOUCHER MAY 2021', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.882', '2026-07-11 03:32:08.882'),
(1190, 'CHECK VOUCHER JANUARY 2022', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.893', '2026-07-11 03:32:08.893'),
(1191, 'CHECK VOUCHER FEBRUARY 2022', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.905', '2026-07-11 03:32:08.905'),
(1192, 'CHECK VOUCHER MARCH 2022', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.915', '2026-07-11 03:32:08.915'),
(1193, 'CHECK VOUCHER APRIL 2022', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.925', '2026-07-11 03:32:08.925'),
(1194, 'CHECK VOUCHER MAY 2022', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.933', '2026-07-11 03:32:08.933'),
(1195, 'CHECK VOUCHER JUNE 2022', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.943', '2026-07-11 03:32:08.943'),
(1196, 'CHECK VOUCHER JULY 2022', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.953', '2026-07-11 03:32:08.953'),
(1197, 'CHECK VOUCHER AUGUST 2022', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.963', '2026-07-11 03:32:08.963'),
(1198, 'CHECK VOUCHER SEPTEMBER 2022', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.971', '2026-07-11 03:32:08.971'),
(1199, 'CHECK VOUCHER DECEMBER 2022', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.981', '2026-07-11 03:32:08.981');
INSERT INTO `documents` (`document_id`, `document_title`, `document_type`, `status`, `request_date`, `department`, `business_document_type`, `action_requested`, `from_party`, `to_party`, `reason_for_change`, `brief_description`, `proposed_change`, `revision_level_from`, `revision_level_to`, `previous_effective_date`, `new_effective_date`, `date_received`, `date_released`, `approval_date`, `legacy_imported`, `creation_source`, `creation_reason`, `direct_created_at`, `legacy_import_note`, `status_before_disposal`, `requested_by_name`, `disposal_remarks`, `disposal_action`, `disposal_action_other`, `disposed_at`, `disposed_by_name`, `created_by`, `requested_by_user_id`, `disposed_by_user_id`, `reviewed_by_user_id`, `reviewed_at`, `reviewer_remarks`, `workflow_version_id`, `workflow_snapshot`, `workflow_current_node_key`, `source_document_id`, `source_document_updated_at`, `created_at`, `updated_at`) VALUES
(1200, 'CHECK VOUCHER JANUARY 2023', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:08.992', '2026-07-11 03:32:08.992'),
(1201, 'CHECK VOUCHER FEBRUARY 2023', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.000', '2026-07-11 03:32:09.000'),
(1202, 'CHECK VOUCHER MARCH 2023', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.014', '2026-07-11 03:32:09.014'),
(1203, 'CHECK VOUCHER APRIL 2023', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.022', '2026-07-11 03:32:09.022'),
(1204, 'CHECK VOUCHER MAY 2023', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.031', '2026-07-11 03:32:09.031'),
(1205, 'CHECK VOUCHER JUNE 2023', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.038', '2026-07-11 03:32:09.038'),
(1206, 'CHECK VOUCHER JULY 2023', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.047', '2026-07-11 03:32:09.047'),
(1207, 'CHGECK VOUCHER AUGUST 2023', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.056', '2026-07-11 03:32:09.056'),
(1208, 'CHECK VOUCHER SEPTEMBER 2023', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.066', '2026-07-11 03:32:09.066'),
(1209, 'CHECK VOUCHER OCTOBER 2023', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.075', '2026-07-11 03:32:09.075'),
(1210, 'CHECK VOUCHER NOVEMBER 2023', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.084', '2026-07-11 03:32:09.084'),
(1211, 'CHECK VOUCHER DECEMBER 2023', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.092', '2026-07-11 03:32:09.092'),
(1212, 'DAILY CASH & RECONCILATION 2023-2024', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.100', '2026-07-11 03:32:09.100'),
(1213, 'PETTY CASH RECONCILATION 2019', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.109', '2026-07-11 03:32:09.109'),
(1214, 'BS COMMISSARY SUGAR NOV-DEC 2022', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.119', '2026-07-11 03:32:09.119'),
(1215, 'BOHOL AGRO MARINE (BAMDECORP)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.127', '2026-07-11 03:32:09.127'),
(1216, 'SBP PRINTERS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.136', '2026-07-11 03:32:09.136'),
(1217, 'PLDT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.143', '2026-07-11 03:32:09.143'),
(1218, 'PETTY CASH RECONCILATION 2024', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.151', '2026-07-11 03:32:09.151'),
(1219, 'NESCO 2019', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.161', '2026-07-11 03:32:09.161'),
(1220, 'ISLA LPG SOLANE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.168', '2026-07-11 03:32:09.168'),
(1221, 'CHECK VOUCHER ORO DRAGON 2022-2024', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.177', '2026-07-11 03:32:09.177'),
(1222, 'ELIXIR JUNE-SEPT 2024', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.185', '2026-07-11 03:32:09.185'),
(1223, 'MARCELA FARMS SUGAR 2021', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.196', '2026-07-11 03:32:09.196'),
(1224, 'MFI POULTRY JANUARY 2022', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.206', '2026-07-11 03:32:09.206'),
(1225, 'NESCO 2022', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.218', '2026-07-11 03:32:09.218'),
(1226, 'ASC MOTORPOOL ISSUEANCE 2023', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.229', '2026-07-11 03:32:09.229'),
(1227, 'ASC CONSTRUCTION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.239', '2026-07-11 03:32:09.239'),
(1228, 'MFI BS COMMISSARY 2021', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.249', '2026-07-11 03:32:09.249'),
(1229, 'MFI POULTRY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.257', '2026-07-11 03:32:09.257'),
(1230, 'MFI POULTRY MARCH-MAY 2023', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.269', '2026-07-11 03:32:09.269'),
(1231, 'MFI BS COMMISSARY SUGAR 2020-2021', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.279', '2026-07-11 03:32:09.279'),
(1232, 'DAILY CASH & RECONCILATION JAN-MARCH 2024', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.289', '2026-07-11 03:32:09.289'),
(1233, 'CV ASSORTED FILES 2018 & 2019', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.302', '2026-07-11 03:32:09.302'),
(1234, 'MFI POULTRY JAN - FEB 2023', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.313', '2026-07-11 03:32:09.313'),
(1235, 'CEBU BSR', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.324', '2026-07-11 03:32:09.324'),
(1236, 'CEBO DEVELOPMENT CORP', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.332', '2026-07-11 03:32:09.332'),
(1237, 'ASC PLANNING & CONSTRUCTION 2024', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.342', '2026-07-11 03:32:09.342'),
(1238, 'D\'GENERAL BOX', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.352', '2026-07-11 03:32:09.352'),
(1239, 'ACCUPLAS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.363', '2026-07-11 03:32:09.363'),
(1240, 'JCG MARKETING GROUP INC. OCT - DEC 2023', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.373', '2026-07-11 03:32:09.373'),
(1241, 'JGY INGREDIENTS 2021-2024', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.387', '2026-07-11 03:32:09.387'),
(1242, 'PAYROLL FILE 2018-2020', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.399', '2026-07-11 03:32:09.399'),
(1243, 'BS COMMISSARY SUGAR 2023', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.410', '2026-07-11 03:32:09.410'),
(1244, 'MFI POULTRY JANUARY 2023', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.424', '2026-07-11 03:32:09.424'),
(1245, 'MFI POULTRY JUNE 1 - AUGUST 15, 2023', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.437', '2026-07-11 03:32:09.437'),
(1246, 'MFI POULTRY OCTOBER 2024', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.451', '2026-07-11 03:32:09.451'),
(1247, 'MFI POULTRY OCTOBER 2022', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.463', '2026-07-11 03:32:09.463'),
(1248, 'MFI POULTRY APRIL-MAY 2024', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.473', '2026-07-11 03:32:09.473'),
(1249, 'MFI POULTRY NOVEMBER 2023 - JULY 2024', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.486', '2026-07-11 03:32:09.486'),
(1250, 'MFI POULTRY NOVEMBER 2021 - AUGUST 2024', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.497', '2026-07-11 03:32:09.497'),
(1251, 'MFI POULTRY OCTOBER - DECEMBER 2021', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.508', '2026-07-11 03:32:09.508'),
(1252, 'MFI POULTRY DECEMBER 2022', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.522', '2026-07-11 03:32:09.522'),
(1253, 'MFI POULTRY JULY - DECEMBER 2021', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.532', '2026-07-11 03:32:09.532'),
(1254, 'MFI POULTRY APRIL 2022', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.543', '2026-07-11 03:32:09.543'),
(1255, 'MFI POULTRY MAY 2022', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.557', '2026-07-11 03:32:09.557'),
(1256, 'BS COMMISSARY SUGAR 2021', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.568', '2026-07-11 03:32:09.568'),
(1257, 'BS COMMISSARY SUGAR 2022', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.582', '2026-07-11 03:32:09.582'),
(1258, 'BS COMMISSARY SUGAR 2023', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.597', '2026-07-11 03:32:09.597'),
(1259, 'MFI POULTRY JUNE 2022', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.609', '2026-07-11 03:32:09.609'),
(1260, 'MFI POULTRY SEPTEMBER 2022', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.617', '2026-07-11 03:32:09.617'),
(1261, 'MFI POULTRY JULY 2022', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.632', '2026-07-11 03:32:09.632'),
(1262, 'MFI POULTRY MARCH 2022', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.644', '2026-07-11 03:32:09.644'),
(1263, 'MFI POULTRY FEBRUARY 2022', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.663', '2026-07-11 03:32:09.663'),
(1264, 'ASC MOTORPOOL 2024', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.675', '2026-07-11 03:32:09.675'),
(1265, 'BS COMMISSARY SUGAR NOV 2023 - MARCH 2024', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.686', '2026-07-11 03:32:09.686'),
(1266, 'Untitled Imported Hardcopy Row 1268', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.702', '2026-07-11 03:32:09.702'),
(1267, 'SSS CONTIBUTION 2016', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.720', '2026-07-11 03:32:09.720'),
(1268, 'PAG-IBIG CONTRIBUTION 2017-2019', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.731', '2026-07-11 03:32:09.731'),
(1269, 'SSS LOAN 2019', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.742', '2026-07-11 03:32:09.742'),
(1270, 'SSS LOAN 2017', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.751', '2026-07-11 03:32:09.751'),
(1271, 'SUMMARY OF PAYMENTS FROM PAYROLL DEPARTMENT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.769', '2026-07-11 03:32:09.769'),
(1272, 'PAG-IBIG LOAN STATEMENT 2018', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.796', '2026-07-11 03:32:09.796'),
(1273, 'PAG-IBIG CONTRIBUTION & LOAN FILE 2020-2021', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.809', '2026-07-11 03:32:09.809'),
(1274, 'SSS CONTRIBUTION & LOAN FILE 2020-2021', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.821', '2026-07-11 03:32:09.821'),
(1275, 'SALARY BILLING STATEMENT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.834', '2026-07-11 03:32:09.834'),
(1276, 'SSS LOAN 2016', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.853', '2026-07-11 03:32:09.853'),
(1277, 'SSS LOAN 2020', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.864', '2026-07-11 03:32:09.864'),
(1278, 'PAG-IBIG CONTRIBUTION 2016', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.877', '2026-07-11 03:32:09.877'),
(1279, 'PHILHEALTH CONTRIBUTION 2020-2021', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.888', '2026-07-11 03:32:09.888'),
(1280, 'PAID SSS, PHILHEALTH, PAG-IBIG LOANS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.904', '2026-07-11 03:32:09.904'),
(1281, 'JOURNAL VOUCHER FS&Q DEPARTMENT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.915', '2026-07-11 03:32:09.915'),
(1282, 'MONTHLY SALES 2022 - PRESENT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.929', '2026-07-11 03:32:09.929'),
(1283, 'MFI SALARY STATEMENT PL SHARE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.938', '2026-07-11 03:32:09.938'),
(1284, 'FILES FOR FILLING & DISPOSAL', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.948', '2026-07-11 03:32:09.948'),
(1285, 'IR 2020', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.959', '2026-07-11 03:32:09.959'),
(1286, 'PK COLLECTION NOT YET POSTED', 'HARDCOPY', 'Disposed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'DCR', NULL, NULL, NULL, 'Approved', NULL, 'Finish Checking', NULL, NULL, '2026-08-11 19:11:03.777', 'Jennifer Ganub', 2, 2, 10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.970', '2026-08-11 19:11:03.784'),
(1287, 'DUE TO FROM STATEMENT/C/O AGC CORPORATE 2014-2018', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.980', '2026-07-11 03:32:09.980'),
(1288, 'MEMO\'S', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:09.988', '2026-07-11 03:32:09.988'),
(1289, 'SSS CONTRIBUTION 2013-2014', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.004', '2026-07-11 03:32:10.004'),
(1290, 'SSS 1998-2000', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.019', '2026-07-11 03:32:10.019'),
(1291, 'SSS LOAN 1994 - 2002', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.029', '2026-07-11 03:32:10.029'),
(1292, 'SSS CONTRIBUTION 2007 - 2012', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.039', '2026-07-11 03:32:10.039'),
(1293, 'E-1 & E-4 FILES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.053', '2026-07-11 03:32:10.053'),
(1294, 'PHILHEALTH 2016', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.060', '2026-07-11 03:32:10.060'),
(1295, 'SSS MATERNITY, REINBURSEMENT & SICKESS FILES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.067', '2026-07-11 03:32:10.067'),
(1296, 'PAG-IBIG LOAN 2016', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.074', '2026-07-11 03:32:10.074'),
(1297, 'PAG-IBIG LOAN 2007-2014', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.082', '2026-07-11 03:32:10.082'),
(1298, 'PAG-IBIG LOAN STATEMENT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.092', '2026-07-11 03:32:10.092'),
(1299, 'PHIC 2003', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.102', '2026-07-11 03:32:10.102');
INSERT INTO `documents` (`document_id`, `document_title`, `document_type`, `status`, `request_date`, `department`, `business_document_type`, `action_requested`, `from_party`, `to_party`, `reason_for_change`, `brief_description`, `proposed_change`, `revision_level_from`, `revision_level_to`, `previous_effective_date`, `new_effective_date`, `date_received`, `date_released`, `approval_date`, `legacy_imported`, `creation_source`, `creation_reason`, `direct_created_at`, `legacy_import_note`, `status_before_disposal`, `requested_by_name`, `disposal_remarks`, `disposal_action`, `disposal_action_other`, `disposed_at`, `disposed_by_name`, `created_by`, `requested_by_user_id`, `disposed_by_user_id`, `reviewed_by_user_id`, `reviewed_at`, `reviewer_remarks`, `workflow_version_id`, `workflow_snapshot`, `workflow_current_node_key`, `source_document_id`, `source_document_updated_at`, `created_at`, `updated_at`) VALUES
(1300, 'SPECIMEN CARD', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.112', '2026-07-11 03:32:10.112'),
(1301, 'SSS LOAN SBR & COLLECTION 2003', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.126', '2026-07-11 03:32:10.126'),
(1302, 'SOA PAG-IBIG', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.135', '2026-07-11 03:32:10.135'),
(1303, 'PHILHEALTH CONTRIBUTION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.146', '2026-07-11 03:32:10.146'),
(1304, 'PAG-IBIG MEMBERS DATA FORM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.158', '2026-07-11 03:32:10.158'),
(1305, 'PHILHEALTH 2007', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.166', '2026-07-11 03:32:10.166'),
(1306, 'SSS LOAN 2013-2014', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.174', '2026-07-11 03:32:10.174'),
(1307, 'PAG-IBIG FORMS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.185', '2026-07-11 03:32:10.185'),
(1308, 'PHIC BLANK FORMS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.195', '2026-07-11 03:32:10.195'),
(1309, 'PAG-IBIG LOAN PAYMENT 2002-2006', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.203', '2026-07-11 03:32:10.203'),
(1310, 'SSS LOAN 2007', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.217', '2026-07-11 03:32:10.217'),
(1311, 'PHILHEALTH CONTRIBUTION 2011-2014', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.225', '2026-07-11 03:32:10.225'),
(1312, 'PHIC M1A, RE2 & MDR FILES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.233', '2026-07-11 03:32:10.233'),
(1313, 'PAG-IBIG CONTRIBUTION 2007', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.243', '2026-07-11 03:32:10.243'),
(1314, 'R-1A FILES PEANUT KISSES EMPLOYEE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.252', '2026-07-11 03:32:10.252'),
(1315, 'PAG-IBIG CONTRIBUTION 2007-2014', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.259', '2026-07-11 03:32:10.259'),
(1316, 'SSS, SBR, R-5 & TRANSMITTAL LIST', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.267', '2026-07-11 03:32:10.267'),
(1317, 'SSS CONTRIBUTION 2015-2016', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.276', '2026-07-11 03:32:10.276'),
(1318, 'SSS CONTRIBUTION 1985-1997', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.284', '2026-07-11 03:32:10.284'),
(1319, 'SSS 1990 - UP MANILA STAFF', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.292', '2026-07-11 03:32:10.292'),
(1320, 'BIR FORM INCOMING NOTICES & LETTER OF AUTHORITY', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.304', '2026-07-11 03:32:10.304'),
(1321, 'BOARD OF RESOLUTION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.314', '2026-07-11 03:32:10.314'),
(1322, 'BQ PROMOTIONAL AGREEMENT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.322', '2026-07-11 03:32:10.322'),
(1323, 'BIR FORM 1601-C WITHHOLDING COMPENSATION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.332', '2026-07-11 03:32:10.332'),
(1324, 'BIR FORM 1604-CF ANNUAL (WITHHOLDING COMPENSATION)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.340', '2026-07-11 03:32:10.340'),
(1325, 'SALES RELIEF', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.348', '2026-07-11 03:32:10.348'),
(1326, 'BIR FORM 1604-E ANNUAL ALPHALIST (PURCHASES)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.360', '2026-07-11 03:32:10.360'),
(1327, 'BIR FORM 0605 - EXAMINATION FEES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.370', '2026-07-11 03:32:10.370'),
(1328, 'SEC DOCUMENTS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.385', '2026-07-11 03:32:10.385'),
(1329, 'DOLE FILES (TIPC)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.396', '2026-07-11 03:32:10.396'),
(1330, 'BIR FORM 1702-Q QUARTERLY INCOME TAX RETURN', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.405', '2026-07-11 03:32:10.405'),
(1331, 'SALES SUMMARY 2020', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.415', '2026-07-11 03:32:10.415'),
(1332, '2307 - PURCHASES 2022', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.426', '2026-07-11 03:32:10.426'),
(1333, 'FIXED ASSETS MONITOR', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.437', '2026-07-11 03:32:10.437'),
(1334, 'AUDITED FS & GIS (BIR)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.448', '2026-07-11 03:32:10.448'),
(1335, 'BIR FORM MONTHLY WITHHOLDING TAX SUMMARY (2307 PURCHASES)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.457', '2026-07-11 03:32:10.457'),
(1336, '2307 PURCHASES 2023-2024', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.467', '2026-07-11 03:32:10.467'),
(1337, 'AUDITED FINANCIAL STATEMENT (ITR)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.477', '2026-07-11 03:32:10.477'),
(1338, 'SEC BY-LAWS & ARTICLES SECRETARY CERTIFICATE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.488', '2026-07-11 03:32:10.488'),
(1339, 'SUPPLIER WITHHOLDING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.500', '2026-07-11 03:32:10.500'),
(1340, 'PURCHASE RELIEF', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.509', '2026-07-11 03:32:10.509'),
(1341, 'SALES 2307 - 2024', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.518', '2026-07-11 03:32:10.518'),
(1342, 'SEMESTRAL LIST OF SUPPLIER', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.531', '2026-07-11 03:32:10.531'),
(1343, 'BIR FORM 2307 CERTIFICATE OF CREDITABLE TAX WITHHOLDING AT SOURCES (SUPPLIER)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.543', '2026-07-11 03:32:10.543'),
(1344, 'BIR FORM 1702-RT ANNUAL INCOME TAX RETURN', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.553', '2026-07-11 03:32:10.553'),
(1345, 'BIR FORM 2020 TAX SUBCRIPTION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.566', '2026-07-11 03:32:10.566'),
(1346, '0605 PAYMENT FORM (CUSTOMER)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.575', '2026-07-11 03:32:10.575'),
(1347, 'BIR FORM 11902 TIN APPLICATION (EE\'S)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.585', '2026-07-11 03:32:10.585'),
(1348, 'BIR FORM 0605 ANNUAL REGISTRATION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.596', '2026-07-11 03:32:10.596'),
(1349, 'BIR FORM 2550-M & 2550-Q MONTHLY & QUARTERLY VAT RETURNS', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.605', '2026-07-11 03:32:10.605'),
(1350, 'BIR FORM 0619-E & 1601 EQ EXPANDED WITTHOLDING (PURCHASES)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.616', '2026-07-11 03:32:10.616'),
(1351, 'LANDBANK MOA', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.626', '2026-07-11 03:32:10.626'),
(1352, 'EMS - MONTHLY PREVENTIVE SCHEDULE HAND & BAND SEALER', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.636', '2026-07-11 03:32:10.636'),
(1353, 'EMPS - EQUIPMENT INFORMATION SHEET', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.645', '2026-07-11 03:32:10.645'),
(1354, 'EMS - FIRE EXTIINGUISHER MONTHLY MONITORING REPORT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.653', '2026-07-11 03:32:10.653'),
(1355, 'EMS - PMS - AIRCONDITIONING UNIT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.662', '2026-07-11 03:32:10.662'),
(1356, 'MONTHLY PREVENTIVE MAINTENANCE PROGRAM FOR MIXER', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.672', '2026-07-11 03:32:10.672'),
(1357, 'EMS - MONTHLY & QUARTERLY PREVENTIVE MAINTENANCE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.682', '2026-07-11 03:32:10.682'),
(1358, 'EMS - MASTER LIST', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.691', '2026-07-11 03:32:10.691'),
(1359, 'PANEL BOARD QUARTERLY MONITORING RECORD', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.700', '2026-07-11 03:32:10.700'),
(1360, 'AIR CONDITIONER PEANUT SELECTION (PS-16.01)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.709', '2026-07-11 03:32:10.709'),
(1361, 'AIR CONDITIONER PRODUCTION OFFICE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.716', '2026-07-11 03:32:10.716'),
(1362, 'AIR CONDITIONER EGG PREPARATION (EP-10.01)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.726', '2026-07-11 03:32:10.726'),
(1363, 'AIR CONDITIONER EGG WASHING (EW-09.01)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.735', '2026-07-11 03:32:10.735'),
(1364, 'AIR CONDITIONER SECONDARY & TERTIARY PACKING (S&TP-08.01)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.744', '2026-07-11 03:32:10.744'),
(1365, 'AIR CONDITIONER SECONDARY & TERTIARY PACKING (S&TP-08.02)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.751', '2026-07-11 03:32:10.751'),
(1366, 'AIR CONDITIONER PRIMARY PACKING (PP-07.01)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.758', '2026-07-11 03:32:10.758'),
(1367, 'AIR CONDITIONER PRIMARY PACKING (PP-07.02)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.767', '2026-07-11 03:32:10.767'),
(1368, 'AIR CONDITIONER PRIMARY PACKING (PP-07.03)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.776', '2026-07-11 03:32:10.776'),
(1369, 'AIR CONDITIONER RELEASING OFFICE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.783', '2026-07-11 03:32:10.783'),
(1370, 'AIR CONDITIONER MINI CONFERENCE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.792', '2026-07-11 03:32:10.792'),
(1371, 'AIR CONDITIONER CONFERENCE ROOM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.800', '2026-07-11 03:32:10.800'),
(1372, 'AIR CONDITIONER DISPLAY ROOM (DR-03.01)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.808', '2026-07-11 03:32:10.808'),
(1373, 'AIR CONDITIONER DISPLAY ROOM (DR-03.02)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.820', '2026-07-11 03:32:10.820'),
(1374, 'AIR CONDITIONER VIEWING DECK (VD-02.01)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.828', '2026-07-11 03:32:10.828'),
(1375, 'AIR CONDITIONER VIEWING DECK (VD-02.02)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.837', '2026-07-11 03:32:10.837'),
(1376, 'AIR CONDITIONER ADMIN OFFICE (AO-01.01)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.845', '2026-07-11 03:32:10.845'),
(1377, 'AIR CONDITIONER ADMIN OFFICE (AO-01.02)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.852', '2026-07-11 03:32:10.852'),
(1378, 'AUTOMATIC CONTINUOUS SEALER (PP.07.04)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.863', '2026-07-11 03:32:10.863'),
(1379, 'POWDER LOADER SYSTEM', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.875', '2026-07-11 03:32:10.875'),
(1380, 'PEANUT ROASTER LINE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.883', '2026-07-11 03:32:10.883'),
(1381, 'PLANETARY MIXER (SR-13.01)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.891', '2026-07-11 03:32:10.891'),
(1382, 'PLANETARY MIXER (SR-13.02)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.899', '2026-07-11 03:32:10.899'),
(1383, 'PLANETARY MIXER (SR-13.03)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.909', '2026-07-11 03:32:10.909'),
(1384, 'PLANETARY MIXER (SR-13.04)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.917', '2026-07-11 03:32:10.917'),
(1385, 'PLANETARY MIXER (SR-13.05)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.926', '2026-07-11 03:32:10.926'),
(1386, 'COLD AND HOT WATER UNIT', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.939', '2026-07-11 03:32:10.939'),
(1387, 'CIP PUMP', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.955', '2026-07-11 03:32:10.955'),
(1388, 'AERATOR', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.964', '2026-07-11 03:32:10.964'),
(1389, 'FEED PUMP', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.973', '2026-07-11 03:32:10.973'),
(1390, 'BUFFER TANK', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.984', '2026-07-11 03:32:10.984'),
(1391, 'LOBE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:10.993', '2026-07-11 03:32:10.993'),
(1392, 'PREMIXING TANK', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.003', '2026-07-11 03:32:11.003'),
(1393, 'DEPANNER', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.030', '2026-07-11 03:32:11.030'),
(1394, 'CONVEYOR LINE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.038', '2026-07-11 03:32:11.038'),
(1395, 'AUTOMATIC OIL GREASER', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.048', '2026-07-11 03:32:11.048'),
(1396, 'STACKING TOWER', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.061', '2026-07-11 03:32:11.061'),
(1397, 'COOLING TOWER 1', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.076', '2026-07-11 03:32:11.076'),
(1398, 'COOLING TOWER 2', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.084', '2026-07-11 03:32:11.084');
INSERT INTO `documents` (`document_id`, `document_title`, `document_type`, `status`, `request_date`, `department`, `business_document_type`, `action_requested`, `from_party`, `to_party`, `reason_for_change`, `brief_description`, `proposed_change`, `revision_level_from`, `revision_level_to`, `previous_effective_date`, `new_effective_date`, `date_received`, `date_released`, `approval_date`, `legacy_imported`, `creation_source`, `creation_reason`, `direct_created_at`, `legacy_import_note`, `status_before_disposal`, `requested_by_name`, `disposal_remarks`, `disposal_action`, `disposal_action_other`, `disposed_at`, `disposed_by_name`, `created_by`, `requested_by_user_id`, `disposed_by_user_id`, `reviewed_by_user_id`, `reviewed_at`, `reviewer_remarks`, `workflow_version_id`, `workflow_snapshot`, `workflow_current_node_key`, `source_document_id`, `source_document_updated_at`, `created_at`, `updated_at`) VALUES
(1399, 'GAS TUNNEL OVEN', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.094', '2026-07-11 03:32:11.094'),
(1400, 'LOADING TOWER', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.103', '2026-07-11 03:32:11.103'),
(1401, 'DIGITAL WEIGHING SCALE (RA-15)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.113', '2026-07-11 03:32:11.113'),
(1402, 'DIGITAL WEIGHING SCALE (SR-13)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.121', '2026-07-11 03:32:11.121'),
(1403, 'DIGITAL WEIGHING SCALE ((MR-12.01)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.131', '2026-07-11 03:32:11.131'),
(1404, 'DIGITAL WEIGHING SCALE (MR-12.02)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.141', '2026-07-11 03:32:11.141'),
(1405, 'DIGITAL WEIGHING SCALE (EP-10.02)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.150', '2026-07-11 03:32:11.150'),
(1406, 'DIGITAL WEIGHING SCALE (PP-07.05)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.160', '2026-07-11 03:32:11.160'),
(1407, 'DIGITAL WEIGHING SCALE (PP-07.06)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.170', '2026-07-11 03:32:11.170'),
(1408, 'DIGITAL WEIGHING SCALE (PP-07.04)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.182', '2026-07-11 03:32:11.182'),
(1409, 'AIR CONDITIONER CONDENSER (OD-19)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.204', '2026-07-11 03:32:11.204'),
(1410, 'AIR CONDITIONER CONDENSER (RT-18.01)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.216', '2026-07-11 03:32:11.216'),
(1411, 'AIR CONDITIONER CONDENSER (RT-18.02)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.226', '2026-07-11 03:32:11.226'),
(1412, 'AIR CONDITIONER CONDENSER (RT-18.03)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.236', '2026-07-11 03:32:11.236'),
(1413, 'AIR CONDITIONER CONDENSER (RT-18.04)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.246', '2026-07-11 03:32:11.246'),
(1414, 'AIR CONDITIONER CONDENSER (RT-18.05)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.259', '2026-07-11 03:32:11.259'),
(1415, 'AIR CONDITIONER CONDENSER (RT-18.06)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.268', '2026-07-11 03:32:11.268'),
(1416, 'AIR CONDITIONER CONDENSER (RT-18.07)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.281', '2026-07-11 03:32:11.281'),
(1417, 'AIR CONDITIONER CONDENSER (RT-18.08)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.291', '2026-07-11 03:32:11.291'),
(1418, 'AIR CONDITIONER CONDENSER (OD-19.01)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.301', '2026-07-11 03:32:11.301'),
(1419, 'AIR CONDITIONER CONDENSER (OD-19.02)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.315', '2026-07-11 03:32:11.315'),
(1420, 'AIR CONDITIONER CONDENSER (OD-19.03)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.327', '2026-07-11 03:32:11.327'),
(1421, 'AIR CONDITIONER CONDENSER (OD-19.04)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.340', '2026-07-11 03:32:11.340'),
(1422, 'AIR CONDITIONER CONDENSER (OD-19.05)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.354', '2026-07-11 03:32:11.354'),
(1423, 'AIR CONDITIONER CONDENSER (OD-19.06)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.372', '2026-07-11 03:32:11.372'),
(1424, 'AIR CONDITIONER CONDENSER (OD-19.07)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.385', '2026-07-11 03:32:11.385'),
(1425, 'AIR CONDITIONER CONDENSER (OD-19.08)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.407', '2026-07-11 03:32:11.407'),
(1426, 'AIR CONDITIONER CONDENSER (OD-19.09)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.419', '2026-07-11 03:32:11.419'),
(1427, 'HAND SEALER (PP-07.19)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.436', '2026-07-11 03:32:11.436'),
(1428, 'HAND SEALER (PP-07.18)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.455', '2026-07-11 03:32:11.455'),
(1429, 'WATER PURIFIER (PH-21.01)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.468', '2026-07-11 03:32:11.468'),
(1430, 'WATER PURIFIER (OA-11.14)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.485', '2026-07-11 03:32:11.485'),
(1431, 'INDUSTRIAL FAN (PS-16.02)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.494', '2026-07-11 03:32:11.494'),
(1432, 'INDUSTRIAL FAN (OA-11.13)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.513', '2026-07-11 03:32:11.513'),
(1433, 'INDUSTRIAL FAN (OA-11.12)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.521', '2026-07-11 03:32:11.521'),
(1434, 'INDUSTRIAL FAN (OA-11.11)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.542', '2026-07-11 03:32:11.542'),
(1435, 'INDUSTRIAL FAN (OA-11.10)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.560', '2026-07-11 03:32:11.560'),
(1436, 'WALL FAN (OA-11.09)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.570', '2026-07-11 03:32:11.570'),
(1437, 'SIFTER', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.587', '2026-07-11 03:32:11.587'),
(1438, 'PEANUT GRINDER', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.599', '2026-07-11 03:32:11.599'),
(1439, 'ROASTER', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.615', '2026-07-11 03:32:11.615'),
(1440, 'PEANUT SELECTOR', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.627', '2026-07-11 03:32:11.627'),
(1441, 'DIGITAL WEIGHING SCALE', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.638', '2026-07-11 03:32:11.638'),
(1442, 'AIR CONDITIONER MAINTENANCE OFFIC', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.657', '2026-07-11 03:32:11.657'),
(1443, 'AIR CONDITIONER CONDENSER (OD-19.13)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.669', '2026-07-11 03:32:11.669'),
(1444, 'AIR CONDITIONER CONDENSER (OD-19.12)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.687', '2026-07-11 03:32:11.687'),
(1445, 'AIR CONDITIONER CONDENSER (OD-19.11)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.701', '2026-07-11 03:32:11.701'),
(1446, 'AIR CONDITIONER EGG PREPARATION (EP-10.05)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.711', '2026-07-11 03:32:11.711'),
(1447, 'INK JET (PP-07.17)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.726', '2026-07-11 03:32:11.726'),
(1448, 'CONTINUOUS BAND SEALER (PP-07.16)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.737', '2026-07-11 03:32:11.737'),
(1449, 'CONTINUOUS BAND SEALER', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.754', '2026-07-11 03:32:11.754'),
(1450, 'FOOT SEALER (PP-07.14)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.766', '2026-07-11 03:32:11.766'),
(1451, 'FLOOR MOUNTED AIR CONDITIONER PRIMARY PACKING (PP-07.13)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.775', '2026-07-11 03:32:11.775'),
(1452, 'FLOOR MOUNTED AIR CONDITIONER PRIMARY PACKING (PP-07.12)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.791', '2026-07-11 03:32:11.791'),
(1453, 'FLOOR MOUNTED AIR CONDITIONER FORMING AREA (FA-08.03)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.801', '2026-07-11 03:32:11.801'),
(1454, 'FREEZER', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.809', '2026-07-11 03:32:11.809'),
(1455, 'CHILLER (EP-10.03)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.821', '2026-07-11 03:32:11.821'),
(1456, 'CHILLER (EP-10.04)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.831', '2026-07-11 03:32:11.831'),
(1457, 'AIR DRYER (BA-17.05)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.840', '2026-07-11 03:32:11.840'),
(1458, 'AIR DRYER (BA-17.04)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.849', '2026-07-11 03:32:11.849'),
(1459, 'AIR COMPRESSOR (BA-17.03)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.859', '2026-07-11 03:32:11.859'),
(1460, 'AIR COMPRESSOR (BA-17.02)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.867', '2026-07-11 03:32:11.867'),
(1461, 'AIR COMPRESSOR (BA-17.01)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.876', '2026-07-11 03:32:11.876'),
(1462, 'HOT STAMP PRINTER (PP-07.10)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.884', '2026-07-11 03:32:11.884'),
(1463, 'HOT STAMP PRINTER (PP-07.11)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.892', '2026-07-11 03:32:11.892'),
(1464, 'AUTOMATIC CONTINUOUS SEALER (PP-07.08)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.901', '2026-07-11 03:32:11.901'),
(1465, 'AUTOMATIC CONTINUOUS SEALER (PP-07.09)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.908', '2026-07-11 03:32:11.908'),
(1466, 'AUTOMATIC CONTINUOUS SEALER (PP-07.07)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.918', '2026-07-11 03:32:11.918'),
(1467, 'AUTOMATIC CONTINUOUS SEALER (PP-07.06)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.927', '2026-07-11 03:32:11.927'),
(1468, 'AUTOMATIC CONTINUOUS SEALER (PP-07.05)', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-11 03:32:11.935', '2026-07-11 03:32:11.935'),
(1469, 'PATENT FILES', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-17 03:35:59.482', '2026-07-17 07:06:01.048'),
(1470, 'TRADEMARK APPLICATION', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-07-17 07:06:30.801', '2026-07-17 07:06:42.417'),
(1471, 'FIRE PRO VALVE MAINTENACE CHECKLIST', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 17, 17, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-08-22 08:03:32.940', '2026-08-22 08:10:18.136'),
(1472, 'TRANSFORMER MONITORING', 'HARDCOPY', 'Completed', '2026-08-29 02:42:15.693', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-03 02:52:23.262', NULL, 1, 'DCR', NULL, NULL, 'Legacy / Imported Approved: preserved from pre-workflow data; no new approval history was created.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 17, 17, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-08-22 08:07:30.169', '2026-08-22 08:10:15.442'),
(1473, 'PPM', 'SOFTCOPY', 'Completed', '2026-09-08 06:55:49.669', 'Admin', 'Monitoring', 'CREATE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-08 06:55:49.669', '2026-09-09 02:51:41.304', '2026-09-08 08:30:38.387', 0, 'DCR', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 9, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-08 06:55:49.676', '2026-09-09 02:51:41.315'),
(1474, 'SAMPLE TITLE', 'SOFTCOPY', 'Completed', '2026-09-14 08:04:05.783', 'Sample-Department', 'Forms', 'CREATE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-14 08:04:05.784', '2026-09-14 08:11:47.892', '2026-09-14 08:08:21.160', 0, 'DCR', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 18, 18, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-14 08:04:05.786', '2026-09-14 08:11:47.898'),
(1475, 'WAREHOUSE RECORDS STOCK RELEASING FORM UNCONTROLLED', 'SOFTCOPY', 'Completed', '2026-09-16 05:31:08.709', 'Sample-Department', 'Manual', 'CREATE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-16 05:31:09.043', '2026-09-16 08:36:45.764', '2026-09-16 08:36:10.337', 0, 'DCR', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 18, 18, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-16 05:31:08.715', '2026-09-16 08:36:45.770'),
(1476, 'QQQQ', 'HARDCOPY', 'ForRevision', '2026-09-17 00:16:28.726', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'DCR', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 16, 16, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-17 00:16:28.735', '2026-09-19 00:45:11.657'),
(1477, 'WAREHOUSE RECORDS STOCK RELEASING FORM CONTROLLED', 'SOFTCOPY', 'ForNotedBy', '2026-09-17 02:05:59.510', 'sssss', NULL, 'CREATE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-17 02:06:00.045', NULL, NULL, 0, 'DCR', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 18, 18, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-17 02:05:59.520', '2026-09-17 02:06:00.054'),
(1478, 'WAREHOUSE RECORDS STOCK RELEASING FORM UNCONTROLLED', 'SOFTCOPY', 'ForNotedBy', '2026-09-17 04:59:54.483', 'EEEE', 'Forms', 'CREATE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-17 04:59:54.921', NULL, NULL, 0, 'DCR', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 18, 18, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-17 04:59:54.490', '2026-09-17 04:59:54.926'),
(1479, 'GFFG', 'HARDCOPY', 'Rejected', '2026-09-19 00:46:04.025', NULL, NULL, 'CREATE_REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'DCR', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 17, 17, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-19 00:46:04.027', '2026-10-05 02:11:38.705'),
(1480, 'UNTITLED IMPORTED HARDCOPY ROW 376 SAMPLE ONLY', 'HARDCOPY', 'Rejected', '2026-09-19 05:57:15.004', NULL, NULL, 'REVISE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 'DCR', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-19 05:57:15.005', '2026-09-19 05:58:08.263');

-- --------------------------------------------------------

--
-- Table structure for table `document_access_requests`
--

CREATE TABLE `document_access_requests` (
  `access_request_id` bigint(20) NOT NULL,
  `document_id` bigint(20) NOT NULL,
  `requested_by_user_id` bigint(20) NOT NULL,
  `request_reason` text DEFAULT NULL,
  `status` enum('PENDING','ForAccessApproval','APPROVED','AccessGranted','RETURNED','REJECTED','CANCELLED','REVOKED','EXPIRED') NOT NULL DEFAULT 'PENDING',
  `reviewed_by_user_id` bigint(20) DEFAULT NULL,
  `approver_user_id` bigint(20) DEFAULT NULL,
  `reviewer_remarks` text DEFAULT NULL,
  `reviewed_at` datetime(3) DEFAULT NULL,
  `approval_stage` varchar(60) DEFAULT NULL,
  `granted_at` datetime(3) DEFAULT NULL,
  `revoked_at` datetime(3) DEFAULT NULL,
  `expires_at` datetime(3) DEFAULT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updated_at` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `document_access_request_history`
--

CREATE TABLE `document_access_request_history` (
  `access_history_id` bigint(20) NOT NULL,
  `access_request_id` bigint(20) NOT NULL,
  `action` varchar(40) NOT NULL,
  `previous_status` enum('PENDING','ForAccessApproval','APPROVED','AccessGranted','RETURNED','REJECTED','CANCELLED','REVOKED','EXPIRED') DEFAULT NULL,
  `new_status` enum('PENDING','ForAccessApproval','APPROVED','AccessGranted','RETURNED','REJECTED','CANCELLED','REVOKED','EXPIRED') NOT NULL,
  `performed_by_user_id` bigint(20) NOT NULL,
  `comments` text DEFAULT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `document_approver_configurations`
--

CREATE TABLE `document_approver_configurations` (
  `approver_configuration_id` bigint(20) NOT NULL,
  `document_id` bigint(20) NOT NULL,
  `noted_by_user_id` bigint(20) DEFAULT NULL,
  `plant_manager_user_id` bigint(20) DEFAULT NULL,
  `document_controller_user_id` bigint(20) DEFAULT NULL,
  `hardcopy_approver_user_id` bigint(20) DEFAULT NULL,
  `access_approver_user_id` bigint(20) DEFAULT NULL,
  `document_owner_user_id` bigint(20) DEFAULT NULL,
  `workflow_name` varchar(150) DEFAULT NULL,
  `workflow_version` int(11) NOT NULL DEFAULT 1,
  `workflow_plan` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`workflow_plan`)),
  `configured_by_user_id` bigint(20) NOT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updated_at` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `document_assignments`
--

CREATE TABLE `document_assignments` (
  `document_assignment_id` bigint(20) NOT NULL,
  `document_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `assigned_by` bigint(20) NOT NULL,
  `assigned_at` datetime(3) NOT NULL DEFAULT current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `document_disposal_requests`
--

CREATE TABLE `document_disposal_requests` (
  `disposal_request_id` bigint(20) NOT NULL,
  `document_id` bigint(20) NOT NULL,
  `requested_by_user_id` bigint(20) NOT NULL,
  `disposal_remarks` text NOT NULL,
  `disposal_action` enum('Shred','Scratch','Reuse','Other') NOT NULL DEFAULT 'Other',
  `disposal_action_other` varchar(150) DEFAULT NULL,
  `status` enum('Pending','Approved','Rejected') NOT NULL DEFAULT 'Pending',
  `reviewed_by_user_id` bigint(20) DEFAULT NULL,
  `reviewer_remarks` text DEFAULT NULL,
  `reviewed_at` datetime(3) DEFAULT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updated_at` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `document_revisions`
--

CREATE TABLE `document_revisions` (
  `revision_id` bigint(20) NOT NULL,
  `softcopy_id` bigint(20) NOT NULL,
  `revision_number` varchar(50) NOT NULL,
  `reason_of_revision` text DEFAULT NULL,
  `effective_date` datetime(3) DEFAULT NULL,
  `page_number` varchar(50) DEFAULT NULL,
  `series_number` varchar(50) DEFAULT NULL,
  `document_title` varchar(255) NOT NULL DEFAULT '',
  `revision_level_from` varchar(50) DEFAULT NULL,
  `revision_level_to` varchar(50) DEFAULT NULL,
  `previous_effective_date` datetime(3) DEFAULT NULL,
  `new_effective_date` datetime(3) DEFAULT NULL,
  `date_received` datetime(3) DEFAULT NULL,
  `date_released` datetime(3) DEFAULT NULL,
  `approval_date` datetime(3) DEFAULT NULL,
  `is_current` tinyint(1) NOT NULL DEFAULT 0,
  `is_historical` tinyint(1) NOT NULL DEFAULT 0,
  `approved_by_user_id` bigint(20) DEFAULT NULL,
  `approved_at` datetime(3) DEFAULT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_path` varchar(500) NOT NULL,
  `file_size` bigint(20) DEFAULT NULL,
  `mime_type` varchar(100) DEFAULT NULL,
  `superseded_by_revision_id` bigint(20) DEFAULT NULL,
  `correction_reason` text DEFAULT NULL,
  `uploaded_by` bigint(20) NOT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `document_revisions`
--

INSERT INTO `document_revisions` (`revision_id`, `softcopy_id`, `revision_number`, `reason_of_revision`, `effective_date`, `page_number`, `series_number`, `document_title`, `revision_level_from`, `revision_level_to`, `previous_effective_date`, `new_effective_date`, `date_received`, `date_released`, `approval_date`, `is_current`, `is_historical`, `approved_by_user_id`, `approved_at`, `file_name`, `file_path`, `file_size`, `mime_type`, `superseded_by_revision_id`, `correction_reason`, `uploaded_by`, `created_at`) VALUES
(1, 1, '1', '1', '2026-09-09 00:00:00.000', '1', '001', 'PPM', NULL, NULL, NULL, NULL, '2026-09-08 06:55:49.669', NULL, '2026-09-09 02:51:41.304', 1, 0, 2, '2026-09-09 02:51:41.304', 'Warehouse Records - stock Releasing Form.xlsx', '/app/uploads/revisions/uncategorized/1788922300915-f3d2497d-6147-404d-b973-506871256cb5-Warehouse-Records-stock-Releasing-Form.xlsx', 73985, 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', NULL, NULL, 2, '2026-09-09 02:51:41.213'),
(2, 2, '000', NULL, '2026-09-16 00:00:00.000', '55', '112', 'SAMPLE TITLE', NULL, NULL, NULL, NULL, '2026-09-14 08:04:05.784', NULL, '2026-09-14 08:11:47.892', 1, 0, 18, '2026-09-14 08:11:47.892', 'Warehouse Records - stock Releasing Form-uncontrolled.xlsx', '/app/uploads/revisions/uncategorized/1789373507794-7102544d-48ea-4b9a-ac92-8e2118f959dc-Warehouse-Records-stock-Releasing-Form-uncontrolled.xlsx', 588, 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', NULL, NULL, 18, '2026-09-14 08:11:47.869'),
(3, 3, '000', NULL, '2026-09-16 08:36:10.356', '66', '1125', 'WAREHOUSE RECORDS STOCK RELEASING FORM UNCONTROLLED', NULL, NULL, NULL, NULL, '2026-09-16 05:31:09.043', '2026-09-16 08:36:45.764', '2026-09-16 08:36:10.356', 1, 0, 8, '2026-09-16 08:36:10.356', 'Warehouse Records - stock Releasing Form-uncontrolled.xlsx', '/app/uploads/revisions/uncategorized/1789536668855-93c84dc7-3064-4ade-a400-2477db121dd2-Warehouse-Records-stock-Releasing-Form-uncontrolled.xlsx', 588, 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', NULL, NULL, 18, '2026-09-16 05:31:08.914'),
(4, 4, '000', NULL, NULL, 'ss', 'sss', 'WAREHOUSE RECORDS STOCK RELEASING FORM CONTROLLED', NULL, NULL, NULL, NULL, '2026-09-17 02:06:00.045', NULL, NULL, 0, 0, NULL, NULL, 'Warehouse Records - stock Releasing Form-controlled.xlsx', '/app/uploads/revisions/uncategorized/1789610759749-897fa61a-4238-41f3-8074-71cb2443dc61-Warehouse-Records-stock-Releasing-Form-controlled.xlsx', 581, 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', NULL, NULL, 18, '2026-09-17 02:05:59.869'),
(5, 5, '000', NULL, NULL, 'EE', 'EE', 'WAREHOUSE RECORDS STOCK RELEASING FORM UNCONTROLLED', NULL, NULL, NULL, NULL, '2026-09-17 04:59:54.921', NULL, NULL, 0, 0, NULL, NULL, 'Warehouse Records - stock Releasing Form-uncontrolled.xlsx', '/app/uploads/revisions/uncategorized/1789621194674-3e1fb3cb-6eae-4049-9a2e-d79ca33e8070-Warehouse-Records-stock-Releasing-Form-uncontrolled.xlsx', 588, 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', NULL, NULL, 18, '2026-09-17 04:59:54.776');

-- --------------------------------------------------------

--
-- Table structure for table `document_status_history`
--

CREATE TABLE `document_status_history` (
  `history_id` bigint(20) NOT NULL,
  `document_id` bigint(20) NOT NULL,
  `previous_status` enum('Draft','PendingApproval','ForNotedBy','ForPlantManagerApproval','ForDocumentControllerAdmin','ForApproval','ForTransfer','Transferred','PendingRecipientAcceptance','Approved','Completed','ReturnedForCorrection','Cancelled','Rejected','ForRevision','Disposed') DEFAULT NULL,
  `new_status` enum('Draft','PendingApproval','ForNotedBy','ForPlantManagerApproval','ForDocumentControllerAdmin','ForApproval','ForTransfer','Transferred','PendingRecipientAcceptance','Approved','Completed','ReturnedForCorrection','Cancelled','Rejected','ForRevision','Disposed') NOT NULL,
  `action` varchar(50) NOT NULL,
  `performed_by` bigint(20) NOT NULL,
  `remarks` text DEFAULT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `document_workflow_assignment_history`
--

CREATE TABLE `document_workflow_assignment_history` (
  `assignment_history_id` bigint(20) NOT NULL,
  `workflow_step_id` bigint(20) NOT NULL,
  `previous_user_id` bigint(20) DEFAULT NULL,
  `new_user_id` bigint(20) NOT NULL,
  `changed_by_user_id` bigint(20) NOT NULL,
  `previous_user_name` varchar(255) DEFAULT NULL,
  `new_user_name` varchar(255) NOT NULL,
  `new_position_title` varchar(150) DEFAULT NULL,
  `reason` text NOT NULL,
  `changed_at` datetime(3) NOT NULL DEFAULT current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `document_workflow_steps`
--

CREATE TABLE `document_workflow_steps` (
  `workflow_step_id` bigint(20) NOT NULL,
  `document_id` bigint(20) NOT NULL,
  `stage` enum('DRAFT','NOTED_BY','PLANT_MANAGER','DOCUMENT_CONTROLLER_ADMIN','HARDCOPY_APPROVAL','COMPLETED','CUSTOM') NOT NULL,
  `node_key` varchar(100) DEFAULT NULL,
  `sequence` int(11) NOT NULL,
  `assigned_user_id` bigint(20) DEFAULT NULL,
  `stage_label` varchar(150) DEFAULT NULL,
  `assignment_source` varchar(50) DEFAULT NULL,
  `assignment_type` varchar(30) DEFAULT NULL,
  `assigned_role_id` bigint(20) DEFAULT NULL,
  `required_permission` varchar(120) DEFAULT NULL,
  `condition_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`condition_json`)),
  `on_approve_node_key` varchar(100) DEFAULT NULL,
  `on_reject_node_key` varchar(100) DEFAULT NULL,
  `on_return_node_key` varchar(100) DEFAULT NULL,
  `assigned_user_name_snapshot` varchar(255) DEFAULT NULL,
  `assigned_position_title_snapshot` varchar(150) DEFAULT NULL,
  `assigned_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `status` enum('QUEUED','PENDING','APPROVED','RETURNED','REJECTED','CANCELLED') NOT NULL DEFAULT 'PENDING',
  `acted_by_user_id` bigint(20) DEFAULT NULL,
  `decision` varchar(30) DEFAULT NULL,
  `comments` text DEFAULT NULL,
  `acted_at` datetime(3) DEFAULT NULL,
  `acted_user_name_snapshot` varchar(255) DEFAULT NULL,
  `acted_position_title_snapshot` varchar(150) DEFAULT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hardcopy_attachments`
--

CREATE TABLE `hardcopy_attachments` (
  `attachment_id` bigint(20) NOT NULL,
  `hardcopy_id` bigint(20) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_path` varchar(500) NOT NULL,
  `file_size` bigint(20) DEFAULT NULL,
  `mime_type` varchar(100) DEFAULT NULL,
  `uploaded_by` bigint(20) NOT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hardcopy_documents`
--

CREATE TABLE `hardcopy_documents` (
  `hardcopy_id` bigint(20) NOT NULL,
  `document_id` bigint(20) NOT NULL,
  `asset_id` bigint(20) DEFAULT NULL,
  `area_id` bigint(20) NOT NULL,
  `specific_id` bigint(20) DEFAULT NULL,
  `location_id` bigint(20) NOT NULL,
  `sequence_id` bigint(20) DEFAULT NULL,
  `retention_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `retention_start_date` datetime(3) DEFAULT NULL,
  `retention_end_date` datetime(3) DEFAULT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hardcopy_documents`
--

INSERT INTO `hardcopy_documents` (`hardcopy_id`, `document_id`, `asset_id`, `area_id`, `specific_id`, `location_id`, `sequence_id`, `retention_enabled`, `retention_start_date`, `retention_end_date`, `created_at`) VALUES
(1, 1, 1, 1, 1, 9, 1, 0, NULL, NULL, '2026-07-11 03:31:54.647'),
(2, 2, 1, 1, 1, 9, 2, 0, NULL, NULL, '2026-07-11 03:31:54.712'),
(3, 3, 1, 1, 1, 9, 3, 0, NULL, NULL, '2026-07-11 03:31:54.723'),
(4, 4, 1, 1, 1, 9, 4, 0, NULL, NULL, '2026-07-11 03:31:54.733'),
(5, 5, 1, 1, 1, 9, 5, 0, NULL, NULL, '2026-07-11 03:31:54.746'),
(6, 6, 1, 1, 1, 9, 6, 0, NULL, NULL, '2026-07-11 03:31:54.757'),
(7, 7, 1, 1, 1, 9, 7, 0, NULL, NULL, '2026-07-11 03:31:54.768'),
(8, 8, 1, 1, 1, 9, 8, 0, NULL, NULL, '2026-07-11 03:31:54.780'),
(9, 9, 1, 1, 1, 9, 9, 0, NULL, NULL, '2026-07-11 03:31:54.790'),
(10, 10, 1, 1, 1, 9, 10, 0, NULL, NULL, '2026-07-11 03:31:54.803'),
(11, 11, 1, 1, 1, 9, NULL, 0, NULL, NULL, '2026-07-11 03:31:54.811'),
(12, 12, 1, 1, 1, 9, NULL, 0, NULL, NULL, '2026-07-11 03:31:54.821'),
(13, 13, 1, 1, 1, 9, NULL, 0, NULL, NULL, '2026-07-11 03:31:54.829'),
(14, 14, 1, 1, 1, 9, 11, 0, NULL, NULL, '2026-07-11 03:31:54.836'),
(15, 15, 1, 1, 1, 9, 12, 0, NULL, NULL, '2026-07-11 03:31:54.846'),
(16, 16, 1, 1, 1, 9, 13, 0, NULL, NULL, '2026-07-11 03:31:54.861'),
(17, 17, 1, 1, 1, 9, 14, 0, NULL, NULL, '2026-07-11 03:31:54.871'),
(18, 18, 1, 1, 1, 9, 15, 0, NULL, NULL, '2026-07-11 03:31:54.880'),
(19, 19, 1, 1, 1, 9, 16, 0, NULL, NULL, '2026-07-11 03:31:54.889'),
(20, 20, 1, 1, 1, 9, 17, 0, NULL, NULL, '2026-07-11 03:31:54.898'),
(21, 21, 1, 1, 1, 9, 18, 0, NULL, NULL, '2026-07-11 03:31:54.907'),
(22, 22, 1, 1, 1, 9, 19, 0, NULL, NULL, '2026-07-11 03:31:54.918'),
(23, 23, 1, 1, 1, 9, 20, 0, NULL, NULL, '2026-07-11 03:31:54.930'),
(24, 24, 1, 1, 1, 10, 21, 0, NULL, NULL, '2026-07-11 03:31:54.942'),
(25, 25, 1, 1, 1, 10, 22, 0, NULL, NULL, '2026-07-11 03:31:54.953'),
(26, 26, 1, 1, 1, 10, 23, 0, NULL, NULL, '2026-07-11 03:31:54.964'),
(27, 27, 1, 1, 1, 10, 24, 0, NULL, NULL, '2026-07-11 03:31:54.973'),
(28, 28, 1, 1, 1, 10, 25, 0, NULL, NULL, '2026-07-11 03:31:54.984'),
(29, 29, 1, 1, 1, 10, 26, 0, NULL, NULL, '2026-07-11 03:31:54.995'),
(30, 30, 1, 1, 1, 10, 27, 0, NULL, NULL, '2026-07-11 03:31:55.007'),
(31, 31, 1, 1, 1, 10, 28, 0, NULL, NULL, '2026-07-11 03:31:55.017'),
(32, 32, 1, 1, 1, 10, 29, 0, NULL, NULL, '2026-07-11 03:31:55.026'),
(33, 33, 1, 1, 1, 10, 30, 0, NULL, NULL, '2026-07-11 03:31:55.038'),
(34, 34, 1, 1, 1, 10, 31, 0, NULL, NULL, '2026-07-11 03:31:55.047'),
(35, 35, 1, 1, 1, 10, NULL, 0, NULL, NULL, '2026-07-11 03:31:55.056'),
(36, 36, 1, 1, 1, 10, 32, 0, NULL, NULL, '2026-07-11 03:31:55.066'),
(37, 37, 1, 1, 1, 10, 33, 0, NULL, NULL, '2026-07-11 03:31:55.079'),
(38, 38, 1, 1, 1, 10, 34, 0, NULL, NULL, '2026-07-11 03:31:55.087'),
(39, 39, 1, 1, 1, 10, 35, 0, NULL, NULL, '2026-07-11 03:31:55.096'),
(40, 40, 1, 1, 1, 10, 36, 0, NULL, NULL, '2026-07-11 03:31:55.107'),
(41, 41, 1, 1, 1, 11, 37, 0, NULL, NULL, '2026-07-11 03:31:55.118'),
(42, 42, 1, 1, 1, 11, 38, 0, NULL, NULL, '2026-07-11 03:31:55.130'),
(43, 43, 1, 1, 1, 11, 39, 0, NULL, NULL, '2026-07-11 03:31:55.141'),
(44, 44, 1, 1, 1, 11, 40, 0, NULL, NULL, '2026-07-11 03:31:55.153'),
(45, 45, 1, 1, 1, 11, 41, 0, NULL, NULL, '2026-07-11 03:31:55.163'),
(46, 46, 1, 1, 1, 11, 42, 0, NULL, NULL, '2026-07-11 03:31:55.173'),
(47, 47, 1, 1, 1, 11, 43, 0, NULL, NULL, '2026-07-11 03:31:55.183'),
(48, 48, 1, 1, 1, 11, 44, 0, NULL, NULL, '2026-07-11 03:31:55.191'),
(49, 49, 1, 1, 1, 11, 45, 0, NULL, NULL, '2026-07-11 03:31:55.201'),
(50, 50, 1, 1, 1, 11, 46, 0, NULL, NULL, '2026-07-11 03:31:55.215'),
(51, 51, 1, 1, 1, 11, 47, 0, NULL, NULL, '2026-07-11 03:31:55.224'),
(52, 52, 1, 1, 1, 11, 48, 0, NULL, NULL, '2026-07-11 03:31:55.233'),
(53, 53, 1, 1, 1, 11, 49, 0, NULL, NULL, '2026-07-11 03:31:55.242'),
(54, 54, 1, 1, 1, 11, 50, 0, NULL, NULL, '2026-07-11 03:31:55.251'),
(55, 55, 1, 1, 1, 11, 51, 0, NULL, NULL, '2026-07-11 03:31:55.263'),
(56, 56, 1, 1, 1, 11, 52, 0, NULL, NULL, '2026-07-11 03:31:55.273'),
(57, 57, 1, 1, 1, 11, 53, 0, NULL, NULL, '2026-07-11 03:31:55.286'),
(58, 58, 1, 1, 1, 11, 54, 0, NULL, NULL, '2026-07-11 03:31:55.297'),
(59, 59, 1, 1, 1, 11, 55, 0, NULL, NULL, '2026-07-11 03:31:55.308'),
(60, 60, 1, 1, 1, 11, 56, 0, NULL, NULL, '2026-07-11 03:31:55.319'),
(61, 61, 1, 1, 1, 11, 57, 0, NULL, NULL, '2026-07-11 03:31:55.330'),
(62, 62, 1, 1, 1, 11, 58, 0, NULL, NULL, '2026-07-11 03:31:55.347'),
(63, 63, 1, 1, 1, 11, 59, 0, NULL, NULL, '2026-07-11 03:31:55.366'),
(64, 64, 1, 1, 1, 11, 60, 0, NULL, NULL, '2026-07-11 03:31:55.387'),
(65, 65, 1, 1, 1, 11, 61, 0, NULL, NULL, '2026-07-11 03:31:55.398'),
(66, 66, 1, 1, 1, 12, 62, 0, NULL, NULL, '2026-07-11 03:31:55.410'),
(67, 67, 1, 1, 1, 12, NULL, 0, NULL, NULL, '2026-07-11 03:31:55.419'),
(68, 68, 1, 1, 1, 12, NULL, 0, NULL, NULL, '2026-07-11 03:31:55.429'),
(69, 69, 1, 1, 1, 12, 63, 0, NULL, NULL, '2026-07-11 03:31:55.470'),
(70, 70, 1, 1, 1, 12, NULL, 0, NULL, NULL, '2026-07-11 03:31:55.483'),
(71, 71, 1, 1, 1, 12, 64, 0, NULL, NULL, '2026-07-11 03:31:55.497'),
(72, 72, 1, 1, 1, 12, 65, 0, NULL, NULL, '2026-07-11 03:31:55.507'),
(73, 73, 1, 1, 1, 12, 66, 0, NULL, NULL, '2026-07-11 03:31:55.517'),
(74, 74, 1, 1, 1, 12, 67, 0, NULL, NULL, '2026-07-11 03:31:55.525'),
(75, 75, 1, 1, 1, 12, 68, 0, NULL, NULL, '2026-07-11 03:31:55.535'),
(76, 76, 1, 1, 1, 12, 69, 0, NULL, NULL, '2026-07-11 03:31:55.544'),
(77, 77, 1, 1, 1, 12, 70, 0, NULL, NULL, '2026-07-11 03:31:55.552'),
(78, 78, 1, 1, 1, 12, 71, 0, NULL, NULL, '2026-07-11 03:31:55.562'),
(79, 79, 1, 1, 1, 12, 72, 0, NULL, NULL, '2026-07-11 03:31:55.571'),
(80, 80, 1, 1, 1, 12, 73, 0, NULL, NULL, '2026-07-11 03:31:55.581'),
(81, 81, 1, 1, 1, 13, 74, 0, NULL, NULL, '2026-07-11 03:31:55.593'),
(82, 82, 1, 1, 1, 13, 75, 0, NULL, NULL, '2026-07-11 03:31:55.603'),
(83, 83, 1, 1, 1, 13, 76, 0, NULL, NULL, '2026-07-11 03:31:55.613'),
(84, 84, 1, 1, 1, 13, 77, 0, NULL, NULL, '2026-07-11 03:31:55.623'),
(85, 85, 1, 1, 1, 13, 78, 0, NULL, NULL, '2026-07-11 03:31:55.634'),
(86, 86, 1, 1, 1, 13, 79, 0, NULL, NULL, '2026-07-11 03:31:55.644'),
(87, 87, 1, 1, 1, 13, 80, 0, NULL, NULL, '2026-07-11 03:31:55.654'),
(88, 88, 1, 1, 1, 13, 81, 0, NULL, NULL, '2026-07-11 03:31:55.663'),
(89, 89, 1, 1, 1, 14, 82, 0, NULL, NULL, '2026-07-11 03:31:55.677'),
(90, 90, 1, 1, 1, 14, NULL, 0, NULL, NULL, '2026-07-11 03:31:55.686'),
(91, 91, 1, 1, 1, 14, NULL, 0, NULL, NULL, '2026-07-11 03:31:55.699'),
(92, 92, 1, 1, 1, 14, NULL, 0, NULL, NULL, '2026-07-11 03:31:55.707'),
(93, 93, 1, 1, 1, 14, NULL, 0, NULL, NULL, '2026-07-11 03:31:55.717'),
(94, 94, 1, 1, 1, 14, NULL, 0, NULL, NULL, '2026-07-11 03:31:55.728'),
(95, 95, 1, 1, 1, 14, NULL, 0, NULL, NULL, '2026-07-11 03:31:55.736'),
(96, 96, 1, 1, 1, 14, NULL, 0, NULL, NULL, '2026-07-11 03:31:55.747'),
(97, 97, 1, 1, 1, 14, NULL, 0, NULL, NULL, '2026-07-11 03:31:55.755'),
(98, 98, 2, 1, 4, 15, 83, 0, NULL, NULL, '2026-07-11 03:31:55.766'),
(99, 99, 2, 1, 4, 15, NULL, 0, NULL, NULL, '2026-07-11 03:31:55.778'),
(100, 100, 2, 1, 4, 16, 84, 0, NULL, NULL, '2026-07-11 03:31:55.789'),
(101, 101, 2, 1, 4, 16, NULL, 0, NULL, NULL, '2026-07-11 03:31:55.798'),
(102, 102, 2, 1, 4, 16, NULL, 0, NULL, NULL, '2026-07-11 03:31:55.806'),
(103, 103, 2, 1, 4, 16, NULL, 0, NULL, NULL, '2026-07-11 03:31:55.815'),
(104, 104, 2, 1, 4, 16, NULL, 0, NULL, NULL, '2026-07-11 03:31:55.823'),
(105, 105, 2, 1, 4, 16, NULL, 0, NULL, NULL, '2026-07-11 03:31:55.830'),
(106, 106, 2, 1, 4, 16, NULL, 0, NULL, NULL, '2026-07-11 03:31:55.837'),
(107, 107, 2, 1, 4, 16, NULL, 0, NULL, NULL, '2026-07-11 03:31:55.847'),
(108, 108, 2, 1, 4, 16, NULL, 0, NULL, NULL, '2026-07-11 03:31:55.854'),
(109, 109, 2, 1, 4, 16, NULL, 0, NULL, NULL, '2026-07-11 03:31:55.863'),
(110, 110, 2, 1, 4, 16, NULL, 0, NULL, NULL, '2026-07-11 03:31:55.870'),
(111, 111, 2, 1, 4, 16, NULL, 0, NULL, NULL, '2026-07-11 03:31:55.879'),
(112, 112, 2, 1, 4, 16, NULL, 0, NULL, NULL, '2026-07-11 03:31:55.887'),
(113, 113, 2, 1, 4, 16, NULL, 0, NULL, NULL, '2026-07-11 03:31:55.895'),
(114, 114, 2, 1, 4, 16, NULL, 0, NULL, NULL, '2026-07-11 03:31:55.903'),
(115, 115, 2, 1, 4, 16, NULL, 0, NULL, NULL, '2026-07-11 03:31:55.912'),
(116, 116, 2, 1, 4, 16, NULL, 0, NULL, NULL, '2026-07-11 03:31:55.920'),
(117, 117, 2, 1, 4, 16, NULL, 0, NULL, NULL, '2026-07-11 03:31:55.928'),
(118, 118, 2, 1, 4, 16, NULL, 0, NULL, NULL, '2026-07-11 03:31:55.936'),
(119, 119, 2, 1, 4, 16, NULL, 0, NULL, NULL, '2026-07-11 03:31:55.946'),
(120, 120, 2, 1, 4, 16, NULL, 0, NULL, NULL, '2026-07-11 03:31:55.953'),
(121, 121, 2, 1, 4, 16, NULL, 0, NULL, NULL, '2026-07-11 03:31:55.962'),
(122, 122, 2, 1, 4, 16, NULL, 0, NULL, NULL, '2026-07-11 03:31:55.972'),
(123, 123, 2, 1, 4, 16, NULL, 0, NULL, NULL, '2026-07-11 03:31:55.980'),
(124, 124, 2, 1, 4, 16, NULL, 0, NULL, NULL, '2026-07-11 03:31:55.988'),
(125, 125, 2, 1, 4, 16, NULL, 0, NULL, NULL, '2026-07-11 03:31:55.997'),
(126, 126, 2, 1, 4, 17, 85, 0, NULL, NULL, '2026-07-11 03:31:56.006'),
(127, 127, 2, 1, 4, 17, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.015'),
(128, 128, 2, 1, 4, 17, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.023'),
(129, 129, 2, 1, 4, 17, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.031'),
(130, 130, 2, 1, 4, 17, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.040'),
(131, 131, 2, 1, 4, 17, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.051'),
(132, 132, 2, 1, 4, 17, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.060'),
(133, 133, 2, 1, 4, 17, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.070'),
(134, 134, 2, 1, 4, 17, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.078'),
(135, 135, 2, 1, 4, 17, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.086'),
(136, 136, 2, 1, 4, 17, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.096'),
(137, 137, 2, 1, 4, 17, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.105'),
(138, 138, 2, 1, 4, 17, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.114'),
(139, 139, 2, 1, 4, 17, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.123'),
(140, 140, 2, 1, 4, 17, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.132'),
(141, 141, 2, 1, 4, 17, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.141'),
(142, 142, 2, 1, 4, 17, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.153'),
(143, 143, NULL, 2, NULL, 18, 86, 0, NULL, NULL, '2026-07-11 03:31:56.164'),
(144, 144, 1, 1, 1, 19, 87, 0, NULL, NULL, '2026-07-11 03:31:56.177'),
(145, 145, 1, 1, 1, 19, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.186'),
(146, 146, 1, 1, 1, 19, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.195'),
(147, 147, 1, 1, 1, 19, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.204'),
(148, 148, 1, 1, 1, 19, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.212'),
(149, 149, 1, 1, 1, 19, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.220'),
(150, 150, 1, 1, 1, 19, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.230'),
(151, 151, 1, 1, 1, 19, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.239'),
(152, 152, 1, 1, 1, 19, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.249'),
(153, 153, 1, 1, 1, 19, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.260'),
(154, 154, 1, 1, 1, 19, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.268'),
(155, 155, 1, 1, 1, 19, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.279'),
(156, 156, 1, 1, 1, 19, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.286'),
(157, 157, 1, 1, 1, 19, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.294'),
(158, 158, 1, 1, 1, 19, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.303'),
(159, 159, 1, 1, 1, 19, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.313'),
(160, 160, 1, 1, 1, 19, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.321'),
(161, 161, 1, 1, 1, 19, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.329'),
(162, 162, 1, 1, 1, 19, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.336'),
(163, 163, 1, 1, 1, 19, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.346'),
(164, 164, 1, 1, 1, 19, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.355'),
(165, 165, 1, 1, 1, 19, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.364'),
(166, 166, 1, 1, 1, 19, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.371'),
(167, 167, 1, 1, 1, 19, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.381'),
(168, 168, 1, 1, 1, 19, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.389'),
(169, 169, 1, 1, 1, 19, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.399'),
(170, 170, 1, 1, 1, 19, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.410'),
(171, 171, 1, 1, 1, 19, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.419'),
(172, 172, 1, 1, 1, 19, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.430'),
(173, 173, 1, 1, 1, 19, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.441'),
(174, 174, 1, 1, 1, 19, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.451'),
(175, 175, 1, 1, 1, 19, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.463'),
(176, 176, 1, 1, 1, 19, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.471'),
(177, 177, 1, 1, 1, 19, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.480'),
(178, 178, 1, 1, 1, 19, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.490'),
(179, 179, 1, 1, 1, 19, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.500'),
(180, 180, 1, 1, 1, 19, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.507'),
(181, 181, 1, 1, 1, 19, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.539'),
(182, 182, 1, 1, 1, 19, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.558'),
(183, 183, 1, 1, 1, 19, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.574'),
(184, 184, 1, 1, 1, 19, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.594'),
(185, 185, 1, 1, 1, 19, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.612'),
(186, 186, 1, 1, 1, 19, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.633'),
(187, 187, 1, 1, 1, 19, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.647'),
(188, 188, 1, 1, 1, 19, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.673'),
(189, 189, 1, 1, 1, 19, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.681'),
(190, 190, 1, 1, 1, 20, 88, 0, NULL, NULL, '2026-07-11 03:31:56.692'),
(191, 191, 1, 1, 1, 20, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.701'),
(192, 192, 1, 1, 1, 20, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.711'),
(193, 193, 1, 1, 1, 20, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.719'),
(194, 194, 1, 1, 1, 20, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.783'),
(195, 195, 1, 1, 1, 20, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.798'),
(196, 196, 1, 1, 1, 20, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.812'),
(197, 197, 1, 1, 1, 20, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.823'),
(198, 198, 1, 1, 1, 20, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.834'),
(199, 199, 1, 1, 1, 20, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.865'),
(200, 200, 1, 1, 1, 20, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.884'),
(201, 201, 1, 1, 1, 20, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.894'),
(202, 202, 1, 1, 1, 20, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.904'),
(203, 203, 1, 1, 1, 21, 89, 0, NULL, NULL, '2026-07-11 03:31:56.915'),
(204, 204, 1, 1, 1, 22, 89, 0, NULL, NULL, '2026-07-11 03:31:56.929'),
(205, 205, 1, 1, 1, 22, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.937'),
(206, 206, 1, 1, 1, 22, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.952'),
(207, 207, 1, 1, 1, 22, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.963'),
(208, 208, 1, 1, 1, 22, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.972'),
(209, 209, 1, 1, 1, 22, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.982'),
(210, 210, 1, 1, 1, 22, NULL, 0, NULL, NULL, '2026-07-11 03:31:56.991'),
(211, 211, 1, 1, 1, 22, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.001'),
(212, 212, 1, 1, 1, 22, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.010'),
(213, 213, 1, 1, 1, 22, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.018'),
(214, 214, 1, 1, 1, 23, 90, 0, NULL, NULL, '2026-07-11 03:31:57.029'),
(215, 215, 1, 1, 1, 23, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.040'),
(216, 216, 1, 1, 1, 24, 91, 0, NULL, NULL, '2026-07-11 03:31:57.053'),
(217, 217, 1, 1, 1, 24, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.062'),
(218, 218, 1, 1, 1, 24, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.071'),
(219, 219, 1, 1, 1, 24, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.079'),
(220, 220, 1, 1, 1, 24, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.087'),
(221, 221, 1, 1, 1, 25, 92, 0, NULL, NULL, '2026-07-11 03:31:57.096'),
(222, 222, 1, 1, 1, 25, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.104'),
(223, 223, 1, 1, 1, 25, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.112'),
(224, 224, 1, 1, 1, 25, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.120'),
(225, 225, 1, 1, 1, 25, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.131'),
(226, 226, 1, 1, 1, 25, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.140'),
(227, 227, 1, 1, 1, 25, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.149'),
(228, 228, 1, 1, 1, 25, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.158'),
(229, 229, NULL, 1, NULL, 26, 93, 0, NULL, NULL, '2026-07-11 03:31:57.171'),
(230, 230, NULL, 1, NULL, 27, 94, 0, NULL, NULL, '2026-07-11 03:31:57.185'),
(231, 231, NULL, 1, NULL, 27, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.196'),
(232, 232, NULL, 2, NULL, 27, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.205'),
(233, 233, NULL, 1, 5, 28, 95, 0, NULL, NULL, '2026-07-11 03:31:57.218'),
(234, 234, NULL, 1, 5, 28, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.231'),
(235, 235, NULL, 1, 5, 28, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.240'),
(236, 236, NULL, 1, 5, 28, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.252'),
(237, 237, NULL, 1, 5, 28, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.261'),
(238, 238, NULL, 1, 5, 28, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.269'),
(239, 239, NULL, 1, 5, 28, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.278'),
(240, 240, NULL, 1, 5, 28, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.288'),
(241, 241, NULL, 2, NULL, 29, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.298'),
(242, 242, NULL, 1, 5, 30, 96, 0, NULL, NULL, '2026-07-11 03:31:57.312'),
(243, 243, NULL, 1, 5, 30, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.321'),
(244, 244, NULL, 1, 5, 30, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.329'),
(245, 245, NULL, 1, 5, 30, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.336'),
(246, 246, NULL, 1, 5, 30, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.346'),
(247, 247, NULL, 1, 5, 30, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.355'),
(248, 248, NULL, 1, 5, 30, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.363'),
(249, 249, NULL, 1, 5, 31, 97, 0, NULL, NULL, '2026-07-11 03:31:57.374'),
(250, 250, NULL, 1, 5, 31, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.384'),
(251, 251, NULL, 1, 5, 31, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.394'),
(252, 252, NULL, 1, 5, 31, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.401'),
(253, 253, NULL, 1, 5, 31, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.415'),
(254, 254, NULL, 1, 5, 31, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.424'),
(255, 255, NULL, 1, 5, 31, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.436'),
(256, 256, NULL, 1, 5, 31, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.455'),
(257, 257, NULL, 1, 5, 31, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.468'),
(258, 258, NULL, 1, 5, 31, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.483'),
(259, 259, NULL, 1, 5, 31, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.497'),
(260, 260, NULL, 1, 5, 31, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.507'),
(261, 261, NULL, 1, 5, 31, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.518'),
(262, 262, NULL, 1, 5, 31, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.529'),
(263, 263, NULL, 1, 5, 32, 98, 0, NULL, NULL, '2026-07-11 03:31:57.538'),
(264, 264, NULL, 1, 5, 33, 99, 0, NULL, NULL, '2026-07-11 03:31:57.561'),
(265, 265, NULL, 1, 5, 34, 100, 0, NULL, NULL, '2026-07-11 03:31:57.583'),
(266, 266, NULL, 1, 5, 35, 101, 0, NULL, NULL, '2026-07-11 03:31:57.594'),
(267, 267, NULL, 1, 5, 36, 102, 0, NULL, NULL, '2026-07-11 03:31:57.605'),
(268, 268, NULL, 1, 5, 37, 103, 0, NULL, NULL, '2026-07-11 03:31:57.614'),
(269, 269, 4, 1, 5, 38, 104, 0, NULL, NULL, '2026-07-11 03:31:57.625'),
(270, 270, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.635'),
(271, 271, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.645'),
(272, 272, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.653'),
(273, 273, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.661'),
(274, 274, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.670'),
(275, 275, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.680'),
(276, 276, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.688'),
(277, 277, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.695'),
(278, 278, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.703'),
(279, 279, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.712'),
(280, 280, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.721'),
(281, 281, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.729'),
(282, 282, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.740'),
(283, 283, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.748'),
(284, 284, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.755'),
(285, 285, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.764'),
(286, 286, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.772'),
(287, 287, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.781'),
(288, 288, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.788'),
(289, 289, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.795'),
(290, 290, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.805'),
(291, 291, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.818'),
(292, 292, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.829'),
(293, 293, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.841'),
(294, 294, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.849'),
(295, 295, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.859'),
(296, 296, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.870'),
(297, 297, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.881'),
(298, 298, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.890'),
(299, 299, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.902'),
(300, 300, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.911'),
(301, 301, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.921'),
(302, 302, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.930'),
(303, 303, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.940'),
(304, 304, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.949'),
(305, 305, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.960'),
(306, 306, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.969'),
(307, 307, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.979'),
(308, 308, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.990'),
(309, 309, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:57.999'),
(310, 310, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.007'),
(311, 311, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.017'),
(312, 312, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.028'),
(313, 313, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.037'),
(314, 314, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.046'),
(315, 315, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.057'),
(316, 316, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.067'),
(317, 317, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.079'),
(318, 318, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.089'),
(319, 319, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.099'),
(320, 320, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.107'),
(321, 321, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.120'),
(322, 322, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.129'),
(323, 323, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.139'),
(324, 324, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.150'),
(325, 325, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.163'),
(326, 326, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.174'),
(327, 327, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.183'),
(328, 328, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.197'),
(329, 329, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.206'),
(330, 330, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.217'),
(331, 331, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.233'),
(332, 332, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.245'),
(333, 333, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.254'),
(334, 334, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.263'),
(335, 335, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.270'),
(336, 336, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.279'),
(337, 337, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.288'),
(338, 338, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.298'),
(339, 339, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.308'),
(340, 340, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.320'),
(341, 341, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.329'),
(342, 342, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.339'),
(343, 343, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.351'),
(344, 344, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.361'),
(345, 345, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.378'),
(346, 346, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.492'),
(347, 347, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.513'),
(348, 348, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.524'),
(349, 349, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.536'),
(350, 350, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.547'),
(351, 351, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.556'),
(352, 352, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.624'),
(353, 353, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.638'),
(354, 354, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.652'),
(355, 355, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.662'),
(356, 356, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.671'),
(357, 357, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.679'),
(358, 358, 4, 1, 5, 38, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.688'),
(359, 359, NULL, 1, 5, 39, 105, 0, NULL, NULL, '2026-07-11 03:31:58.699'),
(360, 360, NULL, 1, 5, 39, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.707'),
(361, 361, NULL, 1, 5, 39, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.716'),
(362, 362, NULL, 1, 5, 39, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.726'),
(363, 363, NULL, 1, 5, 39, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.735'),
(364, 364, NULL, 1, 5, 39, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.743'),
(365, 365, NULL, 1, 5, 39, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.752'),
(366, 366, NULL, 1, 5, 39, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.761'),
(367, 367, NULL, 1, 5, 39, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.770'),
(368, 368, NULL, 1, 5, 39, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.778'),
(369, 369, NULL, 1, 5, 39, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.785'),
(370, 370, NULL, 1, 5, 39, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.796'),
(371, 371, NULL, 1, 5, 39, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.806'),
(372, 372, NULL, 1, 5, 39, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.817'),
(373, 373, NULL, 1, 5, 39, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.827'),
(374, 374, NULL, 1, 5, 40, 106, 0, NULL, NULL, '2026-07-11 03:31:58.840'),
(375, 375, NULL, 1, 5, 41, 107, 0, NULL, NULL, '2026-07-11 03:31:58.853'),
(376, 376, NULL, 1, 5, 41, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.863'),
(377, 377, NULL, 1, 5, 41, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.872'),
(378, 378, NULL, 1, 5, 41, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.882'),
(379, 379, NULL, 1, 5, 41, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.890'),
(380, 380, NULL, 1, 5, 41, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.899'),
(381, 381, NULL, 1, 5, 41, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.906'),
(382, 382, NULL, 1, 5, 41, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.917'),
(383, 383, NULL, 1, 5, 41, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.926'),
(384, 384, NULL, 1, 5, 41, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.934'),
(385, 385, NULL, 1, 5, 41, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.944'),
(386, 386, NULL, 1, 5, 41, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.953'),
(387, 387, NULL, 1, 5, 41, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.962'),
(388, 388, NULL, 1, 5, 41, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.969'),
(389, 389, NULL, 1, 5, 41, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.978'),
(390, 390, NULL, 1, 5, 41, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.986'),
(391, 391, NULL, 1, 5, 41, NULL, 0, NULL, NULL, '2026-07-11 03:31:58.995'),
(392, 392, NULL, 1, 5, 41, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.004'),
(393, 393, NULL, 1, 5, 41, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.013'),
(394, 394, NULL, 1, 5, 41, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.022'),
(395, 395, NULL, 1, 5, 41, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.030'),
(396, 396, NULL, 1, 5, 41, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.038'),
(397, 397, NULL, 1, 5, 41, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.047'),
(398, 398, NULL, 1, 5, 41, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.058'),
(399, 399, NULL, 1, 5, 41, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.068'),
(400, 400, NULL, 1, 5, 41, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.076'),
(401, 401, NULL, 1, 5, 41, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.087'),
(402, 402, NULL, 1, 5, 41, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.096'),
(403, 403, NULL, 1, 5, 41, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.105'),
(404, 404, NULL, 1, 5, 41, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.112'),
(405, 405, NULL, 1, 5, 41, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.124'),
(406, 406, NULL, 1, 5, 41, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.136'),
(407, 407, NULL, 1, 5, 41, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.144'),
(408, 408, NULL, 1, 5, 41, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.152'),
(409, 409, NULL, 1, 5, 41, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.193'),
(410, 410, NULL, 1, 5, 41, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.200'),
(411, 411, NULL, 1, 5, 41, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.209'),
(412, 412, NULL, 1, 5, 41, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.219'),
(413, 413, NULL, 1, 5, 41, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.227'),
(414, 414, NULL, 1, 5, 42, 108, 0, NULL, NULL, '2026-07-11 03:31:59.236'),
(415, 415, NULL, 1, 5, 42, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.246'),
(416, 416, NULL, 1, 5, 42, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.255'),
(417, 417, NULL, 1, 5, 42, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.265'),
(418, 418, NULL, 1, 5, 42, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.273'),
(419, 419, NULL, 1, 5, 42, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.283'),
(420, 420, NULL, 1, 5, 42, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.293'),
(421, 421, NULL, 1, 5, 42, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.300'),
(422, 422, NULL, 1, 5, 42, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.311'),
(423, 423, NULL, 1, 5, 42, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.318'),
(424, 424, NULL, 1, 5, 42, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.326'),
(425, 425, NULL, 1, 5, 42, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.337'),
(426, 426, NULL, 1, 5, 42, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.347'),
(427, 427, NULL, 1, 5, 42, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.356'),
(428, 428, NULL, 1, 5, 42, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.367'),
(429, 429, NULL, 1, 5, 42, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.375'),
(430, 430, NULL, 1, 5, 42, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.383'),
(431, 431, NULL, 1, 5, 42, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.394'),
(432, 432, NULL, 1, 5, 42, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.403'),
(433, 433, NULL, 1, 5, 42, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.416'),
(434, 434, NULL, 1, 5, 42, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.428'),
(435, 435, NULL, 1, 5, 42, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.438'),
(436, 436, NULL, 1, 5, 42, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.449'),
(437, 437, NULL, 1, 5, 42, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.461'),
(438, 438, NULL, 1, 5, 42, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.472'),
(439, 439, NULL, 1, 5, 42, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.484'),
(440, 440, NULL, 1, 5, 42, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.496'),
(441, 441, NULL, 1, 5, 42, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.506'),
(442, 442, NULL, 1, 5, 42, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.519'),
(443, 443, NULL, 1, 5, 42, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.532'),
(444, 444, NULL, 1, 5, 42, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.544'),
(445, 445, NULL, 1, 5, 42, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.554'),
(446, 446, NULL, 1, 5, 42, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.564'),
(447, 447, NULL, 1, 5, 43, 109, 0, NULL, NULL, '2026-07-11 03:31:59.577'),
(448, 448, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.587'),
(449, 449, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.604'),
(450, 450, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.614'),
(451, 451, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.623'),
(452, 452, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.633'),
(453, 453, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.645'),
(454, 454, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.655'),
(455, 455, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.668'),
(456, 456, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.681'),
(457, 457, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.690'),
(458, 458, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.700'),
(459, 459, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.710'),
(460, 460, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.719'),
(461, 461, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.731'),
(462, 462, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.742'),
(463, 463, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.759'),
(464, 464, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.771'),
(465, 465, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.779'),
(466, 466, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.788'),
(467, 467, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.798'),
(468, 468, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.805'),
(469, 469, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.813'),
(470, 470, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.821'),
(471, 471, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.829'),
(472, 472, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.837'),
(473, 473, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.846'),
(474, 474, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.854'),
(475, 475, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.865'),
(476, 476, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.875'),
(477, 477, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.887'),
(478, 478, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.897'),
(479, 479, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.905'),
(480, 480, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.913'),
(481, 481, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.923'),
(482, 482, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.933'),
(483, 483, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.942'),
(484, 484, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.952'),
(485, 485, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.962'),
(486, 486, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.969'),
(487, 487, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.977'),
(488, 488, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.984'),
(489, 489, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:31:59.993'),
(490, 490, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.001'),
(491, 491, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.011'),
(492, 492, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.022'),
(493, 493, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.045'),
(494, 494, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.055'),
(495, 495, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.068'),
(496, 496, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.079'),
(497, 497, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.088'),
(498, 498, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.098'),
(499, 499, NULL, 1, 5, 43, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.112'),
(500, 500, NULL, 1, 5, 44, 110, 0, NULL, NULL, '2026-07-11 03:32:00.125'),
(501, 501, NULL, 1, 5, 44, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.137'),
(502, 502, NULL, 1, 5, 44, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.151'),
(503, 503, NULL, 1, 5, 44, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.160'),
(504, 504, NULL, 1, 5, 44, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.169'),
(505, 505, NULL, 1, 5, 44, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.180'),
(506, 506, NULL, 1, 5, 44, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.192'),
(507, 507, NULL, 1, 5, 44, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.204'),
(508, 508, NULL, 1, 5, 44, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.214'),
(509, 509, NULL, 1, 5, 44, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.222'),
(510, 510, NULL, 1, 5, 44, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.233'),
(511, 511, NULL, 1, 5, 44, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.242'),
(512, 512, NULL, 1, 5, 44, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.253'),
(513, 513, NULL, 1, 5, 44, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.261'),
(514, 514, NULL, 1, 5, 44, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.269'),
(515, 515, NULL, 1, 5, 44, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.277'),
(516, 516, NULL, 1, 5, 44, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.285'),
(517, 517, NULL, 1, 5, 44, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.295'),
(518, 518, NULL, 1, 5, 44, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.304'),
(519, 519, NULL, 1, 5, 44, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.313'),
(520, 520, NULL, 1, 5, 44, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.322'),
(521, 521, NULL, 1, 5, 44, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.332'),
(522, 522, NULL, 1, 5, 44, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.340'),
(523, 523, NULL, 3, 7, 45, 111, 0, NULL, NULL, '2026-07-11 03:32:00.353'),
(524, 524, NULL, 3, 7, 45, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.361'),
(525, 525, NULL, 3, 7, 45, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.381'),
(526, 526, NULL, 3, 7, 45, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.399'),
(527, 527, NULL, 3, 7, 45, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.406'),
(528, 528, NULL, 3, 7, 45, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.415'),
(529, 529, NULL, 3, 7, 45, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.424'),
(530, 530, NULL, 3, 7, 46, 112, 0, NULL, NULL, '2026-07-11 03:32:00.435'),
(531, 531, NULL, 3, 7, 46, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.446'),
(532, 532, NULL, 3, 7, 46, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.455'),
(533, 533, NULL, 3, 7, 46, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.465'),
(534, 534, NULL, 3, 7, 47, 113, 0, NULL, NULL, '2026-07-11 03:32:00.478'),
(535, 535, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.488'),
(536, 536, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.500'),
(537, 537, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.510'),
(538, 538, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.520'),
(539, 539, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.530'),
(540, 540, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.538'),
(541, 541, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.549'),
(542, 542, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.590'),
(543, 543, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.604'),
(544, 544, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.614'),
(545, 545, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.622'),
(546, 546, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.634'),
(547, 547, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.644'),
(548, 548, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.653'),
(549, 549, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.663'),
(550, 550, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.671'),
(551, 551, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.680'),
(552, 552, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.687'),
(553, 553, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.696'),
(554, 554, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.704'),
(555, 555, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.714'),
(556, 556, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.721'),
(557, 557, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.732'),
(558, 558, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.743'),
(559, 559, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.751'),
(560, 560, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.761'),
(561, 561, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.769'),
(562, 562, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.779'),
(563, 563, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.788'),
(564, 564, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.799'),
(565, 565, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.809'),
(566, 566, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.817'),
(567, 567, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.825'),
(568, 568, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.833'),
(569, 569, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.842'),
(570, 570, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.852'),
(571, 571, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.861'),
(572, 572, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.868'),
(573, 573, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.877'),
(574, 574, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.885'),
(575, 575, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.894'),
(576, 576, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.901'),
(577, 577, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.911'),
(578, 578, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.918'),
(579, 579, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.927'),
(580, 580, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.935'),
(581, 581, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.944'),
(582, 582, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.953'),
(583, 583, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.961'),
(584, 584, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.969'),
(585, 585, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.978'),
(586, 586, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.988'),
(587, 587, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:00.997'),
(588, 588, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.005'),
(589, 589, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.013'),
(590, 590, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.022'),
(591, 591, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.032'),
(592, 592, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.042'),
(593, 593, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.050'),
(594, 594, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.061'),
(595, 595, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.071'),
(596, 596, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.081'),
(597, 597, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.093'),
(598, 598, NULL, 3, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.102'),
(599, 599, NULL, 2, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.112'),
(600, 600, NULL, 2, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.120'),
(601, 601, NULL, 2, 7, 47, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.130'),
(602, 602, NULL, 3, 7, 48, 114, 0, NULL, NULL, '2026-07-11 03:32:01.143'),
(603, 603, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.174'),
(604, 604, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.203'),
(605, 605, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.218'),
(606, 606, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.231'),
(607, 607, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.243'),
(608, 608, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.254'),
(609, 609, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.267'),
(610, 610, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.277'),
(611, 611, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.309'),
(612, 612, NULL, 2, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.320'),
(613, 613, NULL, 2, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.342'),
(614, 614, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.387'),
(615, 615, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.414'),
(616, 616, NULL, 2, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.432'),
(617, 617, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.453'),
(618, 618, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.472'),
(619, 619, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.482'),
(620, 620, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.498'),
(621, 621, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.507'),
(622, 622, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.523'),
(623, 623, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.599'),
(624, 624, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.673'),
(625, 625, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.687'),
(626, 626, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.700'),
(627, 627, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.710'),
(628, 628, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.723'),
(629, 629, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.737'),
(630, 630, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.753'),
(631, 631, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.773'),
(632, 632, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.786'),
(633, 633, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.798'),
(634, 634, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.814'),
(635, 635, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.836'),
(636, 636, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.853'),
(637, 637, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.866'),
(638, 638, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.875'),
(639, 639, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.887'),
(640, 640, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.896'),
(641, 641, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.905'),
(642, 642, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.915'),
(643, 643, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.925'),
(644, 644, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.936'),
(645, 645, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.945'),
(646, 646, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.954'),
(647, 647, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.963'),
(648, 648, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.974'),
(649, 649, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.985'),
(650, 650, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:01.996'),
(651, 651, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.004'),
(652, 652, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.013'),
(653, 653, NULL, 2, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.021'),
(654, 654, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.030'),
(655, 655, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.040'),
(656, 656, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.050'),
(657, 657, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.058'),
(658, 658, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.067'),
(659, 659, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.077'),
(660, 660, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.087'),
(661, 661, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.097'),
(662, 662, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.110'),
(663, 663, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.119'),
(664, 664, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.127'),
(665, 665, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.135'),
(666, 666, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.154'),
(667, 667, NULL, 3, 7, 48, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.169'),
(668, 668, NULL, 4, 8, 49, 115, 0, NULL, NULL, '2026-07-11 03:32:02.196'),
(669, 669, NULL, 4, 8, 49, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.206'),
(670, 670, NULL, 4, 8, 49, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.217'),
(671, 671, NULL, 4, 8, 49, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.228'),
(672, 672, NULL, 4, 8, 49, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.236'),
(673, 673, NULL, 4, 8, 49, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.246'),
(674, 674, NULL, 4, 8, 49, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.257'),
(675, 675, NULL, 4, 8, 49, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.268'),
(676, 676, NULL, 4, 8, 49, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.278'),
(677, 677, NULL, 4, 8, 49, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.287'),
(678, 678, NULL, 4, 8, 49, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.295'),
(679, 679, NULL, 4, 8, 49, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.303'),
(680, 680, NULL, 4, 8, 49, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.313'),
(681, 681, NULL, 4, 8, 49, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.320'),
(682, 682, NULL, 4, 8, 49, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.332'),
(683, 683, NULL, 4, 8, 49, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.343'),
(684, 684, NULL, 4, 8, 49, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.351'),
(685, 685, NULL, 4, 8, 49, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.361'),
(686, 686, NULL, 4, 8, 49, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.379'),
(687, 687, NULL, 4, 8, 49, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.426'),
(688, 688, NULL, 4, 8, 49, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.441'),
(689, 689, NULL, 4, 8, 49, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.457'),
(690, 690, NULL, 4, 8, 49, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.468'),
(691, 691, NULL, 4, 8, 49, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.480');
INSERT INTO `hardcopy_documents` (`hardcopy_id`, `document_id`, `asset_id`, `area_id`, `specific_id`, `location_id`, `sequence_id`, `retention_enabled`, `retention_start_date`, `retention_end_date`, `created_at`) VALUES
(692, 692, NULL, 4, 8, 49, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.491'),
(693, 693, NULL, 4, 8, 49, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.500'),
(694, 694, NULL, 4, 8, 49, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.509'),
(695, 695, NULL, 4, 8, 49, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.518'),
(696, 696, NULL, 4, 8, 49, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.528'),
(697, 697, NULL, 4, 8, 49, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.539'),
(698, 698, NULL, 4, 8, 49, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.549'),
(699, 699, NULL, 4, 8, 49, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.559'),
(700, 700, NULL, 4, 8, 49, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.568'),
(701, 701, NULL, 4, 8, 49, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.578'),
(702, 702, NULL, 4, 8, 49, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.587'),
(703, 703, NULL, 4, 8, 49, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.598'),
(704, 704, NULL, 4, 8, 49, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.607'),
(705, 705, NULL, 4, 8, 49, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.618'),
(706, 706, NULL, 3, NULL, 50, 116, 0, NULL, NULL, '2026-07-11 03:32:02.630'),
(707, 707, NULL, 3, NULL, 50, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.641'),
(708, 708, NULL, 3, NULL, 50, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.655'),
(709, 709, NULL, 3, NULL, 50, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.667'),
(710, 710, NULL, 3, NULL, 50, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.677'),
(711, 711, NULL, 3, NULL, 50, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.696'),
(712, 712, NULL, 3, NULL, 50, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.714'),
(713, 713, NULL, 3, NULL, 50, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.726'),
(714, 714, NULL, 3, NULL, 50, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.735'),
(715, 715, NULL, 3, NULL, 50, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.747'),
(716, 716, NULL, 3, NULL, 50, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.756'),
(717, 717, NULL, 3, NULL, 50, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.768'),
(718, 718, NULL, 3, NULL, 50, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.777'),
(719, 719, NULL, 3, 7, 51, 117, 0, NULL, NULL, '2026-07-11 03:32:02.790'),
(720, 720, NULL, 3, 7, 51, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.802'),
(721, 721, NULL, 3, 7, 51, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.812'),
(722, 722, NULL, 3, 7, 51, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.821'),
(723, 723, NULL, 3, 7, 51, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.832'),
(724, 724, NULL, 3, 7, 51, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.846'),
(725, 725, NULL, 3, 7, 51, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.872'),
(726, 726, NULL, 3, 7, 51, NULL, 0, NULL, NULL, '2026-07-11 03:32:02.961'),
(727, 727, NULL, 3, 7, 51, NULL, 0, NULL, NULL, '2026-07-11 03:32:03.042'),
(728, 728, NULL, 3, 7, 51, NULL, 0, NULL, NULL, '2026-07-11 03:32:03.120'),
(729, 729, NULL, 3, 7, 51, NULL, 0, NULL, NULL, '2026-07-11 03:32:03.165'),
(730, 730, NULL, 3, 7, 51, NULL, 0, NULL, NULL, '2026-07-11 03:32:03.226'),
(731, 731, NULL, 3, 7, 51, NULL, 0, NULL, NULL, '2026-07-11 03:32:03.265'),
(732, 732, NULL, 3, 7, 51, NULL, 0, NULL, NULL, '2026-07-11 03:32:03.310'),
(733, 733, NULL, 3, 7, 51, NULL, 0, NULL, NULL, '2026-07-11 03:32:03.362'),
(734, 734, NULL, 3, 7, 51, NULL, 0, NULL, NULL, '2026-07-11 03:32:03.416'),
(735, 735, NULL, 3, 7, 51, NULL, 0, NULL, NULL, '2026-07-11 03:32:03.455'),
(736, 736, NULL, 3, 7, 51, NULL, 0, NULL, NULL, '2026-07-11 03:32:03.515'),
(737, 737, NULL, 3, 7, 51, NULL, 0, NULL, NULL, '2026-07-11 03:32:03.617'),
(738, 738, NULL, 3, 7, 51, NULL, 0, NULL, NULL, '2026-07-11 03:32:03.662'),
(739, 739, NULL, 3, 7, 51, NULL, 0, NULL, NULL, '2026-07-11 03:32:03.705'),
(740, 740, NULL, 3, 7, 51, NULL, 0, NULL, NULL, '2026-07-11 03:32:03.737'),
(741, 741, NULL, 3, 7, 51, NULL, 0, NULL, NULL, '2026-07-11 03:32:03.778'),
(742, 742, NULL, 3, 7, 51, NULL, 0, NULL, NULL, '2026-07-11 03:32:03.851'),
(743, 743, NULL, 3, 7, 51, NULL, 0, NULL, NULL, '2026-07-11 03:32:03.924'),
(744, 744, NULL, 3, 7, 51, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.039'),
(745, 745, NULL, 3, 7, 51, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.079'),
(746, 746, NULL, 3, 7, 51, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.131'),
(747, 747, NULL, 3, 7, 51, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.163'),
(748, 748, NULL, 3, NULL, 52, 118, 0, NULL, NULL, '2026-07-11 03:32:04.183'),
(749, 749, NULL, 3, NULL, 52, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.194'),
(750, 750, NULL, 3, NULL, 52, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.204'),
(751, 751, NULL, 3, NULL, 52, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.215'),
(752, 752, NULL, 3, NULL, 52, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.227'),
(753, 753, NULL, 3, NULL, 52, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.237'),
(754, 754, NULL, 3, NULL, 52, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.247'),
(755, 755, NULL, 3, NULL, 53, 119, 0, NULL, NULL, '2026-07-11 03:32:04.261'),
(756, 756, NULL, 3, NULL, 53, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.271'),
(757, 757, NULL, 3, NULL, 53, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.282'),
(758, 758, NULL, 3, NULL, 53, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.292'),
(759, 759, NULL, 3, NULL, 54, 120, 0, NULL, NULL, '2026-07-11 03:32:04.304'),
(760, 760, NULL, 3, NULL, 55, 121, 0, NULL, NULL, '2026-07-11 03:32:04.318'),
(761, 761, NULL, 3, NULL, 55, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.329'),
(762, 762, NULL, 3, NULL, 56, 122, 0, NULL, NULL, '2026-07-11 03:32:04.342'),
(763, 763, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.353'),
(764, 764, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.364'),
(765, 765, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.374'),
(766, 766, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.385'),
(767, 767, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.395'),
(768, 768, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.405'),
(769, 769, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.415'),
(770, 770, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.427'),
(771, 771, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.437'),
(772, 772, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.449'),
(773, 773, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.461'),
(774, 774, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.471'),
(775, 775, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.484'),
(776, 776, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.495'),
(777, 777, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.656'),
(778, 778, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.666'),
(779, 779, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.675'),
(780, 780, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.682'),
(781, 781, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.691'),
(782, 782, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.701'),
(783, 783, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.711'),
(784, 784, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.718'),
(785, 785, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.727'),
(786, 786, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.736'),
(787, 787, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.746'),
(788, 788, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.760'),
(789, 789, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.769'),
(790, 790, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.780'),
(791, 791, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.790'),
(792, 792, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.798'),
(793, 793, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.805'),
(794, 794, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.815'),
(795, 795, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.826'),
(796, 796, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.835'),
(797, 797, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.844'),
(798, 798, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.853'),
(799, 799, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.861'),
(800, 800, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.870'),
(801, 801, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.878'),
(802, 802, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.886'),
(803, 803, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.895'),
(804, 804, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.903'),
(805, 805, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.911'),
(806, 806, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.923'),
(807, 807, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.932'),
(808, 808, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.943'),
(809, 809, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.952'),
(810, 810, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.961'),
(811, 811, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.969'),
(812, 812, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.977'),
(813, 813, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.985'),
(814, 814, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:04.997'),
(815, 815, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.004'),
(816, 816, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.012'),
(817, 817, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.021'),
(818, 818, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.029'),
(819, 819, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.036'),
(820, 820, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.047'),
(821, 821, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.054'),
(822, 822, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.061'),
(823, 823, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.070'),
(824, 824, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.078'),
(825, 825, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.086'),
(826, 826, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.096'),
(827, 827, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.103'),
(828, 828, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.112'),
(829, 829, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.120'),
(830, 830, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.128'),
(831, 831, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.137'),
(832, 832, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.145'),
(833, 833, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.155'),
(834, 834, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.167'),
(835, 835, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.176'),
(836, 836, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.185'),
(837, 837, NULL, 3, NULL, 56, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.194'),
(838, 838, NULL, 3, NULL, 57, 123, 0, NULL, NULL, '2026-07-11 03:32:05.204'),
(839, 839, NULL, 3, NULL, 57, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.216'),
(840, 840, NULL, 3, NULL, 57, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.224'),
(841, 841, NULL, 3, NULL, 57, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.234'),
(842, 842, NULL, 3, NULL, 57, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.246'),
(843, 843, NULL, 3, NULL, 57, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.254'),
(844, 844, NULL, 3, NULL, 57, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.262'),
(845, 845, NULL, 3, NULL, 57, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.272'),
(846, 846, NULL, 3, NULL, 57, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.282'),
(847, 847, NULL, 3, NULL, 57, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.291'),
(848, 848, NULL, 3, NULL, 57, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.300'),
(849, 849, NULL, 3, NULL, 57, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.310'),
(850, 850, NULL, 3, NULL, 57, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.320'),
(851, 851, NULL, 3, NULL, 57, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.330'),
(852, 852, NULL, 3, NULL, 57, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.338'),
(853, 853, NULL, 3, NULL, 57, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.349'),
(854, 854, NULL, 3, NULL, 57, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.359'),
(855, 855, NULL, 3, NULL, 57, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.368'),
(856, 856, NULL, 3, NULL, 57, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.377'),
(857, 857, NULL, 3, NULL, 57, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.384'),
(858, 858, NULL, 3, NULL, 57, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.393'),
(859, 859, NULL, 3, NULL, 57, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.402'),
(860, 860, NULL, 3, NULL, 57, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.412'),
(861, 861, 5, 1, 5, 58, 124, 0, NULL, NULL, '2026-07-11 03:32:05.423'),
(862, 862, 5, 1, 5, 58, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.432'),
(863, 863, 5, 1, 5, 58, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.439'),
(864, 864, 5, 1, 5, 58, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.450'),
(865, 865, 5, 1, 5, 58, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.460'),
(866, 866, 5, 1, 5, 58, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.475'),
(867, 867, 5, 1, 5, 58, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.487'),
(868, 868, 5, 1, 5, 58, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.497'),
(869, 869, 5, 1, 5, 58, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.510'),
(870, 870, 5, 1, 5, 58, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.520'),
(871, 871, 5, 1, 5, 58, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.528'),
(872, 872, 5, 1, 5, 58, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.537'),
(873, 873, 5, 1, 5, 58, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.546'),
(874, 874, 5, 1, 5, 58, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.554'),
(875, 875, 5, 1, 5, 58, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.565'),
(876, 876, 5, 1, 5, 58, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.576'),
(877, 877, 5, 1, 5, 58, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.583'),
(878, 878, 5, 1, 5, 58, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.592'),
(879, 879, 5, 1, 5, 58, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.601'),
(880, 880, 5, 1, 5, 58, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.611'),
(881, 881, 5, 1, 5, 58, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.620'),
(882, 882, 5, 1, 5, 58, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.628'),
(883, 883, 5, 1, 5, 58, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.637'),
(884, 884, 5, 1, 5, 58, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.653'),
(885, 885, 5, 1, 5, 58, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.664'),
(886, 886, 5, 1, 5, 58, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.673'),
(887, 887, 5, 1, 5, 58, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.681'),
(888, 888, 5, 1, 5, 58, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.691'),
(889, 889, 5, 1, 5, 58, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.700'),
(890, 890, 5, 1, 5, 58, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.709'),
(891, 891, 5, 1, 5, 58, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.719'),
(892, 892, 5, 1, 5, 58, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.732'),
(893, 893, 5, 1, 5, 58, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.740'),
(894, 894, 5, 1, 5, 58, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.748'),
(895, 895, 5, 1, 5, 58, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.756'),
(896, 896, 5, 1, 5, 58, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.767'),
(897, 897, 5, 1, 5, 58, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.779'),
(898, 898, 5, 1, 5, 58, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.790'),
(899, 899, 5, 1, 5, 58, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.801'),
(900, 900, 6, 1, 5, 59, 125, 0, NULL, NULL, '2026-07-11 03:32:05.812'),
(901, 901, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.822'),
(902, 902, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.832'),
(903, 903, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.843'),
(904, 904, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.851'),
(905, 905, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.861'),
(906, 906, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.870'),
(907, 907, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.878'),
(908, 908, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.888'),
(909, 909, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.896'),
(910, 910, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.906'),
(911, 911, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.916'),
(912, 912, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.924'),
(913, 913, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.952'),
(914, 914, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.965'),
(915, 915, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.973'),
(916, 916, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.985'),
(917, 917, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:05.996'),
(918, 918, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.006'),
(919, 919, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.017'),
(920, 920, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.027'),
(921, 921, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.035'),
(922, 922, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.044'),
(923, 923, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.056'),
(924, 924, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.067'),
(925, 925, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.077'),
(926, 926, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.087'),
(927, 927, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.097'),
(928, 928, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.105'),
(929, 929, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.116'),
(930, 930, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.126'),
(931, 931, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.135'),
(932, 932, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.151'),
(933, 933, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.162'),
(934, 934, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.172'),
(935, 935, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.185'),
(936, 936, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.196'),
(937, 937, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.205'),
(938, 938, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.217'),
(939, 939, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.228'),
(940, 940, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.236'),
(941, 941, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.245'),
(942, 942, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.278'),
(943, 943, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.287'),
(944, 944, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.295'),
(945, 945, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.303'),
(946, 946, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.317'),
(947, 947, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.329'),
(948, 948, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.337'),
(949, 949, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.344'),
(950, 950, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.352'),
(951, 951, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.361'),
(952, 952, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.370'),
(953, 953, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.379'),
(954, 954, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.387'),
(955, 955, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.398'),
(956, 956, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.409'),
(957, 957, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.435'),
(958, 958, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.448'),
(959, 959, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.468'),
(960, 960, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.495'),
(961, 961, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.503'),
(962, 962, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.511'),
(963, 963, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.519'),
(964, 964, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.527'),
(965, 965, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.535'),
(966, 966, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.543'),
(967, 967, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.550'),
(968, 968, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.560'),
(969, 969, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.568'),
(970, 970, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.580'),
(971, 971, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.589'),
(972, 972, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.599'),
(973, 973, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.609'),
(974, 974, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.618'),
(975, 975, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.628'),
(976, 976, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.637'),
(977, 977, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.650'),
(978, 978, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.660'),
(979, 979, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.670'),
(980, 980, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.679'),
(981, 981, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.689'),
(982, 982, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.700'),
(983, 983, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.710'),
(984, 984, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.721'),
(985, 985, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.728'),
(986, 986, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.737'),
(987, 987, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.745'),
(988, 988, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.753'),
(989, 989, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.761'),
(990, 990, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.772'),
(991, 991, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.783'),
(992, 992, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.793'),
(993, 993, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.801'),
(994, 994, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.811'),
(995, 995, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.822'),
(996, 996, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.831'),
(997, 997, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.840'),
(998, 998, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.855'),
(999, 999, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.866'),
(1000, 1000, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.877'),
(1001, 1001, 6, 1, 5, 59, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.887'),
(1002, 1002, 6, 1, 5, 60, 126, 0, NULL, NULL, '2026-07-11 03:32:06.899'),
(1003, 1003, 6, 1, 5, 61, 127, 0, NULL, NULL, '2026-07-11 03:32:06.911'),
(1004, 1004, 6, 1, 5, 62, 128, 0, NULL, NULL, '2026-07-11 03:32:06.921'),
(1005, 1005, 7, 1, 5, 63, 129, 0, NULL, NULL, '2026-07-11 03:32:06.933'),
(1006, 1006, 7, 1, 5, 63, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.944'),
(1007, 1007, 7, 1, 5, 63, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.952'),
(1008, 1008, 7, 1, 5, 63, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.962'),
(1009, 1009, 7, 1, 5, 63, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.970'),
(1010, 1010, 7, 1, 5, 63, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.978'),
(1011, 1011, 7, 1, 5, 63, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.988'),
(1012, 1012, 7, 1, 5, 63, NULL, 0, NULL, NULL, '2026-07-11 03:32:06.997'),
(1013, 1013, 7, 1, 5, 63, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.006'),
(1014, 1014, 7, 1, 5, 63, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.016'),
(1015, 1015, 7, 1, 5, 63, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.027'),
(1016, 1016, 7, 1, 5, 63, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.047'),
(1017, 1017, 7, 1, 5, 63, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.061'),
(1018, 1018, 7, 1, 5, 63, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.072'),
(1019, 1019, 7, 1, 5, 63, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.081'),
(1020, 1020, 7, 1, 5, 63, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.091'),
(1021, 1021, 7, 1, 5, 63, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.102'),
(1022, 1022, 7, 1, 5, 63, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.111'),
(1023, 1023, 7, 1, 5, 63, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.120'),
(1024, 1024, 7, 1, 5, 63, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.132'),
(1025, 1025, 7, 1, 5, 63, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.149'),
(1026, 1026, 7, 1, 5, 63, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.174'),
(1027, 1027, 7, 1, 5, 63, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.185'),
(1028, 1028, 7, 1, 5, 63, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.195'),
(1029, 1029, 7, 1, 5, 63, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.204'),
(1030, 1030, 7, 1, 5, 63, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.218'),
(1031, 1031, 7, 1, 5, 63, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.229'),
(1032, 1032, 7, 1, 5, 63, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.238'),
(1033, 1033, 7, 1, 5, 63, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.248'),
(1034, 1034, 7, 1, 5, 63, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.255'),
(1035, 1035, 7, 1, 5, 63, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.267'),
(1036, 1036, 7, 1, 5, 63, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.276'),
(1037, 1037, 7, 1, 5, 63, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.285'),
(1038, 1038, 7, 1, 5, 63, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.296'),
(1039, 1039, 7, 1, 5, 63, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.305'),
(1040, 1040, 7, 1, 5, 63, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.317'),
(1041, 1041, 7, 1, 5, 63, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.325'),
(1042, 1042, 7, 1, 5, 63, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.333'),
(1043, 1043, 7, 1, 5, 63, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.343'),
(1044, 1044, 7, 1, 5, 63, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.351'),
(1045, 1045, 7, 1, 5, 63, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.361'),
(1046, 1046, 7, 1, 5, 63, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.369'),
(1047, 1047, 7, 1, 5, 63, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.378'),
(1048, 1048, 7, 1, 5, 63, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.386'),
(1049, 1049, 7, 1, 5, 63, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.395'),
(1050, 1050, 7, 1, 5, 63, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.405'),
(1051, 1051, 7, 1, 5, 63, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.415'),
(1052, 1052, 7, 1, 5, 63, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.423'),
(1053, 1053, 7, 1, 5, 63, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.433'),
(1054, 1054, 7, 1, 5, 64, 130, 0, NULL, NULL, '2026-07-11 03:32:07.448'),
(1055, 1055, 7, 1, 5, 65, 131, 0, NULL, NULL, '2026-07-11 03:32:07.464'),
(1056, 1056, 7, 1, 5, 66, 132, 0, NULL, NULL, '2026-07-11 03:32:07.478'),
(1057, 1057, 7, 1, 5, 67, 133, 0, NULL, NULL, '2026-07-11 03:32:07.489'),
(1058, 1058, 8, 1, 5, 68, 134, 0, NULL, NULL, '2026-07-11 03:32:07.508'),
(1059, 1059, 8, 1, 5, 69, 135, 0, NULL, NULL, '2026-07-11 03:32:07.520'),
(1060, 1060, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.530'),
(1061, 1061, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.539'),
(1062, 1062, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.548'),
(1063, 1063, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.556'),
(1064, 1064, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.566'),
(1065, 1065, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.576'),
(1066, 1066, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.584'),
(1067, 1067, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.593'),
(1068, 1068, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.601'),
(1069, 1069, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.610'),
(1070, 1070, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.618'),
(1071, 1071, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.627'),
(1072, 1072, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.635'),
(1073, 1073, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.643'),
(1074, 1074, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.652'),
(1075, 1075, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.661'),
(1076, 1076, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.670'),
(1077, 1077, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.679'),
(1078, 1078, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.688'),
(1079, 1079, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.699'),
(1080, 1080, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.709'),
(1081, 1081, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.717'),
(1082, 1082, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.727'),
(1083, 1083, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.737'),
(1084, 1084, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.749'),
(1085, 1085, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.759'),
(1086, 1086, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.768'),
(1087, 1087, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.777'),
(1088, 1088, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.785'),
(1089, 1089, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.793'),
(1090, 1090, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.803'),
(1091, 1091, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.814'),
(1092, 1092, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.824'),
(1093, 1093, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.833'),
(1094, 1094, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.842'),
(1095, 1095, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.850'),
(1096, 1096, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.859'),
(1097, 1097, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.868'),
(1098, 1098, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.880'),
(1099, 1099, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.888'),
(1100, 1100, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.898'),
(1101, 1101, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.909'),
(1102, 1102, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.919'),
(1103, 1103, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.928'),
(1104, 1104, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.936'),
(1105, 1105, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.944'),
(1106, 1106, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.953'),
(1107, 1107, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.963'),
(1108, 1108, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.972'),
(1109, 1109, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.981'),
(1110, 1110, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.989'),
(1111, 1111, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:07.998'),
(1112, 1112, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.008'),
(1113, 1113, 8, 1, 5, 69, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.017'),
(1114, 1114, 8, 1, 5, 70, 136, 0, NULL, NULL, '2026-07-11 03:32:08.029'),
(1115, 1115, 8, 1, 5, 70, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.037'),
(1116, 1116, 8, 1, 5, 70, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.045'),
(1117, 1117, 8, 1, 5, 70, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.052'),
(1118, 1118, 8, 1, 5, 70, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.060'),
(1119, 1119, 8, 1, 5, 71, 137, 0, NULL, NULL, '2026-07-11 03:32:08.070'),
(1120, 1120, 8, 1, 5, 72, 138, 0, NULL, NULL, '2026-07-11 03:32:08.082'),
(1121, 1121, 8, 1, 5, 72, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.097'),
(1122, 1122, 8, 1, 5, 72, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.107'),
(1123, 1123, 8, 1, 5, 72, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.117'),
(1124, 1124, 8, 1, 5, 72, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.129'),
(1125, 1125, 8, 1, 5, 72, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.142'),
(1126, 1126, 8, 1, 5, 72, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.153'),
(1127, 1127, 8, 1, 5, 72, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.166'),
(1128, 1128, 8, 1, 5, 72, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.180'),
(1129, 1129, 8, 1, 5, 72, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.189'),
(1130, 1130, 8, 1, 5, 72, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.204'),
(1131, 1131, 8, 1, 5, 72, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.216'),
(1132, 1132, 8, 1, 5, 72, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.225'),
(1133, 1133, 8, 1, 5, 72, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.236'),
(1134, 1134, 8, 1, 5, 72, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.249'),
(1135, 1135, 8, 1, 5, 72, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.258'),
(1136, 1136, 8, 1, 5, 72, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.267'),
(1137, 1137, 8, 1, 5, 72, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.276'),
(1138, 1138, 8, 1, 5, 72, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.290'),
(1139, 1139, 8, 1, 5, 72, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.301'),
(1140, 1140, 8, 1, 5, 72, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.312'),
(1141, 1141, 8, 1, 5, 72, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.328'),
(1142, 1142, 8, 1, 5, 72, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.343'),
(1143, 1143, 8, 1, 5, 72, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.364'),
(1144, 1144, 8, 1, 5, 72, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.381'),
(1145, 1145, 8, 1, 5, 72, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.396'),
(1146, 1146, 8, 1, 5, 72, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.409'),
(1147, 1147, 8, 1, 5, 72, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.416'),
(1148, 1148, 8, 1, 5, 72, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.425'),
(1149, 1149, 8, 1, 5, 72, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.432'),
(1150, 1150, 8, 1, 5, 72, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.443'),
(1151, 1151, 8, 1, 5, 72, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.450'),
(1152, 1152, 8, 1, 5, 72, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.458'),
(1153, 1153, 5, 1, 5, 73, 139, 0, NULL, NULL, '2026-07-11 03:32:08.468'),
(1154, 1154, 5, 1, 5, 73, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.478'),
(1155, 1155, 5, 1, 5, 73, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.490'),
(1156, 1156, 5, 1, 5, 73, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.500'),
(1157, 1157, 5, 1, 5, 73, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.509'),
(1158, 1158, 5, 1, 5, 73, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.517'),
(1159, 1159, 5, 1, 5, 74, 140, 0, NULL, NULL, '2026-07-11 03:32:08.528'),
(1160, 1160, 5, 1, 5, 74, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.536'),
(1161, 1161, 5, 1, 5, 74, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.544'),
(1162, 1162, 5, 1, 5, 74, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.553'),
(1163, 1163, 5, 1, 5, 74, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.569'),
(1164, 1164, 5, 1, 5, 74, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.614'),
(1165, 1165, 5, 1, 5, 75, 141, 0, NULL, NULL, '2026-07-11 03:32:08.631'),
(1166, 1166, 5, 1, 5, 75, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.644'),
(1167, 1167, 5, 1, 5, 75, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.655'),
(1168, 1168, 5, 1, 5, 75, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.666'),
(1169, 1169, 5, 1, 5, 75, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.675'),
(1170, 1170, 5, 1, 5, 75, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.685'),
(1171, 1171, 5, 1, 5, 75, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.697'),
(1172, 1172, 5, 1, 5, 75, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.705'),
(1173, 1173, 5, 1, 5, 75, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.717'),
(1174, 1174, 5, 1, 5, 76, 142, 0, NULL, NULL, '2026-07-11 03:32:08.730'),
(1175, 1175, 9, 1, 5, 77, 143, 0, NULL, NULL, '2026-07-11 03:32:08.746'),
(1176, 1176, 9, 1, 5, 77, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.754'),
(1177, 1177, 9, 1, 5, 77, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.763'),
(1178, 1178, 9, 1, 5, 77, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.773'),
(1179, 1179, 9, 1, 5, 77, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.782'),
(1180, 1180, 9, 1, 5, 77, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.793'),
(1181, 1181, 9, 1, 5, 77, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.802'),
(1182, 1182, 9, 1, 5, 77, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.812'),
(1183, 1183, 9, 1, 5, 77, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.821'),
(1184, 1184, 9, 1, 5, 77, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.831'),
(1185, 1185, 9, 1, 5, 78, 144, 0, NULL, NULL, '2026-07-11 03:32:08.843'),
(1186, 1186, 9, 1, 5, 78, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.853'),
(1187, 1187, 9, 1, 5, 78, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.864'),
(1188, 1188, 9, 1, 5, 78, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.875'),
(1189, 1189, 9, 1, 5, 78, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.884'),
(1190, 1190, 9, 1, 5, 78, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.895'),
(1191, 1191, 9, 1, 5, 78, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.907'),
(1192, 1192, 9, 1, 5, 78, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.917'),
(1193, 1193, 9, 1, 5, 78, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.927'),
(1194, 1194, 9, 1, 5, 78, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.935'),
(1195, 1195, 9, 1, 5, 78, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.944'),
(1196, 1196, 9, 1, 5, 78, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.955'),
(1197, 1197, 9, 1, 5, 78, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.965'),
(1198, 1198, 9, 1, 5, 78, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.975'),
(1199, 1199, 9, 1, 5, 78, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.983'),
(1200, 1200, 9, 1, 5, 78, NULL, 0, NULL, NULL, '2026-07-11 03:32:08.993'),
(1201, 1201, 9, 1, 5, 78, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.004'),
(1202, 1202, 9, 1, 5, 78, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.015'),
(1203, 1203, 9, 1, 5, 78, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.024'),
(1204, 1204, 9, 1, 5, 78, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.032'),
(1205, 1205, 9, 1, 5, 78, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.040'),
(1206, 1206, 9, 1, 5, 78, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.048'),
(1207, 1207, 9, 1, 5, 78, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.059'),
(1208, 1208, 9, 1, 5, 78, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.067'),
(1209, 1209, 9, 1, 5, 78, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.077'),
(1210, 1210, 9, 1, 5, 78, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.086'),
(1211, 1211, 9, 1, 5, 78, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.094'),
(1212, 1212, 9, 1, 5, 78, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.102'),
(1213, 1213, 9, 1, 5, 78, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.110'),
(1214, 1214, 9, 1, 5, 79, 145, 0, NULL, NULL, '2026-07-11 03:32:09.120'),
(1215, 1215, 9, 1, 5, 79, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.128'),
(1216, 1216, 9, 1, 5, 79, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.137'),
(1217, 1217, 9, 1, 5, 79, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.145'),
(1218, 1218, 9, 1, 5, 79, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.153'),
(1219, 1219, 9, 1, 5, 79, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.162'),
(1220, 1220, 9, 1, 5, 79, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.170'),
(1221, 1221, 9, 1, 5, 79, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.179'),
(1222, 1222, 9, 1, 5, 79, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.187'),
(1223, 1223, 9, 1, 5, 79, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.198'),
(1224, 1224, 9, 1, 5, 79, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.209'),
(1225, 1225, 9, 1, 5, 79, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.219'),
(1226, 1226, 9, 1, 5, 80, 146, 0, NULL, NULL, '2026-07-11 03:32:09.230'),
(1227, 1227, 9, 1, 5, 80, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.242'),
(1228, 1228, 9, 1, 5, 80, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.250'),
(1229, 1229, 9, 1, 5, 80, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.261'),
(1230, 1230, 9, 1, 5, 80, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.271'),
(1231, 1231, 9, 1, 5, 80, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.281'),
(1232, 1232, 9, 1, 5, 80, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.290'),
(1233, 1233, 9, 1, 5, 80, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.304'),
(1234, 1234, 9, 1, 5, 80, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.315'),
(1235, 1235, 9, 1, 5, 80, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.326'),
(1236, 1236, 9, 1, 5, 80, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.334'),
(1237, 1237, 9, 1, 5, 80, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.344'),
(1238, 1238, 9, 1, 5, 80, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.354'),
(1239, 1239, 9, 1, 5, 80, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.364'),
(1240, 1240, 9, 1, 5, 80, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.376'),
(1241, 1241, 9, 1, 5, 80, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.390'),
(1242, 1242, 9, 1, 5, 80, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.400'),
(1243, 1243, 9, 1, 5, 80, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.413'),
(1244, 1244, 9, 1, 5, 80, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.426'),
(1245, 1245, 9, 1, 5, 81, 147, 0, NULL, NULL, '2026-07-11 03:32:09.442'),
(1246, 1246, 9, 1, 5, 81, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.453'),
(1247, 1247, 9, 1, 5, 81, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.465'),
(1248, 1248, 9, 1, 5, 81, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.477'),
(1249, 1249, 9, 1, 5, 81, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.488'),
(1250, 1250, 9, 1, 5, 81, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.499'),
(1251, 1251, 9, 1, 5, 81, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.513'),
(1252, 1252, 9, 1, 5, 81, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.524'),
(1253, 1253, 9, 1, 5, 81, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.535'),
(1254, 1254, 9, 1, 5, 81, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.546'),
(1255, 1255, 9, 1, 5, 81, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.559'),
(1256, 1256, 9, 1, 5, 81, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.572'),
(1257, 1257, 9, 1, 5, 81, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.584'),
(1258, 1258, 9, 1, 5, 81, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.599'),
(1259, 1259, 9, 1, 5, 81, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.611'),
(1260, 1260, 9, 1, 5, 81, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.620'),
(1261, 1261, 9, 1, 5, 81, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.633'),
(1262, 1262, 9, 1, 5, 81, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.647'),
(1263, 1263, 9, 1, 5, 81, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.665'),
(1264, 1264, 9, 1, 5, 81, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.679'),
(1265, 1265, 9, 1, 5, 81, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.688'),
(1266, 1266, 10, 1, 5, 82, 148, 0, NULL, NULL, '2026-07-11 03:32:09.704'),
(1267, 1267, 10, 1, 5, 83, 149, 0, NULL, NULL, '2026-07-11 03:32:09.721'),
(1268, 1268, 10, 1, 5, 83, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.732'),
(1269, 1269, 10, 1, 5, 83, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.744'),
(1270, 1270, 10, 1, 5, 83, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.754'),
(1271, 1271, 10, 1, 5, 83, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.771'),
(1272, 1272, 10, 1, 5, 83, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.798'),
(1273, 1273, 10, 1, 5, 83, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.810'),
(1274, 1274, 10, 1, 5, 83, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.823'),
(1275, 1275, 10, 1, 5, 83, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.837'),
(1276, 1276, 10, 1, 5, 83, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.856'),
(1277, 1277, 10, 1, 5, 83, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.866'),
(1278, 1278, 10, 1, 5, 83, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.879'),
(1279, 1279, 10, 1, 5, 83, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.892'),
(1280, 1280, 10, 1, 5, 84, 150, 0, NULL, NULL, '2026-07-11 03:32:09.906'),
(1281, 1281, 10, 1, 5, 84, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.916'),
(1282, 1282, 10, 1, 5, 84, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.931'),
(1283, 1283, 10, 1, 5, 84, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.941'),
(1284, 1284, 10, 1, 5, 84, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.950'),
(1285, 1285, 10, 1, 5, 84, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.962'),
(1286, 1286, 10, 1, 5, 84, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.971'),
(1287, 1287, 10, 1, 5, 84, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.981'),
(1288, 1288, 10, 1, 5, 84, NULL, 0, NULL, NULL, '2026-07-11 03:32:09.991'),
(1289, 1289, 10, 1, 5, 85, 151, 0, NULL, NULL, '2026-07-11 03:32:10.006'),
(1290, 1290, 10, 1, 5, 85, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.021'),
(1291, 1291, 10, 1, 5, 85, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.031'),
(1292, 1292, 10, 1, 5, 85, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.046'),
(1293, 1293, 10, 1, 5, 85, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.054'),
(1294, 1294, 10, 1, 5, 85, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.061'),
(1295, 1295, 10, 1, 5, 85, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.068'),
(1296, 1296, 10, 1, 5, 85, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.076'),
(1297, 1297, 10, 1, 5, 85, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.085'),
(1298, 1298, 10, 1, 5, 85, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.093'),
(1299, 1299, 10, 1, 5, 85, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.104'),
(1300, 1300, 10, 1, 5, 85, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.117'),
(1301, 1301, 10, 1, 5, 85, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.127'),
(1302, 1302, 10, 1, 5, 85, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.139'),
(1303, 1303, 10, 1, 5, 85, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.148'),
(1304, 1304, 10, 1, 5, 85, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.160'),
(1305, 1305, 10, 1, 5, 85, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.168'),
(1306, 1306, 10, 1, 5, 85, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.177'),
(1307, 1307, 10, 1, 5, 85, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.187'),
(1308, 1308, 10, 1, 5, 85, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.197'),
(1309, 1309, 10, 1, 5, 85, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.205'),
(1310, 1310, 10, 1, 5, 85, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.218'),
(1311, 1311, 10, 1, 5, 85, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.227'),
(1312, 1312, 10, 1, 5, 85, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.235'),
(1313, 1313, 10, 1, 5, 85, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.244'),
(1314, 1314, 10, 1, 5, 85, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.253'),
(1315, 1315, 10, 1, 5, 85, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.261'),
(1316, 1316, 10, 1, 5, 85, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.268'),
(1317, 1317, 10, 1, 5, 85, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.277'),
(1318, 1318, 10, 1, 5, 85, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.285'),
(1319, 1319, 10, 1, 5, 85, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.293'),
(1320, 1320, 10, 1, 5, 86, 152, 0, NULL, NULL, '2026-07-11 03:32:10.305'),
(1321, 1321, 10, 1, 5, 86, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.315'),
(1322, 1322, 10, 1, 5, 86, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.324'),
(1323, 1323, 10, 1, 5, 86, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.333'),
(1324, 1324, 10, 1, 5, 86, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.342'),
(1325, 1325, 10, 1, 5, 86, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.350'),
(1326, 1326, 10, 1, 5, 86, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.362'),
(1327, 1327, 10, 1, 5, 86, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.372'),
(1328, 1328, 10, 1, 5, 86, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.388'),
(1329, 1329, 10, 1, 5, 86, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.397'),
(1330, 1330, 10, 1, 5, 86, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.407'),
(1331, 1331, 10, 1, 5, 86, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.417'),
(1332, 1332, 10, 1, 5, 86, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.429'),
(1333, 1333, 10, 1, 5, 86, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.439'),
(1334, 1334, 10, 1, 5, 86, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.450'),
(1335, 1335, 10, 1, 5, 86, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.459'),
(1336, 1336, 10, 1, 5, 86, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.468'),
(1337, 1337, 10, 1, 5, 86, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.479'),
(1338, 1338, 10, 1, 5, 86, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.490'),
(1339, 1339, 10, 1, 5, 86, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.502'),
(1340, 1340, 10, 1, 5, 86, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.512'),
(1341, 1341, 10, 1, 5, 86, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.520'),
(1342, 1342, 10, 1, 5, 86, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.533'),
(1343, 1343, 10, 1, 5, 86, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.545'),
(1344, 1344, 10, 1, 5, 86, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.557'),
(1345, 1345, 10, 1, 5, 86, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.567'),
(1346, 1346, 10, 1, 5, 86, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.578'),
(1347, 1347, 10, 1, 5, 86, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.587'),
(1348, 1348, 10, 1, 5, 86, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.598'),
(1349, 1349, 10, 1, 5, 86, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.608'),
(1350, 1350, 10, 1, 5, 86, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.618'),
(1351, 1351, 10, 1, 5, 86, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.627'),
(1352, 1352, NULL, 2, NULL, 87, 153, 0, NULL, NULL, '2026-07-11 03:32:10.637'),
(1353, 1353, NULL, 2, NULL, 87, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.647'),
(1354, 1354, NULL, 2, NULL, 87, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.655'),
(1355, 1355, NULL, 2, NULL, 87, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.664'),
(1356, 1356, NULL, 2, NULL, 87, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.673'),
(1357, 1357, NULL, 2, NULL, 87, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.684'),
(1358, 1358, NULL, 2, NULL, 87, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.692'),
(1359, 1359, NULL, 2, NULL, 87, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.702'),
(1360, 1360, 12, 1, 5, 88, 154, 0, NULL, NULL, '2026-07-11 03:32:10.710'),
(1361, 1361, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.718'),
(1362, 1362, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.727'),
(1363, 1363, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.737'),
(1364, 1364, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.746'),
(1365, 1365, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.753'),
(1366, 1366, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.760'),
(1367, 1367, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.768');
INSERT INTO `hardcopy_documents` (`hardcopy_id`, `document_id`, `asset_id`, `area_id`, `specific_id`, `location_id`, `sequence_id`, `retention_enabled`, `retention_start_date`, `retention_end_date`, `created_at`) VALUES
(1368, 1368, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.777'),
(1369, 1369, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.785'),
(1370, 1370, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.794'),
(1371, 1371, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.801'),
(1372, 1372, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.810'),
(1373, 1373, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.821'),
(1374, 1374, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.830'),
(1375, 1375, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.838'),
(1376, 1376, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.846'),
(1377, 1377, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.854'),
(1378, 1378, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.865'),
(1379, 1379, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.877'),
(1380, 1380, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.884'),
(1381, 1381, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.893'),
(1382, 1382, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.900'),
(1383, 1383, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.911'),
(1384, 1384, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.919'),
(1385, 1385, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.928'),
(1386, 1386, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.941'),
(1387, 1387, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.957'),
(1388, 1388, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.966'),
(1389, 1389, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.975'),
(1390, 1390, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.986'),
(1391, 1391, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:10.995'),
(1392, 1392, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.005'),
(1393, 1393, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.032'),
(1394, 1394, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.039'),
(1395, 1395, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.053'),
(1396, 1396, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.063'),
(1397, 1397, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.077'),
(1398, 1398, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.086'),
(1399, 1399, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.095'),
(1400, 1400, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.104'),
(1401, 1401, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.114'),
(1402, 1402, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.124'),
(1403, 1403, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.133'),
(1404, 1404, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.142'),
(1405, 1405, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.151'),
(1406, 1406, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.162'),
(1407, 1407, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.172'),
(1408, 1408, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.186'),
(1409, 1409, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.206'),
(1410, 1410, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.218'),
(1411, 1411, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.228'),
(1412, 1412, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.238'),
(1413, 1413, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.250'),
(1414, 1414, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.261'),
(1415, 1415, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.271'),
(1416, 1416, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.283'),
(1417, 1417, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.293'),
(1418, 1418, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.305'),
(1419, 1419, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.317'),
(1420, 1420, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.330'),
(1421, 1421, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.343'),
(1422, 1422, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.357'),
(1423, 1423, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.374'),
(1424, 1424, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.387'),
(1425, 1425, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.410'),
(1426, 1426, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.425'),
(1427, 1427, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.444'),
(1428, 1428, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.460'),
(1429, 1429, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.472'),
(1430, 1430, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.487'),
(1431, 1431, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.497'),
(1432, 1432, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.515'),
(1433, 1433, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.524'),
(1434, 1434, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.547'),
(1435, 1435, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.562'),
(1436, 1436, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.576'),
(1437, 1437, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.589'),
(1438, 1438, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.602'),
(1439, 1439, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.617'),
(1440, 1440, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.629'),
(1441, 1441, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.641'),
(1442, 1442, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.660'),
(1443, 1443, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.671'),
(1444, 1444, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.692'),
(1445, 1445, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.703'),
(1446, 1446, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.713'),
(1447, 1447, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.729'),
(1448, 1448, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.739'),
(1449, 1449, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.757'),
(1450, 1450, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.767'),
(1451, 1451, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.777'),
(1452, 1452, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.793'),
(1453, 1453, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.803'),
(1454, 1454, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.811'),
(1455, 1455, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.825'),
(1456, 1456, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.832'),
(1457, 1457, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.842'),
(1458, 1458, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.851'),
(1459, 1459, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.860'),
(1460, 1460, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.869'),
(1461, 1461, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.877'),
(1462, 1462, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.885'),
(1463, 1463, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.893'),
(1464, 1464, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.902'),
(1465, 1465, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.911'),
(1466, 1466, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.919'),
(1467, 1467, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.928'),
(1468, 1468, 12, 1, 5, 88, NULL, 0, NULL, NULL, '2026-07-11 03:32:11.936'),
(1469, 1469, 8, 1, 5, 70, NULL, 0, NULL, NULL, '2026-07-17 03:35:59.588'),
(1470, 1470, 8, 1, 5, 70, NULL, 0, NULL, NULL, '2026-07-17 07:06:30.880'),
(1471, 1471, NULL, 4, 8, 49, 3, 0, NULL, NULL, '2026-08-22 08:03:33.059'),
(1472, 1472, NULL, 4, 8, 49, 3, 0, NULL, NULL, '2026-08-22 08:07:30.251'),
(1473, 1476, NULL, 3, 7, 51, NULL, 0, NULL, NULL, '2026-09-17 00:16:28.997'),
(1474, 1479, NULL, 1, 5, 32, NULL, 0, NULL, NULL, '2026-09-19 00:46:04.097'),
(1475, 1480, NULL, 1, 5, 40, 106, 0, NULL, NULL, '2026-09-19 05:57:15.119');

-- --------------------------------------------------------

--
-- Table structure for table `hardcopy_transfer_history`
--

CREATE TABLE `hardcopy_transfer_history` (
  `transfer_history_id` bigint(20) NOT NULL,
  `transfer_request_id` bigint(20) NOT NULL,
  `action` varchar(40) NOT NULL,
  `previous_status` enum('Draft','ForApproval','Approved','ForTransfer','Transferred','PendingRecipientAcceptance','Completed','Returned','Rejected','Cancelled') DEFAULT NULL,
  `new_status` enum('Draft','ForApproval','Approved','ForTransfer','Transferred','PendingRecipientAcceptance','Completed','Returned','Rejected','Cancelled') NOT NULL,
  `performed_by_user_id` bigint(20) NOT NULL,
  `comments` text DEFAULT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hardcopy_transfer_requests`
--

CREATE TABLE `hardcopy_transfer_requests` (
  `transfer_request_id` bigint(20) NOT NULL,
  `document_id` bigint(20) NOT NULL,
  `hardcopy_id` bigint(20) NOT NULL,
  `from_area_id` bigint(20) DEFAULT NULL,
  `from_specific_id` bigint(20) DEFAULT NULL,
  `from_asset_id` bigint(20) DEFAULT NULL,
  `from_location_id` bigint(20) DEFAULT NULL,
  `from_sequence_id` bigint(20) DEFAULT NULL,
  `destination_area_id` bigint(20) DEFAULT NULL,
  `destination_specific_id` bigint(20) DEFAULT NULL,
  `destination_asset_id` bigint(20) DEFAULT NULL,
  `destination_location_id` bigint(20) DEFAULT NULL,
  `destination_sequence_id` bigint(20) DEFAULT NULL,
  `document_copy_number` varchar(100) DEFAULT NULL,
  `current_holder` varchar(220) DEFAULT NULL,
  `transfer_to` varchar(220) DEFAULT NULL,
  `requested_by_user_id` bigint(20) NOT NULL,
  `reason` text NOT NULL,
  `approver_user_id` bigint(20) DEFAULT NULL,
  `approval_date` datetime(3) DEFAULT NULL,
  `workflow_version_id` bigint(20) DEFAULT NULL,
  `workflow_version` int(11) DEFAULT NULL,
  `workflow_name` varchar(150) DEFAULT NULL,
  `workflow_snapshot` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`workflow_snapshot`)),
  `current_workflow_step_id` bigint(20) DEFAULT NULL,
  `transfer_date` datetime(3) DEFAULT NULL,
  `assigned_recipient_user_id` bigint(20) NOT NULL,
  `recipient_acceptance` enum('PENDING','ACCEPTED','REFUSED') NOT NULL DEFAULT 'PENDING',
  `accepted_by_user_id` bigint(20) DEFAULT NULL,
  `acceptance_at` datetime(3) DEFAULT NULL,
  `comments` text DEFAULT NULL,
  `status` enum('Draft','ForApproval','Approved','ForTransfer','Transferred','PendingRecipientAcceptance','Completed','Returned','Rejected','Cancelled') NOT NULL DEFAULT 'Draft',
  `created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updated_at` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hardcopy_transfer_workflow_history`
--

CREATE TABLE `hardcopy_transfer_workflow_history` (
  `workflow_history_id` bigint(20) NOT NULL,
  `workflow_step_id` bigint(20) NOT NULL,
  `previous_status` enum('QUEUED','PENDING','APPROVED','RETURNED','REJECTED') DEFAULT NULL,
  `new_status` enum('QUEUED','PENDING','APPROVED','RETURNED','REJECTED') NOT NULL,
  `action` varchar(40) NOT NULL,
  `performed_by_user_id` bigint(20) NOT NULL,
  `comments` text DEFAULT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hardcopy_transfer_workflow_steps`
--

CREATE TABLE `hardcopy_transfer_workflow_steps` (
  `workflow_step_id` bigint(20) NOT NULL,
  `transfer_request_id` bigint(20) NOT NULL,
  `node_key` varchar(100) NOT NULL,
  `sequence` int(11) NOT NULL,
  `stage` varchar(60) NOT NULL,
  `stage_label` varchar(150) NOT NULL,
  `assignment_type` varchar(30) DEFAULT NULL,
  `assignment_source` varchar(50) DEFAULT NULL,
  `assigned_user_id` bigint(20) NOT NULL,
  `assigned_role_id` bigint(20) DEFAULT NULL,
  `assigned_user_name_snapshot` varchar(255) NOT NULL,
  `assigned_position_title_snapshot` varchar(150) DEFAULT NULL,
  `status` enum('QUEUED','PENDING','APPROVED','RETURNED','REJECTED') NOT NULL DEFAULT 'QUEUED',
  `decision` varchar(30) DEFAULT NULL,
  `comments` text DEFAULT NULL,
  `acted_by_user_id` bigint(20) DEFAULT NULL,
  `acted_at` datetime(3) DEFAULT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE `locations` (
  `location_id` bigint(20) NOT NULL,
  `location_name` varchar(150) NOT NULL,
  `location_code` varchar(20) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `archived_at` datetime(3) DEFAULT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updated_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `asset_id` bigint(20) DEFAULT NULL,
  `specific_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` (`location_id`, `location_name`, `location_code`, `is_active`, `archived_at`, `created_at`, `updated_at`, `asset_id`, `specific_id`) VALUES
(5, 'Production Archive', 'A', 0, '2026-07-10 08:37:13.973', '2026-07-10 08:32:17.347', '2026-07-10 08:37:13.975', NULL, NULL),
(6, 'QA Records Room', 'B', 0, '2026-07-10 08:37:10.075', '2026-07-10 08:32:17.362', '2026-07-10 08:37:10.076', NULL, NULL),
(7, 'HR Cabinet', 'C', 0, '2026-07-10 08:37:06.504', '2026-07-10 08:32:17.370', '2026-07-10 08:37:06.509', NULL, NULL),
(8, 'Maintenance Office', 'D', 0, '2026-07-10 08:37:00.702', '2026-07-10 08:32:17.380', '2026-07-10 08:37:00.707', NULL, NULL),
(9, 'A', 'E', 1, NULL, '2026-07-11 03:31:54.597', '2026-08-12 13:43:44.989', NULL, NULL),
(10, 'B', 'F', 1, NULL, '2026-07-11 03:31:54.938', '2026-08-12 13:43:44.990', NULL, NULL),
(11, 'C', 'G', 1, NULL, '2026-07-11 03:31:55.115', '2026-08-12 13:43:44.990', NULL, NULL),
(12, 'D', 'H', 1, NULL, '2026-07-11 03:31:55.404', '2026-08-12 13:43:44.990', NULL, NULL),
(13, 'E', 'I', 1, NULL, '2026-07-11 03:31:55.588', '2026-08-12 13:43:44.990', NULL, NULL),
(14, 'J', 'J', 1, NULL, '2026-07-11 03:31:55.671', '2026-08-12 13:43:44.990', NULL, NULL),
(15, 'S', 'K', 1, NULL, '2026-07-11 03:31:55.760', '2026-08-12 13:43:44.989', NULL, NULL),
(16, 'T', 'L', 1, NULL, '2026-07-11 03:31:55.784', '2026-08-12 13:43:44.989', NULL, NULL),
(17, 'U', 'M', 1, NULL, '2026-07-11 03:31:56.003', '2026-08-12 13:43:44.990', NULL, NULL),
(18, 'V', 'N', 1, NULL, '2026-07-11 03:31:56.160', '2026-07-11 06:08:30.089', NULL, NULL),
(19, 'Y', 'O', 1, NULL, '2026-07-11 03:31:56.171', '2026-08-15 03:11:26.409', NULL, NULL),
(20, 'AA', 'P', 1, NULL, '2026-07-11 03:31:56.688', '2026-08-12 13:43:44.991', NULL, NULL),
(21, 'AC', 'Q', 1, NULL, '2026-07-11 03:31:56.911', '2026-08-12 13:43:44.991', NULL, NULL),
(22, 'AF', 'R', 1, NULL, '2026-07-11 03:31:56.925', '2026-08-12 13:43:44.989', NULL, NULL),
(23, 'AG', 'S', 1, NULL, '2026-07-11 03:31:57.024', '2026-08-12 13:43:44.990', NULL, NULL),
(24, 'AH', 'T', 1, NULL, '2026-07-11 03:31:57.049', '2026-08-12 13:43:44.990', NULL, NULL),
(25, 'AI', 'U', 1, NULL, '2026-07-11 03:31:57.094', '2026-08-12 13:43:44.990', NULL, NULL),
(26, 'AO', 'V', 1, NULL, '2026-07-11 03:31:57.167', '2026-07-11 06:08:30.167', NULL, NULL),
(27, 'AP', 'W', 1, NULL, '2026-07-11 03:31:57.180', '2026-07-11 06:08:30.180', NULL, NULL),
(28, 'AQ', 'X', 1, NULL, '2026-07-11 03:31:57.212', '2026-07-11 06:08:30.187', NULL, NULL),
(29, 'UNSPECIFIED LOCATION', 'Y', 1, NULL, '2026-07-11 03:31:57.295', '2026-07-11 06:08:30.198', NULL, NULL),
(30, 'AR', 'Z', 1, NULL, '2026-07-11 03:31:57.306', '2026-07-11 06:08:30.206', NULL, NULL),
(31, 'AS', 'AA', 1, NULL, '2026-07-11 03:31:57.371', '2026-07-11 06:08:30.216', NULL, NULL),
(32, 'AT', 'AB', 1, NULL, '2026-07-11 03:31:57.535', '2026-07-11 06:08:30.227', NULL, NULL),
(33, 'AU', 'AC', 1, NULL, '2026-07-11 03:31:57.551', '2026-07-11 06:08:30.238', NULL, NULL),
(34, 'AV', 'AD', 1, NULL, '2026-07-11 03:31:57.579', '2026-07-11 06:08:30.245', NULL, NULL),
(35, 'AW', 'AE', 1, NULL, '2026-07-11 03:31:57.589', '2026-07-11 06:08:30.251', NULL, NULL),
(36, 'AX', 'AF', 1, NULL, '2026-07-11 03:31:57.602', '2026-07-11 06:08:30.257', NULL, NULL),
(37, 'AY', 'AG', 1, NULL, '2026-07-11 03:31:57.611', '2026-07-11 06:08:30.268', NULL, NULL),
(38, 'AZ', 'AH', 1, NULL, '2026-07-11 03:31:57.620', '2026-08-12 13:43:44.990', NULL, NULL),
(39, 'BA', 'AI', 1, NULL, '2026-07-11 03:31:58.694', '2026-07-11 06:08:30.284', NULL, NULL),
(40, 'BC', 'AJ', 1, NULL, '2026-07-11 03:31:58.834', '2026-07-11 06:08:30.291', NULL, NULL),
(41, 'BE', 'AK', 1, NULL, '2026-07-11 03:31:58.848', '2026-07-11 06:08:30.299', NULL, NULL),
(42, 'BF', 'AL', 1, NULL, '2026-07-11 03:31:59.232', '2026-07-11 06:08:30.307', NULL, NULL),
(43, 'BG', 'AM', 1, NULL, '2026-07-11 03:31:59.571', '2026-07-11 06:08:30.313', NULL, NULL),
(44, 'BH', 'AN', 1, NULL, '2026-07-11 03:32:00.121', '2026-07-11 06:08:30.320', NULL, NULL),
(45, 'BU', 'AO', 1, NULL, '2026-07-11 03:32:00.348', '2026-07-11 06:08:30.330', NULL, NULL),
(46, 'BV', 'AP', 1, NULL, '2026-07-11 03:32:00.431', '2026-07-11 06:08:30.341', NULL, NULL),
(47, 'BW', 'AQ', 1, NULL, '2026-07-11 03:32:00.472', '2026-07-11 06:08:30.348', NULL, NULL),
(48, 'BX', 'AR', 1, NULL, '2026-07-11 03:32:01.138', '2026-07-11 06:08:30.354', NULL, NULL),
(49, 'CC', 'AS', 1, NULL, '2026-07-11 03:32:02.178', '2026-08-20 02:14:07.158', NULL, NULL),
(50, 'CI', 'AT', 1, NULL, '2026-07-11 03:32:02.625', '2026-07-11 06:08:30.369', NULL, NULL),
(51, 'DD', 'AU', 1, NULL, '2026-07-11 03:32:02.784', '2026-08-15 03:55:21.162', NULL, NULL),
(52, 'CY', 'AV', 1, NULL, '2026-07-11 03:32:04.172', '2026-07-11 06:08:30.386', NULL, NULL),
(53, 'CZ', 'AW', 1, NULL, '2026-07-11 03:32:04.255', '2026-07-11 06:08:30.394', NULL, NULL),
(54, 'DA', 'AX', 1, NULL, '2026-07-11 03:32:04.301', '2026-07-11 06:08:30.402', NULL, NULL),
(55, 'DB', 'AY', 1, NULL, '2026-07-11 03:32:04.314', '2026-07-11 06:08:30.407', NULL, NULL),
(56, 'DE', 'AZ', 1, NULL, '2026-07-11 03:32:04.336', '2026-07-11 06:08:30.413', NULL, NULL),
(57, 'DF', 'BA', 1, NULL, '2026-07-11 03:32:05.201', '2026-07-11 06:08:30.424', NULL, NULL),
(58, 'DH', 'BB', 1, NULL, '2026-07-11 03:32:05.419', '2026-08-12 13:43:44.989', NULL, NULL),
(59, 'DI/DJ', 'BC', 1, NULL, '2026-07-11 03:32:05.808', '2026-08-12 13:43:44.989', NULL, NULL),
(60, 'DK', 'BD', 1, NULL, '2026-07-11 03:32:06.894', '2026-08-12 13:43:44.990', NULL, NULL),
(61, 'DL', 'BE', 1, NULL, '2026-07-11 03:32:06.906', '2026-08-12 13:43:44.990', NULL, NULL),
(62, 'DM', 'BF', 1, NULL, '2026-07-11 03:32:06.918', '2026-08-12 13:43:44.990', NULL, NULL),
(63, 'DN', 'BG', 1, NULL, '2026-07-11 03:32:06.928', '2026-08-12 13:43:44.990', NULL, NULL),
(64, 'DO', 'BH', 1, NULL, '2026-07-11 03:32:07.442', '2026-08-12 13:43:44.990', NULL, NULL),
(65, 'DP', 'BI', 1, NULL, '2026-07-11 03:32:07.460', '2026-08-12 13:43:44.990', NULL, NULL),
(66, 'DQ', 'BJ', 1, NULL, '2026-07-11 03:32:07.470', '2026-08-12 13:43:44.990', NULL, NULL),
(67, 'DR', 'BK', 1, NULL, '2026-07-11 03:32:07.485', '2026-08-12 13:43:44.990', NULL, NULL),
(68, 'DS', 'BL', 1, NULL, '2026-07-11 03:32:07.498', '2026-08-12 13:43:44.990', NULL, NULL),
(69, 'DT', 'BM', 1, NULL, '2026-07-11 03:32:07.516', '2026-08-12 13:43:44.990', NULL, NULL),
(70, 'DU', 'BN', 1, NULL, '2026-07-11 03:32:08.024', '2026-08-12 13:43:44.990', NULL, NULL),
(71, 'DV', 'BO', 1, NULL, '2026-07-11 03:32:08.067', '2026-08-12 13:43:44.990', NULL, NULL),
(72, 'DW', 'BP', 1, NULL, '2026-07-11 03:32:08.078', '2026-08-12 13:43:44.990', NULL, NULL),
(73, 'DX', 'BQ', 1, NULL, '2026-07-11 03:32:08.465', '2026-08-12 13:43:44.990', NULL, NULL),
(74, 'DY', 'BR', 1, NULL, '2026-07-11 03:32:08.525', '2026-08-12 13:43:44.992', NULL, NULL),
(75, 'DZ', 'BS', 1, NULL, '2026-07-11 03:32:08.625', '2026-08-12 13:43:44.990', NULL, NULL),
(76, 'EA', 'BT', 1, NULL, '2026-07-11 03:32:08.725', '2026-08-12 13:43:44.990', NULL, NULL),
(77, 'EB', 'BU', 1, NULL, '2026-07-11 03:32:08.740', '2026-08-12 13:43:44.990', NULL, NULL),
(78, 'EC', 'BV', 1, NULL, '2026-07-11 03:32:08.839', '2026-08-12 13:43:44.990', NULL, NULL),
(79, 'ED', 'BW', 1, NULL, '2026-07-11 03:32:09.118', '2026-08-12 13:43:44.990', NULL, NULL),
(80, 'EE', 'BX', 1, NULL, '2026-07-11 03:32:09.226', '2026-08-12 13:43:44.990', NULL, NULL),
(81, 'EF', 'BY', 1, NULL, '2026-07-11 03:32:09.434', '2026-08-12 13:43:44.990', NULL, NULL),
(82, 'EG', 'BZ', 1, NULL, '2026-07-11 03:32:09.698', '2026-08-12 13:43:44.990', NULL, NULL),
(83, 'EH', 'CA', 1, NULL, '2026-07-11 03:32:09.716', '2026-08-12 13:43:44.990', NULL, NULL),
(84, 'EI', 'CB', 1, NULL, '2026-07-11 03:32:09.901', '2026-08-12 13:43:44.990', NULL, NULL),
(85, 'EJ', 'CC', 1, NULL, '2026-07-11 03:32:09.998', '2026-08-12 13:43:44.990', NULL, NULL),
(86, 'EK', 'CD', 1, NULL, '2026-07-11 03:32:10.301', '2026-08-12 13:43:44.990', NULL, NULL),
(87, 'DC', 'CE', 1, NULL, '2026-07-11 03:32:10.633', '2026-07-11 06:08:30.643', NULL, NULL),
(88, 'EL', 'CF', 1, NULL, '2026-07-11 03:32:10.708', '2026-08-17 01:00:47.859', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `notification_reads`
--

CREATE TABLE `notification_reads` (
  `notification_read_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `event_key` varchar(180) NOT NULL,
  `read_at` datetime(3) NOT NULL DEFAULT current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `permission_id` bigint(20) NOT NULL,
  `permission_name` varchar(120) NOT NULL,
  `module_key` varchar(100) NOT NULL,
  `module_label` varchar(150) NOT NULL,
  `action_key` varchar(100) NOT NULL,
  `action_label` varchar(150) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`permission_id`, `permission_name`, `module_key`, `module_label`, `action_key`, `action_label`, `description`) VALUES
(91, 'documents.delete', 'documents', 'Documents', 'delete', 'Delete', 'Delete documents.'),
(92, 'documents.import', 'documents', 'Documents', 'import', 'Import', 'Import document records.'),
(93, 'documents.export', 'documents', 'Documents', 'export', 'Export', 'Export document records.'),
(94, 'documents.download', 'documents', 'Documents', 'download', 'Download', 'Download document files.'),
(95, 'storage-classification.edit', 'storage-classification', 'Storage and Classification', 'edit', 'Edit', 'Edit storage and classification records.'),
(96, 'documents.create', 'documents', 'Documents', 'create', 'Create', 'Create documents.'),
(97, 'documents.search', 'documents', 'Documents', 'search', 'Search', 'Search documents.'),
(98, 'storage-classification.delete', 'storage-classification', 'Storage and Classification', 'delete', 'Delete', 'Delete storage and classification records.'),
(99, 'document-disposal.view', 'document-disposal', 'Document Disposal', 'view', 'View', 'View disposed documents.'),
(100, 'storage-classification.manage', 'storage-classification', 'Storage and Classification', 'manage', 'Manage', 'Manage storage and classification catalogs.'),
(101, 'documents.edit', 'documents', 'Documents', 'edit', 'Edit', 'Edit documents.'),
(102, 'document-disposal.dispose', 'document-disposal', 'Document Disposal', 'dispose', 'Dispose', 'Dispose documents.'),
(103, 'location-management.view', 'location-management', 'Location Management', 'view', 'View', 'View locations.'),
(104, 'location-management.manage', 'location-management', 'Location Management', 'manage', 'Manage', 'Manage locations.'),
(105, 'location-management.create', 'location-management', 'Location Management', 'create', 'Create', 'Create locations.'),
(106, 'document-disposal.restore', 'document-disposal', 'Document Disposal', 'restore', 'Restore', 'Restore disposed documents.'),
(107, 'location-management.edit', 'location-management', 'Location Management', 'edit', 'Edit', 'Edit locations.'),
(108, 'document-disposal.manage', 'document-disposal', 'Document Disposal', 'manage', 'Manage', 'Manage document disposal workflows.'),
(109, 'location-management.archive', 'location-management', 'Location Management', 'archive', 'Archive', 'Archive locations.'),
(110, 'documents.dispose', 'documents', 'Documents', 'dispose', 'Dispose', 'Dispose documents.'),
(111, 'activity-logs.view_logs', 'activity-logs', 'Activity Logs', 'view_logs', 'View Logs', 'View activity logs.'),
(112, 'backup-restore.view', 'backup-restore', 'Backup, Restore and Reset', 'view', 'View', 'View backup, restore, and reset pages.'),
(113, 'backup-restore.create_backup', 'backup-restore', 'Backup, Restore and Reset', 'create_backup', 'Create Backup', 'Create backups.'),
(114, 'backup-restore.download_backup', 'backup-restore', 'Backup, Restore and Reset', 'download_backup', 'Download Backup', 'Download backups.'),
(115, 'backup-restore.restore_backup', 'backup-restore', 'Backup, Restore and Reset', 'restore_backup', 'Restore Backup', 'Restore backups.'),
(116, 'backup-restore.reset', 'backup-restore', 'Backup, Restore and Reset', 'reset', 'Factory Reset', 'Back up the system, reset data, and reseed defaults.'),
(117, 'dashboard.view', 'dashboard', 'Dashboard', 'view', 'View', 'View the dashboard module and its authorized summaries.'),
(118, 'backup-restore.delete_backup', 'backup-restore', 'Backup, Restore and Reset', 'delete_backup', 'Delete Backup', 'Delete backups.'),
(119, 'documents.restore', 'documents', 'Documents', 'restore', 'Restore', 'Restore disposed documents.'),
(120, 'batch-import.view', 'batch-import', 'Batch Import', 'view', 'View', 'View batch import screens and results.'),
(121, 'documents.view', 'documents', 'Documents', 'view', 'View', 'View documents.'),
(122, 'backup-restore.view_logs', 'backup-restore', 'Backup, Restore and Reset', 'view_logs', 'View Backup Logs', 'View backup logs.'),
(123, 'user-accounts.edit', 'user-accounts', 'User Accounts', 'edit', 'Edit', 'Edit user accounts.'),
(124, 'storage-classification.create', 'storage-classification', 'Storage and Classification', 'create', 'Create', 'Create storage and classification records.'),
(125, 'user-accounts.delete', 'user-accounts', 'User Accounts', 'delete', 'Delete', 'Delete user accounts.'),
(126, 'batch-import.import', 'batch-import', 'Batch Import', 'import', 'Import', 'Run batch imports.'),
(127, 'roles-permissions.view', 'roles-permissions', 'Roles and Permissions', 'view', 'View', 'View roles and permissions.'),
(128, 'batch-import.manage', 'batch-import', 'Batch Import', 'manage', 'Manage', 'Manage batch import workflows.'),
(129, 'user-accounts.manage', 'user-accounts', 'User Accounts', 'manage', 'Manage', 'Manage user accounts.'),
(130, 'storage-classification.view', 'storage-classification', 'Storage and Classification', 'view', 'View', 'View storage and classification catalogs.'),
(131, 'roles-permissions.manage', 'roles-permissions', 'Roles and Permissions', 'manage', 'Manage', 'Manage roles and permission assignments.'),
(132, 'user-accounts.create', 'user-accounts', 'User Accounts', 'create', 'Create', 'Create user accounts.'),
(133, 'user-accounts.view', 'user-accounts', 'User Accounts', 'view', 'View', 'View user accounts.'),
(134, 'document-requests.edit', 'document-requests', 'Document Requests', 'edit', 'Edit', 'Edit own draft and revision-requested records.'),
(135, 'document-requests.view', 'document-requests', 'Document Requests', 'view', 'View', 'View document requests and request ownership details.'),
(136, 'document-requests.delete', 'document-requests', 'Document Requests', 'delete', 'Delete', 'Delete eligible requests.'),
(137, 'document-requests.review', 'document-requests', 'Document Requests', 'review', 'Review', 'View requests awaiting approval.'),
(138, 'document-requests.request-revision', 'document-requests', 'Document Requests', 'request-revision', 'Request Revision', 'Return pending requests for revision.'),
(139, 'document-requests.reject', 'document-requests', 'Document Requests', 'reject', 'Reject', 'Reject pending requests.'),
(140, 'document-requests.create', 'document-requests', 'Document Requests', 'create', 'Create', 'Create document requests.'),
(141, 'document-requests.view-own', 'document-requests', 'Document Requests', 'view-own', 'View Own', 'View requests created by the current user.'),
(142, 'document-requests.submit', 'document-requests', 'Document Requests', 'submit', 'Submit', 'Submit and resubmit own requests.'),
(143, 'user-accounts.approve', 'user-accounts', 'User Accounts', 'approve', 'Approve registrations', 'Review registration requests and assign approved account roles.'),
(144, 'system-settings.manage', 'system-settings', 'System Settings', 'manage', 'Manage', 'Manage system branding, document behavior, and integration presentation settings.'),
(145, 'documents.attach-scans', 'documents', 'Documents', 'attach-scans', 'Attach Scanned Documents', 'Attach scanned reference files to authorized Softcopy records.'),
(146, 'documents.manage-own', 'documents', 'Documents', 'manage-own', 'Manage Own Documents', 'Manage documents created by the current user.'),
(147, 'ai-document-assistant.search', 'ai-document-assistant', 'AI Document Assistant', 'search', 'Search', 'Search authorized documents with the document assistant.'),
(148, 'softcopy-folders.view', 'softcopy-folders', 'Softcopy Folders', 'view', 'View', 'View authorized softcopy folders and subfolders.'),
(149, 'softcopy-folders.create', 'softcopy-folders', 'Softcopy Folders', 'create', 'Create', 'Create softcopy folders and subfolders.'),
(150, 'softcopy-folders.edit', 'softcopy-folders', 'Softcopy Folders', 'edit', 'Edit', 'Rename or move authorized softcopy folders and subfolders.'),
(151, 'softcopy-folders.delete', 'softcopy-folders', 'Softcopy Folders', 'delete', 'Delete', 'Delete authorized empty softcopy folders and subfolders.'),
(152, 'softcopy-folders.manage', 'softcopy-folders', 'Softcopy Folders', 'manage', 'Manage', 'Manage all softcopy folders and subfolders.'),
(153, 'document-disposal.review', 'document-disposal', 'Document Disposal', 'review', 'Review Disposal Requests', 'Approve or reject pending disposal requests.'),
(154, 'document-disposal.request', 'document-disposal', 'Document Disposal', 'request', 'Request Disposal', 'Submit disposal requests for administrator approval.'),
(155, 'document-access-requests.create', 'document-access-requests', 'Document Access Requests', 'create', 'Request Access', 'Request document assignment for the current account.'),
(156, 'document-access-requests.review', 'document-access-requests', 'Document Access Requests', 'review', 'Review Requests', 'View pending document access requests from users.'),
(157, 'document-access-requests.view-own', 'document-access-requests', 'Document Access Requests', 'view-own', 'View Own Requests', 'View the current account\'s document access requests.'),
(158, 'document-access-requests.approve', 'document-access-requests', 'Document Access Requests', 'approve', 'Approve Requests', 'Approve access requests and assign documents to users.'),
(159, 'document-access-requests.reject', 'document-access-requests', 'Document Access Requests', 'reject', 'Reject Requests', 'Reject document access requests.'),
(160, 'document-access-requests.catalog', 'document-access-requests', 'Document Access Requests', 'catalog', 'Search Request Catalog', 'Search approved document metadata when requesting access.'),
(161, 'document-access-requests.cancel-own', 'document-access-requests', 'Document Access Requests', 'cancel-own', 'Cancel Own Requests', 'Cancel the current account\'s pending document access requests.'),
(162, 'document-requests.approve-noted-by', 'document-requests', 'Document Requests', 'approve-noted-by', 'Approve as Noted By', 'Approve the assigned Softcopy Noted By stage.'),
(163, 'document-access-requests.revoke', 'document-access-requests', 'Document Access Requests', 'revoke', 'Revoke Access', 'Revoke an existing document assignment.'),
(164, 'document-access-requests.expire', 'document-access-requests', 'Document Access Requests', 'expire', 'Expire Access', 'Expire an approved document access request.'),
(165, 'document-requests.approve-plant-manager', 'document-requests', 'Document Requests', 'approve-plant-manager', 'Approve as Plant Manager', 'Approve the assigned Softcopy Plant Manager stage.'),
(166, 'document-requests.approve-document-controller', 'document-requests', 'Document Requests', 'approve-document-controller', 'Approve as Document Controller', 'Approve the assigned Softcopy Document Controller/Admin stage.'),
(167, 'document-requests.approve-hardcopy', 'document-requests', 'Document Requests', 'approve-hardcopy', 'Approve Hardcopy Requests', 'Approve the assigned Hardcopy request stage.'),
(168, 'document-requests.complete', 'document-requests', 'Document Requests', 'complete', 'Complete', 'Complete an approved request as the configured final approver.'),
(169, 'hardcopy-transfers.view-own', 'hardcopy-transfers', 'Hardcopy Transfers', 'view-own', 'View Own Transfers', 'View hardcopy transfers requested by or assigned to the current user.'),
(170, 'document-access-requests.grant', 'document-access-requests', 'Document Access Requests', 'grant', 'Grant Access', 'Grant document access after the configured approver approves the request.'),
(171, 'document-workflow.configure', 'document-workflow', 'Document Workflow', 'configure', 'Build Workflows', 'Create and edit draft workflow definitions, steps, assignments, conditions, and paths.'),
(172, 'hardcopy-transfers.review', 'hardcopy-transfers', 'Hardcopy Transfers', 'review', 'Review Transfers', 'View hardcopy transfers awaiting the configured approver\'s action.'),
(173, 'hardcopy-transfers.accept', 'hardcopy-transfers', 'Hardcopy Transfers', 'accept', 'Accept Receipt', 'Confirm physical receipt of a hardcopy transfer assigned to the current user.'),
(174, 'hardcopy-transfers.approve', 'hardcopy-transfers', 'Hardcopy Transfers', 'approve', 'Approve Transfers', 'Approve a hardcopy transfer request assigned to the current user.'),
(175, 'hardcopy-transfers.create', 'hardcopy-transfers', 'Hardcopy Transfers', 'create', 'Request Transfer', 'Create a hardcopy transfer request.'),
(176, 'hardcopy-transfers.dispatch', 'hardcopy-transfers', 'Hardcopy Transfers', 'dispatch', 'Dispatch Transfers', 'Prepare and dispatch an approved hardcopy transfer.'),
(177, 'document-workflow.view', 'document-workflow', 'Document Workflow', 'view', 'View Workflow Definitions', 'View published workflow definitions and version history.'),
(178, 'documents.create-direct', 'documents', 'Documents', 'create-direct', 'Direct Softcopy Create', 'Create a Softcopy directly without a Document Control Request when authorized.'),
(179, 'document-workflow.publish', 'document-workflow', 'Document Workflow', 'publish', 'Publish Workflows', 'Publish immutable workflow versions for future requests.'),
(180, 'documents.manage', 'documents', 'Documents', 'manage', 'Manage', 'Manage all document records, files, revisions, and assignments.');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `role_id` bigint(20) NOT NULL,
  `role_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`role_id`, `role_name`, `description`) VALUES
(6, 'Admin', 'Default system administrator role with access to all protected modules.'),
(7, 'Staff', 'Staff users manage their own folders, requests, attachments, and documents.'),
(8, 'Plant Manager', 'Approves requests assigned to the Plant Manager stage.'),
(9, 'Internal Audit', 'Document management access for internal audit review and control.'),
(10, 'Documentation Officer', 'Approves and completes requests assigned to Document Control.');

-- --------------------------------------------------------

--
-- Table structure for table `role_permissions`
--

CREATE TABLE `role_permissions` (
  `role_permission_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  `permission_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_permissions`
--

INSERT INTO `role_permissions` (`role_permission_id`, `role_id`, `permission_id`) VALUES
(230, 6, 91),
(198, 6, 92),
(200, 6, 93),
(221, 6, 94),
(236, 6, 95),
(216, 6, 96),
(222, 6, 97),
(202, 6, 98),
(227, 6, 99),
(203, 6, 100),
(218, 6, 101),
(231, 6, 102),
(207, 6, 103),
(223, 6, 104),
(209, 6, 105),
(239, 6, 106),
(213, 6, 107),
(235, 6, 108),
(217, 6, 109),
(197, 6, 110),
(211, 6, 111),
(214, 6, 112),
(215, 6, 113),
(220, 6, 114),
(229, 6, 115),
(219, 6, 116),
(199, 6, 117),
(224, 6, 118),
(206, 6, 119),
(226, 6, 120),
(201, 6, 121),
(225, 6, 122),
(228, 6, 123),
(238, 6, 124),
(234, 6, 125),
(204, 6, 126),
(210, 6, 127),
(205, 6, 128),
(237, 6, 129),
(233, 6, 130),
(212, 6, 131),
(232, 6, 132),
(208, 6, 133),
(241, 6, 134),
(240, 6, 135),
(242, 6, 136),
(246, 6, 137),
(247, 6, 138),
(248, 6, 139),
(243, 6, 140),
(244, 6, 141),
(245, 6, 142),
(249, 6, 143),
(250, 6, 144),
(251, 6, 145),
(263, 6, 146),
(265, 6, 147),
(266, 6, 148),
(267, 6, 149),
(268, 6, 150),
(270, 6, 151),
(269, 6, 152),
(273, 6, 153),
(272, 6, 154),
(279, 6, 155),
(280, 6, 156),
(278, 6, 157),
(281, 6, 158),
(282, 6, 159),
(277, 6, 160),
(284, 6, 161),
(303, 6, 162),
(301, 6, 163),
(302, 6, 164),
(289, 6, 165),
(290, 6, 166),
(295, 6, 167),
(294, 6, 168),
(298, 6, 169),
(300, 6, 170),
(296, 6, 171),
(292, 6, 172),
(297, 6, 173),
(291, 6, 174),
(299, 6, 175),
(293, 6, 176),
(304, 6, 177),
(306, 6, 178),
(305, 6, 179),
(392, 6, 180),
(260, 7, 94),
(257, 7, 96),
(262, 7, 97),
(254, 7, 117),
(253, 7, 121),
(285, 7, 134),
(255, 7, 135),
(258, 7, 140),
(256, 7, 141),
(259, 7, 142),
(252, 7, 145),
(261, 7, 146),
(264, 7, 147),
(271, 7, 154),
(274, 7, 155),
(275, 7, 157),
(276, 7, 160),
(283, 7, 161),
(286, 7, 169),
(287, 7, 173),
(288, 7, 175),
(307, 8, 94),
(326, 8, 96),
(341, 8, 97),
(314, 8, 117),
(308, 8, 121),
(310, 8, 134),
(336, 8, 135),
(320, 8, 137),
(327, 8, 138),
(315, 8, 139),
(339, 8, 140),
(312, 8, 141),
(316, 8, 142),
(334, 8, 145),
(313, 8, 146),
(340, 8, 147),
(332, 8, 154),
(324, 8, 155),
(317, 8, 156),
(328, 8, 157),
(323, 8, 158),
(337, 8, 159),
(331, 8, 160),
(321, 8, 161),
(329, 8, 163),
(330, 8, 164),
(309, 8, 165),
(333, 8, 168),
(335, 8, 169),
(325, 8, 170),
(322, 8, 172),
(318, 8, 173),
(338, 8, 174),
(319, 8, 175),
(311, 8, 176),
(381, 9, 94),
(382, 9, 97),
(379, 9, 111),
(378, 9, 117),
(383, 9, 121),
(380, 9, 148),
(387, 9, 149),
(388, 9, 150),
(390, 9, 151),
(389, 9, 152),
(391, 9, 180),
(343, 10, 94),
(366, 10, 96),
(347, 10, 97),
(342, 10, 117),
(349, 10, 121),
(348, 10, 134),
(361, 10, 135),
(358, 10, 137),
(372, 10, 138),
(367, 10, 139),
(365, 10, 140),
(369, 10, 141),
(344, 10, 142),
(375, 10, 145),
(364, 10, 146),
(370, 10, 147),
(386, 10, 151),
(385, 10, 152),
(362, 10, 154),
(355, 10, 155),
(357, 10, 156),
(346, 10, 157),
(353, 10, 158),
(359, 10, 159),
(363, 10, 160),
(351, 10, 161),
(356, 10, 163),
(354, 10, 164),
(345, 10, 166),
(376, 10, 167),
(368, 10, 168),
(374, 10, 169),
(352, 10, 170),
(371, 10, 172),
(360, 10, 173),
(373, 10, 174),
(377, 10, 175),
(350, 10, 176),
(384, 10, 180);

-- --------------------------------------------------------

--
-- Table structure for table `sequences`
--

CREATE TABLE `sequences` (
  `sequence_id` bigint(20) NOT NULL,
  `sequence_code` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sequences`
--

INSERT INTO `sequences` (`sequence_id`, `sequence_code`) VALUES
(1, '01'),
(2, '02'),
(3, '03'),
(4, '04'),
(5, '05'),
(6, '06'),
(7, '07'),
(8, '08'),
(9, '09'),
(10, '10'),
(100, '100'),
(101, '101'),
(102, '102'),
(103, '103'),
(104, '104'),
(105, '105'),
(106, '106'),
(107, '107'),
(108, '108'),
(109, '109'),
(11, '11'),
(110, '110'),
(111, '111'),
(112, '112'),
(113, '113'),
(114, '114'),
(115, '115'),
(116, '116'),
(117, '117'),
(118, '118'),
(119, '119'),
(12, '12'),
(120, '120'),
(121, '121'),
(122, '122'),
(123, '123'),
(124, '124'),
(125, '125'),
(126, '126'),
(127, '127'),
(128, '128'),
(129, '129'),
(13, '13'),
(130, '130'),
(131, '131'),
(132, '132'),
(133, '133'),
(134, '134'),
(135, '135'),
(136, '136'),
(137, '137'),
(138, '138'),
(139, '139'),
(14, '14'),
(140, '140'),
(141, '141'),
(142, '142'),
(143, '143'),
(144, '144'),
(145, '145'),
(146, '146'),
(147, '147'),
(148, '148'),
(149, '149'),
(15, '15'),
(150, '150'),
(151, '151'),
(152, '152'),
(153, '153'),
(154, '154'),
(16, '16'),
(17, '17'),
(18, '18'),
(19, '19'),
(20, '20'),
(21, '21'),
(22, '22'),
(23, '23'),
(24, '24'),
(25, '25'),
(26, '26'),
(27, '27'),
(28, '28'),
(29, '29'),
(30, '30'),
(31, '31'),
(32, '32'),
(33, '33'),
(34, '34'),
(35, '35'),
(36, '36'),
(37, '37'),
(38, '38'),
(39, '39'),
(40, '40'),
(41, '41'),
(42, '42'),
(43, '43'),
(44, '44'),
(45, '45'),
(46, '46'),
(47, '47'),
(48, '48'),
(49, '49'),
(50, '50'),
(51, '51'),
(52, '52'),
(53, '53'),
(54, '54'),
(55, '55'),
(56, '56'),
(57, '57'),
(58, '58'),
(59, '59'),
(60, '60'),
(61, '61'),
(62, '62'),
(63, '63'),
(64, '64'),
(65, '65'),
(66, '66'),
(67, '67'),
(68, '68'),
(69, '69'),
(70, '70'),
(71, '71'),
(72, '72'),
(73, '73'),
(74, '74'),
(75, '75'),
(76, '76'),
(77, '77'),
(78, '78'),
(79, '79'),
(80, '80'),
(81, '81'),
(82, '82'),
(83, '83'),
(84, '84'),
(85, '85'),
(86, '86'),
(87, '87'),
(88, '88'),
(89, '89'),
(90, '90'),
(91, '91'),
(92, '92'),
(93, '93'),
(94, '94'),
(95, '95'),
(96, '96'),
(97, '97'),
(98, '98'),
(99, '99');

-- --------------------------------------------------------

--
-- Table structure for table `softcopy_attachments`
--

CREATE TABLE `softcopy_attachments` (
  `attachment_id` bigint(20) NOT NULL,
  `softcopy_id` bigint(20) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_path` varchar(500) NOT NULL,
  `file_size` bigint(20) DEFAULT NULL,
  `mime_type` varchar(100) DEFAULT NULL,
  `uploaded_by` bigint(20) NOT NULL,
  `status` enum('PendingApproval','Approved','Rejected','Cancelled') NOT NULL DEFAULT 'PendingApproval',
  `approved_by_user_id` bigint(20) DEFAULT NULL,
  `approved_at` datetime(3) DEFAULT NULL,
  `rejected_by_user_id` bigint(20) DEFAULT NULL,
  `rejected_at` datetime(3) DEFAULT NULL,
  `rejection_reason` text DEFAULT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `softcopy_categories`
--

CREATE TABLE `softcopy_categories` (
  `softcopy_category_id` bigint(20) NOT NULL,
  `category_name` varchar(150) NOT NULL,
  `folder_name` varchar(160) NOT NULL,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `parent_category_id` bigint(20) DEFAULT NULL,
  `created_by_user_id` bigint(20) DEFAULT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updated_at` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `softcopy_categories`
--

INSERT INTO `softcopy_categories` (`softcopy_category_id`, `category_name`, `folder_name`, `description`, `is_active`, `parent_category_id`, `created_by_user_id`, `created_at`, `updated_at`) VALUES
(2, 'Uncategorized', 'uncategorized', 'Default category for existing and unclassified softcopy documents.', 1, NULL, NULL, '2026-07-13 06:44:52.000', '2026-10-05 00:35:09.432'),
(3, 'Warehouse Record', 'warehouse-record', NULL, 1, NULL, NULL, '2026-07-13 06:57:24.374', '2026-07-13 06:57:24.374'),
(4, 'tO mAM NOVA', 'to-mam-nova', NULL, 1, NULL, NULL, '2026-07-13 06:57:37.632', '2026-07-13 06:57:37.632'),
(5, 'Policy', 'policy', NULL, 1, NULL, NULL, '2026-07-13 06:57:50.311', '2026-07-13 06:57:50.311'),
(6, 'Production Monitoring', 'production-monitoring', NULL, 1, NULL, NULL, '2026-07-13 06:58:00.076', '2026-07-13 06:58:00.076'),
(7, 'Production Process Monitoring', 'production-process-monitoring', NULL, 1, NULL, NULL, '2026-07-13 06:58:08.523', '2026-07-13 06:58:08.523'),
(8, 'Production Report', 'production-report', NULL, 1, NULL, NULL, '2026-07-13 06:58:22.260', '2026-07-13 06:58:22.260'),
(9, 'Purchasing Department', 'purchasing-department', NULL, 1, NULL, NULL, '2026-07-13 06:58:39.497', '2026-07-13 06:58:39.497'),
(10, 'Quality Management System & Inspection Report', 'quality-management-system-inspection-report', NULL, 1, NULL, NULL, '2026-07-13 06:58:48.797', '2026-07-13 06:58:48.797'),
(11, 'Raw Material Specification', 'raw-material-specification', NULL, 1, NULL, NULL, '2026-07-13 06:58:59.224', '2026-07-13 06:58:59.224'),
(12, 'Request Form', 'request-form', NULL, 1, NULL, NULL, '2026-07-13 06:59:09.266', '2026-07-13 06:59:09.266'),
(13, 'Safety & Security Monitoring', 'safety-security-monitoring', NULL, 1, NULL, NULL, '2026-07-13 06:59:17.742', '2026-07-13 06:59:17.742'),
(14, 'SOP', 'sop', NULL, 1, NULL, NULL, '2026-07-13 06:59:27.295', '2026-07-13 06:59:27.295'),
(15, 'Task Checklist', 'task-checklist', NULL, 1, NULL, NULL, '2026-07-13 06:59:38.619', '2026-07-13 06:59:38.619'),
(16, 'Equipment Monitoring System', 'equipment-monitoring-system', NULL, 1, NULL, NULL, '2026-07-13 06:59:48.955', '2026-07-13 06:59:48.955'),
(17, 'GOLDILOCKS MONITORING', 'goldilocks-monitoring', NULL, 1, NULL, NULL, '2026-07-13 07:00:05.972', '2026-07-13 07:00:05.972'),
(18, 'GSD', 'gsd', NULL, 1, NULL, NULL, '2026-07-13 07:00:18.271', '2026-07-13 07:00:18.271'),
(19, 'HR', 'hr', NULL, 1, NULL, NULL, '2026-07-13 07:00:33.329', '2026-07-13 07:00:33.329'),
(20, 'Inventory Management Monitoring', 'inventory-management-monitoring', NULL, 1, NULL, NULL, '2026-07-13 07:00:41.966', '2026-07-13 07:00:41.966'),
(21, 'Logistics Department', 'logistics-department', NULL, 1, NULL, NULL, '2026-07-13 07:00:51.552', '2026-07-13 07:00:51.552'),
(22, 'Memorandum', 'memorandum', NULL, 1, NULL, NULL, '2026-07-13 07:01:06.177', '2026-07-13 07:01:06.177'),
(23, 'Admin Forms', 'admin-forms', NULL, 1, NULL, NULL, '2026-07-13 07:01:23.037', '2026-07-13 07:01:23.037'),
(24, 'Company Program', 'company-program', NULL, 1, NULL, NULL, '2026-07-13 07:01:32.428', '2026-07-13 07:01:32.428'),
(25, 'Customer Monitoring', 'customer-monitoring', NULL, 1, NULL, NULL, '2026-07-13 07:01:43.178', '2026-07-13 07:01:43.178'),
(26, 'Employee Monitoring', 'employee-monitoring', NULL, 1, NULL, NULL, '2026-07-13 07:01:54.157', '2026-07-13 07:01:54.157'),
(27, 'EMS - Preventive Maintenance Schedule', 'equipment-monitoring-system/ems-preventive-maintenance-schedule', 'Created automatically from uploaded folder Equipment Monitoring System / EMS - Preventive Maintenance Schedule.', 1, 16, NULL, '2026-07-18 02:09:49.325', '2026-07-18 02:09:49.325'),
(28, 'Research & Development Files', 'r-d-forms', 'Created automatically from uploaded folder R&D Forms.', 1, NULL, NULL, '2026-07-27 13:30:38.590', '2026-08-11 16:59:09.398'),
(29, 'Cleaning and sanitation program', 'cleaning-and-sanitation-program', 'Created automatically from uploaded folder Cleaning and sanitation program.', 1, NULL, NULL, '2026-07-27 13:31:08.303', '2026-07-27 13:31:08.303'),
(30, 'General Cleaning Monitoring Form', 'general-cleaning-monitoring-form', 'Created automatically from uploaded folder General Cleaning Monitoring Form.', 1, NULL, NULL, '2026-07-27 13:31:41.376', '2026-07-27 13:31:41.376'),
(31, 'Productivity Monitoring', 'productivity-monitoring', 'Created automatically from uploaded folder Productivity Monitoring.', 1, NULL, NULL, '2026-07-27 13:33:11.527', '2026-07-27 13:33:11.527'),
(32, 'Training Roadmap', 'hr/training-roadmap', 'Created automatically from uploaded folder HR / Training Roadmap.', 1, 19, NULL, '2026-07-27 13:36:49.804', '2026-07-27 13:36:49.804'),
(33, 'Training Plan and Certification Form', 'hr/training-plan-and-certification-form', 'Created automatically from uploaded folder HR / Training Plan and Certification Form.', 1, 19, NULL, '2026-07-27 13:36:50.047', '2026-07-27 13:36:50.047'),
(34, 'Analysis Report', 'r-d-forms/analysis-report', NULL, 1, 28, NULL, '2026-08-11 17:01:42.185', '2026-08-11 17:01:42.185'),
(35, 'Memorandom', 'r-d-forms/memorandom', NULL, 1, 28, NULL, '2026-08-11 17:01:55.383', '2026-08-11 17:01:55.383'),
(36, 'Request Forms', 'r-d-forms/request-forms', NULL, 1, 28, NULL, '2026-08-11 17:02:08.834', '2026-08-11 17:02:08.834'),
(37, 'Raw Material  Organoleptic & Pyshico-Chemical Analysis', 'r-d-forms/raw-material-organoleptic-pyshico-chemical-analysis', NULL, 1, 28, NULL, '2026-08-11 17:03:13.516', '2026-08-11 17:03:13.516'),
(38, 'Product Specification', 'r-d-forms/product-specification', NULL, 1, 28, NULL, '2026-08-11 17:03:37.449', '2026-08-11 17:03:37.449'),
(39, 'Packaging Material Analysis', 'r-d-forms/packaging-material-analysis', NULL, 1, 28, NULL, '2026-08-11 17:03:56.005', '2026-08-11 17:03:56.005'),
(40, 'Process Flow', 'r-d-forms/process-flow', NULL, 1, 28, NULL, '2026-08-11 17:04:07.582', '2026-08-11 17:04:07.582'),
(41, 'Packaging Material Evaluation Form - Accepted', 'r-d-forms/packaging-material-evaluation-form-accepted', NULL, 1, 28, NULL, '2026-08-11 17:04:44.883', '2026-08-11 17:04:44.883'),
(42, 'Packaging Material Evaluation Form - Rejected', 'r-d-forms/packaging-material-evaluation-form-rejected', NULL, 1, 28, NULL, '2026-08-11 17:04:58.134', '2026-08-11 17:04:58.134'),
(43, 'Packaging Material Evaluation Form - Needs Improvement', 'r-d-forms/packaging-material-evaluation-form-needs-improvement', NULL, 1, 28, NULL, '2026-08-11 17:05:14.802', '2026-08-11 17:05:14.802'),
(44, 'Raw Material Evaluation Form - Accepted', 'r-d-forms/raw-material-evaluation-form-accepted', NULL, 1, 28, NULL, '2026-08-11 17:05:41.923', '2026-08-11 17:05:41.923'),
(45, 'Raw Material Evaluation Form - Rejected', 'r-d-forms/raw-material-evaluation-form-rejected', NULL, 1, 28, NULL, '2026-08-11 17:05:52.709', '2026-08-11 17:05:52.709'),
(46, 'Raw Material Evaluation Form - Needs Improvement', 'r-d-forms/raw-material-evaluation-form-needs-improvement', NULL, 1, 28, NULL, '2026-08-11 17:06:07.300', '2026-08-11 17:06:07.300'),
(47, 'Packaging Development', 'r-d-forms/packaging-development', NULL, 1, 28, NULL, '2026-08-11 17:06:31.346', '2026-08-11 17:06:31.346'),
(48, 'Recipe Scalers Guide', 'r-d-forms/recipe-scalers-guide', NULL, 1, 28, NULL, '2026-08-11 17:06:49.328', '2026-08-11 17:06:49.328'),
(49, 'Sensory Evaluation Results', 'r-d-forms/sensory-evaluation-results', NULL, 1, 28, NULL, '2026-08-11 17:07:11.147', '2026-08-11 17:07:11.147'),
(50, 'Research & Development Raw Files', 'r-d-forms/research-development-raw-files', NULL, 1, 28, NULL, '2026-08-11 18:40:56.299', '2026-08-11 18:40:56.299');

-- --------------------------------------------------------

--
-- Table structure for table `softcopy_documents`
--

CREATE TABLE `softcopy_documents` (
  `softcopy_id` bigint(20) NOT NULL,
  `document_number` varchar(100) DEFAULT NULL,
  `series_number` varchar(50) DEFAULT NULL,
  `document_id` bigint(20) NOT NULL,
  `softcopy_category_id` bigint(20) NOT NULL,
  `current_revision_id` bigint(20) DEFAULT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `softcopy_documents`
--

INSERT INTO `softcopy_documents` (`softcopy_id`, `document_number`, `series_number`, `document_id`, `softcopy_category_id`, `current_revision_id`, `created_at`) VALUES
(1, 'P-011', NULL, 1473, 2, 1, '2026-09-08 06:55:49.896'),
(2, 'Sample-001', NULL, 1474, 2, 2, '2026-09-14 08:04:05.879'),
(3, 'Sample-001', NULL, 1475, 2, 3, '2026-09-16 05:31:08.805'),
(4, 'ssss', NULL, 1477, 2, NULL, '2026-09-17 02:05:59.699'),
(5, 'EEE', NULL, 1478, 2, NULL, '2026-09-17 04:59:54.605');

-- --------------------------------------------------------

--
-- Table structure for table `softcopy_revision_artifacts`
--

CREATE TABLE `softcopy_revision_artifacts` (
  `artifact_id` bigint(20) NOT NULL,
  `revision_id` bigint(20) NOT NULL,
  `artifact_type` enum('CONTROLLED','UNCONTROLLED') NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_path` varchar(500) NOT NULL,
  `file_size` bigint(20) NOT NULL,
  `mime_type` varchar(100) NOT NULL,
  `source_fingerprint` varchar(128) NOT NULL,
  `generator_version` varchar(50) NOT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updated_at` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `specifics`
--

CREATE TABLE `specifics` (
  `specific_id` bigint(20) NOT NULL,
  `specific_name` varchar(150) NOT NULL,
  `area_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `specifics`
--

INSERT INTO `specifics` (`specific_id`, `specific_name`, `area_id`) VALUES
(1, 'PM\'S MOBILE CABINET 01', 1),
(2, 'PM\'S FILE ORGANIZER', 1),
(3, 'AP/AR/PAYROLL\'S FILE ORGANIZER', 1),
(4, 'IN FRONT OF HR\'S TABLE', 1),
(5, 'BACK OFFICE STORAGE', 1),
(6, 'AT THE BACK OF QA\'S TABLE', 3),
(7, 'AT THE BACK OF QA\'S TABLE', 2),
(8, 'MAINTENANCE MOBILE CABINET', 4),
(9, 'IN FRONT GSD MOBILE CABINET', 3);

-- --------------------------------------------------------

--
-- Table structure for table `system_appearance_settings`
--

CREATE TABLE `system_appearance_settings` (
  `id` int(11) NOT NULL DEFAULT 1,
  `theme_scope` varchar(20) NOT NULL DEFAULT 'device',
  `color_mode` varchar(20) NOT NULL DEFAULT 'light',
  `color_theme` varchar(30) NOT NULL DEFAULT 'default',
  `settings_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`settings_json`)),
  `updated_at` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `system_sequence_states`
--

CREATE TABLE `system_sequence_states` (
  `sequence_key` varchar(100) NOT NULL,
  `next_value` bigint(20) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `system_sequence_states`
--

INSERT INTO `system_sequence_states` (`sequence_key`, `next_value`) VALUES
('location_code', 84);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` bigint(20) NOT NULL,
  `firstname` varchar(100) NOT NULL,
  `lastname` varchar(100) NOT NULL,
  `middlename` varchar(100) DEFAULT NULL,
  `username` varchar(150) NOT NULL,
  `position_title` varchar(100) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `require_password_change` tinyint(1) NOT NULL DEFAULT 0,
  `role_id` bigint(20) NOT NULL,
  `leader_id` bigint(20) DEFAULT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updated_at` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `firstname`, `lastname`, `middlename`, `username`, `position_title`, `password`, `require_password_change`, `role_id`, `leader_id`, `created_at`, `updated_at`) VALUES
(2, 'Admin', 'User', NULL, 'admin', 'System Administrator', '$2b$10$C/sxpY9PT7OGYgeYR8aFCedw6ST7gdXnUvR1k/3ZuW8pfIqKzx2XW', 1, 6, NULL, '2026-07-10 08:32:17.323', '2026-10-05 01:27:33.948'),
(3, 'Theresse Jane', 'Alaan', 'Echavari', 'theressechavari28', 'HR Associate I', '$2b$10$HnKK9DQGTyx9eooasnfa3eSQw0iaEhNoJHl4JI1zq00KB8mpJ95Ye', 0, 7, NULL, '2026-07-13 08:25:03.832', '2026-08-12 13:30:16.304'),
(4, 'Alice', 'Auditor', 'Asoy', 'auditoralice19', 'R&D/FS & Q  Jr. Supervisor', '$2b$10$qRDW3du2r3ro9Vs/ToiBgeUeV9OkkhTAz66fi9xae3k5LI3cGF.4e', 0, 7, NULL, '2026-07-13 08:28:54.002', '2026-09-08 07:00:30.881'),
(5, 'Arnel', 'LabadLabad', 'Omole', 'arnel01', 'AP-AR / Liason Officer', '$2b$10$cakWQBVq5sdJ.2Xmum.bIut/zi8pZFpdn532VOnPjYBYWjwQ/klUy', 0, 7, NULL, '2026-07-13 08:31:29.111', '2026-08-14 01:02:45.832'),
(6, 'Josephine', 'Dag-um', 'Sojon', 'jhosh86', 'Accounting Clerk I', '$2b$10$Mb1bNay0QQXs2H5XQqsLnuBHpASAsFFcjdLKEAWyloYDPNGQFnG7u', 0, 7, NULL, '2026-07-13 08:33:41.622', '2026-10-05 01:54:06.084'),
(7, 'Donata', 'Doquipil', 'Perez', 'donatadoquipil', 'Accounting Clerk II', '$2b$10$Mh4hP17XrZZmAtjDhgrmLexkmrJd0379ZF/H.M70wv6hxqe.pbUz6', 0, 7, NULL, '2026-07-13 08:36:03.262', '2026-08-12 13:30:16.304'),
(8, 'John Paul', 'Curib', 'Cajes', 'curibtech', 'Documentation Officer / Computer Programmer', '$2b$10$fPyrSN0yZlAID81AzblYH.z7otKnaabDRJoRHUJuSqOuSowhZjSxq', 0, 10, NULL, '2026-07-17 07:09:10.426', '2026-09-08 07:58:37.018'),
(9, 'Nova Mae', 'Magallen', NULL, 'magallennovamae', 'Marketing', '$2b$10$aBF1FwdPDVtGDsGZsMpylOkjhoQ6DTA3uur7MWBbZLP4JwcZEtkeC', 0, 7, NULL, '2026-08-11 13:50:13.175', '2026-09-08 06:55:34.038'),
(10, 'Jennifer', 'Ganub', 'Uyamot', 'ganubjennifer93', 'bookkeeper', '$2b$10$AbmPWQ56CiVeb.KuAJ1FN.VCHie4kfD/j1GcCftscl9bHIG/9F0dG', 0, 7, NULL, '2026-08-11 13:59:51.378', '2026-08-11 18:32:56.581'),
(11, 'Marivic', 'Idago', 'Talan', 'maveetalan', 'HRD Section Head', '$2b$10$8SBrDKgE6A.vP4qYRQ9IiODVYxM6A2UwJhNFSYyK7QIDLyeNEIKty', 0, 7, NULL, '2026-08-12 17:05:57.997', '2026-08-12 17:05:57.997'),
(12, 'Juper', 'Mativo', 'Parido', 'mativojuper2000', 'Supervisor', '$2b$10$V.kryzG9ZOAJg2es9R.bJuAmqZONX8wxZ9t1BV9KUdNqUkS8KZuL2', 0, 7, NULL, '2026-08-15 01:27:42.307', '2026-08-15 01:27:42.307'),
(13, 'Marilou', 'Arcayan', 'Lacaba', 'mariloulacaba120', 'Section Head', '$2b$10$V4hQXHq2DD2RushvDtocC.NYKFqjrfcVR6NalSIHxEJXE2DighlZa', 0, 7, NULL, '2026-08-15 01:51:35.185', '2026-08-15 01:51:35.185'),
(14, 'Ma. Jemielyn', 'Orrica', 'Migue', 'majemielynorrica', 'Supervisor', '$2b$10$m1X6VH9gOr.Uvm02c2WsRe6Ke/WuV50P6XzirWpF8GSfWbM0XSLPi', 0, 7, NULL, '2026-08-15 01:51:36.819', '2026-08-15 01:51:36.819'),
(15, 'Virginita', 'Estillore', 'Aranay', 'virgieestillore3', 'GSD Section Head', '$2b$10$fH2ajJBrjfPbSjaPYsf9AebQLZtV9xkmSaFCd1F5Bx5zXyZk2qvFe', 0, 7, NULL, '2026-08-15 03:28:40.622', '2026-08-15 03:28:40.622'),
(16, 'Dennis', 'Gabato', 'Tago-on', 'dennisgabato', 'Plant Manager', '$2b$10$KVRfAiuoi8kghjU3IdZszOAsgIDXvrT3Bb.t2hq73jegncWrhUkMO', 0, 8, NULL, '2026-08-19 06:29:13.690', '2026-09-07 07:31:59.705'),
(17, 'Bucarez', 'Maintenance', NULL, 'bucarezmaintenance', 'Maintenance', '$2b$10$hY9kRFZO24GUzr8PD.fJf.yrsK0nEM8NmejxhItRkLaWxzm02tUqO', 0, 7, NULL, '2026-08-20 02:09:41.626', '2026-08-20 02:09:41.626'),
(18, 'sample', 'sample', 'sample', 'sample@gmail.com', 'Sample Position', '$2b$10$gghUZwIINgUC6QIsnAnea.mGN01xPzuiRc90MR6c8Co6rLuGH8YHW', 0, 7, NULL, '2026-09-03 07:09:03.227', '2026-09-16 05:25:40.227'),
(19, 'Workflow', 'Verification 0', NULL, 'workflow-check-1788839423314-0@example.invalid', NULL, '$2b$10$XqpNaQddQhGHOipFP8MuF.ZrrbXyy6pkTO7vmFoXsUfLPCpwnrMkq', 0, 6, NULL, '2026-09-08 03:50:34.742', '2026-09-08 03:50:34.742'),
(20, 'Workflow', 'Verification 1', NULL, 'workflow-check-1788839423314-1@example.invalid', NULL, '$2b$10$XqpNaQddQhGHOipFP8MuF.ZrrbXyy6pkTO7vmFoXsUfLPCpwnrMkq', 0, 7, NULL, '2026-09-08 03:50:35.025', '2026-09-08 07:58:37.033'),
(21, 'Workflow', 'Verification 2', NULL, 'workflow-check-1788839423314-2@example.invalid', NULL, '$2b$10$XqpNaQddQhGHOipFP8MuF.ZrrbXyy6pkTO7vmFoXsUfLPCpwnrMkq', 0, 7, NULL, '2026-09-08 03:50:35.078', '2026-09-08 07:58:37.033');

-- --------------------------------------------------------

--
-- Table structure for table `workflow_definitions`
--

CREATE TABLE `workflow_definitions` (
  `workflow_definition_id` bigint(20) NOT NULL,
  `workflow_key` varchar(100) NOT NULL,
  `name` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `document_type` enum('SOFTCOPY','HARDCOPY') DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_by_user_id` bigint(20) NOT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updated_at` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `workflow_definitions`
--

INSERT INTO `workflow_definitions` (`workflow_definition_id`, `workflow_key`, `name`, `description`, `document_type`, `is_active`, `created_by_user_id`, `created_at`, `updated_at`) VALUES
(5, 'system-softcopy-standard', 'Standard Softcopy Approval', 'Default approval route for standard Softcopy requests.', 'SOFTCOPY', 1, 2, '2026-10-05 01:10:08.630', '2026-10-05 01:10:08.630'),
(6, 'system-softcopy-cancellation', 'Softcopy Cancellation Approval', 'Default approval route for Softcopy cancellation requests.', 'SOFTCOPY', 1, 2, '2026-10-05 01:10:08.666', '2026-10-05 01:10:08.666'),
(7, 'system-hardcopy-direct-approval', 'Direct Hardcopy Approval', 'Default direct approval route for Hardcopy requests.', 'HARDCOPY', 1, 2, '2026-10-05 01:10:08.685', '2026-10-05 01:10:08.685'),
(8, 'system-hardcopy-transfer', 'Hardcopy Transfer Approval', 'Default route for moving a Hardcopy document to another storage location.', 'HARDCOPY', 1, 2, '2026-10-05 01:10:08.716', '2026-10-05 01:10:08.716');

-- --------------------------------------------------------

--
-- Table structure for table `workflow_versions`
--

CREATE TABLE `workflow_versions` (
  `workflow_version_id` bigint(20) NOT NULL,
  `workflow_definition_id` bigint(20) NOT NULL,
  `version_number` int(11) NOT NULL,
  `status` enum('DRAFT','PUBLISHED','ARCHIVED') NOT NULL DEFAULT 'DRAFT',
  `graph` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`graph`)),
  `created_by_user_id` bigint(20) NOT NULL,
  `published_by_user_id` bigint(20) DEFAULT NULL,
  `published_at` datetime(3) DEFAULT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updated_at` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `workflow_versions`
--

INSERT INTO `workflow_versions` (`workflow_version_id`, `workflow_definition_id`, `version_number`, `status`, `graph`, `created_by_user_id`, `published_by_user_id`, `published_at`, `created_at`, `updated_at`) VALUES
(5, 5, 1, 'PUBLISHED', '{\"schema_version\":2,\"start_node_key\":\"noted-by\",\"nodes\":[{\"key\":\"noted-by\",\"label\":\"Leader / Noted By\",\"type\":\"APPROVAL\",\"stage\":\"NOTED_BY\",\"assignment\":{\"type\":\"REQUESTER_LEADER\"}},{\"key\":\"plant-manager\",\"label\":\"Plant Manager Approval\",\"type\":\"APPROVAL\",\"stage\":\"PLANT_MANAGER\",\"assignment\":{\"type\":\"ROLE\",\"role_id\":\"8\"}},{\"key\":\"document-controller\",\"label\":\"Document Controller Approval\",\"type\":\"APPROVAL\",\"stage\":\"DOCUMENT_CONTROLLER_ADMIN\",\"assignment\":{\"type\":\"ROLE\",\"role_id\":\"10\"}},{\"key\":\"approved\",\"label\":\"Approved\",\"type\":\"END\"}],\"edges\":[{\"key\":\"noted-by-approve\",\"from\":\"noted-by\",\"to\":\"plant-manager\",\"outcome\":\"APPROVE\"},{\"key\":\"plant-manager-approve\",\"from\":\"plant-manager\",\"to\":\"document-controller\",\"outcome\":\"APPROVE\"},{\"key\":\"document-controller-approve\",\"from\":\"document-controller\",\"to\":\"approved\",\"outcome\":\"APPROVE\"}]}', 2, 2, '2026-10-05 01:10:08.648', '2026-10-05 01:10:08.650', '2026-10-05 01:10:08.650'),
(6, 6, 1, 'PUBLISHED', '{\"schema_version\":2,\"start_node_key\":\"noted-by\",\"nodes\":[{\"key\":\"noted-by\",\"label\":\"Leader / Noted By\",\"type\":\"APPROVAL\",\"stage\":\"NOTED_BY\",\"assignment\":{\"type\":\"REQUESTER_LEADER\"}},{\"key\":\"document-controller\",\"label\":\"Document Controller Approval\",\"type\":\"APPROVAL\",\"stage\":\"DOCUMENT_CONTROLLER_ADMIN\",\"assignment\":{\"type\":\"ROLE\",\"role_id\":\"10\"}},{\"key\":\"approved\",\"label\":\"Approved\",\"type\":\"END\"}],\"edges\":[{\"key\":\"noted-by-approve\",\"from\":\"noted-by\",\"to\":\"document-controller\",\"outcome\":\"APPROVE\"},{\"key\":\"document-controller-approve\",\"from\":\"document-controller\",\"to\":\"approved\",\"outcome\":\"APPROVE\"}]}', 2, 2, '2026-10-05 01:10:08.671', '2026-10-05 01:10:08.672', '2026-10-05 01:10:08.672'),
(7, 7, 1, 'PUBLISHED', '{\"schema_version\":2,\"start_node_key\":\"hardcopy-approval\",\"nodes\":[{\"key\":\"hardcopy-approval\",\"label\":\"Hardcopy Approval\",\"type\":\"APPROVAL\",\"stage\":\"HARDCOPY_APPROVAL\",\"assignment\":{\"type\":\"ROLE\",\"role_id\":\"10\"}},{\"key\":\"approved\",\"label\":\"Approved\",\"type\":\"END\"}],\"edges\":[{\"key\":\"hardcopy-approval-approve\",\"from\":\"hardcopy-approval\",\"to\":\"approved\",\"outcome\":\"APPROVE\"}]}', 2, 2, '2026-10-05 01:10:08.706', '2026-10-05 01:10:08.707', '2026-10-05 01:10:08.707'),
(8, 8, 1, 'PUBLISHED', '{\"schema_version\":2,\"start_node_key\":\"plant-manager\",\"nodes\":[{\"key\":\"plant-manager\",\"label\":\"Plant Manager Approval\",\"type\":\"APPROVAL\",\"stage\":\"PLANT_MANAGER\",\"assignment\":{\"type\":\"ROLE\",\"role_id\":\"8\"}},{\"key\":\"documentation-officer\",\"label\":\"Documentation Officer Approval\",\"type\":\"APPROVAL\",\"stage\":\"DOCUMENT_CONTROLLER_ADMIN\",\"assignment\":{\"type\":\"ROLE\",\"role_id\":\"10\"}},{\"key\":\"final-approver\",\"label\":\"Final Approver\",\"type\":\"APPROVAL\",\"stage\":\"CUSTOM\",\"assignment\":{\"type\":\"USER\",\"user_id\":\"1\"}},{\"key\":\"approved\",\"label\":\"Approved\",\"type\":\"END\"}],\"edges\":[{\"key\":\"plant-manager-approve\",\"from\":\"plant-manager\",\"to\":\"documentation-officer\",\"outcome\":\"APPROVE\"},{\"key\":\"documentation-officer-approve\",\"from\":\"documentation-officer\",\"to\":\"final-approver\",\"outcome\":\"APPROVE\"},{\"key\":\"final-approver-approve\",\"from\":\"final-approver\",\"to\":\"approved\",\"outcome\":\"APPROVE\"}]}', 2, 2, '2026-10-05 01:10:08.750', '2026-10-05 01:10:08.752', '2026-10-05 01:10:08.752');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `account_registration_requests`
--
ALTER TABLE `account_registration_requests`
  ADD PRIMARY KEY (`registration_id`),
  ADD UNIQUE KEY `account_registration_requests_reference_code_key` (`reference_code`),
  ADD KEY `account_registration_requests_username_status_idx` (`username`,`status`),
  ADD KEY `account_registration_requests_status_created_at_idx` (`status`,`created_at`),
  ADD KEY `account_registration_requests_requested_role_id_fkey` (`requested_role_id`),
  ADD KEY `account_registration_requests_assigned_role_id_fkey` (`assigned_role_id`),
  ADD KEY `account_registration_requests_reviewed_by_user_id_fkey` (`reviewed_by_user_id`);

--
-- Indexes for table `areas`
--
ALTER TABLE `areas`
  ADD PRIMARY KEY (`area_id`);

--
-- Indexes for table `asset_numbers`
--
ALTER TABLE `asset_numbers`
  ADD PRIMARY KEY (`asset_id`),
  ADD UNIQUE KEY `asset_numbers_asset_number_key` (`asset_number`),
  ADD KEY `asset_numbers_specific_id_idx` (`specific_id`);

--
-- Indexes for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`audit_log_id`),
  ADD KEY `audit_logs_user_id_created_at_idx` (`user_id`,`created_at`),
  ADD KEY `audit_logs_module_created_at_idx` (`module`,`created_at`),
  ADD KEY `audit_logs_entity_id_created_at_idx` (`entity_id`,`created_at`);

--
-- Indexes for table `documents`
--
ALTER TABLE `documents`
  ADD PRIMARY KEY (`document_id`),
  ADD KEY `documents_status_created_at_idx` (`status`,`created_at`),
  ADD KEY `documents_source_document_id_status_idx` (`source_document_id`,`status`),
  ADD KEY `documents_created_by_fkey` (`created_by`),
  ADD KEY `documents_requested_by_user_id_fkey` (`requested_by_user_id`),
  ADD KEY `documents_disposed_by_user_id_fkey` (`disposed_by_user_id`),
  ADD KEY `documents_reviewed_by_user_id_fkey` (`reviewed_by_user_id`),
  ADD KEY `documents_workflow_version_id_fkey` (`workflow_version_id`);

--
-- Indexes for table `document_access_requests`
--
ALTER TABLE `document_access_requests`
  ADD PRIMARY KEY (`access_request_id`),
  ADD KEY `document_access_requests_requested_by_user_id_status_created_idx` (`requested_by_user_id`,`status`,`created_at`),
  ADD KEY `document_access_requests_status_created_at_idx` (`status`,`created_at`),
  ADD KEY `document_access_requests_document_id_requested_by_user_id_st_idx` (`document_id`,`requested_by_user_id`,`status`),
  ADD KEY `document_access_requests_reviewed_by_user_id_fkey` (`reviewed_by_user_id`),
  ADD KEY `document_access_requests_approver_user_id_fkey` (`approver_user_id`);

--
-- Indexes for table `document_access_request_history`
--
ALTER TABLE `document_access_request_history`
  ADD PRIMARY KEY (`access_history_id`),
  ADD KEY `document_access_request_history_access_request_id_created_at_idx` (`access_request_id`,`created_at`),
  ADD KEY `document_access_request_history_performed_by_user_id_fkey` (`performed_by_user_id`);

--
-- Indexes for table `document_approver_configurations`
--
ALTER TABLE `document_approver_configurations`
  ADD PRIMARY KEY (`approver_configuration_id`),
  ADD UNIQUE KEY `document_approver_configurations_document_id_key` (`document_id`),
  ADD KEY `document_approver_configurations_configured_by_user_id_fkey` (`configured_by_user_id`),
  ADD KEY `document_approver_configurations_document_owner_user_id_fkey` (`document_owner_user_id`);

--
-- Indexes for table `document_assignments`
--
ALTER TABLE `document_assignments`
  ADD PRIMARY KEY (`document_assignment_id`),
  ADD UNIQUE KEY `document_assignments_document_id_user_id_key` (`document_id`,`user_id`),
  ADD KEY `document_assignments_user_id_document_id_idx` (`user_id`,`document_id`),
  ADD KEY `document_assignments_assigned_by_fkey` (`assigned_by`);

--
-- Indexes for table `document_disposal_requests`
--
ALTER TABLE `document_disposal_requests`
  ADD PRIMARY KEY (`disposal_request_id`),
  ADD KEY `document_disposal_requests_status_created_at_idx` (`status`,`created_at`),
  ADD KEY `document_disposal_requests_document_id_status_idx` (`document_id`,`status`),
  ADD KEY `document_disposal_requests_requested_by_user_id_fkey` (`requested_by_user_id`),
  ADD KEY `document_disposal_requests_reviewed_by_user_id_fkey` (`reviewed_by_user_id`);

--
-- Indexes for table `document_revisions`
--
ALTER TABLE `document_revisions`
  ADD PRIMARY KEY (`revision_id`),
  ADD UNIQUE KEY `document_revisions_softcopy_id_revision_number_key` (`softcopy_id`,`revision_number`),
  ADD KEY `document_revisions_approved_by_user_id_fkey` (`approved_by_user_id`),
  ADD KEY `document_revisions_superseded_by_revision_id_fkey` (`superseded_by_revision_id`),
  ADD KEY `document_revisions_uploaded_by_fkey` (`uploaded_by`);

--
-- Indexes for table `document_status_history`
--
ALTER TABLE `document_status_history`
  ADD PRIMARY KEY (`history_id`),
  ADD KEY `document_status_history_document_id_created_at_idx` (`document_id`,`created_at`),
  ADD KEY `document_status_history_performed_by_fkey` (`performed_by`);

--
-- Indexes for table `document_workflow_assignment_history`
--
ALTER TABLE `document_workflow_assignment_history`
  ADD PRIMARY KEY (`assignment_history_id`),
  ADD KEY `document_workflow_assignment_history_workflow_step_id_change_idx` (`workflow_step_id`,`changed_at`);

--
-- Indexes for table `document_workflow_steps`
--
ALTER TABLE `document_workflow_steps`
  ADD PRIMARY KEY (`workflow_step_id`),
  ADD UNIQUE KEY `document_workflow_steps_document_id_node_key_key` (`document_id`,`node_key`),
  ADD KEY `document_workflow_steps_assigned_user_id_status_idx` (`assigned_user_id`,`status`),
  ADD KEY `document_workflow_steps_assigned_role_id_status_idx` (`assigned_role_id`,`status`),
  ADD KEY `document_workflow_steps_acted_by_user_id_fkey` (`acted_by_user_id`);

--
-- Indexes for table `hardcopy_attachments`
--
ALTER TABLE `hardcopy_attachments`
  ADD PRIMARY KEY (`attachment_id`),
  ADD KEY `hardcopy_attachments_hardcopy_id_created_at_idx` (`hardcopy_id`,`created_at`),
  ADD KEY `hardcopy_attachments_uploaded_by_fkey` (`uploaded_by`);

--
-- Indexes for table `hardcopy_documents`
--
ALTER TABLE `hardcopy_documents`
  ADD PRIMARY KEY (`hardcopy_id`),
  ADD UNIQUE KEY `hardcopy_documents_document_id_key` (`document_id`),
  ADD KEY `hardcopy_documents_asset_id_fkey` (`asset_id`),
  ADD KEY `hardcopy_documents_area_id_fkey` (`area_id`),
  ADD KEY `hardcopy_documents_specific_id_fkey` (`specific_id`),
  ADD KEY `hardcopy_documents_location_id_fkey` (`location_id`),
  ADD KEY `hardcopy_documents_sequence_id_fkey` (`sequence_id`);

--
-- Indexes for table `hardcopy_transfer_history`
--
ALTER TABLE `hardcopy_transfer_history`
  ADD PRIMARY KEY (`transfer_history_id`),
  ADD KEY `hardcopy_transfer_history_transfer_request_id_created_at_idx` (`transfer_request_id`,`created_at`),
  ADD KEY `hardcopy_transfer_history_performed_by_user_id_fkey` (`performed_by_user_id`);

--
-- Indexes for table `hardcopy_transfer_requests`
--
ALTER TABLE `hardcopy_transfer_requests`
  ADD PRIMARY KEY (`transfer_request_id`),
  ADD UNIQUE KEY `hardcopy_transfer_requests_current_workflow_step_id_key` (`current_workflow_step_id`),
  ADD KEY `hardcopy_transfer_requests_document_id_status_idx` (`document_id`,`status`),
  ADD KEY `hardcopy_transfer_requests_assigned_recipient_user_id_recipi_idx` (`assigned_recipient_user_id`,`recipient_acceptance`),
  ADD KEY `hardcopy_transfer_requests_hardcopy_id_fkey` (`hardcopy_id`),
  ADD KEY `hardcopy_transfer_requests_from_area_id_fkey` (`from_area_id`),
  ADD KEY `hardcopy_transfer_requests_from_specific_id_fkey` (`from_specific_id`),
  ADD KEY `hardcopy_transfer_requests_from_asset_id_fkey` (`from_asset_id`),
  ADD KEY `hardcopy_transfer_requests_from_location_id_fkey` (`from_location_id`),
  ADD KEY `hardcopy_transfer_requests_from_sequence_id_fkey` (`from_sequence_id`),
  ADD KEY `hardcopy_transfer_requests_destination_area_id_fkey` (`destination_area_id`),
  ADD KEY `hardcopy_transfer_requests_destination_specific_id_fkey` (`destination_specific_id`),
  ADD KEY `hardcopy_transfer_requests_destination_asset_id_fkey` (`destination_asset_id`),
  ADD KEY `hardcopy_transfer_requests_destination_location_id_fkey` (`destination_location_id`),
  ADD KEY `hardcopy_transfer_requests_destination_sequence_id_fkey` (`destination_sequence_id`),
  ADD KEY `hardcopy_transfer_requests_requested_by_user_id_fkey` (`requested_by_user_id`),
  ADD KEY `hardcopy_transfer_requests_approver_user_id_fkey` (`approver_user_id`),
  ADD KEY `hardcopy_transfer_requests_workflow_version_id_fkey` (`workflow_version_id`),
  ADD KEY `hardcopy_transfer_requests_accepted_by_user_id_fkey` (`accepted_by_user_id`);

--
-- Indexes for table `hardcopy_transfer_workflow_history`
--
ALTER TABLE `hardcopy_transfer_workflow_history`
  ADD PRIMARY KEY (`workflow_history_id`),
  ADD KEY `hardcopy_transfer_workflow_history_workflow_step_id_created__idx` (`workflow_step_id`,`created_at`),
  ADD KEY `hardcopy_transfer_workflow_history_performed_by_user_id_fkey` (`performed_by_user_id`);

--
-- Indexes for table `hardcopy_transfer_workflow_steps`
--
ALTER TABLE `hardcopy_transfer_workflow_steps`
  ADD PRIMARY KEY (`workflow_step_id`),
  ADD UNIQUE KEY `hardcopy_transfer_workflow_steps_transfer_request_id_node_ke_key` (`transfer_request_id`,`node_key`),
  ADD KEY `hardcopy_transfer_workflow_steps_assigned_user_id_status_idx` (`assigned_user_id`,`status`),
  ADD KEY `hardcopy_transfer_workflow_steps_transfer_request_id_status_idx` (`transfer_request_id`,`status`),
  ADD KEY `hardcopy_transfer_workflow_steps_assigned_role_id_fkey` (`assigned_role_id`),
  ADD KEY `hardcopy_transfer_workflow_steps_acted_by_user_id_fkey` (`acted_by_user_id`);

--
-- Indexes for table `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`location_id`),
  ADD UNIQUE KEY `locations_location_name_key` (`location_name`),
  ADD UNIQUE KEY `locations_location_code_key` (`location_code`),
  ADD KEY `locations_asset_id_idx` (`asset_id`),
  ADD KEY `locations_specific_id_idx` (`specific_id`);

--
-- Indexes for table `notification_reads`
--
ALTER TABLE `notification_reads`
  ADD PRIMARY KEY (`notification_read_id`),
  ADD UNIQUE KEY `notification_reads_user_id_event_key_key` (`user_id`,`event_key`),
  ADD KEY `notification_reads_user_id_read_at_idx` (`user_id`,`read_at`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`permission_id`),
  ADD UNIQUE KEY `permissions_permission_name_key` (`permission_name`),
  ADD UNIQUE KEY `permissions_module_key_action_key_key` (`module_key`,`action_key`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`role_id`),
  ADD UNIQUE KEY `roles_role_name_key` (`role_name`);

--
-- Indexes for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD PRIMARY KEY (`role_permission_id`),
  ADD UNIQUE KEY `role_permissions_role_id_permission_id_key` (`role_id`,`permission_id`),
  ADD KEY `role_permissions_permission_id_fkey` (`permission_id`);

--
-- Indexes for table `sequences`
--
ALTER TABLE `sequences`
  ADD PRIMARY KEY (`sequence_id`),
  ADD UNIQUE KEY `sequences_sequence_code_key` (`sequence_code`);

--
-- Indexes for table `softcopy_attachments`
--
ALTER TABLE `softcopy_attachments`
  ADD PRIMARY KEY (`attachment_id`),
  ADD KEY `softcopy_attachments_softcopy_id_created_at_idx` (`softcopy_id`,`created_at`),
  ADD KEY `softcopy_attachments_uploaded_by_fkey` (`uploaded_by`),
  ADD KEY `softcopy_attachments_approved_by_user_id_fkey` (`approved_by_user_id`),
  ADD KEY `softcopy_attachments_rejected_by_user_id_fkey` (`rejected_by_user_id`);

--
-- Indexes for table `softcopy_categories`
--
ALTER TABLE `softcopy_categories`
  ADD PRIMARY KEY (`softcopy_category_id`),
  ADD UNIQUE KEY `softcopy_categories_folder_name_key` (`folder_name`),
  ADD UNIQUE KEY `softcopy_categories_parent_category_id_category_name_key` (`parent_category_id`,`category_name`),
  ADD KEY `softcopy_categories_parent_category_id_idx` (`parent_category_id`),
  ADD KEY `softcopy_categories_created_by_user_id_idx` (`created_by_user_id`);

--
-- Indexes for table `softcopy_documents`
--
ALTER TABLE `softcopy_documents`
  ADD PRIMARY KEY (`softcopy_id`),
  ADD UNIQUE KEY `softcopy_documents_document_id_key` (`document_id`),
  ADD KEY `softcopy_documents_softcopy_category_id_fkey` (`softcopy_category_id`),
  ADD KEY `softcopy_documents_current_revision_id_fkey` (`current_revision_id`);

--
-- Indexes for table `softcopy_revision_artifacts`
--
ALTER TABLE `softcopy_revision_artifacts`
  ADD PRIMARY KEY (`artifact_id`),
  ADD UNIQUE KEY `softcopy_revision_artifacts_revision_id_artifact_type_key` (`revision_id`,`artifact_type`),
  ADD KEY `softcopy_revision_artifacts_source_fingerprint_idx` (`source_fingerprint`);

--
-- Indexes for table `specifics`
--
ALTER TABLE `specifics`
  ADD PRIMARY KEY (`specific_id`),
  ADD KEY `specifics_area_id_fkey` (`area_id`);

--
-- Indexes for table `system_appearance_settings`
--
ALTER TABLE `system_appearance_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `system_sequence_states`
--
ALTER TABLE `system_sequence_states`
  ADD PRIMARY KEY (`sequence_key`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `users_username_key` (`username`),
  ADD KEY `users_role_id_fkey` (`role_id`),
  ADD KEY `users_leader_id_fkey` (`leader_id`);

--
-- Indexes for table `workflow_definitions`
--
ALTER TABLE `workflow_definitions`
  ADD PRIMARY KEY (`workflow_definition_id`),
  ADD UNIQUE KEY `workflow_definitions_workflow_key_key` (`workflow_key`),
  ADD KEY `workflow_definitions_document_type_is_active_idx` (`document_type`,`is_active`),
  ADD KEY `workflow_definitions_created_by_user_id_fkey` (`created_by_user_id`);

--
-- Indexes for table `workflow_versions`
--
ALTER TABLE `workflow_versions`
  ADD PRIMARY KEY (`workflow_version_id`),
  ADD UNIQUE KEY `workflow_versions_workflow_definition_id_version_number_key` (`workflow_definition_id`,`version_number`),
  ADD KEY `workflow_versions_status_published_at_idx` (`status`,`published_at`),
  ADD KEY `workflow_versions_created_by_user_id_fkey` (`created_by_user_id`),
  ADD KEY `workflow_versions_published_by_user_id_fkey` (`published_by_user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `account_registration_requests`
--
ALTER TABLE `account_registration_requests`
  MODIFY `registration_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `areas`
--
ALTER TABLE `areas`
  MODIFY `area_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `asset_numbers`
--
ALTER TABLE `asset_numbers`
  MODIFY `asset_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `audit_log_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `documents`
--
ALTER TABLE `documents`
  MODIFY `document_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1481;

--
-- AUTO_INCREMENT for table `document_access_requests`
--
ALTER TABLE `document_access_requests`
  MODIFY `access_request_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `document_access_request_history`
--
ALTER TABLE `document_access_request_history`
  MODIFY `access_history_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `document_approver_configurations`
--
ALTER TABLE `document_approver_configurations`
  MODIFY `approver_configuration_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `document_assignments`
--
ALTER TABLE `document_assignments`
  MODIFY `document_assignment_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `document_disposal_requests`
--
ALTER TABLE `document_disposal_requests`
  MODIFY `disposal_request_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `document_revisions`
--
ALTER TABLE `document_revisions`
  MODIFY `revision_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `document_status_history`
--
ALTER TABLE `document_status_history`
  MODIFY `history_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `document_workflow_assignment_history`
--
ALTER TABLE `document_workflow_assignment_history`
  MODIFY `assignment_history_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `document_workflow_steps`
--
ALTER TABLE `document_workflow_steps`
  MODIFY `workflow_step_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hardcopy_attachments`
--
ALTER TABLE `hardcopy_attachments`
  MODIFY `attachment_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hardcopy_documents`
--
ALTER TABLE `hardcopy_documents`
  MODIFY `hardcopy_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1476;

--
-- AUTO_INCREMENT for table `hardcopy_transfer_history`
--
ALTER TABLE `hardcopy_transfer_history`
  MODIFY `transfer_history_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hardcopy_transfer_requests`
--
ALTER TABLE `hardcopy_transfer_requests`
  MODIFY `transfer_request_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hardcopy_transfer_workflow_history`
--
ALTER TABLE `hardcopy_transfer_workflow_history`
  MODIFY `workflow_history_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hardcopy_transfer_workflow_steps`
--
ALTER TABLE `hardcopy_transfer_workflow_steps`
  MODIFY `workflow_step_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `locations`
--
ALTER TABLE `locations`
  MODIFY `location_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=89;

--
-- AUTO_INCREMENT for table `notification_reads`
--
ALTER TABLE `notification_reads`
  MODIFY `notification_read_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `permission_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=181;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `role_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `role_permissions`
--
ALTER TABLE `role_permissions`
  MODIFY `role_permission_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=393;

--
-- AUTO_INCREMENT for table `sequences`
--
ALTER TABLE `sequences`
  MODIFY `sequence_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=155;

--
-- AUTO_INCREMENT for table `softcopy_attachments`
--
ALTER TABLE `softcopy_attachments`
  MODIFY `attachment_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `softcopy_categories`
--
ALTER TABLE `softcopy_categories`
  MODIFY `softcopy_category_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `softcopy_documents`
--
ALTER TABLE `softcopy_documents`
  MODIFY `softcopy_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `softcopy_revision_artifacts`
--
ALTER TABLE `softcopy_revision_artifacts`
  MODIFY `artifact_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `specifics`
--
ALTER TABLE `specifics`
  MODIFY `specific_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `workflow_definitions`
--
ALTER TABLE `workflow_definitions`
  MODIFY `workflow_definition_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `workflow_versions`
--
ALTER TABLE `workflow_versions`
  MODIFY `workflow_version_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `account_registration_requests`
--
ALTER TABLE `account_registration_requests`
  ADD CONSTRAINT `account_registration_requests_assigned_role_id_fkey` FOREIGN KEY (`assigned_role_id`) REFERENCES `roles` (`role_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `account_registration_requests_requested_role_id_fkey` FOREIGN KEY (`requested_role_id`) REFERENCES `roles` (`role_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `account_registration_requests_reviewed_by_user_id_fkey` FOREIGN KEY (`reviewed_by_user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `asset_numbers`
--
ALTER TABLE `asset_numbers`
  ADD CONSTRAINT `asset_numbers_specific_id_fkey` FOREIGN KEY (`specific_id`) REFERENCES `specifics` (`specific_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD CONSTRAINT `audit_logs_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `documents`
--
ALTER TABLE `documents`
  ADD CONSTRAINT `documents_created_by_fkey` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `documents_disposed_by_user_id_fkey` FOREIGN KEY (`disposed_by_user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `documents_requested_by_user_id_fkey` FOREIGN KEY (`requested_by_user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `documents_reviewed_by_user_id_fkey` FOREIGN KEY (`reviewed_by_user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `documents_source_document_id_fkey` FOREIGN KEY (`source_document_id`) REFERENCES `documents` (`document_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `documents_workflow_version_id_fkey` FOREIGN KEY (`workflow_version_id`) REFERENCES `workflow_versions` (`workflow_version_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `document_access_requests`
--
ALTER TABLE `document_access_requests`
  ADD CONSTRAINT `document_access_requests_approver_user_id_fkey` FOREIGN KEY (`approver_user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `document_access_requests_document_id_fkey` FOREIGN KEY (`document_id`) REFERENCES `documents` (`document_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `document_access_requests_requested_by_user_id_fkey` FOREIGN KEY (`requested_by_user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `document_access_requests_reviewed_by_user_id_fkey` FOREIGN KEY (`reviewed_by_user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `document_access_request_history`
--
ALTER TABLE `document_access_request_history`
  ADD CONSTRAINT `document_access_request_history_access_request_id_fkey` FOREIGN KEY (`access_request_id`) REFERENCES `document_access_requests` (`access_request_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `document_access_request_history_performed_by_user_id_fkey` FOREIGN KEY (`performed_by_user_id`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE;

--
-- Constraints for table `document_approver_configurations`
--
ALTER TABLE `document_approver_configurations`
  ADD CONSTRAINT `document_approver_configurations_configured_by_user_id_fkey` FOREIGN KEY (`configured_by_user_id`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `document_approver_configurations_document_id_fkey` FOREIGN KEY (`document_id`) REFERENCES `documents` (`document_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `document_approver_configurations_document_owner_user_id_fkey` FOREIGN KEY (`document_owner_user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `document_assignments`
--
ALTER TABLE `document_assignments`
  ADD CONSTRAINT `document_assignments_assigned_by_fkey` FOREIGN KEY (`assigned_by`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `document_assignments_document_id_fkey` FOREIGN KEY (`document_id`) REFERENCES `documents` (`document_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `document_assignments_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `document_disposal_requests`
--
ALTER TABLE `document_disposal_requests`
  ADD CONSTRAINT `document_disposal_requests_document_id_fkey` FOREIGN KEY (`document_id`) REFERENCES `documents` (`document_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `document_disposal_requests_requested_by_user_id_fkey` FOREIGN KEY (`requested_by_user_id`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `document_disposal_requests_reviewed_by_user_id_fkey` FOREIGN KEY (`reviewed_by_user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `document_revisions`
--
ALTER TABLE `document_revisions`
  ADD CONSTRAINT `document_revisions_approved_by_user_id_fkey` FOREIGN KEY (`approved_by_user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `document_revisions_softcopy_id_fkey` FOREIGN KEY (`softcopy_id`) REFERENCES `softcopy_documents` (`softcopy_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `document_revisions_superseded_by_revision_id_fkey` FOREIGN KEY (`superseded_by_revision_id`) REFERENCES `document_revisions` (`revision_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `document_revisions_uploaded_by_fkey` FOREIGN KEY (`uploaded_by`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE;

--
-- Constraints for table `document_status_history`
--
ALTER TABLE `document_status_history`
  ADD CONSTRAINT `document_status_history_document_id_fkey` FOREIGN KEY (`document_id`) REFERENCES `documents` (`document_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `document_status_history_performed_by_fkey` FOREIGN KEY (`performed_by`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE;

--
-- Constraints for table `document_workflow_assignment_history`
--
ALTER TABLE `document_workflow_assignment_history`
  ADD CONSTRAINT `document_workflow_assignment_history_workflow_step_id_fkey` FOREIGN KEY (`workflow_step_id`) REFERENCES `document_workflow_steps` (`workflow_step_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `document_workflow_steps`
--
ALTER TABLE `document_workflow_steps`
  ADD CONSTRAINT `document_workflow_steps_acted_by_user_id_fkey` FOREIGN KEY (`acted_by_user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `document_workflow_steps_assigned_role_id_fkey` FOREIGN KEY (`assigned_role_id`) REFERENCES `roles` (`role_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `document_workflow_steps_assigned_user_id_fkey` FOREIGN KEY (`assigned_user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `document_workflow_steps_document_id_fkey` FOREIGN KEY (`document_id`) REFERENCES `documents` (`document_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `hardcopy_attachments`
--
ALTER TABLE `hardcopy_attachments`
  ADD CONSTRAINT `hardcopy_attachments_hardcopy_id_fkey` FOREIGN KEY (`hardcopy_id`) REFERENCES `hardcopy_documents` (`hardcopy_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `hardcopy_attachments_uploaded_by_fkey` FOREIGN KEY (`uploaded_by`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE;

--
-- Constraints for table `hardcopy_documents`
--
ALTER TABLE `hardcopy_documents`
  ADD CONSTRAINT `hardcopy_documents_area_id_fkey` FOREIGN KEY (`area_id`) REFERENCES `areas` (`area_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `hardcopy_documents_asset_id_fkey` FOREIGN KEY (`asset_id`) REFERENCES `asset_numbers` (`asset_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `hardcopy_documents_document_id_fkey` FOREIGN KEY (`document_id`) REFERENCES `documents` (`document_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `hardcopy_documents_location_id_fkey` FOREIGN KEY (`location_id`) REFERENCES `locations` (`location_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `hardcopy_documents_sequence_id_fkey` FOREIGN KEY (`sequence_id`) REFERENCES `sequences` (`sequence_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `hardcopy_documents_specific_id_fkey` FOREIGN KEY (`specific_id`) REFERENCES `specifics` (`specific_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `hardcopy_transfer_history`
--
ALTER TABLE `hardcopy_transfer_history`
  ADD CONSTRAINT `hardcopy_transfer_history_performed_by_user_id_fkey` FOREIGN KEY (`performed_by_user_id`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `hardcopy_transfer_history_transfer_request_id_fkey` FOREIGN KEY (`transfer_request_id`) REFERENCES `hardcopy_transfer_requests` (`transfer_request_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `hardcopy_transfer_requests`
--
ALTER TABLE `hardcopy_transfer_requests`
  ADD CONSTRAINT `hardcopy_transfer_requests_accepted_by_user_id_fkey` FOREIGN KEY (`accepted_by_user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `hardcopy_transfer_requests_approver_user_id_fkey` FOREIGN KEY (`approver_user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `hardcopy_transfer_requests_assigned_recipient_user_id_fkey` FOREIGN KEY (`assigned_recipient_user_id`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `hardcopy_transfer_requests_current_workflow_step_id_fkey` FOREIGN KEY (`current_workflow_step_id`) REFERENCES `hardcopy_transfer_workflow_steps` (`workflow_step_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `hardcopy_transfer_requests_destination_area_id_fkey` FOREIGN KEY (`destination_area_id`) REFERENCES `areas` (`area_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `hardcopy_transfer_requests_destination_asset_id_fkey` FOREIGN KEY (`destination_asset_id`) REFERENCES `asset_numbers` (`asset_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `hardcopy_transfer_requests_destination_location_id_fkey` FOREIGN KEY (`destination_location_id`) REFERENCES `locations` (`location_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `hardcopy_transfer_requests_destination_sequence_id_fkey` FOREIGN KEY (`destination_sequence_id`) REFERENCES `sequences` (`sequence_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `hardcopy_transfer_requests_destination_specific_id_fkey` FOREIGN KEY (`destination_specific_id`) REFERENCES `specifics` (`specific_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `hardcopy_transfer_requests_document_id_fkey` FOREIGN KEY (`document_id`) REFERENCES `documents` (`document_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `hardcopy_transfer_requests_from_area_id_fkey` FOREIGN KEY (`from_area_id`) REFERENCES `areas` (`area_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `hardcopy_transfer_requests_from_asset_id_fkey` FOREIGN KEY (`from_asset_id`) REFERENCES `asset_numbers` (`asset_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `hardcopy_transfer_requests_from_location_id_fkey` FOREIGN KEY (`from_location_id`) REFERENCES `locations` (`location_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `hardcopy_transfer_requests_from_sequence_id_fkey` FOREIGN KEY (`from_sequence_id`) REFERENCES `sequences` (`sequence_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `hardcopy_transfer_requests_from_specific_id_fkey` FOREIGN KEY (`from_specific_id`) REFERENCES `specifics` (`specific_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `hardcopy_transfer_requests_hardcopy_id_fkey` FOREIGN KEY (`hardcopy_id`) REFERENCES `hardcopy_documents` (`hardcopy_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `hardcopy_transfer_requests_requested_by_user_id_fkey` FOREIGN KEY (`requested_by_user_id`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `hardcopy_transfer_requests_workflow_version_id_fkey` FOREIGN KEY (`workflow_version_id`) REFERENCES `workflow_versions` (`workflow_version_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `hardcopy_transfer_workflow_history`
--
ALTER TABLE `hardcopy_transfer_workflow_history`
  ADD CONSTRAINT `hardcopy_transfer_workflow_history_performed_by_user_id_fkey` FOREIGN KEY (`performed_by_user_id`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `hardcopy_transfer_workflow_history_workflow_step_id_fkey` FOREIGN KEY (`workflow_step_id`) REFERENCES `hardcopy_transfer_workflow_steps` (`workflow_step_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `hardcopy_transfer_workflow_steps`
--
ALTER TABLE `hardcopy_transfer_workflow_steps`
  ADD CONSTRAINT `hardcopy_transfer_workflow_steps_acted_by_user_id_fkey` FOREIGN KEY (`acted_by_user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `hardcopy_transfer_workflow_steps_assigned_role_id_fkey` FOREIGN KEY (`assigned_role_id`) REFERENCES `roles` (`role_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `hardcopy_transfer_workflow_steps_assigned_user_id_fkey` FOREIGN KEY (`assigned_user_id`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `hardcopy_transfer_workflow_steps_transfer_request_id_fkey` FOREIGN KEY (`transfer_request_id`) REFERENCES `hardcopy_transfer_requests` (`transfer_request_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `locations`
--
ALTER TABLE `locations`
  ADD CONSTRAINT `locations_asset_id_fkey` FOREIGN KEY (`asset_id`) REFERENCES `asset_numbers` (`asset_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `locations_specific_id_fkey` FOREIGN KEY (`specific_id`) REFERENCES `specifics` (`specific_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `notification_reads`
--
ALTER TABLE `notification_reads`
  ADD CONSTRAINT `notification_reads_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD CONSTRAINT `role_permissions_permission_id_fkey` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`permission_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `role_permissions_role_id_fkey` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `softcopy_attachments`
--
ALTER TABLE `softcopy_attachments`
  ADD CONSTRAINT `softcopy_attachments_approved_by_user_id_fkey` FOREIGN KEY (`approved_by_user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `softcopy_attachments_rejected_by_user_id_fkey` FOREIGN KEY (`rejected_by_user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `softcopy_attachments_softcopy_id_fkey` FOREIGN KEY (`softcopy_id`) REFERENCES `softcopy_documents` (`softcopy_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `softcopy_attachments_uploaded_by_fkey` FOREIGN KEY (`uploaded_by`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE;

--
-- Constraints for table `softcopy_categories`
--
ALTER TABLE `softcopy_categories`
  ADD CONSTRAINT `softcopy_categories_created_by_user_id_fkey` FOREIGN KEY (`created_by_user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `softcopy_categories_parent_category_id_fkey` FOREIGN KEY (`parent_category_id`) REFERENCES `softcopy_categories` (`softcopy_category_id`) ON UPDATE CASCADE;

--
-- Constraints for table `softcopy_documents`
--
ALTER TABLE `softcopy_documents`
  ADD CONSTRAINT `softcopy_documents_current_revision_id_fkey` FOREIGN KEY (`current_revision_id`) REFERENCES `document_revisions` (`revision_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `softcopy_documents_document_id_fkey` FOREIGN KEY (`document_id`) REFERENCES `documents` (`document_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `softcopy_documents_softcopy_category_id_fkey` FOREIGN KEY (`softcopy_category_id`) REFERENCES `softcopy_categories` (`softcopy_category_id`) ON UPDATE CASCADE;

--
-- Constraints for table `softcopy_revision_artifacts`
--
ALTER TABLE `softcopy_revision_artifacts`
  ADD CONSTRAINT `softcopy_revision_artifacts_revision_id_fkey` FOREIGN KEY (`revision_id`) REFERENCES `document_revisions` (`revision_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `specifics`
--
ALTER TABLE `specifics`
  ADD CONSTRAINT `specifics_area_id_fkey` FOREIGN KEY (`area_id`) REFERENCES `areas` (`area_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_leader_id_fkey` FOREIGN KEY (`leader_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `users_role_id_fkey` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`) ON UPDATE CASCADE;

--
-- Constraints for table `workflow_definitions`
--
ALTER TABLE `workflow_definitions`
  ADD CONSTRAINT `workflow_definitions_created_by_user_id_fkey` FOREIGN KEY (`created_by_user_id`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE;

--
-- Constraints for table `workflow_versions`
--
ALTER TABLE `workflow_versions`
  ADD CONSTRAINT `workflow_versions_created_by_user_id_fkey` FOREIGN KEY (`created_by_user_id`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `workflow_versions_published_by_user_id_fkey` FOREIGN KEY (`published_by_user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `workflow_versions_workflow_definition_id_fkey` FOREIGN KEY (`workflow_definition_id`) REFERENCES `workflow_definitions` (`workflow_definition_id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
