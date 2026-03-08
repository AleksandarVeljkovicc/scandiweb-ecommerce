-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Mar 08, 2026 at 06:33 PM
-- Server version: 9.1.0
-- PHP Version: 8.2.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ecommerce_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `attributes`
--

DROP TABLE IF EXISTS `attributes`;
CREATE TABLE IF NOT EXISTS `attributes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `attribute_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `attributes`
--

INSERT INTO `attributes` (`id`, `product_id`, `attribute_name`, `type`) VALUES
(1, 1, 'Size', 'text'),
(2, 2, 'Size', 'text'),
(3, 3, 'Color', 'swatch'),
(4, 3, 'Capacity', 'text'),
(5, 4, 'Color', 'swatch'),
(6, 4, 'Capacity', 'text'),
(7, 5, 'Capacity', 'text'),
(8, 5, 'With USB 3 ports', 'text'),
(9, 5, 'Touch ID in keyboard', 'text'),
(10, 6, 'Capacity', 'text'),
(11, 6, 'Color', 'swatch');

-- --------------------------------------------------------

--
-- Table structure for table `attribute_values`
--

DROP TABLE IF EXISTS `attribute_values`;
CREATE TABLE IF NOT EXISTS `attribute_values` (
  `id` int NOT NULL AUTO_INCREMENT,
  `attribute_id` int NOT NULL,
  `display_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `attribute_id` (`attribute_id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `attribute_values`
--

INSERT INTO `attribute_values` (`id`, `attribute_id`, `display_value`, `value`) VALUES
(1, 1, '40', '40'),
(2, 1, '41', '41'),
(3, 1, '42', '42'),
(4, 1, '43', '43'),
(5, 2, 'Small', 'S'),
(6, 2, 'Medium', 'M'),
(7, 2, 'Large', 'L'),
(8, 2, 'Extra Large', 'XL'),
(9, 3, 'Green', '#44FF03'),
(10, 3, 'Cyan', '#03FFF7'),
(11, 3, 'Blue', '#030BFF'),
(12, 3, 'Black', '#000000'),
(13, 3, 'White', '#FFFFFF'),
(14, 4, '512G', '512G'),
(15, 4, '1T', '1T'),
(16, 5, 'Green', '#44FF03'),
(17, 5, 'Cyan', '#03FFF7'),
(18, 5, 'Blue', '#030BFF'),
(19, 5, 'Black', '#000000'),
(20, 5, 'White', '#FFFFFF'),
(21, 6, '512G', '512G'),
(22, 6, '1T', '1T'),
(23, 7, '256GB', '256GB'),
(24, 7, '512GB', '512GB'),
(25, 8, 'Yes', 'Yes'),
(26, 8, 'No', 'No'),
(27, 9, 'Yes', 'Yes'),
(28, 9, 'No', 'No'),
(29, 10, '512G', '512G'),
(30, 10, '1T', '1T'),
(31, 11, 'Green', '#44FF03'),
(32, 11, 'Cyan', '#03FFF7'),
(33, 11, 'Blue', '#030BFF'),
(34, 11, 'Black', '#000000'),
(35, 11, 'White', '#FFFFFF');

-- --------------------------------------------------------

--
-- Stand-in structure for view `full_product`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `full_product`;
CREATE TABLE IF NOT EXISTS `full_product` (
`product_id` int
,`name` varchar(255)
,`in_stock` tinyint(1)
,`price` decimal(10,2)
,`currency_symbol` varchar(5)
,`attribute_name` varchar(255)
,`value` varchar(255)
,`image_url` text
,`description` text
);

-- --------------------------------------------------------

--
-- Table structure for table `gallery`
--

DROP TABLE IF EXISTS `gallery`;
CREATE TABLE IF NOT EXISTS `gallery` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `image_url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `gallery`
--

INSERT INTO `gallery` (`id`, `product_id`, `image_url`) VALUES
(1, 1, 'https://cdn.shopify.com/s/files/1/0087/6193/3920/products/DD1381200_DEOA_2_720x.jpg?v=1612816087'),
(2, 1, 'https://cdn.shopify.com/s/files/1/0087/6193/3920/products/DD1381200_DEOA_1_720x.jpg?v=1612816087'),
(3, 1, 'https://cdn.shopify.com/s/files/1/0087/6193/3920/products/DD1381200_DEOA_3_720x.jpg?v=1612816087'),
(4, 1, 'https://cdn.shopify.com/s/files/1/0087/6193/3920/products/DD1381200_DEOA_5_720x.jpg?v=1612816087'),
(5, 1, 'https://cdn.shopify.com/s/files/1/0087/6193/3920/products/DD1381200_DEOA_4_720x.jpg?v=1612816087'),
(6, 2, 'https://images.canadagoose.com/image/upload/w_480,c_scale,f_auto,q_auto:best/v1576016105/product-image/2409L_61.jpg'),
(7, 2, 'https://images.canadagoose.com/image/upload/w_480,c_scale,f_auto,q_auto:best/v1576016107/product-image/2409L_61_a.jpg'),
(8, 2, 'https://images.canadagoose.com/image/upload/w_480,c_scale,f_auto,q_auto:best/v1576016108/product-image/2409L_61_b.jpg'),
(9, 2, 'https://images.canadagoose.com/image/upload/w_480,c_scale,f_auto,q_auto:best/v1576016109/product-image/2409L_61_c.jpg'),
(10, 2, 'https://images.canadagoose.com/image/upload/w_480,c_scale,f_auto,q_auto:best/v1576016110/product-image/2409L_61_d.jpg'),
(11, 2, 'https://images.canadagoose.com/image/upload/w_1333,c_scale,f_auto,q_auto:best/v1634058169/product-image/2409L_61_o.png'),
(12, 2, 'https://images.canadagoose.com/image/upload/w_1333,c_scale,f_auto,q_auto:best/v1634058159/product-image/2409L_61_p.png'),
(13, 3, 'https://images-na.ssl-images-amazon.com/images/I/510VSJ9mWDL._SL1262_.jpg'),
(14, 3, 'https://images-na.ssl-images-amazon.com/images/I/610%2B69ZsKCL._SL1500_.jpg'),
(15, 3, 'https://images-na.ssl-images-amazon.com/images/I/51iPoFwQT3L._SL1230_.jpg'),
(16, 3, 'https://images-na.ssl-images-amazon.com/images/I/61qbqFcvoNL._SL1500_.jpg'),
(17, 3, 'https://images-na.ssl-images-amazon.com/images/I/51HCjA3rqYL._SL1230_.jpg'),
(18, 4, 'https://images-na.ssl-images-amazon.com/images/I/71vPCX0bS-L._SL1500_.jpg'),
(19, 4, 'https://images-na.ssl-images-amazon.com/images/I/71q7JTbRTpL._SL1500_.jpg'),
(20, 4, 'https://images-na.ssl-images-amazon.com/images/I/71iQ4HGHtsL._SL1500_.jpg'),
(21, 4, 'https://images-na.ssl-images-amazon.com/images/I/61IYrCrBzxL._SL1500_.jpg'),
(22, 4, 'https://images-na.ssl-images-amazon.com/images/I/61RnXmpAmIL._SL1500_.jpg'),
(23, 5, 'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/imac-24-blue-selection-hero-202104?wid=904&hei=840&fmt=jpeg&qlt=80&.v=1617492405000'),
(24, 6, 'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-12-pro-family-hero?wid=940&amp;hei=1112&amp;fmt=jpeg&amp;qlt=80&amp;.v=1604021663000'),
(25, 7, 'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MWP22?wid=572&hei=572&fmt=jpeg&qlt=95&.v=1591634795000'),
(26, 8, 'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/airtag-double-select-202104?wid=445&hei=370&fmt=jpeg&qlt=95&.v=1617761672000');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
CREATE TABLE IF NOT EXISTS `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `users_id` int NOT NULL,
  `product_id` int NOT NULL,
  `total_price` decimal(10,2) DEFAULT NULL,
  `currency_symbol` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity` int NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `users_id` (`users_id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `users_id`, `product_id`, `total_price`, `currency_symbol`, `quantity`, `created_at`) VALUES
