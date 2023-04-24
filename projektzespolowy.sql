-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Czas generowania: 24 Kwi 2023, 20:54
-- Wersja serwera: 10.4.27-MariaDB
-- Wersja PHP: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `projektzespolowy`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `arduino`
--

CREATE TABLE `arduino` (
  `id` int(11) NOT NULL,
  `arduino_id` int(11) NOT NULL,
  `temp` tinyint(1) NOT NULL,
  `noise` tinyint(1) NOT NULL,
  `camera` tinyint(1) NOT NULL,
  `status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Zrzut danych tabeli `arduino`
--

INSERT INTO `arduino` (`id`, `arduino_id`, `temp`, `noise`, `camera`, `status`) VALUES
(4, 111, 1, 0, 1, 1),
(5, 312312, 0, 1, 1, 1),
(6, 666, 1, 0, 0, 0);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `camera`
--

CREATE TABLE `camera` (
  `id` int(11) NOT NULL,
  `arduino_id` int(11) NOT NULL,
  `ip` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Zrzut danych tabeli `camera`
--

INSERT INTO `camera` (`id`, `arduino_id`, `ip`) VALUES
(1, 312312, '192.168.1.25'),
(2, 111, '192.168.1.15');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `noise`
--

CREATE TABLE `noise` (
  `id` int(11) NOT NULL,
  `arduino_id` int(11) NOT NULL,
  `noiseLevel` int(11) NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Zrzut danych tabeli `noise`
--

INSERT INTO `noise` (`id`, `arduino_id`, `noiseLevel`, `datetime`) VALUES
(1, 312312, 15, '2023-04-24 17:42:26'),
(2, 312312, 46, '2023-04-24 18:38:16');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `temp`
--

CREATE TABLE `temp` (
  `id` int(11) NOT NULL,
  `arduino_id` int(11) NOT NULL,
  `temperature` float NOT NULL,
  `humidity` float NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Zrzut danych tabeli `temp`
--

INSERT INTO `temp` (`id`, `arduino_id`, `temperature`, `humidity`, `datetime`) VALUES
(1, 111, 31, 50, '2023-04-24 17:42:03'),
(2, 111, 69, 81, '2023-04-24 18:31:27');

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `arduino`
--
ALTER TABLE `arduino`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `camera`
--
ALTER TABLE `camera`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `noise`
--
ALTER TABLE `noise`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `temp`
--
ALTER TABLE `temp`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT dla zrzuconych tabel
--

--
-- AUTO_INCREMENT dla tabeli `arduino`
--
ALTER TABLE `arduino`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT dla tabeli `camera`
--
ALTER TABLE `camera`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT dla tabeli `noise`
--
ALTER TABLE `noise`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT dla tabeli `temp`
--
ALTER TABLE `temp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
