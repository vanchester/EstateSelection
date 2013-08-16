-- phpMyAdmin SQL Dump
-- version 3.2.4
-- http://www.phpmyadmin.net
--
-- Хост: localhost:3306
-- Время создания: Авг 16 2013 г., 08:30
-- Версия сервера: 5.5.32
-- Версия PHP: 5.4.9-4ubuntu2.2

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База данных: `homes`
--

-- --------------------------------------------------------

--
-- Структура таблицы `home`
--

CREATE TABLE IF NOT EXISTS `home` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `url` varchar(255) NOT NULL COMMENT 'URL адрес источника',
  `address` varchar(255) NOT NULL COMMENT 'Адрес квартиры',
  `square_all` float DEFAULT NULL COMMENT 'Общая площадь',
  `square_live` float DEFAULT NULL COMMENT 'Жилая площадь',
  `square_kitchen` float DEFAULT NULL COMMENT 'Площадь кухни',
  `price` float DEFAULT NULL COMMENT 'Цена',
  `price_to_square` float DEFAULT NULL COMMENT 'Цена за кв. метр',
  `flat_floor` tinyint(1) DEFAULT NULL COMMENT 'Этаж',
  `home_floor` tinyint(1) DEFAULT NULL COMMENT 'Этажность дома',
  `matherial` varchar(255) DEFAULT NULL COMMENT 'Материал стен',
  `flat_type` varchar(50) DEFAULT NULL COMMENT 'Тип квартиры',
  `layout` varchar(50) DEFAULT NULL COMMENT 'Планировка',
  `toilet` tinyint(1) DEFAULT NULL COMMENT 'Санузел',
  `balcony` varchar(255) DEFAULT NULL COMMENT 'Балкон',
  `phone` varchar(255) DEFAULT NULL COMMENT 'Телефон',
  `type_of_ownership` varchar(100) DEFAULT NULL COMMENT 'Тип собственности',
  `comment` text COMMENT 'Описание',
  PRIMARY KEY (`id`),
  UNIQUE KEY `url` (`url`),
  KEY `address` (`address`),
  KEY `square_all` (`square_all`),
  KEY `square_live` (`square_live`),
  KEY `square_kitchen` (`square_kitchen`),
  KEY `price` (`price`),
  KEY `price_to_square` (`price_to_square`),
  KEY `flat_floor` (`flat_floor`),
  KEY `home_floor` (`home_floor`),
  KEY `matherial` (`matherial`),
  KEY `flat_type` (`flat_type`),
  KEY `layout` (`layout`),
  KEY `toilet` (`toilet`),
  KEY `balcony` (`balcony`),
  KEY `phone` (`phone`),
  KEY `type _of_ownership` (`type_of_ownership`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=14 ;
