-- MySQL dump 10.13  Distrib 5.7.22, for Linux (x86_64)
--
-- Host: localhost    Database: ssrpmp
-- ------------------------------------------------------
-- Server version	5.7.22

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `order` int(11) NOT NULL DEFAULT '1',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `categories_slug_unique` (`slug`) USING BTREE,
  KEY `categories_parent_id_foreign` (`parent_id`) USING BTREE,
  CONSTRAINT `categories_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,NULL,1,'Category 1','category-1','2018-08-04 13:39:59','2018-08-04 13:39:59'),(2,NULL,1,'Category 2','category-2','2018-08-04 13:39:59','2018-08-04 13:39:59');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_rows`
--

DROP TABLE IF EXISTS `data_rows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_rows` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `data_type_id` int(10) unsigned NOT NULL,
  `field` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `browse` tinyint(1) NOT NULL DEFAULT '1',
  `read` tinyint(1) NOT NULL DEFAULT '1',
  `edit` tinyint(1) NOT NULL DEFAULT '1',
  `add` tinyint(1) NOT NULL DEFAULT '1',
  `delete` tinyint(1) NOT NULL DEFAULT '1',
  `details` text COLLATE utf8mb4_unicode_ci,
  `order` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `data_rows_data_type_id_foreign` (`data_type_id`) USING BTREE,
  CONSTRAINT `data_rows_data_type_id_foreign` FOREIGN KEY (`data_type_id`) REFERENCES `data_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_rows`
--

