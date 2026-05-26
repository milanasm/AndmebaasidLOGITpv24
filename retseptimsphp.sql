-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Май 26 2026 г., 18:47
-- Версия сервера: 10.4.32-MariaDB
-- Версия PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `retseptims`
--

DELIMITER $$
--
-- Процедуры
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `kustutaHinnang` (IN `p_id` INT)   BEGIN
    DELETE FROM hinnang
    WHERE hinnang_id = p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lisaHinnang` (IN `p_hinne` INT, IN `p_kommentaar` VARCHAR(200), IN `p_retsept_id` INT)   BEGIN
    INSERT INTO hinnang(hinne, kommentaar, retsept_id)
    VALUES(p_hinne, p_kommentaar, p_retsept_id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lisaKategooria` (IN `nimi` VARCHAR(50))   BEGIN
    INSERT INTO kategooria(kategooria_nimi)
    VALUES(nimi);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lisaToiduaine` (IN `nimi` VARCHAR(100))   BEGIN
    INSERT INTO toiduaine(toiduaine_nimi)
    VALUES(nimi);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `hinnang`
--

CREATE TABLE `hinnang` (
  `hinnang_id` int(11) NOT NULL,
  `hinne` int(11) DEFAULT NULL CHECK (`hinne` between 1 and 5),
  `kommentaar` varchar(200) DEFAULT NULL,
  `retsept_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `hinnang`
--

INSERT INTO `hinnang` (`hinnang_id`, `hinne`, `kommentaar`, `retsept_id`) VALUES
(1, 5, 'Väga hea', 1),
(2, 4, 'Maitsev', 2),
(3, 3, 'Normaalne', 3),
(4, 5, 'Super', 4),
(5, 2, 'Liiga soolane', 5);

-- --------------------------------------------------------

--
-- Структура таблицы `kasutaja`
--

