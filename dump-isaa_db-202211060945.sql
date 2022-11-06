-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: localhost    Database: isaa_db
-- ------------------------------------------------------
-- Server version	8.0.26

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
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts` (
  `acc_no` int NOT NULL,
  `password` varchar(50) NOT NULL,
  `balance` float DEFAULT NULL,
  PRIMARY KEY (`acc_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES (1000,'aaditya',1000),(1001,'akil',872),(1002,'bimal',1430),(1004,'anmol',8900);
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `transaction_id` varchar(36) NOT NULL,
  `from_acc_no` int NOT NULL,
  `to_acc_no` int NOT NULL,
  `amount` float DEFAULT NULL,
  `time_stamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `fk_sender` (`from_acc_no`),
  KEY `fk_receiver` (`to_acc_no`),
  CONSTRAINT `fk_receiver` FOREIGN KEY (`to_acc_no`) REFERENCES `accounts` (`acc_no`),
  CONSTRAINT `fk_sender` FOREIGN KEY (`from_acc_no`) REFERENCES `accounts` (`acc_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` VALUES ('8128ae31-fe32-4db4-85d0-c4526690b1a1',1000,1001,20,'2022-11-03 17:04:50'),('f3c96879-9c89-4f73-aafa-1a5af7b5024e',1000,1001,1,'2022-11-03 18:06:58'),('067c0e2c-00b2-47e7-a0df-714f06c36ab3',1000,1002,30,'2022-11-04 06:41:25'),('1dc12891-7eff-4a1d-bb7c-99da14b269e5',1000,1001,20,'2022-11-04 08:59:34'),('88385d48-933e-4aee-953b-49a8eceee08a',1000,1001,5,'2022-11-06 03:35:03'),('ddd55d0c-8921-4ac1-9d43-015b90154dc1',1000,1001,20,'2022-11-06 03:41:15'),('e88ae3e2-9317-4fc3-b0bb-dce55dd1bae0',1000,1001,5,'2022-11-06 03:42:17'),('bff329d8-0f7e-45e2-a16b-da25fcd4346a',1000,1001,1,'2022-11-06 03:43:57'),('3533db10-67c3-4c4a-8671-568144b8bb8c',1000,1002,100,'2022-11-06 03:44:11'),('c8e7b5f1-4229-4221-b774-d2b9d99889cb',1000,1002,100,'2022-11-06 03:45:41'),('400e943e-ea45-4f5b-a463-dd6c23d3e8ce',1000,1002,100,'2022-11-06 03:46:14'),('fa510396-7c1e-4b25-b546-866f53e1003a',1000,1002,100,'2022-11-06 03:47:02'),('dfbfa640-d47f-4c51-89a1-dbd2a2d8f1c9',1000,1002,100,'2022-11-06 03:47:28'),('62119d76-35ec-493b-8436-a4272db8aea2',1000,1002,100,'2022-11-06 03:47:38'),('767ab989-9ac6-4d14-b477-28a43b0f4573',1000,1002,100,'2022-11-06 03:55:33'),('fc8c8ed5-292c-42a5-be0d-a0d58c68d54d',1000,1002,100,'2022-11-06 03:57:52'),('3bd7d585-5dfd-4d1c-8206-0486f1cf7280',1004,1002,100,'2022-11-06 03:59:33');
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('admin','123'),('user1','pass1'),('user2','pass2'),('user3','pass3');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'isaa_db'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-11-06  9:45:26
