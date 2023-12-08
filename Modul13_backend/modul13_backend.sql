-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 01, 2023 at 05:24 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `modul13_backend`
--

-- --------------------------------------------------------

--
-- Table structure for table `contents`
--

CREATE TABLE `contents` (
  `id` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `thumbnail` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2016_06_01_000001_create_oauth_auth_codes_table', 1),
(2, '2016_06_01_000002_create_oauth_access_tokens_table', 1),
(3, '2016_06_01_000003_create_oauth_refresh_tokens_table', 1),
(4, '2016_06_01_000004_create_oauth_clients_table', 1),
(5, '2016_06_01_000005_create_oauth_personal_access_clients_table', 1),
(6, '2019_12_14_000001_create_personal_access_tokens_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `scopes` text DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_access_tokens`
--

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('0aacda4adc516e5cc45e651afe5d498a2b41e683d80322f14e269f52017798438d2e80df9b4c7363', 1, 3, 'Authentication Token', '[]', 0, '2023-11-30 07:30:42', '2023-11-30 07:30:43', '2024-11-30 14:30:42'),
('0bb39625b2bce3b25cff4b727b9846e78453e5d499c4a74298a88c192b318445c560dd907370382d', 4, 1, 'Authentication Token', '[]', 0, '2023-11-28 16:53:31', '2023-11-28 16:53:32', '2024-11-28 23:53:31'),
('13e73866b1f5a83e01e549f511ef62520635595df4828c6b918cf9bcb627ad5205eb840ef19cf76f', 1, 3, 'Authentication Token', '[]', 0, '2023-11-30 10:13:49', '2023-11-30 10:13:49', '2024-11-30 17:13:49'),
('364f23f592a57c41e73a68d405fadeea2a6e783a2a1cbbdde55739b3ce8fbbf4bb9c06aba49f3ed3', 4, 1, 'Authentication Token', '[]', 0, '2023-11-28 17:01:35', '2023-11-28 17:01:35', '2024-11-29 00:01:35'),
('4b30a1a2c4bfc465cd0ae55e767add05f170c2bde3ba622b16bea61a787cd56d63fe32a99ae28346', 4, 3, 'Authentication Token', '[]', 0, '2023-11-30 05:06:29', '2023-11-30 05:06:29', '2024-11-30 12:06:29'),
('6ce3ea04089ca83f2ccee4bcf2f33869932c51c00a32df21f2aba817d35b4473b8419f176ef730f8', 4, 1, 'Authentication Token', '[]', 0, '2023-11-28 16:53:39', '2023-11-28 16:53:39', '2024-11-28 23:53:39'),
('6d191ba425103b3dbddc389270b1a4c3ad8a4eeee9b5bbb6a51b8d5b562db4dacdc1958c61c76576', 4, 3, 'Authentication Token', '[]', 0, '2023-11-30 04:35:06', '2023-11-30 04:35:06', '2024-11-30 11:35:06'),
('81cf6abee11116e3ea5ca784655f177980b193be243fe8cb05e98492702429e963ed7bf811c1761d', 1, 5, 'Authentication Token', '[]', 0, '2023-11-30 11:04:45', '2023-11-30 11:04:45', '2024-11-30 18:04:45'),
('a33817859c4ac2abad0c755e55801aeead557d0437d01e40916866c32c75a5aff9309e194314c6b3', 4, 3, 'Authentication Token', '[]', 0, '2023-11-30 06:07:21', '2023-11-30 06:07:21', '2024-11-30 13:07:21'),
('b28af44e0dc556bcc2d6f18c439c9c705ea8bafd33acc21f8e8df6683dff264638173d9f4f107065', 4, 3, 'Authentication Token', '[]', 0, '2023-11-30 05:50:15', '2023-11-30 05:50:15', '2024-11-30 12:50:15'),
('e606b0387a5cadc46b3b6a6f4e6f6f6dbf7dda4d294c814b8f0348a0a4fdb93a2c2220880b9845ed', 1, 1, 'Authentication Token', '[]', 0, '2023-11-27 13:11:22', '2023-11-27 13:11:23', '2024-11-27 20:11:22'),
('e6bfd6b69959fbcbf89033fb7aa9a749e9101c4a840d588f184d450c4850c6926ed17593aa7acdb0', 1, 3, 'Authentication Token', '[]', 0, '2023-11-30 09:23:32', '2023-11-30 09:23:32', '2024-11-30 16:23:32'),
('f09015cd01847b9967661a822834c11e1b453921f1d0b6ae32e28e0d12bb3ed7008dd85175c5d3d9', 4, 1, 'Authentication Token', '[]', 0, '2023-11-28 16:53:57', '2023-11-28 16:53:57', '2024-11-28 23:53:57'),
('fd75ea760399bf0aeea0da4a880f7235e684a037c73870e4e7d7adf99a481fd8f020851b14ac8363', 1, 3, 'Authentication Token', '[]', 0, '2023-11-29 13:48:02', '2023-11-29 13:48:02', '2024-11-29 20:48:02'),
('ffec5a69a33c041a4c1eaa1adc168df755eabe674e0035eac5a10b9790ec1a3ff141e5e989d023c3', 1, 3, 'Authentication Token', '[]', 0, '2023-11-30 10:26:20', '2023-11-30 10:26:20', '2024-11-30 17:26:20');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_auth_codes`
--

CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `scopes` text DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `secret` varchar(100) DEFAULT NULL,
  `provider` varchar(255) DEFAULT NULL,
  `redirect` text NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



-- --------------------------------------------------------

--
-- Table structure for table `oauth_personal_access_clients`
--

CREATE TABLE `oauth_personal_access_clients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_personal_access_clients`
--

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2023-11-27 04:30:41', '2023-11-27 04:30:41'),
(2, 3, '2023-11-29 13:13:03', '2023-11-29 13:13:03'),
(3, 5, '2023-11-30 11:03:15', '2023-11-30 11:03:15');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) NOT NULL,
  `access_token_id` varchar(100) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `handle` varchar(20) NOT NULL,
  `bio` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `handle`, `bio`) VALUES
(1, 'Agung', 'Agung@gmail.com', '$2y$10$dgfEXycRxCrFe0xWpqNZLeP4QUxuUyUIhNmCi4x6yT2iLHwFrY9wm', 'admin', 'yeah yeah yeah\npassword: agungKun');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contents`
--
ALTER TABLE `contents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `contents_ibfk_1` (`id_user`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_access_tokens_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_auth_codes`
--
ALTER TABLE `oauth_auth_codes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_auth_codes_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_clients_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contents`
--
ALTER TABLE `contents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `contents`
--
ALTER TABLE `contents`
  ADD CONSTRAINT `contents_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