CREATE TABLE `kasutaja` (
  `kasutaja_id` int(11) NOT NULL,
  `eesnimi` varchar(50) DEFAULT NULL,
  `perenimi` varchar(50) DEFAULT NULL,
  `email` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `kasutaja`
--

INSERT INTO `kasutaja` (`kasutaja_id`, `eesnimi`, `perenimi`, `email`) VALUES
(1, 'Milana', 'Smolenko', 'smolenkomilana@gmail.com'),
(2, 'Tymofii', 'Smolenko', 'tymofii16@gmail.com'),
(3, 'Karolina', 'Oshlakova', 'karolinabebe@gmail.com'),
(4, 'Anastasiia', 'Lebedeva', 'sixseven@gmail.com'),
(5, 'Oleg', 'Burmalda', 'slavamerlou@gmail.com');

-- --------------------------------------------------------

--
-- Структура таблицы `kategooria`
--

CREATE TABLE `kategooria` (
  `kategooria_id` int(11) NOT NULL,
  `kategooria_nimi` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `kategooria`
--

INSERT INTO `kategooria` (`kategooria_id`, `kategooria_nimi`) VALUES
(1, 'Vorstid'),
(2, 'Salat'),
(3, 'Pannkoogid'),
(4, 'Borsh'),
(5, 'Kotletid');

-- --------------------------------------------------------

--
-- Структура таблицы `koostis`
--

CREATE TABLE `koostis` (
  `koostis_id` int(11) NOT NULL,
  `kogus` int(11) DEFAULT NULL,
  `retsept_retsept_id` int(11) DEFAULT NULL,
  `toiduaine_id` int(11) DEFAULT NULL,
  `yhik_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `koostis`
--

INSERT INTO `koostis` (`koostis_id`, `kogus`, `retsept_retsept_id`, `toiduaine_id`, `yhik_id`) VALUES
(1, 200, 1, 3, 1),
(2, 500, 1, 2, 2),
(3, 300, 2, 4, 1),
(4, 2, 3, 5, 3),
(5, 50, 5, 1, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `retsept`
--

CREATE TABLE `retsept` (
  `retsept_id` int(11) NOT NULL,
  `retsepti_nimi` varchar(100) DEFAULT NULL,
  `kirjeldus` varchar(300) DEFAULT NULL,
  `juhend` varchar(500) DEFAULT NULL,
  `sisestatud_kp` date DEFAULT NULL,
  `kasutaja_id` int(11) DEFAULT NULL,
  `kategooria_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `retsept`
--

INSERT INTO `retsept` (`retsept_id`, `retsepti_nimi`, `kirjeldus`, `juhend`, `sisestatud_kp`, `kasutaja_id`, `kategooria_id`) VALUES
(1, 'Pannkoogid', 'Maitsvad pannkoogid', 'Sega ja küpseta', '2026-05-26', 1, 1),
(2, 'Vorstid', 'Maitsvad grillvorstid', 'Prae grillil', '2026-05-26', 2, 4),
(3, 'Tomatisupp', 'Borsh tomatiga', 'Keeda supp', '2026-05-26', 3, 2),
(4, 'Salat', 'Värske salat', 'Sega koostisosad', '2026-05-26', 4, 3),
(5, 'Kakao', 'Soe jook', 'Kuumuta piim', '2026-05-26', 5, 5);

-- --------------------------------------------------------

--
-- Структура таблицы `tehtud`
--

CREATE TABLE `tehtud` (
  `tehtud_id` int(11) NOT NULL,
  `tehtud_kp` date DEFAULT NULL,
  `retsept_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `tehtud`
--

INSERT INTO `tehtud` (`tehtud_id`, `tehtud_kp`, `retsept_id`) VALUES
(1, '2026-05-26', 1),
(2, '2026-05-26', 2),
(3, '2026-05-26', 3),
(4, '2026-05-26', 4),
(5, '2026-05-26', 5);

-- --------------------------------------------------------

--
-- Структура таблицы `toiduaine`
--

CREATE TABLE `toiduaine` (
  `toiduaine_id` int(11) NOT NULL,
  `toiduaine_nimi` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `toiduaine`
--

INSERT INTO `toiduaine` (`toiduaine_id`, `toiduaine_nimi`) VALUES
(1, 'Liha'),
(2, 'Kurk'),
(3, 'Munad'),
(4, 'Peet'),
(5, 'Kana');

-- --------------------------------------------------------

--
-- Структура таблицы `yhik`
--

CREATE TABLE `yhik` (
  `yhik_id` int(11) NOT NULL,
  `yhik_nimi` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `yhik`
--

INSERT INTO `yhik` (`yhik_id`, `yhik_nimi`) VALUES
(1, 'gramm'),
(2, 'liiter'),
(3, 'tk'),
(4, 'spl'),
(5, 'ml');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `hinnang`
--
ALTER TABLE `hinnang`
  ADD PRIMARY KEY (`hinnang_id`),
  ADD KEY `FK_hinnang_retsept` (`retsept_id`);

--
-- Индексы таблицы `kasutaja`
--
ALTER TABLE `kasutaja`
  ADD PRIMARY KEY (`kasutaja_id`);

--
-- Индексы таблицы `kategooria`
--
ALTER TABLE `kategooria`
  ADD PRIMARY KEY (`kategooria_id`);

--
-- Индексы таблицы `koostis`
--
ALTER TABLE `koostis`
  ADD PRIMARY KEY (`koostis_id`),
  ADD KEY `FK_koostis_retsept` (`retsept_retsept_id`),
  ADD KEY `FK_koostis_toiduaine` (`toiduaine_id`),
  ADD KEY `FK_koostis_yhik` (`yhik_id`);

--
-- Индексы таблицы `retsept`
--
ALTER TABLE `retsept`
  ADD PRIMARY KEY (`retsept_id`),
  ADD KEY `FK_retsept_kasutaja` (`kasutaja_id`),
  ADD KEY `FK_retsept_kategooria` (`kategooria_id`);

--
-- Индексы таблицы `tehtud`
--
ALTER TABLE `tehtud`
  ADD PRIMARY KEY (`tehtud_id`),
  ADD KEY `FK_tehtud_retsept` (`retsept_id`);

--
-- Индексы таблицы `toiduaine`
--
ALTER TABLE `toiduaine`
  ADD PRIMARY KEY (`toiduaine_id`);

--
-- Индексы таблицы `yhik`
--
ALTER TABLE `yhik`
  ADD PRIMARY KEY (`yhik_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `hinnang`
--
ALTER TABLE `hinnang`
  MODIFY `hinnang_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `kasutaja`
--
ALTER TABLE `kasutaja`
  MODIFY `kasutaja_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `kategooria`
--
ALTER TABLE `kategooria`
  MODIFY `kategooria_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `koostis`
--
ALTER TABLE `koostis`
  MODIFY `koostis_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `retsept`
--
ALTER TABLE `retsept`
  MODIFY `retsept_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `tehtud`
--
ALTER TABLE `tehtud`
  MODIFY `tehtud_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `toiduaine`
--
ALTER TABLE `toiduaine`
  MODIFY `toiduaine_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `yhik`
--
ALTER TABLE `yhik`
  MODIFY `yhik_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `hinnang`
--
ALTER TABLE `hinnang`
  ADD CONSTRAINT `FK_hinnang_retsept` FOREIGN KEY (`retsept_id`) REFERENCES `retsept` (`retsept_id`);

--
-- Ограничения внешнего ключа таблицы `koostis`
--
ALTER TABLE `koostis`
  ADD CONSTRAINT `FK_koostis_retsept` FOREIGN KEY (`retsept_retsept_id`) REFERENCES `retsept` (`retsept_id`),
  ADD CONSTRAINT `FK_koostis_toiduaine` FOREIGN KEY (`toiduaine_id`) REFERENCES `toiduaine` (`toiduaine_id`),
  ADD CONSTRAINT `FK_koostis_yhik` FOREIGN KEY (`yhik_id`) REFERENCES `yhik` (`yhik_id`);

--
-- Ограничения внешнего ключа таблицы `retsept`
--
ALTER TABLE `retsept`
  ADD CONSTRAINT `FK_retsept_kasutaja` FOREIGN KEY (`kasutaja_id`) REFERENCES `kasutaja` (`kasutaja_id`),
  ADD CONSTRAINT `FK_retsept_kategooria` FOREIGN KEY (`kategooria_id`) REFERENCES `kategooria` (`kategooria_id`);

--
-- Ограничения внешнего ключа таблицы `tehtud`
--
ALTER TABLE `tehtud`
  ADD CONSTRAINT `FK_tehtud_retsept` FOREIGN KEY (`retsept_id`) REFERENCES `retsept` (`retsept_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
