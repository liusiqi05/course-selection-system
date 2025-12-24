-- MySQL dump 10.13  Distrib 5.7.24, for osx11.1 (x86_64)
--
-- Host: localhost    Database: course_selection
-- ------------------------------------------------------
-- Server version	9.3.0

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
-- Current Database: `course_selection`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `course_selection` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `course_selection`;

--
-- Table structure for table `course_evaluation`
--

DROP TABLE IF EXISTS `course_evaluation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_evaluation` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `student_id` bigint NOT NULL COMMENT '学生ID',
  `course_id` bigint NOT NULL COMMENT '课程ID',
  `teacher_rating` int DEFAULT '5' COMMENT '教师评分（1-5星）',
  `course_rating` int DEFAULT '5' COMMENT '课程评分（1-5星）',
  `content` text COLLATE utf8mb4_general_ci COMMENT '评价内容',
  `is_anonymous` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '是否匿名（0否 1是）',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5000 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='课程评价表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_evaluation`
--

LOCK TABLES `course_evaluation` WRITE;
/*!40000 ALTER TABLE `course_evaluation` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_evaluation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_info`
--

DROP TABLE IF EXISTS `course_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_info` (
  `course_id` bigint NOT NULL AUTO_INCREMENT COMMENT '课程ID',
  `course_code` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '课程编号',
  `course_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '课程名称',
  `course_type` char(1) COLLATE utf8mb4_general_ci DEFAULT '1' COMMENT '课程类型（1必修 2选修 3通识）',
  `credit` decimal(3,1) DEFAULT '0.0' COMMENT '学分',
  `hours` int DEFAULT '0' COMMENT '学时',
  `dept_id` bigint NOT NULL COMMENT '开课学院ID',
  `teacher_id` bigint DEFAULT NULL COMMENT '授课教师ID',
  `teacher_name` varchar(30) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '授课教师姓名',
  `max_students` int DEFAULT '50' COMMENT '最大选课人数',
  `current_students` int DEFAULT '0' COMMENT '已选课人数',
  `semester` varchar(20) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '学期（如：2024-2025-1）',
  `year` varchar(10) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '学年（如：2024）',
  `description` text COLLATE utf8mb4_general_ci COMMENT '课程描述',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '课程状态（0正常 1停用）',
  `del_flag` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`course_id`),
  UNIQUE KEY `uk_course_code` (`course_code`)
) ENGINE=InnoDB AUTO_INCREMENT=1006 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='课程信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_info`
--

LOCK TABLES `course_info` WRITE;
/*!40000 ALTER TABLE `course_info` DISABLE KEYS */;
INSERT INTO `course_info` VALUES (1001,'CS101','数据结构','1',4.0,64,101,2,'张教授',120,0,'2024-2025-1','2024','学习各种数据结构的原理和应用','0','0','admin','2025-12-18 15:46:08','',NULL,''),(1002,'CS102','算法设计与分析','1',4.0,64,101,2,'张教授',100,0,'2024-2025-1','2024','学习算法设计的基本方法和复杂度分析','0','0','admin','2025-12-18 15:46:08','',NULL,''),(1003,'CS201','数据库原理','1',3.0,48,101,2,'张教授',80,0,'2024-2025-1','2024','关系数据库的基本原理和SQL语言','0','0','admin','2025-12-18 15:46:08','',NULL,''),(1004,'CS301','人工智能导论','2',3.0,48,101,2,'张教授',60,0,'2024-2025-1','2024','人工智能的基本概念和应用','0','0','admin','2025-12-18 15:46:08','',NULL,''),(1005,'GE101','大学英语','3',2.0,32,104,NULL,'外语系教师',150,0,'2024-2025-1','2024','提高英语听说读写能力','0','0','admin','2025-12-18 15:46:08','',NULL,'');
/*!40000 ALTER TABLE `course_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_schedule`
--

DROP TABLE IF EXISTS `course_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_schedule` (
  `schedule_id` bigint NOT NULL AUTO_INCREMENT COMMENT '排课ID',
  `course_id` bigint NOT NULL COMMENT '课程ID（外键关联course_info）',
  `week_day` int NOT NULL COMMENT '星期几（1-7）',
  `start_week` int NOT NULL COMMENT '开始周次',
  `end_week` int NOT NULL COMMENT '结束周次',
  `start_time` varchar(5) COLLATE utf8mb4_general_ci NOT NULL COMMENT '开始时间（如：08:00）',
  `end_time` varchar(5) COLLATE utf8mb4_general_ci NOT NULL COMMENT '结束时间（如：09:40）',
  `classroom` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '教室',
  `building` varchar(30) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '教学楼',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`schedule_id`),
  KEY `idx_course_id` (`course_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2007 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='课程排课表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_schedule`
--

LOCK TABLES `course_schedule` WRITE;
/*!40000 ALTER TABLE `course_schedule` DISABLE KEYS */;
INSERT INTO `course_schedule` VALUES (2001,1001,1,1,16,'08:00','09:40','A101','教学楼A','admin','2025-12-18 15:46:08','',NULL),(2002,1001,3,1,16,'10:00','11:40','A101','教学楼A','admin','2025-12-18 15:46:08','',NULL),(2003,1002,2,1,16,'14:00','15:40','A102','教学楼A','admin','2025-12-18 15:46:08','',NULL),(2004,1002,4,1,16,'14:00','15:40','A102','教学楼A','admin','2025-12-18 15:46:08','',NULL),(2005,1003,1,1,16,'14:00','15:40','B201','教学楼B','admin','2025-12-18 15:46:08','',NULL),(2006,1003,3,1,16,'14:00','15:40','B201','教学楼B','admin','2025-12-18 15:46:08','',NULL);
/*!40000 ALTER TABLE `course_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_selection_time`
--

DROP TABLE IF EXISTS `course_selection_time`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_selection_time` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `semester` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '学期',
  `start_time` datetime NOT NULL COMMENT '选课开始时间',
  `end_time` datetime NOT NULL COMMENT '选课结束时间',
  `withdraw_end_time` datetime DEFAULT NULL COMMENT '退课截止时间',
  `grade_limit` varchar(10) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '年级限制（为空表示不限）',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4002 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='选课时间配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_selection_time`
--

LOCK TABLES `course_selection_time` WRITE;
/*!40000 ALTER TABLE `course_selection_time` DISABLE KEYS */;
INSERT INTO `course_selection_time` VALUES (4001,'2024-2025-1','2024-08-20 08:00:00','2024-09-05 23:59:59','2024-09-15 23:59:59','','0','admin','2025-12-18 15:46:08','',NULL,'2024-2025学年第一学期选课');
/*!40000 ALTER TABLE `course_selection_time` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `edu_college`
--

DROP TABLE IF EXISTS `edu_college`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `edu_college` (
  `college_id` bigint NOT NULL AUTO_INCREMENT,
  `college_code` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '学院代码',
  `college_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '学院名称',
  `dean_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '院长姓名',
  `phone` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '联系电话',
  `email` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '邮箱',
  `address` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '办公地址',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态(0正常 1停用)',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '',
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '',
  `update_time` datetime DEFAULT NULL,
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`college_id`),
  UNIQUE KEY `uk_college_code` (`college_code`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='学院信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `edu_college`
--

LOCK TABLES `edu_college` WRITE;
/*!40000 ALTER TABLE `edu_college` DISABLE KEYS */;
INSERT INTO `edu_college` VALUES (1,'CS','计算机工程与科学学院','李建国','021-66134431','cs@shu.edu.cn','计算机大楼A座','0','','2025-12-21 17:10:34','',NULL,NULL),(2,'ME','机电工程与自动化学院','王志强','021-66134432','me@shu.edu.cn','机电楼','0','','2025-12-21 17:10:34','',NULL,NULL),(3,'MS','理学院','陈明华','021-66134433','math@shu.edu.cn','理学大楼','0','','2025-12-21 17:10:34','',NULL,NULL),(4,'EE','通信与信息工程学院','赵国庆','021-66134434','ee@shu.edu.cn','通信楼','0','','2025-12-21 17:10:34','',NULL,NULL),(5,'MA','管理学院','刘德华','021-66134435','ma@shu.edu.cn','管理楼','0','','2025-12-21 17:10:34','',NULL,NULL),(6,'FL','外国语学院','张秀英','021-66134436','fl@shu.edu.cn','外语楼','0','','2025-12-21 17:10:34','',NULL,NULL),(7,'EC','经济学院','周建伟','021-66134437','ec@shu.edu.cn','经管大楼A座','0','','2025-12-21 17:10:34','',NULL,NULL),(8,'CE','土木工程系','吴建设','021-66134438','ce@shu.edu.cn','土木楼','0','','2025-12-21 17:10:34','',NULL,NULL),(9,'MT','材料科学与工程学院','孙伟民','021-66134439','mt@shu.edu.cn','材料楼','0','','2025-12-21 17:10:34','',NULL,NULL),(10,'ART','美术学院','黄艺术','021-66134440','art@shu.edu.cn','美术楼','0','','2025-12-21 17:10:34','',NULL,NULL);
/*!40000 ALTER TABLE `edu_college` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `edu_course`
--

DROP TABLE IF EXISTS `edu_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `edu_course` (
  `course_id` bigint NOT NULL AUTO_INCREMENT COMMENT '课程ID',
  `course_code` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '课程代码',
  `course_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '课程名称',
  `dept_id` bigint DEFAULT NULL COMMENT '开课学院ID',
  `credit` decimal(3,1) NOT NULL DEFAULT '0.0' COMMENT '学分',
  `hours` int DEFAULT '0' COMMENT '学时',
  `course_type` char(1) COLLATE utf8mb4_general_ci DEFAULT '1' COMMENT '课程类型 (1必修 2选修 3公选)',
  `description` varchar(500) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '课程简介',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态 (0正常 1停用)',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`course_id`),
  UNIQUE KEY `uk_course_code` (`course_code`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='课程信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `edu_course`
--

LOCK TABLES `edu_course` WRITE;
/*!40000 ALTER TABLE `edu_course` DISABLE KEYS */;
INSERT INTO `edu_course` VALUES (1,'CS101','程序设计基础',101,4.0,64,'1','C语言程序设计入门课程','0','admin','2025-12-18 15:46:15','',NULL,''),(2,'CS201','数据结构',101,4.0,64,'1','数据结构与算法基础','0','admin','2025-12-18 15:46:15','',NULL,''),(3,'CS301','操作系统',101,3.5,56,'1','计算机操作系统原理','0','admin','2025-12-18 15:46:15','',NULL,''),(4,'CS401','计算机网络',101,3.0,48,'1','计算机网络原理与应用','0','admin','2025-12-18 15:46:15','',NULL,''),(5,'GE101','大学英语',104,2.0,32,'1','大学英语基础课程','0','admin','2025-12-18 15:46:15','',NULL,''),(6,'GE201','高等数学',105,4.0,64,'1','高等数学基础','0','admin','2025-12-18 15:46:15','',NULL,''),(7,'EL101','Python编程',101,2.0,32,'2','Python程序设计选修课','0','admin','2025-12-18 15:46:15','',NULL,''),(8,'EL102','人工智能导论',101,2.0,32,'3','AI入门公选课','0','admin','2025-12-18 15:46:15','',NULL,''),(25,'CS202','操作系统',103,3.5,56,'1','介绍操作系统的基本原理','0','admin','2025-12-20 15:20:54','',NULL,NULL),(26,'CS203','计算机网络',103,3.0,48,'1','计算机网络基本原理和TCP/IP协议','0','admin','2025-12-20 15:20:54','',NULL,NULL),(27,'CS302','软件工程',103,3.0,48,'1','软件开发的基本方法和过程','0','admin','2025-12-20 15:20:54','',NULL,NULL),(28,'CS402','Python程序设计',103,2.5,40,'2','Python语言基础及数据分析应用','0','admin','2025-12-20 15:20:54','',NULL,NULL),(29,'MA101','高等数学(上)',104,5.0,80,'1','函数、极限、导数、积分','0','admin','2025-12-20 15:20:54','',NULL,NULL),(30,'MA102','高等数学(下)',104,5.0,80,'1','多元函数微积分、无穷级数','0','admin','2025-12-20 15:20:54','',NULL,NULL),(31,'MA201','线性代数',104,3.0,48,'1','矩阵、行列式、线性方程组','0','admin','2025-12-20 15:20:54','',NULL,NULL),(32,'MA202','概率论与数理统计',104,3.0,48,'1','随机事件与概率、统计推断','0','admin','2025-12-20 15:20:54','',NULL,NULL),(33,'EN101','大学英语(1)',105,2.0,32,'1','大学英语基础课程','0','admin','2025-12-20 15:20:54','',NULL,NULL),(34,'EN102','大学英语(2)',105,2.0,32,'1','大学英语进阶课程','0','admin','2025-12-20 15:20:54','',NULL,NULL),(35,'GE001','体育(1)',100,1.0,32,'1','体育基础课程','0','admin','2025-12-20 15:20:54','',NULL,NULL),(36,'GE002','创新创业基础',100,2.0,32,'3','创新思维与创业实践入门','0','admin','2025-12-20 15:20:54','',NULL,NULL),(65,'MEC101','机械制图',NULL,3.0,0,'1','机械工程专业基础课','0','','2025-12-21 17:13:35','',NULL,NULL),(66,'MEC102','工程力学',NULL,4.0,0,'1','力学分析与计算','0','','2025-12-21 17:13:35','',NULL,NULL),(67,'MEC201','机械原理',NULL,3.5,0,'1','机械传动与机构','0','','2025-12-21 17:13:35','',NULL,NULL),(68,'MEC301','自动控制原理',NULL,4.0,0,'1','控制系统分析与设计','0','','2025-12-21 17:13:35','',NULL,NULL),(69,'PHY101','大学物理(上)',NULL,3.5,0,'1','力学与热学','0','','2025-12-21 17:13:35','',NULL,NULL),(70,'PHY102','大学物理(下)',NULL,3.5,0,'1','电磁学与光学','0','','2025-12-21 17:13:35','',NULL,NULL),(71,'PHY201','大学物理实验',NULL,2.0,0,'3','物理实验','0','','2025-12-21 17:13:35','',NULL,NULL),(72,'CHE101','无机化学',NULL,3.0,0,'1','无机化学基础','0','','2025-12-21 17:13:35','',NULL,NULL),(73,'EEC101','电路分析',NULL,4.0,0,'1','电路基础理论','0','','2025-12-21 17:13:35','',NULL,NULL),(74,'EEC102','模拟电子技术',NULL,4.0,0,'1','模拟电路设计','0','','2025-12-21 17:13:35','',NULL,NULL),(75,'EEC201','数字电子技术',NULL,3.5,0,'1','数字电路设计','0','','2025-12-21 17:13:35','',NULL,NULL),(76,'EEC301','信号与系统',NULL,4.0,0,'1','信号处理基础','0','','2025-12-21 17:13:35','',NULL,NULL),(77,'MGT101','管理学原理',NULL,3.0,0,'1','管理基础理论','0','','2025-12-21 17:13:35','',NULL,NULL),(78,'MGT102','微观经济学',NULL,3.0,0,'1','经济学基础','0','','2025-12-21 17:13:35','',NULL,NULL),(79,'MGT201','财务管理',NULL,3.0,0,'1','企业财务管理','0','','2025-12-21 17:13:35','',NULL,NULL),(80,'MGT301','市场营销',NULL,3.0,0,'2','营销理论与实践','0','','2025-12-21 17:13:35','',NULL,NULL),(81,'ENG101','综合英语(1)',NULL,4.0,0,'1','英语综合能力','0','','2025-12-21 17:13:35','',NULL,NULL),(82,'ENG102','综合英语(2)',NULL,4.0,0,'1','英语综合能力进阶','0','','2025-12-21 17:13:35','',NULL,NULL),(83,'ENG201','英语写作',NULL,2.0,0,'1','写作技能','0','','2025-12-21 17:13:35','',NULL,NULL),(84,'JPN101','基础日语(1)',NULL,4.0,0,'1','日语入门','0','','2025-12-21 17:13:35','',NULL,NULL),(85,'ECO101','宏观经济学',NULL,3.0,0,'1','宏观经济分析','0','','2025-12-21 17:13:35','',NULL,NULL),(86,'ECO102','金融学',NULL,3.0,0,'1','金融基础','0','','2025-12-21 17:13:35','',NULL,NULL),(87,'ECO201','国际贸易',NULL,3.0,0,'1','国际贸易理论','0','','2025-12-21 17:13:35','',NULL,NULL),(88,'ECO301','证券投资',NULL,3.0,0,'2','证券分析','0','','2025-12-21 17:13:35','',NULL,NULL);
/*!40000 ALTER TABLE `edu_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `edu_course_evaluation`
--

DROP TABLE IF EXISTS `edu_course_evaluation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `edu_course_evaluation` (
  `eval_id` bigint NOT NULL AUTO_INCREMENT COMMENT '评价ID',
  `sc_id` bigint NOT NULL COMMENT '选课记录ID',
  `student_id` bigint NOT NULL COMMENT '学生ID',
  `open_id` bigint NOT NULL COMMENT '开课ID',
  `teaching_score` int DEFAULT NULL COMMENT '教学质量评分(1-5)',
  `content_score` int DEFAULT NULL COMMENT '课程内容评分(1-5)',
  `difficulty_score` int DEFAULT NULL COMMENT '难度适中评分(1-5)',
  `workload_score` int DEFAULT NULL COMMENT '作业量评分(1-5)',
  `overall_score` int DEFAULT NULL COMMENT '总体评分(1-5)',
  `comment` text COMMENT '文字评价',
  `is_anonymous` char(1) DEFAULT '1' COMMENT '是否匿名(0否 1是)',
  `eval_time` datetime DEFAULT NULL COMMENT '评价时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`eval_id`),
  UNIQUE KEY `uk_sc_id` (`sc_id`),
  KEY `idx_open_id` (`open_id`),
  KEY `idx_student_id` (`student_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='课程评价表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `edu_course_evaluation`
--

LOCK TABLES `edu_course_evaluation` WRITE;
/*!40000 ALTER TABLE `edu_course_evaluation` DISABLE KEYS */;
INSERT INTO `edu_course_evaluation` VALUES (1,11,4,26,5,4,3,3,4,'数据结构课程内容充实，老师讲解清晰！','0','2025-12-21 17:06:41','2025-12-21 17:06:41',NULL),(2,12,4,27,4,5,4,4,5,'操作系统是非常重要的基础课，老师讲得很好。','1','2025-12-21 17:06:41','2025-12-21 17:06:41',NULL),(3,14,5,26,5,5,3,3,5,'数据结构让我对算法有了深入理解，感谢老师！','0','2025-12-21 17:06:41','2025-12-21 17:06:41',NULL),(4,15,5,28,4,4,5,4,4,'操作系统比较难，但老师很有耐心。','1','2025-12-21 17:06:41','2025-12-21 17:06:41',NULL),(5,17,6,26,5,4,4,3,4,'数据结构课程设计很好，实践性强。','0','2025-12-21 17:06:41','2025-12-21 17:06:41',NULL),(6,18,6,27,4,4,4,4,4,'操作系统课程内容丰富，收获很大。','0','2025-12-21 17:06:41','2025-12-21 17:06:41',NULL),(7,20,7,26,5,5,4,4,5,'数据结构老师讲解深入浅出，很好理解。','1','2025-12-21 17:06:41','2025-12-21 17:06:41',NULL),(8,26,9,23,4,4,3,3,4,'程序设计基础是入门编程的好课程！','0','2025-12-21 17:06:41','2025-12-21 17:06:41',NULL);
/*!40000 ALTER TABLE `edu_course_evaluation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `edu_course_opening`
--

DROP TABLE IF EXISTS `edu_course_opening`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `edu_course_opening` (
  `open_id` bigint NOT NULL AUTO_INCREMENT COMMENT '开课ID',
  `term_id` bigint NOT NULL COMMENT '学期ID',
  `course_id` bigint NOT NULL COMMENT '课程ID',
  `teacher_id` bigint NOT NULL COMMENT '授课教师ID (edu_teacher.teacher_id)',
  `class_time` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '上课时间 (如: 周一1-2节,周三3-4节)',
  `class_location` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '上课地点',
  `max_students` int DEFAULT '50' COMMENT '课程容量',
  `selected_num` int DEFAULT '0' COMMENT '已选人数',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态 (0报名中 1已开课 2已结课)',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`open_id`),
  KEY `idx_term_course` (`term_id`,`course_id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='开课安排表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `edu_course_opening`
--

LOCK TABLES `edu_course_opening` WRITE;
/*!40000 ALTER TABLE `edu_course_opening` DISABLE KEYS */;
INSERT INTO `edu_course_opening` VALUES (1,2,1,1,'周一1-2节,周三1-2节','教学楼A101',60,0,'1','admin','2025-12-18 15:46:15','',NULL,''),(2,2,2,1,'周二3-4节,周四3-4节','教学楼A102',50,0,'1','admin','2025-12-18 15:46:15','',NULL,''),(3,2,3,1,'周一5-6节,周三5-6节','教学楼B201',45,0,'1','admin','2025-12-18 15:46:15','',NULL,''),(4,2,5,1,'周二1-2节','教学楼C301',80,0,'1','admin','2025-12-18 15:46:15','',NULL,''),(5,2,7,1,'周五1-2节','机房D101',40,0,'1','admin','2025-12-18 15:46:15','',NULL,''),(6,2,8,1,'周四7-8节','教学楼A201',100,0,'1','admin','2025-12-18 15:46:15','',NULL,''),(7,2,2,2,'周一3-4节,周三3-4节','教学楼A301',60,0,'1','admin','2025-12-20 15:21:34','',NULL,NULL),(8,2,25,3,'周二1-2节,周四1-2节','教学楼A302',50,0,'1','admin','2025-12-20 15:21:34','',NULL,NULL),(9,2,3,2,'周一5-6节,周四5-6节','教学楼B201',45,0,'1','admin','2025-12-20 15:21:34','',NULL,NULL),(10,2,27,3,'周三1-2节,周五1-2节','教学楼B202',55,0,'1','admin','2025-12-20 15:21:34','',NULL,NULL),(11,2,4,1,'周二5-6节,周五5-6节','教学楼A401',40,0,'1','admin','2025-12-20 15:21:34','',NULL,NULL),(12,2,28,1,'周三5-6节','机房C101',35,0,'1','admin','2025-12-20 15:21:34','',NULL,NULL),(13,2,30,4,'周一1-2节,周三1-2节,周五1-2节','教学楼D101',120,0,'1','admin','2025-12-20 15:21:34','',NULL,NULL),(14,2,31,4,'周二3-4节,周四3-4节','教学楼D102',100,0,'1','admin','2025-12-20 15:21:34','',NULL,NULL),(15,2,32,4,'周一7-8节,周三7-8节','教学楼D103',80,0,'1','admin','2025-12-20 15:21:34','',NULL,NULL),(16,2,34,5,'周二7-8节,周四7-8节','外语楼E201',40,0,'1','admin','2025-12-20 15:21:34','',NULL,NULL),(17,2,36,1,'周六上午','创业园区',100,0,'1','admin','2025-12-20 15:21:34','',NULL,NULL),(18,1,1,1,'周一1-2节,周三1-2节','教学楼A101',60,0,'1','admin','2024-09-01 00:00:00','',NULL,NULL),(19,1,29,4,'周一3-4节,周三3-4节,周五3-4节','教学楼D101',120,0,'1','admin','2024-09-01 00:00:00','',NULL,NULL),(20,1,33,5,'周二1-2节,周四1-2节','外语楼E101',45,0,'1','admin','2024-09-01 00:00:00','',NULL,NULL),(21,1,35,1,'周五7-8节','体育馆',100,0,'1','admin','2024-09-01 00:00:00','',NULL,NULL),(22,1,2,2,'周二3-4节,周四3-4节','教学楼A201',55,0,'1','admin','2024-09-01 00:00:00','',NULL,NULL),(23,3,1,1,'周一1-2节,周三1-2节','教学楼A101',60,0,'1','admin','2025-12-20 15:25:20','','2025-12-21 19:56:38',NULL),(24,3,29,4,'周一3-4节,周三3-4节,周五3-4节','教学楼D101',120,6,'1','admin','2025-12-20 15:25:20','','2025-12-21 19:56:38',NULL),(25,3,33,5,'周二1-2节,周四1-2节','外语楼E101',45,5,'1','admin','2025-12-20 15:25:20','','2025-12-21 19:56:38',NULL),(26,3,2,2,'周二3-4节,周四3-4节','教学楼A201',55,6,'1','admin','2025-12-20 15:25:20','','2025-12-21 19:56:38',NULL),(27,3,25,3,'周一5-6节,周三5-6节','教学楼B201',50,2,'1','admin','2025-12-20 15:25:20','','2025-12-21 19:56:38',NULL),(28,3,3,2,'周二5-6节,周四5-6节','教学楼B301',45,2,'1','admin','2025-12-20 15:25:20','','2025-12-21 19:56:38',NULL),(29,3,31,4,'周二7-8节,周四7-8节','教学楼D102',100,4,'1','admin','2025-12-20 15:25:20','','2025-12-21 19:56:38',NULL),(30,3,28,1,'周五1-2节','机房D101',40,4,'1','admin','2025-12-20 15:25:20','','2025-12-21 19:56:38',NULL),(31,3,36,1,'周六上午','创业园区',100,4,'1','admin','2025-12-20 15:25:20','','2025-12-21 19:56:38',NULL),(32,4,30,4,'周一3-4节,周三3-4节,周五3-4节','教学楼D101',120,5,'1','admin','2025-12-20 15:25:34','','2025-12-21 20:03:17',NULL),(33,4,34,5,'周二1-2节,周四1-2节','外语楼E101',45,6,'1','admin','2025-12-20 15:25:34','','2025-12-21 20:03:17',NULL),(34,4,27,3,'周一1-2节,周三1-2节','教学楼B202',55,5,'1','admin','2025-12-20 15:25:34','','2025-12-21 20:03:17',NULL),(35,4,26,2,'周二3-4节,周四3-4节','教学楼A301',50,30,'1','admin','2025-12-20 15:25:34','','2025-12-21 20:03:17',NULL),(36,4,32,4,'周一7-8节,周三7-8节','教学楼D103',80,3,'1','admin','2025-12-20 15:25:34','','2025-12-21 20:03:17',NULL),(37,4,4,1,'周五5-6节','教学楼A401',60,5,'1','admin','2025-12-20 15:25:34','','2025-12-21 20:03:17',NULL),(38,4,4,3,'周一1-2节,周四5-6节','理工楼202',50,29,'1','',NULL,'','2025-12-21 20:03:17',NULL),(39,4,65,14,'周一1-2节,周三1-2节','机电楼201',45,6,'1','','2025-12-21 17:14:01','','2025-12-21 20:03:17',NULL),(40,4,66,14,'周二3-4节,周四3-4节','机电楼202',45,6,'1','','2025-12-21 17:14:01','','2025-12-21 20:03:17',NULL),(41,4,67,15,'周一5-6节,周三5-6节','机电楼301',40,0,'1','','2025-12-21 17:14:01','','2025-12-21 20:03:17',NULL),(42,4,68,15,'周二5-6节,周四5-6节','机电楼302',40,0,'1','','2025-12-21 17:14:01','','2025-12-21 20:03:17',NULL),(43,4,69,17,'周一3-4节,周三3-4节,周五3-4节','理学楼101',60,37,'1','','2025-12-21 17:14:01','','2025-12-21 20:03:17',NULL),(44,4,70,17,'周二3-4节,周四3-4节','理学楼102',60,6,'1','','2025-12-21 17:14:01','','2025-12-21 20:03:17',NULL),(45,4,71,19,'周五5-6节','物理实验楼',30,6,'1','','2025-12-21 17:14:01','','2025-12-21 20:03:17',NULL),(46,4,73,20,'周一1-2节,周三1-2节','通信楼201',50,5,'1','','2025-12-21 17:14:01','','2025-12-21 20:03:17',NULL),(47,4,74,20,'周二3-4节,周四3-4节','通信楼202',50,5,'1','','2025-12-21 17:14:01','','2025-12-21 20:03:17',NULL),(48,4,75,21,'周一5-6节,周三5-6节','通信楼301',45,5,'1','','2025-12-21 17:14:01','','2025-12-21 20:03:17',NULL),(49,4,76,21,'周二5-6节,周四5-6节','通信楼302',45,0,'1','','2025-12-21 17:14:01','','2025-12-21 20:03:17',NULL),(50,4,77,22,'周一1-2节,周三1-2节','管理楼201',50,6,'1','','2025-12-21 17:14:01','','2025-12-21 20:03:17',NULL),(51,4,78,22,'周二3-4节,周四3-4节','管理楼202',50,6,'1','','2025-12-21 17:14:01','','2025-12-21 20:03:17',NULL),(52,4,79,23,'周一5-6节,周三5-6节','管理楼301',45,6,'1','','2025-12-21 17:14:01','','2025-12-21 20:03:17',NULL),(53,4,80,23,'周二5-6节','管理楼302',45,0,'1','','2025-12-21 17:14:01','','2025-12-21 20:03:17',NULL),(54,4,81,24,'周一1-2节,周三1-2节','外语楼201',35,5,'1','','2025-12-21 17:14:01','','2025-12-21 20:03:17',NULL),(55,4,82,24,'周二3-4节,周四3-4节','外语楼202',35,5,'1','','2025-12-21 17:14:01','','2025-12-21 20:03:17',NULL),(56,4,83,24,'周五1-2节','外语楼203',30,5,'1','','2025-12-21 17:14:01','','2025-12-21 20:03:17',NULL),(57,4,84,25,'周一5-6节,周三5-6节','外语楼301',30,0,'1','','2025-12-21 17:14:01','','2025-12-21 20:03:17',NULL),(58,4,85,26,'周一1-2节,周三1-2节','经管楼201',50,6,'1','','2025-12-21 17:14:01','','2025-12-21 20:03:17',NULL),(59,4,86,26,'周二3-4节,周四3-4节','经管楼202',50,6,'1','','2025-12-21 17:14:01','','2025-12-21 20:03:17',NULL),(60,4,87,27,'周一5-6节,周三5-6节','经管楼301',45,6,'1','','2025-12-21 17:14:01','','2025-12-21 20:03:17',NULL),(61,4,88,27,'周二5-6节,周四5-6节','经管楼302',45,0,'1','','2025-12-21 17:14:01','','2025-12-21 20:03:17',NULL);
/*!40000 ALTER TABLE `edu_course_opening` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `edu_major`
--

DROP TABLE IF EXISTS `edu_major`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `edu_major` (
  `major_id` bigint NOT NULL AUTO_INCREMENT,
  `major_code` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '专业代码',
  `major_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '专业名称',
  `college_id` bigint NOT NULL COMMENT '所属学院',
  `degree_type` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '学位类型(工学/理学/管理学等)',
  `study_years` int DEFAULT '4' COMMENT '学制年限',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态(0正常 1停用)',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '',
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '',
  `update_time` datetime DEFAULT NULL,
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`major_id`),
  UNIQUE KEY `uk_major_code` (`major_code`),
  KEY `idx_college_id` (`college_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='专业信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `edu_major`
--

LOCK TABLES `edu_major` WRITE;
/*!40000 ALTER TABLE `edu_major` DISABLE KEYS */;
INSERT INTO `edu_major` VALUES (1,'CS01','计算机科学与技术',1,'工学',4,'0','','2025-12-21 17:10:47','',NULL,NULL),(2,'CS02','软件工程',1,'工学',4,'0','','2025-12-21 17:10:47','',NULL,NULL),(3,'CS03','人工智能',1,'工学',4,'0','','2025-12-21 17:10:47','',NULL,NULL),(4,'CS04','数据科学与大数据技术',1,'工学',4,'0','','2025-12-21 17:10:47','',NULL,NULL),(5,'CS05','网络空间安全',1,'工学',4,'0','','2025-12-21 17:10:47','',NULL,NULL),(6,'ME01','机械工程',2,'工学',4,'0','','2025-12-21 17:10:47','',NULL,NULL),(7,'ME02','自动化',2,'工学',4,'0','','2025-12-21 17:10:47','',NULL,NULL),(8,'ME03','电气工程及其自动化',2,'工学',4,'0','','2025-12-21 17:10:47','',NULL,NULL),(9,'ME04','机器人工程',2,'工学',4,'0','','2025-12-21 17:10:47','',NULL,NULL),(10,'MS01','数学与应用数学',3,'理学',4,'0','','2025-12-21 17:10:47','',NULL,NULL),(11,'MS02','信息与计算科学',3,'理学',4,'0','','2025-12-21 17:10:47','',NULL,NULL),(12,'MS03','物理学',3,'理学',4,'0','','2025-12-21 17:10:47','',NULL,NULL),(13,'MS04','应用化学',3,'理学',4,'0','','2025-12-21 17:10:47','',NULL,NULL),(14,'EE01','通信工程',4,'工学',4,'0','','2025-12-21 17:10:47','',NULL,NULL),(15,'EE02','电子信息工程',4,'工学',4,'0','','2025-12-21 17:10:47','',NULL,NULL),(16,'EE03','信息安全',4,'工学',4,'0','','2025-12-21 17:10:47','',NULL,NULL),(17,'MA01','工商管理',5,'管理学',4,'0','','2025-12-21 17:10:47','',NULL,NULL),(18,'MA02','信息管理与信息系统',5,'管理学',4,'0','','2025-12-21 17:10:47','',NULL,NULL),(19,'MA03','会计学',5,'管理学',4,'0','','2025-12-21 17:10:47','',NULL,NULL),(20,'MA04','人力资源管理',5,'管理学',4,'0','','2025-12-21 17:10:47','',NULL,NULL),(21,'FL01','英语',6,'文学',4,'0','','2025-12-21 17:10:47','',NULL,NULL),(22,'FL02','日语',6,'文学',4,'0','','2025-12-21 17:10:47','',NULL,NULL),(23,'FL03','翻译',6,'文学',4,'0','','2025-12-21 17:10:47','',NULL,NULL),(24,'EC01','经济学',7,'经济学',4,'0','','2025-12-21 17:10:47','',NULL,NULL),(25,'EC02','金融学',7,'经济学',4,'0','','2025-12-21 17:10:47','',NULL,NULL),(26,'EC03','国际经济与贸易',7,'经济学',4,'0','','2025-12-21 17:10:47','',NULL,NULL),(27,'CE01','土木工程',8,'工学',4,'0','','2025-12-21 17:10:47','',NULL,NULL),(28,'CE02','建筑环境与能源应用工程',8,'工学',4,'0','','2025-12-21 17:10:47','',NULL,NULL),(29,'MT01','材料科学与工程',9,'工学',4,'0','','2025-12-21 17:10:47','',NULL,NULL),(30,'MT02','高分子材料与工程',9,'工学',4,'0','','2025-12-21 17:10:47','',NULL,NULL),(31,'ART01','视觉传达设计',10,'艺术学',4,'0','','2025-12-21 17:10:47','',NULL,NULL),(32,'ART02','环境设计',10,'艺术学',4,'0','','2025-12-21 17:10:47','',NULL,NULL);
/*!40000 ALTER TABLE `edu_major` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `edu_student`
--

DROP TABLE IF EXISTS `edu_student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `edu_student` (
  `student_id` bigint NOT NULL AUTO_INCREMENT COMMENT '学生ID',
  `user_id` bigint NOT NULL COMMENT '关联系统用户ID (sys_user.user_id)',
  `college_id` bigint DEFAULT NULL COMMENT '所属学院',
  `major_id` bigint DEFAULT NULL COMMENT '所属专业',
  `class_name` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '班级名称',
  `enrollment_date` date DEFAULT NULL COMMENT '入学日期',
  `expected_graduation` date DEFAULT NULL COMMENT '预计毕业日期',
  `student_status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '学籍状态 (0在读 1毕业 2休学 3退学)',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`student_id`),
  UNIQUE KEY `uk_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='学生信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `edu_student`
--

LOCK TABLES `edu_student` WRITE;
/*!40000 ALTER TABLE `edu_student` DISABLE KEYS */;
INSERT INTO `edu_student` VALUES (1,3,1,1,'计科2101班','2021-09-01','2025-06-30','0','admin','2025-12-18 15:46:15','',NULL,'测试学生'),(2,100,1,1,'',NULL,NULL,'0','','2025-12-18 16:09:36','',NULL,NULL),(3,101,1,1,'',NULL,NULL,'0','','2025-12-18 17:07:48','',NULL,NULL),(4,106,1,1,'计科2101班','2021-09-01','2025-06-30','0','admin','2025-12-20 15:19:04','',NULL,'班长'),(5,107,1,1,'软工2101班','2021-09-01','2025-06-30','0','admin','2025-12-20 15:19:04','',NULL,'学习委员'),(6,108,1,1,'计科2101班','2021-09-01','2025-06-30','0','admin','2025-12-20 15:19:04','',NULL,NULL),(7,109,1,1,'信计2101班','2021-09-01','2025-06-30','0','admin','2025-12-20 15:19:04','',NULL,NULL),(8,110,1,2,'软工2101班','2021-09-01','2025-06-30','0','admin','2025-12-20 15:19:04','',NULL,'体育委员'),(9,111,1,2,'计科2201班','2022-09-01','2026-06-30','0','admin','2025-12-20 15:19:04','',NULL,NULL),(10,112,1,2,'软工2201班','2022-09-01','2026-06-30','0','admin','2025-12-20 15:19:04','',NULL,'文艺委员'),(11,113,1,1,'数学2201班','2022-09-01','2026-06-30','0','admin','2025-12-20 15:19:04','',NULL,NULL),(12,114,1,1,'计科2201班','2022-09-01','2026-06-30','0','admin','2025-12-20 15:19:04','',NULL,'团支书'),(13,115,1,1,'软工2201班','2022-09-01','2026-06-30','0','admin','2025-12-20 15:19:04','',NULL,NULL),(24,200,1,1,'计科2101班','2021-09-01','2025-07-01','0','admin','2025-12-21 17:12:37','',NULL,NULL),(25,201,1,1,'计科2101班','2021-09-01','2025-07-01','0','admin','2025-12-21 17:12:37','',NULL,NULL),(26,202,1,1,'计科2101班','2021-09-01','2025-07-01','0','admin','2025-12-21 17:12:37','',NULL,NULL),(27,203,1,1,'计科2102班','2021-09-01','2025-07-01','0','admin','2025-12-21 17:12:37','',NULL,NULL),(28,204,1,1,'计科2102班','2021-09-01','2025-07-01','0','admin','2025-12-21 17:12:37','',NULL,NULL),(29,205,1,1,'计科2201班','2022-09-01','2026-07-01','0','admin','2025-12-21 17:12:37','',NULL,NULL),(30,206,1,1,'计科2201班','2022-09-01','2026-07-01','0','admin','2025-12-21 17:12:37','',NULL,NULL),(31,207,1,1,'计科2201班','2022-09-01','2026-07-01','0','admin','2025-12-21 17:12:37','',NULL,NULL),(32,208,1,1,'计科2202班','2022-09-01','2026-07-01','0','admin','2025-12-21 17:12:37','',NULL,NULL),(33,209,1,1,'计科2202班','2022-09-01','2026-07-01','0','admin','2025-12-21 17:12:37','',NULL,NULL),(34,210,1,2,'软工2101班','2021-09-01','2025-07-01','0','admin','2025-12-21 17:12:37','',NULL,NULL),(35,211,1,2,'软工2101班','2021-09-01','2025-07-01','0','admin','2025-12-21 17:12:37','',NULL,NULL),(36,212,1,2,'软工2101班','2021-09-01','2025-07-01','0','admin','2025-12-21 17:12:37','',NULL,NULL),(37,213,1,2,'软工2102班','2021-09-01','2025-07-01','0','admin','2025-12-21 17:12:37','',NULL,NULL),(38,214,1,2,'软工2102班','2021-09-01','2025-07-01','0','admin','2025-12-21 17:12:37','',NULL,NULL),(39,215,1,2,'软工2201班','2022-09-01','2026-07-01','0','admin','2025-12-21 17:12:37','',NULL,NULL),(40,216,1,2,'软工2201班','2022-09-01','2026-07-01','0','admin','2025-12-21 17:12:37','',NULL,NULL),(41,217,1,2,'软工2201班','2022-09-01','2026-07-01','0','admin','2025-12-21 17:12:37','',NULL,NULL),(42,218,1,2,'软工2202班','2022-09-01','2026-07-01','0','admin','2025-12-21 17:12:37','',NULL,NULL),(43,219,1,2,'软工2202班','2022-09-01','2026-07-01','0','admin','2025-12-21 17:12:37','',NULL,NULL),(44,220,1,3,'人智2201班','2022-09-01','2026-07-01','0','admin','2025-12-21 17:12:37','',NULL,NULL),(45,221,1,3,'人智2201班','2022-09-01','2026-07-01','0','admin','2025-12-21 17:12:37','',NULL,NULL),(46,222,1,3,'人智2201班','2022-09-01','2026-07-01','0','admin','2025-12-21 17:12:37','',NULL,NULL),(47,223,1,3,'人智2202班','2022-09-01','2026-07-01','0','admin','2025-12-21 17:12:37','',NULL,NULL),(48,224,1,3,'人智2202班','2022-09-01','2026-07-01','0','admin','2025-12-21 17:12:37','',NULL,NULL),(49,225,2,6,'机械2101班','2021-09-01','2025-07-01','0','admin','2025-12-21 17:13:00','',NULL,NULL),(50,226,2,7,'自动2101班','2021-09-01','2025-07-01','0','admin','2025-12-21 17:13:00','',NULL,NULL),(51,227,2,8,'电气2101班','2021-09-01','2025-07-01','0','admin','2025-12-21 17:13:00','',NULL,NULL),(52,228,2,9,'机器人2201班','2022-09-01','2026-07-01','0','admin','2025-12-21 17:13:00','',NULL,NULL),(53,229,2,6,'机械2201班','2022-09-01','2026-07-01','0','admin','2025-12-21 17:13:00','',NULL,NULL),(54,230,2,7,'自动2201班','2022-09-01','2026-07-01','0','admin','2025-12-21 17:13:00','',NULL,NULL),(55,231,3,10,'数学2101班','2021-09-01','2025-07-01','0','admin','2025-12-21 17:13:00','',NULL,NULL),(56,232,3,12,'物理2101班','2021-09-01','2025-07-01','0','admin','2025-12-21 17:13:00','',NULL,NULL),(57,233,3,13,'化学2101班','2021-09-01','2025-07-01','0','admin','2025-12-21 17:13:00','',NULL,NULL),(58,234,3,10,'数学2201班','2022-09-01','2026-07-01','0','admin','2025-12-21 17:13:00','',NULL,NULL),(59,235,3,11,'信计2201班','2022-09-01','2026-07-01','0','admin','2025-12-21 17:13:00','',NULL,NULL),(60,236,3,12,'物理2201班','2022-09-01','2026-07-01','0','admin','2025-12-21 17:13:00','',NULL,NULL),(61,237,4,14,'通信2101班','2021-09-01','2025-07-01','0','admin','2025-12-21 17:13:00','',NULL,NULL),(62,238,4,15,'电子2101班','2021-09-01','2025-07-01','0','admin','2025-12-21 17:13:00','',NULL,NULL),(63,239,4,14,'通信2201班','2022-09-01','2026-07-01','0','admin','2025-12-21 17:13:00','',NULL,NULL),(64,240,4,15,'电子2201班','2022-09-01','2026-07-01','0','admin','2025-12-21 17:13:00','',NULL,NULL),(65,241,4,16,'信安2201班','2022-09-01','2026-07-01','0','admin','2025-12-21 17:13:00','',NULL,NULL),(66,242,5,17,'工商2101班','2021-09-01','2025-07-01','0','admin','2025-12-21 17:13:00','',NULL,NULL),(67,243,5,19,'会计2101班','2021-09-01','2025-07-01','0','admin','2025-12-21 17:13:00','',NULL,NULL),(68,244,5,20,'人资2101班','2021-09-01','2025-07-01','0','admin','2025-12-21 17:13:00','',NULL,NULL),(69,245,5,17,'工商2201班','2022-09-01','2026-07-01','0','admin','2025-12-21 17:13:00','',NULL,NULL),(70,246,5,19,'会计2201班','2022-09-01','2026-07-01','0','admin','2025-12-21 17:13:00','',NULL,NULL),(71,247,5,18,'信管2201班','2022-09-01','2026-07-01','0','admin','2025-12-21 17:13:00','',NULL,NULL),(72,248,6,21,'英语2101班','2021-09-01','2025-07-01','0','admin','2025-12-21 17:13:00','',NULL,NULL),(73,249,6,22,'日语2101班','2021-09-01','2025-07-01','0','admin','2025-12-21 17:13:00','',NULL,NULL),(74,250,6,23,'翻译2201班','2022-09-01','2026-07-01','0','admin','2025-12-21 17:13:00','',NULL,NULL),(75,251,6,23,'翻译2201班','2022-09-01','2026-07-01','0','admin','2025-12-21 17:13:00','',NULL,NULL),(76,252,6,21,'英语2201班','2022-09-01','2026-07-01','0','admin','2025-12-21 17:13:00','',NULL,NULL),(77,253,7,24,'经济2101班','2021-09-01','2025-07-01','0','admin','2025-12-21 17:13:00','',NULL,NULL),(78,254,7,25,'金融2101班','2021-09-01','2025-07-01','0','admin','2025-12-21 17:13:00','',NULL,NULL),(79,255,7,26,'国贸2101班','2021-09-01','2025-07-01','0','admin','2025-12-21 17:13:00','',NULL,NULL),(80,256,7,25,'金融2201班','2022-09-01','2026-07-01','0','admin','2025-12-21 17:13:00','',NULL,NULL),(81,257,7,25,'金融2201班','2022-09-01','2026-07-01','0','admin','2025-12-21 17:13:00','',NULL,NULL),(82,258,7,24,'经济2201班','2022-09-01','2026-07-01','0','admin','2025-12-21 17:13:00','',NULL,NULL),(83,259,8,27,'土木2101班','2021-09-01','2025-07-01','0','admin','2025-12-21 17:13:00','',NULL,NULL),(84,260,8,27,'土木2101班','2021-09-01','2025-07-01','0','admin','2025-12-21 17:13:00','',NULL,NULL),(85,261,8,28,'建环2201班','2022-09-01','2026-07-01','0','admin','2025-12-21 17:13:00','',NULL,NULL),(86,262,8,27,'土木2201班','2022-09-01','2026-07-01','0','admin','2025-12-21 17:13:00','',NULL,NULL),(87,263,9,29,'材料2101班','2021-09-01','2025-07-01','0','admin','2025-12-21 17:13:00','',NULL,NULL),(88,264,9,30,'高分子2101班','2021-09-01','2025-07-01','0','admin','2025-12-21 17:13:00','',NULL,NULL),(89,265,9,29,'材料2201班','2022-09-01','2026-07-01','0','admin','2025-12-21 17:13:00','',NULL,NULL),(90,266,9,30,'高分子2201班','2022-09-01','2026-07-01','0','admin','2025-12-21 17:13:00','',NULL,NULL),(91,267,10,31,'视传2101班','2021-09-01','2025-07-01','0','admin','2025-12-21 17:13:00','',NULL,NULL),(92,268,10,32,'环设2101班','2021-09-01','2025-07-01','0','admin','2025-12-21 17:13:00','',NULL,NULL),(93,269,10,31,'视传2201班','2022-09-01','2026-07-01','0','admin','2025-12-21 17:13:00','',NULL,NULL),(94,270,10,32,'环设2201班','2022-09-01','2026-07-01','0','admin','2025-12-21 17:13:00','',NULL,NULL);
/*!40000 ALTER TABLE `edu_student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `edu_student_course`
--

DROP TABLE IF EXISTS `edu_student_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `edu_student_course` (
  `sc_id` bigint NOT NULL AUTO_INCREMENT COMMENT '选课记录ID',
  `student_id` bigint NOT NULL COMMENT '学生ID (edu_student.student_id)',
  `open_id` bigint NOT NULL COMMENT '开课ID',
  `score` decimal(5,2) DEFAULT NULL COMMENT '成绩',
  `usual_score` decimal(5,1) DEFAULT NULL COMMENT '平时成绩',
  `exam_score` decimal(5,1) DEFAULT NULL COMMENT '考试成绩',
  `enroll_time` datetime DEFAULT NULL COMMENT '选课时间',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态 (0正常 1退课)',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `is_evaluated` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '是否已评价(0未评价 1已评价)',
  PRIMARY KEY (`sc_id`),
  UNIQUE KEY `uk_student_open` (`student_id`,`open_id`) COMMENT '防止重复选课'
) ENGINE=InnoDB AUTO_INCREMENT=351 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='选课记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `edu_student_course`
--

LOCK TABLES `edu_student_course` WRITE;
/*!40000 ALTER TABLE `edu_student_course` DISABLE KEYS */;
INSERT INTO `edu_student_course` VALUES (11,4,26,71.00,80.0,62.0,'2025-12-20 15:33:23','0','system','2025-12-20 15:33:23','',NULL,NULL,'1'),(12,4,27,64.00,89.0,92.0,'2025-12-20 15:33:23','0','system','2025-12-20 15:33:23','',NULL,NULL,'1'),(13,4,30,62.00,80.0,89.0,'2025-12-20 15:33:23','0','system','2025-12-20 15:33:23','',NULL,NULL,'0'),(14,5,26,76.00,93.0,95.0,'2025-12-20 15:33:23','0','system','2025-12-20 15:33:23','',NULL,NULL,'1'),(15,5,28,63.00,79.0,70.0,'2025-12-20 15:33:23','0','system','2025-12-20 15:33:23','',NULL,NULL,'1'),(16,5,31,85.00,74.0,58.0,'2025-12-20 15:33:23','0','system','2025-12-20 15:33:23','',NULL,NULL,'0'),(17,6,26,67.00,85.0,60.0,'2025-12-20 15:33:23','0','system','2025-12-20 15:33:23','',NULL,NULL,'1'),(18,6,27,87.00,73.0,68.0,'2025-12-20 15:33:23','0','system','2025-12-20 15:33:23','',NULL,NULL,'1'),(19,6,29,86.00,81.0,99.0,'2025-12-20 15:33:23','0','system','2025-12-20 15:33:23','',NULL,NULL,'0'),(20,7,26,60.00,93.0,91.0,'2025-12-20 15:33:23','0','system','2025-12-20 15:33:23','',NULL,NULL,'1'),(21,7,29,79.00,82.0,60.0,'2025-12-20 15:33:23','0','system','2025-12-20 15:33:23','',NULL,NULL,'0'),(22,7,30,79.00,75.0,51.0,'2025-12-20 15:33:23','0','system','2025-12-20 15:33:23','',NULL,NULL,'0'),(23,8,26,64.00,70.0,87.0,'2025-12-20 15:33:23','0','system','2025-12-20 15:33:23','',NULL,NULL,'0'),(24,8,28,69.00,98.0,52.0,'2025-12-20 15:33:23','0','system','2025-12-20 15:33:23','',NULL,NULL,'0'),(25,8,31,100.00,89.0,73.0,'2025-12-20 15:33:23','0','system','2025-12-20 15:33:23','',NULL,NULL,'0'),(26,9,23,91.40,80.0,99.0,'2025-12-20 15:33:41','1','system','2025-12-20 15:33:41','','2025-12-21 13:43:09',NULL,'1'),(27,9,24,82.00,82.0,60.0,'2025-12-20 15:33:41','0','system','2025-12-20 15:33:41','',NULL,NULL,'0'),(28,9,25,82.00,88.0,73.0,'2025-12-20 15:33:41','0','system','2025-12-20 15:33:41','',NULL,NULL,'0'),(29,10,23,87.00,99.0,79.0,'2025-12-20 15:33:41','1','system','2025-12-20 15:33:41','','2025-12-21 13:43:09',NULL,'0'),(30,10,24,75.00,86.0,62.0,'2025-12-20 15:33:41','0','system','2025-12-20 15:33:41','',NULL,NULL,'0'),(31,10,25,64.00,75.0,77.0,'2025-12-20 15:33:41','0','system','2025-12-20 15:33:41','',NULL,NULL,'0'),(32,10,31,77.00,86.0,70.0,'2025-12-20 15:33:41','0','system','2025-12-20 15:33:41','',NULL,NULL,'0'),(33,11,24,89.00,77.0,75.0,'2025-12-20 15:33:41','0','system','2025-12-20 15:33:41','',NULL,NULL,'0'),(34,11,25,84.00,71.0,50.0,'2025-12-20 15:33:41','0','system','2025-12-20 15:33:41','',NULL,NULL,'0'),(35,11,29,70.00,98.0,75.0,'2025-12-20 15:33:41','0','system','2025-12-20 15:33:41','',NULL,NULL,'0'),(36,12,23,93.00,99.0,89.0,'2025-12-20 15:33:41','1','system','2025-12-20 15:33:41','','2025-12-21 13:43:09',NULL,'0'),(37,12,24,61.00,89.0,84.0,'2025-12-20 15:33:41','0','system','2025-12-20 15:33:41','',NULL,NULL,'0'),(38,12,25,74.00,86.0,69.0,'2025-12-20 15:33:41','0','system','2025-12-20 15:33:41','',NULL,NULL,'0'),(39,13,23,46.00,34.0,54.0,'2025-12-20 15:33:41','1','system','2025-12-20 15:33:41','','2025-12-21 13:43:09',NULL,'0'),(40,13,24,82.00,89.0,82.0,'2025-12-20 15:33:41','0','system','2025-12-20 15:33:41','',NULL,NULL,'0'),(41,13,30,86.00,88.0,64.0,'2025-12-20 15:33:41','0','system','2025-12-20 15:33:41','',NULL,NULL,'0'),(42,1,23,73.60,34.0,100.0,'2025-12-20 15:33:41','1','system','2025-12-20 15:33:41','','2025-12-21 13:43:09',NULL,'0'),(43,1,26,85.00,86.0,52.0,'2025-12-20 15:33:41','0','system','2025-12-20 15:33:41','','2025-12-21 12:59:48',NULL,'0'),(44,1,31,44.40,99.0,8.0,'2025-12-20 15:33:41','1','system','2025-12-20 15:33:41','','2025-12-21 14:02:33',NULL,'0'),(45,2,24,64.00,98.0,72.0,'2025-12-20 15:33:41','0','system','2025-12-20 15:33:41','',NULL,NULL,'0'),(46,2,29,80.00,75.0,94.0,'2025-12-20 15:33:41','0','system','2025-12-20 15:33:41','',NULL,NULL,'0'),(47,2,30,71.00,90.0,94.0,'2025-12-20 15:33:41','0','system','2025-12-20 15:33:41','',NULL,NULL,'0'),(48,3,23,73.60,34.0,100.0,'2025-12-20 15:33:41','1','system','2025-12-20 15:33:41','','2025-12-21 13:43:06',NULL,'0'),(49,3,25,67.00,75.0,86.0,'2025-12-20 15:33:41','0','system','2025-12-20 15:33:41','',NULL,NULL,'0'),(50,3,31,52.00,98.0,98.0,'2025-12-20 15:33:41','0','system','2025-12-20 15:33:41','',NULL,NULL,'0'),(51,4,18,74.90,NULL,NULL,'2024-09-05 00:00:00','1','system','2024-09-05 00:00:00','',NULL,'已结课','0'),(52,4,19,95.00,NULL,NULL,'2024-09-05 00:00:00','1','system','2024-09-05 00:00:00','',NULL,'已结课','0'),(53,4,20,80.40,NULL,NULL,'2024-09-05 00:00:00','1','system','2024-09-05 00:00:00','',NULL,'已结课','0'),(54,5,18,72.00,NULL,NULL,'2024-09-05 00:00:00','1','system','2024-09-05 00:00:00','',NULL,'已结课','0'),(55,5,19,73.70,NULL,NULL,'2024-09-05 00:00:00','1','system','2024-09-05 00:00:00','',NULL,'已结课','0'),(56,5,20,82.60,NULL,NULL,'2024-09-05 00:00:00','1','system','2024-09-05 00:00:00','',NULL,'已结课','0'),(57,6,18,71.70,NULL,NULL,'2024-09-05 00:00:00','1','system','2024-09-05 00:00:00','',NULL,'已结课','0'),(58,6,19,90.70,NULL,NULL,'2024-09-05 00:00:00','1','system','2024-09-05 00:00:00','',NULL,'已结课','0'),(59,6,20,93.60,NULL,NULL,'2024-09-05 00:00:00','1','system','2024-09-05 00:00:00','',NULL,'已结课','0'),(60,7,18,75.60,NULL,NULL,'2024-09-05 00:00:00','1','system','2024-09-05 00:00:00','',NULL,'已结课','0'),(61,7,19,77.60,NULL,NULL,'2024-09-05 00:00:00','1','system','2024-09-05 00:00:00','',NULL,'已结课','0'),(62,7,20,90.80,NULL,NULL,'2024-09-05 00:00:00','1','system','2024-09-05 00:00:00','',NULL,'已结课','0'),(63,8,18,76.60,NULL,NULL,'2024-09-05 00:00:00','1','system','2024-09-05 00:00:00','',NULL,'已结课','0'),(64,8,19,90.30,NULL,NULL,'2024-09-05 00:00:00','1','system','2024-09-05 00:00:00','',NULL,'已结课','0'),(65,8,20,76.80,NULL,NULL,'2024-09-05 00:00:00','1','system','2024-09-05 00:00:00','',NULL,'已结课','0'),(66,1,22,93.10,NULL,NULL,'2024-09-05 00:00:00','1','system','2024-09-05 00:00:00','',NULL,'已结课','0'),(67,2,22,90.00,NULL,NULL,'2024-09-05 00:00:00','1','system','2024-09-05 00:00:00','',NULL,'已结课','0'),(68,3,22,75.70,NULL,NULL,'2024-09-05 00:00:00','1','system','2024-09-05 00:00:00','','2025-12-20 16:14:24','已结课','0'),(69,4,2,57.20,41.3,35.2,'2025-02-20 10:00:00','1','','2025-12-20 17:34:14','',NULL,NULL,'0'),(70,4,3,78.00,NULL,NULL,'2025-02-20 10:05:00','1','','2025-12-20 17:34:14','',NULL,NULL,'0'),(71,4,11,82.50,NULL,NULL,'2025-02-20 10:10:00','1','','2025-12-20 17:34:14','',NULL,NULL,'0'),(72,5,2,55.40,41.1,42.6,'2025-02-21 09:00:00','1','','2025-12-20 17:34:14','',NULL,NULL,'0'),(73,5,12,91.50,NULL,NULL,'2025-02-21 09:05:00','1','','2025-12-20 17:34:14','',NULL,NULL,'0'),(74,5,13,75.00,NULL,NULL,'2025-02-21 09:10:00','1','','2025-12-20 17:34:14','',NULL,NULL,'0'),(75,6,3,79.50,NULL,NULL,'2025-02-22 14:00:00','1','','2025-12-20 17:34:14','',NULL,NULL,'0'),(76,6,14,86.00,NULL,NULL,'2025-02-22 14:05:00','1','','2025-12-20 17:34:14','',NULL,NULL,'0'),(77,6,16,88.50,NULL,NULL,'2025-02-22 14:10:00','1','','2025-12-20 17:34:14','',NULL,NULL,'0'),(78,7,7,92.00,NULL,NULL,'2025-02-23 11:00:00','1','','2025-12-20 17:34:14','',NULL,NULL,'0'),(79,7,10,58.70,50.0,41.4,'2025-02-23 11:05:00','1','','2025-12-20 17:34:14','',NULL,NULL,'0'),(80,7,15,77.00,NULL,NULL,'2025-02-23 11:10:00','1','','2025-12-20 17:34:14','',NULL,NULL,'0'),(81,8,9,81.00,NULL,NULL,'2025-02-24 15:00:00','1','','2025-12-20 17:34:14','',NULL,NULL,'0'),(82,8,17,89.50,NULL,NULL,'2025-02-24 15:05:00','1','','2025-12-20 17:34:14','',NULL,NULL,'0'),(83,8,5,83.00,NULL,NULL,'2025-02-24 15:10:00','1','','2025-12-20 17:34:14','',NULL,NULL,'0'),(84,1,38,NULL,NULL,NULL,'2025-12-21 16:50:24','0','','2025-12-21 16:50:24','',NULL,NULL,'0'),(85,1,37,NULL,NULL,NULL,'2025-12-21 17:04:00','1','','2025-12-21 17:04:00','','2025-12-21 17:04:11',NULL,'0'),(86,1,33,NULL,NULL,NULL,'2025-12-21 17:04:16','0','','2025-12-21 17:04:16','',NULL,NULL,'0'),(87,4,37,NULL,NULL,NULL,'2025-12-21 17:05:30','0','',NULL,'',NULL,NULL,'0'),(88,4,35,NULL,NULL,NULL,'2025-12-21 17:05:30','0','',NULL,'',NULL,NULL,'0'),(89,4,34,NULL,NULL,NULL,'2025-12-21 17:05:30','0','',NULL,'',NULL,NULL,'0'),(90,5,38,NULL,NULL,NULL,'2025-12-21 17:05:30','0','',NULL,'',NULL,NULL,'0'),(91,5,35,NULL,NULL,NULL,'2025-12-21 17:05:30','0','',NULL,'',NULL,NULL,'0'),(92,5,32,NULL,NULL,NULL,'2025-12-21 17:05:30','0','',NULL,'',NULL,NULL,'0'),(93,6,37,NULL,NULL,NULL,'2025-12-21 17:05:30','0','',NULL,'',NULL,NULL,'0'),(94,6,34,NULL,NULL,NULL,'2025-12-21 17:05:30','0','',NULL,'',NULL,NULL,'0'),(95,6,33,NULL,NULL,NULL,'2025-12-21 17:05:30','0','',NULL,'',NULL,NULL,'0'),(96,7,38,NULL,NULL,NULL,'2025-12-21 17:05:30','0','',NULL,'',NULL,NULL,'0'),(97,7,36,NULL,NULL,NULL,'2025-12-21 17:05:30','0','',NULL,'',NULL,NULL,'0'),(98,7,33,NULL,NULL,NULL,'2025-12-21 17:05:30','0','',NULL,'',NULL,NULL,'0'),(99,8,37,NULL,NULL,NULL,'2025-12-21 17:05:30','0','',NULL,'',NULL,NULL,'0'),(100,8,35,NULL,NULL,NULL,'2025-12-21 17:05:30','0','',NULL,'',NULL,NULL,'0'),(101,8,36,NULL,NULL,NULL,'2025-12-21 17:05:30','0','',NULL,'',NULL,NULL,'0'),(102,9,38,NULL,NULL,NULL,'2025-12-21 17:05:30','0','',NULL,'',NULL,NULL,'0'),(103,9,32,NULL,NULL,NULL,'2025-12-21 17:05:30','0','',NULL,'',NULL,NULL,'0'),(104,9,34,NULL,NULL,NULL,'2025-12-21 17:05:30','0','',NULL,'',NULL,NULL,'0'),(105,10,37,NULL,NULL,NULL,'2025-12-21 17:05:30','0','',NULL,'','2025-12-21 19:59:36',NULL,'0'),(106,10,33,NULL,NULL,NULL,'2025-12-21 17:05:30','0','',NULL,'',NULL,NULL,'0'),(107,10,36,NULL,NULL,NULL,'2025-12-21 17:05:30','0','',NULL,'',NULL,NULL,'0'),(119,1,35,NULL,NULL,NULL,'2025-12-21 17:06:11','0','',NULL,'',NULL,NULL,'0'),(120,1,32,NULL,NULL,NULL,'2025-12-21 17:06:11','0','',NULL,'',NULL,NULL,'0'),(121,1,34,NULL,NULL,NULL,'2025-12-21 17:06:11','0','',NULL,'',NULL,NULL,'0'),(122,2,37,92.80,88.0,96.0,'2025-12-21 17:06:11','1','',NULL,'','2025-12-21 20:00:41',NULL,'0'),(123,2,35,NULL,NULL,NULL,'2025-12-21 17:06:11','0','',NULL,'',NULL,NULL,'0'),(124,2,34,NULL,NULL,NULL,'2025-12-21 17:06:11','0','',NULL,'',NULL,NULL,'0'),(125,2,32,NULL,NULL,NULL,'2025-12-21 17:06:11','0','',NULL,'',NULL,NULL,'0'),(126,2,33,NULL,NULL,NULL,'2025-12-21 17:06:11','0','',NULL,'',NULL,NULL,'0'),(127,3,38,NULL,NULL,NULL,'2025-12-21 17:06:11','1','',NULL,'','2025-12-21 20:02:11',NULL,'0'),(128,3,36,NULL,NULL,NULL,'2025-12-21 17:06:11','1','',NULL,'','2025-12-21 20:02:14',NULL,'0'),(129,3,33,NULL,NULL,NULL,'2025-12-21 17:06:11','0','',NULL,'',NULL,NULL,'0'),(130,3,32,NULL,NULL,NULL,'2025-12-21 17:06:11','0','',NULL,'',NULL,NULL,'0'),(131,3,35,NULL,NULL,NULL,'2025-12-21 17:06:11','1','',NULL,'','2025-12-21 20:05:43',NULL,'0'),(132,24,38,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(133,25,38,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(134,26,38,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(135,27,38,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(136,28,38,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(137,29,38,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(138,30,38,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(139,31,38,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(140,32,38,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(141,33,38,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(142,34,38,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(143,35,38,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(144,36,38,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(145,37,38,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(146,38,38,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(147,39,38,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(148,40,38,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(149,41,38,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(150,42,38,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(151,43,38,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(152,44,38,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(153,45,38,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(154,46,38,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(155,47,38,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(156,48,38,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(163,24,35,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(164,25,35,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(165,26,35,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(166,27,35,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(167,28,35,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(168,29,35,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(169,30,35,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(170,31,35,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(171,32,35,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(172,33,35,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(173,34,35,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(174,35,35,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(175,36,35,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(176,37,35,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(177,38,35,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(178,39,35,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(179,40,35,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(180,41,35,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(181,42,35,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(182,43,35,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(183,44,35,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(184,45,35,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(185,46,35,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(186,47,35,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(187,48,35,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(194,24,43,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(195,25,43,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(196,26,43,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(197,27,43,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(198,28,43,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(199,29,43,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(200,30,43,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(201,31,43,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(202,32,43,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(203,33,43,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(204,34,43,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(205,35,43,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(206,36,43,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(207,37,43,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(208,38,43,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(209,39,43,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(210,40,43,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(211,41,43,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(212,42,43,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(213,43,43,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(214,44,43,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(215,45,43,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(216,46,43,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(217,47,43,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(218,48,43,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(225,49,39,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(226,50,39,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(227,51,39,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(228,52,39,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(229,53,39,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(230,54,39,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(232,49,40,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(233,50,40,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(234,51,40,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(235,52,40,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(236,53,40,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(237,54,40,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(239,49,43,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(240,50,43,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(241,51,43,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(242,52,43,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(243,53,43,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(244,54,43,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(246,55,43,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(247,56,43,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(248,57,43,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(249,58,43,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(250,59,43,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(251,60,43,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(253,55,44,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(254,56,44,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(255,57,44,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(256,58,44,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(257,59,44,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(258,60,44,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(260,55,45,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(261,56,45,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(262,57,45,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(263,58,45,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(264,59,45,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(265,60,45,NULL,NULL,NULL,'2025-12-21 17:14:22','0','',NULL,'',NULL,NULL,'0'),(267,61,46,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(268,62,46,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(269,63,46,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(270,64,46,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(271,65,46,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(274,61,47,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(275,62,47,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(276,63,47,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(277,64,47,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(278,65,47,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(281,61,48,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(282,62,48,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(283,63,48,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(284,64,48,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(285,65,48,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(288,66,50,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(289,67,50,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(290,68,50,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(291,69,50,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(292,70,50,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(293,71,50,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(295,66,51,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(296,67,51,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(297,68,51,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(298,69,51,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(299,70,51,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(300,71,51,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(302,66,52,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(303,67,52,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(304,68,52,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(305,69,52,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(306,70,52,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(307,71,52,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(309,72,54,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(310,73,54,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(311,74,54,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(312,75,54,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(313,76,54,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(316,72,55,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(317,73,55,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(318,74,55,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(319,75,55,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(320,76,55,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(323,72,56,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(324,73,56,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(325,74,56,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(326,75,56,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(327,76,56,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(330,77,58,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(331,78,58,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(332,79,58,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(333,80,58,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(334,81,58,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(335,82,58,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(337,77,59,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(338,78,59,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(339,79,59,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(340,80,59,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(341,81,59,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(342,82,59,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(344,77,60,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(345,78,60,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(346,79,60,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(347,80,60,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(348,81,60,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0'),(349,82,60,NULL,NULL,NULL,'2025-12-21 17:14:32','0','',NULL,'',NULL,NULL,'0');
/*!40000 ALTER TABLE `edu_student_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `edu_teacher`
--

DROP TABLE IF EXISTS `edu_teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `edu_teacher` (
  `teacher_id` bigint NOT NULL AUTO_INCREMENT COMMENT '教师ID',
  `user_id` bigint NOT NULL COMMENT '关联系统用户ID (sys_user.user_id)',
  `college_id` bigint DEFAULT NULL COMMENT '所属学院',
  `title` varchar(30) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '职称 (教授/副教授/讲师/助教)',
  `education` varchar(20) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '学历 (博士/硕士/学士)',
  `research_area` varchar(200) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '研究方向',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`teacher_id`),
  UNIQUE KEY `uk_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='教师信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `edu_teacher`
--

LOCK TABLES `edu_teacher` WRITE;
/*!40000 ALTER TABLE `edu_teacher` DISABLE KEYS */;
INSERT INTO `edu_teacher` VALUES (1,2,1,'教授','博士','人工智能、机器学习','admin','2025-12-18 15:46:15','',NULL,'测试教师'),(2,102,1,'教授','博士','数据库系统、大数据分析','admin','2025-12-20 15:19:04','',NULL,'博士生导师'),(3,103,1,'副教授','博士','软件工程、程序设计','admin','2025-12-20 15:19:04','',NULL,'硕士生导师'),(4,104,3,'教授','博士','高等数学、线性代数','admin','2025-12-20 15:19:04','',NULL,'教学名师'),(5,105,6,'讲师','硕士','英语语言文学','admin','2025-12-20 15:19:04','',NULL,'大学英语教研室'),(10,116,1,'教授','博士','深度学习、计算机视觉','admin','2025-12-21 17:11:26','',NULL,NULL),(11,117,1,'副教授','博士','算法设计、数据结构','admin','2025-12-21 17:11:26','',NULL,NULL),(12,118,1,'教授','博士','大数据分析、数据挖掘','admin','2025-12-21 17:11:26','',NULL,NULL),(13,119,1,'副教授','博士','计算机网络、网络安全','admin','2025-12-21 17:11:26','',NULL,NULL),(14,120,2,'教授','博士','机械设计、先进制造','admin','2025-12-21 17:11:26','',NULL,NULL),(15,121,2,'副教授','博士','自动控制、智能系统','admin','2025-12-21 17:11:26','',NULL,NULL),(16,122,2,'讲师','硕士','电气工程、电力电子','admin','2025-12-21 17:11:26','',NULL,NULL),(17,123,3,'教授','博士','微分方程、应用数学','admin','2025-12-21 17:11:26','',NULL,NULL),(18,124,3,'副教授','博士','代数学、矩阵论','admin','2025-12-21 17:11:26','',NULL,NULL),(19,125,3,'教授','博士','理论物理、量子力学','admin','2025-12-21 17:11:26','',NULL,NULL),(20,126,4,'教授','博士','信号处理、无线通信','admin','2025-12-21 17:11:26','',NULL,NULL),(21,127,4,'副教授','博士','通信系统、5G技术','admin','2025-12-21 17:11:26','',NULL,NULL),(22,128,5,'教授','博士','企业管理、战略规划','admin','2025-12-21 17:11:26','',NULL,NULL),(23,129,5,'副教授','博士','财务管理、会计学','admin','2025-12-21 17:11:26','',NULL,NULL),(24,130,6,'副教授','硕士','英语语言学、翻译','admin','2025-12-21 17:11:26','',NULL,NULL),(25,131,6,'讲师','硕士','日语语言文学','admin','2025-12-21 17:11:26','',NULL,NULL),(26,132,7,'教授','博士','宏观经济学、政策分析','admin','2025-12-21 17:11:26','',NULL,NULL),(27,133,7,'副教授','博士','金融工程、投资学','admin','2025-12-21 17:11:26','',NULL,NULL);
/*!40000 ALTER TABLE `edu_teacher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `edu_term`
--

DROP TABLE IF EXISTS `edu_term`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `edu_term` (
  `term_id` bigint NOT NULL AUTO_INCREMENT COMMENT '学期ID',
  `term_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '学期名称 (如: 2024-2025学年第一学期)',
  `start_date` date DEFAULT NULL COMMENT '学期开始日期',
  `end_date` date DEFAULT NULL COMMENT '学期结束日期',
  `selection_start` datetime DEFAULT NULL COMMENT '选课开始时间',
  `selection_end` datetime DEFAULT NULL COMMENT '选课结束时间',
  `is_current` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '是否当前学期 (0否 1是)',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态 (0正常 1停用)',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`term_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='学期信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `edu_term`
--

LOCK TABLES `edu_term` WRITE;
/*!40000 ALTER TABLE `edu_term` DISABLE KEYS */;
INSERT INTO `edu_term` VALUES (1,'2024-2025学年第一学期','2024-09-01','2025-01-15','2024-08-20 08:00:00','2024-09-10 23:59:59','0','0','admin','2025-12-18 15:46:15','','2025-12-20 15:22:46','秋季学期'),(2,'2024-2025学年第二学期','2025-02-17','2025-07-05','2025-02-10 08:00:00','2025-02-28 23:59:59','0','0','admin','2025-12-18 15:46:15','','2025-12-20 15:36:47','春季学期（当前）'),(3,'2025-2026学年第一学期','2025-09-01','2026-01-15','2025-12-19 08:00:00','2025-12-25 23:59:59','1','0','admin','2025-12-20 15:24:40','','2025-12-21 20:05:10','秋季学期（当前）'),(4,'2025-2026学年第二学期','2026-02-16','2026-07-04','2025-12-01 00:00:00','2025-12-31 23:59:59','0','0','admin','2025-12-20 15:24:40','','2025-12-21 19:57:32','春季学期（待开放）');
/*!40000 ALTER TABLE `edu_term` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gen_table`
--

DROP TABLE IF EXISTS `gen_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gen_table` (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) COLLATE utf8mb4_general_ci DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) COLLATE utf8mb4_general_ci DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='代码生成业务表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_table`
--

LOCK TABLES `gen_table` WRITE;
/*!40000 ALTER TABLE `gen_table` DISABLE KEYS */;
INSERT INTO `gen_table` VALUES (1,'edu_term','学期信息表',NULL,NULL,'EduTerm','crud','','com.ruoyi.system','system','term','学期信息','ruoyi','0','/',NULL,'admin','2025-12-18 17:18:05','',NULL,NULL);
/*!40000 ALTER TABLE `gen_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gen_table_column`
--

DROP TABLE IF EXISTS `gen_table_column`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gen_table_column` (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) COLLATE utf8mb4_general_ci DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典类型',
  `sort` int DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='代码生成业务表字段';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_table_column`
--

LOCK TABLES `gen_table_column` WRITE;
/*!40000 ALTER TABLE `gen_table_column` DISABLE KEYS */;
INSERT INTO `gen_table_column` VALUES (1,1,'term_id','学期ID','bigint','Long','termId','1','1','0','1',NULL,NULL,NULL,'EQ','input','',1,'admin','2025-12-18 17:18:05','',NULL),(2,1,'term_name','学期名称 (如: 2024-2025学年第一学期)','varchar(64)','String','termName','0','0','1','1','1','1','1','LIKE','input','',2,'admin','2025-12-18 17:18:05','',NULL),(3,1,'start_date','学期开始日期','date','Date','startDate','0','0','0','1','1','1','1','EQ','datetime','',3,'admin','2025-12-18 17:18:05','',NULL),(4,1,'end_date','学期结束日期','date','Date','endDate','0','0','0','1','1','1','1','EQ','datetime','',4,'admin','2025-12-18 17:18:05','',NULL),(5,1,'is_current','是否当前学期 (0否 1是)','char(1)','String','isCurrent','0','0','0','1','1','1','1','EQ','input','',5,'admin','2025-12-18 17:18:05','',NULL),(6,1,'status','状态 (0正常 1停用)','char(1)','String','status','0','0','0','1','1','1','1','EQ','radio','',6,'admin','2025-12-18 17:18:05','',NULL),(7,1,'create_by','创建者','varchar(64)','String','createBy','0','0','0','1',NULL,NULL,NULL,'EQ','input','',7,'admin','2025-12-18 17:18:05','',NULL),(8,1,'create_time','创建时间','datetime','Date','createTime','0','0','0','1',NULL,NULL,NULL,'EQ','datetime','',8,'admin','2025-12-18 17:18:05','',NULL),(9,1,'update_by','更新者','varchar(64)','String','updateBy','0','0','0','1','1',NULL,NULL,'EQ','input','',9,'admin','2025-12-18 17:18:05','',NULL),(10,1,'update_time','更新时间','datetime','Date','updateTime','0','0','0','1','1',NULL,NULL,'EQ','datetime','',10,'admin','2025-12-18 17:18:05','',NULL),(11,1,'remark','备注','varchar(500)','String','remark','0','0','0','1','1','1',NULL,'EQ','textarea','',11,'admin','2025-12-18 17:18:05','',NULL);
/*!40000 ALTER TABLE `gen_table_column` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_BLOB_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_BLOB_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_BLOB_TRIGGERS` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Blob类型的触发器表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_BLOB_TRIGGERS`
--

LOCK TABLES `QRTZ_BLOB_TRIGGERS` WRITE;
/*!40000 ALTER TABLE `QRTZ_BLOB_TRIGGERS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_BLOB_TRIGGERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_CALENDARS`
--

DROP TABLE IF EXISTS `QRTZ_CALENDARS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_CALENDARS` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`,`calendar_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='日历信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_CALENDARS`
--

LOCK TABLES `QRTZ_CALENDARS` WRITE;
/*!40000 ALTER TABLE `QRTZ_CALENDARS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_CALENDARS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_CRON_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_CRON_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_CRON_TRIGGERS` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Cron类型的触发器表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_CRON_TRIGGERS`
--

LOCK TABLES `QRTZ_CRON_TRIGGERS` WRITE;
/*!40000 ALTER TABLE `QRTZ_CRON_TRIGGERS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_CRON_TRIGGERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_FIRED_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_FIRED_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_FIRED_TRIGGERS` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint NOT NULL COMMENT '触发的时间',
  `sched_time` bigint NOT NULL COMMENT '定时器制定的时间',
  `priority` int NOT NULL COMMENT '优先级',
  `state` varchar(16) COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态',
  `job_name` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`,`entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='已触发的触发器表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_FIRED_TRIGGERS`
--

LOCK TABLES `QRTZ_FIRED_TRIGGERS` WRITE;
/*!40000 ALTER TABLE `QRTZ_FIRED_TRIGGERS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_FIRED_TRIGGERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_JOB_DETAILS`
--

DROP TABLE IF EXISTS `QRTZ_JOB_DETAILS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_JOB_DETAILS` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `description` varchar(250) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) COLLATE utf8mb4_general_ci NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`,`job_name`,`job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='任务详细信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_JOB_DETAILS`
--

LOCK TABLES `QRTZ_JOB_DETAILS` WRITE;
/*!40000 ALTER TABLE `QRTZ_JOB_DETAILS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_JOB_DETAILS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_LOCKS`
--

DROP TABLE IF EXISTS `QRTZ_LOCKS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_LOCKS` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) COLLATE utf8mb4_general_ci NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`,`lock_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='存储的悲观锁信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_LOCKS`
--

LOCK TABLES `QRTZ_LOCKS` WRITE;
/*!40000 ALTER TABLE `QRTZ_LOCKS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_LOCKS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_PAUSED_TRIGGER_GRPS`
--

DROP TABLE IF EXISTS `QRTZ_PAUSED_TRIGGER_GRPS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_PAUSED_TRIGGER_GRPS` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`,`trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='暂停的触发器表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_PAUSED_TRIGGER_GRPS`
--

LOCK TABLES `QRTZ_PAUSED_TRIGGER_GRPS` WRITE;
/*!40000 ALTER TABLE `QRTZ_PAUSED_TRIGGER_GRPS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_PAUSED_TRIGGER_GRPS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_SCHEDULER_STATE`
--

DROP TABLE IF EXISTS `QRTZ_SCHEDULER_STATE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_SCHEDULER_STATE` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`,`instance_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='调度器状态表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_SCHEDULER_STATE`
--

LOCK TABLES `QRTZ_SCHEDULER_STATE` WRITE;
/*!40000 ALTER TABLE `QRTZ_SCHEDULER_STATE` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_SCHEDULER_STATE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_SIMPLE_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_SIMPLE_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_SIMPLE_TRIGGERS` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='简单触发器的信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_SIMPLE_TRIGGERS`
--

LOCK TABLES `QRTZ_SIMPLE_TRIGGERS` WRITE;
/*!40000 ALTER TABLE `QRTZ_SIMPLE_TRIGGERS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_SIMPLE_TRIGGERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_SIMPROP_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_SIMPROP_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_SIMPROP_TRIGGERS` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13,4) DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13,4) DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='同步机制的行锁表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_SIMPROP_TRIGGERS`
--

LOCK TABLES `QRTZ_SIMPROP_TRIGGERS` WRITE;
/*!40000 ALTER TABLE `QRTZ_SIMPROP_TRIGGERS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_SIMPROP_TRIGGERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_TRIGGERS` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器的类型',
  `start_time` bigint NOT NULL COMMENT '开始时间',
  `end_time` bigint DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  KEY `sched_name` (`sched_name`,`job_name`,`job_group`),
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `QRTZ_JOB_DETAILS` (`sched_name`, `job_name`, `job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='触发器详细信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_TRIGGERS`
--

LOCK TABLES `QRTZ_TRIGGERS` WRITE;
/*!40000 ALTER TABLE `QRTZ_TRIGGERS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_TRIGGERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_course`
--

DROP TABLE IF EXISTS `student_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_course` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `student_id` bigint NOT NULL COMMENT '学生ID（关联sys_user）',
  `course_id` bigint NOT NULL COMMENT '课程ID',
  `enroll_time` datetime DEFAULT NULL COMMENT '选课时间',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '选课状态（0已选 1已退 2已完成）',
  `score` decimal(5,2) DEFAULT NULL COMMENT '成绩',
  `grade_point` decimal(3,2) DEFAULT NULL COMMENT '绩点',
  `semester` varchar(20) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '学期',
  `del_flag` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_student_course` (`student_id`,`course_id`,`semester`)
) ENGINE=InnoDB AUTO_INCREMENT=3000 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='学生选课表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_course`
--

LOCK TABLES `student_course` WRITE;
/*!40000 ALTER TABLE `student_course` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_config`
--

DROP TABLE IF EXISTS `sys_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_config` (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) COLLATE utf8mb4_general_ci DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='参数配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_config`
--

LOCK TABLES `sys_config` WRITE;
/*!40000 ALTER TABLE `sys_config` DISABLE KEYS */;
INSERT INTO `sys_config` VALUES (1,'主框架页-默认皮肤样式名称','sys.index.skinName','skin-blue','Y','admin','2025-12-18 15:46:08','',NULL,'蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow'),(2,'用户管理-账号初始密码','sys.user.initPassword','123456','Y','admin','2025-12-18 15:46:08','',NULL,'初始化密码 123456'),(3,'主框架页-侧边栏主题','sys.index.sideTheme','theme-dark','Y','admin','2025-12-18 15:46:08','',NULL,'深色主题theme-dark，浅色主题theme-light'),(4,'账号自助-验证码开关','sys.account.captchaEnabled','true','Y','admin','2025-12-18 15:46:08','',NULL,'是否开启验证码功能（true开启，false关闭）'),(5,'账号自助-是否开启用户注册功能','sys.account.registerUser','false','Y','admin','2025-12-18 15:46:08','',NULL,'是否开启注册用户功能（true开启，false关闭）'),(6,'用户登录-黑名单列表','sys.login.blackIPList','','Y','admin','2025-12-18 15:46:08','',NULL,'设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）'),(7,'用户管理-初始密码修改策略','sys.account.initPasswordModify','1','Y','admin','2025-12-18 15:46:08','',NULL,'0：初始密码修改策略关闭，没有任何提示，1：提醒用户，如果未修改初始密码，则在登录时就会提醒修改密码对话框'),(8,'用户管理-账号密码更新周期','sys.account.passwordValidateDays','0','Y','admin','2025-12-18 15:46:08','',NULL,'密码更新周期（填写数字，数据初始化值为0不限制，若修改必须为大于0小于365的正整数），如果超过这个周期登录系统时，则在登录时就会提醒修改密码对话框');
/*!40000 ALTER TABLE `sys_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dept`
--

DROP TABLE IF EXISTS `sys_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_dept` (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '学院id',
  `parent_id` bigint DEFAULT '0' COMMENT '父学院id',
  `ancestors` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '学院名称',
  `order_num` int DEFAULT '0' COMMENT '显示顺序',
  `leader` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '院长',
  `phone` varchar(11) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '邮箱',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '学院状态（0正常 1停用）',
  `del_flag` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=200 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='学院表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dept`
--

LOCK TABLES `sys_dept` WRITE;
/*!40000 ALTER TABLE `sys_dept` DISABLE KEYS */;
INSERT INTO `sys_dept` VALUES (100,0,'0','教学管理中心',0,'系统管理员','15888888888','admin@university.edu','0','0','admin','2025-12-18 15:46:08','',NULL),(101,100,'0,100','计算机工程与科学学院',1,'张三','15888888801','cs@university.edu','0','0','admin','2025-12-18 15:46:08','',NULL),(102,100,'0,100','信息工程学院',2,'李四','15888888802','ie@university.edu','0','0','admin','2025-12-18 15:46:08','',NULL),(103,100,'0,100','经济学院',3,'王五','15888888803','em@university.edu','0','0','admin','2025-12-18 15:46:08','',NULL),(104,100,'0,100','外国语学院',4,'赵六','15888888804','fl@university.edu','0','0','admin','2025-12-18 15:46:08','',NULL),(105,100,'0,100','理学院',5,'刘七','15888888805','math@university.edu','0','0','admin','2025-12-18 15:46:08','',NULL),(106,101,'0,100,101','计算机科学系',1,'陈八','15888888806','cs-dept@university.edu','0','0','admin','2025-12-18 15:46:08','',NULL),(107,101,'0,100,101','软件工程系',2,'周九','15888888807','se-dept@university.edu','0','0','admin','2025-12-18 15:46:08','',NULL),(108,102,'0,100,102','电子信息系',1,'吴十','15888888808','ei-dept@university.edu','0','0','admin','2025-12-18 15:46:08','',NULL),(109,100,'0,100','机电工程学院',2,'王志强',NULL,NULL,'0','0','','2025-12-21 17:16:56','',NULL),(110,100,'0,100','通信与信息工程学院',4,'赵国庆',NULL,NULL,'0','0','','2025-12-21 17:16:56','',NULL),(111,100,'0,100','管理学院',5,'刘德华',NULL,NULL,'0','0','','2025-12-21 17:16:56','',NULL),(112,100,'0,100','土木工程系',8,'吴建设',NULL,NULL,'0','0','','2025-12-21 17:16:56','',NULL),(113,100,'0,100','材料科学与工程学院',9,'孙伟民',NULL,NULL,'0','0','','2025-12-21 17:16:56','',NULL),(114,100,'0,100','美术学院',10,'黄艺术',NULL,NULL,'0','0','','2025-12-21 17:16:56','',NULL);
/*!40000 ALTER TABLE `sys_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dict_data`
--

DROP TABLE IF EXISTS `sys_dict_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_dict_data` (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int DEFAULT '0' COMMENT '字典排序',
  `dict_label` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) COLLATE utf8mb4_general_ci DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`)
) ENGINE=InnoDB AUTO_INCREMENT=1013 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='字典数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict_data`
--

LOCK TABLES `sys_dict_data` WRITE;
/*!40000 ALTER TABLE `sys_dict_data` DISABLE KEYS */;
INSERT INTO `sys_dict_data` VALUES (1,1,'男','0','sys_user_sex','','','Y','0','admin','2025-12-18 15:46:08','',NULL,'性别男'),(2,2,'女','1','sys_user_sex','','','N','0','admin','2025-12-18 15:46:08','',NULL,'性别女'),(3,3,'未知','2','sys_user_sex','','','N','0','admin','2025-12-18 15:46:08','',NULL,'性别未知'),(4,1,'显示','0','sys_show_hide','','primary','Y','0','admin','2025-12-18 15:46:08','',NULL,'显示菜单'),(5,2,'隐藏','1','sys_show_hide','','danger','N','0','admin','2025-12-18 15:46:08','',NULL,'隐藏菜单'),(6,1,'正常','0','sys_normal_disable','','primary','Y','0','admin','2025-12-18 15:46:08','',NULL,'正常状态'),(7,2,'停用','1','sys_normal_disable','','danger','N','0','admin','2025-12-18 15:46:08','',NULL,'停用状态'),(8,1,'正常','0','sys_job_status','','primary','Y','0','admin','2025-12-18 15:46:08','',NULL,'正常状态'),(9,2,'暂停','1','sys_job_status','','danger','N','0','admin','2025-12-18 15:46:08','',NULL,'停用状态'),(10,1,'默认','DEFAULT','sys_job_group','','','Y','0','admin','2025-12-18 15:46:08','',NULL,'默认分组'),(11,2,'系统','SYSTEM','sys_job_group','','','N','0','admin','2025-12-18 15:46:08','',NULL,'系统分组'),(12,1,'是','Y','sys_yes_no','','primary','Y','0','admin','2025-12-18 15:46:08','',NULL,'系统默认是'),(13,2,'否','N','sys_yes_no','','danger','N','0','admin','2025-12-18 15:46:08','',NULL,'系统默认否'),(14,1,'通知','1','sys_notice_type','','warning','Y','0','admin','2025-12-18 15:46:08','',NULL,'通知'),(15,2,'公告','2','sys_notice_type','','success','N','0','admin','2025-12-18 15:46:08','',NULL,'公告'),(16,1,'正常','0','sys_notice_status','','primary','Y','0','admin','2025-12-18 15:46:08','',NULL,'正常状态'),(17,2,'关闭','1','sys_notice_status','','danger','N','0','admin','2025-12-18 15:46:08','',NULL,'关闭状态'),(18,99,'其他','0','sys_oper_type','','info','N','0','admin','2025-12-18 15:46:08','',NULL,'其他操作'),(19,1,'新增','1','sys_oper_type','','info','N','0','admin','2025-12-18 15:46:08','',NULL,'新增操作'),(20,2,'修改','2','sys_oper_type','','info','N','0','admin','2025-12-18 15:46:08','',NULL,'修改操作'),(21,3,'删除','3','sys_oper_type','','danger','N','0','admin','2025-12-18 15:46:08','',NULL,'删除操作'),(22,4,'授权','4','sys_oper_type','','primary','N','0','admin','2025-12-18 15:46:08','',NULL,'授权操作'),(23,5,'导出','5','sys_oper_type','','warning','N','0','admin','2025-12-18 15:46:08','',NULL,'导出操作'),(24,6,'导入','6','sys_oper_type','','warning','N','0','admin','2025-12-18 15:46:08','',NULL,'导入操作'),(25,7,'强退','7','sys_oper_type','','danger','N','0','admin','2025-12-18 15:46:08','',NULL,'强退操作'),(26,8,'生成代码','8','sys_oper_type','','warning','N','0','admin','2025-12-18 15:46:08','',NULL,'生成操作'),(27,9,'清空数据','9','sys_oper_type','','danger','N','0','admin','2025-12-18 15:46:08','',NULL,'清空操作'),(28,1,'成功','0','sys_common_status','','primary','N','0','admin','2025-12-18 15:46:08','',NULL,'正常状态'),(29,2,'失败','1','sys_common_status','','danger','N','0','admin','2025-12-18 15:46:08','',NULL,'停用状态'),(1001,1,'必修课','1','edu_course_type','','primary','N','0','admin','2025-12-18 15:46:15','',NULL,''),(1002,2,'选修课','2','edu_course_type','','success','N','0','admin','2025-12-18 15:46:15','',NULL,''),(1003,3,'公选课','3','edu_course_type','','info','N','0','admin','2025-12-18 15:46:15','',NULL,''),(1004,1,'在读','0','edu_student_status','','success','Y','0','admin','2025-12-18 15:46:15','',NULL,''),(1005,2,'毕业','1','edu_student_status','','info','N','0','admin','2025-12-18 15:46:15','',NULL,''),(1006,3,'休学','2','edu_student_status','','warning','N','0','admin','2025-12-18 15:46:15','',NULL,''),(1007,4,'退学','3','edu_student_status','','danger','N','0','admin','2025-12-18 15:46:15','',NULL,''),(1008,1,'正常','0','edu_selection_status','','success','Y','0','admin','2025-12-18 15:46:15','',NULL,''),(1009,2,'退课','1','edu_selection_status','','info','N','0','admin','2025-12-18 15:46:15','',NULL,''),(1010,1,'报名中','0','edu_opening_status','','primary','Y','0','admin','2025-12-18 15:46:15','',NULL,''),(1011,2,'已开课','1','edu_opening_status','','success','N','0','admin','2025-12-18 15:46:15','',NULL,''),(1012,3,'已结课','2','edu_opening_status','','info','N','0','admin','2025-12-18 15:46:15','',NULL,'');
/*!40000 ALTER TABLE `sys_dict_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dict_type`
--

DROP TABLE IF EXISTS `sys_dict_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_dict_type` (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典类型',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`),
  UNIQUE KEY `dict_type` (`dict_type`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='字典类型表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict_type`
--

LOCK TABLES `sys_dict_type` WRITE;
/*!40000 ALTER TABLE `sys_dict_type` DISABLE KEYS */;
INSERT INTO `sys_dict_type` VALUES (1,'用户性别','sys_user_sex','0','admin','2025-12-18 15:46:08','',NULL,'用户性别列表'),(2,'菜单状态','sys_show_hide','0','admin','2025-12-18 15:46:08','',NULL,'菜单状态列表'),(3,'系统开关','sys_normal_disable','0','admin','2025-12-18 15:46:08','',NULL,'系统开关列表'),(4,'任务状态','sys_job_status','0','admin','2025-12-18 15:46:08','',NULL,'任务状态列表'),(5,'任务分组','sys_job_group','0','admin','2025-12-18 15:46:08','',NULL,'任务分组列表'),(6,'系统是否','sys_yes_no','0','admin','2025-12-18 15:46:08','',NULL,'系统是否列表'),(7,'通知类型','sys_notice_type','0','admin','2025-12-18 15:46:08','',NULL,'通知类型列表'),(8,'通知状态','sys_notice_status','0','admin','2025-12-18 15:46:08','',NULL,'通知状态列表'),(9,'操作类型','sys_oper_type','0','admin','2025-12-18 15:46:08','',NULL,'操作类型列表'),(10,'系统状态','sys_common_status','0','admin','2025-12-18 15:46:08','',NULL,'登录状态列表'),(100,'课程类型','edu_course_type','0','admin','2025-12-18 15:46:15','',NULL,'课程类型列表'),(101,'学生状态','edu_student_status','0','admin','2025-12-18 15:46:15','',NULL,'学生在校状态'),(102,'选课状态','edu_selection_status','0','admin','2025-12-18 15:46:15','',NULL,'选课记录状态'),(103,'开课状态','edu_opening_status','0','admin','2025-12-18 15:46:15','',NULL,'开课安排状态');
/*!40000 ALTER TABLE `sys_dict_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_job`
--

DROP TABLE IF EXISTS `sys_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_job` (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) COLLATE utf8mb4_general_ci DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) COLLATE utf8mb4_general_ci DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`,`job_name`,`job_group`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='定时任务调度表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_job`
--

LOCK TABLES `sys_job` WRITE;
/*!40000 ALTER TABLE `sys_job` DISABLE KEYS */;
INSERT INTO `sys_job` VALUES (1,'系统默认（无参）','DEFAULT','ryTask.ryNoParams','0/10 * * * * ?','3','1','1','admin','2025-12-18 15:46:08','',NULL,''),(2,'系统默认（有参）','DEFAULT','ryTask.ryParams(\'ry\')','0/15 * * * * ?','3','1','1','admin','2025-12-18 15:46:08','',NULL,''),(3,'系统默认（多参）','DEFAULT','ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)','0/20 * * * * ?','3','1','1','admin','2025-12-18 15:46:08','',NULL,'');
/*!40000 ALTER TABLE `sys_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_job_log`
--

DROP TABLE IF EXISTS `sys_job_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_job_log` (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '日志信息',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '异常信息',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='定时任务调度日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_job_log`
--

LOCK TABLES `sys_job_log` WRITE;
/*!40000 ALTER TABLE `sys_job_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_job_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_logininfor`
--

DROP TABLE IF EXISTS `sys_logininfor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_logininfor` (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '操作系统',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '提示消息',
  `login_time` datetime DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`),
  KEY `idx_sys_logininfor_s` (`status`),
  KEY `idx_sys_logininfor_lt` (`login_time`)
) ENGINE=InnoDB AUTO_INCREMENT=237 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='系统访问记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_logininfor`
--

LOCK TABLES `sys_logininfor` WRITE;
/*!40000 ALTER TABLE `sys_logininfor` DISABLE KEYS */;
INSERT INTO `sys_logininfor` VALUES (100,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','退出成功','2025-12-18 16:09:51'),(101,'周宸宇','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','1','用户不存在/密码错误','2025-12-18 16:09:56'),(102,'23121608','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','1','验证码错误','2025-12-18 16:10:03'),(103,'23121608','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','1','用户不存在/密码错误','2025-12-18 16:10:06'),(104,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','1','验证码错误','2025-12-18 16:10:12'),(105,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-18 16:10:15'),(106,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','退出成功','2025-12-18 16:12:06'),(107,'23121608','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','1','验证码错误','2025-12-18 16:12:20'),(108,'23121608','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-18 16:12:23'),(109,'23121608','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','退出成功','2025-12-18 16:14:45'),(110,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-18 16:14:52'),(111,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-18 17:07:27'),(112,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','退出成功','2025-12-18 17:08:22'),(113,'23121608','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-18 17:08:33'),(114,'23121608','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','退出成功','2025-12-18 17:09:12'),(115,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-18 17:09:15'),(116,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','退出成功','2025-12-18 17:09:45'),(117,'23121608','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-18 17:09:56'),(118,'23121608','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','退出成功','2025-12-18 17:13:15'),(119,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-18 17:13:29'),(120,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','退出成功','2025-12-18 17:14:20'),(121,'teacher01','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','1','用户不存在/密码错误','2025-12-18 17:14:30'),(122,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-18 17:14:40'),(123,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-18 23:07:43'),(124,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-20 15:00:57'),(125,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','退出成功','2025-12-20 15:15:03'),(126,'teacher01','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','1','用户不存在/密码错误','2025-12-20 15:15:11'),(127,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-20 15:15:21'),(128,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','退出成功','2025-12-20 15:29:11'),(129,'23121608','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','1','用户不存在/密码错误','2025-12-20 15:29:21'),(130,'23121608','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-20 15:29:30'),(131,'23121608','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','退出成功','2025-12-20 15:29:56'),(132,'teacher01','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-20 15:30:06'),(133,'teacher01','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','退出成功','2025-12-20 15:34:30'),(134,'student03','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','1','用户不存在/密码错误','2025-12-20 15:34:51'),(135,'student03','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','1','用户不存在/密码错误','2025-12-20 15:35:05'),(136,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-20 15:35:13'),(137,'2021001','127.0.0.1','内网IP','Curl 8.9.1','','1','验证码已失效','2025-12-20 15:44:19'),(138,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','退出成功','2025-12-20 15:45:19'),(139,'2021001','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-20 15:45:30'),(140,'2021001','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','退出成功','2025-12-20 15:45:47'),(141,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','1','验证码错误','2025-12-20 15:45:52'),(142,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-20 15:45:56'),(143,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','退出成功','2025-12-20 15:51:49'),(144,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-20 15:51:59'),(145,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','退出成功','2025-12-20 15:52:45'),(146,'2021001','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-20 15:52:50'),(147,'2021001','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','退出成功','2025-12-20 15:56:52'),(148,'teacher01','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-20 15:57:00'),(149,'teacher01','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','退出成功','2025-12-20 16:01:17'),(150,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-20 16:01:22'),(151,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','退出成功','2025-12-20 17:00:59'),(152,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-20 17:01:04'),(153,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','退出成功','2025-12-20 17:04:26'),(154,'teacher02','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-20 17:04:37'),(155,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-21 12:45:53'),(156,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-21 12:47:20'),(157,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','退出成功','2025-12-21 12:49:24'),(158,'teacher01','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','1','用户不存在/密码错误','2025-12-21 12:49:33'),(159,'teacher01','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','1','用户不存在/密码错误','2025-12-21 12:49:40'),(160,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-21 12:49:49'),(161,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','退出成功','2025-12-21 12:50:18'),(162,'teacher02','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-21 12:50:26'),(163,'teacher02','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','退出成功','2025-12-21 13:03:23'),(164,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-21 13:03:25'),(165,'teacher1','127.0.0.1','内网IP','Curl 8.9.1','','1','验证码已失效','2025-12-21 13:20:16'),(166,'teacher01','127.0.0.1','内网IP','Curl 8.9.1','','1','验证码已失效','2025-12-21 13:22:07'),(167,'teacher01','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-21 13:42:17'),(168,'teacher01','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','退出成功','2025-12-21 13:43:53'),(169,'23121608','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','1','用户不存在/密码错误','2025-12-21 13:43:59'),(170,'23121608','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','1','验证码错误','2025-12-21 13:44:03'),(171,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','1','验证码错误','2025-12-21 13:44:10'),(172,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-21 13:44:14'),(173,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','退出成功','2025-12-21 13:44:26'),(174,'student01','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-21 13:44:31'),(175,'student01','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','退出成功','2025-12-21 14:02:12'),(176,'teacher01','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-21 14:02:20'),(177,'teacher01','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','退出成功','2025-12-21 14:02:42'),(178,'student01','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-21 14:02:55'),(179,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-21 15:01:48'),(180,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-21 16:21:51'),(181,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','1','验证码已失效','2025-12-21 16:30:41'),(182,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','1','验证码错误','2025-12-21 16:30:44'),(183,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-21 16:30:50'),(184,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','退出成功','2025-12-21 16:48:50'),(185,'student01','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-21 16:48:55'),(186,'student01','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','退出成功','2025-12-21 17:09:07'),(187,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-21 17:09:09'),(188,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','退出成功','2025-12-21 17:22:30'),(189,'teacher03','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-21 17:22:38'),(190,'teacher03','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','退出成功','2025-12-21 17:24:19'),(191,'teacher80','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','1','用户不存在/密码错误','2025-12-21 17:24:35'),(192,'teacher08','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','1','用户不存在/密码错误','2025-12-21 17:24:41'),(193,'teacher01','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-21 17:24:48'),(194,'teacher01','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','退出成功','2025-12-21 17:26:09'),(195,'student09','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','1','用户不存在/密码错误','2025-12-21 17:26:20'),(196,'student02','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','1','用户不存在/密码错误','2025-12-21 17:26:29'),(197,'student02','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','1','用户不存在/密码错误','2025-12-21 17:26:31'),(198,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-21 17:26:38'),(199,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','退出成功','2025-12-21 17:30:14'),(200,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-21 17:30:18'),(201,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','退出成功','2025-12-21 17:30:23'),(202,'23000001','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-21 17:30:38'),(203,'23000001','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','退出成功','2025-12-21 17:31:43'),(204,'100000003','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','1','用户不存在/密码错误','2025-12-21 17:31:50'),(205,'10000003','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-21 17:31:55'),(206,'10000003','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','退出成功','2025-12-21 17:33:15'),(207,'10000003','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','1','验证码错误','2025-12-21 17:33:23'),(208,'1000003','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','1','用户不存在/密码错误','2025-12-21 17:33:27'),(209,'10000003','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-21 17:33:40'),(210,'10000003','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','退出成功','2025-12-21 17:34:04'),(211,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-21 17:34:07'),(212,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','退出成功','2025-12-21 17:35:23'),(213,'100000001','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','1','用户不存在/密码错误','2025-12-21 17:35:29'),(214,'10000001','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-21 17:35:32'),(215,'10000001','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','退出成功','2025-12-21 17:36:46'),(216,'100000002','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','1','用户不存在/密码错误','2025-12-21 17:36:51'),(217,'10000008','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-21 17:37:00'),(218,'10000008','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','退出成功','2025-12-21 17:37:16'),(219,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-21 17:37:20'),(220,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','退出成功','2025-12-21 17:37:52'),(221,'10000001','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-21 17:37:59'),(222,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-21 19:54:18'),(223,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','退出成功','2025-12-21 19:58:23'),(224,'10000001','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-21 19:58:30'),(225,'10000001','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','退出成功','2025-12-21 20:01:53'),(226,'23000003','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-21 20:02:02'),(227,'23000003','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','退出成功','2025-12-21 20:02:53'),(228,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-21 20:02:57'),(229,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','退出成功','2025-12-21 20:03:36'),(230,'230000003','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','1','用户不存在/密码错误','2025-12-21 20:03:45'),(231,'23000003','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-21 20:03:50'),(232,'23000003','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','退出成功','2025-12-21 20:04:32'),(233,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-21 20:04:34'),(234,'admin','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','退出成功','2025-12-21 20:05:14'),(235,'231000003','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','1','用户不存在/密码错误','2025-12-21 20:05:21'),(236,'23000003','127.0.0.1','内网IP','Chrome 143','Mac OS >=10.15.7','0','登录成功','2025-12-21 20:05:26');
/*!40000 ALTER TABLE `sys_logininfor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_menu`
--

DROP TABLE IF EXISTS `sys_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_menu` (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint DEFAULT '0' COMMENT '父菜单ID',
  `order_num` int DEFAULT '0' COMMENT '显示顺序',
  `path` varchar(200) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '路由名称',
  `is_frame` int DEFAULT '1' COMMENT '是否为外链（0是 1否）',
  `is_cache` int DEFAULT '0' COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4094 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='菜单权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_menu`
--

LOCK TABLES `sys_menu` WRITE;
/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;
INSERT INTO `sys_menu` VALUES (1,'系统管理',0,1,'system',NULL,'','',1,0,'M','0','0','','system','admin','2025-12-18 15:46:08','',NULL,'系统管理目录'),(2,'系统监控',0,2,'monitor',NULL,'','',1,0,'M','0','0','','monitor','admin','2025-12-18 15:46:08','',NULL,'系统监控目录'),(3,'系统工具',0,3,'tool',NULL,'','',1,0,'M','0','0','','tool','admin','2025-12-18 15:46:08','',NULL,'系统工具目录'),(100,'用户管理',1,1,'user','system/user/index','','',1,0,'C','0','0','system:user:list','user','admin','2025-12-18 15:46:08','',NULL,'用户管理菜单'),(101,'角色管理',1,2,'role','system/role/index','','',1,0,'C','0','0','system:role:list','peoples','admin','2025-12-18 15:46:08','',NULL,'角色管理菜单'),(102,'菜单管理',1,3,'menu','system/menu/index','','',1,0,'C','0','0','system:menu:list','tree-table','admin','2025-12-18 15:46:08','',NULL,'菜单管理菜单'),(103,'学院管理',1,4,'dept','system/dept/index','','',1,0,'C','0','0','system:dept:list','tree','admin','2025-12-18 15:46:08','',NULL,'学院管理菜单'),(105,'字典管理',1,6,'dict','system/dict/index','','',1,0,'C','0','0','system:dict:list','dict','admin','2025-12-18 15:46:08','',NULL,'字典管理菜单'),(106,'参数设置',1,7,'config','system/config/index','','',1,0,'C','0','0','system:config:list','edit','admin','2025-12-18 15:46:08','',NULL,'参数设置菜单'),(107,'通知公告',1,8,'notice','system/notice/index','','',1,0,'C','0','0','system:notice:list','message','admin','2025-12-18 15:46:08','',NULL,'通知公告菜单'),(108,'日志管理',1,9,'log','','','',1,0,'M','0','0','','log','admin','2025-12-18 15:46:08','',NULL,'日志管理菜单'),(109,'在线用户',2,1,'online','monitor/online/index','','',1,0,'C','0','0','monitor:online:list','online','admin','2025-12-18 15:46:08','',NULL,'在线用户菜单'),(110,'定时任务',2,2,'job','monitor/job/index','','',1,0,'C','0','0','monitor:job:list','job','admin','2025-12-18 15:46:08','',NULL,'定时任务菜单'),(111,'数据监控',2,3,'druid','monitor/druid/index','','',1,0,'C','0','0','monitor:druid:list','druid','admin','2025-12-18 15:46:08','',NULL,'数据监控菜单'),(112,'服务监控',2,4,'server','monitor/server/index','','',1,0,'C','0','0','monitor:server:list','server','admin','2025-12-18 15:46:08','',NULL,'服务监控菜单'),(113,'缓存监控',2,5,'cache','monitor/cache/index','','',1,0,'C','0','0','monitor:cache:list','redis','admin','2025-12-18 15:46:08','',NULL,'缓存监控菜单'),(114,'缓存列表',2,6,'cacheList','monitor/cache/list','','',1,0,'C','0','0','monitor:cache:list','redis-list','admin','2025-12-18 15:46:08','',NULL,'缓存列表菜单'),(115,'表单构建',3,1,'build','tool/build/index','','',1,0,'C','0','0','tool:build:list','build','admin','2025-12-18 15:46:08','',NULL,'表单构建菜单'),(116,'代码生成',3,2,'gen','tool/gen/index','','',1,0,'C','0','0','tool:gen:list','code','admin','2025-12-18 15:46:08','',NULL,'代码生成菜单'),(117,'系统接口',3,3,'swagger','tool/swagger/index','','',1,0,'C','0','0','tool:swagger:list','swagger','admin','2025-12-18 15:46:08','',NULL,'系统接口菜单'),(500,'操作日志',108,1,'operlog','monitor/operlog/index','','',1,0,'C','0','0','monitor:operlog:list','form','admin','2025-12-18 15:46:08','',NULL,'操作日志菜单'),(501,'登录日志',108,2,'logininfor','monitor/logininfor/index','','',1,0,'C','0','0','monitor:logininfor:list','logininfor','admin','2025-12-18 15:46:08','',NULL,'登录日志菜单'),(1000,'用户查询',100,1,'','','','',1,0,'F','0','0','system:user:query','#','admin','2025-12-18 15:46:08','',NULL,''),(1001,'用户新增',100,2,'','','','',1,0,'F','0','0','system:user:add','#','admin','2025-12-18 15:46:08','',NULL,''),(1002,'用户修改',100,3,'','','','',1,0,'F','0','0','system:user:edit','#','admin','2025-12-18 15:46:08','',NULL,''),(1003,'用户删除',100,4,'','','','',1,0,'F','0','0','system:user:remove','#','admin','2025-12-18 15:46:08','',NULL,''),(1004,'用户导出',100,5,'','','','',1,0,'F','0','0','system:user:export','#','admin','2025-12-18 15:46:08','',NULL,''),(1005,'用户导入',100,6,'','','','',1,0,'F','0','0','system:user:import','#','admin','2025-12-18 15:46:08','',NULL,''),(1006,'重置密码',100,7,'','','','',1,0,'F','0','0','system:user:resetPwd','#','admin','2025-12-18 15:46:08','',NULL,''),(1007,'角色查询',101,1,'','','','',1,0,'F','0','0','system:role:query','#','admin','2025-12-18 15:46:08','',NULL,''),(1008,'角色新增',101,2,'','','','',1,0,'F','0','0','system:role:add','#','admin','2025-12-18 15:46:08','',NULL,''),(1009,'角色修改',101,3,'','','','',1,0,'F','0','0','system:role:edit','#','admin','2025-12-18 15:46:08','',NULL,''),(1010,'角色删除',101,4,'','','','',1,0,'F','0','0','system:role:remove','#','admin','2025-12-18 15:46:08','',NULL,''),(1011,'角色导出',101,5,'','','','',1,0,'F','0','0','system:role:export','#','admin','2025-12-18 15:46:08','',NULL,''),(1012,'菜单查询',102,1,'','','','',1,0,'F','0','0','system:menu:query','#','admin','2025-12-18 15:46:08','',NULL,''),(1013,'菜单新增',102,2,'','','','',1,0,'F','0','0','system:menu:add','#','admin','2025-12-18 15:46:08','',NULL,''),(1014,'菜单修改',102,3,'','','','',1,0,'F','0','0','system:menu:edit','#','admin','2025-12-18 15:46:08','',NULL,''),(1015,'菜单删除',102,4,'','','','',1,0,'F','0','0','system:menu:remove','#','admin','2025-12-18 15:46:08','',NULL,''),(1016,'学院查询',103,1,'','','','',1,0,'F','0','0','system:dept:query','#','admin','2025-12-18 15:46:08','',NULL,''),(1017,'学院新增',103,2,'','','','',1,0,'F','0','0','system:dept:add','#','admin','2025-12-18 15:46:08','',NULL,''),(1018,'学院修改',103,3,'','','','',1,0,'F','0','0','system:dept:edit','#','admin','2025-12-18 15:46:08','',NULL,''),(1019,'学院删除',103,4,'','','','',1,0,'F','0','0','system:dept:remove','#','admin','2025-12-18 15:46:08','',NULL,''),(1025,'字典查询',105,1,'#','','','',1,0,'F','0','0','system:dict:query','#','admin','2025-12-18 15:46:08','',NULL,''),(1026,'字典新增',105,2,'#','','','',1,0,'F','0','0','system:dict:add','#','admin','2025-12-18 15:46:08','',NULL,''),(1027,'字典修改',105,3,'#','','','',1,0,'F','0','0','system:dict:edit','#','admin','2025-12-18 15:46:08','',NULL,''),(1028,'字典删除',105,4,'#','','','',1,0,'F','0','0','system:dict:remove','#','admin','2025-12-18 15:46:08','',NULL,''),(1029,'字典导出',105,5,'#','','','',1,0,'F','0','0','system:dict:export','#','admin','2025-12-18 15:46:08','',NULL,''),(1030,'参数查询',106,1,'#','','','',1,0,'F','0','0','system:config:query','#','admin','2025-12-18 15:46:08','',NULL,''),(1031,'参数新增',106,2,'#','','','',1,0,'F','0','0','system:config:add','#','admin','2025-12-18 15:46:08','',NULL,''),(1032,'参数修改',106,3,'#','','','',1,0,'F','0','0','system:config:edit','#','admin','2025-12-18 15:46:08','',NULL,''),(1033,'参数删除',106,4,'#','','','',1,0,'F','0','0','system:config:remove','#','admin','2025-12-18 15:46:08','',NULL,''),(1034,'参数导出',106,5,'#','','','',1,0,'F','0','0','system:config:export','#','admin','2025-12-18 15:46:08','',NULL,''),(1035,'公告查询',107,1,'#','','','',1,0,'F','0','0','system:notice:query','#','admin','2025-12-18 15:46:08','',NULL,''),(1036,'公告新增',107,2,'#','','','',1,0,'F','0','0','system:notice:add','#','admin','2025-12-18 15:46:08','',NULL,''),(1037,'公告修改',107,3,'#','','','',1,0,'F','0','0','system:notice:edit','#','admin','2025-12-18 15:46:08','',NULL,''),(1038,'公告删除',107,4,'#','','','',1,0,'F','0','0','system:notice:remove','#','admin','2025-12-18 15:46:08','',NULL,''),(1039,'操作查询',500,1,'#','','','',1,0,'F','0','0','monitor:operlog:query','#','admin','2025-12-18 15:46:08','',NULL,''),(1040,'操作删除',500,2,'#','','','',1,0,'F','0','0','monitor:operlog:remove','#','admin','2025-12-18 15:46:08','',NULL,''),(1041,'日志导出',500,3,'#','','','',1,0,'F','0','0','monitor:operlog:export','#','admin','2025-12-18 15:46:08','',NULL,''),(1042,'登录查询',501,1,'#','','','',1,0,'F','0','0','monitor:logininfor:query','#','admin','2025-12-18 15:46:08','',NULL,''),(1043,'登录删除',501,2,'#','','','',1,0,'F','0','0','monitor:logininfor:remove','#','admin','2025-12-18 15:46:08','',NULL,''),(1044,'日志导出',501,3,'#','','','',1,0,'F','0','0','monitor:logininfor:export','#','admin','2025-12-18 15:46:08','',NULL,''),(1045,'账户解锁',501,4,'#','','','',1,0,'F','0','0','monitor:logininfor:unlock','#','admin','2025-12-18 15:46:08','',NULL,''),(1046,'在线查询',109,1,'#','','','',1,0,'F','0','0','monitor:online:query','#','admin','2025-12-18 15:46:08','',NULL,''),(1047,'批量强退',109,2,'#','','','',1,0,'F','0','0','monitor:online:batchLogout','#','admin','2025-12-18 15:46:08','',NULL,''),(1048,'单条强退',109,3,'#','','','',1,0,'F','0','0','monitor:online:forceLogout','#','admin','2025-12-18 15:46:08','',NULL,''),(1049,'任务查询',110,1,'#','','','',1,0,'F','0','0','monitor:job:query','#','admin','2025-12-18 15:46:08','',NULL,''),(1050,'任务新增',110,2,'#','','','',1,0,'F','0','0','monitor:job:add','#','admin','2025-12-18 15:46:08','',NULL,''),(1051,'任务修改',110,3,'#','','','',1,0,'F','0','0','monitor:job:edit','#','admin','2025-12-18 15:46:08','',NULL,''),(1052,'任务删除',110,4,'#','','','',1,0,'F','0','0','monitor:job:remove','#','admin','2025-12-18 15:46:08','',NULL,''),(1053,'状态修改',110,5,'#','','','',1,0,'F','0','0','monitor:job:changeStatus','#','admin','2025-12-18 15:46:08','',NULL,''),(1054,'任务导出',110,6,'#','','','',1,0,'F','0','0','monitor:job:export','#','admin','2025-12-18 15:46:08','',NULL,''),(1055,'生成查询',116,1,'#','','','',1,0,'F','0','0','tool:gen:query','#','admin','2025-12-18 15:46:08','',NULL,''),(1056,'生成修改',116,2,'#','','','',1,0,'F','0','0','tool:gen:edit','#','admin','2025-12-18 15:46:08','',NULL,''),(1057,'生成删除',116,3,'#','','','',1,0,'F','0','0','tool:gen:remove','#','admin','2025-12-18 15:46:08','',NULL,''),(1058,'导入代码',116,4,'#','','','',1,0,'F','0','0','tool:gen:import','#','admin','2025-12-18 15:46:08','',NULL,''),(1059,'预览代码',116,5,'#','','','',1,0,'F','0','0','tool:gen:preview','#','admin','2025-12-18 15:46:08','',NULL,''),(1060,'生成代码',116,6,'#','','','',1,0,'F','0','0','tool:gen:code','#','admin','2025-12-18 15:46:08','',NULL,''),(4000,'教务管理',0,5,'education',NULL,'','',1,0,'M','0','0','','education','admin','2025-12-18 15:47:48','',NULL,'教务管理目录'),(4001,'学期管理',4000,1,'term','education/term/index','','',1,0,'C','0','0','education:term:list','date','admin','2025-12-18 15:47:48','',NULL,'学期管理菜单'),(4002,'学生管理',4000,2,'student','education/student/index','','',1,0,'C','0','0','education:student:list','peoples','admin','2025-12-18 15:47:48','',NULL,'学生管理菜单'),(4003,'教师管理',4000,3,'teacher','education/teacher/index','','',1,0,'C','0','0','education:teacher:list','user','admin','2025-12-18 15:47:48','',NULL,'教师管理菜单'),(4004,'课程管理',4000,4,'course','education/course/index','','',1,0,'C','0','0','education:course:list','list','admin','2025-12-18 15:47:48','',NULL,'课程管理菜单'),(4005,'开课安排',4000,5,'opening','education/opening/index','','',1,0,'C','0','0','education:opening:list','time-range','admin','2025-12-18 15:47:48','',NULL,'开课安排菜单'),(4006,'选课记录',4000,6,'selection','education/selection/index','','',1,0,'C','0','0','education:selection:list','checkbox','admin','2025-12-18 15:47:48','',NULL,'选课记录菜单'),(4007,'学生选课',4000,7,'enroll','education/selection/enroll','','',1,0,'C','0','0','education:selection:enroll','shopping','admin','2025-12-18 15:47:48','',NULL,'学生选课菜单'),(4010,'我的课程',4000,10,'teacherCourse','education/teacherCourse/index',NULL,'',1,0,'C','0','0','education:teacherCourse:list','cascader','admin','2025-12-20 17:09:35','admin','2025-12-21 13:04:18','教师查看自己的开课列表'),(4011,'学期查询',4001,1,'','','','',1,0,'F','0','0','education:term:query','#','admin','2025-12-18 15:47:48','',NULL,''),(4012,'学期新增',4001,2,'','','','',1,0,'F','0','0','education:term:add','#','admin','2025-12-18 15:47:48','',NULL,''),(4013,'学期修改',4001,3,'','','','',1,0,'F','0','0','education:term:edit','#','admin','2025-12-18 15:47:48','',NULL,''),(4014,'学期删除',4001,4,'','','','',1,0,'F','0','0','education:term:remove','#','admin','2025-12-18 15:47:48','',NULL,''),(4015,'学期导出',4001,5,'','','','',1,0,'F','0','0','education:term:export','#','admin','2025-12-18 15:47:48','',NULL,''),(4021,'学生查询',4002,1,'','','','',1,0,'F','0','0','education:student:query','#','admin','2025-12-18 15:47:48','',NULL,''),(4022,'学生新增',4002,2,'','','','',1,0,'F','0','0','education:student:add','#','admin','2025-12-18 15:47:48','',NULL,''),(4023,'学生修改',4002,3,'','','','',1,0,'F','0','0','education:student:edit','#','admin','2025-12-18 15:47:48','',NULL,''),(4024,'学生删除',4002,4,'','','','',1,0,'F','0','0','education:student:remove','#','admin','2025-12-18 15:47:48','',NULL,''),(4025,'学生导出',4002,5,'','','','',1,0,'F','0','0','education:student:export','#','admin','2025-12-18 15:47:48','',NULL,''),(4031,'教师查询',4003,1,'','','','',1,0,'F','0','0','education:teacher:query','#','admin','2025-12-18 15:47:48','',NULL,''),(4032,'教师新增',4003,2,'','','','',1,0,'F','0','0','education:teacher:add','#','admin','2025-12-18 15:47:48','',NULL,''),(4033,'教师修改',4003,3,'','','','',1,0,'F','0','0','education:teacher:edit','#','admin','2025-12-18 15:47:48','',NULL,''),(4034,'教师删除',4003,4,'','','','',1,0,'F','0','0','education:teacher:remove','#','admin','2025-12-18 15:47:48','',NULL,''),(4035,'教师导出',4003,5,'','','','',1,0,'F','0','0','education:teacher:export','#','admin','2025-12-18 15:47:48','',NULL,''),(4041,'课程查询',4004,1,'','','','',1,0,'F','0','0','education:course:query','#','admin','2025-12-18 15:47:48','',NULL,''),(4042,'课程新增',4004,2,'','','','',1,0,'F','0','0','education:course:add','#','admin','2025-12-18 15:47:48','',NULL,''),(4043,'课程修改',4004,3,'','','','',1,0,'F','0','0','education:course:edit','#','admin','2025-12-18 15:47:48','',NULL,''),(4044,'课程删除',4004,4,'','','','',1,0,'F','0','0','education:course:remove','#','admin','2025-12-18 15:47:48','',NULL,''),(4045,'课程导出',4004,5,'','','','',1,0,'F','0','0','education:course:export','#','admin','2025-12-18 15:47:48','',NULL,''),(4050,'我的课表',4000,50,'schedule/student','education/schedule/student',NULL,'',1,0,'C','0','0','education:schedule:student','date','','2025-12-21 16:43:37','',NULL,''),(4051,'开课查询',4005,1,'','','','',1,0,'F','0','0','education:opening:query','#','admin','2025-12-18 15:47:48','',NULL,''),(4052,'开课新增',4005,2,'','','','',1,0,'F','0','0','education:opening:add','#','admin','2025-12-18 15:47:48','',NULL,''),(4053,'开课修改',4005,3,'','','','',1,0,'F','0','0','education:opening:edit','#','admin','2025-12-18 15:47:48','',NULL,''),(4054,'开课删除',4005,4,'','','','',1,0,'F','0','0','education:opening:remove','#','admin','2025-12-18 15:47:48','',NULL,''),(4055,'开课导出',4005,5,'','','','',1,0,'F','0','0','education:opening:export','#','admin','2025-12-18 15:47:48','',NULL,''),(4061,'选课查询',4006,1,'','','','',1,0,'F','0','0','education:selection:query','#','admin','2025-12-18 15:47:48','',NULL,''),(4062,'选课新增',4006,2,'','','','',1,0,'F','0','0','education:selection:add','#','admin','2025-12-18 15:47:48','',NULL,''),(4063,'选课修改',4006,3,'','','','',1,0,'F','0','0','education:selection:edit','#','admin','2025-12-18 15:47:48','',NULL,''),(4064,'选课删除',4006,4,'','','','',1,0,'F','0','0','education:selection:remove','#','admin','2025-12-18 15:47:48','',NULL,''),(4065,'选课导出',4006,5,'','','','',1,0,'F','0','0','education:selection:export','#','admin','2025-12-18 15:47:48','',NULL,''),(4070,'学生名单',4000,70,'teacherStudent','education/teacherStudent/index',NULL,'',1,0,'C','1','0','education:teacherStudent:list','peoples','admin','2025-12-20 17:11:00','',NULL,'教师查看课程学生名单'),(4071,'修改课程信息',4010,2,'',NULL,NULL,'',1,0,'F','0','0','education:teacherCourse:edit','#','admin','2025-12-20 17:11:00','',NULL,''),(4072,'查询学生名单',4070,1,'',NULL,NULL,'',1,0,'F','0','0','education:teacherStudent:list','#','admin','2025-12-20 17:11:00','',NULL,''),(4073,'录入成绩',4070,2,'',NULL,NULL,'',1,0,'F','0','0','education:teacherStudent:edit','#','admin','2025-12-20 17:11:00','',NULL,''),(4080,'录入成绩',4000,15,'scoreInput','education/scoreInput/index',NULL,'',1,0,'C','0','0','education:score:list','edit','admin','2025-12-21 13:07:12','',NULL,'教师录入学生成绩'),(4081,'录入成绩',4080,1,'',NULL,NULL,'',1,0,'F','0','0','education:score:edit','#','admin','2025-12-21 13:07:12','',NULL,''),(4090,'成绩查询',4000,20,'myScore','education/myScore/index',NULL,'',1,0,'C','0','0','education:myScore:list','chart','admin','2025-12-21 13:59:02','',NULL,'学生查询自己的成绩'),(4091,'教师课表',4000,71,'schedule/teacher','education/schedule/teacher',NULL,'',1,0,'C','0','0','education:schedule:teacher','date','','2025-12-21 16:44:01','',NULL,''),(4092,'课程评价',4000,92,'evaluation/student','education/evaluation/student',NULL,'',1,0,'C','0','0','education:evaluation:student','star','','2025-12-21 16:44:01','',NULL,''),(4093,'GPA与预警',4000,93,'gpa','education/gpa/index',NULL,'',1,0,'C','0','0','education:gpa:query','chart','','2025-12-21 16:44:01','',NULL,'');
/*!40000 ALTER TABLE `sys_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_notice`
--

DROP TABLE IF EXISTS `sys_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_notice` (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob COMMENT '公告内容',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='通知公告表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_notice`
--

LOCK TABLES `sys_notice` WRITE;
/*!40000 ALTER TABLE `sys_notice` DISABLE KEYS */;
INSERT INTO `sys_notice` VALUES (1,'温馨提醒：2018-07-01 若依新版本发布啦','2',_binary '新版本内容','0','admin','2025-12-18 15:46:08','',NULL,'管理员'),(2,'维护通知：2018-07-01 若依系统凌晨维护','1',_binary '维护内容','0','admin','2025-12-18 15:46:08','',NULL,'管理员');
/*!40000 ALTER TABLE `sys_notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_oper_log`
--

DROP TABLE IF EXISTS `sys_oper_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_oper_log` (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '模块标题',
  `business_type` int DEFAULT '0' COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '请求方式',
  `operator_type` int DEFAULT '0' COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '返回参数',
  `status` int DEFAULT '0' COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint DEFAULT '0' COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`),
  KEY `idx_sys_oper_log_bt` (`business_type`),
  KEY `idx_sys_oper_log_s` (`status`),
  KEY `idx_sys_oper_log_ot` (`oper_time`)
) ENGINE=InnoDB AUTO_INCREMENT=156 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='操作日志记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_oper_log`
--

LOCK TABLES `sys_oper_log` WRITE;
/*!40000 ALTER TABLE `sys_oper_log` DISABLE KEYS */;
INSERT INTO `sys_oper_log` VALUES (100,'角色管理',2,'com.ruoyi.web.controller.system.SysRoleController.edit()','PUT',1,'admin','教学管理中心','/system/role','127.0.0.1','内网IP','{\"admin\":false,\"createTime\":\"2025-12-18 15:46:08\",\"dataScope\":\"3\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[4000,4004,4005,4006,1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117,4041,4051,4052,4053,4061,4063],\"params\":{},\"remark\":\"教师角色，可以管理课程、查看选课情况\",\"roleId\":2,\"roleKey\":\"teacher\",\"roleName\":\"教师\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-12-18 15:49:33',131),(101,'菜单管理',3,'com.ruoyi.web.controller.system.SysMenuController.remove()','DELETE',1,'admin','教学管理中心','/system/menu/2000','127.0.0.1','内网IP','2000 ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-12-18 16:08:45',38),(102,'菜单管理',3,'com.ruoyi.web.controller.system.SysMenuController.remove()','DELETE',1,'admin','教学管理中心','/system/menu/5','127.0.0.1','内网IP','5 ','{\"msg\":\"存在子菜单,不允许删除\",\"code\":601}',0,NULL,'2025-12-18 16:08:48',13),(103,'学生信息',1,'com.ruoyi.education.controller.EduStudentController.add()','POST',1,'admin','教学管理中心','/education/student','127.0.0.1','内网IP','{\"createTime\":\"2025-12-18 16:09:36\",\"deptId\":106,\"grade\":\"2023\",\"major\":\"智能科学\",\"nickName\":\"周宸宇\",\"params\":{},\"sex\":\"0\",\"studentId\":2,\"studentNo\":\"23121608\",\"userId\":100} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-12-18 16:09:36',111),(104,'学生选课',1,'com.ruoyi.education.controller.EduStudentCourseController.enroll()','POST',1,'23121608','计算机科学系','/education/selection/enroll/6','127.0.0.1','内网IP','6 ','{\"msg\":\"选课成功\",\"code\":200}',0,NULL,'2025-12-18 16:12:30',39),(105,'学生选课',1,'com.ruoyi.education.controller.EduStudentCourseController.enroll()','POST',1,'23121608','计算机科学系','/education/selection/enroll/3','127.0.0.1','内网IP','3 ','{\"msg\":\"选课成功\",\"code\":200}',0,NULL,'2025-12-18 16:12:34',35),(106,'学生选课',1,'com.ruoyi.education.controller.EduStudentCourseController.enroll()','POST',1,'23121608','计算机科学系','/education/selection/enroll/1','127.0.0.1','内网IP','1 ','{\"msg\":\"选课成功\",\"code\":200}',0,NULL,'2025-12-18 16:12:36',36),(107,'学生信息',1,'com.ruoyi.education.controller.EduStudentController.add()','POST',1,'admin','教学管理中心','/education/student','127.0.0.1','内网IP','{\"createTime\":\"2025-12-18 17:07:48\",\"deptId\":106,\"nickName\":\"刘思琪\",\"params\":{},\"sex\":\"0\",\"studentId\":3,\"studentNo\":\"23121609\",\"userId\":101} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-12-18 17:07:48',90),(108,'学生退课',3,'com.ruoyi.education.controller.EduStudentCourseController.withdraw()','DELETE',1,'23121608','计算机科学系','/education/selection/withdraw/1','127.0.0.1','内网IP','1 ','{\"msg\":\"退课成功\",\"code\":200}',0,NULL,'2025-12-18 17:08:52',36),(109,'学生选课',1,'com.ruoyi.education.controller.EduStudentCourseController.enroll()','POST',1,'23121608','计算机科学系','/education/selection/enroll/5','127.0.0.1','内网IP','5 ','{\"msg\":\"选课成功\",\"code\":200}',0,NULL,'2025-12-18 17:09:01',33),(110,'学生选课',1,'com.ruoyi.education.controller.EduStudentCourseController.enroll()','POST',1,'23121608','计算机科学系','/education/selection/enroll/4','127.0.0.1','内网IP','4 ','{\"msg\":\"选课成功\",\"code\":200}',0,NULL,'2025-12-18 17:09:04',30),(111,'学生选课',1,'com.ruoyi.education.controller.EduStudentCourseController.enroll()','POST',1,'23121608','计算机科学系','/education/selection/enroll/2','127.0.0.1','内网IP','2 ','{\"msg\":\"选课成功\",\"code\":200}',0,NULL,'2025-12-18 17:09:06',29),(112,'选课记录',3,'com.ruoyi.education.controller.EduStudentCourseController.remove()','DELETE',1,'admin','教学管理中心','/education/selection/7,6,5','127.0.0.1','内网IP','[7,6,5] ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-12-18 17:09:40',8),(113,'代码生成',6,'com.ruoyi.generator.controller.GenController.importTableSave()','POST',1,'admin','教学管理中心','/tool/gen/importTable','127.0.0.1','内网IP','{\"tables\":\"edu_term\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-12-18 17:18:05',89),(114,'代码生成',8,'com.ruoyi.generator.controller.GenController.batchGenCode()','GET',1,'admin','教学管理中心','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"edu_term\"}',NULL,0,NULL,'2025-12-18 17:18:11',201),(115,'学生选课',1,'com.ruoyi.education.controller.EduStudentCourseController.enroll()','POST',1,'admin','教学管理中心','/education/selection/enroll/6','127.0.0.1','内网IP','6 ','{\"msg\":\"您不是学生用户，无法选课\",\"code\":500}',0,NULL,'2025-12-20 15:07:42',26),(116,'学期信息',2,'com.ruoyi.education.controller.EduTermController.edit()','PUT',1,'admin','教学管理中心','/education/term','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"createTime\":\"2025-12-18 15:46:15\",\"endDate\":\"2025-01-15\",\"isCurrent\":\"1\",\"params\":{},\"remark\":\"秋季学期\",\"startDate\":\"2024-09-01\",\"status\":\"0\",\"termId\":1,\"termName\":\"2024-2025学年第一学期\",\"updateBy\":\"\",\"updateTime\":\"2025-12-20 15:08:09\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-12-20 15:08:09',20),(117,'学期信息',2,'com.ruoyi.education.controller.EduTermController.edit()','PUT',1,'admin','教学管理中心','/education/term','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"createTime\":\"2025-12-18 15:46:15\",\"endDate\":\"2025-07-05\",\"isCurrent\":\"1\",\"params\":{},\"remark\":\"春季学期（当前）\",\"startDate\":\"2025-02-17\",\"status\":\"0\",\"termId\":2,\"termName\":\"2024-2025学年第二学期\",\"updateBy\":\"\",\"updateTime\":\"2025-12-20 15:08:34\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-12-20 15:08:34',21),(118,'角色管理',2,'com.ruoyi.web.controller.system.SysRoleController.changeStatus()','PUT',1,'admin','教学管理中心','/system/role/changeStatus','127.0.0.1','内网IP','{\"admin\":true,\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":1,\"status\":\"1\"} ',NULL,1,'不允许操作超级管理员角色','2025-12-20 15:10:09',2),(119,'角色管理',2,'com.ruoyi.web.controller.system.SysRoleController.changeStatus()','PUT',1,'admin','教学管理中心','/system/role/changeStatus','127.0.0.1','内网IP','{\"admin\":false,\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":2,\"status\":\"1\",\"updateBy\":\"admin\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-12-20 15:10:12',9),(120,'角色管理',2,'com.ruoyi.web.controller.system.SysRoleController.changeStatus()','PUT',1,'admin','教学管理中心','/system/role/changeStatus','127.0.0.1','内网IP','{\"admin\":false,\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":2,\"status\":\"0\",\"updateBy\":\"admin\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-12-20 15:10:14',14),(121,'学期信息',2,'com.ruoyi.education.controller.EduTermController.edit()','PUT',1,'admin','教学管理中心','/education/term','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"createTime\":\"2025-12-18 15:46:15\",\"endDate\":\"2025-01-15\",\"isCurrent\":\"1\",\"params\":{},\"remark\":\"秋季学期\",\"startDate\":\"2024-09-01\",\"status\":\"0\",\"termId\":1,\"termName\":\"2024-2025学年第一学期\",\"updateBy\":\"\",\"updateTime\":\"2025-12-20 15:22:46\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-12-20 15:22:46',20),(122,'选课记录',3,'com.ruoyi.education.controller.EduStudentCourseController.remove()','DELETE',1,'admin','教学管理中心','/education/selection/4,3,2,1','127.0.0.1','内网IP','[4,3,2,1] ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-12-20 15:26:21',14),(123,'学生选课',1,'com.ruoyi.education.controller.EduStudentCourseController.enroll()','POST',1,'23121608','计算机科学系','/education/selection/enroll/31','127.0.0.1','内网IP','31 ','{\"msg\":\"选课成功\",\"code\":200}',0,NULL,'2025-12-20 15:29:42',52),(124,'学生选课',1,'com.ruoyi.education.controller.EduStudentCourseController.enroll()','POST',1,'23121608','计算机科学系','/education/selection/enroll/23','127.0.0.1','内网IP','23 ','{\"msg\":\"选课成功\",\"code\":200}',0,NULL,'2025-12-20 15:29:47',31),(125,'学生选课',1,'com.ruoyi.education.controller.EduStudentCourseController.enroll()','POST',1,'23121608','计算机科学系','/education/selection/enroll/22','127.0.0.1','内网IP','22 ','{\"msg\":\"选课成功\",\"code\":200}',0,NULL,'2025-12-20 15:29:48',31),(126,'选课记录',2,'com.ruoyi.education.controller.EduStudentCourseController.edit()','PUT',1,'teacher01','计算机学院','/education/selection','127.0.0.1','内网IP','{\"params\":{},\"scId\":10,\"score\":99,\"updateTime\":\"2025-12-20 15:30:58\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-12-20 15:30:58',15),(127,'学期信息',2,'com.ruoyi.education.controller.EduTermController.edit()','PUT',1,'admin','教学管理中心','/education/term','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"createTime\":\"2025-12-18 15:46:15\",\"endDate\":\"2025-07-05\",\"isCurrent\":\"1\",\"params\":{},\"remark\":\"春季学期（当前）\",\"startDate\":\"2025-02-17\",\"status\":\"0\",\"termId\":2,\"termName\":\"2024-2025学年第二学期\",\"updateBy\":\"\",\"updateTime\":\"2025-12-20 15:36:47\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-12-20 15:36:47',18),(128,'学期信息',2,'com.ruoyi.education.controller.EduTermController.edit()','PUT',1,'admin','教学管理中心','/education/term','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"createTime\":\"2025-12-20 15:24:40\",\"endDate\":\"2026-07-04\",\"isCurrent\":\"1\",\"params\":{},\"remark\":\"春季学期（待开放）\",\"startDate\":\"2026-02-16\",\"status\":\"0\",\"termId\":4,\"termName\":\"2025-2026学年第二学期\",\"updateBy\":\"\",\"updateTime\":\"2025-12-20 15:37:10\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-12-20 15:37:10',17),(129,'学生选课',1,'com.ruoyi.education.controller.EduStudentCourseController.enroll()','POST',1,'admin','教学管理中心','/education/selection/enroll/26','127.0.0.1','内网IP','26 ','{\"msg\":\"您不是学生用户，无法选课\",\"code\":500}',0,NULL,'2025-12-20 15:50:59',20),(130,'学期信息',2,'com.ruoyi.education.controller.EduTermController.edit()','PUT',1,'admin','教学管理中心','/education/term','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"createTime\":\"2025-12-20 15:24:40\",\"endDate\":\"2026-07-04\",\"isCurrent\":\"1\",\"params\":{},\"remark\":\"春季学期（待开放）\",\"startDate\":\"2026-02-16\",\"status\":\"0\",\"termId\":4,\"termName\":\"2025-2026学年第二学期\",\"updateBy\":\"\",\"updateTime\":\"2025-12-20 15:51:36\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-12-20 15:51:36',20),(131,'角色管理',2,'com.ruoyi.web.controller.system.SysRoleController.edit()','PUT',1,'admin','教学管理中心','/system/role','127.0.0.1','内网IP','{\"admin\":false,\"createTime\":\"2025-12-18 15:46:08\",\"dataScope\":\"3\",\"delFlag\":\"0\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"menuIds\":[100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,115,116,1055,1056,1057,1058,1059,1060,117,4000,4004,4041,4005,4051,4052,4053,4006,4061,4063],\"params\":{},\"remark\":\"教师角色，可以管理课程、查看选课情况\",\"roleId\":2,\"roleKey\":\"teacher\",\"roleName\":\"教师\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-12-20 16:04:18',57),(132,'选课记录',2,'com.ruoyi.education.controller.EduStudentCourseController.edit()','PUT',1,'admin','教学管理中心','/education/selection','127.0.0.1','内网IP','{\"params\":{},\"scId\":68,\"score\":80,\"updateTime\":\"2025-12-20 16:14:24\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-12-20 16:14:24',33),(133,'在线用户',7,'com.ruoyi.web.controller.monitor.SysUserOnlineController.forceLogout()','DELETE',1,'admin','教学管理中心','/monitor/online/30dbc776-30c9-4702-8fe6-868a6680a2c2','127.0.0.1','内网IP','\"30dbc776-30c9-4702-8fe6-868a6680a2c2\" ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-12-21 12:47:13',4),(134,'教师录入成绩',2,'com.ruoyi.education.controller.EduStudentCourseController.inputScore()','PUT',1,'teacher02','经济管理学院','/education/selection/inputScore','127.0.0.1','内网IP','{\"params\":{},\"scId\":43,\"score\":59} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-12-21 12:59:48',104),(135,'菜单管理',2,'com.ruoyi.web.controller.system.SysMenuController.edit()','PUT',1,'admin','教学管理中心','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"education/teacherCourse/index\",\"createTime\":\"2025-12-20 17:09:35\",\"icon\":\"cascader\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":4010,\"menuName\":\"我的课程\",\"menuType\":\"C\",\"orderNum\":10,\"params\":{},\"parentId\":4000,\"path\":\"teacherCourse\",\"perms\":\"education:teacherCourse:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-12-21 13:04:18',28),(136,'教师录入成绩',2,'com.ruoyi.education.controller.EduStudentCourseController.inputScore()','PUT',1,'teacher01','计算机学院','/education/selection/inputScore','127.0.0.1','内网IP','{\"examScore\":100,\"params\":{},\"scId\":48,\"usualScore\":34} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-12-21 13:43:06',24),(137,'批量录入成绩',2,'com.ruoyi.education.controller.EduStudentCourseController.batchInputScore()','PUT',1,'teacher01','计算机学院','/education/selection/batchInputScore','127.0.0.1','内网IP','[{\"examScore\":100,\"params\":{},\"scId\":42,\"usualScore\":34},{\"examScore\":54,\"params\":{},\"scId\":39,\"usualScore\":34},{\"examScore\":89,\"params\":{},\"scId\":36,\"usualScore\":99},{\"examScore\":79,\"params\":{},\"scId\":29,\"usualScore\":99},{\"examScore\":99,\"params\":{},\"scId\":26,\"usualScore\":80}] ','{\"msg\":\"成功录入 5 条成绩\",\"code\":200}',0,NULL,'2025-12-21 13:43:09',54),(138,'批量录入成绩',2,'com.ruoyi.education.controller.EduStudentCourseController.batchInputScore()','PUT',1,'teacher01','计算机学院','/education/selection/batchInputScore','127.0.0.1','内网IP','[{\"examScore\":8,\"params\":{},\"scId\":44,\"usualScore\":99}] ','{\"msg\":\"成功录入 1 条成绩\",\"code\":200}',0,NULL,'2025-12-21 14:02:33',23),(139,'学期信息',2,'com.ruoyi.education.controller.EduTermController.edit()','PUT',1,'admin','教学管理中心','/education/term','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"createTime\":\"2025-12-20 15:24:40\",\"endDate\":\"2026-07-04\",\"isCurrent\":\"1\",\"params\":{},\"remark\":\"春季学期（待开放）\",\"selectionEnd\":\"2026-02-28 23:59:59\",\"selectionStart\":\"2025-12-21 16:32:00\",\"startDate\":\"2026-02-16\",\"status\":\"0\",\"termId\":4,\"termName\":\"2025-2026学年第二学期\",\"updateBy\":\"\",\"updateTime\":\"2025-12-21 16:31:56\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-12-21 16:31:56',27),(140,'学生选课',1,'com.ruoyi.education.controller.EduStudentCourseController.enroll()','POST',1,'student01','计算机学院','/education/selection/enroll/38','127.0.0.1','内网IP','38 ','{\"msg\":\"选课成功\",\"code\":200}',0,NULL,'2025-12-21 16:50:24',44),(141,'学生选课',1,'com.ruoyi.education.controller.EduStudentCourseController.enroll()','POST',1,'student01','计算机学院','/education/selection/enroll/37','127.0.0.1','内网IP','37 ','{\"msg\":\"选课成功\",\"code\":200}',0,NULL,'2025-12-21 17:04:00',149),(142,'学生退课',3,'com.ruoyi.education.controller.EduStudentCourseController.withdraw()','DELETE',1,'student01','计算机学院','/education/selection/withdraw/37','127.0.0.1','内网IP','37 ','{\"msg\":\"退课成功\",\"code\":200}',0,NULL,'2025-12-21 17:04:11',26),(143,'学生选课',1,'com.ruoyi.education.controller.EduStudentCourseController.enroll()','POST',1,'student01','计算机学院','/education/selection/enroll/34','127.0.0.1','内网IP','34 ','{\"msg\":\"上课时间冲突：与【计算机网络】的上课时间（周一1-2节,周四5-6节）存在冲突\",\"code\":500}',0,NULL,'2025-12-21 17:04:13',28),(144,'学生选课',1,'com.ruoyi.education.controller.EduStudentCourseController.enroll()','POST',1,'student01','计算机学院','/education/selection/enroll/33','127.0.0.1','内网IP','33 ','{\"msg\":\"选课成功\",\"code\":200}',0,NULL,'2025-12-21 17:04:16',41),(145,'学期信息',2,'com.ruoyi.education.controller.EduTermController.edit()','PUT',1,'admin','教学管理中心','/education/term','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"createTime\":\"2025-12-20 15:24:40\",\"endDate\":\"2026-01-15\",\"isCurrent\":\"1\",\"params\":{},\"remark\":\"秋季学期（当前）\",\"selectionEnd\":\"2025-09-15 23:59:59\",\"selectionStart\":\"2025-08-20 08:00:00\",\"startDate\":\"2025-09-01\",\"status\":\"0\",\"termId\":3,\"termName\":\"2025-2026学年第一学期\",\"updateBy\":\"\",\"updateTime\":\"2025-12-21 17:37:44\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-12-21 17:37:44',40),(146,'学期信息',2,'com.ruoyi.education.controller.EduTermController.edit()','PUT',1,'admin','教学管理中心','/education/term','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"createTime\":\"2025-12-20 15:24:40\",\"endDate\":\"2026-07-04\",\"isCurrent\":\"1\",\"params\":{},\"remark\":\"春季学期（待开放）\",\"selectionEnd\":\"2025-12-31 23:59:59\",\"selectionStart\":\"2025-12-01 00:00:00\",\"startDate\":\"2026-02-16\",\"status\":\"0\",\"termId\":4,\"termName\":\"2025-2026学年第二学期\",\"updateBy\":\"\",\"updateTime\":\"2025-12-21 19:56:38\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-12-21 19:56:38',24),(147,'学期信息',2,'com.ruoyi.education.controller.EduTermController.edit()','PUT',1,'admin','教学管理中心','/education/term','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"createTime\":\"2025-12-20 15:24:40\",\"endDate\":\"2026-07-04\",\"isCurrent\":\"1\",\"params\":{},\"remark\":\"春季学期（待开放）\",\"selectionEnd\":\"2025-12-31 23:59:59\",\"selectionStart\":\"2025-12-01 00:00:00\",\"startDate\":\"2026-02-16\",\"status\":\"0\",\"termId\":4,\"termName\":\"2025-2026学年第二学期\",\"updateBy\":\"\",\"updateTime\":\"2025-12-21 19:57:32\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-12-21 19:57:32',19),(148,'教师录入成绩',2,'com.ruoyi.education.controller.EduStudentCourseController.inputScore()','PUT',1,'10000001','计算机工程与科学学院','/education/selection/inputScore','127.0.0.1','内网IP','{\"params\":{},\"scId\":105,\"score\":60} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-12-21 19:59:36',25),(149,'教师录入成绩',2,'com.ruoyi.education.controller.EduStudentCourseController.inputScore()','PUT',1,'10000001','计算机工程与科学学院','/education/selection/inputScore','127.0.0.1','内网IP','{\"params\":{},\"scId\":122,\"score\":100} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-12-21 19:59:50',17),(150,'教师录入成绩',2,'com.ruoyi.education.controller.EduStudentCourseController.inputScore()','PUT',1,'10000001','计算机工程与科学学院','/education/selection/inputScore','127.0.0.1','内网IP','{\"examScore\":96,\"params\":{},\"scId\":122,\"usualScore\":88} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-12-21 20:00:41',19),(151,'学生退课',3,'com.ruoyi.education.controller.EduStudentCourseController.withdraw()','DELETE',1,'23000003','计算机工程与科学学院','/education/selection/withdraw/38','127.0.0.1','内网IP','38 ','{\"msg\":\"退课成功\",\"code\":200}',0,NULL,'2025-12-21 20:02:11',30),(152,'学生退课',3,'com.ruoyi.education.controller.EduStudentCourseController.withdraw()','DELETE',1,'23000003','计算机工程与科学学院','/education/selection/withdraw/36','127.0.0.1','内网IP','36 ','{\"msg\":\"退课成功\",\"code\":200}',0,NULL,'2025-12-21 20:02:14',25),(153,'学期信息',2,'com.ruoyi.education.controller.EduTermController.edit()','PUT',1,'admin','教学管理中心','/education/term','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"createTime\":\"2025-12-20 15:24:40\",\"endDate\":\"2026-01-15\",\"isCurrent\":\"1\",\"params\":{},\"remark\":\"秋季学期（当前）\",\"selectionEnd\":\"2025-09-15 23:59:59\",\"selectionStart\":\"2025-08-20 08:00:00\",\"startDate\":\"2025-09-01\",\"status\":\"0\",\"termId\":3,\"termName\":\"2025-2026学年第一学期\",\"updateBy\":\"\",\"updateTime\":\"2025-12-21 20:03:17\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-12-21 20:03:17',22),(154,'学期信息',2,'com.ruoyi.education.controller.EduTermController.edit()','PUT',1,'admin','教学管理中心','/education/term','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"createTime\":\"2025-12-20 15:24:40\",\"endDate\":\"2026-01-15\",\"isCurrent\":\"1\",\"params\":{},\"remark\":\"秋季学期（当前）\",\"selectionEnd\":\"2025-12-25 23:59:59\",\"selectionStart\":\"2025-12-19 08:00:00\",\"startDate\":\"2025-09-01\",\"status\":\"0\",\"termId\":3,\"termName\":\"2025-2026学年第一学期\",\"updateBy\":\"\",\"updateTime\":\"2025-12-21 20:05:10\"} ','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-12-21 20:05:10',17),(155,'学生退课',3,'com.ruoyi.education.controller.EduStudentCourseController.withdraw()','DELETE',1,'23000003','计算机工程与科学学院','/education/selection/withdraw/35','127.0.0.1','内网IP','35 ','{\"msg\":\"退课成功\",\"code\":200}',0,NULL,'2025-12-21 20:05:43',24);
/*!40000 ALTER TABLE `sys_oper_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role`
--

DROP TABLE IF EXISTS `sys_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role` (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) COLLATE utf8mb4_general_ci DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) DEFAULT '1' COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) DEFAULT '1' COMMENT '部门树选择项是否关联显示',
  `status` char(1) COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='角色信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role`
--

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
INSERT INTO `sys_role` VALUES (1,'系统管理员','admin',1,'1',1,1,'0','0','admin','2025-12-18 15:46:08','',NULL,'系统管理员，拥有所有权限'),(2,'教师','teacher',2,'3',0,0,'0','0','admin','2025-12-18 15:46:08','admin','2025-12-20 16:04:18','教师角色，可以管理课程、查看选课情况'),(3,'学生','student',3,'2',1,1,'0','0','admin','2025-12-18 15:46:08','',NULL,'学生角色，可以选课、退课、查看成绩');
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_dept`
--

DROP TABLE IF EXISTS `sys_role_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role_dept` (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`,`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='角色和部门关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_dept`
--

LOCK TABLES `sys_role_dept` WRITE;
/*!40000 ALTER TABLE `sys_role_dept` DISABLE KEYS */;
INSERT INTO `sys_role_dept` VALUES (2,100),(2,101),(2,105);
/*!40000 ALTER TABLE `sys_role_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_menu`
--

DROP TABLE IF EXISTS `sys_role_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role_menu` (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='角色和菜单关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_menu`
--

LOCK TABLES `sys_role_menu` WRITE;
/*!40000 ALTER TABLE `sys_role_menu` DISABLE KEYS */;
INSERT INTO `sys_role_menu` VALUES (2,100),(2,101),(2,102),(2,103),(2,105),(2,106),(2,107),(2,108),(2,109),(2,110),(2,111),(2,112),(2,113),(2,114),(2,115),(2,116),(2,117),(2,500),(2,501),(2,1000),(2,1001),(2,1002),(2,1003),(2,1004),(2,1005),(2,1006),(2,1007),(2,1008),(2,1009),(2,1010),(2,1011),(2,1012),(2,1013),(2,1014),(2,1015),(2,1016),(2,1017),(2,1018),(2,1019),(2,1025),(2,1026),(2,1027),(2,1028),(2,1029),(2,1030),(2,1031),(2,1032),(2,1033),(2,1034),(2,1035),(2,1036),(2,1037),(2,1038),(2,1039),(2,1040),(2,1041),(2,1042),(2,1043),(2,1044),(2,1045),(2,1046),(2,1047),(2,1048),(2,1049),(2,1050),(2,1051),(2,1052),(2,1053),(2,1054),(2,1055),(2,1056),(2,1057),(2,1058),(2,1059),(2,1060),(2,4000),(2,4004),(2,4005),(2,4006),(2,4010),(2,4041),(2,4051),(2,4052),(2,4053),(2,4061),(2,4063),(2,4070),(2,4071),(2,4072),(2,4073),(2,4080),(2,4081),(2,4091),(3,4000),(3,4007),(3,4050),(3,4090),(3,4092),(3,4093);
/*!40000 ALTER TABLE `sys_role_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user` (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint DEFAULT NULL COMMENT '学院ID',
  `user_name` varchar(30) COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) COLLATE utf8mb4_general_ci DEFAULT '00' COMMENT '用户类型（00系统管理员 01教师 02学生）',
  `student_id` varchar(20) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '学号（学生）',
  `teacher_id` varchar(20) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '工号（教师）',
  `grade` varchar(10) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '年级（学生专用）',
  `major` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '专业（学生专用）',
  `email` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '手机号码',
  `sex` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '密码',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '账号状态（0正常 1停用）',
  `del_flag` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
  `pwd_update_date` datetime DEFAULT NULL COMMENT '密码最后更新时间',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=271 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES (1,100,'admin','系统管理员','00','','','','','admin@university.edu','15888888888','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','127.0.0.1','2025-12-21 20:04:35','2025-12-18 15:46:08','admin','2025-12-18 15:46:08','',NULL,'系统管理员'),(2,101,'10000001','张教授','01','','T20210001','','','teacher01@university.edu','15888888801','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','127.0.0.1','2025-12-21 19:58:31','2025-12-18 15:46:08','admin','2025-12-18 15:46:08','',NULL,'测试教师'),(3,101,'23000001','李明','02','2021001001','','2021','计算机科学与技术','student01@university.edu','15888888901','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','127.0.0.1','2025-12-21 17:30:39','2025-12-18 15:46:08','admin','2025-12-18 15:46:08','',NULL,'测试学生'),(100,101,'23000002','周宸宇','00','','','','','','','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','127.0.0.1','2025-12-20 15:29:30',NULL,'','2025-12-18 16:09:36','',NULL,NULL),(101,101,'23000003','刘思琪','00','','','','','','','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','127.0.0.1','2025-12-21 20:05:27',NULL,'','2025-12-18 17:07:48','',NULL,NULL),(102,101,'10000002','王建国','00','','','','','wangjianguo@university.edu.cn','13800138002','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','127.0.0.1','2025-12-21 12:50:27',NULL,'admin','2025-12-20 15:19:04','',NULL,'计算机学院教授'),(103,101,'10000003','李春华','00','','','','','lichunhua@university.edu.cn','13800138003','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','127.0.0.1','2025-12-21 17:33:40',NULL,'admin','2025-12-20 15:19:04','',NULL,'计算机学院副教授'),(104,105,'10000004','刘明远','00','','','','','liumingyuan@university.edu.cn','13800138004','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'admin','2025-12-20 15:19:04','',NULL,'数学学院教授'),(105,104,'10000005','陈晓燕','00','','','','','chenxiaoyan@university.edu.cn','13800138005','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'admin','2025-12-20 15:19:04','',NULL,'外语学院讲师'),(106,101,'23000004','张伟','00','','','','','zhangwei@stu.university.edu.cn','15900001001','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','127.0.0.1','2025-12-20 15:52:50',NULL,'admin','2025-12-20 15:19:04','',NULL,'计算机科学与技术专业'),(107,101,'23000005','王芳','00','','','','','wangfang@stu.university.edu.cn','15900001002','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'admin','2025-12-20 15:19:04','',NULL,'软件工程专业'),(108,101,'23000006','李强','00','','','','','liqiang@stu.university.edu.cn','15900001003','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'admin','2025-12-20 15:19:04','',NULL,'计算机科学与技术专业'),(109,101,'23000007','赵静','00','','','','','zhaojing@stu.university.edu.cn','15900001004','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'admin','2025-12-20 15:19:04','',NULL,'信息与计算科学专业'),(110,101,'23000008','刘洋','00','','','','','liuyang@stu.university.edu.cn','15900001005','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'admin','2025-12-20 15:19:04','',NULL,'软件工程专业'),(111,101,'23000009','陈明','00','','','','','chenming@stu.university.edu.cn','15900002001','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'admin','2025-12-20 15:19:04','',NULL,'计算机科学与技术专业'),(112,101,'23000010','杨雪','00','','','','','yangxue@stu.university.edu.cn','15900002002','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'admin','2025-12-20 15:19:04','',NULL,'软件工程专业'),(113,101,'23000011','周杰','00','','','','','zhoujie@stu.university.edu.cn','15900002003','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'admin','2025-12-20 15:19:04','',NULL,'数学与应用数学专业'),(114,101,'23000012','吴婷','00','','','','','wuting@stu.university.edu.cn','15900002004','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'admin','2025-12-20 15:19:04','',NULL,'计算机科学与技术专业'),(115,101,'23000013','孙磊','00','','','','','sunlei@stu.university.edu.cn','15900002005','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'admin','2025-12-20 15:19:04','',NULL,'软件工程专业'),(116,101,'10000006','张智远','00','','','','','zhangzy@shu.edu.cn','13800001001','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:11','',NULL,NULL),(117,101,'10000007','刘算法','00','','','','','liusf@shu.edu.cn','13800001002','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:11','',NULL,NULL),(118,101,'10000008','王数据','00','','','','','wangsj@shu.edu.cn','13800001003','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','127.0.0.1','2025-12-21 17:37:00',NULL,'','2025-12-21 17:11:11','',NULL,NULL),(119,101,'10000009','陈网络','00','','','','','chenwl@shu.edu.cn','13800001004','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:11','',NULL,NULL),(120,109,'10000010','赵机械','00','','','','','zhaojx@shu.edu.cn','13800002001','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:11','',NULL,NULL),(121,109,'10000011','钱自动','00','','','','','qianzd@shu.edu.cn','13800002002','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:11','',NULL,NULL),(122,109,'10000012','孙电气','00','','','','','sundq@shu.edu.cn','13800002003','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:11','',NULL,NULL),(123,105,'10000013','李高数','00','','','','','ligs@shu.edu.cn','13800003001','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:11','',NULL,NULL),(124,105,'10000014','周线代','00','','','','','zhouxd@shu.edu.cn','13800003002','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:11','',NULL,NULL),(125,105,'10000015','吴物理','00','','','','','wuwl@shu.edu.cn','13800003003','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:11','',NULL,NULL),(126,110,'10000016','郑信号','00','','','','','zhengxh@shu.edu.cn','13800004001','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:11','',NULL,NULL),(127,110,'10000017','杨通信','00','','','','','yangtx@shu.edu.cn','13800004002','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:11','',NULL,NULL),(128,111,'10000018','徐管理','00','','','','','xugl@shu.edu.cn','13800005001','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:11','',NULL,NULL),(129,111,'10000019','何财务','00','','','','','hecw@shu.edu.cn','13800005002','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:11','',NULL,NULL),(130,104,'10000020','黄英语','00','','','','','huangyy@shu.edu.cn','13800006001','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:11','',NULL,NULL),(131,104,'10000021','林日语','00','','','','','linry@shu.edu.cn','13800006002','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:11','',NULL,NULL),(132,103,'10000022','高经济','00','','','','','gaojj@shu.edu.cn','13800007001','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:11','',NULL,NULL),(133,103,'10000023','罗金融','00','','','','','luojr@shu.edu.cn','13800007002','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:11','',NULL,NULL),(200,101,'23000014','赵一鸣','00','','','','','21cs001@shu.edu.cn','13900000001','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:44','',NULL,NULL),(201,101,'23000015','钱二明','00','','','','','21cs002@shu.edu.cn','13900000002','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:44','',NULL,NULL),(202,101,'23000016','孙三丽','00','','','','','21cs003@shu.edu.cn','13900000003','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:44','',NULL,NULL),(203,101,'23000017','李四强','00','','','','','21cs004@shu.edu.cn','13900000004','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:44','',NULL,NULL),(204,101,'23000018','周五月','00','','','','','21cs005@shu.edu.cn','13900000005','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:44','',NULL,NULL),(205,101,'23000019','吴大伟','00','','','','','22cs001@shu.edu.cn','13900000006','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:44','',NULL,NULL),(206,101,'23000020','郑小红','00','','','','','22cs002@shu.edu.cn','13900000007','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:44','',NULL,NULL),(207,101,'23000021','王小明','00','','','','','22cs003@shu.edu.cn','13900000008','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:44','',NULL,NULL),(208,101,'23000022','冯晓燕','00','','','','','22cs004@shu.edu.cn','13900000009','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:44','',NULL,NULL),(209,101,'23000023','陈志豪','00','','','','','22cs005@shu.edu.cn','13900000010','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:44','',NULL,NULL),(210,101,'23000024','褚建华','00','','','','','21se001@shu.edu.cn','13900000011','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:44','',NULL,NULL),(211,101,'23000025','卫雅婷','00','','','','','21se002@shu.edu.cn','13900000012','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:44','',NULL,NULL),(212,101,'23000026','蒋文杰','00','','','','','21se003@shu.edu.cn','13900000013','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:44','',NULL,NULL),(213,101,'23000027','沈梦琪','00','','','','','21se004@shu.edu.cn','13900000014','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:44','',NULL,NULL),(214,101,'23000028','韩宇航','00','','','','','21se005@shu.edu.cn','13900000015','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:44','',NULL,NULL),(215,101,'23000029','杨光辉','00','','','','','22se001@shu.edu.cn','13900000016','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:44','',NULL,NULL),(216,101,'23000030','朱美玲','00','','','','','22se002@shu.edu.cn','13900000017','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:44','',NULL,NULL),(217,101,'23000031','秦浩然','00','','','','','22se003@shu.edu.cn','13900000018','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:44','',NULL,NULL),(218,101,'23000032','尤晓雪','00','','','','','22se004@shu.edu.cn','13900000019','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:44','',NULL,NULL),(219,101,'23000033','许志远','00','','','','','22se005@shu.edu.cn','13900000020','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:44','',NULL,NULL),(220,101,'23000034','何智能','00','','','','','22ai001@shu.edu.cn','13900000021','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:44','',NULL,NULL),(221,101,'23000035','吕算法','00','','','','','22ai002@shu.edu.cn','13900000022','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:44','',NULL,NULL),(222,101,'23000036','施学习','00','','','','','22ai003@shu.edu.cn','13900000023','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:44','',NULL,NULL),(223,101,'23000037','张深度','00','','','','','22ai004@shu.edu.cn','13900000024','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:44','',NULL,NULL),(224,101,'23000038','孔神经','00','','','','','22ai005@shu.edu.cn','13900000025','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:44','',NULL,NULL),(225,109,'23000039','曹机械','00','','','','','21me001@shu.edu.cn','13900000026','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:59','',NULL,NULL),(226,109,'23000040','严自动','00','','','','','21me002@shu.edu.cn','13900000027','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:59','',NULL,NULL),(227,109,'23000041','华电气','00','','','','','21me003@shu.edu.cn','13900000028','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:59','',NULL,NULL),(228,109,'23000042','金机器','00','','','','','22me001@shu.edu.cn','13900000029','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:59','',NULL,NULL),(229,109,'23000043','魏制造','00','','','','','22me002@shu.edu.cn','13900000030','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:59','',NULL,NULL),(230,109,'23000044','陶设计','00','','','','','22me003@shu.edu.cn','13900000031','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:59','',NULL,NULL),(231,105,'23000045','姜数学','00','','','','','21ms001@shu.edu.cn','13900000032','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:59','',NULL,NULL),(232,105,'23000046','戚物理','00','','','','','21ms002@shu.edu.cn','13900000033','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:59','',NULL,NULL),(233,105,'23000047','谢化学','00','','','','','21ms003@shu.edu.cn','13900000034','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:59','',NULL,NULL),(234,105,'23000048','邹统计','00','','','','','22ms001@shu.edu.cn','13900000035','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:59','',NULL,NULL),(235,105,'23000049','喻代数','00','','','','','22ms002@shu.edu.cn','13900000036','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:59','',NULL,NULL),(236,105,'23000050','柏分析','00','','','','','22ms003@shu.edu.cn','13900000037','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:59','',NULL,NULL),(237,110,'23000051','水信号','00','','','','','21ee001@shu.edu.cn','13900000038','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:59','',NULL,NULL),(238,110,'23000052','窦通信','00','','','','','21ee002@shu.edu.cn','13900000039','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:59','',NULL,NULL),(239,110,'23000053','章电子','00','','','','','22ee001@shu.edu.cn','13900000040','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:59','',NULL,NULL),(240,110,'23000054','云无线','00','','','','','22ee002@shu.edu.cn','13900000041','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:59','',NULL,NULL),(241,110,'23000055','苏网络','00','','','','','22ee003@shu.edu.cn','13900000042','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:59','',NULL,NULL),(242,111,'23000056','潘管理','00','','','','','21ma001@shu.edu.cn','13900000043','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:59','',NULL,NULL),(243,111,'23000057','葛会计','00','','','','','21ma002@shu.edu.cn','13900000044','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:59','',NULL,NULL),(244,111,'23000058','奚人资','00','','','','','21ma003@shu.edu.cn','13900000045','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:59','',NULL,NULL),(245,111,'23000059','范战略','00','','','','','22ma001@shu.edu.cn','13900000046','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:59','',NULL,NULL),(246,111,'23000060','彭财务','00','','','','','22ma002@shu.edu.cn','13900000047','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:59','',NULL,NULL),(247,111,'23000061','郎营销','00','','','','','22ma003@shu.edu.cn','13900000048','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:11:59','',NULL,NULL),(248,104,'23000062','鲁英语','00','','','','','21fl001@shu.edu.cn','13900000049','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:12:16','',NULL,NULL),(249,104,'23000063','韦日语','00','','','','','21fl002@shu.edu.cn','13900000050','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:12:16','',NULL,NULL),(250,104,'23000064','昌翻译','00','','','','','22fl001@shu.edu.cn','13900000051','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:12:16','',NULL,NULL),(251,104,'23000065','马口译','00','','','','','22fl002@shu.edu.cn','13900000052','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:12:16','',NULL,NULL),(252,104,'23000066','苗笔译','00','','','','','22fl003@shu.edu.cn','13900000053','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:12:16','',NULL,NULL),(253,103,'23000067','凤经济','00','','','','','21ec001@shu.edu.cn','13900000054','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:12:16','',NULL,NULL),(254,103,'23000068','花金融','00','','','','','21ec002@shu.edu.cn','13900000055','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:12:16','',NULL,NULL),(255,103,'23000069','方贸易','00','','','','','21ec003@shu.edu.cn','13900000056','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:12:16','',NULL,NULL),(256,103,'23000070','俞投资','00','','','','','22ec001@shu.edu.cn','13900000057','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:12:16','',NULL,NULL),(257,103,'23000071','任证券','00','','','','','22ec002@shu.edu.cn','13900000058','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:12:16','',NULL,NULL),(258,103,'23000072','袁银行','00','','','','','22ec003@shu.edu.cn','13900000059','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:12:16','',NULL,NULL),(259,112,'23000073','柳建筑','00','','','','','21ce001@shu.edu.cn','13900000060','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:12:16','',NULL,NULL),(260,112,'23000074','酆结构','00','','','','','21ce002@shu.edu.cn','13900000061','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:12:16','',NULL,NULL),(261,112,'23000075','鲍桥梁','00','','','','','22ce001@shu.edu.cn','13900000062','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:12:16','',NULL,NULL),(262,112,'23000076','史道路','00','','','','','22ce002@shu.edu.cn','13900000063','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:12:16','',NULL,NULL),(263,113,'23000077','唐材料','00','','','','','21mt001@shu.edu.cn','13900000064','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:12:16','',NULL,NULL),(264,113,'23000078','费高分','00','','','','','21mt002@shu.edu.cn','13900000065','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:12:16','',NULL,NULL),(265,113,'23000079','廉复合','00','','','','','22mt001@shu.edu.cn','13900000066','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:12:16','',NULL,NULL),(266,113,'23000080','岑金属','00','','','','','22mt002@shu.edu.cn','13900000067','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:12:16','',NULL,NULL),(267,114,'23000081','薛视觉','00','','','','','21art001@shu.edu.cn','13900000068','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:12:16','',NULL,NULL),(268,114,'23000082','雷环境','00','','','','','21art002@shu.edu.cn','13900000069','0','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:12:16','',NULL,NULL),(269,114,'23000083','贺设计','00','','','','','22art001@shu.edu.cn','13900000070','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:12:16','',NULL,NULL),(270,114,'23000084','倪艺术','00','','','','','22art002@shu.edu.cn','13900000071','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','',NULL,NULL,'','2025-12-21 17:12:16','',NULL,NULL);
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_post`
--

DROP TABLE IF EXISTS `sys_user_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user_post` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`,`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户与岗位关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_post`
--

LOCK TABLES `sys_user_post` WRITE;
/*!40000 ALTER TABLE `sys_user_post` DISABLE KEYS */;
INSERT INTO `sys_user_post` VALUES (1,1),(2,2);
/*!40000 ALTER TABLE `sys_user_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_role`
--

DROP TABLE IF EXISTS `sys_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user_role` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户和角色关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_role`
--

LOCK TABLES `sys_user_role` WRITE;
/*!40000 ALTER TABLE `sys_user_role` DISABLE KEYS */;
INSERT INTO `sys_user_role` VALUES (1,1),(2,2),(3,3),(100,3),(101,3),(102,2),(103,2),(104,2),(105,2),(106,3),(107,3),(108,3),(109,3),(110,3),(111,3),(112,3),(113,3),(114,3),(115,3),(116,2),(117,2),(118,2),(119,2),(120,2),(121,2),(122,2),(123,2),(124,2),(125,2),(126,2),(127,2),(128,2),(129,2),(130,2),(131,2),(132,2),(133,2),(200,3),(201,3),(202,3),(203,3),(204,3),(205,3),(206,3),(207,3),(208,3),(209,3),(210,3),(211,3),(212,3),(213,3),(214,3),(215,3),(216,3),(217,3),(218,3),(219,3),(220,3),(221,3),(222,3),(223,3),(224,3),(225,3),(226,3),(227,3),(228,3),(229,3),(230,3),(231,3),(232,3),(233,3),(234,3),(235,3),(236,3),(237,3),(238,3),(239,3),(240,3),(241,3),(242,3),(243,3),(244,3),(245,3),(246,3),(247,3),(248,3),(249,3),(250,3),(251,3),(252,3),(253,3),(254,3),(255,3),(256,3),(257,3),(258,3),(259,3),(260,3),(261,3),(262,3),(263,3),(264,3),(265,3),(266,3),(267,3),(268,3),(269,3),(270,3);
/*!40000 ALTER TABLE `sys_user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'course_selection'
--

--
-- Dumping routines for database 'course_selection'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-21 20:34:49
