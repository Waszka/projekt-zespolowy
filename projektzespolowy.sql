-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Czas generowania: 25 Kwi 2023, 17:16
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
  `name` varchar(255) NOT NULL,
  `temp` tinyint(1) NOT NULL,
  `status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Zrzut danych tabeli `arduino`
--

INSERT INTO `arduino` (`id`, `arduino_id`, `name`, `temp`, `status`) VALUES
(4, 111, 'Pokój #1', 1, 1),
(5, 312312, 'Fabryka#31', 0, 1),
(6, 666, 'Hala Produkcyjna', 1, 0);

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
(2, 111, 69, 81, '2023-04-24 18:31:27'),
(3, 666, 35.5, 24, '2023-04-25 14:52:26'),
(4, 111, 65, 84, '2023-04-25 14:57:38'),
(5, 111, 40.5, 75, '2023-04-25 15:00:44');

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `arduino`
--
ALTER TABLE `arduino`
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
-- AUTO_INCREMENT dla tabeli `temp`
--
ALTER TABLE `temp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
