/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50643
 Source Host           : localhost:3306
 Source Schema         : book_system

 Target Server Type    : MySQL
 Target Server Version : 50643
 File Encoding         : 65001

 Date: 12/12/2021 23:21:56
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_book
-- ----------------------------
DROP TABLE IF EXISTS `t_book`;
CREATE TABLE `t_book`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '书号',
  `category` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '别类',
  `bookname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '书名',
  `author` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '作者',
  `press` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '出版社',
  `state` tinyint(1) NOT NULL COMMENT '状态：1代表启用，0代表不启用',
  `describe` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '描述',
  `img` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片路径\r\n',
  `num` int(11) NULL DEFAULT 0 COMMENT '数量',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `bookname`(`bookname`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_book
-- ----------------------------
INSERT INTO `t_book` VALUES (1, '计算机', '计算机组成原理', '林钟宝', '人民邮电出版社', 1, '', NULL, 3);
INSERT INTO `t_book` VALUES (6, '计算机', '操作系统原理', 'lbw', '人民邮电出版社', 1, '', '', 2);
INSERT INTO `t_book` VALUES (7, '计算机', '思科网络技术学院教程', NULL, '人民邮电出版社', 1, NULL, NULL, 1);
INSERT INTO `t_book` VALUES (8, NULL, '计算机操作系统', '庞丽萍', '人民邮电出版社', 1, '庞丽萍，华中科技大学教授，博导，1967年毕业于北京邮电学院无线电专业。曾任国家教育部工科计算机基础课程教学指导委员会委员、中国计算机学会教育与培训专业委员会委员。主持的“操作系统原理”课程获2007年*精品课程,2013年获国家精品资源共享课程；获2004年度宝钢教育奖优秀教师奖；1995年获首届“孺子牛金球奖”（香港柏宁顿（中国）教育基金会颁发）。长期从事计算机操作系统、分布式计算机系统的研究和教学工作。主要研究方向为并行分布式系统。是“局域网上异构的分布式操作系统”、“基于UNIX的分布式操作系统”、“实时分布式UNIX操作系统实现技术”等预研及基金项目的负责人和研制者。并参加完成了211行动计划项目“集群超级网络服务器聚集技术”、973项目“下一代互联网信息存储的组织模式和核心技术研究”。编著了《操作系统原理》等11本教材，其中《计算机操作系统（第2版）》被评为国家十二五规划教材。', NULL, 0);

-- ----------------------------
-- Table structure for t_bookorder
-- ----------------------------
DROP TABLE IF EXISTS `t_bookorder`;
CREATE TABLE `t_bookorder`  (
  `id` bigint(20) NOT NULL COMMENT '单号',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `studentid` int(11) NOT NULL COMMENT '学号',
  `bookname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '书名',
  `bookid` bigint(11) NOT NULL COMMENT '书号',
  `create_tiem` datetime(0) NOT NULL COMMENT '借书时间',
  `return_tiem` datetime(0) NULL DEFAULT NULL COMMENT '还书时间',
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '状态',
  PRIMARY KEY (`id`, `username`, `studentid`, `bookname`, `bookid`) USING BTREE,
  INDEX `username`(`username`) USING BTREE,
  INDEX `studentid`(`studentid`) USING BTREE,
  INDEX `bookname`(`bookname`) USING BTREE,
  INDEX `bookid`(`bookid`) USING BTREE,
  CONSTRAINT `t_bookorder_ibfk_1` FOREIGN KEY (`username`) REFERENCES `t_user` (`username`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `t_bookorder_ibfk_2` FOREIGN KEY (`studentid`) REFERENCES `t_user` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `t_bookorder_ibfk_3` FOREIGN KEY (`bookname`) REFERENCES `t_book` (`bookname`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `t_bookorder_ibfk_4` FOREIGN KEY (`bookid`) REFERENCES `t_bookwarehouse` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_bookorder
-- ----------------------------
INSERT INTO `t_bookorder` VALUES (11639321121, '黄艺彤', 20210001, '计算机组成原理', 16391379873, '2021-12-12 22:58:41', '2021-12-12 23:10:49', '0');
INSERT INTO `t_bookorder` VALUES (21639319790, '黄艺彤', 20210001, '计算机组成原理', 16391379871, '2021-12-12 22:36:31', '2021-12-12 22:55:43', '0');
INSERT INTO `t_bookorder` VALUES (61639319909, '黄艺彤', 20210001, '计算机组成原理', 16391379872, '2021-12-12 22:38:30', '2021-12-12 23:10:52', '0');
INSERT INTO `t_bookorder` VALUES (71639321028, '黄艺彤', 20210001, '操作系统原理', 2021121206002, '2021-12-12 22:57:09', '2021-12-12 23:10:53', '0');
INSERT INTO `t_bookorder` VALUES (71639321100, '黄艺彤', 20210001, '计算机组成原理', 16391379873, '2021-12-12 22:58:21', '2021-12-12 23:10:53', '0');
INSERT INTO `t_bookorder` VALUES (81639321093, '黄艺彤', 20210001, '计算机组成原理', 16391379873, '2021-12-12 22:58:13', '2021-12-12 23:10:54', '0');
INSERT INTO `t_bookorder` VALUES (91639321801, '黄艺彤', 20210001, '计算机组成原理', 16391379873, '2021-12-12 23:10:02', '2021-12-12 23:10:54', '0');
INSERT INTO `t_bookorder` VALUES (101639321094, '黄艺彤', 20210001, '计算机组成原理', 16391379873, '2021-12-12 22:58:15', '2021-12-12 23:10:55', '0');
INSERT INTO `t_bookorder` VALUES (101639321129, '黄艺彤', 20210001, '计算机组成原理', 16391379873, '2021-12-12 22:58:49', '2021-12-12 23:10:55', '0');

-- ----------------------------
-- Table structure for t_bookwarehouse
-- ----------------------------
DROP TABLE IF EXISTS `t_bookwarehouse`;
CREATE TABLE `t_bookwarehouse`  (
  `id` bigint(11) NOT NULL COMMENT '编号',
  `bookname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '书名',
  `state` tinyint(1) NULL DEFAULT NULL COMMENT '状态，0未借出，1借出',
  `bookid` int(11) NOT NULL COMMENT '条形码',
  PRIMARY KEY (`id`, `bookname`, `bookid`) USING BTREE,
  INDEX `bookname`(`bookname`) USING BTREE,
  INDEX `bookid`(`bookid`) USING BTREE,
  INDEX `id`(`id`) USING BTREE,
  CONSTRAINT `t_bookwarehouse_ibfk_1` FOREIGN KEY (`bookname`) REFERENCES `t_book` (`bookname`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `t_bookwarehouse_ibfk_2` FOREIGN KEY (`bookid`) REFERENCES `t_book` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_bookwarehouse
-- ----------------------------
INSERT INTO `t_bookwarehouse` VALUES (16391379871, '计算机组成原理', 1, 1);
INSERT INTO `t_bookwarehouse` VALUES (16391379872, '计算机组成原理', 1, 1);
INSERT INTO `t_bookwarehouse` VALUES (16391379873, '计算机组成原理', 1, 1);
INSERT INTO `t_bookwarehouse` VALUES (2021121206001, '操作系统原理', 1, 6);
INSERT INTO `t_bookwarehouse` VALUES (2021121206002, '操作系统原理', 1, 6);
INSERT INTO `t_bookwarehouse` VALUES (2021121207001, '思科网络技术学院教程', 1, 7);

-- ----------------------------
-- Table structure for t_category
-- ----------------------------
DROP TABLE IF EXISTS `t_category`;
CREATE TABLE `t_category`  (
  `id` int(11) NOT NULL,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user`  (
  `id` int(11) NOT NULL COMMENT '学号',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '姓名',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `role` tinyint(1) NOT NULL COMMENT '角色：1时为学生，0时为管理员',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES (20210001, '黄艺彤', '5487c17bc92a0713270a9559d9858071', 1);
INSERT INTO `t_user` VALUES (20210003, '林钟宝', '5487c17bc92a0713270a9559d9858071', 0);
INSERT INTO `t_user` VALUES (20210004, '苏键东', 'ca59bb70e76ae2d10605cdadd037e0c7', 0);
INSERT INTO `t_user` VALUES (20210005, '刘琪琪', '5487c17bc92a0713270a9559d9858071', 1);
INSERT INTO `t_user` VALUES (20210007, '庄舜娜', '5487c17bc92a0713270a9559d9858071', 1);
INSERT INTO `t_user` VALUES (202010006, '宋沛荣', 'ca59bb70e76ae2d10605cdadd037e0c7', 1);

-- ----------------------------
-- Triggers structure for table t_bookwarehouse
-- ----------------------------
DROP TRIGGER IF EXISTS `update-booknum`;
delimiter ;;
CREATE TRIGGER `update-booknum` AFTER UPDATE ON `t_bookwarehouse` FOR EACH ROW begin
 UPDATE `book_system`.`t_book` SET `num` = (
  SELECT COUNT(*) FROM `book_system`.`t_bookwarehouse` WHERE `bookid`= new.bookid AND `state`=1 GROUP BY `state`
 ) 
 WHERE `id` = new.bookid;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
