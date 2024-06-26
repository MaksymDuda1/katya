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
-- Table structure for table `director`
--

DROP TABLE IF EXISTS `director`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `director` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `fullname` varchar(100) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `director`
--

LOCK TABLES `director` WRITE;
/*!40000 ALTER TABLE `director` DISABLE KEYS */;
INSERT INTO `director` VALUES (1,'Some name'),(2,'Some name'),(3,'\nКрістофер Нолан'),(4,'\nДені Вільньов'),(5,'\nЕдвард Цвік'),(6,'\nШон Пенн'),(7,'\nСаллі Поттер'),(8,'\nС. Дж. Кларксон'),(9,'\nКрістоффер Борґлі'),(10,'\nЕрік Шульц'),(11,'\nНіколь Паоне');
/*!40000 ALTER TABLE `director` ENABLE KEYS */;
UNLOCK TABLES;

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

--
-- Table structure for table `movie`
--

DROP TABLE IF EXISTS `movie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movie` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL,
  `YearOfEdition` int NOT NULL,
  `Description` varchar(500) NOT NULL,
  `Rate` float DEFAULT NULL,
  `Genre` int NOT NULL,
  `CoverImage` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movie`
--

LOCK TABLES `movie` WRITE;
/*!40000 ALTER TABLE `movie` DISABLE KEYS */;
INSERT INTO `movie` VALUES (6,'Оппенгеймер\n',2023,'У розпал Другої світової війни полковник США Леслі Гровс призначає блискучого фізика-теоретика Роберта Оппенгеймера науковим керівником Манхеттенського проєкту. Оппенгеймер проводить успішні випробування першої у світі ядерної бомби, що дозволяє наблизити перемогу у війні. Проте чоловіка мучать докори совісті, оскільки його винахід здатний призвести до знищення всього людства.',8.3,3,'8215.jpg'),(8,'Тепер я йду у дику далечінь\n	',2007,'Молодий Крістофер МакКендлес, що виріс у забезпеченій сім\'ї, закінчує Університет Еморі з відзнакою, проте відмовляється будувати кар\'єру та налагоджувати стабільне життя. Натомість він жертвує на благодійність усі свої заощадження у розмірі 24 тисяч доларів, збирає речі та вирушає автостопом подорожувати Америкою. У квітні 1992 року Крістофер прибуває до Деналі, віддаленого регіону Аляски, де починає жити серед дикої природи в старому автобусі та стикається зі своєю останньою пригодою.',8.1,1,'7795.jpg'),(10,'Кохання та інші ліки\n	',2010,'Джеймі Ренделл — ловелас і дамський угодник,  Під час одного з прийомів Джеймі зустрічає Меггі. Невелика інтрижка між Джеймі і Меггі переростає в більш серйозні відносини. Але після того, як з\'ясовується, що дівчина хвора на невиліковну хворобу Паркінсона (прогресуюче захворювання, яке вражає роботу центральної нервової системи), між закоханими виникають труднощі...',6.7,7,'2878.jpg'),(11,'Вечірка\n	',2017,'Член британського парламенту Джанет досягає піка своєї кар\'єри, отримавши посаду міністра охорони здоров\'я у тіньовому кабінеті офіційної опозиції та вирішує організувати з цього приводу невелику вечірку у себе вдома. У міру того, як вечірка набирає обертів, між гостями та Джанет сильно загострюється обстановка, що призводить до вибухонебезпечної ситуації.',6.5,2,'8623.jpg'),(12,'Мадам Павутина\n	',2024,'У 1973 році безстрашна дослідниця Констанс Вебб, незважаючи на свою вагітність, розшукує в перуанських джунглях рідкісного павука. Жінка трагічно гине, але перед смертю встигає народити здорову дівчинку Кассандру, яка від павукової отрути набуває екстрасенсорних здібностей.',3.8,0,'8536.jpg'),(13,'Сценарій мрії\n	',2023,'Пол Меттьюз — звичайний і нічим не примітний професор біології середнього віку, що живе з дружиною та дочкою. Нудне та одноманітне життя чоловіка перевертається з ніг на голову, коли з\'ясовується, що він несподівано став головним героєм сновидінь мільйонів людей по всьому світу. ',6.9,5,'8400.jpg'),(14,'Ігри свідомості\n	',2020,'Молодий нейробіолог Ітан, що веде самітницький спосіб життя, хоче продовжити справу свого покійного батька, розраховуючи розгадати загадку людської свідомості. Майже безвилазно він знаходиться у лабораторії, обладнаній у підвалі свого будинку, де проводить досліди над власним мозком. Внаслідок одного з таких експериментів розум чоловіка розщеплюється на десять частин, які захоплюють владу над свідомістю кожні шість хвилин. ',5.1,6,'8361.jpg'),(15,'Кімната вбивств\n	',2023,'Патріс — власниця художньої галереї, яка опинилася у скрутному становищі: її бізнес втрачає популярність, а вона не може укласти контракти з успішними митцями й починає вживати наркотики. Кримінальний бос Гордон, дізнавшись подробиці про жахливу фінансову ситуацію Патріс, пропонує партнерство жінці, збираючись за її допомогою відмити кошти, здобуті злочинним шляхом',5.5,9,'8565.jpg'),(18,'Дюна: частина друга \n	',2024,'Молодий герцог Пол Атрід, що має дар ясновидіння, дивом переживає замах на свою сім\'ю, після чого разом з матір\'ю, леді Джессікою, ховається від переслідування серед безмежної пустелі. Двоє знаходять безпечний притулок у таборі фременів — волелюбного народу, який за багато століть пристосувався до життя у суворих умовах планети Арракіс.',9.7,4,'8520.jpg');
/*!40000 ALTER TABLE `movie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `moviedirector`
--

DROP TABLE IF EXISTS `moviedirector`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `moviedirector` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Movie_Id` int NOT NULL,
  `Director_Id` int NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `moviedirector`
--

LOCK TABLES `moviedirector` WRITE;
/*!40000 ALTER TABLE `moviedirector` DISABLE KEYS */;
INSERT INTO `moviedirector` VALUES (5,6,4),(6,6,5),(7,8,4),(8,9,6),(9,10,5),(10,11,11),(11,11,10),(12,12,8),(13,13,3),(14,14,7),(15,15,6),(16,16,4),(17,18,4),(18,18,3);
/*!40000 ALTER TABLE `moviedirector` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usermovie`
--

DROP TABLE IF EXISTS `usermovie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usermovie` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `User_Id` int NOT NULL,
  `Movie_Id` int NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usermovie`
--

LOCK TABLES `usermovie` WRITE;
/*!40000 ALTER TABLE `usermovie` DISABLE KEYS */;
INSERT INTO `usermovie` VALUES (6,5,8),(7,5,10),(8,5,11),(11,5,6);
/*!40000 ALTER TABLE `usermovie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Username` varchar(50) NOT NULL,
  `Login` varchar(50) NOT NULL,
  `Password` varchar(50) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'z','z','z'),(2,'qwe','qwe','qwe'),(3,'Maksi','Maksi123','password'),(4,'maksi','maksimduda333@gmail.com','Deodorantstick1'),(5,'maksi','maksimduda387@gmail.com','Deodorantstick1');
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

-- Dump completed on 2024-04-30 21:49:58
