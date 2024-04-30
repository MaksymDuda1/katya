-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: moviesguide
-- ------------------------------------------------------
-- Server version	8.0.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `image`
--

DROP TABLE IF EXISTS `image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `image` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Path` varchar(50) NOT NULL,
  `Movie_id` int DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `Movie_id` (`Movie_id`),
  CONSTRAINT `image_ibfk_1` FOREIGN KEY (`Movie_id`) REFERENCES `movie` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image`
--

LOCK TABLES `image` WRITE;
/*!40000 ALTER TABLE `image` DISABLE KEYS */;
INSERT INTO `image` VALUES (5,'kb1.jpg',15),(6,'kb2.jpg',15),(7,'kb3.jpg',15),(8,'kb4.jpg',15),(9,'ic1.jpg',14),(10,'ic2.jpg',14),(11,'ic3.jpg',14),(12,'ic3.jpg',14),(13,'ic4.jpg',14),(14,'cm1.jpg',13),(15,'cm2.jpg',13),(16,'cm3.jpg',13),(17,'cm4.jpg',13),(18,'mp1.jpg',12),(19,'mp2.jpg',12),(20,'mp3.jpg',12),(21,'mp4.jpg',12),(22,'v4.jpg',11),(23,'v3.jpg',11),(24,'v2.jpg',11),(25,'v1.jpg',11),(26,'ld1.jpg',10),(27,'ld2.jpg',10),(28,'ld3.jpg',10),(29,'ld4.jpg',10),(32,'dd1.jpg',8),(33,'dd2.jpg',8),(34,'dd3.jpg',8),(35,'dd4.jpg',8),(36,'o1.jpg',6),(37,'o2.jpg',6),(38,'o3.jpg',6),(39,'o4.jpg',6),(44,'d1.jpg',18),(45,'d2.jpg',18),(46,'d3.jpg',18),(47,'d4.jpg',18);
/*!40000 ALTER TABLE `image` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-30 21:48:00