(1, 1, 2, 518.47, '$', 2, '2025-10-07 20:53:09'),
(2, 1, 1, 144.69, '$', 1, '2025-10-07 20:53:09'),
(3, 1, 5, 1688.03, '$', 3, '2025-10-07 20:56:21'),
(4, 1, 5, 3376.06, '$', 2, '2025-10-07 21:35:35'),
(5, 1, 1, 289.38, '$', 2, '2025-10-07 21:35:35'),
(6, 1, 2, 1036.94, '$', 2, '2025-10-07 21:47:18'),
(7, 1, 2, 1036.94, '$', 2, '2025-10-07 21:47:18'),
(8, 1, 6, 1000.76, '$', 1, '2025-10-07 21:47:18'),
(9, 1, 6, 2001.52, '$', 2, '2025-10-07 21:48:18'),
(10, 1, 6, 3002.28, '$', 3, '2025-10-07 21:49:04'),
(11, 1, 6, 3002.28, '$', 3, '2025-10-07 21:49:04'),
(12, 1, 1, 434.07, '$', 3, '2025-10-07 22:04:11'),
(13, 1, 1, 1446.90, '$', 10, '2025-10-07 22:04:11'),
(14, 1, 5, 1688.03, '$', 1, '2025-10-07 22:04:11'),
(15, 1, 1, 144.69, '$', 1, '2025-10-07 22:28:28'),
(16, 1, 8, 361.71, '$', 3, '2025-10-07 22:35:12'),
(17, 1, 3, 2532.06, '$', 3, '2025-10-08 13:19:47'),
(18, 1, 3, 844.02, '$', 1, '2025-10-08 13:19:47'),
(19, 1, 3, 844.02, '$', 1, '2025-10-08 13:20:58'),
(20, 1, 3, 844.02, '$', 1, '2025-10-08 13:20:58'),
(21, 1, 2, 518.47, '$', 1, '2025-10-08 13:20:58'),
(22, 1, 1, 1446.90, '$', 10, '2025-10-08 13:22:53'),
(23, 1, 1, 144.69, '$', 1, '2025-10-08 13:22:53'),
(24, 3, 8, 482.28, '$', 4, '2025-10-08 13:32:27'),
(25, 3, 5, 1688.03, '$', 1, '2025-10-08 13:32:27'),
(26, 3, 2, 1555.41, '$', 3, '2025-10-08 13:42:40'),
(27, 3, 2, 518.47, '$', 1, '2025-10-08 13:42:40'),
(28, 3, 1, 144.69, '$', 1, '2025-10-08 13:44:56'),
(29, 3, 6, 1000.76, '$', 1, '2025-10-08 13:44:56'),
(30, 1, 3, 200.00, '', 2, '2025-10-08 20:00:00'),
(31, 1, 3, 8440.20, '$', 10, '2025-10-08 19:06:40'),
(32, 1, 3, 844.02, '$', 1, '2025-10-08 19:06:40'),
(33, 3, 2, 518.47, '$', 1, '2025-10-08 19:12:08'),
(34, 3, 1, 144.69, '$', 1, '2025-10-08 19:12:08'),
(35, 3, 3, 844.02, '$', 1, '2025-10-08 19:12:08'),
(36, 1, 3, 4220.10, '$', 5, '2025-10-09 13:32:35'),
(37, 1, 2, 518.47, '$', 1, '2025-10-09 13:34:25'),
(38, 1, 1, 144.69, '$', 1, '2025-10-09 13:34:25'),
(39, 1, 5, 1688.03, '$', 1, '2025-10-09 13:34:25'),
(40, 1, 3, 844.02, '$', 1, '2025-10-09 20:13:27'),
(41, 1, 2, 518.47, '$', 1, '2025-10-09 20:28:56'),
(42, 1, 1, 144.69, '$', 1, '2025-10-09 20:29:27'),
(43, 1, 5, 1688.03, '$', 1, '2025-10-09 23:33:17'),
(44, 7, 1, 723.45, '$', 5, '2025-10-09 23:54:47'),
(45, 1, 8, 241.14, '$', 2, '2025-11-20 16:22:46'),
(46, 1, 1, 434.07, '$', 3, '2025-11-20 16:22:46'),
(47, 1, 1, 578.76, '$', 4, '2025-11-20 16:22:46'),
(48, 1, 2, 518.47, '$', 1, '2025-11-20 16:40:30'),
(49, 1, 3, 3376.08, '$', 4, '2025-11-20 16:40:30'),
(50, 1, 3, 844.02, '$', 1, '2025-11-20 16:40:30'),
(51, 1, 2, 518.47, '$', 1, '2026-03-08 19:10:45'),
(52, 1, 2, 518.47, '$', 1, '2026-03-08 19:10:45'),
(53, 1, 3, 844.02, '$', 1, '2026-03-08 19:10:45'),
(54, 1, 3, 844.02, '$', 1, '2026-03-08 19:10:45'),
(55, 1, 2, 518.47, '$', 1, '2026-03-08 19:22:03'),
(56, 1, 3, 844.02, '$', 1, '2026-03-08 19:22:04'),
(57, 1, 2, 3110.82, '$', 6, '2026-03-08 19:22:44'),
(58, 1, 2, 518.47, '$', 1, '2026-03-08 19:29:37'),
(59, 1, 3, 844.02, '$', 1, '2026-03-08 19:29:37'),
(60, 1, 3, 2532.06, '$', 3, '2026-03-08 19:29:38');

