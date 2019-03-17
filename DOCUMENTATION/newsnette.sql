-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Počítač: 127.0.0.1
-- Vytvořeno: Čtv 24. led 2019, 12:26
-- Verze serveru: 10.1.37-MariaDB
-- Verze PHP: 7.3.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Databáze: `newsnette`
--

-- --------------------------------------------------------

--
-- Struktura tabulky `evaluation`
--

CREATE TABLE `evaluation` (
  `id` int(11) NOT NULL,
  `news_id` int(11) NOT NULL,
  `users_id` int(11) NOT NULL,
  `inch_up` int(11) DEFAULT NULL,
  `inch_down` int(11) DEFAULT NULL,
  `evaluation` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Vypisuji data pro tabulku `evaluation`
--

INSERT INTO `evaluation` (`id`, `news_id`, `users_id`, `inch_up`, `inch_down`, `evaluation`, `created_at`) VALUES
(14, 1, 1, 1, NULL, NULL, '2019-01-21 15:56:04'),
(16, 1, 1, 1, NULL, NULL, '2019-01-21 15:56:10'),
(17, 1, 1, 1, NULL, NULL, '2019-01-21 15:56:15'),
(25, 1, 1, 1, NULL, NULL, '2019-01-21 15:58:45'),
(26, 1, 1, 1, NULL, NULL, '2019-01-21 15:58:46'),
(27, 1, 1, 1, NULL, NULL, '2019-01-21 15:58:47'),
(28, 1, 1, NULL, 1, NULL, '2019-01-21 15:59:13'),
(29, 1, 1, NULL, 1, NULL, '2019-01-21 15:59:18'),
(30, 1, 1, NULL, 1, NULL, '2019-01-21 15:59:19');

-- --------------------------------------------------------

--
-- Struktura tabulky `news`
--

CREATE TABLE `news` (
  `id` int(11) NOT NULL,
  `short_text` varchar(255) NOT NULL,
  `text` text NOT NULL,
  `author` varchar(255) NOT NULL,
  `users_id` int(11) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Vypisuji data pro tabulku `news`
--

INSERT INTO `news` (`id`, `short_text`, `text`, `author`, `users_id`, `image`, `created_at`) VALUES
(1, 'first news', 'text first news', 'author first news', 1, 'backend.jpeg', '2019-01-16 12:02:25'),
(2, 'second news', 'text second news', 'author second news', 1, 'backend.jpeg', '2019-01-16 12:02:25'),
(3, 'test news', 'text test news', 'author test news', NULL, NULL, '2019-01-17 13:21:16');

-- --------------------------------------------------------

--
-- Struktura tabulky `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Vypisuji data pro tabulku `roles`
--

INSERT INTO `roles` (`id`, `name`, `created_at`) VALUES
(1, 'guest', '2019-01-24 11:31:09'),
(2, 'member', '2019-01-24 11:31:09'),
(3, 'admin', '2019-01-24 11:31:09');

-- --------------------------------------------------------

--
-- Struktura tabulky `tokens`
--

CREATE TABLE `tokens` (
  `id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` datetime NOT NULL,
  `expirate_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Vypisuji data pro tabulku `tokens`
--

INSERT INTO `tokens` (`id`, `token`, `user_id`, `create_at`, `update_at`, `expirate_at`) VALUES
(4, 'jDerqAq0MMlxonVuCyY5qfkOt1UECRN7HyDckXh8wvIS6k7KZzQlBDM4gvrgZD8rGgEXEG1ZlpAFyyK14AjMTw==', 1, '2019-01-21 11:55:43', '2019-01-24 08:01:29', '2019-01-24 20:01:29');

-- --------------------------------------------------------

--
-- Struktura tabulky `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `roles_id` int(16) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Vypisuji data pro tabulku `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `roles_id`, `created_at`) VALUES
(1, 'siki@example.com', 'siki@example.com', '$2y$10$ttwaGNOGm3PaBBjY9JdTIuOTJLZjDwD6R/UPo6G0WN7gfACeVgm0i', 3, '2019-01-16 12:01:19'),
(6, 'admin@example.com', 'admin@example.com', '$2y$10$rAvBQVOePzfRSk//vVRa2.BFx.BYR34xoEDuKXE/vyIBacIao6Pea', 3, '2019-01-22 09:16:38');

--
-- Klíče pro exportované tabulky
--

--
-- Klíče pro tabulku `evaluation`
--
ALTER TABLE `evaluation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `news_id` (`news_id`),
  ADD KEY `user_id` (`users_id`);

--
-- Klíče pro tabulku `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`id`),
  ADD KEY `users_id` (`users_id`);

--
-- Klíče pro tabulku `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Klíče pro tabulku `tokens`
--
ALTER TABLE `tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Klíče pro tabulku `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `roles_id` (`roles_id`);

--
-- AUTO_INCREMENT pro tabulky
--

--
-- AUTO_INCREMENT pro tabulku `evaluation`
--
ALTER TABLE `evaluation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT pro tabulku `news`
--
ALTER TABLE `news`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pro tabulku `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pro tabulku `tokens`
--
ALTER TABLE `tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pro tabulku `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Omezení pro exportované tabulky
--

--
-- Omezení pro tabulku `evaluation`
--
ALTER TABLE `evaluation`
  ADD CONSTRAINT `evaluation_ibfk_1` FOREIGN KEY (`news_id`) REFERENCES `news` (`id`),
  ADD CONSTRAINT `evaluation_ibfk_2` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`);

--
-- Omezení pro tabulku `news`
--
ALTER TABLE `news`
  ADD CONSTRAINT `news_ibfk_1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`);

--
-- Omezení pro tabulku `tokens`
--
ALTER TABLE `tokens`
  ADD CONSTRAINT `tokens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Omezení pro tabulku `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`roles_id`) REFERENCES `roles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
