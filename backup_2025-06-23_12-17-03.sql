-- MySQL dump 10.13  Distrib 8.0.42, for Linux (x86_64)
--
-- Host: localhost    Database: cargo_camp
-- ------------------------------------------------------
-- Server version	8.0.42

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (12,'Такси','2025-05-14 23:06:04','2025-05-14 23:06:04'),(13,'Курьер','2025-05-14 23:06:04','2025-05-14 23:06:04'),(14,'Грузоперевозки','2025-05-16 20:53:32','2025-05-16 20:53:32'),(15,'Уборка и клиннинг','2025-05-16 20:53:32','2025-05-16 20:53:32'),(16,'Ремонт и строительство','2025-05-16 20:53:32','2025-05-16 20:53:32'),(17,'Электронные и IT-услуги','2025-05-16 20:53:32','2025-05-16 20:53:32'),(18,'Специалисты с узкими навыками','2025-05-16 20:53:32','2025-05-16 20:53:32'),(19,'Фото и видео','2025-05-16 20:53:32','2025-05-16 20:53:32'),(20,'Рабочий персонал','2025-05-16 20:53:32','2025-05-16 20:53:32'),(21,'Автоуслуги','2025-05-16 20:53:32','2025-05-16 20:53:32'),(22,'Бухгалтерия и юридические услуги','2025-05-16 20:53:32','2025-05-16 20:53:32'),(23,'Дистанционная помощь','2025-05-16 21:59:44','2025-05-16 21:59:44');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  `senderId` int NOT NULL,
  `receiverId` int NOT NULL,
  `orderId` int NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `senderId` (`senderId`),
  KEY `receiverId` (`receiverId`),
  CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`senderId`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`receiverId`) REFERENCES `users` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `type` enum('new_message') NOT NULL,
  `messageId` int NOT NULL,
  `orderId` int NOT NULL,
  `isRead` tinyint(1) DEFAULT '0',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  KEY `messageId` (`messageId`),
  KEY `orderId` (`orderId`),
  CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`id`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `notifications_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `notifications_ibfk_3` FOREIGN KEY (`messageId`) REFERENCES `messages` (`id`) ON DELETE CASCADE,
  CONSTRAINT `notifications_ibfk_4` FOREIGN KEY (`orderId`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `address` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `workTime` datetime DEFAULT NULL,
  `proposedSum` int DEFAULT NULL,
  `coordinates` varchar(255) DEFAULT NULL,
  `userId` int NOT NULL,
  `status` enum('pending','active','completed','expired','pending_payment') DEFAULT 'pending',
  `executorId` int DEFAULT NULL,
  `creatorId` int NOT NULL,
  `completedBy` json NOT NULL,
  `images` text,
  `completedAt` datetime DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `categoryId` int NOT NULL,
  `subcategoryId` int DEFAULT NULL,
  `requestedExecutors` json NOT NULL,
  `paymentStatus` enum('paid','pending','unpaid') DEFAULT 'pending',
  `paymentType` enum('cash','guarantee','installment') NOT NULL,
  `requests` json DEFAULT NULL,
  `contractPath` varchar(255) DEFAULT NULL,
  `is_highlighted` tinyint(1) DEFAULT '0',
  `is_recommended` tinyint(1) DEFAULT '0',
  `is_push_notified` tinyint(1) DEFAULT '0',
  `taxi_courier` tinyint(1) DEFAULT '0',
  `serviceId` int DEFAULT NULL,
  `promotionCost` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  KEY `executorId` (`executorId`),
  KEY `creatorId` (`creatorId`),
  KEY `categoryId` (`categoryId`),
  KEY `subcategoryId` (`subcategoryId`),
  KEY `serviceId` (`serviceId`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`executorId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `orders_ibfk_4` FOREIGN KEY (`categoryId`) REFERENCES `category` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `orders_ibfk_5` FOREIGN KEY (`subcategoryId`) REFERENCES `subcategory` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `orders_ibfk_6` FOREIGN KEY (`serviceId`) REFERENCES `services` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'балакаклавская стрит  → проспект непобедимых ','ке',NULL,2500,'51.1249,-2.728992',2,'expired',NULL,2,'[]',NULL,NULL,'2025-06-17 08:13:31',12,67,'[]','pending','cash','[]',NULL,0,0,0,1,NULL,0),(2,'село Мирное','Сосат','2025-06-19 05:45:00',6666,'44.97943,34.065229',1,'expired',NULL,1,'[]','[\"/uploads/orders/1750308453128\"]',NULL,'2025-06-19 04:47:33',16,169,'[]','pending','cash','[]',NULL,0,0,0,0,4,0),(3,'село Мирное','ыва','2025-06-21 07:00:00',123,'44.97943,34.065229',1,'expired',NULL,1,'[]','[\"/uploads/orders/1750488370628\"]',NULL,'2025-06-21 06:46:10',15,87,'[]','pending','cash','[]',NULL,0,0,0,0,NULL,0),(4,'село Мирное','Hdhdh','2025-06-22 18:30:00',500,'44.97943,34.065229',1,'pending',NULL,1,'[]','[\"/uploads/orders/1750616832742\"]',NULL,'2025-06-22 18:27:12',14,76,'[]','pending','cash','[]',NULL,0,0,0,0,NULL,0);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `services` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `price` int DEFAULT NULL,
  `subcategoryId` int NOT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `subcategoryId` (`subcategoryId`),
  CONSTRAINT `services_ibfk_1` FOREIGN KEY (`subcategoryId`) REFERENCES `subcategory` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES (1,'Сборка мебели (1 час)',500,169,'2025-05-16 22:24:05','2025-05-16 22:24:05'),(2,'Установка карнизов/полок',300,169,'2025-05-16 22:24:05','2025-05-16 22:24:05'),(3,'Вскрытие замков',400,169,'2025-05-16 22:24:05','2025-05-16 22:24:05'),(4,'Покраска (1 квадрат)',400,169,'2025-05-16 22:24:05','2025-05-16 22:24:05'),(5,'Изготовление ворот/решеток',5000,170,'2025-05-16 22:27:48','2025-05-16 22:27:48'),(6,'Сварочные работы (1 час)',800,170,'2025-05-16 22:27:48','2025-05-16 22:27:48'),(7,'Плотницкие работы (1 час)',600,170,'2025-05-16 22:27:48','2025-05-16 22:27:48'),(8,'Ремонт мебели из дерева',700,170,'2025-05-16 22:27:48','2025-05-16 22:27:48'),(9,'Изготовление ферм',800,170,'2025-05-16 22:27:48','2025-05-16 22:27:48'),(10,'Демонтаж перегородок/мебели',1000,171,'2025-05-16 22:31:16','2025-05-16 22:31:16'),(11,'Монтаж натяжных потолков',600,171,'2025-05-16 22:31:16','2025-05-16 22:31:16'),(12,'Установка кондиционеров',3500,171,'2025-05-16 22:31:16','2025-05-16 22:31:16'),(13,'ГКЛ перегородки (1 квадрат)',400,171,'2025-05-16 22:31:16','2025-05-16 22:31:16'),(14,'Демонтаж кирпича (1 квадрат)',800,171,'2025-05-16 22:31:16','2025-05-16 22:31:16'),(15,'Демонтаж железобетона (1 квадрат)',5400,171,'2025-05-16 22:31:16','2025-05-16 22:31:16'),(16,'Демонтаж стяжки (1 квадрат)',500,171,'2025-05-16 22:31:16','2025-05-16 22:31:16'),(17,'Демонтаж обой (1 квадрат)',240,171,'2025-05-16 22:31:16','2025-05-16 22:31:16'),(18,'Экскаватор (1 час)',2000,172,'2025-05-16 22:32:59','2025-05-16 22:32:59'),(19,'Автовышка (1 час)',1800,172,'2025-05-16 22:32:59','2025-05-16 22:32:59'),(20,'Аренда бетономешалки/генератора (сутки)',1000,172,'2025-05-16 22:32:59','2025-05-16 22:32:59'),(21,'Капитальный ремонт под ключ (1 квадрат)',8000,173,'2025-05-16 22:45:19','2025-05-16 22:45:19'),(22,'Укладка плитки (1 квадрат)',1200,173,'2025-05-16 22:45:19','2025-05-16 22:45:19'),(23,'Поклейка обоев (1 квадрат)',250,173,'2025-05-16 22:45:19','2025-05-16 22:45:19'),(24,'Кладка кирпича (1 шт)',24,173,'2025-05-16 22:45:19','2025-05-16 22:45:19'),(25,'Кладка газобетона (100мм, 1 квадрат)',1000,173,'2025-05-16 22:45:19','2025-05-16 22:45:19'),(26,'Монолитные стены (1 квадрат)',8000,173,'2025-05-16 22:45:19','2025-05-16 22:45:19'),(27,'Заливка фундамента (1 куб)',7250,173,'2025-05-16 22:45:19','2025-05-16 22:45:19'),(28,'Земляные работы (1 куб)',800,173,'2025-05-16 22:45:19','2025-05-16 22:45:19'),(29,'Мусорный контейнер (8 кубов)',19200,173,'2025-05-16 22:45:19','2025-05-16 22:45:19'),(30,'Покраска потолка (1 квадрат)',150,173,'2025-05-16 22:45:19','2025-05-16 22:45:19'),(31,'Шпаклевка потолка)',250,173,'2025-05-16 22:45:19','2025-05-16 22:45:19'),(32,'Стяжка пола (1 квадрат)',350,173,'2025-05-16 22:45:19','2025-05-16 22:45:19'),(33,'Ламинат (1 квадрат)',170,173,'2025-05-16 22:45:19','2025-05-16 22:45:19'),(34,'Перегородки ГКЛ',1250,173,'2025-05-16 22:45:19','2025-05-16 22:45:19'),(35,'Замена смесителя',1000,174,'2025-05-16 22:48:54','2025-05-16 22:48:54'),(36,'Сантехническая точка',2000,174,'2025-05-16 22:48:54','2025-05-16 22:48:54'),(37,'Унитаз',2000,174,'2025-05-16 22:48:54','2025-05-16 22:48:54'),(38,'Ванна',2000,174,'2025-05-16 22:48:54','2025-05-16 22:48:54'),(39,'Душевая кабина',2000,174,'2025-05-16 22:48:54','2025-05-16 22:48:54'),(40,'Полотенцесушитель',1200,174,'2025-05-16 22:48:54','2025-05-16 22:48:54'),(41,'Прокладка труб',1500,174,'2025-05-16 22:48:54','2025-05-16 22:48:54'),(42,'Пайка труб (1 стык)',300,174,'2025-05-16 22:48:54','2025-05-16 22:48:54'),(43,'Воздуховоды (1 метр)',150,176,'2025-05-16 22:50:12','2025-05-16 22:50:12'),(44,'Системы кондиционирования',4000,176,'2025-05-16 22:50:12','2025-05-16 22:50:12'),(45,'Почасово',500,177,'2025-05-16 22:51:29','2025-05-16 22:51:29'),(46,'Дневная ставка',4000,177,'2025-05-16 22:51:29','2025-05-16 22:51:29'),(47,'Электромонтажные работы (точка)',500,179,'2025-05-16 22:52:51','2025-05-16 22:52:51'),(48,'Розеткивыключатели',650,179,'2025-05-16 22:52:51','2025-05-16 22:52:51'),(49,'Заливка и кладка бетона миксером',7000,178,'2025-05-16 22:55:15','2025-05-16 22:55:15'),(50,'Заливка и кладка бетона вручную',9000,178,'2025-05-16 22:55:15','2025-05-16 22:55:15'),(51,'Монолитный фундамент (плита)',9000,178,'2025-05-16 22:55:15','2025-05-16 22:55:15'),(52,'Монолитные площадки (толщина от 0,2м)',3500,178,'2025-05-16 22:55:15','2025-05-16 22:55:15'),(53,'Вязка арматуных каркасов',1500,178,'2025-05-16 22:55:15','2025-05-16 22:55:15'),(54,'Лестничные марши',3500,178,'2025-05-16 22:55:15','2025-05-16 22:55:15'),(55,'Монолитные подпорные стены',7000,178,'2025-05-16 22:55:15','2025-05-16 22:55:15'),(56,'Монолитные чаши для бассейнов',17000,178,'2025-05-16 22:55:15','2025-05-16 22:55:15');
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subcategory`
--

DROP TABLE IF EXISTS `subcategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subcategory` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `categoryId` int NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `price` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `categoryId` (`categoryId`),
  CONSTRAINT `subcategory_ibfk_1` FOREIGN KEY (`categoryId`) REFERENCES `category` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=180 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subcategory`