-- --------------------------------------------------------

--
-- Table structure for table `order_attributes`
--

DROP TABLE IF EXISTS `order_attributes`;
CREATE TABLE IF NOT EXISTS `order_attributes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `orders_id` int NOT NULL,
  `attribute_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`orders_id`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_attributes`
--

INSERT INTO `order_attributes` (`id`, `orders_id`, `attribute_name`, `value`) VALUES
(1, 1, 'Size', 'XL'),
(2, 2, 'Size', '43'),
(3, 3, 'Capacity', '512GB'),
(4, 3, 'With USB 3 ports', 'No'),
(5, 3, 'Touch ID in keyboard', 'No'),
(6, 4, 'Capacity', '256GB'),
(7, 4, 'With USB 3 ports', 'Yes'),
(8, 4, 'Touch ID in keyboard', 'Yes'),
(9, 5, 'Size', '41'),
(10, 6, 'Size', 'L'),
(11, 7, 'Size', 'XL'),
(12, 8, 'Capacity', '512G'),
(13, 8, 'Color', '#030BFF'),
(14, 9, 'Capacity', '512G'),
(15, 9, 'Color', '#030BFF'),
(16, 10, 'Capacity', '512G'),
(17, 10, 'Color', '#03FFF7'),
(18, 11, 'Capacity', '1T'),
(19, 11, 'Color', '#FFFFFF'),
(20, 12, 'Size', '40'),
(21, 13, 'Size', '43'),
(22, 14, 'Capacity', '256GB'),
(23, 14, 'With USB 3 ports', 'Yes'),
(24, 14, 'Touch ID in keyboard', 'No'),
(25, 15, 'Size', '40'),
(26, 17, 'Color', '#44FF03'),
(27, 17, 'Capacity', '512G'),
(28, 18, 'Color', '#000000'),
(29, 18, 'Capacity', '1T'),
(30, 19, 'Color', '#44FF03'),
(31, 19, 'Capacity', '512G'),
(32, 20, 'Color', '#000000'),
(33, 20, 'Capacity', '1T'),
(34, 21, 'Size', 'S'),
(35, 22, 'Size', '40'),
(36, 23, 'Size', '42'),
(37, 25, 'Capacity', '256GB'),
(38, 25, 'With USB 3 ports', 'Yes'),
(39, 25, 'Touch ID in keyboard', 'Yes'),
(40, 26, 'Size', 'S'),
(41, 27, 'Size', 'L'),
(42, 28, 'Size', '40'),
(43, 29, 'Capacity', '512G'),
(44, 29, 'Color', '#44FF03'),
(45, 31, 'Color', '#44FF03'),
(46, 31, 'Capacity', '512G'),
(47, 32, 'Color', '#030BFF'),
(48, 32, 'Capacity', '1T'),
(49, 33, 'Size', 'S'),
(50, 34, 'Size', '40'),
(51, 35, 'Color', '#44FF03'),
(52, 35, 'Capacity', '512G'),
(53, 36, 'Color', '#44FF03'),
(54, 36, 'Capacity', '512G'),
(55, 37, 'Size', 'L'),
(56, 38, 'Size', '42'),
(57, 39, 'Capacity', '512GB'),
(58, 39, 'With USB 3 ports', 'No'),
(59, 39, 'Touch ID in keyboard', 'No'),
(60, 40, 'Color', '#44FF03'),
(61, 40, 'Capacity', '512G'),
(62, 41, 'Size', 'S'),
(63, 42, 'Size', '40'),
(64, 43, 'Capacity', '512GB'),
(65, 43, 'With USB 3 ports', 'No'),
(66, 43, 'Touch ID in keyboard', 'No'),
(67, 44, 'Size', '40'),
(68, 46, 'Size', '42'),
(69, 47, 'Size', '43'),
(70, 48, 'Size', 'S'),
(71, 49, 'Color', '#030BFF'),
(72, 49, 'Capacity', '1T'),
(73, 50, 'Color', '#44FF03'),
(74, 50, 'Capacity', '512G'),
(75, 51, 'Size', 'Small'),
(76, 52, 'Size', 'Extra Large'),
(77, 53, 'Color', 'Green'),
(78, 53, 'Capacity', '512G'),
(79, 54, 'Color', 'Cyan'),
(80, 54, 'Capacity', '1T'),
(81, 55, 'Size', 'Small'),
(82, 56, 'Capacity', '1T'),
(83, 56, 'Color', 'White'),
(84, 57, 'Size', 'Small'),
(85, 58, 'Size', 'Small'),
(86, 59, 'Color', 'Green'),
(87, 59, 'Capacity', '512G'),
(88, 60, 'Color', 'White'),
(89, 60, 'Capacity', '1T');

-- --------------------------------------------------------

--
-- Table structure for table `prices`
--

DROP TABLE IF EXISTS `prices`;
CREATE TABLE IF NOT EXISTS `prices` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `currency_label` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency_symbol` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `prices`
--

