-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jun 11, 2025 at 01:02 PM
-- Server version: 8.0.30
-- PHP Version: 8.3.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `snbt`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `photo`, `slug`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'Tes Pontensi Skolastik', 'assets/category/1742971326_tps (2).png', 'tes-pontensi-skolastik', NULL, '2025-03-26 06:33:44', '2025-03-26 07:56:19'),
(2, 'Tes Literasi', 'assets/category/1742974354_tes literasi (1).png', 'tes-literasi', NULL, '2025-03-26 07:28:31', '2025-05-01 03:23:31'),
(6, 'Tes Penalaran Matematika', 'assets/category/1746069794_calculating.png', 'tes-penalaran-matematika', NULL, '2025-05-01 03:23:14', '2025-05-01 03:23:14'),
(7, 'Tes Kemampuan Akademik', 'assets/category/1748599562_categories-gadgets.svg', 'tes-kemampuan-akademik', NULL, '2025-05-30 10:06:02', '2025-05-30 10:06:02');

-- --------------------------------------------------------

--
-- Table structure for table `districts`
--

CREATE TABLE `districts` (
  `id` char(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `regency_id` char(4) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `essays`
--

CREATE TABLE `essays` (
  `id` bigint UNSIGNED NOT NULL,
  `text` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `question_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `essays`
--

INSERT INTO `essays` (`id`, `text`, `question_id`, `created_at`, `updated_at`) VALUES
(3, 's', 33, '2025-04-03 07:09:55', '2025-04-03 07:09:55'),
(6, 'ini loh hahaah', 12, '2025-04-07 06:02:35', '2025-04-07 08:08:57'),
(8, 'bombardino crocodilo', 40, '2025-04-30 05:52:49', '2025-04-30 05:52:49'),
(9, 'universitas brawijaya', 41, '2025-05-13 05:24:28', '2025-05-13 05:24:28'),
(10, 'reza', 42, '2025-05-13 05:45:06', '2025-05-13 05:45:06'),
(11, 'reza', 43, '2025-05-13 05:46:45', '2025-05-13 05:46:45'),
(12, '7', 50, '2025-05-22 03:27:53', '2025-05-22 03:27:53'),
(13, 'reza', 75, '2025-06-03 03:26:12', '2025-06-03 03:26:12'),
(14, 'f', 81, '2025-06-08 12:35:05', '2025-06-08 12:35:05'),
(19, 'd', 92, '2025-06-09 08:07:46', '2025-06-09 08:07:46');

-- --------------------------------------------------------

--
-- Table structure for table `exams`
--

CREATE TABLE `exams` (
  `id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_published` tinyint(1) NOT NULL DEFAULT '0',
  `exam_type` enum('latihan soal','tryout') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tanggal_dibuka` date DEFAULT NULL,
  `tanggal_ditutup` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `exam_category_id` bigint UNSIGNED DEFAULT NULL,
  `sub_category_id` bigint UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `exams`
--

INSERT INTO `exams` (`id`, `title`, `description`, `slug`, `is_published`, `exam_type`, `created_by`, `tanggal_dibuka`, `tanggal_ditutup`, `created_at`, `updated_at`, `exam_category_id`, `sub_category_id`) VALUES
(1, 'Latihan Soal Penalaran Umum', '<p>dfdfdfd</p>', 'latihan-soal-penalaran-umum', 1, 'latihan soal', 'Ilyas', NULL, NULL, '2025-04-01 06:55:36', '2025-05-24 09:44:18', NULL, 2),
(3, 'Tryout 1', NULL, 'tryout-1', 1, 'tryout', 'Reza Nurfa Ilyas', '2025-05-23', '2025-05-24', '2025-04-07 05:45:54', '2025-05-25 04:18:13', NULL, NULL),
(4, 'Test 3x', NULL, 'test-3x', 1, 'latihan soal', 'Reza Nurfa Ilyas', NULL, NULL, '2025-04-08 07:01:20', '2025-04-29 06:55:00', NULL, 2),
(8, 'Tryout 2', NULL, 'tryout-2', 1, 'tryout', 'Reza Nurfa Ilyas', '2025-05-15', '2025-05-27', '2025-04-30 04:54:53', '2025-05-28 03:26:33', NULL, NULL),
(9, 'latihan soal 2', '<p>latihan soal testing</p>', 'latihan-soal-2', 1, 'latihan soal', 'Budi Hartono', NULL, NULL, '2025-04-30 05:04:23', '2025-06-05 04:49:01', NULL, 2),
(11, 'Latihan soall 3', NULL, 'latihan-soall-3', 1, 'latihan soal', 'Reza Nurfa Ilyas', NULL, NULL, '2025-05-13 05:30:15', '2025-05-13 06:17:37', NULL, NULL),
(12, 'Tryout 4', NULL, 'tryout-4', 1, 'tryout', 'Reza Nurfa Ilyas', '2025-05-17', '2025-05-19', '2025-05-13 07:55:29', '2025-05-25 08:40:34', NULL, NULL),
(13, 'Latihan Soal 5', NULL, 'latihan-soal-5', 1, 'latihan soal', 'Ilyas', NULL, NULL, '2025-05-13 08:08:06', '2025-05-24 09:45:32', NULL, 2),
(14, 'Tryout 5', NULL, 'tryout-5', 1, 'tryout', 'Reza Nurfa Ilyas', '2025-05-28', '2025-05-29', '2025-05-14 03:21:50', '2025-05-28 11:53:45', NULL, NULL),
(15, 'Tryout 6', NULL, 'tryout-6', 0, 'tryout', 'Reza Nurfa Ilyas', '2025-05-14', '2025-05-15', '2025-05-14 04:17:23', '2025-05-14 04:17:23', NULL, NULL),
(16, 'Tryout 7', NULL, 'tryout-7', 1, 'tryout', 'Reza Nurfa Ilyas', '2025-05-24', '2025-05-24', '2025-05-23 08:55:08', '2025-05-24 08:38:40', NULL, NULL),
(17, 'Latihan Soal 7', NULL, 'latihan-soal-7', 1, 'latihan soal', 'Reza Nurfa Ilyas', NULL, NULL, '2025-05-24 09:36:26', '2025-05-26 07:46:12', NULL, 8),
(18, 'Tryout 8', NULL, 'tryout-8', 1, 'tryout', 'Budi Hartono', '2025-06-03', '2025-06-10', '2025-05-25 04:01:28', '2025-06-11 11:48:56', NULL, NULL),
(19, 'Matematika 1', NULL, 'matematika-1', 1, 'latihan soal', 'Reza Nurfa Ilyas', NULL, NULL, '2025-05-30 10:08:32', '2025-05-30 10:08:32', NULL, 9),
(20, 'Tryout 9', NULL, 'tryout-9', 1, 'tryout', 'Andi', '2025-06-02', '2025-06-02', '2025-06-03 03:25:25', '2025-06-03 03:28:17', NULL, NULL),
(21, 'Matematika 2', NULL, 'matematika-2', 0, 'latihan soal', 'Budi Hartono', NULL, NULL, '2025-06-05 04:01:02', '2025-06-05 04:01:02', NULL, 9),
(23, 'Testing', NULL, 'testing', 1, 'latihan soal', 'Budi Hartono', NULL, NULL, '2025-06-09 03:13:29', '2025-06-09 03:46:48', NULL, 4),
(24, 'Tryout 12', NULL, 'tryout-12', 1, 'tryout', 'Budi Hartono', '2025-06-08', '2025-06-08', '2025-06-09 05:36:58', '2025-06-09 08:09:02', NULL, NULL),
(25, 'Tryout 13', NULL, 'tryout-13', 1, 'tryout', 'Budi Hartono', '2025-06-09', '2025-06-10', '2025-06-10 04:56:59', '2025-06-11 12:02:16', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `majors`
--

CREATE TABLE `majors` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `level` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `passing_score` float NOT NULL,
  `quota` int NOT NULL,
  `peminat` int NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `university_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `majors`
--

INSERT INTO `majors` (`id`, `name`, `level`, `passing_score`, `quota`, `peminat`, `slug`, `university_id`, `created_at`, `updated_at`) VALUES
(1, 'PENDIDIKAN DOKTER', 'S1', 854.48, 90, 3275, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(2, 'PENDIDIKAN DOKTER GIGI', 'S1', 800.95, 54, 1104, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(3, 'MATEMATIKA', 'S1', 702.4, 30, 315, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(4, 'FISIKA', 'S1', 626.01, 42, 225, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(5, 'KIMIA', 'S1', 694.88, 42, 309, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(6, 'BIOLOGI', 'S1', 684.57, 36, 398, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(7, 'FARMASI', 'S1', 824.33, 54, 1070, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(8, 'GEOGRAFI', 'S1', 702.58, 42, 322, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(9, 'TEKNIK SIPIL', 'S1', 767.52, 60, 919, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(10, 'TEKNIK MESIN', 'S1', 780.05, 60, 780, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(11, 'TEKNIK ELEKTRO', 'S1', 775.08, 51, 877, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(12, 'TEKNIK METALURGI & MATERIAL', 'S1', 771.25, 51, 756, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(13, 'ARSITEKTUR', 'S1', 786.79, 36, 819, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(14, 'TEKNIK KIMIA', 'S1', 745.43, 51, 664, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(15, 'ILMU KEPERAWATAN', 'S1', 816.01, 73, 961, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(16, 'ILMU KOMPUTER', 'S1', 831.25, 75, 1900, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(17, 'ILMU KESEHATAN MASYARAKAT', 'S1', 805.34, 63, 1088, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(18, 'TEKNIK INDUSTRI', 'S1', 806.84, 78, 1367, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(19, 'TEKNIK PERKAPALAN', 'S1', 695.62, 39, 477, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(20, 'TEKNIK LINGKUNGAN', 'S1', 717.23, 39, 689, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(21, 'TEKNIK KOMPUTER', 'S1', 798.6, 42, 909, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(22, 'SISTEM INFORMASI', 'S1', 826.85, 75, 1954, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(23, 'ARSITEKTUR INTERIOR', 'S1', 719.55, 20, 431, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(24, 'TEKNOLOGI BIOPROSES', 'S1', 633.24, 30, 369, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(25, 'GIZI', 'S1', 770.85, 20, 622, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(26, 'KESEHATAN LINGKUNGAN', 'S1', 681.95, 18, 441, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(27, 'KESELAMATAN DAN KESEHATAN KERJA', 'S1', 741.46, 27, 877, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(28, 'GEOFISIKA', 'S1', 624.95, 26, 315, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(29, 'GEOLOGI', 'S1', 672.78, 26, 323, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(30, 'STATISTIKA', 'S1', 737.68, 26, 520, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(31, 'AKTUARIA', 'S1', 754.71, 26, 519, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(32, 'TEKNIK BIOMEDIS', 'S1', 726.7, 15, 303, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(33, 'ILMU HUKUM', 'S1', 853.02, 171, 3883, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(34, 'ARKEOLOGI INDONESIA', 'S1', 595.64, 24, 371, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(35, 'ILMU SEJARAH', 'S1', 616.88, 24, 298, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(36, 'ILMU PSIKOLOGI', 'S1', 845.08, 99, 3088, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(37, 'ILMU KOMUNIKASI', 'S1', 834.13, 48, 2271, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(38, 'ILMU POLITIK', 'S1', 711.35, 24, 550, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(39, 'ILMU ADMINISTRASI NEGARA', 'S1', 772.47, 57, 1328, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(40, 'KRIMINOLOGI', 'S1', 815.24, 18, 1246, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(41, 'SOSIOLOGI', 'S1', 706.12, 24, 528, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(42, 'ILMU KESEJAHTERAAN SOSIAL', 'S1', 724.7, 24, 760, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(43, 'ANTROPOLOGI SOSIAL', 'S1', 672.61, 24, 510, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(44, 'ILMU EKONOMI', 'S1', 787.21, 63, 938, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(45, 'ILMU ADMINISTRASI NIAGA', 'S1', 777.21, 57, 1700, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(46, 'ILMU ADMINISTRASI FISKAL', 'S1', 793.71, 57, 1439, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(47, 'MANAJEMEN', 'S1', 846.42, 114, 2915, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(48, 'AKUNTANSI', 'S1', 841.58, 105, 2554, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(49, 'ILMU HUBUNGAN INTERNASIONAL', 'S1', 807.4, 18, 1255, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(50, 'ILMU PERPUSTAKAAN', 'S1', 727.16, 24, 522, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(51, 'ILMU FILSAFAT', 'S1', 633.95, 24, 324, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(52, 'SASTRA INDONESIA', 'S1', 707.11, 24, 369, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(53, 'SASTRA DAERAH UNTUK SASTRA JAWA', 'S1', 559.45, 24, 156, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(54, 'SASTRA JEPANG', 'S1', 749.64, 24, 594, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(55, 'SASTRA CINA', 'S1', 650.17, 24, 350, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(56, 'SASTRA ARAB', 'S1', 733.78, 24, 470, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(57, 'SASTRA PERANCIS', 'S1', 594.84, 17, 221, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(58, 'SASTRA INGGRIS', 'S1', 803.7, 24, 841, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(59, 'SASTRA JERMAN', 'S1', 620.87, 17, 247, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(60, 'SASTRA BELANDA', 'S1', 603.87, 24, 248, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(61, 'SASTRA RUSIA', 'S1', 589.25, 24, 164, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(62, 'BAHASA DAN KEBUDAYAAN KOREA', 'S1', 763.28, 17, 580, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(63, 'ILMU EKONOMI ISLAM', 'S1', 720.92, 18, 415, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(64, 'BISNIS ISLAM', 'S1', 739.99, 18, 492, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(65, 'MANAJEMEN BISNIS PARIWISATA', 'D4', 728.1, 47, 2280, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(66, 'TERAPI OKUPASI', 'D4', 589.26, 47, 1282, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(67, 'FISIOTERAPI', 'D4', 686.72, 47, 2580, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(68, 'MANAJEMEN REKOD DAN ARSIP', 'D4', 624.47, 47, 1671, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(69, 'BISNIS KREATIF', 'D4', 730.51, 47, 4966, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(70, 'PRODUKSI MEDIA', 'D4', 705.48, 47, 3682, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(71, 'ADMINISTRASI PERPAJAKAN', 'D3', 656.46, 30, 3329, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(72, 'ADMINISTRASI PERKANTORAN', 'D3', 655.9, 30, 2763, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(73, 'ADMINISTRASI RUMAH SAKIT', 'D3', 605.18, 30, 3001, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(74, 'PENYIARAN MULTIMEDIA', 'D3', 595.08, 30, 2588, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(75, 'ADMINISTRASI ASURANSI & AKTUARIA', 'D3', 551.72, 30, 1927, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(76, 'HUBUNGAN MASYARAKAT', 'D3', 560.34, 30, 4788, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(77, 'PERIKLANAN KREATIF', 'D3', 556.87, 30, 2650, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(78, 'AKUNTANSI', 'D3', 656.33, 30, 3949, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(79, 'ADMINISTRASI KEUANGAN DAN PERBANKAN', 'D3', 585.11, 30, 3216, NULL, 1, '2025-05-23 07:11:21', '2025-05-23 07:11:21'),
(80, 'BIOLOGI', 'S1', 774.35, 68, 516, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(81, 'FARMASI', 'S1', 837.79, 72, 2004, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(82, 'GEOGRAFI LINGKUNGAN', 'S1', 775.35, 30, 362, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(83, 'KARTOGRAFI DAN PENGINDERAAN JAUH', 'S1', 740.7, 30, 346, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(84, 'PEMBANGUNAN WILAYAH', 'S1', 753.34, 24, 289, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(85, 'KEDOKTERAN', 'S1', 847.88, 53, 3889, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(86, 'ILMU KEPERAWATAN', 'S1', 809.91, 36, 1178, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(87, 'GIZI', 'S1', 811.84, 30, 1092, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(88, 'KEDOKTERAN GIGI', 'S1', 821.89, 47, 1350, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(89, 'KEDOKTERAN HEWAN', 'S1', 808.39, 60, 789, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(90, 'FISIKA', 'S1', 703.6, 21, 151, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(91, 'KIMIA', 'S1', 739.94, 45, 414, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(92, 'MATEMATIKA', 'S1', 751.19, 20, 336, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(93, 'ILMU KOMPUTER', 'S1', 815.7, 27, 1219, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(94, 'STATISTIKA', 'S1', 792.81, 20, 544, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(95, 'GEOFISIKA', 'S1', 745.16, 21, 217, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(96, 'ELEKTRONIKA DAN INSTRUMENTASI', 'S1', 740.44, 27, 330, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(97, 'AGRONOMI', 'S1', 736.16, 24, 241, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(98, 'ILMU TANAH', 'S1', 729.37, 23, 216, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(99, 'EKONOMI PERTANIAN DAN AGRIBISNIS', 'S1', 777.66, 27, 483, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(100, 'PROTEKSI TANAMAN (ILMU HAMA DAN PENYAKIT TUMBUHAN)', 'S1', 701.57, 23, 305, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(101, 'PENYULUHAN DAN KOMUNIKASI PERTANIAN', 'S1', 701.14, 9, 162, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(102, 'AKUAKULTUR (BUDIDAYA PERIKANAN)', 'S1', 725.97, 23, 228, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(103, 'TEKNOLOGI HASIL PERIKANAN', 'S1', 719.24, 23, 129, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(104, 'MANAJEMEN SUMBERDAYA AKUATIK (MANAJEMEN SUMBER DAYA PERIKANAN)', 'S1', 707.95, 23, 273, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(105, 'MIKROBIOLOGI PERTANIAN', 'S1', 704.87, 11, 134, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(106, 'ILMU DAN INDUSTRI PETERNAKAN', 'S1', 801.81, 90, 694, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(107, 'ARSITEKTUR', 'S1', 807.17, 24, 944, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(108, 'PERENCANAAN WILAYAH DAN KOTA', 'S1', 799.28, 18, 674, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(109, 'TEKNIK GEODESI', 'S1', 778.87, 38, 527, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(110, 'TEKNIK GEOLOGI', 'S1', 802.06, 36, 1105, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(111, 'TEKNIK KIMIA', 'S1', 789.43, 42, 800, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(112, 'TEKNIK ELEKTRO', 'S1', 784.26, 30, 755, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(113, 'TEKNIK MESIN', 'S1', 804.13, 51, 1019, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(114, 'TEKNIK SIPIL', 'S1', 811.86, 33, 1336, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(115, 'TEKNIK NUKLIR', 'S1', 755.46, 15, 377, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(116, 'TEKNIK FISIKA', 'S1', 747.96, 42, 215, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(117, 'TEKNIK INDUSTRI', 'S1', 814.64, 36, 1429, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(118, 'TEKNIK PERTANIAN', 'S1', 740.42, 27, 303, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(119, 'TEKNOLOGI PANGAN DAN HASIL PERTANIAN', 'S1', 807.9, 33, 1015, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(120, 'TEKNOLOGI INDUSTRI PERTANIAN', 'S1', 748.31, 30, 388, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(121, 'HIGIENE GIGI', 'S1', 735.3, 17, 300, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(122, 'KEHUTANAN', 'S1', 817.78, 90, 1030, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(123, 'TEKNOLOGI INFORMASI', 'S1', 833.89, 24, 1627, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(124, 'ILMU AKTUARIA', 'S1', 775.32, 17, 417, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(125, 'TEKNIK BIOMEDIS', 'S1', 751.6, 18, 452, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(126, 'TEKNIK INFRASTRUKTUR LINGKUNGAN', 'S1', 730.54, 15, 557, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(127, 'ILMU EKONOMI', 'S1', 799.65, 30, 931, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(128, 'MANAJEMEN', 'S1', 842.72, 45, 2604, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(129, 'AKUNTANSI', 'S1', 833.92, 45, 2325, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(130, 'FILSAFAT', 'S1', 778.9, 45, 535, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(131, 'HUKUM', 'S1', 846.55, 96, 3584, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(132, 'ANTROPOLOGI BUDAYA', 'S1', 775.61, 30, 451, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(133, 'ARKEOLOGI', 'S1', 748.12, 21, 353, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(134, 'SEJARAH', 'S1', 718.09, 15, 248, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(135, 'SASTRA ARAB', 'S1', 776.41, 21, 429, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(136, 'BAHASA DAN SASTRA INDONESIA', 'S1', 771.16, 27, 448, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(137, 'SASTRA INGGRIS', 'S1', 801.63, 21, 708, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(138, 'BAHASA, SASTRA, DAN BUDAYA JAWA', 'S1', 714.03, 15, 190, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(139, 'BAHASA DAN SASTRA PRANCIS', 'S1', 705.28, 14, 134, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(140, 'BAHASA DAN KEBUDAYAAN JEPANG', 'S1', 768.99, 18, 393, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(141, 'BAHASA DAN KEBUDAYAAN KOREA', 'S1', 782.43, 18, 586, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(142, 'MANAJEMEN DAN KEBIJAKAN PUBLIK', 'S1', 802.96, 24, 1075, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(143, 'ILMU HUBUNGAN INTERNASIONAL', 'S1', 821.95, 24, 1482, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(144, 'POLITIK DAN PEMERINTAHAN', 'S1', 796.61, 24, 659, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(145, 'PEMBANGUNAN SOSIAL DAN KESEJAHTERAAN', 'S1', 783.62, 24, 889, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(146, 'ILMU KOMUNIKASI', 'S1', 826.34, 24, 1614, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(147, 'SOSIOLOGI', 'S1', 758.13, 24, 420, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(148, 'PSIKOLOGI', 'S1', 849.7, 68, 4022, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(149, 'PARIWISATA', 'S1', 805.3, 21, 874, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(150, 'TEKNIK SUMBER DAYA AIR', 'S1', 730.52, 15, 353, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(151, 'MANAJEMEN INFORMASI KESEHATAN', 'D4', 800.91, 36, 3808, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(152, 'TEKNOLOGI REKAYASA PERANGKAT LUNAK', 'D4', 780.89, 29, 2167, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(153, 'TEKNOLOGI REKAYASA ELEKTRO', 'D4', 713.79, 22, 1109, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(154, 'TEKNOLOGI REKAYASA INSTRUMENTASI DAN KONTROL', 'D4', 704.44, 22, 529, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(155, 'TEKNOLOGI REKAYASA INTERNET', 'D4', 749.89, 29, 1075, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(156, 'TEKNIK PENGELOLAAN DAN PEMELIHARAAN INFRASTRUKTUR SIPIL', 'D4', 738.09, 18, 1571, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(157, 'TEKNOLOGI REKAYASA MESIN', 'D4', 708.32, 18, 929, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(158, 'TEKNIK PENGELOLAAN DAN PERAWATAN ALAT BERAT', 'D4', 725.85, 18, 788, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(159, 'PENGELOLAAN HUTAN', 'D4', 741.59, 27, 1386, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(160, 'TEKNOLOGI VETERINER', 'D4', 714.9, 27, 755, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(161, 'PENGEMBANGAN PRODUK AGROINDUSTRI', 'D4', 716.45, 27, 1201, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(162, 'TEKNOLOGI SURVEI DAN PEMETAAN DASAR', 'D4', 711.1, 18, 568, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(163, 'SISTEM INFORMASI GEOGRAFIS', 'D4', 737.93, 18, 894, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(164, 'TEKNOLOGI REKAYASA PELAKSANAAN BANGUNAN SIPIL', 'D4', 717.1, 18, 953, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(165, 'MANAJEMEN DAN PENILAIAN PROPERTI', 'D4', 768.38, 30, 1663, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(166, 'PERBANKAN', 'D4', 759.64, 36, 2144, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(167, 'AKUNTANSI SEKTOR PUBLIK', 'D4', 790.68, 30, 3606, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(168, 'PEMBANGUNAN EKONOMI KEWILAYAHAN', 'D4', 731.11, 30, 1607, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(169, 'PENGELOLAAN ARSIP DAN REKAMAN INFORMASI', 'D4', 786.54, 18, 1517, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(170, 'BAHASA INGGRIS', 'D4', 757.34, 18, 1971, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(171, 'BISNIS PERJALANAN WISATA', 'D4', 775.13, 27, 1865, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(172, 'BAHASA JEPANG UNTUK KOMUNIKASI BISNIS DAN PROFESIONAL', 'D4', 775.34, 15, 1352, NULL, 2, '2025-05-23 07:32:19', '2025-05-23 07:32:19'),
(173, 'FAKULTAS ILMU DAN TEKNOLOGI KEBUMIAN (FITB)', 'S1', 762.48, 150, 1267, NULL, 3, '2025-06-04 12:13:42', '2025-06-04 12:13:42'),
(174, 'FAKULTAS TEKNIK PERTAMBANGAN DAN PERMINYAKAN (FTTM)', 'S1', 844.83, 123, 3492, NULL, 3, '2025-06-04 12:13:42', '2025-06-04 12:13:42'),
(175, 'SEKOLAH FARMASI (SF)', 'S1', 787.82, 58, 895, NULL, 3, '2025-06-04 12:13:42', '2025-06-04 12:13:42'),
(176, 'SEKOLAH ILMU DAN TEKNOLOGI HAYATI - SAINS (SITH-S)', 'S1', 727.77, 45, 351, NULL, 3, '2025-06-04 12:13:42', '2025-06-04 12:13:42'),
(177, 'FAKULTAS TEKNIK MESIN DAN DIRGANTARA (FTMD)', 'S1', 776.48, 100, 1692, NULL, 3, '2025-06-04 12:13:42', '2025-06-04 12:13:42'),
(178, 'SEKOLAH ARSITEKTUR, PERENCANAAN DAN PENGEMBANGAN KEBIJAKAN (SAPPK)', 'S1', 772.93, 59, 1197, NULL, 3, '2025-06-04 12:13:42', '2025-06-04 12:13:42'),
(179, 'SEKOLAH ILMU DAN TEKNOLOGI HAYATI - REKAYASA (SITH-R)', 'S1', 732.94, 71, 513, NULL, 3, '2025-06-04 12:13:42', '2025-06-04 12:13:42'),
(180, 'FAKULTAS TEKNOLOGI INDUSTRI - KAMPUS CIREBON (FTI-C)', 'S1', 720.89, 27, 518, NULL, 3, '2025-06-04 12:13:42', '2025-06-04 12:13:42'),
(181, 'SEKOLAH ARSITEKTUR, PERENCANAAN DAN PENGEMBANGAN KEBIJAKAN - KAMPUS CIREBON (SAPPK-C)', 'S1', 719.54, 25, 338, NULL, 3, '2025-06-04 12:13:42', '2025-06-04 12:13:42'),
(182, 'FAKULTAS TEKNIK PERTAMBANGAN DAN PERMINYAKAN - KAMPUS CIREBON (FTTM-C)', 'S1', 738.49, 60, 1406, NULL, 3, '2025-06-04 12:13:42', '2025-06-04 12:13:42'),
(183, 'FAKULTAS ILMU DAN TEKNOLOGI KEBUMIAN - KAMPUS CIREBON (FITB-C)', 'S1', 718.65, 25, 250, NULL, 3, '2025-06-04 12:13:42', '2025-06-04 12:13:42'),
(184, 'FAKULTAS MATEMATIKA DAN ILMU PENGETAHUAN ALAM - MATEMATIKA (FMIPA-M)', 'S1', 758.32, 66, 546, NULL, 3, '2025-06-04 12:13:42', '2025-06-04 12:13:42'),
(185, 'FAKULTAS MATEMATIKA DAN ILMU PENGETAHUAN ALAM - IPA (FMIPA-IPA)', 'S1', 744.7, 136, 542, NULL, 3, '2025-06-04 12:13:42', '2025-06-04 12:13:42'),
(186, 'SEKOLAH TEKNIK ELEKTRO DAN INFORMATIKA - KOMPUTASI (STEI-K)', 'S1', 858.87, 90, 3454, NULL, 3, '2025-06-04 12:13:42', '2025-06-04 12:13:42'),
(187, 'SEKOLAH TEKNIK ELEKTRO DAN INFORMATIKA - REKAYASA (STEI-R)', 'S1', 775.45, 94, 1267, NULL, 3, '2025-06-04 12:13:42', '2025-06-04 12:13:42'),
(188, 'FAKULTAS SENIRUPA DAN DESAIN (FSRD)', 'S1', 791.61, 113, 1755, NULL, 3, '2025-06-04 12:13:42', '2025-06-04 12:13:42'),
(189, 'SEKOLAH BISNIS DAN MANAJEMEN (SBM)', 'S1', 815.77, 54, 2473, NULL, 3, '2025-06-04 12:13:42', '2025-06-04 12:13:42'),
(190, 'FAKULTAS SENIRUPA DAN DESAIN - KAMPUS CIREBON (FSRD-C)', 'S1', 702.32, 42, 241, NULL, 3, '2025-06-04 12:13:42', '2025-06-04 12:13:42'),
(191, 'FAKULTAS TEKNIK SIPIL DAN LINGKUNGAN - INFRASTRUKTUR SIPIL DAN KELAUTAN (FTSL-SI)', 'S1', 740, 106, 1355, NULL, 3, '2025-06-04 12:13:42', '2025-06-04 12:13:42'),
(192, 'FAKULTAS TEKNIK SIPIL DAN LINGKUNGAN - TEKNOLOGI LINGKUNGAN (FTSL-L)', 'S1', 735, 68, 1007, NULL, 3, '2025-06-04 12:13:42', '2025-06-04 12:13:42'),
(193, 'FAKULTAS TEKNOLOGI INDUSTRI - SISTEM DAN PROSES (FTI-SP)', 'S1', 725, 128, 1161, NULL, 3, '2025-06-04 12:13:42', '2025-06-04 12:13:42'),
(194, 'FAKULTAS TEKNOLOGI INDUSTRI - REKAYASA INDUSTRI (FTI-RI)', 'S1', 730, 61, 1231, NULL, 3, '2025-06-04 12:13:42', '2025-06-04 12:13:42'),
(195, 'SEKOLAH ILMU DAN TEKNOLOGI HAYATI - KAMPUS CIREBON (SITH-C)', 'S1', 720, 12, 57, NULL, 3, '2025-06-04 12:13:42', '2025-06-04 12:13:42'),
(196, 'SEKOLAH BISNIS DAN MANAJEMEN - KAMPUS CIREBON (SBM-C)', 'S1', 800, 15, 330, NULL, 3, '2025-06-04 12:13:42', '2025-06-04 12:13:42');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2014_10_12_100000_create_password_resets_table', 1),
(4, '2017_05_02_140432_create_provinces_tables', 1),
(5, '2017_05_02_140444_create_regencies_tables', 1),
(6, '2017_05_02_142019_create_districts_tables', 1),
(7, '2017_05_02_143454_create_villages_tables', 1),
(8, '2019_08_19_000000_create_failed_jobs_table', 1),
(9, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(10, '2024_04_29_075719_create_categories_table', 1),
(13, '2025_03_26_115553_create_exams_table', 2),
(14, '2025_03_26_115610_create_sub_categories_table', 2),
(15, '2025_03_26_130243_create_questions_table', 2),
(28, '2025_03_28_133113_create_pilihan_gandas_table', 3),
(29, '2025_03_28_133123_create_pilihan_majemuks_table', 3),
(30, '2025_03_28_133131_create_isians_table', 3),
(31, '2025_03_28_135100_create_exam_categories_table', 3),
(32, '2025_03_28_140804_create_results_table', 3),
(33, '2025_03_28_140812_create_result_details_table', 3),
(34, '2025_03_28_143352_add_exams_column', 3),
(36, '2025_04_01_125502_add_sub_category_column', 4),
(37, '2025_04_02_113225_create_multiple_choices_table', 5),
(38, '2025_04_02_113255_create_multiple_options_table', 5),
(39, '2025_04_02_113304_create_essays_table', 5),
(40, '2025_04_02_140613_add_sub_category1_column', 6),
(41, '2025_04_02_144358_add_option_column', 7),
(42, '2025_04_03_115819_add_option_column', 8),
(45, '2025_04_29_111345_create_tryout_subtests_table', 9),
(49, '2025_05_15_114557_create_universities_table', 10),
(50, '2025_05_15_114639_create_majors_table', 10),
(51, '2025_05_15_114738_create_user_majors_table', 10),
(52, '2025_06_03_110942_create_results_evaluations_table', 11),
(54, '2025_06_11_114212_create_result_logs_table', 12);

-- --------------------------------------------------------

--
-- Table structure for table `multiple_choices`
--

CREATE TABLE `multiple_choices` (
  `id` bigint UNSIGNED NOT NULL,
  `option1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `option2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `option3` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `option4` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `option5` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `correct_answer` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `question_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `multiple_choices`
--

INSERT INTO `multiple_choices` (`id`, `option1`, `option2`, `option3`, `option4`, `option5`, `correct_answer`, `question_id`, `created_at`, `updated_at`) VALUES
(4, 'Harga pestisida alami yang terjangkau menyebabkan pestisida sering digunakan.', 'Ahli teknologi memproduksi pestisida alami yang memiliki daya kerja lebih cepat.', 'Ahli pertanian memiliki kemampuan dalam menghasilkan pestisida alami yang tahan lama.', 'Pestisida alami membutuhkan waktu lebih lama untuk membasmi hama.', 'Meskipun ramah lingkungan, daya kerja pestisida alami tergolong lambat.', 'Ahli teknologi memproduksi pestisida alami yang memiliki daya kerja lebih cepat.', 7, '2025-04-02 08:45:57', '2025-04-02 08:45:57'),
(7, '2012', '2001', '2021', '2022', '2024', '2021', 17, '2025-04-07 06:35:17', '2025-04-09 05:42:43'),
(9, '1', '2', '3', '34', '4', '34', 37, '2025-04-30 05:50:15', '2025-04-30 05:50:15'),
(10, 'g', 'fg', 'gfgf', 'fgfgf', 'fgfgf', 'g', 39, '2025-04-30 05:52:15', '2025-04-30 05:52:15'),
(11, '2', '32', '323', '3233', '3333', '3333', 44, '2025-05-13 08:10:23', '2025-05-13 08:10:23'),
(12, '1', '2', '3', '34', '4', '1', 46, '2025-05-14 03:22:22', '2025-05-14 03:22:22'),
(13, '34', 'dfd', '4545', 'dfdfdf', '3333', '34', 47, '2025-05-14 03:23:46', '2025-05-14 03:23:46'),
(14, 'fd', 'df', 'fff', 'ff', 'ffffff', 'ff', 48, '2025-05-14 04:18:26', '2025-05-14 04:18:26'),
(15, '1`', '2', '3', '4', '5', '5', 34, '2025-05-15 03:42:01', '2025-05-15 03:42:01'),
(16, 'q', 'w', 'e', 'r', '5', '5', 36, '2025-05-15 03:42:32', '2025-05-15 03:42:32'),
(17, '2', '1', '3', '4', '5', '2', 49, '2025-05-22 03:27:22', '2025-05-22 03:27:22'),
(18, '1', '2', '3', '4', '5', '2', 51, '2025-05-24 08:55:33', '2025-05-24 08:55:33'),
(19, '2', '3', '4', '45', '5', '5', 52, '2025-05-24 08:55:50', '2025-05-24 08:55:50'),
(21, '$0$', '$\\frac{1}{2}$', '$1$', '$\\infty$', '$2$', '$0$', 54, '2025-05-26 07:45:20', '2025-05-27 05:20:18'),
(22, '1', '2', '3', '4', '5', '5', 55, '2025-05-26 08:10:54', '2025-05-27 05:29:31'),
(23, 'khasiat susu bagi manusia', 'manfaat susu fermentasi bagi konsumsi intoleran susu', 'kelebihan susu fermentasi', 'penanganan kendala mengonsumsi susu', 'kandungan gizi susu bubuk dengan kadar laktosa rendah', 'penanganan kendala mengonsumsi susu', 56, '2025-05-27 03:24:06', '2025-05-27 05:41:20'),
(25, 'Mengapa penderita intoleran tidak mau mengonsumsi susu?', 'Bagaimanakah mengurangi kadar laktosa pada susu?', 'Bagaimanakah proses fermentasi susu?', 'Benarkah bahwa semua susu bubuk berkadar laktosa rendah?', 'Apakah susu fermentasi lebih baik daripada susu yang tidak difermentasi?', 'Mengapa penderita intoleran tidak mau mengonsumsi susu?', 61, '2025-05-27 03:45:59', '2025-05-27 06:55:24'),
(26, 'Orang yang tidak suka minum susu karena tidak suka dengan rasa atau bau susu.', 'Orang yang secara biologis menghindari minum susu karena kandungan laktosa susu.', 'Orang yang secara biologis tidak dapat mencerna kandungan laktosa susu.', 'Orang yang suka minum susu yang sudah diubah rasa dan baunya.', 'Orang yang secara biologis hanya boleh minum susu yang sudah difermentasi.', 'Orang yang secara biologis tidak dapat mencerna kandungan laktosa susu.', 62, '2025-05-27 03:49:41', '2025-05-27 06:55:35'),
(27, 'Penyebab orang tidak menyukai susu, penderita intoleran susu, dan manfaat susu fermentasi.', 'Khasiat susu bagi tubuh, penderita intoleran susu, dan masalah kesehatan manula.', 'Cara mengatasi laktosa penderita intoleran susu, pentingnya susu kadar laktosa rendah, dan keuntungan susu fermentasi.', 'Kemungkinan orang tidak suka susu, penderita intoleran susu, dan cara mengatasi masalah penderita yang mengalami kesulitan mencerna makanan berprotein tinggi.', 'Khasiat susu bagi tubuh, kandungan laktosa dalam susu, dan berbagai keuntungan mengonsumsi susu fermentasi.', 'Penyebab orang tidak menyukai susu, penderita intoleran susu, dan manfaat susu fermentasi.', 63, '2025-05-27 03:51:31', '2025-05-27 06:55:49'),
(28, 'kecepatan dorongan lempeng Indo-Australia terhadap Pulau Sumatra', 'sejarah terbentuknya benua dan pulau', 'terbentuknya lempeng pada lapisan bumi', 'pergerakan lempeng Indo-Australia mendesak lempeng Eurasia', 'posisi Pulau Jawa dan Sumatra di lempeng Eurasia', 'sejarah terbentuknya benua dan pulau', 64, '2025-05-27 03:52:50', '2025-05-27 06:56:04'),
(29, 'kerusakan alam dan lingkungan hidup akibat ulah manusia', 'terancamnya eksistensi planet bumi akibat krisis lingkungan', 'adanya banjir tahunan akibat kerusakan lingkungan hidup', 'adanya krisis lingkungan dalam skala nasional dan global', 'ledakan hama dan penyakit merupakan gejala lain yang serius mengancam penghidupan di planet bumi', 'kerusakan alam dan lingkungan hidup akibat ulah manusia', 65, '2025-05-27 03:55:34', '2025-05-27 06:56:47'),
(30, '(1)', '(3)', '(4)', '(6)', '(8)', '(4)', 66, '2025-05-27 03:57:37', '2025-05-27 06:56:59'),
(31, '(11)', '(12)', '(13)', '(14)', '(15)', '(12)', 67, '2025-05-27 03:59:06', '2025-05-27 06:57:12'),
(32, 'Manusia memandang alam sebagai bagian dari kehidupannya.', 'Adanya kesalahan cara pandang manusia terhadap alam.', 'Cara pandang seseorang memengaruhi perilakunya.', 'Cara pandang manusia terhadap alam berbeda-beda.', 'Ada berbagai bentuk kerusakan lingkungan di muka bumi ini.', 'Adanya kesalahan cara pandang manusia terhadap alam.', 68, '2025-05-27 04:01:35', '2025-05-27 06:59:08'),
(33, '(1) dan (3)', '(2) dan (5)', '(6) dan (8)', '(5) dan (8)', '(7) dan (9)', '(7) dan (9)', 69, '2025-05-27 04:06:36', '2025-05-27 06:59:24'),
(34, 'r', 'r', 'r', '<img src=\"../../../storage/images/desain uas.png\" alt=\"\" width=\"908\" height=\"480\">', '<img src=\"../../../storage/images/erd.jpg\" alt=\"\" width=\"400\" height=\"287\">', '<img src=\"../../../storage/images/desain uas.png\" alt=\"\" width=\"908\" height=\"480\">', 70, '2025-05-27 05:43:17', '2025-05-27 06:52:40'),
(35, '<img src=\"../../storage/images/categories-baby.svg\" alt=\"\" width=\"76\" height=\"76\">', '<img src=\"../../storage/images/categories-furniture.svg\" alt=\"\" width=\"76\" height=\"76\">', '<img src=\"../../storage/images/categories-gadgets.svg\" alt=\"\" width=\"76\" height=\"76\">', '<img src=\"../../storage/images/categories-makeup.svg\" alt=\"\" width=\"76\" height=\"76\">', '<img src=\"../../storage/images/categories-sneaker.svg\" alt=\"\" width=\"76\" height=\"76\">', '<img src=\"../../storage/images/categories-makeup.svg\" alt=\"\" width=\"76\" height=\"76\">', 71, '2025-05-27 07:02:09', '2025-05-27 07:02:09'),
(36, '<img src=\"../../storage/images/desain uas.png\" alt=\"\" width=\"163\" height=\"86\">', '<img src=\"../../storage/images/dokumentasi black box2.png\" alt=\"\" width=\"163\" height=\"75\">', '<img src=\"../../storage/images/erd.jpg\" alt=\"\" width=\"163\" height=\"117\">', '<img src=\"../../storage/images/pkkmb.png\" alt=\"\" width=\"163\" height=\"92\">', '<img src=\"../../storage/images/skyline.jpg\" alt=\"\" width=\"163\" height=\"102\">', '<img src=\"../../storage/images/skyline.jpg\" alt=\"\" width=\"163\" height=\"102\">', 72, '2025-05-28 03:23:40', '2025-05-28 03:23:40'),
(37, '<img src=\"../../storage/images/Screenshot 2025-05-30 171305.png\" alt=\"\" width=\"153\" height=\"40\">', '<img src=\"../../storage/images/Screenshot 2025-05-30 171340.png\" alt=\"\" width=\"151\" height=\"33\">', '<img src=\"../../storage/images/Screenshot 2025-05-30 171406.png\" alt=\"\" width=\"172\" height=\"41\">', '<img src=\"../../storage/images/Screenshot 2025-05-30 171424.png\" alt=\"\" width=\"158\" height=\"41\">', '<img src=\"../../storage/images/Screenshot 2025-05-30 171439.png\" alt=\"\" width=\"156\" height=\"45\">', '<img src=\"../../storage/images/Screenshot 2025-05-30 171439.png\" alt=\"\" width=\"156\" height=\"45\">', 74, '2025-05-30 10:16:32', '2025-05-30 10:16:32'),
(38, '1', '2', '', '3', '<img src=\"../../../storage/images/Kelompok 4-erd (1).jpg\" alt=\"\" width=\"502\" height=\"350\">', '<img src=\"../../../storage/images/Kelompok 4-erd (1).jpg\" alt=\"\" width=\"502\" height=\"350\">', 73, '2025-06-03 03:09:34', '2025-06-03 03:09:34'),
(39, '1', '2', '3', '4', '5', '5', 76, '2025-06-03 03:27:01', '2025-06-03 03:27:01'),
(40, '<img src=\"../../storage/images/Screenshot 2025-06-03 131507.png\" alt=\"\" width=\"62\" height=\"63\">', '<img src=\"../../storage/images/Screenshot 2025-06-03 131536.png\" alt=\"\" width=\"50\" height=\"60\">', '<img src=\"../../storage/images/Screenshot 2025-06-03 131607.png\" alt=\"\" width=\"29\" height=\"36\">', '<img src=\"../../storage/images/Screenshot 2025-06-03 131632.png\" alt=\"\" width=\"97\" height=\"72\">', '<img src=\"../../storage/images/Screenshot 2025-06-03 131654.png\" alt=\"\" width=\"100\" height=\"65\">', '<img src=\"../../storage/images/Screenshot 2025-06-03 131507.png\" alt=\"\" width=\"62\" height=\"63\">', 77, '2025-06-03 06:17:15', '2025-06-03 06:17:15'),
(41, 'f', 'g', 'gg', 'ggfg', 'fgfgf', 'fgfgf', 78, '2025-06-03 06:21:45', '2025-06-03 06:21:45'),
(42, '1', '2', '3', '4', '5', '5', 79, '2025-06-05 04:03:47', '2025-06-05 04:03:47'),
(43, '1', '2', '3', '4', '<img src=\"../../../storage/images/dashboard-store-logo.svg\" alt=\"\" width=\"79\" height=\"96\">5', '<img src=\"../../../storage/images/dashboard-store-logo.svg\" alt=\"\" width=\"79\" height=\"96\">5', 80, '2025-06-07 05:22:29', '2025-06-07 05:44:50'),
(44, '<img src=\"http://snbt.test/storage/uploads/1749440606-no 18.jpg\" width=\"1600\" height=\"496\">', '1', '2', '3', '4', '<img src=\"http://snbt.test/storage/uploads/1749440606-no 18.jpg\" width=\"1600\" height=\"496\">', 82, '2025-06-09 03:43:48', '2025-06-09 03:46:19'),
(45, '<img style=\"aspect-ratio:649/306;\" src=\"/storage/uploads/1749447473-image.png\" width=\"649\" height=\"306\">', '1', '2', '3', '4', '<img style=\"aspect-ratio:649/306;\" src=\"/storage/uploads/1749447473-image.png\" width=\"649\" height=\"306\">', 84, '2025-06-09 05:38:03', '2025-06-09 05:38:03'),
(47, '<img style=\"aspect-ratio:975/460;\" src=\"/storage/uploads/1749457388-bpmn.png\" width=\"975\" height=\"460\">', 'e', 'erer', 'rre', 'rer', 'rer', 93, '2025-06-09 08:23:17', '2025-06-09 08:23:17'),
(48, '<img style=\"aspect-ratio:3276/2120;\" src=\"/storage/uploads/1749458462-6937117.jpg\" width=\"3276\" height=\"2120\">', '4', '4', '4', '4', '<img style=\"aspect-ratio:3276/2120;\" src=\"/storage/uploads/1749458462-6937117.jpg\" width=\"3276\" height=\"2120\">', 94, '2025-06-09 08:41:19', '2025-06-09 08:41:19'),
(49, '<img style=\"aspect-ratio:600/418;\" src=\"/storage/uploads/1749458802-image.png\" width=\"600\" height=\"418\">', 's', 'f', 'g', 'h', '<img style=\"aspect-ratio:600/418;\" src=\"/storage/uploads/1749458802-image.png\" width=\"600\" height=\"418\">', 95, '2025-06-09 08:46:48', '2025-06-09 08:46:48'),
(50, '<img src=\"http://snbt.test/storage/uploads/1749459289-image.png\" width=\"603\" height=\"351\">', '1', '<img src=\"/storage/uploads/1749459353-image.png\" width=\"498\" height=\"249\">2', '3', '4', '<img src=\"http://snbt.test/storage/uploads/1749459289-image.png\" width=\"603\" height=\"351\">', 96, '2025-06-09 08:55:00', '2025-06-09 08:55:57'),
(51, '<img style=\"aspect-ratio:112/112;\" src=\"/storage/uploads/1749531378-icon-testimonial-1.png\" width=\"112\" height=\"112\">', '2', '3', '4', '5', '<img style=\"aspect-ratio:112/112;\" src=\"/storage/uploads/1749531378-icon-testimonial-1.png\" width=\"112\" height=\"112\">', 97, '2025-06-10 04:56:29', '2025-06-10 04:56:29'),
(52, '1', '2', '<img src=\"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-oRtqV2etq0bMdjwyjIdJUGkZGT6M2AYn0g&amp;s\" alt=\"10 Cara Belajar Efektif dan Efisien di Rumah, Perhatikan Langkah-langkahnya  - Hot Liputan6.com\" width=\"259\" height=\"194\">', '4', '<img src=\"http://snbt.test/storage/uploads/1749531485-icon-testimonial-1.png\" width=\"112\" height=\"112\">', '<img src=\"http://snbt.test/storage/uploads/1749531485-icon-testimonial-1.png\" width=\"112\" height=\"112\">', 98, '2025-06-10 04:58:07', '2025-06-10 05:01:25'),
(53, '<img style=\"aspect-ratio:224/224;\" src=\"/storage/uploads/1749632026-images.jpeg\" width=\"224\" height=\"224\">', '1', '2', '3', '4', '<img style=\"aspect-ratio:224/224;\" src=\"/storage/uploads/1749632026-images.jpeg\" width=\"224\" height=\"224\">', 99, '2025-06-11 08:53:51', '2025-06-11 08:53:51'),
(54, '<img src=\"/storage/uploads/1749642850-image.png\" width=\"284\" height=\"189\">', '1', '2', '3', '4', '<img src=\"/storage/uploads/1749642850-image.png\" width=\"284\" height=\"189\">', 101, '2025-06-11 11:54:18', '2025-06-11 11:54:18'),
(55, '<img src=\"/storage/uploads/1749643023-image.png\" width=\"431\" height=\"288\">', '1', '2', '3', '4', '<img src=\"/storage/uploads/1749643023-image.png\" width=\"431\" height=\"288\">', 100, '2025-06-11 11:57:12', '2025-06-11 11:57:12');

-- --------------------------------------------------------

--
-- Table structure for table `multiple_options`
--

CREATE TABLE `multiple_options` (
  `id` bigint UNSIGNED NOT NULL,
  `option_text` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `multiple1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `yes/no1` enum('yes','no') COLLATE utf8mb4_unicode_ci NOT NULL,
  `multiple2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `yes/no2` enum('yes','no') COLLATE utf8mb4_unicode_ci NOT NULL,
  `multiple3` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `yes/no3` enum('yes','no') COLLATE utf8mb4_unicode_ci NOT NULL,
  `multiple4` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `yes/no4` enum('yes','no') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `multiple5` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `yes/no5` enum('yes','no') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `yes/no` enum('yes','no') COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_correct` tinyint(1) DEFAULT '0',
  `question_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `multiple_options`
--

INSERT INTO `multiple_options` (`id`, `option_text`, `multiple1`, `yes/no1`, `multiple2`, `yes/no2`, `multiple3`, `yes/no3`, `multiple4`, `yes/no4`, `multiple5`, `yes/no5`, `yes/no`, `is_correct`, `question_id`, `created_at`, `updated_at`) VALUES
(9, NULL, 'fg', 'yes', 'fgg', 'no', 'fgfg', 'yes', NULL, NULL, NULL, NULL, 'yes', 0, 32, '2025-04-03 07:09:21', '2025-04-03 07:09:21'),
(10, NULL, 'reza', 'yes', 'as', 'yes', 'asas', 'no', NULL, NULL, NULL, NULL, 'yes', 0, 35, '2025-04-07 06:57:02', '2025-04-07 06:57:02'),
(11, NULL, 'bola', 'yes', 'game', 'yes', 'musik', 'yes', 'membaca', 'no', 'menulis', 'no', 'yes', 0, 38, '2025-04-30 05:51:42', '2025-04-30 05:51:42'),
(12, NULL, 'reza', 'yes', 'rezaa', 'yes', 're', 'no', NULL, NULL, NULL, NULL, 'yes', 0, 45, '2025-05-14 03:17:26', '2025-05-14 03:17:26'),
(13, NULL, '1', 'yes', '3', 'no', '4', 'yes', NULL, NULL, NULL, NULL, 'yes', 0, 83, '2025-06-09 03:53:25', '2025-06-09 03:53:25'),
(14, NULL, '2', 'no', '4', 'no', '5', 'yes', NULL, NULL, NULL, NULL, 'yes', 0, 86, '2025-06-09 05:46:57', '2025-06-09 05:46:57'),
(15, NULL, '2', 'no', '4', 'no', '5', 'yes', NULL, NULL, NULL, NULL, 'yes', 0, 87, '2025-06-09 05:48:25', '2025-06-09 05:48:25');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `password_reset_tokens`
--

INSERT INTO `password_reset_tokens` (`email`, `token`, `created_at`) VALUES
('rezailyas39@gmail.com', '$2y$12$2/aG5gWqORJHzeKzAYdkleQBL963KudXSA/gBkuZ8at5DQWnNpAta', '2025-06-05 02:40:40');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `provinces`
--

CREATE TABLE `provinces` (
  `id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `id` bigint UNSIGNED NOT NULL,
  `question_text` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `photo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `question_type` enum('pilihan_ganda','pilihan_majemuk','isian') COLLATE utf8mb4_unicode_ci NOT NULL,
  `explanation` longtext COLLATE utf8mb4_unicode_ci,
  `lesson` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `sub_category_id` bigint UNSIGNED NOT NULL,
  `exam_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`id`, `question_text`, `photo`, `question_type`, `explanation`, `lesson`, `created_at`, `updated_at`, `deleted_at`, `sub_category_id`, `exam_id`) VALUES
(7, 'Pestisida alami sering digunakan karena harganya terjangkau dan lebih ramah lingkungan. Namun daya kerja pestisida alami lebih lambat dan penyimpanannya tidak dapat dilakukan dalam jangka waktu yang panjang. Pembuatan pestisida alami membutuhkan waktu yang agak panjang sehingga kurang praktis. Ahli teknologi pertanian perlu menemukan cara agar pestisida alami dapat diproduksi dalam waktu singkat dan dapat disimpan dalam jangka panjang.\r\n\r\nBerdasarkan informasi tersebut, manakah pernyataan berikut ini yang PASTI SALAH?', NULL, 'pilihan_ganda', 'Soal ini menanyakan pernyataan yang salah berdasarkan informasi yang ada di dalam sebuah teks. Untuk menjawab pertanyaan ini, kita harus mencocokkan pernyataan di opsi jawaban dengan informasi dalam teks.\r\n\r\nOpsi A salah karena pernyataannya benar. Hal ini sesuai dengan kalimat ke-1 ”Pestisida alami sering digunakan karena harganya terjangkau dan lebih ramah lingkungan.\r\n\r\nOpsi B benar karena pernyataannya salah. Dalam teks disebutkan bahwa ”daya kerja pestisida alami lebih lambat dan penyimpanannya tidak dapat dilakukan dalam jangka waktu yang panjang.”\r\n\r\nOpsi C salah karena pernyataannya belum tentu salah ataupun benar. Tidak disebutkan apakah ahli pertanian memiliki kemampuan untuk menghasilkan pestisida alami yang tahan lama.\r\n\r\nOpsi D dan E salah karena pernyataannya benar. Dalam teks disebutkan bahwa ”daya kerja pestisida alami lebih lambat dan penyimpanannya tidak dapat dilakukan dalam jangka waktu yang panjang.”\r\n\r\nJadi, jawabannya adalah B.', 'pernyataan Dalam teks', '2025-04-02 08:45:57', '2025-04-02 08:45:57', NULL, 2, 1),
(12, 'krab adalah', NULL, 'isian', 'cssd', 'sds', '2025-04-03 06:16:14', '2025-04-07 06:00:20', NULL, 2, 1),
(17, 'foto di atas merupakan chelsea yang sedang mengangkat UCL, kapan foto itu diambil?', 'assets/question/1/1744177361_6937117.jpg', 'pilihan_ganda', '2021 menang lawan city', 'sejarah', '2025-04-03 06:28:58', '2025-04-09 05:42:43', NULL, 2, 1),
(32, 'saya sassd', 'assets/question/1/1743664161_dokumentasi black box2.png', 'pilihan_majemuk', 'fgfgfgf', 'fgfgfgf', '2025-04-03 07:09:21', '2025-04-03 07:09:21', NULL, 2, 1),
(33, 'sdsds', NULL, 'isian', 'dsd', 'RTRT', '2025-04-03 07:09:55', '2025-04-03 07:09:55', NULL, 2, 1),
(34, '<p>cacacaaac</p>', NULL, 'pilihan_ganda', 'fdfdfdfd', 'dfdf', '2025-04-07 05:46:34', '2025-05-15 03:42:01', NULL, 3, 3),
(35, '<p>cacacaaac</p>', NULL, 'pilihan_majemuk', 'fdfdfdfd', 'dfdf', '2025-04-07 05:48:16', '2025-05-13 08:21:16', NULL, 3, 3),
(36, '<p>cacacaaac</p>', NULL, 'pilihan_ganda', 'fdfdfdfd', 'dfdf', '2025-04-07 05:48:43', '2025-05-15 03:42:32', NULL, 3, 3),
(37, 'tralelelo tralala or tung tung tung sahur', NULL, 'pilihan_ganda', 'tung tung tung tung  sahur', 'trigonometri', '2025-04-30 05:50:15', '2025-04-30 05:50:15', NULL, 2, 8),
(38, 'saya suka apa', NULL, 'pilihan_majemuk', 'saya suka bermain', 'vffgdgdfgd', '2025-04-30 05:51:42', '2025-04-30 05:51:42', NULL, 2, 8),
(39, 'saya fgfkgfkgfr', NULL, 'pilihan_ganda', 'fgfg', 'dfdfdfd', '2025-04-30 05:52:15', '2025-04-30 05:52:15', NULL, 3, 8),
(40, 'tralelo tralala or bombarido crocodillo', NULL, 'isian', 'erere', 'RTRT', '2025-04-30 05:52:49', '2025-04-30 05:52:49', NULL, 3, 8),
(41, '<p>inikan namanya …..</p><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><figure class=\"table\"><table><tbody><tr><td>we</td><td>wew</td><td>wew</td><td>wew</td><td>we</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr></tbody></table></figure>', NULL, 'isian', 'unbraw', 'trigonometri', '2025-05-13 05:24:28', '2025-05-13 05:24:28', NULL, 3, 9),
(42, '<p>saya adalah<br>&nbsp;</p>', NULL, 'isian', '.', '.', '2025-05-13 05:45:06', '2025-05-13 05:45:06', NULL, 6, 11),
(43, '<p>saya adalah<br>&nbsp;</p>', NULL, 'isian', '.', '.', '2025-05-13 05:46:45', '2025-05-13 05:46:45', NULL, 6, 11),
(44, '<p>yayaya</p>', NULL, 'pilihan_ganda', 'sds', 'dsd', '2025-05-13 08:10:22', '2025-05-14 03:15:59', NULL, 6, 12),
(45, '<p>testing 1 2 3</p><figure class=\"table\"><table><tbody><tr><td>pernyataan</td><td>Mendukung</td><td>Tidak Mendukung</td></tr></tbody></table></figure>', NULL, 'pilihan_majemuk', 'ap aja', 'pemahaman deduktif', '2025-05-14 03:17:26', '2025-05-14 03:17:26', NULL, 2, 12),
(46, '<p>test</p>', NULL, 'pilihan_ganda', 'nnn', 'nn', '2025-05-14 03:22:22', '2025-05-14 03:22:22', NULL, 6, 14),
(47, '<p>mmm</p>', NULL, 'pilihan_ganda', 'jkjh', 'dfdfdfd', '2025-05-14 03:23:46', '2025-05-14 03:23:46', NULL, 2, 14),
(48, '<p>xfxd</p>', NULL, 'pilihan_ganda', 'sdf', 'dfd', '2025-05-14 04:18:26', '2025-05-14 04:18:26', NULL, 2, 15),
(49, '<p>1 + 1 =&nbsp;</p>', NULL, 'pilihan_ganda', '1 + 1 ya 2', 'dasar matematika', '2025-05-22 03:27:22', '2025-05-22 03:27:22', NULL, 5, 3),
(50, '<p>2 + 5 =&nbsp;</p>', NULL, 'isian', '2 + 5 = 7', 'dasar matematika', '2025-05-22 03:27:53', '2025-05-22 03:27:53', NULL, 5, 3),
(51, '<p>q 6</p>', NULL, 'pilihan_ganda', 'sd', 'sd', '2025-05-24 08:55:33', '2025-05-24 08:55:33', NULL, 2, 16),
(52, '<p>wew</p>', NULL, 'pilihan_ganda', 'wew', 'rwer', '2025-05-24 08:55:50', '2025-05-24 08:55:50', NULL, 4, 16),
(54, '<h1>Hitunglah nilai dari limx&rarr;0sin⁡xx</h1>', NULL, 'pilihan_ganda', '<p>Menggunakan aturan L\'H&ocirc;pital atau teorema limit trigonometri, kita dapat menunjukkan bahwa $\\lim_{x \\to 0} \\frac{\\sin x}{x} = 1$.</p>', 'matematika', '2025-05-26 07:45:20', '2025-05-26 08:41:17', NULL, 8, 17),
(55, '<p><img src=\"../../../storage/images/GUrvkDIQzl2EvCJDIQqFGHd6I1UyFu26aDaHZ87G.png\" alt=\"\" width=\"594\" height=\"280\"></p>\n<p><span style=\"font-size: 12pt;\">ini merupakan gambar apa</span></p>\n<p>a2+b2=c2</p>\n<p>&nbsp;</p>\n<p>Ini rumus kuadrat: x=&minus;b&plusmn;b2&minus;4ac2a</p>\n<p>Rumus besar:<br>a2+b2=c2<img src=\"../../../storage/images/OSrXIhZOv22XwzKDRs21MfbFjacifQ79FDmSWrZL.svg\" alt=\"\" width=\"76\" height=\"76\"></p>', NULL, 'pilihan_ganda', '<p>ini merupakan gambar skyline&nbsp;</p>', 'trigonometri', '2025-05-26 08:10:54', '2025-05-27 05:33:20', NULL, 8, 17),
(56, '<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\"><span style=\"font-size: 12pt;\">Walaupun khasiat susu bagi tubuh kita sudah tidak diragukan lagi, tidak setiap orang bersedia mengonsumsi susu dengan baik. Hal ini disebabkan oleh dua kemungkinan, yakni sifat yang terkandung dalam susu yang tidak disukai orang atau sifat biologis orang yang bersangkutan (intoleran). Penyebab pertama dapat diatasi dengan penambahan sari jeruk, markisa, apel, atau lainnya sehingga rasa asli susu yang memualkan dapat dihilangkan. Sementara itu, penyebab kedua dapat diatasi dengan menggantinya dengan air susu yang telah mengalami perlakuan khusus, yaitu fermentasi.</span></p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\"><span style=\"font-size: 12pt;\">Secara biologis, penderita intoleran susu tidak mampu mencerna laktosa dari makanan atau minuman dalam susu sehingga terjadi penimbunan laktosa dalam usus. Penderita yang demikian dapat meminum susu bubuk dengan kadar laktosa rendah atau air susu fermentasi, seperti yoghurt, kefir, dan koumis.</span></p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\"><span style=\"font-size: 12pt;\">Susu fermentasi juga bermanfaat bagi manula (manusia usia lanjut) yang mengalami kesukaran dalam mencerna makanan berprotein tinggi. Susu fermentasi, seperti yoghurt, yang dapat dicerna dalam waktu satu jam dapat mengatasi kesukaran tersebut. Keuntungan lain susu fermentasi, yaitu dapat menurunkan kadar kolesterol darah dan mencegah diare bagi penderita kekurangan laktosa.</span></p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\"><span style=\"font-size: 12pt;\">Masalah pokok yang dibahas dalam bacaan di atas adalah ....</span></p>', NULL, 'pilihan_ganda', '<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\"><span style=\"font-size: 12pt;\">Soal di atas menanyakan topik bacaan. Topik dapat diartikan sebagai inti pembahasan di dalam teks. Untuk menjawab soal ini, kita harus menganalisis isi teks secara keseluruhan.</span></p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\"><span style=\"font-size: 12pt;\">Apabila kita analisis teks di atas membahas kendala dalam mengonsumsi susu dan penanganannya. Di paragraf pertama dijelaskan bahwa ada dua penyebab orang tidak mengonsumsi susu, dua penyebab tersebut dapat diatasi dengan cara yang berbeda. Di paragraf kedua dijelaskan bahwa penderita intoleran susu yang tidak mampu mencerna laktosa dari susu. Di paragraf ketiga dijelaskan mengenai susu fermentasi.</span></p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\"><span style=\"font-size: 12pt;\">Opsi A&nbsp;<em>salah</em>&nbsp;karena bacaan di atas tidak membahas khasiat susu.</span></p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\"><span style=\"font-size: 12pt;\">Opsi B dan C&nbsp;<em>salah</em>&nbsp;karena pernyataan tersebut merupakan sebagian gagasan yang hanya dibahas pada paragraf ketiga sehingga bukan topik bacaan yang tepat.</span></p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\"><span style=\"font-size: 12pt;\">Opsi D&nbsp;<em>benar</em>&nbsp;karena merupakan inti pada bacaan dan menjadi topik bahasan pada teks.</span></p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\"><span style=\"font-size: 12pt;\">Opsi E&nbsp;<em>salah</em>&nbsp;karena merupakan kalimat penjelas yang ada di paragraf kedua.</span></p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\"><span style=\"font-size: 12pt;\">Jadi, jawaban yang tepat adalah&nbsp;<strong>D</strong>.</span></p>', 'Ide Pokok', '2025-05-27 03:24:06', '2025-05-27 03:42:45', NULL, 3, 18),
(61, '<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Walaupun khasiat susu bagi tubuh kita sudah tidak diragukan lagi, tidak setiap orang bersedia mengonsumsi susu dengan baik. Hal ini disebabkan oleh dua kemungkinan, yakni sifat yang terkandung dalam susu yang tidak disukai orang atau sifat biologis orang yang bersangkutan (intoleran). Penyebab pertama dapat diatasi dengan penambahan sari jeruk, markisa, apel, atau lainnya sehingga rasa asli susu yang memualkan dapat dihilangkan. Sementara itu, penyebab kedua dapat diatasi dengan menggantinya dengan air susu yang telah mengalami perlakuan khusus, yaitu fermentasi.</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Secara biologis, penderita intoleran susu tidak mampu mencerna laktosa dari makanan atau minuman dalam susu sehingga terjadi penimbunan laktosa dalam usus. Penderita yang demikian dapat meminum susu bubuk dengan kadar laktosa rendah atau air susu fermentasi, seperti yoghurt, kefir, dan koumis.</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Susu fermentasi juga bermanfaat bagi manula (manusia usia lanjut) yang mengalami kesukaran dalam mencerna makanan berprotein tinggi. Susu fermentasi, seperti yoghurt, yang dapat dicerna dalam waktu satu jam dapat mengatasi kesukaran tersebut. Keuntungan lain susu fermentasi, yaitu dapat menurunkan kadar kolesterol darah dan mencegah diare bagi penderita kekurangan laktosa.</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Pertanyaan yang jawabannya dapat ditemukan pada bacaan di atas adalah ....</p>', NULL, 'pilihan_ganda', '<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Soal di atas menanyakan pertanyaan yang jawabannya terdapat di dalam teks. Untuk menjawab soal ini, kita harus menganalisis bacaan dan mencocokkannya dengan opsi jawaban.</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Apabila kita analisis teks di atas membahas kendala dalam mengonsumsi susu dan penanganannya. Di paragraf pertama dijelaskan bahwa ada dua penyebab orang tidak mengonsumsi susu, dua penyebab tersebut dapat diatasi dengan cara yang berbeda. Di paragraf kedua dijelaskan bahwa penderita intoleran susu yang tidak mampu mencerna laktosa dari susu. Di paragraf ketiga dijelaskan mengenai susu fermentasi.</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Opsi A&nbsp;<em>benar</em>&nbsp;karena jawaban pertanyaan tersebut ada di dalam bacaan, yaitu&nbsp;<em>penderita intoleran susu tidak mampu mencerna laktosa dari makanan atau minuman dalam susu sehingga terjadi penimbunan laktosa dalam usus.</em></p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Opsi B, C, D dan E&nbsp;<em>salah</em>&nbsp;karena jawaban pertanyaan tersebut tidak terdapat dalam bacaan.</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Jadi, jawaban yang tepat adalah&nbsp;<strong>A</strong>.</p>', 'pernyataan Dalam teks', '2025-05-27 03:45:59', '2025-05-27 03:45:59', NULL, 3, 18),
(62, '<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Walaupun khasiat susu bagi tubuh kita sudah tidak diragukan lagi, tidak setiap orang bersedia mengonsumsi susu dengan baik. Hal ini disebabkan oleh dua kemungkinan, yakni sifat yang terkandung dalam susu yang tidak disukai orang atau sifat biologis orang yang bersangkutan (intoleran). Penyebab pertama dapat diatasi dengan penambahan sari jeruk, markisa, apel, atau lainnya sehingga rasa asli susu yang memualkan dapat dihilangkan. Sementara itu, penyebab kedua dapat diatasi dengan menggantinya dengan air susu yang telah mengalami perlakuan khusus, yaitu fermentasi.</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Secara biologis, penderita intoleran susu tidak mampu mencerna laktosa dari makanan atau minuman dalam susu sehingga terjadi penimbunan laktosa dalam usus. Penderita yang demikian dapat meminum susu bubuk dengan kadar laktosa rendah atau air susu fermentasi, seperti yoghurt, kefir, dan koumis.</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Susu fermentasi juga bermanfaat bagi manula (manusia usia lanjut) yang mengalami kesukaran dalam mencerna makanan berprotein tinggi. Susu fermentasi, seperti yoghurt, yang dapat dicerna dalam waktu satu jam dapat mengatasi kesukaran tersebut. Keuntungan lain susu fermentasi, yaitu dapat menurunkan kadar kolesterol darah dan mencegah diare bagi penderita kekurangan laktosa.</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Maksud penderita intoleran susu dalam bacaan adalah ....</p>', NULL, 'pilihan_ganda', '<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Soal di atas menanyakan maksud dari penderita intoleran susu. Untuk menjawab soal ini, kita harus menganalisis bacaan dan mencocokkannya dengan opsi jawaban.</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Berdasarkan bacaan di atas, penderita intoleran susu dijelaskan sebagai seseorang yang tidak mampu mencerna laktosa dari makanan atau minuman dalam susu sehingga terjadi penimbunan laktosa dalam usus. Penderita yang demikian dapat meminum susu bubuk dengan kadar laktosa rendah atau air susu fermentasi, seperti yoghurt, kefir, dan koumis.</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Opsi A&nbsp;<em>salah</em>&nbsp;karena penderita intoleran susu bukanlah orang yang tidak suka susu melainkan tidak bisa mencerna laktosa dalam susu.</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Opsi B&nbsp;<em>salah</em>&nbsp;karena penderita intoleran susu bukan hanya menghindari minum susu karena kandungan laktosanya melainkan tidak bisa mencerna kandungan laktosa tersebut.</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Opsi C&nbsp;<em>benar</em>&nbsp;karena penderita intoleran adalah seseorang yang tidak mampu mencerna kandungan laktosa susu.</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Opsi D&nbsp;<em>salah</em>&nbsp;karena penderita intoleran susu bukanlah orang yang menyukai susu meskipun rasanya sudah diubah.</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Opsi E&nbsp;<em>salah</em>&nbsp;karena penderita intoleran susu adalah seseorang yang tidak mampu mencerna kandungan laktosa susu meskipun sudah difermentasi.</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Jadi, jawaban yang tepat adalah&nbsp;<strong>C</strong>.</p>', 'Analisis Bacaan & Kepaduan Paragraf', '2025-05-27 03:49:41', '2025-05-27 03:49:41', NULL, 3, 18),
(63, '<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Walaupun khasiat susu bagi tubuh kita sudah tidak diragukan lagi, tidak setiap orang bersedia mengonsumsi susu dengan baik. Hal ini disebabkan oleh dua kemungkinan, yakni sifat yang terkandung dalam susu yang tidak disukai orang atau sifat biologis orang yang bersangkutan (intoleran). Penyebab pertama dapat diatasi dengan penambahan sari jeruk, markisa, apel, atau lainnya sehingga rasa asli susu yang memualkan dapat dihilangkan. Sementara itu, penyebab kedua dapat diatasi dengan menggantinya dengan air susu yang telah mengalami perlakuan khusus, yaitu fermentasi.</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Secara biologis, penderita intoleran susu tidak mampu mencerna laktosa dari makanan atau minuman dalam susu sehingga terjadi penimbunan laktosa dalam usus. Penderita yang demikian dapat meminum susu bubuk dengan kadar laktosa rendah atau air susu fermentasi, seperti yoghurt, kefir, dan koumis.</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Susu fermentasi juga bermanfaat bagi manula (manusia usia lanjut) yang mengalami kesukaran dalam mencerna makanan berprotein tinggi. Susu fermentasi, seperti yoghurt, yang dapat dicerna dalam waktu satu jam dapat mengatasi kesukaran tersebut. Keuntungan lain susu fermentasi, yaitu dapat menurunkan kadar kolesterol darah dan mencegah diare bagi penderita kekurangan laktosa.</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Secara runtun, masalah pokok yang dibicarakan bacaan di atas adalah ....</p>', NULL, 'pilihan_ganda', '<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Soal di atas menanyakan masalah pokok yang dibicarakan bacaan di atas. Untuk menjawab soal ini, kita harus menganalisis pokok bahasan yang ada di setiap paragraf dan merunutkannya kemudian mencocokkan dengan opsi jawaban.</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Apabila kita analisis teks di atas membahas kendala dalam mengonsumsi susu dan penanganannya. Di paragraf pertama dijelaskan bahwa ada dua&nbsp;<strong>penyebab orang tidak mengonsumsi susu</strong>, dua penyebab tersebut dapat diatasi dengan cara yang berbeda. Di paragraf kedua dijelaskan bahwa penderita&nbsp;<strong>intoleran susu</strong>&nbsp;yang tidak mampu mencerna laktosa dari susu. Di paragraf ketiga dijelaskan mengenai&nbsp;<strong>manfaat susu fermentasi</strong>.</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Opsi A&nbsp;<em>benar</em>&nbsp;karena merupakan masalah pokok yang dibicarakan setiap paragraf pada teks.</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Opsi B, C, D dan E&nbsp;<em>salah</em>&nbsp;karena bukan merupakan masalah pokok yang dibicarakan setiap paragraf pada teks.</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Jadi, jawaban yang tepat adalah&nbsp;<strong>A</strong>.</p>', 'Ide Pokok', '2025-05-27 03:51:31', '2025-05-27 03:51:31', NULL, 3, 18),
(64, '<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Daratan di muka bumi terdiri atas benua hingga pulau-pulau kecil yang sejak jutaan tahun lalu terus bergerak dinamis. Konon, dahulu kala di bumi hanya ada satu benda yang sangat luas. Namun, akibat aktivitas magma dan perputaran bumi itu sendiri, lapisan bumi bagian atas pecah menjadi lempeng-lempeng, yaitu lempeng benua dan lempeng samudra. Pergeseran lempeng ini menyebabkan daratan terpencar hingga kondisi saat ini. Perjalanan daratan itu tidak akan pernah usai sepanjang umur bumi ini.</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Pada proses pergeseran daratan terlihat bahwa Pulau Sumatra hingga Jawa serta sebagian Kalimantan bagian selatan dan timur, sejak dahulu merupakan satu kesatuan yang berada di lempeng Benua Eurasia. Sumatra dan Jawa berada di tepi sebelah selatan lempeng ini, dekat dengan pertemuan lempeng Indo-Australia. Lempeng Sumatra ini mendesak lempeng Eurasia di bawah Samudra Hindia ke arah barat laut di Sumatra dan frontal ke utara terhadap Pulau Jawa dengan kecepatan pergerakan yang bervariasi. Selama puluhan hingga ratusan tahun, dua lempeng itu saling menekan, namun lempeng Indo-Australia bergerak lebih aktif.</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Pergerakannya yang hanya beberapa milimeter hingga beberapa sentimeter per tahun itu memang tidak terasa oleh manusia penghuni bumi. Dorongan lempeng Indo-Australia terhadap</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">bagian utara Sumatra 5,2 cm per tahun, sedangkan yang di bagian selatan 6 cm per tahun. Pergerakan lempeng di daerah barat Sumatra yang miring posisinya ini lebih cepat dibandingkan dengan di Jawa yang pergerakannya hanya 2 cm per tahun.</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Topik bacaan di atas adalah ....</p>', NULL, 'pilihan_ganda', '<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Soal di atas menanyakan topik bacaan. Topik dapat diartikan sebagai inti pembahasan di dalam teks. Untuk menjawab soal ini, kita harus menganalisis isi teks secara keseluruhan.</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Apabila kita analisis teks di atas membahas proses terbentuknya benua dan pulau. Di paragraf pertama dijelaskan bahwa bumi mengalami perubahan sepanjang usianya. Di paragraf kedua dijelaskan proses pergeseran daratan. Di paragraf ketiga dijelaskan pergerakan lempeng Indo-Australia.</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Opsi A&nbsp;<em>salah</em>&nbsp;karena kecepatan dorongan lempeng Indo-Australia hanya merupakan gagasan pada paragraf ketiga dan bukanlah topik bacaan di atas.</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Opsi B&nbsp;<em>benar</em>&nbsp;karena inti pembicaraan pada teks di atas adalah membahas proses pembentukan pulau dan benua atau sejarah terbentuknya benua dan pulau.</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Opsi C&nbsp;<em>salah</em>&nbsp;karena di dalam teks tidak dibahas terbentuknya lempeng, melainkan pergeseran lempeng sehingga bukanlah topik bacaan yang tepat.</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Opsi D&nbsp;<em>salah</em>&nbsp;karena hanya merupakan sebagian gagasan pada paragraf kedua sehingga bukanlah topik teks yang tepat.</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Opsi E&nbsp;<em>salah</em>&nbsp;karena hanya merupakan sebagian gagasan pada paragraf kedua sehingga bukanlah topik teks yang tepat.</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Jadi, jawaban yang tepat adalah&nbsp;<strong>B</strong>.</p>', 'Ide Pokok', '2025-05-27 03:52:50', '2025-05-27 03:52:50', NULL, 3, 18),
(65, '<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">(1) Dewasa ini ulah manusia melakukan perusakan alam dan sistem lingkungan yang menopang kehidupan semakin nyata. (2) Akibatnya, krisis lingkungan yang terjadi dalam skala nasional dan global, sudah sampai pada tahap yang serius mengancam eksistensi planet bumi tempat manusia, hewan, dan tumbuhan melangsungkan kehidupan. (3) Salah satu indikator kerusakan lingkungan adalah adanya degradasi lahan cukup nyata di depan mata. (4) Misalnya, banjir tahunan yang semakin besar dan meluas, sedimentasi sungai dan danau, tanah longsor, dan kelangkaan air, baik secara kuantitas ataupun kualitas. (5) Polusi air dan udara, pemanasan global, perubahan iklim, kefanaan spesies tumbuhan dan hewan, serta ledakan hama dan penyakit merupakan gejala lain yang serius mengancam penghidupan di planet bumi.</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">(6) Berbagai kasus kerusakan lingkungan yang terjadi dalam lingkup nasional dan global tersebut berakar dari perilaku manusia yang tidak bertanggung jawab terhadap lingkungannya. (7) Sebagai contoh dalam lingkup lokal, misalnya penebangan liar dan perusakan ekosistem hutan yang terjadi hampir seluruh pulau Indonesia. (8) Salah satu akibat yang dirasakan oleh masyarakat adalah banjir yang terjadi di berbagai pelosok tanah air. (9) Bahkan, di berbagai kota besar di Indonesia seperti Jakarta, Surabaya, dan Semarang merupakan peristiwa rutin tiap tahun. (10) Bencana banjir sudah pasti menyebabkan berbagai korban, kesusahan, dan kerugian harta benda, bahkan nyawa manusia.</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\"><img src=\"https://storage.pahamify.com/QB%20TPS/Artboard%201.png\" width=\"943\" height=\"530\"></p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">(11) Ada berbagai bentuk kerusakan lingkungan di muka bumi ini, tetapi selalu manusia yang menjadi penyebab utama. (12) Peningkatan jumlah penduduk yang sangat pesat, juga telah mengakibatkan terjadinya eksplorasi berlebihan terhadap sumber daya alam. (13) Hal itu terlihat pada eksplorasi hutan dan tambang yang memacu terjadinya kerusakan lingkungan dan degradasi lahan. (14) Padahal lahan dengan sumber dayanya berfungsi sebagai penyangga kehidupan hewan, tumbuhan, dan manusia. (15) Kesalahan cara pandang dan pemahaman manusia tentang sistem lingkungan mempunyai andil besar terhadap kerusakan lingkungan. (16) Cara pandang demikian telah melahirkan perilaku yang eksploitatif dan tidak bertanggung jawab terhadap kelestarian sumber daya alam dan lingkungan.</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Gagasan utama paragraf pertama adalah &hellip;.</p>', NULL, 'pilihan_ganda', '<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Soal di atas menanyakan gagasan utama paragraf pertama. Untuk menjawabnya, kita perlu menganalisis paragraf pertama dan menemukan ide pokoknya.</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Ide pokok paragraf adalah inti permasalahan dalam sebuah paragraf. Ide pokok paragraf biasanya berada di kalimat utama.</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Pada paragraf pertama, inti permasalahan yang dibahas adalah tentang kerusakan alam dan lingkungan karena ulah manusia. Ide pokok paragraf tersebut ada pada kalimat 1.</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Opsi A&nbsp;<em>benar</em>&nbsp;karena merupakan ide pokok yang tepat. Kalimat pada opsi A merupakan inti dari kalimat 1 yang menjadi kalimat utama paragraf.</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Opsi B, C, D, dan E&nbsp;<em>salah</em>&nbsp;karena kalimat tersebut bukan merupakan inti paragraf. Krisis lingkungan, banjir tahunan, dan ledakan hama merupakan akibat dari kerusakan alam dan lingkungan. Hal tersebut merupakan kalimat penjelas untuk kalimat 1.</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Jadi, jawaban yang tepat adalah&nbsp;<strong>A</strong>.</p>', 'Ide Pokok', '2025-05-27 03:55:34', '2025-05-27 03:55:34', NULL, 4, 18),
(66, '<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">(1) Dewasa ini ulah manusia melakukan perusakan alam dan sistem lingkungan yang menopang kehidupan semakin nyata. (2) Akibatnya, krisis lingkungan yang terjadi dalam skala nasional dan global, sudah sampai pada tahap yang serius mengancam eksistensi planet bumi tempat manusia, hewan, dan tumbuhan melangsungkan kehidupan. (3) Salah satu indikator kerusakan lingkungan adalah adanya degradasi lahan cukup nyata di depan mata. (4) Misalnya, banjir tahunan yang semakin besar dan meluas, sedimentasi sungai dan danau, tanah longsor, dan kelangkaan air, baik secara kuantitas ataupun kualitas. (5) Polusi air dan udara, pemanasan global, perubahan iklim, kefanaan spesies tumbuhan dan hewan, serta ledakan hama dan penyakit merupakan gejala lain yang serius mengancam penghidupan di planet bumi.</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">(6) Berbagai kasus kerusakan lingkungan yang terjadi dalam lingkup nasional dan global tersebut berakar dari perilaku manusia yang tidak bertanggung jawab terhadap lingkungannya. (7) Sebagai contoh dalam lingkup lokal, misalnya penebangan liar dan perusakan ekosistem hutan yang terjadi hampir seluruh pulau Indonesia. (8) Salah satu akibat yang dirasakan oleh masyarakat adalah banjir yang terjadi di berbagai pelosok tanah air. (9) Bahkan, di berbagai kota besar di Indonesia seperti Jakarta, Surabaya, dan Semarang merupakan peristiwa rutin tiap tahun. (10) Bencana banjir sudah pasti menyebabkan berbagai korban, kesusahan, dan kerugian harta benda, bahkan nyawa manusia.</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\"><img src=\"https://storage.pahamify.com/QB%20TPS/Artboard%201.png\" width=\"898\" height=\"505\"></p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">(11) Ada berbagai bentuk kerusakan lingkungan di muka bumi ini, tetapi selalu manusia yang menjadi penyebab utama. (12) Peningkatan jumlah penduduk yang sangat pesat, juga telah mengakibatkan terjadinya eksplorasi berlebihan terhadap sumber daya alam. (13) Hal itu terlihat pada eksplorasi hutan dan tambang yang memacu terjadinya kerusakan lingkungan dan degradasi lahan. (14) Padahal lahan dengan sumber dayanya berfungsi sebagai penyangga kehidupan hewan, tumbuhan, dan manusia. (15) Kesalahan cara pandang dan pemahaman manusia tentang sistem lingkungan mempunyai andil besar terhadap kerusakan lingkungan. (16) Cara pandang demikian telah melahirkan perilaku yang eksploitatif dan tidak bertanggung jawab terhadap kelestarian sumber daya alam dan lingkungan.</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Penggunaan diksi yang tidak tepat terdapat pada kalimat &hellip;.</p>', NULL, 'pilihan_ganda', '<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Soal di atas menanyakan diksi yang tidak tepat. Untuk menjawabnya, kita perlu menganalisis kalimat yang ditunjuk pada opsi jawaban dan menentukan kalimat yang mengandung diksi yang tidak tepat. Diksi yang tidak tepat berkaitan dengan konteks kalimatnya.</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Opsi A, B, D, dan E&nbsp;<em>salah</em>&nbsp;karena tidak ada penggunaan diksi yang salah.</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Opsi C&nbsp;<em>benar</em>&nbsp;karena terdapat kesalahan diksi pada kalimat 4. Penggunaan kata&nbsp;<em>ataupun</em>&nbsp;pada konteks kalimat tersebut salah.</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Perhatikan kalimat berikut!</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\"><em>Misalnya, banjir tahunan yang semakin besar dan meluas, sedimentasi sungai dan danau, tanah longsor, dan kelangkaan air,&nbsp;<strong>baik</strong>&nbsp;secara kuantitas&nbsp;<strong>ataupun</strong>&nbsp;kualitas.</em></p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Pada kalimat di atas terdapat konjungsi korelatif yang tidak tepat, yakni&nbsp;<em>baik....ataupun...</em>. Kata&nbsp;<em>ataupun</em>&nbsp;seharusnya diganti menjadi&nbsp;<em>maupun</em>.</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Jadi, jawaban yang tepat adalah&nbsp;<strong>B</strong>.</p>', 'Semantik', '2025-05-27 03:57:37', '2025-05-27 03:57:37', NULL, 4, 18),
(67, '<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">(1) Dewasa ini ulah manusia melakukan perusakan alam dan sistem lingkungan yang menopang kehidupan semakin nyata. (2) Akibatnya, krisis lingkungan yang terjadi dalam skala nasional dan global, sudah sampai pada tahap yang serius mengancam eksistensi planet bumi tempat manusia, hewan, dan tumbuhan melangsungkan kehidupan. (3) Salah satu indikator kerusakan lingkungan adalah adanya degradasi lahan cukup nyata di depan mata. (4) Misalnya, banjir tahunan yang semakin besar dan meluas, sedimentasi sungai dan danau, tanah longsor, dan kelangkaan air, baik secara kuantitas ataupun kualitas. (5) Polusi air dan udara, pemanasan global, perubahan iklim, kefanaan spesies tumbuhan dan hewan, serta ledakan hama dan penyakit merupakan gejala lain yang serius mengancam penghidupan di planet bumi.</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">(6) Berbagai kasus kerusakan lingkungan yang terjadi dalam lingkup nasional dan global tersebut berakar dari perilaku manusia yang tidak bertanggung jawab terhadap lingkungannya. (7) Sebagai contoh dalam lingkup lokal, misalnya penebangan liar dan perusakan ekosistem hutan yang terjadi hampir seluruh pulau Indonesia. (8) Salah satu akibat yang dirasakan oleh masyarakat adalah banjir yang terjadi di berbagai pelosok tanah air. (9) Bahkan, di berbagai kota besar di Indonesia seperti Jakarta, Surabaya, dan Semarang merupakan peristiwa rutin tiap tahun. (10) Bencana banjir sudah pasti menyebabkan berbagai korban, kesusahan, dan kerugian harta benda, bahkan nyawa manusia.</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\"><img src=\"https://storage.pahamify.com/QB%20TPS/Artboard%201.png\" width=\"1003\" height=\"564\"></p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">(11) Ada berbagai bentuk kerusakan lingkungan di muka bumi ini, tetapi selalu manusia yang menjadi penyebab utama. (12) Peningkatan jumlah penduduk yang sangat pesat, juga telah mengakibatkan terjadinya eksplorasi berlebihan terhadap sumber daya alam. (13) Hal itu terlihat pada eksplorasi hutan dan tambang yang memacu terjadinya kerusakan lingkungan dan degradasi lahan. (14) Padahal lahan dengan sumber dayanya berfungsi sebagai penyangga kehidupan hewan, tumbuhan, dan manusia. (15) Kesalahan cara pandang dan pemahaman manusia tentang sistem lingkungan mempunyai andil besar terhadap kerusakan lingkungan. (16) Cara pandang demikian telah melahirkan perilaku yang eksploitatif dan tidak bertanggung jawab terhadap kelestarian sumber daya alam dan lingkungan.</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Kesalahan penggunaan tanda baca terdapat pada kalimat &hellip;.</p>', NULL, 'pilihan_ganda', '<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Soal di atas menanyakan kesalahan penggunaan tanda baca. Untuk menjawabnya, kita perlu menganalisis kalimat yang ditunjuk pada opsi jawaban.</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Opsi A&nbsp;<em>salah</em>&nbsp;karena tidak ada kesalahan tanda baca pada kalimat (11). Tanda koma sebelum konjungsi&nbsp;<em>tetapi</em>&nbsp;diperlukan karena merupakan konjungsi subordinatif.</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Opsi B&nbsp;<em>benar</em>&nbsp;karena terdapat kesalahan tanda baca pada kalimat (12). Tanda koma setelah kata&nbsp;<em>juga</em>&nbsp;seharusnya dihilangkan karena antara subjek dan predikat tidak membutuhkan tanda baca.</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Opsi C dan E&nbsp;<em>salah</em>&nbsp;karena tidak ada kesalahan tanda baca pada kalimat (13). Tanda baca yang ada pada kalimat (13) dan (15) hanya tanda titik. Tanda baca tersebut digunakan untuk mengakhiri kalimat.</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Opsi D&nbsp;<em>salah</em>&nbsp;karena tidak ada kesalahan tanda baca pada kalimat (14). Tanda koma digunakan untuk perincian. Kalimat (14) mengalami kekurangan tanda baca, yakni tanda koma setelah konjungsi&nbsp;<em>Padahal</em>. Karena digunakan sebagai konjungsi antarkalimat, setelah konjungsi harus ada tanda koma. Namun, pertanyaannya adalah berkaitan dengan kesalahan tanda baca, bukan kekurangan tanda baca sehingga opsi D masih kurang tepat.</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Jadi, jawaban yang tepat adalah&nbsp;<strong>B</strong>.</p>', 'PUEBI', '2025-05-27 03:59:06', '2025-05-27 03:59:06', NULL, 4, 18);
INSERT INTO `questions` (`id`, `question_text`, `photo`, `question_type`, `explanation`, `lesson`, `created_at`, `updated_at`, `deleted_at`, `sub_category_id`, `exam_id`) VALUES
(68, '<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">(1) Dewasa ini ulah manusia melakukan perusakan alam dan sistem lingkungan yang menopang kehidupan semakin nyata. (2) Akibatnya, krisis lingkungan yang terjadi dalam skala nasional dan global, sudah sampai pada tahap yang serius mengancam eksistensi planet bumi tempat manusia, hewan, dan tumbuhan melangsungkan kehidupan. (3) Salah satu indikator kerusakan lingkungan adalah adanya degradasi lahan cukup nyata di depan mata. (4) Misalnya, banjir tahunan yang semakin besar dan meluas, sedimentasi sungai dan danau, tanah longsor, dan kelangkaan air, baik secara kuantitas ataupun kualitas. (5) Polusi air dan udara, pemanasan global, perubahan iklim, kefanaan spesies tumbuhan dan hewan, serta ledakan hama dan penyakit merupakan gejala lain yang serius mengancam penghidupan di planet bumi.</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">(6) Berbagai kasus kerusakan lingkungan yang terjadi dalam lingkup nasional dan global tersebut berakar dari perilaku manusia yang tidak bertanggung jawab terhadap lingkungannya. (7) Sebagai contoh dalam lingkup lokal, misalnya penebangan liar dan perusakan ekosistem hutan yang terjadi hampir seluruh pulau Indonesia. (8) Salah satu akibat yang dirasakan oleh masyarakat adalah banjir yang terjadi di berbagai pelosok tanah air. (9) Bahkan, di berbagai kota besar di Indonesia seperti Jakarta, Surabaya, dan Semarang merupakan peristiwa rutin tiap tahun. (10) Bencana banjir sudah pasti menyebabkan berbagai korban, kesusahan, dan kerugian harta benda, bahkan nyawa manusia.</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\"><img src=\"https://storage.pahamify.com/QB%20TPS/Artboard%201.png\" width=\"754\" height=\"424\"></p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">(11) Ada berbagai bentuk kerusakan lingkungan di muka bumi ini, tetapi selalu manusia yang menjadi penyebab utama. (12) Peningkatan jumlah penduduk yang sangat pesat, juga telah mengakibatkan terjadinya eksplorasi berlebihan terhadap sumber daya alam. (13) Hal itu terlihat pada eksplorasi hutan dan tambang yang memacu terjadinya kerusakan lingkungan dan degradasi lahan. (14) Padahal lahan dengan sumber dayanya berfungsi sebagai penyangga kehidupan hewan, tumbuhan, dan manusia. (15) Kesalahan cara pandang dan pemahaman manusia tentang sistem lingkungan mempunyai andil besar terhadap kerusakan lingkungan. (16) Cara pandang demikian telah melahirkan perilaku yang eksploitatif dan tidak bertanggung jawab terhadap kelestarian sumber daya alam dan lingkungan.</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Apakah penyebab utama terjadinya kerusakan lingkungan?</p>', NULL, 'pilihan_ganda', '<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Soal di atas menanyakan penyebab terjadinya kerusakan lingkungan. Untuk menjawabnya, pahami apa yang dibahas dalam teks yang berkaitan dengan penyebab kerusakan lingkungan.</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Pembahasan mengenai penyebab kerusakan lingkungan terdapat pada paragraf ke-3. Pada kalimat (11), dijelaskan bahwa manusia selalu menjadi penyebab utama kerusakan alam. Pada kalimat (15) dijelaskan juga bahwa cara pandang dan pemahaman manusia tentang sistem lingkungan mempunyai andil besar terhadap kerusakan lingkungan.</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Opsi A&nbsp;<em>salah</em>&nbsp;karena jika manusia memandang alam sebagai bagian dari kehidupan, lingkungan tidak akan rusak. Pernyataan pada opsi A tidak bisa menjawab pernyataan mengapa kerusakan lingkungan terjadi.</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Opsi B&nbsp;<em>benar</em>&nbsp;karena adanya kesalahan cara pandang manusia terhadap alam menyebabkan terjadinya kerusakan lingkungan. Hal tersebut sesuai dengan inti paragraf ketiga.</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Opsi C&nbsp;<em>salah</em>&nbsp;karena pernyataan opsi C tidak dikaitkan dengan terjadinya kerusakan lingkungan.</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Opsi D&nbsp;<em>salah</em>&nbsp;karena cara pandang manusia terhadap alam berbeda-beda belum tentu menyebabkan kerusakan lingkungan.</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Opsi E&nbsp;<em>salah</em>&nbsp;karena pernyataan tersebut tidak bisa menjawab pertanyaan mengapa kerusakan lingkungan terjadi.</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Jadi, jawaban yang tepat adalah&nbsp;<strong>B</strong>.</p>', 'Pemahaman Bacaan', '2025-05-27 04:01:35', '2025-06-03 03:20:30', NULL, 4, 18),
(69, '<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">(1) Dewasa ini ulah manusia melakukan perusakan alam dan sistem lingkungan yang menopang kehidupan semakin nyata. (2) Akibatnya, krisis lingkungan yang terjadi dalam skala nasional dan global, sudah sampai pada tahap yang serius mengancam eksistensi planet bumi tempat manusia, hewan, dan tumbuhan melangsungkan kehidupan. (3) Salah satu indikator kerusakan lingkungan adalah adanya degradasi lahan cukup nyata di depan mata. (4) Misalnya, banjir tahunan yang semakin besar dan meluas, sedimentasi sungai dan danau, tanah longsor, dan kelangkaan air, baik secara kuantitas ataupun kualitas. (5) Polusi air dan udara, pemanasan global, perubahan iklim, kefanaan spesies tumbuhan dan hewan, serta ledakan hama dan penyakit merupakan gejala lain yang serius mengancam penghidupan di planet bumi.</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">(6) Berbagai kasus kerusakan lingkungan yang terjadi dalam lingkup nasional dan global tersebut berakar dari perilaku manusia yang tidak bertanggung jawab terhadap lingkungannya. (7) Sebagai contoh dalam lingkup lokal, misalnya penebangan liar dan perusakan ekosistem hutan yang terjadi hampir seluruh pulau Indonesia. (8) Salah satu akibat yang dirasakan oleh masyarakat adalah banjir yang terjadi di berbagai pelosok tanah air. (9) Bahkan, di berbagai kota besar di Indonesia seperti Jakarta, Surabaya, dan Semarang merupakan peristiwa rutin tiap tahun. (10) Bencana banjir sudah pasti menyebabkan berbagai korban, kesusahan, dan kerugian harta benda, bahkan nyawa manusia.</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\"><img src=\"https://storage.pahamify.com/QB%20TPS/Artboard%201.png\" width=\"1173\" height=\"660\"></p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">(11) Ada berbagai bentuk kerusakan lingkungan di muka bumi ini, tetapi selalu manusia yang menjadi penyebab utama. (12) Peningkatan jumlah penduduk yang sangat pesat, juga telah mengakibatkan terjadinya eksplorasi berlebihan terhadap sumber daya alam. (13) Hal itu terlihat pada eksplorasi hutan dan tambang yang memacu terjadinya kerusakan lingkungan dan degradasi lahan. (14) Padahal lahan dengan sumber dayanya berfungsi sebagai penyangga kehidupan hewan, tumbuhan, dan manusia. (15) Kesalahan cara pandang dan pemahaman manusia tentang sistem lingkungan mempunyai andil besar terhadap kerusakan lingkungan. (16) Cara pandang demikian telah melahirkan perilaku yang eksploitatif dan tidak bertanggung jawab terhadap kelestarian sumber daya alam dan lingkungan.</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Kalimat yang tidak efektif adalah kalimat &hellip;.</p>\r\n<p class=\"font16 semi-normal brown-black\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>', NULL, 'pilihan_ganda', '<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Soal di atas menanyakan kalimat yang tidak efektif pada paragraf di atas. Untuk menjawabnya, kita perlu menganalisis kalimat-kalimat yang ditunjuk pada opsi jawaban.</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Ciri-ciri kalimat efektif adalah sebagai berikut.</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">1) S-P jelas</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">2) Hemat</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">3) Logis</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">4) Sejajar</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Opsi A, B, C, dan D&nbsp;<em>salah</em>&nbsp;karena kalimat-kalimat tersebut efektif.</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Opsi E&nbsp;<em>benar</em>&nbsp;karena kalimat (7) dan (9) merupakan kalimat tidak efektif karena memiliki ketidakjelasan S-P. Padahal, kalimat efektif wajib memiliki subjek dan predikat. Kalimat (7) hanya berunsur keterangan. Kalimat (9) tidak memiliki subjek.</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Analisis pola kalimat (7):</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\"><span class=\"katex\"><span class=\"katex-mathml\">Sebagai&nbsp;contoh&nbsp;dalam&nbsp;lingkup&nbsp;lokal,&nbsp;misalnya&nbsp;penebangan&nbsp;liar&nbsp;dan&nbsp;perusakan&nbsp;ekosistem&nbsp;hutan&nbsp;yang&nbsp;terjadi&nbsp;hampir&nbsp;seluruh&nbsp;pulau&nbsp;Indonesia.Keterangan</span><span class=\"katex-html\" aria-hidden=\"true\"><span class=\"base\"><span class=\"mord\"><span class=\"mfrac\"><span class=\"vlist-t vlist-t2\"><span class=\"vlist-r\"><span class=\"vlist\"><span class=\"\"><span class=\"sizing reset-size6 size3 mtight\"><span class=\"mord mtight\"><span class=\"mord text mtight\">Keterangan</span></span></span></span><span class=\"\"><span class=\"sizing reset-size6 size3 mtight\"><span class=\"mord mtight\"><span class=\"mord text sizing reset-size3 size6\">Sebagai&nbsp;contoh&nbsp;dalam&nbsp;lingkup&nbsp;lokal,&nbsp;misalnya&nbsp;penebangan&nbsp;liar&nbsp;dan&nbsp;perusakan&nbsp;ekosistem&nbsp;hutan&nbsp;yang&nbsp;terjadi&nbsp;hampir&nbsp;seluruh&nbsp;pulau&nbsp;Indonesia.</span></span></span></span></span><span class=\"vlist-s\">​</span></span></span></span></span></span></span></span></p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Analisis pola kalimat 9:</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\"><span class=\"katex\"><span class=\"katex-mathml\">Bahkan,Konjungsi&nbsp;antarkalimat</span><span class=\"katex-html\" aria-hidden=\"true\"><span class=\"base\"><span class=\"mord\"><span class=\"mfrac\"><span class=\"vlist-t vlist-t2\"><span class=\"vlist-r\"><span class=\"vlist\"><span class=\"\"><span class=\"sizing reset-size6 size3 mtight\"><span class=\"mord mtight\"><span class=\"mord text mtight\">Konjungsi&nbsp;antarkalimat</span></span></span></span><span class=\"\"><span class=\"sizing reset-size6 size3 mtight\"><span class=\"mord mtight\"><span class=\"mord text sizing reset-size3 size6\">Bahkan,</span></span></span></span></span><span class=\"vlist-s\">​</span></span></span></span></span></span></span></span>&nbsp;<span class=\"katex\"><span class=\"katex-mathml\">di&nbsp;berbagai&nbsp;kota&nbsp;besar&nbsp;di&nbsp;Indonesia&nbsp;seperti&nbsp;Jakarta,&nbsp;Surabaya,&nbsp;dan&nbsp;SemarangKeterangan</span><span class=\"katex-html\" aria-hidden=\"true\"><span class=\"base\"><span class=\"mord\"><span class=\"mfrac\"><span class=\"vlist-t vlist-t2\"><span class=\"vlist-r\"><span class=\"vlist\"><span class=\"\"><span class=\"sizing reset-size6 size3 mtight\"><span class=\"mord mtight\"><span class=\"mord text mtight\">Keterangan</span></span></span></span><span class=\"\"><span class=\"sizing reset-size6 size3 mtight\"><span class=\"mord mtight\"><span class=\"mord text sizing reset-size3 size6\">di&nbsp;berbagai&nbsp;kota&nbsp;besar&nbsp;di&nbsp;Indonesia&nbsp;seperti&nbsp;Jakarta,&nbsp;Surabaya,&nbsp;dan&nbsp;Semarang</span></span></span></span></span><span class=\"vlist-s\">​</span></span></span></span></span></span></span></span>&nbsp;<span class=\"katex\"><span class=\"katex-mathml\">merupakanPredikat</span><span class=\"katex-html\" aria-hidden=\"true\"><span class=\"base\"><span class=\"mord\"><span class=\"mfrac\"><span class=\"vlist-t vlist-t2\"><span class=\"vlist-r\"><span class=\"vlist\"><span class=\"\"><span class=\"sizing reset-size6 size3 mtight\"><span class=\"mord mtight\"><span class=\"mord text mtight\">Predikat</span></span></span></span><span class=\"\"><span class=\"sizing reset-size6 size3 mtight\"><span class=\"mord mtight\"><span class=\"mord text sizing reset-size3 size6\">merupakan</span></span></span></span></span><span class=\"vlist-s\">​</span></span></span></span></span></span></span></span>&nbsp;<span class=\"katex\"><span class=\"katex-mathml\">peristiwa&nbsp;rutin&nbsp;tiap&nbsp;tahun.Pelengkap</span><span class=\"katex-html\" aria-hidden=\"true\"><span class=\"base\"><span class=\"mord\"><span class=\"mfrac\"><span class=\"vlist-t vlist-t2\"><span class=\"vlist-r\"><span class=\"vlist\"><span class=\"\"><span class=\"sizing reset-size6 size3 mtight\"><span class=\"mord mtight\"><span class=\"mord text mtight\">Pelengkap</span></span></span></span><span class=\"\"><span class=\"sizing reset-size6 size3 mtight\"><span class=\"mord mtight\"><span class=\"mord text sizing reset-size3 size6\">peristiwa&nbsp;rutin&nbsp;tiap&nbsp;tahun.</span></span></span></span></span><span class=\"vlist-s\">​</span></span></span></span></span></span></span></span></p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">&nbsp;</p>\r\n<p class=\"font16 semi-normal brown-black pembahasan-content\" data-v-b20f6856=\"\" data-v-0fdc3c02=\"\">Jadi, jawaban yang tepat adalah&nbsp;<strong>E</strong>.</p>', 'Kalimat', '2025-05-27 04:06:36', '2025-05-27 04:06:36', NULL, 4, 18),
(70, '<p>fgfgfgfg</p>', NULL, 'pilihan_ganda', '<p>vbvbbvbv</p>', 'bb', '2025-05-27 04:37:45', '2025-05-27 04:37:45', NULL, 8, 17),
(71, '<p>managambar yang benar, soal bonus</p>', NULL, 'pilihan_ganda', '<p>d</p>', 'd', '2025-05-27 07:02:09', '2025-05-27 07:02:09', NULL, 4, 18),
(72, '<p>ini</p>', NULL, 'pilihan_ganda', '<p>sd</p>', 'sd', '2025-05-28 03:23:40', '2025-05-28 03:23:40', NULL, 8, 8),
(73, '<p>sdfdfdff</p>\r\n<p><img src=\"../../../storage/images/categories-gadgets.svg\" alt=\"\" width=\"76\" height=\"76\"></p>', NULL, 'pilihan_ganda', '<p><img src=\"https://ghost-blog-assets.zenius.net/wordpress/2022/04/pembahasan-soal-trigonometri.PNG.webp\" alt=\"Pembahasan Contoh Soal 1: Trigonometri\"></p>', '-', '2025-05-30 10:15:10', '2025-06-03 06:07:51', NULL, 9, 19),
(74, '<p><img src=\"../../storage/images/Screenshot 2025-05-30 171154.png\" alt=\"\" width=\"925\" height=\"78\"></p>\r\n<p>&nbsp;</p>', NULL, 'pilihan_ganda', '<p><img src=\"https://ghost-blog-assets.zenius.net/wordpress/2022/04/pembahasan-soal-trigonometri.PNG.webp\" alt=\"Pembahasan Contoh Soal 1: Trigonometri\"></p>', 'trigonometri', '2025-05-30 10:16:32', '2025-05-30 10:16:32', NULL, 9, 19),
(75, '<p>xdcxcxcxfxdcx</p>\r\n<p><img src=\"../../storage/images/erd.jpg\" alt=\"\" width=\"684\" height=\"490\"></p>', NULL, 'isian', '<p>dfdfdfdd</p>', 'dfdfd', '2025-06-03 03:26:12', '2025-06-03 03:26:12', NULL, 2, 20),
(76, '<p><img src=\"../../storage/images/dokumentasi black box2.png\" alt=\"\" width=\"799\" height=\"367\"></p>', NULL, 'pilihan_ganda', '<p>12</p>', '23', '2025-06-03 03:27:01', '2025-06-03 03:27:01', NULL, 9, 20),
(77, '<p><img src=\"../../storage/images/Screenshot 2025-06-03 131320.png\" alt=\"\" width=\"605\" height=\"63\"></p>', NULL, 'pilihan_ganda', '<p><img src=\"../../storage/images/Screenshot 2025-06-03 131417.png\" alt=\"\" width=\"450\" height=\"482\"></p>', 'Limit Matematika', '2025-06-03 06:17:15', '2025-06-03 06:17:15', NULL, 9, 19),
(78, '<p>dfdfdf<br><img src=\"../../storage/images/erd.jpg\" alt=\"\" width=\"617\" height=\"442\"></p>', NULL, 'pilihan_ganda', '<p>dfdfd</p>', 'dfd', '2025-06-03 06:21:45', '2025-06-03 06:21:45', NULL, 9, 19),
(79, '<p>&nbsp;</p>\r\n<p>ini testin</p>\r\n<p>&nbsp;<img src=\"../../storage/images/erd.jpg\" alt=\"\" width=\"698\" height=\"500\"></p>', NULL, 'pilihan_ganda', '<p>e</p>', 'bb', '2025-06-05 04:03:47', '2025-06-05 04:03:47', NULL, 2, 9),
(80, '<p>resw</p>', NULL, 'pilihan_ganda', '<p>ew</p>', 'd', '2025-06-07 05:22:28', '2025-06-07 05:22:28', NULL, 2, 9),
(81, '<p><img src=\"../../storage/images/Reza Nurfa Ilyas_Speed Test.png\" alt=\"\" width=\"470\" height=\"214\"></p>', NULL, 'isian', '<p>f</p>', 'f', '2025-06-08 12:35:05', '2025-06-08 12:35:05', NULL, 9, 21),
(82, '<p>ini merupakan gambar apa</p><p><img src=\"/storage/uploads/1749440774-image.png\" width=\"415\" height=\"196\"></p>', NULL, 'pilihan_ganda', '<figure class=\"image\"><img style=\"aspect-ratio:1913/1012;\" src=\"http://snbt.test/storage/uploads/1749440582-desain uas.png\" width=\"1913\" height=\"1012\"></figure>', 'S1', '2025-06-09 03:43:48', '2025-06-09 03:46:19', NULL, 4, 23),
(83, '<p>12212dfd rrtrtrtrrtrtrt<br>mendukung tidak mendukung</p>', NULL, 'pilihan_majemuk', '<p>232</p>', 'trigonometri', '2025-06-09 03:53:25', '2025-06-09 05:50:47', NULL, 4, 23),
(84, '<p>ini gambar apa</p><p><img src=\"/storage/uploads/1749447448-image.png\" width=\"649\" height=\"306\"></p>', NULL, 'pilihan_ganda', '<p><img src=\"/storage/uploads/1749447460-image.png\" width=\"649\" height=\"306\"></p><p>&nbsp;</p>', 'Teks', '2025-06-09 05:38:03', '2025-06-09 05:38:03', NULL, 2, 24),
(86, '<p>re sdsdsd mendukung tidak mendukung</p>', NULL, 'pilihan_majemuk', '<p>x</p>', 'x', '2025-06-09 05:46:57', '2025-06-09 05:46:57', NULL, 5, 24),
(87, '<p>re fddxcxc mendukung tidak mendukung</p>', NULL, 'pilihan_majemuk', '<p>d</p>', 'x', '2025-06-09 05:48:25', '2025-06-09 07:39:25', NULL, 5, 24),
(92, '<p>ds</p>', NULL, 'isian', '<p>d</p>', 'd', '2025-06-09 08:07:46', '2025-06-09 08:07:46', NULL, 4, 23),
(93, '<figure class=\"image\"><img style=\"aspect-ratio:1913/1012;\" src=\"/storage/uploads/1749457367-desain uas.png\" width=\"1913\" height=\"1012\"></figure>', NULL, 'pilihan_ganda', '<figure class=\"image\"><img style=\"aspect-ratio:1913/1012;\" src=\"/storage/uploads/1749457380-desain uas.png\" width=\"1913\" height=\"1012\"></figure><p>dfd</p>', 'd', '2025-06-09 08:23:17', '2025-06-09 08:23:17', NULL, 4, 23),
(94, '<p>reza</p>', NULL, 'pilihan_ganda', '<p>dsd</p>', 'Sejarah', '2025-06-09 08:41:19', '2025-06-09 08:41:19', NULL, 4, 23),
(95, '<p><img src=\"/storage/uploads/1749458790-image.png\" width=\"600\" height=\"418\"></p>', NULL, 'pilihan_ganda', '<figure class=\"image\"><img style=\"aspect-ratio:600/418;\" src=\"/storage/uploads/1749458796-image.png\" width=\"600\" height=\"418\"></figure>', 's', '2025-06-09 08:46:48', '2025-06-09 08:46:48', NULL, 4, 23),
(96, '<p><img src=\"http://snbt.test/storage/uploads/1749459273-image.png\" width=\"603\" height=\"351\"></p>', NULL, 'pilihan_ganda', '<p><img src=\"http://snbt.test/storage/uploads/1749459279-image.png\" width=\"603\" height=\"351\"></p>', 'e', '2025-06-09 08:55:00', '2025-06-09 08:55:57', NULL, 4, 23),
(97, '<figure class=\"image\"><img style=\"aspect-ratio:512/512;\" src=\"/storage/uploads/1749531360-admin.png\" width=\"512\" height=\"512\"></figure>', NULL, 'pilihan_ganda', '<figure class=\"image\"><img style=\"aspect-ratio:112/112;\" src=\"/storage/uploads/1749531372-icon-testimonial-1.png\" width=\"112\" height=\"112\"></figure>', 'r', '2025-06-10 04:56:29', '2025-06-10 04:56:29', NULL, 4, 23),
(98, '<figure class=\"image\"><img style=\"aspect-ratio:112/112;\" src=\"http://snbt.test/storage/uploads/1749531462-icon-testimonial-1.png\" width=\"112\" height=\"112\"></figure>', NULL, 'pilihan_ganda', '<figure class=\"image\"><img style=\"aspect-ratio:44/44;\" src=\"http://snbt.test/storage/uploads/1749531471-dashboard-icon-product-3.png\" width=\"44\" height=\"44\"></figure>', 'd', '2025-06-10 04:58:07', '2025-06-10 05:01:25', NULL, 2, 25),
(99, '<p><img src=\"/storage/uploads/1749631987-images.jpeg\" width=\"224\" height=\"224\"></p>', NULL, 'pilihan_ganda', '<p>ini gambar upn atau universitas veteran jakarta<br>&nbsp;</p><p><img src=\"/storage/uploads/1749632010-images.jpeg\" width=\"224\" height=\"224\"></p>', 'Penetahuan Umum', '2025-06-11 08:53:51', '2025-06-11 08:53:51', NULL, 4, 23),
(100, '<p>ini merupakan mobil f1 apa</p><p><img src=\"/storage/uploads/1749643011-image.png\" width=\"431\" height=\"288\"></p>', NULL, 'pilihan_ganda', '<p>ini merupakan mobil mclaren</p><p><img src=\"/storage/uploads/1749643020-image.png\" width=\"431\" height=\"288\"></p>', 'F1', '2025-06-11 11:51:32', '2025-06-11 11:57:12', NULL, 3, 25),
(101, '<p>ini merupaka mobil apa<br>&nbsp;</p><p><img src=\"/storage/uploads/1749642834-image.png\" width=\"284\" height=\"189\"></p>', NULL, 'pilihan_ganda', '<p><img src=\"/storage/uploads/1749642838-image.png\" width=\"284\" height=\"189\"></p><p>redbull</p>', 'F1', '2025-06-11 11:54:18', '2025-06-11 11:54:18', NULL, 3, 25);

-- --------------------------------------------------------

--
-- Table structure for table `regencies`
--

CREATE TABLE `regencies` (
  `id` char(4) COLLATE utf8mb4_unicode_ci NOT NULL,
  `province_id` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `results`
--

CREATE TABLE `results` (
  `id` bigint UNSIGNED NOT NULL,
  `score` double(8,2) NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `exam_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `results`
--

INSERT INTO `results` (`id`, `score`, `user_id`, `exam_id`, `created_at`, `updated_at`) VALUES
(48, 60.00, 1, 1, '2025-05-14 05:19:18', '2025-06-11 06:38:06'),
(59, 0.00, 1, 3, '2025-05-25 04:17:03', '2025-05-25 04:17:03'),
(60, 150.00, 1, 16, '2025-05-25 08:05:41', '2025-05-29 07:05:33'),
(61, 0.00, 1, 12, '2025-05-25 08:39:23', '2025-05-25 08:39:23'),
(62, 150.00, 3, 16, '2025-05-26 03:48:55', '2025-05-29 07:05:33'),
(63, 150.00, 4, 16, '2025-05-26 04:01:14', '2025-05-29 07:05:33'),
(67, 2.00, 1, 17, '2025-05-27 06:03:32', '2025-05-27 06:53:21'),
(70, 493.37, 3, 18, '2025-05-28 02:44:11', '2025-06-11 07:17:29'),
(71, 270.36, 5, 18, '2025-05-28 02:51:26', '2025-06-11 07:17:29'),
(72, 226.84, 4, 18, '2025-05-28 02:54:58', '2025-06-11 07:17:29'),
(73, 4.00, 4, 1, '2025-05-28 03:05:21', '2025-05-28 03:05:56'),
(74, 283.54, 6, 18, '2025-05-28 03:08:17', '2025-06-11 07:17:29'),
(75, 0.00, 1, 8, '2025-05-28 03:24:30', '2025-05-28 03:24:30'),
(76, 0.00, 1, 14, '2025-05-28 11:54:05', '2025-05-28 11:54:05'),
(79, 0.00, 3, 20, '2025-06-03 03:27:27', '2025-06-03 03:27:27'),
(80, 50.00, 1, 9, '2025-06-05 04:51:07', '2025-06-05 04:51:07'),
(81, 66.67, 1, 23, '2025-06-09 03:48:51', '2025-06-11 11:37:32'),
(84, 0.00, 1, 24, '2025-06-09 08:02:04', '2025-06-09 08:02:04'),
(86, 75.00, 1, 19, '2025-06-11 05:50:58', '2025-06-11 05:53:10'),
(90, 496.30, 1, 18, '2025-06-11 06:26:51', '2025-06-11 07:17:29'),
(91, 66.67, 5, 23, '2025-06-11 11:37:09', '2025-06-11 11:37:09'),
(93, 0.00, 10, 25, '2025-06-11 11:55:06', '2025-06-11 11:55:06'),
(94, 0.00, 3, 25, '2025-06-11 12:02:55', '2025-06-11 12:02:55'),
(95, 0.00, 1, 25, '2025-06-11 12:04:12', '2025-06-11 12:04:12');

-- --------------------------------------------------------

--
-- Table structure for table `results_evaluations`
--

CREATE TABLE `results_evaluations` (
  `id` bigint UNSIGNED NOT NULL,
  `result_id` bigint UNSIGNED NOT NULL,
  `evaluation` longtext COLLATE utf8mb4_unicode_ci,
  `recommendation` longtext COLLATE utf8mb4_unicode_ci,
  `correct` int DEFAULT NULL,
  `wrong` int DEFAULT NULL,
  `empty` int DEFAULT NULL,
  `score` double(10,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `results_evaluations`
--

INSERT INTO `results_evaluations` (`id`, `result_id`, `evaluation`, `recommendation`, `correct`, `wrong`, `empty`, `score`, `created_at`, `updated_at`) VALUES
(12, 70, '<p><strong>Evaluasi Kompetensi Siswa</strong></p>\n<p>Siswa telah menyelesaikan latihan soal dengan nilai 609/1000. Berikut adalah evaluasi kompetensi siswa berdasarkan kekuatan dan kelemahan subbab Pembahasan:</p>\n<p><strong>Kekuatan:</strong></p>\n<ol>\n<li><strong>Ide Pokok</strong>: Siswa telah memahami ide pokok teks, yaitu &quot;Dewasa ini ulah manusia melakukan perusakan alam dan sistem lingkungan yang...&quot; dengan benar.</li>\n<li><strong>Pernyataan Dalam Teks</strong>: Siswa telah dapat menemukan pernyataan dalam teks yang relevan dengan ide pokok, yaitu &quot;Walaupun khasiat susu bagi tubuh kita sudah tidak diragukan lagi, tidak setiap orang dapat menikmati manfaatnya...&quot;</li>\n<li><strong>Semantik</strong>: Siswa telah memahami semantik teks, yaitu struktur kalimat dan kata-kata yang digunakan untuk mengungkapkan ide pokok.</li>\n<li><strong>PUEBI</strong>: Siswa telah dapat menemukan PUEBI (Pernyataan Utama, Eksplanasi, Bukti, dan Ikhtisar) dalam teks yang relevan dengan ide pokok.</li>\n<li><strong>Pemahaman Bacaan</strong>: Siswa telah memahami isi teks dan dapat menjelaskan ide pokok dengan jelas.</li>\n<li><strong>Kalimat</strong>: Siswa telah dapat menemukan kalimat yang relevan dengan ide pokok.</li>\n<li><strong>Managambar yang Benar</strong>: Siswa telah dapat menemukan managambar yang benar.</li>\n</ol>\n<p><strong>Kelemahan:</strong></p>\n<ol>\n<li><strong>Analisis Bacaan &amp; Kepaduan Paragraf</strong>: Siswa masih belum dapat menganalisis teks secara baik dan tidak dapat menjelaskan kepaduan paragraf dengan jelas. Siswa masih perlu melatih soal pada subbab Analisis Bacaan &amp; Kepaduan Paragraf setiap hari dan tinjau ulang penjelasan konsep di subbab Analisis Bacaan &amp; Kepaduan Paragraf.</li>\n</ol>\n<p><strong>Strategi Pembelajaran:</strong></p>\n<ol>\n<li>Latih soal pada subbab Analisis Bacaan &amp; Kepaduan Paragraf setiap hari.</li>\n<li>Tinjau ulang penjelasan konsep di subbab Analisis Bacaan &amp; Kepaduan Paragraf (video atau ringkasan).</li>\n</ol>\n<p>Dengan demikian, siswa dapat meningkatkan kompetensinya dalam menganalisis teks dan menjelaskan kepaduan paragraf.</p>', '<p>Berikut adalah analisis peluang berdasarkan data real dan strategi peningkatan nilai yang realistis:</p>\n<p><strong>Evaluasi gap nilai terhadap semua pilihan jurusan:</strong></p>\n<ol>\n<li><strong>PENDIDIKAN DOKTER (Universitas Indonesia)</strong>\n<ul>\n<li>Passing Score: 854.48</li>\n<li>Nilai Tryout: 609.35</li>\n<li>Gap nilai: 245.13 poin</li>\n<li>Analisis: Pilihan jurusan ini memerlukan peningkatan nilai yang signifikan. Target berdasarkan gap nilai sebenarnya adalah mencapai nilai 854.48.</li>\n</ul></li>\n<li><strong>ILMU KOMPUTER (Universitas Gadjah Mada)</strong>\n<ul>\n<li>Passing Score: 815.7</li>\n<li>Nilai Tryout: 609.35</li>\n<li>Gap nilai: 206.35 poin</li>\n<li>Analisis: Pilihan jurusan ini memerlukan peningkatan nilai yang signifikan. Target berdasarkan gap nilai sebenarnya adalah mencapai nilai 815.7.</li>\n</ul></li>\n<li><strong>ADMINISTRASI ASURANSI &amp; AKTUARIA (Universitas Indonesia)</strong>\n<ul>\n<li>Passing Score: 551.72</li>\n<li>Nilai Tryout: 609.35</li>\n<li>Gap nilai: -57.63 poin</li>\n<li>Analisis: Pilihan jurusan ini sudah sangat aman dan tidak memerlukan peningkatan nilai.</li>\n</ul></li>\n</ol>\n<p><strong>Alternatif dari database:</strong></p>\n<p>Pada kategori &quot;Pilihan Aman&quot;, ada beberapa jurusan yang paling mendekati nilai Anda:</p>\n<ol>\n<li><strong>ADMINISTRASI RUMAH SAKIT (Universitas Indonesia)</strong>\n<ul>\n<li>Passing Score: 605.18</li>\n<li>Nilai Tryout: 609.35</li>\n<li>Gap nilai: 4.17 poin</li>\n</ul></li>\n<li><strong>SASTRA BELANDA (Universitas Indonesia)</strong>\n<ul>\n<li>Passing Score: 603.87</li>\n<li>Nilai Tryout: 609.35</li>\n<li>Gap nilai: 5.48 poin</li>\n</ul></li>\n</ol>\n<p>Pada kategori &quot;Target Stretch&quot;, tidak ada jurusan yang paling mendekati nilai Anda.</p>\n<p><strong>Strategi peningkatan realistis:</strong></p>\n<ol>\n<li><strong>Pendidikan Dokter (Universitas Indonesia)</strong>\n<ul>\n<li>Target: Mencapai nilai 854.48</li>\n<li>Langkah peningkatan: Fokus pada mata pelajaran Biologi dan Kimia, dan lakukan latihan ujian secara intensif selama 2 bulan.</li>\n</ul></li>\n<li><strong>Ilmu Komputer (Universitas Gadjah Mada)</strong>\n<ul>\n<li>Target: Mencapai nilai 815.7</li>\n<li>Langkah peningkatan: Fokus pada mata pelajaran Matematika dan Fisika, dan lakukan latihan ujian secara intensif selama 2 bulan.</li>\n</ul></li>\n</ol>\n<p>Dengan demikian, re</p>', 10, 1, 0, 493.37, '2025-06-03 07:17:11', '2025-06-11 07:17:29'),
(18, 80, '<p><strong>Evaluasi Kompetensi Siswa</strong></p>\n<p>Dengan nilai 50/100, dapat disimpulkan bahwa siswa masih membutuhkan perbaikan dalam kompetensinya. Oleh karena itu, perlu dilakukan analisis detail untuk mengetahui kekuatan dan kelemahan siswa.</p>\n<p><strong>Kekuatan Siswa</strong></p>\n<ul>\n<li>Subbab yang kuat: </li>\n<li>Siswa menunjukkan kemampuan dasar dalam menjawab soal, tetapi masih membutuhkan perbaikan dalam menghadapi soal-soal yang lebih sulit.</li>\n<li>Siswa memiliki kemampuan dalam menganalisis dan memecahkan masalah.</li>\n</ul>\n<p><strong>Kelemahan Siswa</strong></p>\n<ul>\n<li>Trigonometri: Siswa masih membutuhkan perbaikan dalam memahami konsep dan soal-soal trigonometri. Siswa cenderung bingung dan tidak dapat menjawab soal-soal dengan benar. </li>\n<li>Siswa perlu meningkatkan kemampuan dalam mengingat rumus-rumus trigonometri dan menerapkan konsep-konsep dasar.</li>\n</ul>\n<p><strong>Strategi Pembelajaran</strong></p>\n<p>Untuk meningkatkan kemampuan siswa, perlu dilakukan strategi pembelajaran yang efektif. Berikut beberapa strategi yang dapat digunakan:</p>\n<ul>\n<li><strong>Latihan Soal Trigonometri</strong>: Saya akan meminta siswa untuk latihan soal trigonometri setiap hari. Dengan demikian, siswa dapat meningkatkan kemampuan dalam menghadapi soal-soal trigonometri dan memahami konsep-konsep dasar.</li>\n<li><strong>Tinjau Ulang Penjelasan Konsep</strong>: Saya akan meminta siswa untuk tinjau ulang penjelasan konsep trigonometri (video atau ringkasan). Dengan demikian, siswa dapat memahami konsep-konsep dasar dan meningkatkan kemampuan dalam mengaplikasikan konsep-konsep tersebut.</li>\n</ul>\n<p>Dengan strategi pembelajaran yang efektif, saya percaya bahwa siswa dapat meningkatkan kemampuan dan mencapai hasil yang lebih baik dalam kompetensi trigonometri.</p>', NULL, NULL, NULL, NULL, NULL, '2025-06-05 04:51:43', '2025-06-05 04:51:43'),
(19, 80, '<p><strong>Evaluasi Kompetensi Siswa</strong></p>\n<p>Siswa memiliki nilai 50/100 dalam latihan soal, menunjukkan bahwa masih banyak aspek yang perlu ditingkatkan. Namun, ada beberapa kekuatan dan kelemahan yang perlu diperhatikan.</p>\n<p><strong>Kekuatan:</strong></p>\n<ol>\n<li><strong>Pengertian dasar</strong>: Siswa memiliki kemampuan memahami konsep dasar dalam pelajaran, seperti definisi dan pengertian dasar.</li>\n<li><strong>Penggunaan istilah</strong>: Siswa dapat menggunakan istilah yang benar dalam menjawab soal, menunjukkan bahwa mereka telah memahami konsep dasar.</li>\n<li><strong>Pengertian logika</strong>: Siswa memiliki kemampuan memahami logika dan struktur soal, sehingga dapat menjawab soal dengan lebih efektif.</li>\n</ol>\n<p><strong>Kelemahan:</strong></p>\n<ol>\n<li><strong>Trigonometri</strong>: Siswa masih memiliki kesulitan dalam memahami konsep trigonometri, seperti sudut, sinus, kosinus, dan tangen. Mereka masih kesulitan mengaplikasikan konsep ini dalam menjawab soal.</li>\n<li><strong>Penggunaan rumus</strong>: Siswa masih kesulitan menggunakan rumus trigonometri dengan benar, sehingga menjawab soal menjadi lebih sulit.</li>\n<li><strong>Pengertian konsep</strong>: Siswa masih kesulitan memahami konsep trigonometri secara mendalam, sehingga mereka masih kesulitan mengaplikasikan konsep ini dalam menjawab soal.</li>\n</ol>\n<p><strong>Strategi Pembelajaran:</strong></p>\n<p>Untuk meningkatkan kompetensi siswa dalam trigonometri, berikut beberapa strategi yang dapat digunakan:</p>\n<ol>\n<li><strong>Latih soal setiap hari</strong>: Siswa harus melatih soal trigonometri setiap hari untuk meningkatkan kemampuan mereka dalam mengaplikasikan konsep ini.</li>\n<li><strong>Tinjau ulang penjelasan konsep</strong>: Siswa harus meninjau ulang penjelasan konsep trigonometri untuk memahami konsep ini secara mendalam.</li>\n<li><strong>Gunakan video atau ringkasan</strong>: Siswa dapat menggunakan video atau ringkasan untuk memahami konsep trigonometri secara lebih efektif.</li>\n</ol>\n<p>Dengan menggunakan strategi ini, saya yakin bahwa siswa dapat meningkatkan kompetensi mereka dalam trigonometri dan mencapai nilai yang lebih baik.</p>', NULL, NULL, NULL, NULL, NULL, '2025-06-05 04:52:28', '2025-06-05 04:52:28'),
(20, 48, '<p><strong>Evaluasi Kompetensi Siswa</strong></p>\n<p>Pada dasarnya, evaluasi kompetensi siswa bertujuan untuk mengetahui kemampuan siswa dalam memahami dan menerapkan konsep-konsep yang telah dipelajari. Dalam hal ini, saya akan mengevaluasi kompetensi siswa berdasarkan latihan soal yang diberikan.</p>\n<p><strong>Kekuatan</strong></p>\n<p>Siswa memiliki beberapa kekuatan dalam hal memahami dan menerapkan konsep-konsep yang telah dipelajari. Beberapa contoh kekuatan siswa adalah:</p>\n<ul>\n<li><strong>Pernyataan dalam teks</strong>: Siswa dapat memahami dan menerapkan pernyataan dalam teks dengan baik. Contohnya, pernyataan &quot;Pestisida alami sering digunakan karena harganya terjangkau dan lebih ramah lingkungan&quot; menunjukkan bahwa siswa dapat memahami konsep tentang pestisida alami dan kelebihannya.</li>\n<li><strong>Krab adalah</strong>: Siswa juga dapat memahami konsep tentang krab dan dapat menjawab pertanyaan dengan tepat. Contohnya, siswa dapat menjawab bahwa krab adalah hewan laut yang memiliki cangkang keras.</li>\n</ul>\n<p><strong>Kelemahan</strong></p>\n<p>Namun, siswa juga memiliki beberapa kelemahan dalam hal memahami dan menerapkan konsep-konsep yang telah dipelajari. Beberapa contoh kelemahan siswa adalah:</p>\n<ul>\n<li><strong>fgfgfgf</strong>: Siswa masih memiliki kesulitan dalam memahami konsep-konsep yang terkait dengan subbab ini. Contohnya, siswa masih belum dapat menjawab pertanyaan dengan tepat dan masih memiliki kesulitan dalam menerapkan konsep-konsep yang terkait dengan subbab ini.</li>\n<li><strong>RTRT</strong>: Siswa juga masih memiliki kesulitan dalam memahami konsep-konsep yang terkait dengan subbab ini. Contohnya, siswa masih belum dapat menjawab pertanyaan dengan tepat dan masih memiliki kesulitan dalam menerapkan konsep-konsep yang terkait dengan subbab ini.</li>\n</ul>\n<p><strong>Strategi Pembelajaran</strong></p>\n<p>Untuk meningkatkan kemampuan siswa dalam memahami dan menerapkan konsep-konsep yang telah dipelajari, berikut beberapa strategi pembelajaran yang dapat digunakan:</p>\n<ul>\n<li><strong>Latih soal setiap hari</strong>: Siswa dapat melatih soal pada subbab <strong>fgfgfgf</strong> dan <strong>RTRT</strong> setiap hari untuk meningkatkan kemampuan mereka dalam memahami dan menerapkan konsep-konsep yang terkait dengan subbab ini.</li>\n<li><strong>Tinjau ulang penjelasan konsep</strong>: Siswa dapat meninjau ulang penjelasan konsep di subbab <strong>fgfgfgf</strong> dan <strong>RTRT</strong> (video atau ringkasan) untuk memahami konsep-konsep yang terkait dengan subbab ini lebih baik.</li>\n</ul>\n<p>Dengan menggunakan strategi pembelajaran ini, diharapkan siswa dapat meningkatkan kemampuan mereka dalam memahami dan menerapkan konsep-konsep yang telah dipelajari.</p>', NULL, NULL, NULL, NULL, NULL, '2025-06-06 07:38:20', '2025-06-06 07:38:20'),
(21, 67, '<p><strong>Evaluasi Kompetensi Siswa</strong></p>\n<p>Saat ini, nilai siswa adalah 2/100. Untuk meningkatkan nilai ini, perlu diperhatikan kekuatan dan kelemahan siswa dalam memahami materi pelajaran. Berikut adalah evaluasi kompetensi siswa:</p>\n<p><strong>Kekuatan:</strong></p>\n<ol>\n<li><strong>Matematika:</strong> Siswa mampu menjawab soal tentang nilai dari limx→0sin⁡xx. Soal ini menunjukkan bahwa siswa memiliki pemahaman tentang konsep limit dalam matematika.\n<ul>\n<li>Deskripsi: Siswa memiliki kemampuan untuk menghitung limit trigonometri, yang menunjukkan bahwa siswa telah memahami konsep dasar trigonometri dan limit.</li>\n</ul></li>\n<li><strong>Trigonometri:</strong>\n<ul>\n<li>a2+b2=c2: Siswa mampu menjawab soal tentang identitas trigonometri a2+b2=c2. Soal ini menunjukkan bahwa siswa memiliki pemahaman tentang konsep identitas trigonometri.</li>\n<li>Ini merupakan gambar apa: Siswa mampu mengidentifikasi gambar yang sesuai dengan deskripsi. Soal ini menunjukkan bahwa siswa memiliki kemampuan untuk menganalisis dan mengidentifikasi gambar.</li>\n<li>Rumus kuadrat: x=−b±√(b^2−4ac) Siswa mampu menjawab soal tentang rumus kuadrat. Soal ini menunjukkan bahwa siswa memiliki pemahaman tentang konsep dasar algebra.</li>\n</ul></li>\n</ol>\n<p><strong>Kelemahan:</strong></p>\n<ol>\n<li><strong>bb:</strong> Siswa memiliki kesulitan dalam menjawab soal tentang fgfgfgfg. Soal ini menunjukkan bahwa siswa memiliki kesulitan dalam memahami konsep dasar algebra.\n<ul>\n<li>Deskripsi: Siswa memiliki kesulitan dalam menghitung ekspresi aljabar, yang menunjukkan bahwa siswa belum memahami konsep dasar algebra dengan baik.</li>\n</ul></li>\n</ol>\n<p><strong>Strategi Pembelajaran:</strong></p>\n<ol>\n<li><strong>Latih soal pada subbab bb:</strong> Siswa perlu melatih soal-soal pada subbab bb setiap hari untuk meningkatkan pemahaman konsep dasar algebra.\n<ul>\n<li>Tujuan: Meningkatkan kemampuan siswa dalam menghitung ekspresi aljabar.</li>\n</ul></li>\n<li><strong>Tinjau ulang penjelasan konsep di subbab bb:</strong> Siswa perlu meninjau ulang penjelasan konsep di subbab bb melalui video atau ringkasan untuk memahami konsep dasar algebra dengan baik.\n<ul>\n<li>Tujuan: Meningkatkan pemahaman siswa tentang konsep dasar algebra.</li>\n</ul></li>\n</ol>\n<p>Dengan strategi pembelajaran ini, diharapkan nilai siswa akan meningkat dan siswa dapat memahami materi pelajaran dengan lebih baik.</p>', NULL, NULL, NULL, NULL, NULL, '2025-06-06 07:39:26', '2025-06-06 07:39:26'),
(22, 60, '<p><strong>Evaluasi Kompetensi Siswa</strong></p>\n<p>Siswa telah menyelesaikan latihan soal dengan nilai 150/1000, yang menunjukkan bahwa siswa masih perlu memperbaiki kemampuan dalam beberapa subbab.</p>\n<p><strong>Kekuatan:</strong></p>\n<p>Tidak ada subbab yang berhasil dikuasai oleh siswa, sehingga semua subbab perlu diperbaiki.</p>\n<p><strong>Kelemahan:</strong></p>\n<ol>\n<li><strong>Subbab sd</strong>: Siswa mengalami kesulitan pada pertanyaan ke-6 (q 6). Deskripsi: Siswa masih belum memahami konsep dasar pada subbab ini, sehingga perlu dilatih dan dipelajari kembali.</li>\n<li><strong>Subbab rwer</strong>: Siswa mengalami kesulitan pada beberapa aspek, termasuk rwer. Deskripsi: Siswa masih belum memahami konsep dasar pada subbab ini, sehingga perlu dilatih dan dipelajari kembali.</li>\n</ol>\n<p><strong>Strategi Pembelajaran:</strong></p>\n<p>Untuk meningkatkan kemampuan siswa, disarankan untuk:</p>\n<ol>\n<li>Latih soal pada subbab <strong>sd</strong> setiap hari, dengan fokus pada pertanyaan ke-6 (q 6).</li>\n<li>Tinjau ulang penjelasan konsep di subbab <strong>sd</strong> (video atau ringkasan) untuk memahami konsep dasar dengan lebih baik.</li>\n<li>Latih soal pada subbab <strong>rwer</strong> setiap hari, dengan fokus pada aspek rwer.</li>\n<li>Tinjau ulang penjelasan konsep di subbab <strong>rwer</strong> (video atau ringkasan) untuk memahami konsep dasar dengan lebih baik.</li>\n</ol>\n<p>Dengan strategi pembelajaran ini, diharapkan siswa dapat meningkatkan kemampuan dan mencapai nilai yang lebih baik dalam latihan soal berikutnya.</p>', '<p>Setelah menganalisis data yang tersedia, saya akan memberikan rekomendasi berdasarkan aturan yang ketat.</p>\n<p><strong>ANALISIS PELUANG BERDASARKAN DATA REAL</strong></p>\n<p>Dengan nilai tryout 150/1000, saya melihat bahwa Anda masih perlu peningkatan nilai untuk masuk ke beberapa jurusan yang Anda pilih. Berikut adalah evaluasi gap nilai terhadap semua pilihan jurusan:</p>\n<ul>\n<li>FARMASI (Universitas Gadjah Mada): Kurang 687.79 poin (Nilai Anda: 150, Passing Score: 837.79)</li>\n<li>ILMU KOMPUTER (Universitas Gadjah Mada): Kurang 665.7 poin (Nilai Anda: 150, Passing Score: 815.7)</li>\n<li>FAKULTAS ILMU DAN TEKNOLOGI KEBUMIAN (FITB) (Institut Teknologi Bandung): Kurang 612.48 poin (Nilai Anda: 150, Passing Score: 762.48)</li>\n</ul>\n<p>Dari hasil evaluasi, saya melihat bahwa Anda masih perlu peningkatan nilai yang signifikan untuk masuk ke beberapa jurusan yang Anda pilih.</p>\n<p><strong>ALTERNATIF DARI DATABASE</strong></p>\n<p>Tidak ada data di &quot;Pilihan Aman&quot; karena nilai Anda tidak mencapai passing score yang tersedia. Namun, saya akan mengevaluasi data di &quot;Target Stretch&quot; untuk melihat apakah ada alternatif yang sesuai.</p>\n<p>Dalam kategori &quot;Target Stretch&quot;, saya melihat bahwa beberapa jurusan memiliki passing score yang lebih rendah dari nilai Anda. Namun, saya tidak akan merekomendasikan jurusan-jurusan ini karena aturan yang ketat hanya memungkinkan saya untuk menggunakan nama jurusan dan universitas yang tertera dalam &quot;Pilihan Aman&quot; atau &quot;Target Stretch&quot;.</p>\n<p><strong>STRATEGI PENINGKATAN REALISTIS</strong></p>\n<p>Untuk meningkatkan nilai Anda, saya merekomendasikan Anda untuk fokus pada mata pelajaran atau materi ujian yang paling berdampak. Berikut adalah langkah peningkatan yang realistis:</p>\n<ul>\n<li>Buatlah rencana belajar yang jelas dan terstruktur untuk meningkatkan nilai Anda.</li>\n<li>Fokus pada mata pelajaran atau materi ujian yang paling berdampak, seperti matematika, fisika, atau kimia.</li>\n<li>Gunakan sumber belajar yang efektif, seperti buku teks, video tutorial, atau aplikasi belajar.</li>\n<li>Lakukan latihan dan evaluasi secara teratur untuk memantau kemajuan Anda.</li>\n<li>Dengan kerja keras dan fokus, Anda dapat meningkatkan nilai Anda dalam waktu 2-3 bulan.</li>\n</ul>\n<p><strong>REKOMENDASI</strong></p>\n<p>Dengan nilai tryout 150/1000, saya merekomendasikan Anda untuk fokus pada meningkatkan nilai Anda melalui strategi peningkatan yang realistis. Anda dapat memilih salah satu atau beberapa jurusan yang Anda pilih untuk fokus pada peningkatan nilai Anda.</p>\n<ul>\n<li>Fokus pada mata pelajaran atau materi ujian yang paling berdampak.</li>\n<li>Buatlah rencana belajar yang jelas dan terstruktur untuk meningkatkan nilai Anda.</li>\n<li>Gunakan sumber belajar yang efektif untuk meningkatkan kemampuan Anda.</li>\n</ul>\n<p>Dengan kerja keras dan fokus, Anda dapat meningkatkan nilai Anda dan mempertimbangkan untuk masuk ke beberapa jurusan yang Anda pilih.</p>', NULL, NULL, NULL, NULL, '2025-06-07 08:43:34', '2025-06-07 08:43:57'),
(23, 81, '<p>Berdasarkan evaluasi latihan soal, saya menemukan beberapa kekuatan dan kelemahan yang perlu diperhatikan.</p>\n<p><strong>KEKUATAN SUBBAB PEMBAHASAN</strong></p>\n<p>Siswa memiliki kekuatan dalam menganalisis dan memahami materi yang diberikan. Siswa dapat dengan cepat dan akurat mengidentifikasi gambar, yaitu gambar yang menunjukkan sebuah buku teks. Siswa juga dapat menjawab soal dengan benar, tanpa ada kesalahan.</p>\n<p><strong>KELEMAHAN SUBBAB PEMBAHASAN</strong></p>\n<p>Tidak ada kelemahan yang teridentifikasi dalam materi yang diberikan. Siswa telah menyelesaikan semua soal dengan benar, tanpa ada kesalahan atau kebingungan. Siswa telah menunjukkan kemampuan yang sangat baik dalam memahami materi dan menjawab soal dengan akurat.</p>\n<p><strong>SARAN</strong></p>\n<p>Untuk meningkatkan kemampuan siswa, saya sarankan siswa untuk terus memantau dan meningkatkan kemampuan analitisnya. Siswa dapat melakukan ini dengan:</p>\n<ul>\n<li>Melakukan latihan soal secara teratur untuk meningkatkan kemampuan menganalisis dan memahami materi.</li>\n<li>Membaca dan memahami materi yang diberikan dengan seksama.</li>\n<li>Membuat catatan dan ringkasan materi untuk membantu memahami dan mengingat materi.</li>\n</ul>\n<p>Dengan melakukan hal-hal di atas, siswa dapat meningkatkan kemampuan analitisnya dan menjadi lebih percaya diri dalam menjawab soal.</p>\n<p><strong>STRATEGI PEMBELAJARAN</strong></p>\n<p>Siswa yang memiliki kemampuan ini perlu mempertahankan konsistensi belajar. Siswa dapat melakukan ini dengan:</p>\n<ul>\n<li>Membuat jadwal belajar yang teratur dan tetap.</li>\n<li>Membuat rencana belajar yang spesifik dan realistis.</li>\n<li>Membuat catatan dan ringkasan materi untuk membantu memahami dan mengingat materi.</li>\n<li>Membuat latihan soal secara teratur untuk meningkatkan kemampuan menganalisis dan memahami materi.</li>\n</ul>\n<p>Dengan melakukan hal-hal di atas, siswa dapat meningkatkan kemampuan belajarnya dan menjadi lebih sukses dalam akademik.</p>', NULL, NULL, NULL, NULL, NULL, '2025-06-09 03:49:00', '2025-06-09 03:49:00'),
(24, 86, '<p>Berikut adalah evaluasi kompetensi siswa berdasarkan latihan soal:</p>\n<p><strong>Kekuatan Subbab Pembahasan</strong></p>\n<p>Siswa memiliki kemampuan yang baik dalam menganalisis konsep trigonometri, terlihat dari jawaban soal yang akurat dan sistematik. Siswa mampu menerapkan konsep trigonometri untuk menyelesaikan masalah yang kompleks, menunjukkan kemampuan berpikir kritis dan analitis yang baik.</p>\n<p><strong>Kelemahan Subbab Pembahasan</strong></p>\n<p>Namun, siswa masih memiliki kelemahan dalam beberapa area, yaitu:</p>\n<ul>\n<li><strong>Limit Matematika</strong>: Siswa masih belum menguasai konsep limit matematika dengan baik, terlihat dari jawaban soal yang salah atau tidak lengkap. Siswa mungkin masih belum memahami prinsip dasar limit matematika, seperti konsep limit sentral dan limit perbatasan.</li>\n<li><strong>dfd</strong>: Siswa masih belum memiliki pengetahuan yang cukup tentang subbab ini, terlihat dari jawaban soal yang salah atau tidak ada. Siswa mungkin belum pernah mempelajari subbab ini sebelumnya atau belum memahami konsep dasar yang terkait.</li>\n</ul>\n<p><strong>Strategi Pembelajaran</strong></p>\n<p>Untuk meningkatkan kemampuan siswa, saya merekomendasikan strategi pembelajaran berikut:</p>\n<ul>\n<li><strong>Latih soal pada subbab Limit Matematika setiap hari</strong>: Saya merekomendasikan siswa untuk memulai dengan mempelajari konsep dasar limit matematika dan kemudian melanjutkan dengan mengerjakan soal-soal yang terkait. Siswa dapat menggunakan sumber belajar seperti buku teks, video, atau aplikasi pembelajaran online untuk mendukung proses belajar mereka.</li>\n<li><strong>Tinjau ulang penjelasan konsep di subbab Limit Matematika (video atau ringkasan)</strong>: Saya merekomendasikan siswa untuk meninjau ulang penjelasan konsep limit matematika untuk memastikan bahwa mereka memahami dengan baik. Siswa dapat menggunakan video atau ringkasan untuk membantu memahami konsep dasar limit matematika.</li>\n<li><strong>Latih soal pada subbab dfd setiap hari</strong>: Saya merekomendasikan siswa untuk memulai dengan mempelajari konsep dasar subbab dfd dan kemudian melanjutkan dengan mengerjakan soal-soal yang terkait. Siswa dapat menggunakan sumber belajar seperti buku teks, video, atau aplikasi pembelajaran online untuk mendukung proses belajar mereka.</li>\n<li><strong>Tinjau ulang penjelasan konsep di subbab dfd (video atau ringkasan)</strong>: Saya merekomendasikan siswa untuk meninjau ulang penjelasan konsep subbab dfd untuk memastikan bahwa mereka memahami dengan baik. Siswa dapat menggunakan video atau ringkasan untuk membantu memahami konsep dasar subbab dfd.</li>\n</ul>\n<p>Dengan strategi pembelajaran ini, saya yakin bahwa siswa dapat meningkatkan kemampuan mereka dalam menganalisis konsep limit matematika dan subbab dfd.</p>', NULL, 2, 2, NULL, 50.00, '2025-06-11 05:50:58', '2025-06-11 05:51:35'),
(25, 86, '<p><strong>Evaluasi Kompetensi Siswa</strong></p>\n<p><strong>Nilai: 75/100</strong></p>\n<p><strong>Kekuatan Subbab Pembahasan</strong></p>\n<ul>\n<li><strong>Trigonometri</strong>: Siswa memiliki pengetahuan yang baik tentang konsep trigonometri, seperti fungsi trigonometri, identitas trigonometri, dan rumus-rumus trigonometri. Mereka dapat menerapkan konsep ini dalam soal-soal yang melibatkan trigonometri, seperti menganalisis fungsi trigonometri dan menerapkan rumus-rumus trigonometri untuk menyelesaikan masalah. Namun, perlu diperhatikan bahwa siswa masih perlu meningkatkan kemampuan dalam menerapkan konsep ini dalam situasi yang lebih kompleks.</li>\n<li><strong>Limit Matematika</strong>: Siswa memiliki pemahaman yang baik tentang konsep limit, seperti definisi limit, sifat-sifat limit, dan cara-cara menyelesaikan limit. Mereka dapat menerapkan konsep ini dalam soal-soal yang melibatkan limit, seperti menganalisis fungsi limit dan menerapkan cara-cara menyelesaikan limit untuk menyelesaikan masalah.</li>\n</ul>\n<p><strong>Kekalahan Subbab Pembahasan</strong></p>\n<ul>\n<li><strong>dfd</strong>: Siswa masih memiliki kesulitan dalam memahami konsep <strong>dfd</strong>, seperti tidak dapat menerapkan konsep ini dalam soal-soal yang melibatkan <strong>dfd</strong>. Mereka juga masih perlu meningkatkan kemampuan dalam menganalisis dan menerapkan konsep <strong>dfd</strong> dalam situasi yang lebih kompleks.</li>\n</ul>\n<p><strong>Strategi Pembelajaran</strong></p>\n<ul>\n<li><strong>Latih Soal</strong>: Siswa perlu melatih soal-soal pada subbab <strong>dfd</strong> setiap hari untuk meningkatkan kemampuan dalam menerapkan konsep ini.</li>\n<li><strong>Tinjau Ulang Penjelasan Konsep</strong>: Siswa perlu meninjau ulang penjelasan konsep di subbab <strong>dfd</strong> (video atau ringkasan) untuk memahami konsep ini lebih baik dan meningkatkan kemampuan dalam menerapkan konsep ini.</li>\n</ul>\n<p>Dengan melaksanakan strategi pembelajaran ini, diharapkan siswa dapat meningkatkan kemampuan dalam menerapkan konsep <strong>dfd</strong> dan meningkatkan nilai akhir menjadi 90/100 atau lebih.</p>', NULL, 3, 1, NULL, 75.00, '2025-06-11 05:53:10', '2025-06-11 06:37:21'),
(41, 90, '<p><strong>Evaluasi Kompetensi Siswa Berdasarkan Latihan Soal</strong></p>\n<p>Dalam evaluasi kompetensi siswa, ada beberapa aspek yang perlu diperhatikan, yaitu kekuatan dan kelemahan siswa dalam setiap mata pelajaran. Dalam latihan soal yang diberikan, siswa telah menunjukkan beberapa kekuatan dan kelemahan yang perlu dianalisis lebih lanjut.</p>\n<p><strong>Analisis Per Materi (Lesson)</strong></p>\n<p>Dalam analisis per materi, kita dapat melihat kekuatan dan kelemahan siswa dalam setiap materi yang dipelajari. Berikut adalah analisis per materi yang telah dilakukan:</p>\n<h3>Mata Pelajaran: Pengetahuan dan Pemahaman Umum</h3>\n<ul>\n<li><strong>Ide Pokok</strong>: Siswa telah menunjukkan kekuatan dalam memahami ide pokok materi, dengan nilai yang cukup tinggi (3 benar, 0 salah). Ini menunjukkan bahwa siswa telah berhasil memahami konsep dasar materi.</li>\n<li><strong>Pernyataan Dalam Teks</strong>: Siswa telah menunjukkan kekuatan dalam memahami pernyataan dalam teks, dengan nilai yang cukup tinggi (1 benar, 0 salah). Ini menunjukkan bahwa siswa telah berhasil memahami struktur dan konteks teks.</li>\n<li><strong>Analisis Bacaan &amp; Kepaduan Paragraf</strong>: Siswa telah menunjukkan kekuatan dalam memahami analisis bacaan dan kepaduan paragraf, dengan nilai yang cukup tinggi (1 benar, 0 salah). Ini menunjukkan bahwa siswa telah berhasil memahami cara mengembangkan ide dan menghubungkan antara kalimat.</li>\n</ul>\n<h3>Mata Pelajaran: Kemampuan Memahami Bacaan dan Menulis</h3>\n<ul>\n<li><strong>Ide Pokok</strong>: Siswa telah menunjukkan kekuatan dalam memahami ide pokok materi, dengan nilai yang cukup tinggi (1 benar, 0 salah). Ini menunjukkan bahwa siswa telah berhasil memahami konsep dasar materi.</li>\n<li><strong>Semantik</strong>: Siswa telah menunjukkan kekuatan dalam memahami semantik materi, dengan nilai yang cukup tinggi (1 benar, 0 salah). Ini menunjukkan bahwa siswa telah berhasil memahami struktur dan konteks teks.</li>\n<li><strong>PUEBI</strong>: Siswa telah menunjukkan kekuatan dalam memahami PUEBI materi, dengan nilai yang cukup tinggi (1 benar, 0 salah). Ini menunjukkan bahwa siswa telah berhasil memahami cara mengembangkan ide dan menghubungkan antara kalimat.</li>\n<li><strong>Pemahaman Bacaan</strong>: Siswa telah menunjukkan kekuatan dalam memahami pemahaman bacaan materi, dengan nilai yang cukup tinggi (1 benar, 0 salah). Ini menunjukkan bahwa siswa telah berhasil memahami cara mengembangkan ide dan menghubungkan antara kalimat.</li>\n<li><strong>Kalimat</strong>: Siswa telah menunjukkan kekuatan dalam memahami kalimat materi, dengan nilai yang cukup tinggi (1 benar, 0 salah). Ini menunjukkan bahwa siswa telah berhasil memahami struktur dan konteks teks.</li>\n</ul>\n<h3>Kelemahan</h3>\n<p>Dalam kelemahan, siswa telah menunjukkan beberapa masalah dalam memahami materi, yaitu:</p>\n<ul>\n<li><strong>Mata Pelajaran: Kemampuan Memahami Bacaan dan Menulis</strong>: Siswa telah menunjukkan kelemahan dalam memahami materi, dengan nilai yang cukup rendah (440.56). Ini menunjukkan bahwa siswa perlu meningkatkan kemampuan memahami materi.</li>\n</ul>\n<p><strong>Analisis Per Mata Pelajaran</strong></p>\n<p>Dalam analisis per mata pelajaran, kita dapat melihat kekuatan dan kelemahan siswa dalam setiap mata pelajaran. Berikut adalah analisis per mata pelajaran yang telah dilakukan:</p>\n<h3>Mata Pelajaran: Pengetahuan dan Pemahaman Umum</h3>\n<ul>\n<li><strong>Rata-rata nilai</strong>: Siswa telah menunjukkan kekuatan dalam mata pelajaran ini, dengan rata-rata nilai 552.04. Ini menunjukkan bahwa siswa telah berhasil memahami konsep dasar materi.</li>\n</ul>\n<h3>Mata Pelajaran: Kemampuan Memahami Bacaan dan Menulis</h3>\n<ul>\n<li><strong>Rata-rata nilai</strong>: Siswa telah menunjukkan kelemahan dalam mata pelajaran ini, dengan rata-rata nilai 440.56. Ini menunjukkan bahwa siswa perlu meningkatkan kemampuan memahami materi.</li>\n</ul>\n<p><strong>Rekomendasi</strong></p>\n<p>Dalam evaluasi kompetensi siswa, ada beberapa rekomendasi yang dapat diberikan untuk meningkatkan kemampuan siswa:</p>\n<ol>\n<li><strong>Meningkatkan kemampuan memahami materi</strong>: Siswa perlu meningkatkan kemampuan memahami materi, terutama dalam mata pelajaran Kemampuan Memahami Bacaan dan Menulis.</li>\n<li><strong>Mengembangkan kemampuan analisis</strong>: Siswa perlu mengembangkan kemampuan analisis untuk memahami materi dengan lebih baik.</li>\n<li><strong>Meningkatkan kemampuan menulis</strong>: Siswa perlu meningkatkan kemampuan menulis untuk mengembangkan ide dan menghubungkan antara kalimat.</li>\n<li><strong>Mengembangkan kemampuan memahami konteks</strong>: Siswa perlu mengembangkan kemampuan memahami konteks untuk memahami struktur dan konteks teks.</li>\n</ol>\n<p>Dengan meningkatkan kemampuan siswa dalam setiap aspek, kita dapat membantu siswa untuk mencapai tujuan belajar yang lebih baik.</p>', '<p><strong>Analisis Peluang Berdasarkan Data Real</strong></p>\n<p>Dengan nilai tryout 496.3, Anda memiliki beberapa pilihan jurusan yang dapat dipertimbangkan. Berikut adalah evaluasi gap nilai terhadap semua pilihan jurusan:</p>\n<ol>\n<li><strong>FARMASI (Universitas Gadjah Mada)</strong>\n<ul>\n<li>Passing Score: 837.79</li>\n<li>Kurang 341.49 poin dari passing score</li>\n<li>Strategi peningkatan:</li>\n<li>Fokus pada mata pelajaran biologi, kimia, dan fisika untuk meningkatkan pengetahuan dan keterampilan.</li>\n<li>Prioritaskan pembelajaran dengan menggunakan sumber belajar yang efektif, seperti buku teks, online course, dan tutorial.</li>\n<li>Target peningkatan: +50 poin dalam waktu 2 bulan.</li>\n</ul></li>\n<li><strong>ILMU KOMPUTER (Universitas Gadjah Mada)</strong>\n<ul>\n<li>Passing Score: 815.7</li>\n<li>Kurang 319.4 poin dari passing score</li>\n<li>Strategi peningkatan:</li>\n<li>Fokus pada mata pelajaran matematika, fisika, dan komputer untuk meningkatkan pengetahuan dan keterampilan.</li>\n<li>Prioritaskan pembelajaran dengan menggunakan sumber belajar yang efektif, seperti buku teks, online course, dan tutorial.</li>\n<li>Target peningkatan: +60 poin dalam waktu 2 bulan.</li>\n</ul></li>\n<li><strong>FAKULTAS ILMU DAN TEKNOLOGI KEBUMIAN (FITB) (Institut Teknologi Bandung)</strong>\n<ul>\n<li>Passing Score: 762.48</li>\n<li>Kurang 266.18 poin dari passing score</li>\n<li>Strategi peningkatan:</li>\n<li>Fokus pada mata pelajaran fisika, kimia, dan geologi untuk meningkatkan pengetahuan dan keterampilan.</li>\n<li>Prioritaskan pembelajaran dengan menggunakan sumber belajar yang efektif, seperti buku teks, online course, dan tutorial.</li>\n<li>Target peningkatan: +70 poin dalam waktu 2 bulan.</li>\n</ul></li>\n</ol>\n<p><strong>Alternatif dari Database</strong></p>\n<p>Tidak ada data di &quot;Pilihan Aman&quot;, tetapi ada data di &quot;Target Stretch&quot;. Berikut adalah 2-3 jurusan teratas yang paling mendekati nilai Anda:</p>\n<ol>\n<li><strong>ADMINISTRASI ASURANSI &amp; AKTUARIA (Universitas Indonesia)</strong>\n<ul>\n<li>Passing Score: 551.72</li>\n<li>Prospek kerja: Bisa bekerja di perusahaan asuransi, bank, atau lembaga keuangan lainnya.</li>\n</ul></li>\n<li><strong>PERIKLANAN KREATIF (Universitas Indonesia)</strong>\n<ul>\n<li>Passing Score: 556.87</li>\n<li>Prospek kerja: Bisa bekerja di agensi periklanan, media massa, atau sebagai konsultan periklanan.</li>\n</ul></li>\n<li><strong>SASTRA DAERAH UNTUK SASTRA JAWA (Universitas Indonesia)</strong>\n<ul>\n<li>Passing Score: 559.45</li>\n<li>Prospek kerja: Bisa bekerja sebagai dosen, penulis, atau konsultan sastra.</li>\n</ul></li>\n</ol>\n<p><strong>Strategi Peningkatan Realistis</strong></p>\n<ol>\n<li>Fokus pada mata pelajaran yang paling berdampak terhadap nilai tryout.</li>\n<li>Prioritaskan pembelajaran dengan menggunakan sumber belajar yang efektif.</li>\n<li>Target peningkatan nilai tryout dalam waktu yang realistis (2 bulan).</li>\n</ol>\n<p>Dengan strategi peningkatan ini, Anda dapat meningkatkan nilai tryout dan meningkatkan peluang masuk ke jurusan yang diinginkan.</p>', 10, 1, 0, 496.30, '2025-06-11 06:26:51', '2025-06-11 07:17:29'),
(45, 71, NULL, NULL, 6, 4, 1, 270.36, '2025-06-11 06:31:25', '2025-06-11 07:17:29'),
(46, 72, NULL, NULL, 5, 5, 1, 226.84, '2025-06-11 06:31:25', '2025-06-11 07:17:29'),
(47, 74, NULL, NULL, 6, 4, 1, 283.54, '2025-06-11 06:31:25', '2025-06-11 07:17:29'),
(48, 48, '<p><strong>Evaluasi Kompetensi Siswa</strong></p>\n<p>Dilihat dari nilai yang diperoleh, yaitu 60/100, dapat dikatakan bahwa siswa masih memerlukan perbaikan dalam memahami materi yang dipelajari. Berikut adalah evaluasi kekuatan dan kelemahan siswa dalam memahami subbab pembahasan:</p>\n<p><strong>KEKUATAN SUBBAB PEMBAHASAN</strong></p>\n<ul>\n<li>\n<p>Pernyataan dalam teks &quot;Pestisida alami sering digunakan karena harganya terjangkau dan lebih ramah lingkungan&quot; menunjukkan bahwa siswa telah memahami konsep tentang pestisida alami dan manfaatnya. Siswa telah berhasil menganalisis informasi yang disajikan dalam teks dan mengidentifikasi kelebihan pestisida alami.</p>\n</li>\n<li>\n<p>Siswa juga telah memahami kalimat yang singkat &quot;krab adalah&quot;. Meskipun kalimat ini terlihat sederhana, siswa telah berhasil mengidentifikasi kata benda yang terkait dengan krab.</p>\n</li>\n<li>\n<p>Siswa juga telah memahami kalimat yang singkat &quot;foto di atas merupakan chelsea yang sedang mengangkat UCL, kapan foto itu diambil?&quot; dan telah berhasil mengidentifikasi tahun atau waktu yang terkait dengan foto tersebut.</p>\n</li>\n</ul>\n<p><strong>KELEMAHAN SUBBAB PEMBAHASAN</strong></p>\n<ul>\n<li>\n<p>Siswa masih mengalami kesulitan dalam memahami kalimat yang tidak jelas &quot;saya sassd&quot;. Kalimat ini tidak memiliki makna atau relevansi dengan materi yang dipelajari, sehingga siswa perlu dilatih untuk mengenali dan membedakan kalimat yang relevan dan tidak relevan.</p>\n</li>\n<li>\n<p>Siswa juga masih mengalami kesulitan dalam memahami kalimat yang tidak jelas &quot;sdsds&quot;. Kalimat ini juga tidak memiliki makna atau relevansi dengan materi yang dipelajari, sehingga siswa perlu dilatih untuk mengenali dan membedakan kalimat yang relevan dan tidak relevan.</p>\n</li>\n</ul>\n<p><strong>STRATEGI PEMBELAJARAN</strong></p>\n<ul>\n<li>\n<p>Untuk meningkatkan kemampuan siswa dalam memahami materi, saya merekomendasikan latihan soal setiap hari pada subbab yang masih perlu diperbaiki, yaitu <strong>fgfgfgf</strong> dan <strong>RTRT</strong>. Latihan soal ini dapat membantu siswa memahami konsep dan meningkatkan kemampuan mereka dalam menganalisis informasi.</p>\n</li>\n<li>\n<p>Selain latihan soal, saya juga merekomendasikan tinjauan ulang penjelasan konsep yang terkait dengan subbab <strong>fgfgfgf</strong> dan <strong>RTRT</strong>. Penjelasan konsep dapat berupa video atau ringkasan yang dapat membantu siswa memahami materi lebih baik.</p>\n</li>\n</ul>\n<p>Dengan melaksanakan strategi pembelajaran yang tepat, saya percaya bahwa siswa dapat meningkatkan kemampuan mereka dalam memahami materi dan mencapai nilai yang lebih baik.</p>', NULL, 3, 0, NULL, 60.00, '2025-06-11 06:38:06', '2025-06-11 06:41:32'),
(49, 48, '<p>Berikut adalah evaluasi kompetensi siswa berdasarkan latihan soal:</p>\n<p><strong>KEKUATAN SUBBAB PEMBAHASAN</strong></p>\n<p>Siswa menunjukkan kemampuan yang baik dalam memahami konsep-konsep dasar pada beberapa subbab. Berikut adalah kekuatan yang dilihat:</p>\n<ul>\n<li>Pada subbab <strong>pernyataan Dalam teks</strong>: Siswa telah dapat memahami dan menerjemahkan pernyataan-pernyataan yang terkait dengan pestisida alami, seperti &quot;Pestisida alami sering digunakan karena harganya terjangkau dan lebih ramah lingkungan.&quot; Ini menunjukkan kemampuan siswa dalam menganalisis informasi dan memahami konteks.</li>\n<li>Siswa juga telah dapat memahami konsep-konsep dasar pada subbab <strong>sejarah</strong>, seperti menerima informasi tentang foto Chelsea yang mengangkat UCL. Namun, belum diketahui kaitannya dengan kemampuan siswa dalam menganalisis atau menafsirkan informasi sejarah.</li>\n</ul>\n<p><strong>KELEMAHAN SUBBAB PEMBAHASAN</strong></p>\n<p>Siswa masih memiliki kelemahan dalam beberapa subbab, seperti:</p>\n<ul>\n<li>Pada subbab <strong>fgfgfgf</strong>: Siswa telah menunjukkan gejala ketidakmampuan dalam memahami konsep-konsep dasar. Siswa telah menulis kalimat-kalimat yang tidak terkait dengan konteks, seperti &quot;saya sassd&quot;. Ini menunjukkan bahwa siswa belum dapat memahami dan menerjemahkan informasi dengan baik.</li>\n<li>Pada subbab <strong>RTRT</strong>: Siswa juga telah menunjukkan kelemahan dalam memahami konsep-konsep dasar. Siswa telah menulis kalimat-kalimat yang tidak terkait dengan konteks, seperti &quot;sdsds&quot;. Ini menunjukkan bahwa siswa belum dapat memahami dan menerjemahkan informasi dengan baik.</li>\n</ul>\n<p><strong>STRATEGI PEMBELAJARAN</strong></p>\n<p>Untuk meningkatkan kemampuan siswa, berikut adalah beberapa strategi pembelajaran yang dapat dilakukan:</p>\n<ul>\n<li>Latih soal pada subbab <strong>fgfgfgf</strong> setiap hari. Siswa perlu dilatih untuk memahami konsep-konsep dasar dan menerjemahkan informasi dengan baik.</li>\n<li>Tinjau ulang penjelasan konsep di subbab <strong>fgfgfgf</strong> (video atau ringkasan). Siswa perlu memahami konsep-konsep dasar dengan lebih baik melalui penjelasan yang lebih jelas.</li>\n<li>Latih soal pada subbab <strong>RTRT</strong> setiap hari. Siswa perlu dilatih untuk memahami konsep-konsep dasar dan menerjemahkan informasi dengan baik.</li>\n<li>Tinjau ulang penjelasan konsep di subbab <strong>RTRT</strong> (video atau ringkasan). Siswa perlu memahami konsep-konsep dasar dengan lebih baik melalui penjelasan yang lebih jelas.</li>\n</ul>\n<p>Dengan menggunakan strategi pembelajaran ini, diharapkan siswa dapat meningkatkan kemampuan memahami dan menerjemahkan informasi dengan lebih baik.</p>', NULL, 3, 0, NULL, 60.00, '2025-06-11 06:42:24', '2025-06-11 06:42:31'),
(52, 48, '<p>Saya akan memberikan evaluasi kompetensi siswa berdasarkan latihan soal yang diberikan.</p>\n<p><strong>Kekuatan:</strong></p>\n<ol>\n<li><strong>Pernyataan dalam teks</strong>: Siswa telah menunjukkan kemampuan untuk memahami dan menerjemahkan pernyataan dalam teks. Dalam contoh ini, siswa telah berhasil menerjemahkan pernyataan &quot;Pestisida alami sering digunakan karena harganya terjangkau dan lebih ramah lingkungan&quot; dengan cara yang tepat.</li>\n<li><strong>Sekilas</strong>: Meskipun tidak ada penjelasan yang jelas, siswa telah menunjukkan kemampuan untuk memahami sekilas atau inti dari sebuah topik. Dalam contoh ini, siswa telah berhasil memahami bahwa &quot;krab adalah&quot; adalah sebuah sekilas atau inti dari topik yang tidak jelas.</li>\n<li><strong>Sejarah</strong>: Siswa telah menunjukkan kemampuan untuk memahami dan menganalisis foto atau gambar. Dalam contoh ini, siswa telah berhasil menganalisis foto di atas dan menyimpulkan bahwa foto tersebut merupakan Chelsea yang sedang mengangkat UCL.</li>\n</ol>\n<p><strong>Kelemahan:</strong></p>\n<ol>\n<li><strong>Tidak ada penjelasan yang jelas</strong>: Beberapa item dalam kelemahan tidak ada penjelasan yang jelas, sehingga sulit untuk mengetahui apa yang sebenarnya dimaksudkan.</li>\n<li><strong>Tidak ada kemampuan analitis</strong>: Beberapa item dalam kelemahan tidak menunjukkan kemampuan analitis yang baik, seperti &quot;fgfgfgf: saya sassd&quot; yang tidak ada makna atau konteks.</li>\n</ol>\n<p><strong>Strategi Pembelajaran:</strong></p>\n<ol>\n<li><strong>Latih soal setiap hari</strong>: Siswa harus melatih soal pada subbab <strong>fgfgfgf</strong> dan <strong>RTRT</strong> setiap hari untuk meningkatkan kemampuan analitis dan memahami konsep yang lebih baik.</li>\n<li><strong>Tinjau ulang penjelasan konsep</strong>: Siswa harus meninjau ulang penjelasan konsep di subbab <strong>fgfgfgf</strong> dan <strong>RTRT</strong> (video atau ringkasan) untuk memastikan bahwa mereka memahami konsep dengan baik.</li>\n<li><strong>Fokus pada kelemahan</strong>: Siswa harus fokus pada kelemahan mereka, seperti tidak ada penjelasan yang jelas dan tidak ada kemampuan analitis, untuk meningkatkan kemampuan mereka.</li>\n</ol>\n<p>Dalam keseluruhan, siswa telah menunjukkan beberapa kekuatan, seperti memahami pernyataan dalam teks, sekilas, dan sejarah. Namun, mereka juga memiliki beberapa kelemahan, seperti tidak ada penjelasan yang jelas dan tidak ada kemampuan analitis. Dengan strategi pembelajaran yang tepat, seperti melatih soal setiap hari dan meninjau ulang penjelasan konsep, siswa dapat meningkatkan kemampuan mereka dan mencapai hasil yang lebih baik.</p>', NULL, 3, 0, 2, 60.00, '2025-06-11 06:50:56', '2025-06-11 06:51:08'),
(53, 81, '<p><strong>Evaluasi Kompetensi Siswa</strong></p>\n<p>Siswa memiliki nilai 66/100 dalam evaluasi kompetensi. Berdasarkan hasil evaluasi ini, ada kekuatan dan kelemahan yang perlu diperhatikan.</p>\n<p><strong>KEKUATAN SUBBAB PEMBAHASAN</strong></p>\n<ol>\n<li><strong>Gambar</strong>: Siswa dapat mengidentifikasi gambar dengan baik. Ini menunjukkan kemampuan visual dan kreatif siswa.</li>\n<li><strong>Pengetahuan Umum</strong>: Siswa memiliki pengetahuan umum yang cukup tentang berbagai topik, seperti sejarah dan general knowledge.</li>\n</ol>\n<p><strong>KELEMAHAN SUBBAB PEMBAHASAN</strong></p>\n<ol>\n<li><strong>Trigonometri</strong>: Siswa mengalami kesulitan dalam memahami konsep trigonometri. Ini dapat disebabkan oleh kurangnya pemahaman konsep dasar atau kurangnya latihan.</li>\n<li><strong>d</strong>: Siswa tidak memberikan penjelasan yang jelas tentang subbab &quot;d&quot;. Ini menunjukkan bahwa siswa perlu meningkatkan kemampuan dalam menyampaikan pengetahuan.</li>\n</ol>\n<p><strong>STRATEGI PEMBELAJARAN</strong></p>\n<p>Untuk meningkatkan kemampuan siswa dalam trigonometri, saya sarankan:</p>\n<ol>\n<li><strong>Latih soal</strong>: Siswa perlu melatih soal trigonometri setiap hari untuk meningkatkan pemahaman konsep.</li>\n<li><strong>Tinjau ulang penjelasan</strong>: Siswa perlu meninjau ulang penjelasan konsep trigonometri (video atau ringkasan) untuk memahami konsep dasar.</li>\n<li><strong>Latih soal</strong>: Siswa perlu melatih soal subbab &quot;d&quot; setiap hari untuk meningkatkan kemampuan dalam menyampaikan pengetahuan.</li>\n<li><strong>Tinjau ulang penjelasan</strong>: Siswa perlu meninjau ulang penjelasan konsep subbab &quot;d&quot; (video atau ringkasan) untuk memahami konsep dasar.</li>\n</ol>\n<p>Dengan melaksanakan strategi pembelajaran ini, saya percaya bahwa siswa dapat meningkatkan kemampuan trigonometri dan kemampuan menyampaikan pengetahuan.</p>', NULL, 6, 2, 1, 66.67, '2025-06-11 08:55:03', '2025-06-11 08:55:10'),
(54, 86, '<p><strong>Evaluasi Kompetensi Siswa</strong></p>\n<p>Siswa Anda telah menyelesaikan latihan soal dan hasilnya adalah 75/100. Dalam evaluasi ini, kita akan menganalisis kekuatan dan kelemahan siswa dalam masing-masing subbab, serta memberikan saran strategi pembelajaran untuk meningkatkan kemampuan siswa.</p>\n<p><strong>KEKUATAN SUBBAB PEMBAHASAN</strong></p>\n<ul>\n<li>Trigonometri: Siswa telah menunjukkan pengetahuan yang baik tentang konsep trigonometri, seperti fungsi trigonometri, identitas trigonometri, dan rumus trigonometri. Siswa dapat menerapkan konsep ini dalam soal-soal yang diberikan.</li>\n<li>Limit Matematika: Siswa telah menunjukkan kemampuan yang baik dalam menyelesaikan soal-soal limit matematika. Siswa dapat menganalisis dan menerapkan konsep limit dalam berbagai kasus.</li>\n</ul>\n<p><strong>KELEMAHAN SUBBAB PEMBAHASAN</strong></p>\n<ul>\n<li>Sdf: Siswa masih membutuhkan peningkatan dalam memahami konsep <strong>sdf</strong>, terutama dalam menerapkan konsep ini dalam soal-soal yang lebih kompleks. Siswa masih sering kali membuat kesalahan dalam menghitung atau menganalisis konsep <strong>sdf</strong>.</li>\n<li>Dfd: Siswa masih membutuhkan peningkatan dalam memahami konsep <strong>dfd</strong>, terutama dalam menerapkan konsep ini dalam soal-soal yang lebih kompleks. Siswa masih sering kali membuat kesalahan dalam menghitung atau menganalisis konsep <strong>dfd</strong>.</li>\n</ul>\n<p><strong>STRATEGI PEMBELAJARAN</strong></p>\n<p>Untuk meningkatkan kemampuan siswa dalam subbab-subbab yang masih perlu ditingkatkan, di bawah ini adalah saran strategi pembelajaran yang dapat diterapkan:</p>\n<ul>\n<li><strong>Subbab sdf</strong>: Latih soal-soal pada subbab <strong>sdf</strong> setiap hari. Pastikan siswa untuk memahami konsep <strong>sdf</strong> dengan baik, terutama dalam menerapkan konsep ini dalam soal-soal yang lebih kompleks.</li>\n<li><strong>Subbab dfd</strong>: Tinjau ulang penjelasan konsep di subbab <strong>dfd</strong> (video atau ringkasan). Pastikan siswa untuk memahami konsep <strong>dfd</strong> dengan baik, terutama dalam menerapkan konsep ini dalam soal-soal yang lebih kompleks.</li>\n</ul>\n<p>Dengan menerapkan strategi pembelajaran ini, diharapkan siswa dapat meningkatkan kemampuan mereka dalam subbab-subbab yang masih perlu ditingkatkan, sehingga nilai mereka dapat meningkat secara signifikan.</p>', NULL, 3, 1, 0, 75.00, '2025-06-11 09:37:20', '2025-06-11 09:37:28'),
(55, 91, '<p><strong>Evaluasi Kompetensi Siswa</strong></p>\n<p>Siswa saya telah menyelesaikan latihan soal dan memperoleh nilai 66/100. Berdasarkan hasil evaluasi, saya telah mengidentifikasi kekuatan dan kelemahan siswa dalam memahami materi.</p>\n<p><strong>Kekuatan</strong></p>\n<p>Siswa memperlihatkan kekuatan dalam memahami beberapa subbab, seperti:</p>\n<ul>\n<li><strong>Gambar</strong>: Siswa dapat mengidentifikasi gambar dengan baik, menunjukkan kemampuan visual yang tajam.</li>\n<li><strong>Pengetahuan Umum</strong>: Siswa menunjukkan kemampuan dasar dalam berbagai bidang, seperti sejarah dan pengetahuan umum.</li>\n</ul>\n<p><strong>Kelemahan</strong></p>\n<p>Namun, siswa juga menunjukkan kelemahan dalam beberapa subbab, seperti:</p>\n<ul>\n<li><strong>Trigonometri</strong>: Siswa masih mengalami kesulitan dalam memahami konsep trigonometri, menunjukkan kebutuhan tambahan bimbingan dan latihan.</li>\n<li><strong>D</strong>: Siswa tidak menyebutkan jawaban atau penjelasan yang jelas tentang subbab ini, menunjukkan kebutuhan penjelasan dan latihan tambahan.</li>\n</ul>\n<p><strong>Strategi Pembelajaran</strong></p>\n<p>Untuk meningkatkan kemampuan siswa, saya menawarkan beberapa strategi pembelajaran, yaitu:</p>\n<ul>\n<li><strong>Latihan Soal</strong>: Siswa harus melatih soal pada subbab trigonometri dan subbab D setiap hari untuk meningkatkan kemampuan memahami konsep.</li>\n<li><strong>Tinjau Ulang Penjelasan</strong>: Siswa harus meninjau ulang penjelasan konsep di subbab trigonometri dan subbab D (video atau ringkasan) untuk meningkatkan pemahaman.</li>\n</ul>\n<p>Dengan menerapkan strategi pembelajaran ini, saya berharap siswa dapat meningkatkan kemampuan dan mencapai nilai yang lebih baik dalam evaluasi kompetensi selanjutnya.</p>', NULL, 6, 3, 0, 66.67, '2025-06-11 11:37:09', '2025-06-11 11:38:41');
INSERT INTO `results_evaluations` (`id`, `result_id`, `evaluation`, `recommendation`, `correct`, `wrong`, `empty`, `score`, `created_at`, `updated_at`) VALUES
(56, 81, '<p>Berdasarkan hasil evaluasi kompetensi siswa, saya menemukan beberapa kekuatan dan kelemahan dalam memahami materi subbab. Berikut adalah ringkasan hasil evaluasi:</p>\n<p><strong>Kekuatan:</strong></p>\n<ol>\n<li>Siswa telah menunjukkan kemampuan dalam mengenali gambar dengan baik, seperti contoh &quot;S1: ini merupakan gambar apa&quot;. Hal ini menunjukkan bahwa siswa memiliki kemampuan visual dan dapat mengidentifikasi objek dengan benar.</li>\n<li>Siswa juga telah menunjukkan minat dalam bidang sejarah, seperti contoh &quot;Sejarah: reza&quot;. Hal ini menunjukkan bahwa siswa memiliki kemampuan untuk memahami dan mengingat informasi sejarah.</li>\n<li>Siswa telah menunjukkan kemampuan dalam menganalisis informasi dan membuat kesimpulan, seperti contoh &quot;Penetahuan Umum: &quot;. Hal ini menunjukkan bahwa siswa memiliki kemampuan analitis dan dapat membuat kesimpulan yang logis.</li>\n</ol>\n<p><strong>Kelemahan:</strong></p>\n<ol>\n<li>Siswa masih memiliki kesulitan dalam memahami konsep trigonometri, seperti contoh &quot;trigonometri: 12212dfd rrtrtrtrrtrtrtmendukung tidak mendukung&quot;. Hal ini menunjukkan bahwa siswa masih perlu banyak latihan dan pengulangan untuk memahami konsep ini.</li>\n<li>Siswa masih memiliki kesulitan dalam memahami informasi yang kompleks, seperti contoh &quot;d: &quot;. Hal ini menunjukkan bahwa siswa masih perlu banyak latihan dan pengulangan untuk memahami informasi ini.</li>\n</ol>\n<p><strong>Strategi Pembelajaran:</strong></p>\n<p>Untuk meningkatkan kemampuan siswa, saya merekomendasikan beberapa strategi pembelajaran berikut:</p>\n<ol>\n<li><strong>Latih soal pada subbab trigonometri setiap hari</strong>: Saya merekomendasikan siswa untuk melakukan latihan soal pada subbab trigonometri setiap hari. Hal ini dapat membantu siswa memahami konsep ini dengan lebih baik dan meningkatkan kemampuan mereka dalam menganalisis informasi.</li>\n<li><strong>Tinjau ulang penjelasan konsep di subbab trigonometri</strong>: Saya merekomendasikan siswa untuk meninjau ulang penjelasan konsep di subbab trigonometri, baik melalui video atau ringkasan. Hal ini dapat membantu siswa memahami konsep ini dengan lebih baik dan meningkatkan kemampuan mereka dalam menganalisis informasi.</li>\n<li><strong>Latih soal pada subbab d setiap hari</strong>: Saya merekomendasikan siswa untuk melakukan latihan soal pada subbab d setiap hari. Hal ini dapat membantu siswa memahami informasi ini dengan lebih baik dan meningkatkan kemampuan mereka dalam menganalisis informasi.</li>\n<li><strong>Tinjau ulang penjelasan konsep di subbab d</strong>: Saya merekomendasikan siswa untuk meninjau ulang penjelasan konsep di subbab d, baik melalui video atau ringkasan. Hal ini dapat membantu siswa memahami informasi ini dengan lebih baik dan meningkatkan kemampuan mereka dalam menganalisis informasi.</li>\n</ol>', NULL, 6, 2, 1, 66.67, '2025-06-11 11:37:32', '2025-06-11 11:40:18'),
(58, 93, NULL, NULL, 3, 0, 0, NULL, '2025-06-11 11:55:06', '2025-06-11 11:58:08'),
(59, 94, NULL, NULL, 2, 1, 0, NULL, '2025-06-11 12:02:55', '2025-06-11 12:03:05'),
(60, 95, NULL, NULL, 2, 1, 0, NULL, '2025-06-11 12:04:12', '2025-06-11 12:04:22');

-- --------------------------------------------------------

--
-- Table structure for table `result_details`
--

CREATE TABLE `result_details` (
  `id` bigint UNSIGNED NOT NULL,
  `answer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `correct` tinyint(1) DEFAULT NULL,
  `question_id` bigint UNSIGNED NOT NULL,
  `score` float DEFAULT NULL,
  `result_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `result_details`
--

INSERT INTO `result_details` (`id`, `answer`, `correct`, `question_id`, `score`, `result_id`, `created_at`, `updated_at`) VALUES
(240, NULL, NULL, 34, NULL, 59, '2025-05-25 04:17:03', '2025-05-25 04:17:03'),
(241, NULL, NULL, 35, NULL, 59, '2025-05-25 04:17:03', '2025-05-25 04:17:03'),
(242, NULL, NULL, 36, NULL, 59, '2025-05-25 04:17:03', '2025-05-25 04:17:03'),
(243, NULL, NULL, 49, NULL, 59, '2025-05-25 04:17:12', '2025-05-25 04:17:12'),
(244, NULL, NULL, 50, NULL, 59, '2025-05-25 04:17:12', '2025-05-25 04:17:12'),
(271, NULL, NULL, 51, 0, 60, '2025-05-25 08:05:41', '2025-05-29 06:59:57'),
(272, NULL, NULL, 52, 0, 60, '2025-05-25 08:05:48', '2025-05-29 06:59:57'),
(283, NULL, NULL, 44, NULL, 61, '2025-05-25 08:39:24', '2025-05-25 08:39:24'),
(284, '{\"reza\":\"yes\",\"rezaa\":null,\"re\":null}', 0, 45, NULL, 61, '2025-05-25 08:39:56', '2025-05-25 08:39:56'),
(285, 'Ahli teknologi memproduksi pestisida alami yang memiliki daya kerja lebih cepat.', 1, 7, NULL, 48, '2025-05-25 08:56:17', '2025-05-25 08:56:17'),
(286, 'ini loh hahaah', 1, 12, NULL, 48, '2025-05-25 08:56:17', '2025-05-28 10:53:44'),
(287, '2021', 1, 17, NULL, 48, '2025-05-25 08:56:17', '2025-05-25 08:56:17'),
(288, NULL, NULL, 32, NULL, 48, '2025-05-25 08:56:18', '2025-05-25 08:56:18'),
(289, NULL, NULL, 33, NULL, 48, '2025-05-25 08:56:18', '2025-05-28 10:53:44'),
(320, '$0$', 1, 54, NULL, 67, '2025-05-27 06:03:32', '2025-05-27 06:43:22'),
(321, '5', 1, 55, NULL, 67, '2025-05-27 06:03:32', '2025-05-27 06:03:32'),
(322, '<img src=\"../../../storage/images/erd.jpg\" alt=\"\" width=\"400\" height=\"287\">', 0, 70, NULL, 67, '2025-05-27 06:03:32', '2025-05-27 06:53:21'),
(339, 'penanganan kendala mengonsumsi susu', 1, 56, 500, 70, '2025-05-28 02:44:11', '2025-06-11 06:28:34'),
(340, 'Mengapa penderita intoleran tidak mau mengonsumsi susu?', 1, 61, 596.64, 70, '2025-05-28 02:44:11', '2025-06-11 06:28:34'),
(341, 'Orang yang tidak suka minum susu karena tidak suka dengan rasa atau bau susu.', 0, 62, 0, 70, '2025-05-28 02:44:11', '2025-06-11 06:28:16'),
(342, 'Penyebab orang tidak menyukai susu, penderita intoleran susu, dan manfaat susu fermentasi.', 1, 63, 596.64, 70, '2025-05-28 02:44:11', '2025-06-11 06:28:34'),
(343, 'sejarah terbentuknya benua dan pulau', 1, 64, 500, 70, '2025-05-28 02:44:11', '2025-06-11 06:28:34'),
(344, 'kerusakan alam dan lingkungan hidup akibat ulah manusia', 1, 65, 500, 70, '2025-05-28 02:45:06', '2025-06-11 06:28:34'),
(345, '(4)', 1, 66, 500, 70, '2025-05-28 02:45:06', '2025-06-11 06:28:34'),
(346, '(12)', 1, 67, 522.13, 70, '2025-05-28 02:45:06', '2025-06-11 06:28:34'),
(347, 'Adanya kesalahan cara pandang manusia terhadap alam.', 1, 68, 599.11, 70, '2025-05-28 02:45:06', '2025-06-11 06:28:34'),
(348, '(7) dan (9)', 1, 69, 522.13, 70, '2025-05-28 02:45:07', '2025-06-11 06:28:34'),
(349, '<img src=\"../../storage/images/categories-makeup.svg\" alt=\"\" width=\"76\" height=\"76\">', 1, 71, 645.14, 70, '2025-05-28 02:45:07', '2025-06-11 06:28:34'),
(350, 'penanganan kendala mengonsumsi susu', 1, 56, 500, 71, '2025-05-28 02:51:26', '2025-06-11 06:28:34'),
(351, 'Apakah susu fermentasi lebih baik daripada susu yang tidak difermentasi?', 0, 61, 0, 71, '2025-05-28 02:51:26', '2025-06-11 06:28:16'),
(352, 'Orang yang tidak suka minum susu karena tidak suka dengan rasa atau bau susu.', 0, 62, 0, 71, '2025-05-28 02:51:26', '2025-06-11 06:28:16'),
(353, 'Khasiat susu bagi tubuh, kandungan laktosa dalam susu, dan berbagai keuntungan mengonsumsi susu fermentasi.', 0, 63, 0, 71, '2025-05-28 02:51:26', '2025-06-11 06:28:16'),
(354, 'sejarah terbentuknya benua dan pulau', 1, 64, 500, 71, '2025-05-28 02:51:26', '2025-06-11 06:28:34'),
(355, 'kerusakan alam dan lingkungan hidup akibat ulah manusia', 1, 65, 500, 71, '2025-05-28 02:52:13', '2025-06-11 06:28:34'),
(356, '(4)', 1, 66, 500, 71, '2025-05-28 02:52:13', '2025-06-11 06:28:34'),
(357, '(12)', 1, 67, 522.13, 71, '2025-05-28 02:52:13', '2025-06-11 06:28:34'),
(358, 'Manusia memandang alam sebagai bagian dari kehidupannya.', 0, 68, 0, 71, '2025-05-28 02:52:13', '2025-06-11 06:28:16'),
(359, '(7) dan (9)', 1, 69, 522.13, 71, '2025-05-28 02:52:13', '2025-06-11 06:28:34'),
(360, NULL, NULL, 71, 0, 71, '2025-05-28 02:52:13', '2025-06-11 06:28:16'),
(361, 'penanganan kendala mengonsumsi susu', 1, 56, 500, 72, '2025-05-28 02:54:58', '2025-06-11 06:28:34'),
(362, 'Benarkah bahwa semua susu bubuk berkadar laktosa rendah?', 0, 61, 0, 72, '2025-05-28 02:54:58', '2025-06-11 06:28:16'),
(363, 'Orang yang secara biologis hanya boleh minum susu yang sudah difermentasi.', 0, 62, 0, 72, '2025-05-28 02:54:58', '2025-06-11 06:28:16'),
(364, 'Cara mengatasi laktosa penderita intoleran susu, pentingnya susu kadar laktosa rendah, dan keuntungan susu fermentasi.', 0, 63, 0, 72, '2025-05-28 02:54:58', '2025-06-11 06:28:16'),
(365, 'sejarah terbentuknya benua dan pulau', 1, 64, 500, 72, '2025-05-28 02:54:58', '2025-06-11 06:28:34'),
(366, 'kerusakan alam dan lingkungan hidup akibat ulah manusia', 1, 65, 500, 72, '2025-05-28 03:01:46', '2025-06-11 06:28:34'),
(367, '(4)', 1, 66, 500, 72, '2025-05-28 03:01:46', '2025-06-11 06:28:34'),
(368, '(14)', 0, 67, 0, 72, '2025-05-28 03:01:46', '2025-06-11 06:28:16'),
(369, NULL, NULL, 68, 0, 72, '2025-05-28 03:01:46', '2025-06-11 06:28:16'),
(370, '(7) dan (9)', 1, 69, 522.13, 72, '2025-05-28 03:01:46', '2025-06-11 06:28:34'),
(371, '<img src=\"../../storage/images/categories-baby.svg\" alt=\"\" width=\"76\" height=\"76\">', 0, 71, 0, 72, '2025-05-28 03:01:46', '2025-06-11 06:28:16'),
(372, 'Ahli teknologi memproduksi pestisida alami yang memiliki daya kerja lebih cepat.', 1, 7, NULL, 73, '2025-05-28 03:05:21', '2025-05-28 03:05:21'),
(373, 'ini loh hahaah', 1, 12, NULL, 73, '2025-05-28 03:05:21', '2025-05-28 03:05:56'),
(374, '2021', 1, 17, NULL, 73, '2025-05-28 03:05:21', '2025-05-28 03:05:21'),
(375, '{\"fg\":\"yes\",\"fgg\":\"yes\",\"fgfg\":null}', 0, 32, NULL, 73, '2025-05-28 03:05:21', '2025-05-28 03:05:56'),
(376, 's', 1, 33, NULL, 73, '2025-05-28 03:05:21', '2025-05-28 03:05:56'),
(377, 'penanganan kendala mengonsumsi susu', 1, 56, 500, 74, '2025-05-28 03:08:17', '2025-06-11 06:28:34'),
(378, NULL, NULL, 61, 0, 74, '2025-05-28 03:08:17', '2025-06-11 06:28:16'),
(379, 'Orang yang secara biologis tidak dapat mencerna kandungan laktosa susu.', 1, 62, 566.93, 74, '2025-05-28 03:08:17', '2025-06-11 06:28:34'),
(380, 'Khasiat susu bagi tubuh, kandungan laktosa dalam susu, dan berbagai keuntungan mengonsumsi susu fermentasi.', 0, 63, 0, 74, '2025-05-28 03:08:17', '2025-06-11 06:28:16'),
(381, 'sejarah terbentuknya benua dan pulau', 1, 64, 500, 74, '2025-05-28 03:08:17', '2025-06-11 06:28:34'),
(382, 'kerusakan alam dan lingkungan hidup akibat ulah manusia', 1, 65, 500, 74, '2025-05-28 03:09:40', '2025-06-11 06:28:34'),
(383, '(4)', 1, 66, 500, 74, '2025-05-28 03:09:40', '2025-06-11 06:28:34'),
(384, '(12)', 1, 67, 522.13, 74, '2025-05-28 03:09:40', '2025-06-11 06:28:34'),
(385, 'Ada berbagai bentuk kerusakan lingkungan di muka bumi ini.', 0, 68, 0, 74, '2025-05-28 03:09:40', '2025-06-11 06:28:16'),
(386, '(2) dan (5)', 0, 69, 0, 74, '2025-05-28 03:09:40', '2025-06-11 06:28:16'),
(387, '<img src=\"../../storage/images/categories-sneaker.svg\" alt=\"\" width=\"76\" height=\"76\">', 0, 71, 0, 74, '2025-05-28 03:09:40', '2025-06-11 06:28:16'),
(388, '3', 0, 37, NULL, 75, '2025-05-28 03:24:30', '2025-05-28 03:24:30'),
(389, '{\"bola\":\"yes\",\"game\":\"yes\",\"musik\":\"yes\",\"membaca\":\"yes\",\"menulis\":\"yes\"}', 1, 38, NULL, 75, '2025-05-28 03:24:30', '2025-05-28 03:24:30'),
(390, 'fgfgf', 0, 39, NULL, 75, '2025-05-28 03:24:46', '2025-05-28 03:24:46'),
(391, 'saa', 1, 40, NULL, 75, '2025-05-28 03:24:46', '2025-05-28 03:24:46'),
(392, NULL, NULL, 72, NULL, 75, '2025-05-28 03:24:53', '2025-05-28 03:24:53'),
(393, NULL, NULL, 46, NULL, 76, '2025-05-28 11:54:05', '2025-05-28 11:54:05'),
(394, '3333', 0, 47, NULL, 76, '2025-05-28 11:54:13', '2025-05-28 11:54:13'),
(399, 'reza', 1, 75, NULL, 79, '2025-06-03 03:27:27', '2025-06-03 03:27:27'),
(400, NULL, NULL, 76, NULL, 79, '2025-06-03 03:27:42', '2025-06-03 03:27:42'),
(405, '2', 0, 41, NULL, 80, '2025-06-05 04:51:07', '2025-06-05 04:51:07'),
(406, '5', 1, 79, NULL, 80, '2025-06-05 04:51:07', '2025-06-05 04:51:07'),
(407, '<img src=\"http://snbt.test/storage/uploads/1749440606-no 18.jpg\" width=\"1600\" height=\"496\">', 1, 82, NULL, 81, '2025-06-09 03:48:51', '2025-06-09 03:48:51'),
(408, NULL, NULL, 83, NULL, 81, '2025-06-09 05:25:05', '2025-06-11 11:37:32'),
(415, '<img style=\"aspect-ratio:649/306;\" src=\"/storage/uploads/1749447473-image.png\" width=\"649\" height=\"306\">', 1, 84, NULL, 84, '2025-06-09 08:02:04', '2025-06-09 08:02:04'),
(416, '{\"2\":\"yes\",\"4\":\"no\",\"5\":\"no\"}', 0, 86, NULL, 84, '2025-06-09 08:02:25', '2025-06-09 08:02:25'),
(417, '{\"2\":\"no\",\"4\":\"no\",\"5\":\"yes\"}', 1, 87, NULL, 84, '2025-06-09 08:02:25', '2025-06-09 08:02:25'),
(418, 'e', 0, 92, NULL, 81, '2025-06-09 08:24:13', '2025-06-11 11:37:32'),
(419, '<img style=\"aspect-ratio:975/460;\" src=\"/storage/uploads/1749457388-bpmn.png\" width=\"975\" height=\"460\">', 0, 93, NULL, 81, '2025-06-09 08:24:13', '2025-06-11 04:48:10'),
(420, '<img style=\"aspect-ratio:3276/2120;\" src=\"/storage/uploads/1749458462-6937117.jpg\" width=\"3276\" height=\"2120\">', 1, 94, NULL, 81, '2025-06-09 08:43:25', '2025-06-09 08:43:25'),
(421, '<img style=\"aspect-ratio:600/418;\" src=\"/storage/uploads/1749458802-image.png\" width=\"600\" height=\"418\">', 1, 95, NULL, 81, '2025-06-09 08:47:20', '2025-06-09 08:47:20'),
(422, '<img src=\"http://snbt.test/storage/uploads/1749459289-image.png\" width=\"603\" height=\"351\">', 1, 96, NULL, 81, '2025-06-09 08:57:43', '2025-06-09 08:57:43'),
(423, '<img style=\"aspect-ratio:112/112;\" src=\"/storage/uploads/1749531378-icon-testimonial-1.png\" width=\"112\" height=\"112\">', 1, 97, NULL, 81, '2025-06-10 04:58:54', '2025-06-11 08:55:03'),
(425, '<img src=\"../../../storage/images/Kelompok 4-erd (1).jpg\" alt=\"\" width=\"502\" height=\"350\">', 1, 73, NULL, 86, '2025-06-11 05:50:58', '2025-06-11 05:50:58'),
(426, '<img src=\"../../storage/images/Screenshot 2025-05-30 171439.png\" alt=\"\" width=\"156\" height=\"45\">', 1, 74, NULL, 86, '2025-06-11 05:50:58', '2025-06-11 05:50:58'),
(427, '<img src=\"../../storage/images/Screenshot 2025-06-03 131507.png\" alt=\"\" width=\"62\" height=\"63\">', 1, 77, NULL, 86, '2025-06-11 05:50:58', '2025-06-11 05:53:10'),
(428, 'f', 0, 78, NULL, 86, '2025-06-11 05:50:58', '2025-06-11 05:53:10'),
(462, 'penanganan kendala mengonsumsi susu', 1, 56, 500, 90, '2025-06-11 06:26:51', '2025-06-11 06:28:34'),
(463, 'Mengapa penderita intoleran tidak mau mengonsumsi susu?', 1, 61, 596.64, 90, '2025-06-11 06:26:51', '2025-06-11 06:28:34'),
(464, 'Orang yang secara biologis tidak dapat mencerna kandungan laktosa susu.', 1, 62, 566.93, 90, '2025-06-11 06:26:51', '2025-06-11 06:28:34'),
(465, 'Penyebab orang tidak menyukai susu, penderita intoleran susu, dan manfaat susu fermentasi.', 1, 63, 596.64, 90, '2025-06-11 06:26:51', '2025-06-11 06:28:34'),
(466, 'sejarah terbentuknya benua dan pulau', 1, 64, 500, 90, '2025-06-11 06:26:51', '2025-06-11 06:28:34'),
(467, 'kerusakan alam dan lingkungan hidup akibat ulah manusia', 1, 65, 500, 90, '2025-06-11 06:27:27', '2025-06-11 06:28:34'),
(468, '(4)', 1, 66, 500, 90, '2025-06-11 06:27:27', '2025-06-11 06:28:34'),
(469, '(12)', 1, 67, 522.13, 90, '2025-06-11 06:27:27', '2025-06-11 06:28:34'),
(470, 'Adanya kesalahan cara pandang manusia terhadap alam.', 1, 68, 599.11, 90, '2025-06-11 06:27:27', '2025-06-11 06:28:34'),
(471, '(7) dan (9)', 1, 69, 522.13, 90, '2025-06-11 06:27:27', '2025-06-11 06:28:34'),
(472, '<img src=\"../../storage/images/categories-gadgets.svg\" alt=\"\" width=\"76\" height=\"76\">', 0, 71, 0, 90, '2025-06-11 06:27:27', '2025-06-11 06:28:16'),
(473, '<img style=\"aspect-ratio:224/224;\" src=\"/storage/uploads/1749632026-images.jpeg\" width=\"224\" height=\"224\">', 1, 99, NULL, 81, '2025-06-11 08:55:03', '2025-06-11 08:55:03'),
(474, '<img src=\"http://snbt.test/storage/uploads/1749440606-no 18.jpg\" width=\"1600\" height=\"496\">', 1, 82, NULL, 91, '2025-06-11 11:37:09', '2025-06-11 11:37:09'),
(475, '{\"1\":\"no\",\"3\":\"no\",\"4\":\"no\"}', 0, 83, NULL, 91, '2025-06-11 11:37:09', '2025-06-11 11:37:09'),
(476, 'dfdf', 0, 92, NULL, 91, '2025-06-11 11:37:09', '2025-06-11 11:37:09'),
(477, '<img style=\"aspect-ratio:975/460;\" src=\"/storage/uploads/1749457388-bpmn.png\" width=\"975\" height=\"460\">', 0, 93, NULL, 91, '2025-06-11 11:37:09', '2025-06-11 11:37:09'),
(478, '<img style=\"aspect-ratio:3276/2120;\" src=\"/storage/uploads/1749458462-6937117.jpg\" width=\"3276\" height=\"2120\">', 1, 94, NULL, 91, '2025-06-11 11:37:09', '2025-06-11 11:37:09'),
(479, '<img style=\"aspect-ratio:600/418;\" src=\"/storage/uploads/1749458802-image.png\" width=\"600\" height=\"418\">', 1, 95, NULL, 91, '2025-06-11 11:37:09', '2025-06-11 11:37:09'),
(480, '<img src=\"http://snbt.test/storage/uploads/1749459289-image.png\" width=\"603\" height=\"351\">', 1, 96, NULL, 91, '2025-06-11 11:37:09', '2025-06-11 11:37:09'),
(481, '<img style=\"aspect-ratio:112/112;\" src=\"/storage/uploads/1749531378-icon-testimonial-1.png\" width=\"112\" height=\"112\">', 1, 97, NULL, 91, '2025-06-11 11:37:09', '2025-06-11 11:37:09'),
(482, '<img style=\"aspect-ratio:224/224;\" src=\"/storage/uploads/1749632026-images.jpeg\" width=\"224\" height=\"224\">', 1, 99, NULL, 91, '2025-06-11 11:37:09', '2025-06-11 11:37:09'),
(494, '<img src=\"http://snbt.test/storage/uploads/1749531485-icon-testimonial-1.png\" width=\"112\" height=\"112\">', 1, 98, NULL, 93, '2025-06-11 11:55:06', '2025-06-11 11:55:06'),
(495, '<img src=\"/storage/uploads/1749643023-image.png\" width=\"431\" height=\"288\">', 1, 100, NULL, 93, '2025-06-11 11:58:08', '2025-06-11 11:58:08'),
(496, '<img src=\"/storage/uploads/1749642850-image.png\" width=\"284\" height=\"189\">', 1, 101, NULL, 93, '2025-06-11 11:58:08', '2025-06-11 11:58:08'),
(497, '<img src=\"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-oRtqV2etq0bMdjwyjIdJUGkZGT6M2AYn0g&amp;s\" alt=\"10 Cara Belajar Efektif dan Efisien di Rumah, Perhatikan Langkah-langkahnya  - Hot Liputan6.com\" width=\"259\" height=\"194\">', 0, 98, NULL, 94, '2025-06-11 12:02:55', '2025-06-11 12:02:55'),
(498, '<img src=\"/storage/uploads/1749643023-image.png\" width=\"431\" height=\"288\">', 1, 100, NULL, 94, '2025-06-11 12:03:05', '2025-06-11 12:03:05'),
(499, '<img src=\"/storage/uploads/1749642850-image.png\" width=\"284\" height=\"189\">', 1, 101, NULL, 94, '2025-06-11 12:03:05', '2025-06-11 12:03:05'),
(500, '<img src=\"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-oRtqV2etq0bMdjwyjIdJUGkZGT6M2AYn0g&amp;s\" alt=\"10 Cara Belajar Efektif dan Efisien di Rumah, Perhatikan Langkah-langkahnya  - Hot Liputan6.com\" width=\"259\" height=\"194\">', 0, 98, NULL, 95, '2025-06-11 12:04:12', '2025-06-11 12:04:12'),
(501, '<img src=\"/storage/uploads/1749643023-image.png\" width=\"431\" height=\"288\">', 1, 100, NULL, 95, '2025-06-11 12:04:22', '2025-06-11 12:04:22'),
(502, '<img src=\"/storage/uploads/1749642850-image.png\" width=\"284\" height=\"189\">', 1, 101, NULL, 95, '2025-06-11 12:04:22', '2025-06-11 12:04:22');

-- --------------------------------------------------------

--
-- Table structure for table `result_logs`
--

CREATE TABLE `result_logs` (
  `id` bigint UNSIGNED NOT NULL,
  `result_id` bigint UNSIGNED NOT NULL,
  `correct` int NOT NULL,
  `wrong` int NOT NULL,
  `score` double(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `result_logs`
--

INSERT INTO `result_logs` (`id`, `result_id`, `correct`, `wrong`, `score`, `created_at`, `updated_at`) VALUES
(1, 81, 5, 3, 62.50, '2025-06-11 04:48:10', '2025-06-11 04:48:10'),
(2, 81, 4, 4, 50.00, '2025-06-11 05:02:47', '2025-06-11 05:02:47');

-- --------------------------------------------------------

--
-- Table structure for table `sub_categories`
--

CREATE TABLE `sub_categories` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `timer` int DEFAULT NULL,
  `category_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sub_categories`
--

INSERT INTO `sub_categories` (`id`, `name`, `photo`, `slug`, `timer`, `category_id`, `created_at`, `updated_at`) VALUES
(2, 'Kemampuan Penalaran Umum', 'assets/subcategory/1742976169_Kemampuan Penalaran Umum.png', 'kemampuan-penalaran-umum', 2, 1, '2025-03-26 08:02:49', '2025-03-26 08:03:13'),
(3, 'Pengetahuan dan Pemahaman Umum', 'assets/subcategory/1745927927_book.png', 'pengetahuan-dan-pemahaman-umum', 5, 1, '2025-04-29 11:58:47', '2025-05-27 04:10:53'),
(4, 'Kemampuan Memahami Bacaan dan Menulis', 'assets/subcategory/1745928062_book (1).png', 'kemampuan-memahami-bacaan-dan-menulis', 6, 1, '2025-04-29 12:01:02', '2025-05-27 04:11:07'),
(5, 'Pengetahuan Kuantitatif', 'assets/subcategory/1745928213_statistical-analysis.png', 'pengetahuan-kuantitatif', 5, 1, '2025-04-29 12:03:33', '2025-04-29 12:03:33'),
(6, 'Literasi dalam Bahasa Indonesia', 'assets/subcategory/1745928405_language.png', 'literasi-dalam-bahasa-indonesia', NULL, 2, '2025-04-29 12:04:53', '2025-04-29 12:06:45'),
(7, 'Literasi Bahasa Inggris', 'assets/subcategory/1745928381_eng.png', 'literasi-bahasa-inggris', NULL, 2, '2025-04-29 12:06:21', '2025-04-29 12:06:21'),
(8, 'Penalaran Matematika', 'assets/subcategory/1745928459_calculator.png', 'penalaran-matematika', NULL, 6, '2025-04-29 12:07:39', '2025-05-01 03:26:46'),
(9, 'Matematika', 'assets/subcategory/1748599682_—Pngtree—math clipart balloon cartoon math_6086532.png', 'matematika', 0, 7, '2025-05-30 10:08:02', '2025-05-30 10:08:02');

-- --------------------------------------------------------

--
-- Table structure for table `universities`
--

CREATE TABLE `universities` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `universities`
--

INSERT INTO `universities` (`id`, `name`, `photo`, `slug`, `created_at`, `updated_at`) VALUES
(1, 'Universitas Indonesia', 'assets/university/1747969872_ui.png', 'universitas-indonesia', '2025-05-23 03:11:13', '2025-05-23 03:12:27'),
(2, 'Universitas Gadjah Mada', 'assets/university/1747970382_ugm.png', 'universitas-gadjah-mada', '2025-05-23 03:19:19', '2025-05-23 03:19:42'),
(3, 'Institut Teknologi Bandung', NULL, NULL, '2025-05-23 03:19:19', '2025-05-23 03:19:19'),
(4, 'Universitas Diponegoro', NULL, NULL, '2025-05-23 03:19:19', '2025-05-23 03:19:19'),
(5, 'Universitas Padjadjaran', NULL, NULL, '2025-05-23 03:19:19', '2025-05-23 03:19:19'),
(6, 'Institut Pertanian Bogor', NULL, NULL, '2025-05-23 03:19:19', '2025-05-23 03:19:19'),
(7, 'Universitas Brawijaya', NULL, NULL, '2025-05-23 03:19:19', '2025-05-23 03:19:19'),
(8, 'Universitas Airlangga', NULL, NULL, '2025-05-23 03:19:19', '2025-05-23 03:19:19'),
(9, 'Universitas Sebelas Maret', NULL, NULL, '2025-05-23 03:19:19', '2025-05-23 03:19:19'),
(10, 'Universitas Pendidikan Indonesia', NULL, NULL, '2025-05-23 03:19:19', '2025-05-23 03:19:19');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `photos` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `province_id` int DEFAULT NULL,
  `regencies_id` int DEFAULT NULL,
  `country` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `roles` enum('USER','ADMIN','MITRA') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'USER',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `username`, `email_verified_at`, `password`, `photos`, `province_id`, `regencies_id`, `country`, `phone_number`, `roles`, `remember_token`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'Reza Nurfa Ilyas', 'rezailyas39@gmail.com', 'rezailyas101', NULL, '$2y$12$nCBDxAKJdwqQsbPDZ9opkevX2BBVjPsvVL.FTg1nEzY6HA5N2Nofe', NULL, NULL, NULL, NULL, NULL, 'USER', NULL, NULL, '2025-03-26 06:15:11', '2025-06-05 04:32:03'),
(2, 'Budi Hartono', 'budi@gmail.com', 'budihartono12', NULL, '$2y$12$aA8SvMIVBwpDKjb8F6zqOurvMUy641PMi08OXHGsPQhtnHi.57UcG', NULL, NULL, NULL, NULL, NULL, 'MITRA', NULL, NULL, '2025-03-26 06:26:46', '2025-03-26 06:26:46'),
(3, 'Andi', 'andi13@gmail.com', 'Andiil12', NULL, '$2y$12$HaBLPpIrkCUE1DmL.LXRRe.TuWxRJY4/lTbcNUeCNXii8yX3bC6GO', NULL, NULL, NULL, NULL, NULL, 'USER', NULL, NULL, '2025-05-15 03:15:15', '2025-06-11 12:01:14'),
(4, 'Ilyas', 'ilyas123@gmail.com', 'ilyas123', NULL, '$2y$12$mzj2Oi8gQiwoEjWvv6O34ezzrOzmlFIrNqHXfLwmKDORyvmsMgW1.', NULL, NULL, NULL, NULL, NULL, 'ADMIN', NULL, NULL, '2025-05-22 03:18:34', '2025-05-22 03:18:34'),
(5, 'Fajar Nooer', 'fajar123@gmail.com', 'FajarNoer123', NULL, '$2y$12$qDI1cUe9GuAhE4559LQo2eeHdA3lQ7Ef0pOYlKLciBIJYPeptqvly', NULL, NULL, NULL, NULL, NULL, 'USER', NULL, NULL, '2025-05-28 02:47:53', '2025-05-28 02:47:53'),
(6, 'Marc', 'marc123@gmail.com', 'marc1234', NULL, '$2y$12$GV5fksTTzvORUbUYvWh.keS/XfWHNyHDusSZF9amzbbQYkQ4XzA/O', NULL, NULL, NULL, NULL, NULL, 'USER', NULL, NULL, '2025-05-28 03:06:55', '2025-05-28 03:06:55'),
(7, 'resa', 'resa@gmail.com', 'resa123', NULL, '$2y$12$AJ0Ky/W4BGQHlMbz0B/BvuLevQxwPEEFSfZr5Xd.yCzJfEAcwz18G', NULL, NULL, NULL, NULL, NULL, 'USER', NULL, NULL, '2025-05-28 11:52:01', '2025-05-28 11:52:01'),
(8, 'Jokowi', 'joko123@gmail.com', 'joko123', NULL, '$2y$12$IdaOgbfuwHgwJ4.fnEuqH.fyZe5/4ENAo/iiai/ymYGk7x3GVrPHq', NULL, NULL, NULL, NULL, NULL, 'USER', NULL, NULL, '2025-06-04 12:34:43', '2025-06-04 12:34:43'),
(9, 'Reza Ilyas', 'rezailyas61@gmail.com', 'rezailyas1016', NULL, '$2y$12$th4gFefUc2ZzGVYa7eFLueIEnKxD7Yai6Kk5IkiLzPMaXc4AFI1BG', NULL, NULL, NULL, NULL, NULL, 'ADMIN', NULL, NULL, '2025-06-05 04:26:33', '2025-06-05 04:26:33'),
(10, 'andika', 'andika@gmail.com', 'andika123', NULL, '$2y$12$0GqrNRb7KSSrNp4FpATTlONo8mzlrTbmnUrGkzAt1VQMsAhx81o/6', NULL, NULL, NULL, NULL, NULL, 'USER', NULL, NULL, '2025-06-11 11:41:35', '2025-06-11 11:41:35');

-- --------------------------------------------------------

--
-- Table structure for table `user_majors`
--

CREATE TABLE `user_majors` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `major_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_majors`
--

INSERT INTO `user_majors` (`id`, `user_id`, `major_id`, `created_at`, `updated_at`) VALUES
(6, 1, 81, '2025-05-24 05:38:26', '2025-06-05 05:19:53'),
(8, 1, 93, '2025-05-24 06:25:18', '2025-06-05 05:19:53'),
(9, 4, 81, '2025-05-24 06:33:00', '2025-05-24 06:33:00'),
(10, 4, 116, '2025-05-24 06:33:00', '2025-05-24 06:33:00'),
(11, 4, 11, '2025-05-24 06:33:00', '2025-05-24 06:33:00'),
(12, 3, 1, '2025-05-28 02:42:23', '2025-05-31 05:34:33'),
(13, 3, 93, '2025-05-28 02:42:23', '2025-05-31 05:34:33'),
(14, 5, 1, '2025-05-28 02:49:26', '2025-05-28 02:49:26'),
(15, 5, 93, '2025-05-28 02:49:26', '2025-05-28 02:49:26'),
(16, 5, 13, '2025-05-28 02:49:26', '2025-05-28 02:49:26'),
(17, 6, 13, '2025-05-28 03:07:19', '2025-05-28 03:07:19'),
(18, 3, 75, '2025-05-31 05:34:33', '2025-05-31 05:34:33'),
(21, 1, 173, '2025-06-04 12:32:24', '2025-06-05 05:19:53'),
(22, 8, 21, '2025-06-04 12:35:11', '2025-06-04 13:20:52'),
(23, 8, 174, '2025-06-04 13:04:29', '2025-06-04 13:20:52'),
(25, 8, 176, '2025-06-04 13:20:52', '2025-06-04 13:20:52');

-- --------------------------------------------------------

--
-- Table structure for table `villages`
--

CREATE TABLE `villages` (
  `id` char(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `district_id` char(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `districts`
--
ALTER TABLE `districts`
  ADD KEY `districts_regency_id_foreign` (`regency_id`),
  ADD KEY `districts_id_index` (`id`);

--
-- Indexes for table `essays`
--
ALTER TABLE `essays`
  ADD PRIMARY KEY (`id`),
  ADD KEY `essays_question_id_foreign` (`question_id`);

--
-- Indexes for table `exams`
--
ALTER TABLE `exams`
  ADD PRIMARY KEY (`id`),
  ADD KEY `exams_exam_category_id_foreign` (`exam_category_id`),
  ADD KEY `exams_sub_category_id_foreign` (`sub_category_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `majors`
--
ALTER TABLE `majors`
  ADD PRIMARY KEY (`id`),
  ADD KEY `majors_university_id_foreign` (`university_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `multiple_choices`
--
ALTER TABLE `multiple_choices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `multiple_choices_question_id_foreign` (`question_id`);

--
-- Indexes for table `multiple_options`
--
ALTER TABLE `multiple_options`
  ADD PRIMARY KEY (`id`),
  ADD KEY `multiple_options_question_id_foreign` (`question_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `provinces`
--
ALTER TABLE `provinces`
  ADD KEY `provinces_id_index` (`id`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `questions_sub_category_id_foreign` (`sub_category_id`),
  ADD KEY `questions_exam_id_foreign` (`exam_id`);

--
-- Indexes for table `regencies`
--
ALTER TABLE `regencies`
  ADD KEY `regencies_province_id_foreign` (`province_id`),
  ADD KEY `regencies_id_index` (`id`);

--
-- Indexes for table `results`
--
ALTER TABLE `results`
  ADD PRIMARY KEY (`id`),
  ADD KEY `results_user_id_foreign` (`user_id`),
  ADD KEY `results_exam_id_foreign` (`exam_id`);

--
-- Indexes for table `results_evaluations`
--
ALTER TABLE `results_evaluations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `results_evaluations_result_id_foreign` (`result_id`);

--
-- Indexes for table `result_details`
--
ALTER TABLE `result_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `result_details_question_id_foreign` (`question_id`),
  ADD KEY `result_details_result_id_foreign` (`result_id`);

--
-- Indexes for table `result_logs`
--
ALTER TABLE `result_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `result_logs_result_id_foreign` (`result_id`);

--
-- Indexes for table `sub_categories`
--
ALTER TABLE `sub_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sub_categories_category_id_foreign` (`category_id`);

--
-- Indexes for table `universities`
--
ALTER TABLE `universities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_username_unique` (`username`);

--
-- Indexes for table `user_majors`
--
ALTER TABLE `user_majors`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_majors_user_id_foreign` (`user_id`),
  ADD KEY `user_majors_major_id_foreign` (`major_id`);

--
-- Indexes for table `villages`
--
ALTER TABLE `villages`
  ADD KEY `villages_district_id_foreign` (`district_id`),
  ADD KEY `villages_id_index` (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `essays`
--
ALTER TABLE `essays`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `exams`
--
ALTER TABLE `exams`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `majors`
--
ALTER TABLE `majors`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=197;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT for table `multiple_choices`
--
ALTER TABLE `multiple_choices`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `multiple_options`
--
ALTER TABLE `multiple_options`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=102;

--
-- AUTO_INCREMENT for table `results`
--
ALTER TABLE `results`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=96;

--
-- AUTO_INCREMENT for table `results_evaluations`
--
ALTER TABLE `results_evaluations`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `result_details`
--
ALTER TABLE `result_details`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=503;

--
-- AUTO_INCREMENT for table `result_logs`
--
ALTER TABLE `result_logs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `sub_categories`
--
ALTER TABLE `sub_categories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `universities`
--
ALTER TABLE `universities`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `user_majors`
--
ALTER TABLE `user_majors`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `districts`
--
ALTER TABLE `districts`
  ADD CONSTRAINT `districts_regency_id_foreign` FOREIGN KEY (`regency_id`) REFERENCES `regencies` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `essays`
--
ALTER TABLE `essays`
  ADD CONSTRAINT `essays_question_id_foreign` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `exams`
--
ALTER TABLE `exams`
  ADD CONSTRAINT `exams_exam_category_id_foreign` FOREIGN KEY (`exam_category_id`) REFERENCES `exam_categories` (`id`),
  ADD CONSTRAINT `exams_sub_category_id_foreign` FOREIGN KEY (`sub_category_id`) REFERENCES `sub_categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `majors`
--
ALTER TABLE `majors`
  ADD CONSTRAINT `majors_university_id_foreign` FOREIGN KEY (`university_id`) REFERENCES `universities` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `multiple_choices`
--
ALTER TABLE `multiple_choices`
  ADD CONSTRAINT `multiple_choices_question_id_foreign` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `multiple_options`
--
ALTER TABLE `multiple_options`
  ADD CONSTRAINT `multiple_options_question_id_foreign` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `questions_exam_id_foreign` FOREIGN KEY (`exam_id`) REFERENCES `exams` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `questions_sub_category_id_foreign` FOREIGN KEY (`sub_category_id`) REFERENCES `sub_categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `regencies`
--
ALTER TABLE `regencies`
  ADD CONSTRAINT `regencies_province_id_foreign` FOREIGN KEY (`province_id`) REFERENCES `provinces` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `results`
--
ALTER TABLE `results`
  ADD CONSTRAINT `results_exam_id_foreign` FOREIGN KEY (`exam_id`) REFERENCES `exams` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `results_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `results_evaluations`
--
ALTER TABLE `results_evaluations`
  ADD CONSTRAINT `results_evaluations_result_id_foreign` FOREIGN KEY (`result_id`) REFERENCES `results` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `result_details`
--
ALTER TABLE `result_details`
  ADD CONSTRAINT `result_details_question_id_foreign` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `result_details_result_id_foreign` FOREIGN KEY (`result_id`) REFERENCES `results` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `result_logs`
--
ALTER TABLE `result_logs`
  ADD CONSTRAINT `result_logs_result_id_foreign` FOREIGN KEY (`result_id`) REFERENCES `results` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `sub_categories`
--
ALTER TABLE `sub_categories`
  ADD CONSTRAINT `sub_categories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_majors`
--
ALTER TABLE `user_majors`
  ADD CONSTRAINT `user_majors_major_id_foreign` FOREIGN KEY (`major_id`) REFERENCES `majors` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_majors_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `villages`
--
ALTER TABLE `villages`
  ADD CONSTRAINT `villages_district_id_foreign` FOREIGN KEY (`district_id`) REFERENCES `districts` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