LOCK TABLES `data_rows` WRITE;
/*!40000 ALTER TABLE `data_rows` DISABLE KEYS */;
INSERT INTO `data_rows` VALUES (1,1,'id','number','ID',1,0,0,0,0,0,NULL,1),(2,1,'name','text','姓名',1,1,1,1,1,1,'{\r\n    \"validation\": {\r\n        \"rule\": \"required|unique:posts,slug\",\r\n        \"messages\": {\r\n            \"required\": \"用户的姓名必须存在且唯一的。\",\r\n            \"unique \": \"用户的姓名必须是存在且唯一的。\"\r\n        }\r\n    }\r\n}',2),(3,1,'email','text','邮箱',1,1,1,1,1,1,NULL,3),(4,1,'password','password','密码',1,0,0,1,1,0,NULL,4),(5,1,'remember_token','text','Remember Token',0,0,0,0,0,0,NULL,5),(6,1,'created_at','timestamp','创建时间',0,1,1,0,0,0,NULL,6),(7,1,'updated_at','timestamp','Updated At',0,0,0,0,0,0,NULL,7),(8,1,'avatar','image','头像',0,1,1,1,1,1,NULL,8),(9,1,'user_belongsto_role_relationship','relationship','角色',0,1,1,1,1,0,'{\"model\":\"TCG\\\\Voyager\\\\Models\\\\Role\",\"table\":\"roles\",\"type\":\"belongsTo\",\"column\":\"role_id\",\"key\":\"id\",\"label\":\"display_name\",\"pivot_table\":\"roles\",\"pivot\":\"0\",\"taggable\":\"0\"}',10),(10,1,'user_belongstomany_role_relationship','relationship','其他角色',0,0,1,1,1,0,'{\"model\":\"TCG\\\\Voyager\\\\Models\\\\Role\",\"table\":\"roles\",\"type\":\"belongsToMany\",\"column\":\"id\",\"key\":\"id\",\"label\":\"display_name\",\"pivot_table\":\"user_roles\",\"pivot\":\"1\",\"taggable\":\"0\"}',11),(12,1,'settings','hidden','Settings',0,0,0,0,0,0,NULL,12),(13,2,'id','number','ID',1,0,0,0,0,0,'',1),(14,2,'name','text','Name',1,1,1,1,1,1,'',2),(15,2,'created_at','timestamp','Created At',0,0,0,0,0,0,'',3),(16,2,'updated_at','timestamp','Updated At',0,0,0,0,0,0,'',4),(17,3,'id','number','ID',1,0,0,0,0,0,'',1),(18,3,'name','text','Name',1,1,1,1,1,1,'',2),(19,3,'created_at','timestamp','Created At',0,0,0,0,0,0,'',3),(20,3,'updated_at','timestamp','Updated At',0,0,0,0,0,0,'',4),(21,3,'display_name','text','Display Name',1,1,1,1,1,1,'',5),(22,1,'role_id','text','Role',0,1,1,1,1,1,NULL,9),(23,4,'id','number','ID',1,0,0,0,0,0,'',1),(24,4,'parent_id','select_dropdown','Parent',0,0,1,1,1,1,'{\"default\":\"\",\"null\":\"\",\"options\":{\"\":\"-- None --\"},\"relationship\":{\"key\":\"id\",\"label\":\"name\"}}',2),(25,4,'order','text','Order',1,1,1,1,1,1,'{\"default\":1}',3),(26,4,'name','text','Name',1,1,1,1,1,1,'',4),(27,4,'slug','text','Slug',1,1,1,1,1,1,'{\"slugify\":{\"origin\":\"name\"}}',5),(28,4,'created_at','timestamp','Created At',0,0,1,0,0,0,'',6),(29,4,'updated_at','timestamp','Updated At',0,0,0,0,0,0,'',7),(30,5,'id','number','ID',1,0,0,0,0,0,NULL,1),(31,5,'author_id','text','作者',1,0,0,0,0,1,NULL,2),(32,5,'category_id','text','分类',0,0,0,1,1,0,NULL,3),(33,5,'title','text','标题',1,1,1,1,1,1,NULL,4),(34,5,'excerpt','text_area','简介',0,0,1,1,1,1,NULL,5),(35,5,'body','rich_text_box','内容',1,0,1,1,1,1,NULL,6),(36,5,'image','image','图片',0,1,1,1,1,1,'{\"resize\":{\"width\":\"1000\",\"height\":\"null\"},\"quality\":\"70%\",\"upsize\":true,\"thumbnails\":[{\"name\":\"medium\",\"scale\":\"50%\"},{\"name\":\"small\",\"scale\":\"25%\"},{\"name\":\"cropped\",\"crop\":{\"width\":\"300\",\"height\":\"250\"}}]}',7),(37,5,'slug','text','链接',1,0,1,1,1,1,'{\"validation\":{\"rule\":\"required|unique:posts,slug\",\"messages\":{\"required\":\"文章的链接(URL) 是必须存在且唯一的。\",\"unique \":\"文章的链接(URL) 必须是存在且唯一的。\"}}}',8),(38,5,'meta_description','text_area','Meta Description',0,0,1,1,1,1,NULL,9),(39,5,'meta_keywords','text_area','Meta Keywords',0,0,1,1,1,1,NULL,10),(40,5,'status','select_dropdown','状态',1,1,1,1,1,1,'{\"default\":\"发布\",\"options\":{\"PUBLISHED\":\"发布\",\"DRAFT\":\"草稿\",\"PENDING\":\"审核中\"}}',11),(41,5,'created_at','timestamp','创建时间',0,1,1,0,0,0,NULL,12),(42,5,'updated_at','timestamp','更新时间',0,1,1,0,0,0,NULL,13),(43,5,'seo_title','text','SEO Title',0,0,1,1,1,1,NULL,14),(44,5,'featured','checkbox','喜欢',1,0,1,1,1,1,NULL,15),(45,6,'id','number','ID',1,0,0,0,0,0,'',1),(46,6,'author_id','text','Author',1,0,0,0,0,0,'',2),(47,6,'title','text','Title',1,1,1,1,1,1,'',3),(48,6,'excerpt','text_area','Excerpt',1,0,1,1,1,1,'',4),(49,6,'body','rich_text_box','Body',1,0,1,1,1,1,'',5),(50,6,'slug','text','Slug',1,0,1,1,1,1,'{\"slugify\":{\"origin\":\"title\"},\"validation\":{\"rule\":\"unique:pages,slug\"}}',6),(51,6,'meta_description','text','Meta Description',1,0,1,1,1,1,'',7),(52,6,'meta_keywords','text','Meta Keywords',1,0,1,1,1,1,'',8),(53,6,'status','select_dropdown','Status',1,1,1,1,1,1,'{\"default\":\"INACTIVE\",\"options\":{\"INACTIVE\":\"INACTIVE\",\"ACTIVE\":\"ACTIVE\"}}',9),(54,6,'created_at','timestamp','Created At',1,1,1,0,0,0,'',10),(55,6,'updated_at','timestamp','Updated At',1,0,0,0,0,0,'',11),(56,6,'image','image','Page Image',0,1,1,1,1,1,'',12),(57,7,'id','text','Id',1,0,0,0,0,0,NULL,1),(58,7,'user_id','text','User Id',0,1,1,1,1,1,NULL,2),(59,7,'project_id','text','Project Id',0,1,1,1,1,1,NULL,3),(60,7,'fno','text','流水号',0,0,1,0,0,0,NULL,5),(61,7,'apply_reason','text_area','申请理由',0,0,1,1,1,1,NULL,6),(62,7,'apply_money','text','申请金额',0,1,1,1,1,1,NULL,7),(63,7,'status','select_dropdown','申请单状态',0,1,1,1,1,1,'{\"default\":\"申请中\",\"options\":{\"申请中\":\"申请中\",\"审批中\":\"审批中\",\"结报中\":\"结报中\",\"结束\":\"结束\"}}',8),(64,7,'approve_id','text','Approve Id',0,1,1,1,1,1,NULL,4),(66,7,'approve_reason','text_area','审批理由',0,0,1,1,1,1,NULL,10),(67,7,'approve_money','text','审批金额',0,1,1,1,1,1,NULL,11),(68,7,'reimburse_time','timestamp','报销时间',0,1,1,0,0,0,NULL,12),(69,7,'reimburse_no','text','报销单号',0,1,1,1,1,1,NULL,13),(70,7,'end_time','timestamp','结束时间',0,1,1,0,0,0,NULL,14),(71,7,'created_at','timestamp','创建时间',0,1,1,0,0,0,NULL,15),(72,7,'updated_at','timestamp','Updated At',0,0,0,0,0,0,NULL,16),(73,7,'fund_belongsto_user_relationship','relationship','申请人名称',0,1,1,1,1,1,'{\"model\":\"App\\\\User\",\"table\":\"users\",\"type\":\"belongsTo\",\"column\":\"user_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"categories\",\"pivot\":\"0\",\"taggable\":\"0\"}',17),(75,7,'fund_belongsto_user_relationship_1','relationship','审批人名称',0,1,1,1,1,1,'{\"model\":\"App\\\\User\",\"table\":\"users\",\"type\":\"belongsTo\",\"column\":\"approve_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"categories\",\"pivot\":\"0\",\"taggable\":\"0\"}',19),(76,8,'id','text','Id',1,0,0,0,0,0,NULL,1),(77,8,'pid','text','项目编号',0,1,1,1,1,1,NULL,4),(78,8,'name','text','项目名称',0,1,1,1,1,1,NULL,5),(79,8,'type_id','text','type id',0,1,1,1,1,1,NULL,2),(80,8,'user_id','text','User Id',0,1,1,1,1,1,NULL,3),(81,8,'teacher','text','指导老师',0,1,1,1,1,1,NULL,6),(82,8,'reason','text_area','申请理由',0,0,1,1,1,1,NULL,7),(83,8,'description','text_area','项目描述',0,1,1,1,1,1,NULL,8),(84,8,'expect','text_area','项目简介',0,0,1,1,1,1,NULL,9),(85,8,'created_at','timestamp','创建时间',0,1,1,1,0,1,NULL,10),(86,8,'updated_at','timestamp','Updated At',0,0,0,0,0,0,NULL,11),(89,8,'project_belongsto_type_relationship','relationship','项目类型',0,1,1,1,1,1,'{\"model\":\"App\\\\Type\",\"table\":\"types\",\"type\":\"belongsTo\",\"column\":\"type_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"categories\",\"pivot\":\"0\",\"taggable\":\"0\"}',13),(90,8,'project_belongsto_user_relationship','relationship','主持人',0,1,1,1,1,1,'{\"model\":\"App\\\\User\",\"table\":\"users\",\"type\":\"belongsTo\",\"column\":\"user_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"categories\",\"pivot\":\"0\",\"taggable\":\"0\"}',14),(92,8,'project_belongstomany_user_relationship','relationship','项目成员',0,1,1,1,1,1,'{\"model\":\"App\\\\User\",\"table\":\"users\",\"type\":\"belongsToMany\",\"column\":\"id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"user_projects\",\"pivot\":\"1\",\"taggable\":\"0\"}',15),(93,9,'id','text','Id',1,0,0,0,0,0,NULL,1),(94,9,'name','text','类型名称',0,1,1,1,1,1,NULL,2),(95,9,'description','text_area','类型描述',0,1,1,1,1,1,NULL,3),(96,9,'condition','text_area','申请条件',0,1,1,1,1,1,NULL,4),(97,9,'budget','text','预算',0,1,1,1,1,1,NULL,5),(98,9,'created_at','timestamp','创建时间',0,1,1,1,0,1,NULL,6),(99,9,'updated_at','timestamp','Updated At',0,0,0,0,0,0,NULL,7),(100,7,'fund_belongsto_project_relationship','relationship','项目名称',0,1,1,1,1,1,'{\"model\":\"App\\\\Project\",\"table\":\"projects\",\"type\":\"belongsTo\",\"column\":\"project_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"categories\",\"pivot\":\"0\",\"taggable\":\"0\"}',20),(101,7,'reimburse_money','text','结报金额',0,1,1,1,1,1,NULL,14),(102,7,'approve_time','text','审批时间',0,1,1,0,0,0,NULL,9),(103,8,'attachment','file','附件',0,1,1,1,1,1,NULL,10),(104,1,'uno','text','学号/工号',0,1,1,1,1,1,NULL,9);
/*!40000 ALTER TABLE `data_rows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_types`
--

DROP TABLE IF EXISTS `data_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name_singular` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name_plural` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `model_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `policy_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `controller` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `generate_permissions` tinyint(1) NOT NULL DEFAULT '0',
  `server_side` tinyint(4) NOT NULL DEFAULT '0',
  `details` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `data_types_name_unique` (`name`) USING BTREE,
  UNIQUE KEY `data_types_slug_unique` (`slug`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_types`
--

LOCK TABLES `data_types` WRITE;
/*!40000 ALTER TABLE `data_types` DISABLE KEYS */;
INSERT INTO `data_types` VALUES (1,'users','users','User','Users','voyager-person','TCG\\Voyager\\Models\\User','TCG\\Voyager\\Policies\\UserPolicy',NULL,NULL,1,0,'{\"order_column\":null,\"order_display_column\":null}','2018-08-04 13:39:58','2018-08-20 20:58:51'),(2,'menus','menus','Menu','Menus','voyager-list','TCG\\Voyager\\Models\\Menu',NULL,'','',1,0,NULL,'2018-08-04 13:39:58','2018-08-04 13:39:58'),(3,'roles','roles','Role','Roles','voyager-lock','TCG\\Voyager\\Models\\Role',NULL,'','',1,0,NULL,'2018-08-04 13:39:58','2018-08-04 13:39:58'),(4,'categories','categories','Category','Categories','voyager-categories','TCG\\Voyager\\Models\\Category',NULL,'','',1,0,NULL,'2018-08-04 13:39:59','2018-08-04 13:39:59'),(5,'posts','posts','Post','Posts','voyager-news','TCG\\Voyager\\Models\\Post','TCG\\Voyager\\Policies\\PostPolicy',NULL,NULL,1,0,'{\"order_column\":null,\"order_display_column\":null}','2018-08-04 13:39:59','2018-08-20 20:42:54'),(6,'pages','pages','Page','Pages','voyager-file-text','TCG\\Voyager\\Models\\Page',NULL,'','',1,0,NULL,'2018-08-04 13:39:59','2018-08-04 13:39:59'),(7,'funds','funds','Fund','Funds','voyager-receipt','App\\Fund',NULL,'\\App\\Http\\Controllers\\Voyager\\FundController',NULL,1,0,'{\"order_column\":null,\"order_display_column\":null}','2018-08-05 09:35:41','2018-08-19 13:33:45'),(8,'projects','projects','项目','项目','voyager-paw','App\\Project',NULL,'\\App\\Http\\Controllers\\Voyager\\ProjectController',NULL,1,0,'{\"order_column\":null,\"order_display_column\":null}','2018-08-06 14:02:10','2018-08-06 20:12:05'),(9,'types','types','Type','Types','voyager-archive','App\\Type',NULL,NULL,NULL,1,0,'{\"order_column\":null,\"order_display_column\":null}','2018-08-06 15:13:55','2018-08-06 20:09:48');
/*!40000 ALTER TABLE `data_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `funds`
--

DROP TABLE IF EXISTS `funds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `funds` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `project_id` int(10) unsigned DEFAULT NULL,
  `fno` varchar(255) DEFAULT NULL COMMENT '自动生成的经费申请编号',
  `apply_reason` text COMMENT '申请理由',
  `apply_money` varchar(255) DEFAULT NULL COMMENT '金额',
  `status` varchar(255) DEFAULT NULL COMMENT '申请状态',
  `approve_id` int(10) unsigned DEFAULT NULL COMMENT '审批人id',
  `approve_time` datetime DEFAULT NULL COMMENT '审批时间',
  `approve_reason` text COMMENT '审批理由',
  `approve_money` varchar(255) DEFAULT NULL COMMENT '审批金额',
  `reimburse_time` datetime DEFAULT NULL COMMENT '报销时间',
  `reimburse_no` varchar(255) DEFAULT NULL COMMENT '报销单编号',
  `reimburse_money` varchar(255) DEFAULT NULL COMMENT '报销金额',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `funds_users_user_id` (`user_id`) USING BTREE,
  KEY `projects_users_project_id` (`project_id`) USING BTREE,
  KEY `funds_users_approve_id` (`approve_id`) USING BTREE,
  CONSTRAINT `funds_users_approve_id` FOREIGN KEY (`approve_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `funds_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `projects_users_project_id` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funds`
--

LOCK TABLES `funds` WRITE;
/*!40000 ALTER TABLE `funds` DISABLE KEYS */;
/*!40000 ALTER TABLE `funds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_items`
--

DROP TABLE IF EXISTS `menu_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `menu_id` int(10) unsigned DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `target` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '_self',
  `icon_class` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `order` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `route` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parameters` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `menu_items_menu_id_foreign` (`menu_id`) USING BTREE,
  CONSTRAINT `menu_items_menu_id_foreign` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_items`
--

LOCK TABLES `menu_items` WRITE;
/*!40000 ALTER TABLE `menu_items` DISABLE KEYS */;
INSERT INTO `menu_items` VALUES (1,1,'Dashboard','','_self','voyager-boat',NULL,NULL,1,'2018-08-04 13:39:58','2018-08-04 13:39:58','voyager.dashboard',NULL),(2,1,'Media','','_self','voyager-images',NULL,NULL,4,'2018-08-04 13:39:58','2018-08-06 15:14:55','voyager.media.index',NULL),(3,1,'Users','','_self','voyager-person',NULL,NULL,3,'2018-08-04 13:39:58','2018-08-04 13:39:58','voyager.users.index',NULL),(4,1,'Roles','','_self','voyager-lock',NULL,NULL,2,'2018-08-04 13:39:58','2018-08-04 13:39:58','voyager.roles.index',NULL),(5,1,'Tools','','_self','voyager-tools',NULL,NULL,8,'2018-08-04 13:39:58','2018-08-06 15:14:55',NULL,NULL),(6,1,'Menu Builder','','_self','voyager-list',NULL,5,1,'2018-08-04 13:39:58','2018-08-06 15:14:55','voyager.menus.index',NULL),(7,1,'Database','','_self','voyager-data',NULL,5,2,'2018-08-04 13:39:58','2018-08-06 15:14:55','voyager.database.index',NULL),(8,1,'Compass','','_self','voyager-compass',NULL,5,3,'2018-08-04 13:39:58','2018-08-06 15:14:55','voyager.compass.index',NULL),(9,1,'BREAD','','_self','voyager-bread',NULL,5,4,'2018-08-04 13:39:58','2018-08-06 15:14:55','voyager.bread.index',NULL),(10,1,'Settings','','_self','voyager-settings',NULL,NULL,9,'2018-08-04 13:39:58','2018-08-06 15:14:55','voyager.settings.index',NULL),(11,1,'Categories','','_self','voyager-categories',NULL,NULL,7,'2018-08-04 13:39:59','2018-08-06 15:14:55','voyager.categories.index',NULL),(12,1,'Posts','','_self','voyager-news',NULL,NULL,5,'2018-08-04 13:39:59','2018-08-06 15:14:55','voyager.posts.index',NULL),(13,1,'Pages','','_self','voyager-file-text',NULL,NULL,6,'2018-08-04 13:39:59','2018-08-06 15:14:55','voyager.pages.index',NULL),(14,1,'Hooks','','_self','voyager-hook',NULL,5,5,'2018-08-04 13:39:59','2018-08-06 15:14:55','voyager.hooks',NULL),(15,1,'项目经费','','_self','voyager-receipt','#000000',NULL,12,'2018-08-05 09:35:41','2018-08-06 20:16:33','voyager.funds.index','null'),(16,1,'所有项目','','_self','voyager-paw','#000000',NULL,10,'2018-08-06 14:02:10','2018-08-20 20:02:24','voyager.projects.index','null'),(17,1,'项目类型','','_self','voyager-archive','#000000',NULL,11,'2018-08-06 15:13:55','2018-08-06 20:16:20','voyager.types.index','null');
/*!40000 ALTER TABLE `menu_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menus`
--

DROP TABLE IF EXISTS `menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menus` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `menus_name_unique` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menus`
--

LOCK TABLES `menus` WRITE;
/*!40000 ALTER TABLE `menus` DISABLE KEYS */;
INSERT INTO `menus` VALUES (1,'admin','2018-08-04 13:39:58','2018-08-04 13:39:58');
/*!40000 ALTER TABLE `menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_12_000000_create_users_table',1),(2,'2014_10_12_100000_create_password_resets_table',1),(3,'2016_01_01_000000_add_voyager_user_fields',1),(4,'2016_01_01_000000_create_data_types_table',1),(5,'2016_01_01_000000_create_pages_table',1),(6,'2016_01_01_000000_create_posts_table',1),(7,'2016_02_15_204651_create_categories_table',1),(8,'2016_05_19_173453_create_menu_table',1),(9,'2016_10_21_190000_create_roles_table',1),(10,'2016_10_21_190000_create_settings_table',1),(11,'2016_11_30_135954_create_permission_table',1),(12,'2016_11_30_141208_create_permission_role_table',1),(13,'2016_12_26_201236_data_types__add__server_side',1),(14,'2017_01_13_000000_add_route_to_menu_items_table',1),(15,'2017_01_14_005015_create_translations_table',1),(16,'2017_01_15_000000_make_table_name_nullable_in_permissions_table',1),(17,'2017_03_06_000000_add_controller_to_data_types_table',1),(18,'2017_04_11_000000_alter_post_nullable_fields_table',1),(19,'2017_04_21_000000_add_order_to_data_rows_table',1),(20,'2017_07_05_210000_add_policyname_to_data_types_table',1),(21,'2017_08_05_000000_add_group_to_settings_table',1),(22,'2017_11_26_013050_add_user_role_relationship',1),(23,'2017_11_26_015000_create_user_roles_table',1),(24,'2018_03_11_000000_add_user_settings',1),(25,'2018_03_14_000000_add_details_to_data_types_table',1),(26,'2018_03_16_000000_make_settings_value_nullable',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pages`
--

DROP TABLE IF EXISTS `pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `author_id` int(11) NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `excerpt` text COLLATE utf8mb4_unicode_ci,
  `body` text COLLATE utf8mb4_unicode_ci,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_description` text COLLATE utf8mb4_unicode_ci,
  `meta_keywords` text COLLATE utf8mb4_unicode_ci,
  `status` enum('ACTIVE','INACTIVE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'INACTIVE',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `pages_slug_unique` (`slug`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pages`
--

LOCK TABLES `pages` WRITE;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
INSERT INTO `pages` VALUES (1,0,'Hello World','Hang the jib grog grog blossom grapple dance the hempen jig gangway pressgang bilge rat to go on account lugger. Nelsons folly gabion line draught scallywag fire ship gaff fluke fathom case shot. Sea Legs bilge rat sloop matey gabion long clothes run a shot across the bow Gold Road cog league.','<p>Hello World. Scallywag grog swab Cat o\'nine tails scuttle rigging hardtack cable nipper Yellow Jack. Handsomely spirits knave lad killick landlubber or just lubber deadlights chantey pinnace crack Jennys tea cup. Provost long clothes black spot Yellow Jack bilged on her anchor league lateen sail case shot lee tackle.</p>\n<p>Ballast spirits fluke topmast me quarterdeck schooner landlubber or just lubber gabion belaying pin. Pinnace stern galleon starboard warp carouser to go on account dance the hempen jig jolly boat measured fer yer chains. Man-of-war fire in the hole nipperkin handsomely doubloon barkadeer Brethren of the Coast gibbet driver squiffy.</p>','pages/page1.jpg','hello-world','Yar Meta Description','Keyword1, Keyword2','ACTIVE','2018-08-04 13:39:59','2018-08-04 13:39:59');
/*!40000 ALTER TABLE `pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_resets`
--

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission_role`
--

DROP TABLE IF EXISTS `permission_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permission_role` (
  `permission_id` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`) USING BTREE,
  KEY `permission_role_permission_id_index` (`permission_id`) USING BTREE,
  KEY `permission_role_role_id_index` (`role_id`) USING BTREE,
  CONSTRAINT `permission_role_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `permission_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission_role`
--

LOCK TABLES `permission_role` WRITE;
/*!40000 ALTER TABLE `permission_role` DISABLE KEYS */;
INSERT INTO `permission_role` VALUES (1,1),(1,2),(1,3),(2,1),(3,1),(4,1),(4,3),(5,1),(6,1),(7,1),(8,1),(9,1),(10,1),(11,1),(11,3),(12,1),(12,3),(13,1),(14,1),(15,1),(16,1),(16,2),(16,3),(17,1),(17,2),(17,3),(18,1),(19,1),(20,1),(20,3),(21,1),(22,1),(23,1),(24,1),(25,1),(26,1),(27,1),(28,1),(29,1),(30,1),(31,1),(31,2),(31,3),(32,1),(32,2),(32,3),(33,1),(33,3),(34,1),(34,3),(35,1),(35,3),(36,1),(37,1),(38,1),(39,1),(40,1),(41,1),(42,1),(42,2),(42,3),(43,1),(43,2),(43,3),(44,1),(44,2),(44,3),(45,1),(45,2),(45,3),(46,1),(46,2),(46,3),(47,1),(47,2),(47,3),(48,1),(48,2),(48,3),(49,1),(49,2),(49,3),(50,1),(50,2),(50,3),(51,1),(51,2),(51,3),(52,1),(52,2),(52,3),(53,1),(53,2),(53,3),(54,1),(54,3),(55,1),(55,3),(56,1),(56,3);
/*!40000 ALTER TABLE `permission_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `table_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `permissions_key_index` (`key`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES (1,'browse_admin',NULL,'2018-08-04 13:39:58','2018-08-04 13:39:58'),(2,'browse_bread',NULL,'2018-08-04 13:39:58','2018-08-04 13:39:58'),(3,'browse_database',NULL,'2018-08-04 13:39:58','2018-08-04 13:39:58'),(4,'browse_media',NULL,'2018-08-04 13:39:58','2018-08-04 13:39:58'),(5,'browse_compass',NULL,'2018-08-04 13:39:58','2018-08-04 13:39:58'),(6,'browse_menus','menus','2018-08-04 13:39:58','2018-08-04 13:39:58'),(7,'read_menus','menus','2018-08-04 13:39:58','2018-08-04 13:39:58'),(8,'edit_menus','menus','2018-08-04 13:39:58','2018-08-04 13:39:58'),(9,'add_menus','menus','2018-08-04 13:39:58','2018-08-04 13:39:58'),(10,'delete_menus','menus','2018-08-04 13:39:58','2018-08-04 13:39:58'),(11,'browse_roles','roles','2018-08-04 13:39:58','2018-08-04 13:39:58'),(12,'read_roles','roles','2018-08-04 13:39:58','2018-08-04 13:39:58'),(13,'edit_roles','roles','2018-08-04 13:39:58','2018-08-04 13:39:58'),(14,'add_roles','roles','2018-08-04 13:39:58','2018-08-04 13:39:58'),(15,'delete_roles','roles','2018-08-04 13:39:58','2018-08-04 13:39:58'),(16,'browse_users','users','2018-08-04 13:39:58','2018-08-04 13:39:58'),(17,'read_users','users','2018-08-04 13:39:58','2018-08-04 13:39:58'),(18,'edit_users','users','2018-08-04 13:39:58','2018-08-04 13:39:58'),(19,'add_users','users','2018-08-04 13:39:58','2018-08-04 13:39:58'),(20,'delete_users','users','2018-08-04 13:39:58','2018-08-04 13:39:58'),(21,'browse_settings','settings','2018-08-04 13:39:59','2018-08-04 13:39:59'),(22,'read_settings','settings','2018-08-04 13:39:59','2018-08-04 13:39:59'),(23,'edit_settings','settings','2018-08-04 13:39:59','2018-08-04 13:39:59'),(24,'add_settings','settings','2018-08-04 13:39:59','2018-08-04 13:39:59'),(25,'delete_settings','settings','2018-08-04 13:39:59','2018-08-04 13:39:59'),(26,'browse_categories','categories','2018-08-04 13:39:59','2018-08-04 13:39:59'),(27,'read_categories','categories','2018-08-04 13:39:59','2018-08-04 13:39:59'),(28,'edit_categories','categories','2018-08-04 13:39:59','2018-08-04 13:39:59'),(29,'add_categories','categories','2018-08-04 13:39:59','2018-08-04 13:39:59'),(30,'delete_categories','categories','2018-08-04 13:39:59','2018-08-04 13:39:59'),(31,'browse_posts','posts','2018-08-04 13:39:59','2018-08-04 13:39:59'),(32,'read_posts','posts','2018-08-04 13:39:59','2018-08-04 13:39:59'),(33,'edit_posts','posts','2018-08-04 13:39:59','2018-08-04 13:39:59'),(34,'add_posts','posts','2018-08-04 13:39:59','2018-08-04 13:39:59'),(35,'delete_posts','posts','2018-08-04 13:39:59','2018-08-04 13:39:59'),(36,'browse_pages','pages','2018-08-04 13:39:59','2018-08-04 13:39:59'),(37,'read_pages','pages','2018-08-04 13:39:59','2018-08-04 13:39:59'),(38,'edit_pages','pages','2018-08-04 13:39:59','2018-08-04 13:39:59'),(39,'add_pages','pages','2018-08-04 13:39:59','2018-08-04 13:39:59'),(40,'delete_pages','pages','2018-08-04 13:39:59','2018-08-04 13:39:59'),(41,'browse_hooks',NULL,'2018-08-04 13:39:59','2018-08-04 13:39:59'),(42,'browse_funds','funds','2018-08-05 09:35:41','2018-08-05 09:35:41'),(43,'read_funds','funds','2018-08-05 09:35:41','2018-08-05 09:35:41'),(44,'edit_funds','funds','2018-08-05 09:35:41','2018-08-05 09:35:41'),(45,'add_funds','funds','2018-08-05 09:35:41','2018-08-05 09:35:41'),(46,'delete_funds','funds','2018-08-05 09:35:41','2018-08-05 09:35:41'),(47,'browse_projects','projects','2018-08-06 14:02:10','2018-08-06 14:02:10'),(48,'read_projects','projects','2018-08-06 14:02:10','2018-08-06 14:02:10'),(49,'edit_projects','projects','2018-08-06 14:02:10','2018-08-06 14:02:10'),(50,'add_projects','projects','2018-08-06 14:02:10','2018-08-06 14:02:10'),(51,'delete_projects','projects','2018-08-06 14:02:10','2018-08-06 14:02:10'),(52,'browse_types','types','2018-08-06 15:13:55','2018-08-06 15:13:55'),(53,'read_types','types','2018-08-06 15:13:55','2018-08-06 15:13:55'),(54,'edit_types','types','2018-08-06 15:13:55','2018-08-06 15:13:55'),(55,'add_types','types','2018-08-06 15:13:55','2018-08-06 15:13:55'),(56,'delete_types','types','2018-08-06 15:13:55','2018-08-06 15:13:55');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `author_id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `seo_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `excerpt` text COLLATE utf8mb4_unicode_ci,
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_description` text COLLATE utf8mb4_unicode_ci,
  `meta_keywords` text COLLATE utf8mb4_unicode_ci,
  `status` enum('PUBLISHED','DRAFT','PENDING') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'DRAFT',
  `featured` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `posts_slug_unique` (`slug`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (8,2,1,'测试文章',NULL,'测试文章摘要测试文章摘要测试文章摘要测试文章摘要测试文章摘要测试文章摘要测试文章摘要测试文章摘要测试文章摘要测试文章摘要测试文章摘要测试文章摘要测试文章摘要测试文章摘要测试文章摘要测试文章摘要测试文章摘要测试文章摘要测试文章摘要','<p><strong>测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容</strong>测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文<em>章内容测试文章内容</em>测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内<span style=\"text-decoration: underline;\">容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章</span>内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容<span style=\"text-decoration: underline;\">测试文</span>章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内<span style=\"color: #ffff00;\">容测试文章内容测试</span>文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测<span style=\"color: #ff0000;\">试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测</span>试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容测试文章内容</p>','posts/August2018/ljqCotj5om3zLtO6ZsAf.png','test',NULL,NULL,'PUBLISHED',0,'2018-08-27 11:10:19','2018-08-27 11:10:19'),(9,2,1,'edgrser',NULL,'asdf','<p>ssdfg&nbsp;</p>',NULL,'qet',NULL,NULL,'PUBLISHED',0,'2018-08-27 11:23:26','2018-08-27 11:23:26');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projects` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` varchar(255) DEFAULT NULL COMMENT '项目编号',
  `name` varchar(255) DEFAULT NULL COMMENT '项目名称',
  `type_id` int(10) unsigned DEFAULT NULL COMMENT '项目类型的id（是类型表的外键）',
  `user_id` int(10) unsigned DEFAULT NULL COMMENT '项目主持人的id（users表的外键）',
  `teacher` varchar(255) DEFAULT NULL COMMENT '指导老师',
  `reason` text COMMENT '申请理由',
  `description` text COMMENT '项目简介',
  `expect` text COMMENT '预期成果',
  `attachment` varchar(255) DEFAULT NULL COMMENT '附件',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `type_id_projects_type` (`type_id`) USING BTREE,
  KEY `user_id_project` (`user_id`) USING BTREE,
  CONSTRAINT `type_id_projects_type` FOREIGN KEY (`type_id`) REFERENCES `types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_id_project` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` VALUES (2,'adgfas','啊手动阀手动阀',1,2,'阿迪斯发倒萨倒萨','阿迪斯广发速度发到四个','阿斯蒂芬案说法','啊手动阀为发',NULL,'2018-08-06 15:26:00','2018-08-06 17:16:37');
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `roles_name_unique` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'admin','超级管理员','2018-08-04 13:39:58','2018-08-20 14:43:51'),(2,'user','普通用户','2018-08-04 13:39:58','2018-08-20 14:44:05'),(3,'manager','管理员','2018-08-20 14:43:31','2018-08-20 14:43:31');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  `details` text COLLATE utf8mb4_unicode_ci,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order` int(11) NOT NULL DEFAULT '1',
  `group` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `settings_key_unique` (`key`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES (1,'site.title','Site Title','学生科研项目管理平台','','text',1,'Site'),(2,'site.description','Site Description','科研项目管理平台是为了方便学生和老师进行各类项目的收集和管理的网站','','text',3,'Site'),(3,'site.logo','Site Logo','','','image',6,'Site'),(4,'site.google_analytics_tracking_id','Google Analytics Tracking ID',NULL,'','text',7,'Site'),(5,'admin.bg_image','Admin Background Image','','','image',5,'Admin'),(6,'admin.title','Admin Title','SSRPMP','','text',1,'Admin'),(7,'admin.description','Admin Description','学生科研项目管理平台','','text',2,'Admin'),(8,'admin.loader','Admin Loader','','','image',3,'Admin'),(9,'admin.icon_image','Admin Icon Image','','','image',4,'Admin'),(10,'admin.google_analytics_client_id','Google Analytics Client ID (used for admin dashboard)',NULL,'','text',1,'Admin'),(11,'site.subtitle','Site Sub Title','Students Science and Research Projects Management Platform',NULL,'text',2,'Site'),(12,'site.excerpt','Site Excerpt','具有项目管理和经费管理的功能，所有操作均在前端实现，极大的提高了项目申报和管理工作的效率',NULL,'text',4,'Site');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `translations`
--

DROP TABLE IF EXISTS `translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `translations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `table_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `column_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `foreign_key` int(10) unsigned NOT NULL,
  `locale` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `translations_table_name_column_name_foreign_key_locale_unique` (`table_name`,`column_name`,`foreign_key`,`locale`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `translations`
--

LOCK TABLES `translations` WRITE;
/*!40000 ALTER TABLE `translations` DISABLE KEYS */;
INSERT INTO `translations` VALUES (1,'data_types','display_name_singular',5,'pt','Post','2018-08-04 13:39:59','2018-08-04 13:39:59'),(2,'data_types','display_name_singular',6,'pt','Página','2018-08-04 13:39:59','2018-08-04 13:39:59'),(3,'data_types','display_name_singular',1,'pt','Utilizador','2018-08-04 13:39:59','2018-08-04 13:39:59'),(4,'data_types','display_name_singular',4,'pt','Categoria','2018-08-04 13:39:59','2018-08-04 13:39:59'),(5,'data_types','display_name_singular',2,'pt','Menu','2018-08-04 13:39:59','2018-08-04 13:39:59'),(6,'data_types','display_name_singular',3,'pt','Função','2018-08-04 13:39:59','2018-08-04 13:39:59'),(7,'data_types','display_name_plural',5,'pt','Posts','2018-08-04 13:39:59','2018-08-04 13:39:59'),(8,'data_types','display_name_plural',6,'pt','Páginas','2018-08-04 13:39:59','2018-08-04 13:39:59'),(9,'data_types','display_name_plural',1,'pt','Utilizadores','2018-08-04 13:39:59','2018-08-04 13:39:59'),(10,'data_types','display_name_plural',4,'pt','Categorias','2018-08-04 13:39:59','2018-08-04 13:39:59'),(11,'data_types','display_name_plural',2,'pt','Menus','2018-08-04 13:39:59','2018-08-04 13:39:59'),(12,'data_types','display_name_plural',3,'pt','Funções','2018-08-04 13:39:59','2018-08-04 13:39:59'),(13,'categories','slug',1,'pt','categoria-1','2018-08-04 13:39:59','2018-08-04 13:39:59'),(14,'categories','name',1,'pt','Categoria 1','2018-08-04 13:39:59','2018-08-04 13:39:59'),(15,'categories','slug',2,'pt','categoria-2','2018-08-04 13:39:59','2018-08-04 13:39:59'),(16,'categories','name',2,'pt','Categoria 2','2018-08-04 13:39:59','2018-08-04 13:39:59'),(17,'pages','title',1,'pt','Olá Mundo','2018-08-04 13:39:59','2018-08-04 13:39:59'),(18,'pages','slug',1,'pt','ola-mundo','2018-08-04 13:39:59','2018-08-04 13:39:59'),(19,'pages','body',1,'pt','<p>Olá Mundo. Scallywag grog swab Cat o\'nine tails scuttle rigging hardtack cable nipper Yellow Jack. Handsomely spirits knave lad killick landlubber or just lubber deadlights chantey pinnace crack Jennys tea cup. Provost long clothes black spot Yellow Jack bilged on her anchor league lateen sail case shot lee tackle.</p>\r\n<p>Ballast spirits fluke topmast me quarterdeck schooner landlubber or just lubber gabion belaying pin. Pinnace stern galleon starboard warp carouser to go on account dance the hempen jig jolly boat measured fer yer chains. Man-of-war fire in the hole nipperkin handsomely doubloon barkadeer Brethren of the Coast gibbet driver squiffy.</p>','2018-08-04 13:39:59','2018-08-04 13:39:59'),(20,'menu_items','title',1,'pt','Painel de Controle','2018-08-04 13:39:59','2018-08-04 13:39:59'),(21,'menu_items','title',2,'pt','Media','2018-08-04 13:39:59','2018-08-04 13:39:59'),(22,'menu_items','title',12,'pt','Publicações','2018-08-04 13:39:59','2018-08-04 13:39:59'),(23,'menu_items','title',3,'pt','Utilizadores','2018-08-04 13:39:59','2018-08-04 13:39:59'),(24,'menu_items','title',11,'pt','Categorias','2018-08-04 13:39:59','2018-08-04 13:39:59'),(25,'menu_items','title',13,'pt','Páginas','2018-08-04 13:39:59','2018-08-04 13:39:59'),(26,'menu_items','title',4,'pt','Funções','2018-08-04 13:39:59','2018-08-04 13:39:59'),(27,'menu_items','title',5,'pt','Ferramentas','2018-08-04 13:39:59','2018-08-04 13:39:59'),(28,'menu_items','title',6,'pt','Menus','2018-08-04 13:39:59','2018-08-04 13:39:59'),(29,'menu_items','title',7,'pt','Base de dados','2018-08-04 13:39:59','2018-08-04 13:39:59'),(30,'menu_items','title',10,'pt','Configurações','2018-08-04 13:39:59','2018-08-04 13:39:59');
/*!40000 ALTER TABLE `translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `types`
--

DROP TABLE IF EXISTS `types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT '类型名称',
  `description` text COMMENT '类型简介',
  `condition` text COMMENT '申报条件',
  `budget` varchar(255) DEFAULT NULL COMMENT '预算',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `types`
--

LOCK TABLES `types` WRITE;
/*!40000 ALTER TABLE `types` DISABLE KEYS */;
INSERT INTO `types` VALUES (1,'类型一','阿斯顿发大水','按上级领导覅骄傲送抵放假哦','12k','2018-08-06 15:25:11','2018-08-06 15:25:11'),(2,'kyjj','阿斯顿佛i啊是大家佛教','哦i后的首府拉萨的减肥了就离开家','100','2018-08-06 19:35:28','2018-08-06 19:35:28'),(3,'类型45','加上独立房间','iu华东师范拉升阶段佛','i按时间都覅','2018-08-06 19:38:37','2018-08-06 19:38:37');
/*!40000 ALTER TABLE `types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_projects`
--

DROP TABLE IF EXISTS `user_projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_projects` (
  `user_id` int(10) unsigned NOT NULL,
  `project_id` int(10) unsigned NOT NULL,
  `whether_host` varchar(255) DEFAULT NULL COMMENT '是否是主持人',
  PRIMARY KEY (`user_id`,`project_id`) USING BTREE,
  KEY `mtm_user_projects_project_id` (`project_id`) USING BTREE,
  CONSTRAINT `mtm_user_projects_project_id` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mtm_user_projects_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_projects`
--

LOCK TABLES `user_projects` WRITE;
/*!40000 ALTER TABLE `user_projects` DISABLE KEYS */;
INSERT INTO `user_projects` VALUES (2,2,NULL);
/*!40000 ALTER TABLE `user_projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_roles` (
  `user_id` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`) USING BTREE,
  KEY `user_roles_user_id_index` (`user_id`) USING BTREE,
  KEY `user_roles_role_id_index` (`role_id`) USING BTREE,
  CONSTRAINT `user_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_roles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_roles`
--

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'users/default.png',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `settings` text COLLATE utf8mb4_unicode_ci,
  `uno` varchar(0) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '学号/工号',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `users_email_unique` (`email`) USING BTREE,
  KEY `users_role_id_foreign` (`role_id`) USING BTREE,
  CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (2,1,'tian','360726539@qq.com','users/default.png','$2y$10$1fd4W8kKypvo7u16lLEjLua.RQ.aZtAQm7MTdtOOscnNTjfZ7nOcq','VJ9cOtPzndVfghmlcqPEvGPcdu6WjRKccPM6MRQCzc2CEbbpIYONUjMA3B39','{\"locale\":\"zh_CN\"}',NULL,'2018-08-04 14:18:31','2018-08-06 13:24:52'),(6,3,'testmanager','123@456.com','users/default.png','$2y$10$GFUldmFTkOOXdaMWWJ/QaOIzEMpInRPZ6Wxj0EyQTiqPEV6KWC03K','CLLewY0fDzDAc9gTX9tBl48x7UE2SxvaYOZ45FcdhnQRnqoUblcD0CmRee7K',NULL,NULL,'2018-08-27 11:04:26','2018-08-27 11:08:09'),(7,2,'testuser','12@34.com','users/default.png','$2y$10$i8LKE31cZnNoT7M.h/yyyuN8iD4iEjImSqEVHmcWkGXt8s1VmGtyq','vR55TGHNVHtoLOA6RwazwpJX6IwCfDcAYFJnIJxyGxdXmKNnLEl0r9tc6O5j',NULL,NULL,'2018-08-27 11:06:04','2018-08-27 11:06:04');
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

-- Dump completed on 2018-08-27  3:55:34