INSERT INTO `prices` (`id`, `product_id`, `amount`, `currency_label`, `currency_symbol`) VALUES
(1, 1, 144.69, 'USD', '$'),
(2, 2, 518.47, 'USD', '$'),
(3, 3, 844.02, 'USD', '$'),
(4, 4, 333.99, 'USD', '$'),
(5, 5, 1688.03, 'USD', '$'),
(6, 6, 1000.76, 'USD', '$'),
(7, 7, 300.23, 'USD', '$'),
(8, 8, 120.57, 'USD', '$');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
CREATE TABLE IF NOT EXISTS `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `category` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `brand` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `in_stock` tinyint(1) DEFAULT NULL,
  `code_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `category`, `brand`, `in_stock`, `code_name`) VALUES
(1, 'Nike Air Huarache Le', '<p>Great sneakers for everyday use!</p>', 'clothes', 'Nike x Stussy', 1, 'huarache-x-stussy-le'),
(2, 'Jacket', '<p>Awesome winter jacket</p>', 'clothes', 'Canada Goose', 1, 'jacket-canada-goosee'),
(3, 'PlayStation 5', '<p>A good gaming console. Plays games of PS4! Enjoy if you can buy it mwahahahaha</p>', 'tech', 'Sony', 1, 'ps-5'),
(4, 'Xbox Series S 512GB', '\n<div>\n    <ul>\n        <li><span>Hardware-beschleunigtes Raytracing macht dein Spiel noch realistischer</span></li>\n        <li><span>Spiele Games mit bis zu 120 Bilder pro Sekunde</span></li>\n        <li><span>Minimiere Ladezeiten mit einer speziell entwickelten 512GB NVMe SSD und wechsle mit Quick Resume nahtlos zwischen mehreren Spielen.</span></li>\n        <li><span>Xbox Smart Delivery stellt sicher, dass du die beste Version deines Spiels spielst, egal, auf welcher Konsole du spielst</span></li>\n        <li><span>Spiele deine Xbox One-Spiele auf deiner Xbox Series S weiter. Deine Fortschritte, Erfolge und Freundesliste werden automatisch auf das neue System übertragen.</span></li>\n        <li><span>Erwecke deine Spiele und Filme mit innovativem 3D Raumklang zum Leben</span></li>\n        <li><span>Der brandneue Xbox Wireless Controller zeichnet sich durch höchste Präzision, eine neue Share-Taste und verbesserte Ergonomie aus</span></li>\n        <li><span>Ultra-niedrige Latenz verbessert die Reaktionszeit von Controller zum Fernseher</span></li>\n        <li><span>Verwende dein Xbox One-Gaming-Zubehör -einschließlich Controller, Headsets und mehr</span></li>\n        <li><span>Erweitere deinen Speicher mit der Seagate 1 TB-Erweiterungskarte für Xbox Series X (separat erhältlich) und streame 4K-Videos von Disney+, Netflix, Amazon, Microsoft Movies &amp; TV und mehr</span></li>\n    </ul>\n</div>', 'tech', 'Microsoft', 0, 'xbox-series-s'),
(5, 'iMac 2021', 'The new iMac!', 'tech', 'Apple', 1, 'apple-imac-2021'),
(6, 'iPhone 12 Pro', 'This is iPhone 12. Nothing else to say.', 'tech', 'Apple', 1, 'apple-iphone-12-pro'),
(7, 'AirPods Pro', '\n<h3>Magic like you’ve never heard</h3>\n<p>AirPods Pro have been designed to deliver Active Noise Cancellation for immersive sound, Transparency mode so you can hear your surroundings, and a customizable fit for all-day comfort. Just like AirPods, AirPods Pro connect magically to your iPhone or Apple Watch. And they’re ready to use right out of the case.\n\n<h3>Active Noise Cancellation</h3>\n<p>Incredibly light noise-cancelling headphones, AirPods Pro block out your environment so you can focus on what you’re listening to. AirPods Pro use two microphones, an outward-facing microphone and an inward-facing microphone, to create superior noise cancellation. By continuously adapting to the geometry of your ear and the fit of the ear tips, Active Noise Cancellation silences the world to keep you fully tuned in to your music, podcasts, and calls.\n\n<h3>Transparency mode</h3>\n<p>Switch to Transparency mode and AirPods Pro let the outside sound in, allowing you to hear and connect to your surroundings. Outward- and inward-facing microphones enable AirPods Pro to undo the sound-isolating effect of the silicone tips so things sound and feel natural, like when you’re talking to people around you.</p>\n\n<h3>All-new design</h3>\n<p>AirPods Pro offer a more customizable fit with three sizes of flexible silicone tips to choose from. With an internal taper, they conform to the shape of your ear, securing your AirPods Pro in place and creating an exceptional seal for superior noise cancellation.</p>\n\n<h3>Amazing audio quality</h3>\n<p>A custom-built high-excursion, low-distortion driver delivers powerful bass. A superefficient high dynamic range amplifier produces pure, incredibly clear sound while also extending battery life. And Adaptive EQ automatically tunes music to suit the shape of your ear for a rich, consistent listening experience.</p>\n\n<h3>Even more magical</h3>\n<p>The Apple-designed H1 chip delivers incredibly low audio latency. A force sensor on the stem makes it easy to control music and calls and switch between Active Noise Cancellation and Transparency mode. Announce Messages with Siri gives you the option to have Siri read your messages through your AirPods. And with Audio Sharing, you and a friend can share the same audio stream on two sets of AirPods — so you can play a game, watch a movie, or listen to a song together.</p>\n', 'tech', 'Apple', 0, 'apple-airpods-pro'),
(8, 'AirTag', '\n<h1>Lose your knack for losing things.</h1>\n<p>AirTag is an easy way to keep track of your stuff. Attach one to your keys, slip another one in your backpack. And just like that, they’re on your radar in the Find My app. AirTag has your back.</p>\n', 'tech', 'Apple', 1, 'apple-airtag');

