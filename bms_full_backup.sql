-- MySQL dump 10.13  Distrib 8.1.0, for Win64 (x86_64)
--
-- Host: localhost    Database: bms
-- ------------------------------------------------------
-- Server version	8.1.0

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
-- Position to start replication or point-in-time recovery from
--

-- CHANGE MASTER TO MASTER_LOG_FILE='DESKTOP-DB6DDD1-bin.000023', MASTER_LOG_POS=157;

--
-- Table structure for table `app01_author`
--

DROP TABLE IF EXISTS `app01_author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app01_author` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `sex` varchar(4) NOT NULL,
  `age` int NOT NULL,
  `tel` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app01_author`
--

LOCK TABLES `app01_author` WRITE;
/*!40000 ALTER TABLE `app01_author` DISABLE KEYS */;
INSERT INTO `app01_author` VALUES (1,'张伟','男',45,'zhangwei45@example.com'),(2,'李娜','女',22,'lina38@example.com'),(3,'王敏','女',50,'wangmin50@example.com'),(4,'赵刚','男',34,'zhaogang34@example.com'),(10,'周慧','女',42,'zhouhui42@example.com'),(11,'吴天','男',29,'wutian29@example.com'),(12,'陈静','女',47,'chenjing47@example.com'),(13,'林飞','男',53,'linfei53@example.com'),(14,'黄蕾','女',26,'huanglei26@example.com'),(15,'徐博','男',39,'xubo39@example.com');
/*!40000 ALTER TABLE `app01_author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app01_author_book`
--

DROP TABLE IF EXISTS `app01_author_book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app01_author_book` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `author_id` int NOT NULL,
  `book_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app01_author_book_author_id_book_id_2a845453_uniq` (`author_id`,`book_id`),
  KEY `app01_author_book_book_id_15e32827_fk_app01_book_id` (`book_id`),
  CONSTRAINT `app01_author_book_author_id_0f6c5f17_fk_app01_author_id` FOREIGN KEY (`author_id`) REFERENCES `app01_author` (`id`),
  CONSTRAINT `app01_author_book_book_id_15e32827_fk_app01_book_id` FOREIGN KEY (`book_id`) REFERENCES `app01_book` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app01_author_book`
--