--

LOCK TABLES `subcategory` WRITE;
/*!40000 ALTER TABLE `subcategory` DISABLE KEYS */;
INSERT INTO `subcategory` VALUES (67,'Перевозка пассажиров',12,'2025-05-14 23:18:02','2025-05-14 23:18:02',NULL),(68,'Перевозка детей',12,'2025-05-14 23:18:09','2025-05-14 23:18:09',NULL),(69,'Перевозка животных',12,'2025-05-14 23:18:17','2025-05-14 23:18:17',NULL),(70,'Перевозка между городами',12,'2025-05-14 23:18:23','2025-05-14 23:18:23',NULL),(71,'Доставка цветов',13,'2025-05-14 23:19:20','2025-05-14 23:19:20',NULL),(72,'Доставка еды/продуктов',13,'2025-05-14 23:19:57','2025-05-14 23:19:57',400),(73,'Доставка документов',13,'2025-05-14 23:20:18','2025-05-14 23:20:18',NULL),(74,'Квартирный переезд',14,'2025-05-16 21:10:03','2025-05-16 21:10:03',2000),(75,'Вывоз строительного мусора (ходка)',14,'2025-05-16 21:20:58','2025-05-16 21:20:58',1500),(76,'Доставка мебели/техники',14,'2025-05-16 21:20:58','2025-05-16 21:20:58',500),(77,'Газель по городу (1 час)',14,'2025-05-16 21:20:58','2025-05-16 21:20:58',800),(78,'Газель межгород (за км)',14,'2025-05-16 21:20:58','2025-05-16 21:20:58',30),(79,'Грузчик (1 час)',14,'2025-05-16 21:20:58','2025-05-16 21:20:58',500),(80,'Упаковка вещей (1 час)',14,'2025-05-16 21:20:58','2025-05-16 21:20:58',500),(81,'Разборка-сборка мебели (1 час)',14,'2025-05-16 21:20:58','2025-05-16 21:20:58',800),(82,'Маркировка и инвентаризация имущества (1 час)',14,'2025-05-16 21:20:58','2025-05-16 21:20:58',1000),(83,'Перевозка спецтехники (за км)',14,'2025-05-16 21:20:58','2025-05-16 21:20:58',40),(84,'Перевозка с/х животных (за км)',14,'2025-05-16 21:20:58','2025-05-16 21:20:58',70),(85,'Генеральная уборка квартиры (за 1 квадрат)',15,'2025-05-16 21:26:27','2025-05-16 21:26:27',60),(86,'Уборка после ремонта',15,'2025-05-16 21:26:27','2025-05-16 21:26:27',4000),(87,'Мойка окон (1 окно)',15,'2025-05-16 21:26:27','2025-05-16 21:26:27',300),(88,'Чистка ковров',15,'2025-05-16 21:26:27','2025-05-16 21:26:27',500),(89,'Поддерживающая уборка (за квадрат)',15,'2025-05-16 21:26:27','2025-05-16 21:26:27',35),(90,'Уборка территории (за квадрат)',15,'2025-05-16 21:26:27','2025-05-16 21:26:27',40),(91,'Уборка офиса (за квадрат)',15,'2025-05-16 21:26:27','2025-05-16 21:26:27',60),(92,'Химчистка мебели (за еденицу)',15,'2025-05-16 21:26:27','2025-05-16 21:26:27',3000),(93,'Настройка Windows',17,'2025-05-16 21:30:34','2025-05-16 21:30:34',1000),(94,'Установка программ',17,'2025-05-16 21:30:34','2025-05-16 21:30:34',300),(95,'Удаление вирусов',17,'2025-05-16 21:30:34','2025-05-16 21:30:34',500),(96,'Настройка роутера',17,'2025-05-16 21:30:34','2025-05-16 21:30:34',800),(97,'Ремонт компьютера и ноутбука',17,'2025-05-16 21:30:34','2025-05-16 21:30:34',2000),(98,'Создание сайта и разработка ПО',17,'2025-05-16 21:30:34','2025-05-16 21:30:34',15000),(99,'Ремонт экрана телефона',17,'2025-05-16 21:30:34','2025-05-16 21:30:34',3000),(100,'Замена аккумулятора телефона',17,'2025-05-16 21:30:34','2025-05-16 21:30:34',1500),(101,'Замена разъема зарядки телефона',17,'2025-05-16 21:30:34','2025-05-16 21:30:34',900),(102,'Ремонт после влаги',17,'2025-05-16 21:30:34','2025-05-16 21:30:34',2500),(103,'Топоплан',18,'2025-05-16 21:35:43','2025-05-16 21:35:43',7000),(104,'Геоплан участка',18,'2025-05-16 21:35:43','2025-05-16 21:35:43',8000),(105,'Сопровождение строительства (в месяц)',18,'2025-05-16 21:35:43','2025-05-16 21:35:43',100000),(106,'Геоизыскания',18,'2025-05-16 21:35:43','2025-05-16 21:35:43',35000),(107,'Дизайн интерьера (за квадрат)',18,'2025-05-16 21:35:43','2025-05-16 21:35:43',800),(108,'Ландшафтный дизайн',18,'2025-05-16 21:35:43','2025-05-16 21:35:43',3000),(109,'3D-моделирование',18,'2025-05-16 21:35:43','2025-05-16 21:35:43',1500),(110,'Чертежи для строительства',18,'2025-05-16 21:35:43','2025-05-16 21:35:43',2000),(111,'Виртуальный помошник (1 час)',18,'2025-05-16 21:35:43','2025-05-16 21:35:43',400),(112,'Инженер строитель',18,'2025-05-16 21:35:43','2025-05-16 21:35:43',3000),(113,'Оценщик имущества',18,'2025-05-16 21:35:43','2025-05-16 21:35:43',3000),(114,'Почасовая фотосъемка',19,'2025-05-16 21:39:50','2025-05-16 21:39:50',4000),(115,'Экспресс фотосессия',19,'2025-05-16 21:39:50','2025-05-16 21:39:50',2000),(116,'Свадебная фотосессия (14 часов)',19,'2025-05-16 21:39:50','2025-05-16 21:39:50',48000),(117,'Видеосъемка свадьбы (8 часов)',19,'2025-05-16 21:39:50','2025-05-16 21:39:50',40000),(118,'Мероприятие (1 час)',19,'2025-05-16 21:39:50','2025-05-16 21:39:50',3000),(119,'Монтаж видео (минута)',19,'2025-05-16 21:39:50','2025-05-16 21:39:50',300),(120,'Ведущий/тамада (вечер)',19,'2025-05-16 21:39:50','2025-05-16 21:39:50',5000),(121,'Прокат звука и света',19,'2025-05-16 21:39:50','2025-05-16 21:39:50',3000),(122,'Оформление шарами/декором',19,'2025-05-16 21:39:50','2025-05-16 21:39:50',2500),(123,'Аниматоры для детей (1 час)',19,'2025-05-16 21:39:50','2025-05-16 21:39:50',1500),(124,'Косить траву (сотка)',20,'2025-05-16 21:46:07','2025-05-16 21:46:07',300),(125,'Вспашка мотоблоком (сотка)',20,'2025-05-16 21:46:07','2025-05-16 21:46:07',400),(126,'Убрка урожая (1 час)',20,'2025-05-16 21:46:07','2025-05-16 21:46:07',500),(127,'Посадка/пересадка деревьев',20,'2025-05-16 21:46:07','2025-05-16 21:46:07',700),(128,'Домработница (1 час)',20,'2025-05-16 21:46:07','2025-05-16 21:46:07',400),(129,'Садовник (1 день)',20,'2025-05-16 21:46:07','2025-05-16 21:46:07',1500),(130,'Управляющий на участок',20,'2025-05-16 21:46:07','2025-05-16 21:46:07',2000),(131,'Няня (1 час)',20,'2025-05-16 21:46:07','2025-05-16 21:46:07',300),(132,'Сиделка (сутки)',20,'2025-05-16 21:46:07','2025-05-16 21:46:07',2500),(133,'Присмотр за пожилым человеком (1 час)',20,'2025-05-16 21:46:07','2025-05-16 21:46:07',400),(134,'Передержка (сутки)',20,'2025-05-16 21:46:07','2025-05-16 21:46:07',500),(135,'Выгул собаки (1 час)',20,'2025-05-16 21:46:07','2025-05-16 21:46:07',300),(136,'Стрижка животных',20,'2025-05-16 21:46:07','2025-05-16 21:46:07',1000),(137,'Репетиторство (1 час)',20,'2025-05-16 21:46:07','2025-05-16 21:46:07',600),(138,'Обучение компьютеру',20,'2025-05-16 21:46:07','2025-05-16 21:46:07',500),(139,'Языковые курсы',20,'2025-05-16 21:46:07','2025-05-16 21:46:07',700),(140,'Физическая охрана (смена)',20,'2025-05-16 21:46:07','2025-05-16 21:46:07',2500),(141,'Установка видеонаблюдения',20,'2025-05-16 21:46:07','2025-05-16 21:46:07',3000),(142,'Мелкий ремонт авто',21,'2025-05-16 21:48:20','2025-05-16 21:48:20',1000),(143,'Эвакуатор',21,'2025-05-16 21:48:20','2025-05-16 21:48:20',2000),(144,'Мойка авто',21,'2025-05-16 21:48:20','2025-05-16 21:48:20',500),(145,'Диагностика авто',21,'2025-05-16 21:48:20','2025-05-16 21:48:20',1000),(146,'Автоэлектрик',21,'2025-05-16 21:48:20','2025-05-16 21:48:20',1000),(147,'Тонировка/шумоизоляция',21,'2025-05-16 21:48:20','2025-05-16 21:48:20',1000),(148,'Замена масла и фильтров',21,'2025-05-16 21:48:20','2025-05-16 21:48:20',1000),(149,'Шиномонтаж',21,'2025-05-16 21:48:20','2025-05-16 21:48:20',500),(150,'Бухгалтерия (ИП, УСН) (в месяц)',22,'2025-05-16 21:58:31','2025-05-16 21:58:31',3500),(151,'Бухгалтерия (ООО, УСН) (в месяц)',22,'2025-05-16 21:58:31','2025-05-16 21:58:31',6000),(152,'Бухгалтерия (ИП, ОСНО) (в месяц)',22,'2025-05-16 21:58:31','2025-05-16 21:58:31',7000),(153,'Бухгалтерия (ООО, ОСНО) (в месяц)',22,'2025-05-16 21:58:31','2025-05-16 21:58:31',8500),(154,'Разовая отчетность',22,'2025-05-16 21:58:31','2025-05-16 21:58:31',500),(155,'Консультация юриста',22,'2025-05-16 21:58:31','2025-05-16 21:58:31',1000),(156,'Исковое заявление',22,'2025-05-16 21:58:31','2025-05-16 21:58:31',3000),(157,'Представительство в суде',22,'2025-05-16 21:58:31','2025-05-16 21:58:31',10000),(158,'Сопровождение сделок',22,'2025-05-16 21:58:31','2025-05-16 21:58:31',15000),(159,'Доверенность (нотариус)',22,'2025-05-16 21:58:31','2025-05-16 21:58:31',1000),(160,'Договор купли-продажи',22,'2025-05-16 21:58:31','2025-05-16 21:58:31',5000),(161,'Завещание',22,'2025-05-16 21:58:31','2025-05-16 21:58:31',2000),(162,'Перевод (1 страница)',23,'2025-05-16 22:02:04','2025-05-16 22:02:04',300),(163,'Копирайтинг (1000 знаков)',23,'2025-05-16 22:02:04','2025-05-16 22:02:04',500),(164,'Редактирование документов',23,'2025-05-16 22:02:04','2025-05-16 22:02:04',400),(165,'Составление резюме/петиции',23,'2025-05-16 22:02:04','2025-05-16 22:02:04',700),(166,'Телемаркетинг (1 час)',23,'2025-05-16 22:02:04','2025-05-16 22:02:04',400),(167,'Анкетирование по телефону',23,'2025-05-16 22:02:04','2025-05-16 22:02:04',300),(168,'Сбор отзывов от клиентов',23,'2025-05-16 22:02:04','2025-05-16 22:02:04',500),(169,'Мелкий бытовой ремонт',16,'2025-05-16 22:15:38','2025-05-16 22:15:38',NULL),(170,'Работы по металлу и дереву',16,'2025-05-16 22:15:38','2025-05-16 22:15:38',NULL),(171,'Монтаж и демонтаж',16,'2025-05-16 22:15:38','2025-05-16 22:15:38',NULL),(172,'Спецтехника и аренда',16,'2025-05-16 22:15:38','2025-05-16 22:15:38',NULL),(173,'Строительство и отделочные работы',16,'2025-05-16 22:15:38','2025-05-16 22:15:38',NULL),(174,'Сантехнические работы',16,'2025-05-16 22:15:38','2025-05-16 22:15:38',NULL),(176,'Вентиляция и кондиционеры',16,'2025-05-16 22:15:38','2025-05-16 22:15:38',NULL),(177,'Разнорабочие',16,'2025-05-16 22:15:38','2025-05-16 22:15:38',NULL),(178,'Бетонные работы',16,'2025-05-16 22:15:38','2025-05-16 22:15:38',NULL),(179,'Электрические работы',16,'2025-05-16 22:15:38','2025-05-16 22:15:38',NULL);
/*!40000 ALTER TABLE `subcategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `rating` float DEFAULT '0',
  `ratingCount` int DEFAULT '0',
  `complaintsCount` int DEFAULT '0',
  `complaints` json DEFAULT NULL,
  `documentPhotos` json DEFAULT NULL,
  `role` enum('user','admin','banned') DEFAULT 'user',
  `userStatus` varchar(255) NOT NULL DEFAULT 'unverified',
  `cardNumber` varchar(255) DEFAULT NULL,
  `cardLastFour` varchar(4) DEFAULT NULL,
  `cardType` varchar(255) DEFAULT NULL,
  `RebillId` varchar(255) DEFAULT NULL,
  `subscription_type` enum('standard','premium') NOT NULL DEFAULT 'standard',
  `subscription_expires_at` datetime DEFAULT NULL,
  `has_debt` tinyint(1) NOT NULL DEFAULT '0',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Akim','+7 (978) 686-41-18','$2b$10$FrPJb3aajehUslWpPG918u6VHIngd3Y4aXrxsx6ZBeea/RYvx.vbu',0,0,0,'[]','[]','user','unverified',NULL,NULL,NULL,NULL,'standard',NULL,0,'2025-06-14 07:38:01','2025-06-22 18:26:36'),(2,'emir','+7 (978) 080-16-37','$2b$10$T5KcvkW3/phKubrYf1J0CuMdkSMv99iYqjdT5T/8BePKVx7ZA23eS',0,0,0,'[]','[]','user','unverified',NULL,NULL,NULL,NULL,'premium','2025-06-24 08:12:51',0,'2025-06-17 08:12:52','2025-06-17 08:12:52');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-23 12:17:03