-- --------------------------------------------------------

--
-- Stand-in structure for view `product_listing_view`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `product_listing_view`;
CREATE TABLE IF NOT EXISTS `product_listing_view` (
`product_id` int
,`name` varchar(255)
,`in_stock` tinyint(1)
,`price` decimal(10,2)
,`currency_symbol` varchar(5)
,`image_url` mediumtext
);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `lastname` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `country` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `postal_zip_code` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`,`email`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `lastname`, `username`, `password`, `email`, `country`, `city`, `address`, `postal_zip_code`) VALUES
(1, 'aca', 'aca', 'aca', '$2y$10$jlFnMit2pO4w8u.RCiVlFeBeRe8hGBWbnsdah1ATfFYFzmviOaJI6', 'aca@gmail.com', 'Belgium', 'aca', 'aca', '1234'),
(2, 'Nenad', 'Nenadovic', 'nenad', '$2y$10$hfQQ33ENDCgF/fwe0CfocOkivD3mQrM.bmPgAZSz.87nlkA38fK4q', 'nenad@gmail.com', 'Germany', 'Berlin', 'test ', '123'),
(3, 'Aleksandar', 'Veljkovic', 'Acomir123', '$2y$10$q23TSWc1kcIAywUkR.2Fpu3l8Cw9DNjTsfAPIYpjbfWqWfHdkN7Yu', 'acomir@gmail.com', 'Serbia', 'Belgrade', 'test', '123'),
(4, 'acacaca', 'acacacacaca', 'test', '$2y$10$7AXX3Z6mqKdZmbFTfX7LwuHpZIitzA.6xrBAhAf3TZvyPtjm8EEkK', 'test@gmail.com', 'Belgium', 'asdqw', 'adwq', '123'),
(5, 'testest', 'testest', 'testest2', '$2y$10$jvm4hlhp2jBd82iPIr4nhu3cZCMkqilK/ph9sQg7KyDxdTYzvXZqu', 'testest2@gmail.com', 'Belgium', 'testest', 'testest2', '1234'),
(6, 'acacsacwdqasd', 'sadqwdwqadsdqwd', 'asdqwdqwdqwqwdas', '$2y$10$4AMY6zUbNreUD5y5QtHGG.1znc3kZxInbbM4cTvgsob/Ap/fgXIvK', 'cc@gmai.com', 'Barbados', 'asdqwdas', 'asdqwdwdqwasd', '123'),
(7, 'asdqwd', 'asdqwdqwas', 'wqasdqwd', '$2y$10$K0UFjSTAgaLuGOF7SHNUL.QpAqJmTl/YrxiZbLpILMxdSYnRLiq.y', 'dwdw@gmail.com', 'Belarus', 'asdqwdq', 'asdqwdqw', '33333'),
(8, 'sadwqdasdwq', 'asdqwqwdasdwq', 'nikola', '$2y$10$ERjtqzMu6m/715I5BsOrWeduMQa98cRh40D/hR/Z5jPCjF3mjckhq', 'dada@gmail.com', 'Benin', 'dasdad', 'swdas', '1234');

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_product_attributes`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `view_product_attributes`;
CREATE TABLE IF NOT EXISTS `view_product_attributes` (
`product_id` int
,`name` varchar(255)
,`price` decimal(10,2)
,`currency_symbol` varchar(5)
,`attribute_name` varchar(255)
,`value` varchar(255)
,`image_url` text
);