LOCK TABLES `app01_author_book` WRITE;
/*!40000 ALTER TABLE `app01_author_book` DISABLE KEYS */;
/*!40000 ALTER TABLE `app01_author_book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app01_book`
--

DROP TABLE IF EXISTS `app01_book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app01_book` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `ISBN` varchar(64) NOT NULL,
  `publisher_id` int NOT NULL,
  `summary` longtext,
  `author_id` int DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app01_book_publisher_id_e407867a_fk_app01_publisher_id` (`publisher_id`),
  KEY `app01_book_author_id_88ca5297_fk_app01_author_id` (`author_id`),
  CONSTRAINT `app01_book_author_id_88ca5297_fk_app01_author_id` FOREIGN KEY (`author_id`) REFERENCES `app01_author` (`id`),
  CONSTRAINT `app01_book_publisher_id_e407867a_fk_app01_publisher_id` FOREIGN KEY (`publisher_id`) REFERENCES `app01_publisher` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app01_book`
--

LOCK TABLES `app01_book` WRITE;
/*!40000 ALTER TABLE `app01_book` DISABLE KEYS */;
INSERT INTO `app01_book` VALUES (10,'《我来了》','978-0-421-94892-2',8,'他们来了，诊断来了',2,22.00),(11,'《阿门！！》','978-0-421-94892-3',9,'基督教的历史',3,100.00),(12,'《Java入门》','978-0-421-94892-1',10,'讲述如何学习Java',13,53.00),(13,'《老八的传说》','978-0-421-94892-5',11,'讲述老八的光荣事迹',10,12.00),(14,'《中华功夫》','978-0-421-94892-6',12,'讲述马老师的传奇功夫',11,22.00),(15,'《CSS样式学习》','978-0-421-94892-7',13,'如何学习前端CSS',15,29.00),(16,'《笑话》','978-0-421-94892-8',11,'笑话',4,23.00),(17,'《我是可汗》','978-0-421-94892-10',9,'天书',3,20.00),(18,'《非洲行》','978-0-421-94892-19',14,'换非洲历险记',12,50.00),(19,'《哈哈哈是我》','978-0-421-94892-55',7,'就是笑',4,3.00),(20,'《为美好的世界》','978-0-421-94892-22',7,'轻小说',1,322.00),(21,'《你们仨》','978-0-421-94892-54',11,'仿名著',11,11.00),(22,'《东鹏来了》','978-0-421-94892-32',11,'讲述东鹏的故事',12,12.00),(23,'《我不玩原神》','978-0-421-94892-36',11,'戒网瘾',15,19.00),(24,'《ui设计》','978-0-421-94892-323',7,'设计UI',2,21.00),(25,'《速通JAVA》','978-0-421-94892-321',7,'JAVA上手',3,25.00);
/*!40000 ALTER TABLE `app01_book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app01_borrow`
--

DROP TABLE IF EXISTS `app01_borrow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app01_borrow` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `borrow_date` date NOT NULL,
  `return_date` date DEFAULT NULL,
  `book_id` int NOT NULL,
  `reader_id` varchar(32) NOT NULL,
  `fine` decimal(6,2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app01_borrow_book_id_reader_id_12f630e7_uniq` (`book_id`,`reader_id`),
  KEY `app01_borrow_reader_id_bab10ec7_fk_app01_reader_card_number` (`reader_id`),
  CONSTRAINT `app01_borrow_book_id_47cb05b4_fk_app01_book_id` FOREIGN KEY (`book_id`) REFERENCES `app01_book` (`id`),
  CONSTRAINT `app01_borrow_reader_id_bab10ec7_fk_app01_reader_card_number` FOREIGN KEY (`reader_id`) REFERENCES `app01_reader` (`card_number`)
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app01_borrow`
--

LOCK TABLES `app01_borrow` WRITE;
/*!40000 ALTER TABLE `app01_borrow` DISABLE KEYS */;
INSERT INTO `app01_borrow` VALUES (77,'2023-12-23','2023-12-21',17,'2020020202',44.00),(78,'2023-11-14','2023-12-07',14,'2020023011',20.00),(80,'2023-12-27','2024-01-26',18,'2024030213',0.00),(81,'2023-12-27','2024-01-26',20,'2020070111',0.00),(83,'2024-01-02','2024-02-01',21,'2024030213',0.00),(84,'2024-01-02','2024-02-01',22,'2024030213',0.00),(89,'2024-01-02','2024-02-01',10,'2024030213',0.00),(90,'2024-01-02','2024-02-01',11,'2024030213',0.00);
/*!40000 ALTER TABLE `app01_borrow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app01_lmsuser`
--

DROP TABLE IF EXISTS `app01_lmsuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app01_lmsuser` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL,
  `password` varchar(32) NOT NULL,
  `email` varchar(254) NOT NULL,
  `mobile` bigint NOT NULL,
  `is_admin` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app01_lmsuser`
--

LOCK TABLES `app01_lmsuser` WRITE;
/*!40000 ALTER TABLE `app01_lmsuser` DISABLE KEYS */;
INSERT INTO `app01_lmsuser` VALUES (3,'1','c4ca4238a0b923820dcc509a6f75849b','123@expl.com',13728213223,1),(4,'2','c81e728d9d4c2f636f067f89cc14862c','99@11.com',13728213222,0),(5,'0','cfcd208495d565ef66e7dff9f98764da','022@123.com',13728213222,1),(6,'3','eccbc87e4b5ce2fe28308fd9f2a7baf3','33@QQ.com',132323331111,0);
/*!40000 ALTER TABLE `app01_lmsuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app01_publisher`
--

DROP TABLE IF EXISTS `app01_publisher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app01_publisher` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `addr` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app01_publisher`
--

LOCK TABLES `app01_publisher` WRITE;
/*!40000 ALTER TABLE `app01_publisher` DISABLE KEYS */;
INSERT INTO `app01_publisher` VALUES (7,'人民出版社','天津'),(8,'人民文学出版社','上海'),(9,'科学出版社','成都'),(10,'高等教育出版社','温州'),(11,'商务印书馆','北京'),(12,'中华书局有限公司','北京'),(13,'人民美术出版社','南京'),(14,'人民音乐出版社','南京'),(15,'中国戏剧出版社','沈阳'),(16,'民族出版社','杭州'),(17,'明天出版社','南京'),(18,'美好世界出版社','乌鲁木齐');
/*!40000 ALTER TABLE `app01_publisher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app01_reader`
--

DROP TABLE IF EXISTS `app01_reader`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app01_reader` (
  `card_number` varchar(32) NOT NULL,
  `name` varchar(64) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `department` varchar(100) NOT NULL,
  `reader_type` varchar(50) NOT NULL,
  `level` varchar(50) NOT NULL,
  PRIMARY KEY (`card_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app01_reader`
--

LOCK TABLES `app01_reader` WRITE;
/*!40000 ALTER TABLE `app01_reader` DISABLE KEYS */;
INSERT INTO `app01_reader` VALUES ('2020010106','黄人可','男','北京化工大学','本科生','大四'),('2020010222','杨额','男','北京化工大学','本科生','大一'),('2020010991','黄人哦','女','北京化工大学','本科生','大四'),('2020020202','王明天','男','北京化工大学','研究生','研二'),('2020023011','毛毛','女','北京化工大学','研究生','研一'),('2020070111','王德法','男','北京化工大学','本科生','大一'),('2020070112','武由的','男','北京化工大学','本科生','大四'),('2020220202','武敏','男','北京化工大学','教职工','教授'),('2021040163','吴浩','男','北京化工大学','本科生','大三'),('2024030213','安心意','女','北京化工大学','教职工','讲师');
/*!40000 ALTER TABLE `app01_reader` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add lms user',7,'add_lmsuser'),(26,'Can change lms user',7,'change_lmsuser'),(27,'Can delete lms user',7,'delete_lmsuser'),(28,'Can view lms user',7,'view_lmsuser'),(29,'Can add publisher',8,'add_publisher'),(30,'Can change publisher',8,'change_publisher'),(31,'Can delete publisher',8,'delete_publisher'),(32,'Can view publisher',8,'view_publisher'),(33,'Can add book',9,'add_book'),(34,'Can change book',9,'change_book'),(35,'Can delete book',9,'delete_book'),(36,'Can view book',9,'view_book'),(37,'Can add author',10,'add_author'),(38,'Can change author',10,'change_author'),(39,'Can delete author',10,'delete_author'),(40,'Can view author',10,'view_author'),(41,'Can add reader',11,'add_reader'),(42,'Can change reader',11,'change_reader'),(43,'Can delete reader',11,'delete_reader'),(44,'Can view reader',11,'view_reader'),(45,'Can add borrow',12,'add_borrow'),(46,'Can change borrow',12,'change_borrow'),(47,'Can delete borrow',12,'delete_borrow'),(48,'Can view borrow',12,'view_borrow');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(10,'app01','author'),(9,'app01','book'),(12,'app01','borrow'),(7,'app01','lmsuser'),(8,'app01','publisher'),(11,'app01','reader'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2023-11-28 03:11:27.861248'),(2,'auth','0001_initial','2023-11-28 03:11:28.418285'),(3,'admin','0001_initial','2023-11-28 03:11:28.546329'),(4,'admin','0002_logentry_remove_auto_add','2023-11-28 03:11:28.560293'),(5,'admin','0003_logentry_add_action_flag_choices','2023-11-28 03:11:28.573470'),(6,'app01','0001_initial','2023-11-28 03:11:28.850379'),(7,'app01','0002_auto_20231128_1111','2023-11-28 03:11:28.891613'),(8,'contenttypes','0002_remove_content_type_name','2023-11-28 03:11:28.979763'),(9,'auth','0002_alter_permission_name_max_length','2023-11-28 03:11:29.067706'),(10,'auth','0003_alter_user_email_max_length','2023-11-28 03:11:29.117562'),(11,'auth','0004_alter_user_username_opts','2023-11-28 03:11:29.130527'),(12,'auth','0005_alter_user_last_login_null','2023-11-28 03:11:29.184390'),(13,'auth','0006_require_contenttypes_0002','2023-11-28 03:11:29.190366'),(14,'auth','0007_alter_validators_add_error_messages','2023-11-28 03:11:29.200339'),(15,'auth','0008_alter_user_username_max_length','2023-11-28 03:11:29.258410'),(16,'auth','0009_alter_user_last_name_max_length','2023-11-28 03:11:29.321172'),(17,'auth','0010_alter_group_name_max_length','2023-11-28 03:11:29.362958'),(18,'auth','0011_update_proxy_permissions','2023-11-28 03:11:29.384827'),(19,'auth','0012_alter_user_first_name_max_length','2023-11-28 03:11:29.456632'),(20,'sessions','0001_initial','2023-11-28 03:11:29.496169'),(21,'app01','0003_auto_20231128_1126','2023-11-28 03:26:37.910101'),(22,'app01','0004_auto_20231209_0210','2023-12-08 18:10:41.771052'),(23,'app01','0005_auto_20231212_0052','2023-12-11 16:52:31.812868'),(24,'app01','0006_auto_20231212_1501','2023-12-12 07:01:50.603115'),(25,'app01','0007_auto_20231212_1931','2023-12-12 11:32:05.787973'),(26,'app01','0008_lmsuser_is_admin','2023-12-27 16:38:15.692581'),(27,'app01','0009_remove_borrow_fine_processed','2023-12-28 08:03:55.248143'),(28,'app01','0010_alter_borrow_unique_together','2024-01-01 16:45:03.236631');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('1bqoie2bg5xh85ewvau4gufmj93aobpu','e30:1rKbXN:gCfbl3vFV8DHmeu2ddkMlR67Av022SWMTOUhVWD3A-c','2024-01-16 09:58:17.703667'),('7jztl0e53ro6kpkf7aa0wj2jy84fv2fy','.eJw9jMsKgCAURP_lrlv42PUzYjlIoBcRC0L8964U7eacYaZTAYeDo6vwAZXWTruvwfGZt4lklFFKK61pIfYZoqzEKLO3FwgovrYMbiK0neq9c-0u-F3ChfTRGA9MQCTk:1rKaVA:-ykOutzQ2cmM49bIKAlPAn2eGzHPargWgwbLyE0k9QI','2024-01-16 08:51:56.024012');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-01-02 20:38:25