-- --------------------------------------------------------

--
-- Structure for view `full_product`
--
DROP TABLE IF EXISTS `full_product`;

DROP VIEW IF EXISTS `full_product`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `full_product`  AS SELECT `p`.`id` AS `product_id`, `p`.`name` AS `name`, `p`.`in_stock` AS `in_stock`, `pr`.`amount` AS `price`, `pr`.`currency_symbol` AS `currency_symbol`, `a`.`attribute_name` AS `attribute_name`, `av`.`display_value` AS `value`, `g`.`image_url` AS `image_url`, `p`.`description` AS `description` FROM ((((`products` `p` left join `prices` `pr` on((`p`.`id` = `pr`.`product_id`))) left join `attributes` `a` on((`p`.`id` = `a`.`product_id`))) left join `attribute_values` `av` on((`a`.`id` = `av`.`attribute_id`))) left join `gallery` `g` on((`p`.`id` = `g`.`product_id`))) ;

-- --------------------------------------------------------

--
-- Structure for view `product_listing_view`
--
DROP TABLE IF EXISTS `product_listing_view`;

DROP VIEW IF EXISTS `product_listing_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `product_listing_view`  AS SELECT `p`.`id` AS `product_id`, `p`.`name` AS `name`, `p`.`in_stock` AS `in_stock`, `pr`.`amount` AS `price`, `pr`.`currency_symbol` AS `currency_symbol`, (select `g`.`image_url` from `gallery` `g` where (`g`.`product_id` = `p`.`id`) limit 1) AS `image_url` FROM (`products` `p` left join `prices` `pr` on((`pr`.`product_id` = `p`.`id`))) ;

-- --------------------------------------------------------

--
-- Structure for view `view_product_attributes`
--
DROP TABLE IF EXISTS `view_product_attributes`;

DROP VIEW IF EXISTS `view_product_attributes`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_product_attributes`  AS SELECT `p`.`id` AS `product_id`, `p`.`name` AS `name`, `pr`.`amount` AS `price`, `pr`.`currency_symbol` AS `currency_symbol`, `a`.`attribute_name` AS `attribute_name`, `av`.`value` AS `value`, `g`.`image_url` AS `image_url` FROM ((((`products` `p` left join `prices` `pr` on((`p`.`id` = `pr`.`product_id`))) left join `attributes` `a` on((`p`.`id` = `a`.`product_id`))) left join `attribute_values` `av` on((`a`.`id` = `av`.`attribute_id`))) left join `gallery` `g` on((`p`.`id` = `g`.`product_id`))) ;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `attributes`
--
ALTER TABLE `attributes`
  ADD CONSTRAINT `attributes_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `attribute_values`
--
ALTER TABLE `attribute_values`
  ADD CONSTRAINT `attribute_values_ibfk_1` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`);

--
-- Constraints for table `gallery`
--
ALTER TABLE `gallery`
  ADD CONSTRAINT `gallery_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `order_attributes`
--
ALTER TABLE `order_attributes`
  ADD CONSTRAINT `order_attributes_ibfk_1` FOREIGN KEY (`orders_id`) REFERENCES `orders` (`id`);

--
-- Constraints for table `prices`
--
ALTER TABLE `prices`
  ADD CONSTRAINT `prices_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
