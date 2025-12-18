/*
 Navicat Premium Data Transfer

 Source Server         : better
 Source Server Type    : MySQL
 Source Server Version : 80019
 Source Host           : localhost:3306
 Source Schema         : hrsys1

 Target Server Type    : MySQL
 Target Server Version : 80019
 File Encoding         : 65001

 Date: 18/12/2025 15:33:27
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `number` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES (1, '开发部', 101);
INSERT INTO `department` VALUES (2, '测试部', 102);
INSERT INTO `department` VALUES (3, '产品部', 103);
INSERT INTO `department` VALUES (4, '设计部', 104);
INSERT INTO `department` VALUES (8, '123', 2222222);
INSERT INTO `department` VALUES (9, '阿萨德', 1);
INSERT INTO `department` VALUES (12, '市场部', 111);
INSERT INTO `department` VALUES (13, '测试用部门', 2147483647);

-- ----------------------------
-- Table structure for employee
-- ----------------------------
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `number` int(0) NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `gender` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `age` int(0) NULL DEFAULT NULL,
  `dep_id` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 505 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of employee
-- ----------------------------
INSERT INTO `employee` VALUES (84, 10001, '王悦', '女', 23, 3);
INSERT INTO `employee` VALUES (86, 10002, '张婕', '女', 12, 2);
INSERT INTO `employee` VALUES (94, 10003, '王聪', '男', 23, 2);
INSERT INTO `employee` VALUES (95, 10004, '刘海', '男', 25, NULL);
INSERT INTO `employee` VALUES (96, 10005, '李越', '男', 26, 3);
INSERT INTO `employee` VALUES (103, 10008, '周云', '男', 26, 2);
INSERT INTO `employee` VALUES (108, 12, '12', '男', 12, 4);
INSERT INTO `employee` VALUES (117, 32, '32', '男', 12, 4);
INSERT INTO `employee` VALUES (121, 10001, '徐明', '男', 59, 4);
INSERT INTO `employee` VALUES (122, 10002, '薛霞霞', '男', 40, 3);
INSERT INTO `employee` VALUES (123, 10003, '张娜强', '女', 26, 4);
INSERT INTO `employee` VALUES (124, 10004, '丁明霞', '女', 52, 9);
INSERT INTO `employee` VALUES (125, 10005, '刘秀英艳', '女', 57, NULL);
INSERT INTO `employee` VALUES (126, 10006, '林娟军', '女', 37, NULL);
INSERT INTO `employee` VALUES (127, 10007, '曾艳秀英', '女', 50, 8);
INSERT INTO `employee` VALUES (128, 10008, '吴秀兰娜', '男', 47, 3);
INSERT INTO `employee` VALUES (129, 10009, '彭洋', '女', 44, 5);
INSERT INTO `employee` VALUES (130, 10010, '杨杰', '男', 33, NULL);
INSERT INTO `employee` VALUES (131, 10011, '薛霞', '女', 20, 5);
INSERT INTO `employee` VALUES (132, 10012, '蒋娜', '男', 38, 9);
INSERT INTO `employee` VALUES (133, 10013, '陈娟', '女', 57, 3);
INSERT INTO `employee` VALUES (134, 10014, '萧磊', '男', 28, 5);
INSERT INTO `employee` VALUES (135, 10015, '谢洋', '男', 48, NULL);
INSERT INTO `employee` VALUES (136, 10016, '苏静军', '男', 24, 5);
INSERT INTO `employee` VALUES (137, 10017, '苏秀兰', '男', 57, 2);
INSERT INTO `employee` VALUES (138, 10018, '韩勇', '男', 26, 2);
INSERT INTO `employee` VALUES (139, 10019, '傅超', '男', 24, 5);
INSERT INTO `employee` VALUES (140, 10020, '黄霞', '女', 34, 4);
INSERT INTO `employee` VALUES (141, 10021, '郭敏', '男', 52, NULL);
INSERT INTO `employee` VALUES (142, 10022, '萧丽伟', '男', 27, NULL);
INSERT INTO `employee` VALUES (143, 10023, '胡磊', '女', 39, 2);
INSERT INTO `employee` VALUES (144, 10024, '于杰杰', '女', 60, 9);
INSERT INTO `employee` VALUES (145, 10025, '徐霞', '女', 30, NULL);
INSERT INTO `employee` VALUES (146, 10026, '萧勇', '女', 43, 8);
INSERT INTO `employee` VALUES (147, 10027, '沈芳', '女', 34, NULL);
INSERT INTO `employee` VALUES (148, 10028, '许芳', '女', 26, NULL);
INSERT INTO `employee` VALUES (149, 10029, '曾敏洋', '女', 20, 9);
INSERT INTO `employee` VALUES (150, 10030, '韩丽', '女', 58, 8);
INSERT INTO `employee` VALUES (151, 10031, '董伟', '女', 48, 9);
INSERT INTO `employee` VALUES (152, 10032, '何勇敏', '男', 56, NULL);
INSERT INTO `employee` VALUES (153, 10033, '许明', '女', 38, 9);
INSERT INTO `employee` VALUES (154, 10034, '刘超', '男', 53, 9);
INSERT INTO `employee` VALUES (155, 10035, '傅敏', '女', 22, 5);
INSERT INTO `employee` VALUES (156, 10036, '黄秀兰', '男', 51, 8);
INSERT INTO `employee` VALUES (157, 10037, '梁秀英军', '男', 26, 8);
INSERT INTO `employee` VALUES (158, 10038, '唐丽', '女', 26, NULL);
INSERT INTO `employee` VALUES (159, 10039, '蒋秀英', '女', 40, 9);
INSERT INTO `employee` VALUES (160, 10040, '邓伟', '女', 46, 4);
INSERT INTO `employee` VALUES (161, 10041, '徐勇', '女', 35, NULL);
INSERT INTO `employee` VALUES (162, 10042, '王静', '女', 50, NULL);
INSERT INTO `employee` VALUES (163, 10043, '吴明', '女', 43, 4);
INSERT INTO `employee` VALUES (164, 10044, '郭强涛', '女', 24, NULL);
INSERT INTO `employee` VALUES (165, 10045, '叶军', '男', 36, NULL);
INSERT INTO `employee` VALUES (166, 10046, '吕娜', '女', 47, NULL);
INSERT INTO `employee` VALUES (167, 10047, '吕超秀兰', '男', 55, 9);
INSERT INTO `employee` VALUES (168, 10048, '薛磊', '男', 40, 2);
INSERT INTO `employee` VALUES (169, 10049, '蒋芳霞', '女', 55, 5);
INSERT INTO `employee` VALUES (170, 10050, '高芳磊', '女', 23, 9);
INSERT INTO `employee` VALUES (171, 10051, '陈强秀英', '男', 54, NULL);
INSERT INTO `employee` VALUES (172, 10052, '傅娟', '男', 36, 2);
INSERT INTO `employee` VALUES (173, 10053, '彭敏娜', '女', 50, 5);
INSERT INTO `employee` VALUES (174, 10054, '郭明', '男', 42, 9);
INSERT INTO `employee` VALUES (175, 10055, '刘丽', '女', 33, 5);
INSERT INTO `employee` VALUES (176, 10056, '薛洋磊', '男', 20, 8);
INSERT INTO `employee` VALUES (177, 10057, '马娜', '女', 57, 4);
INSERT INTO `employee` VALUES (178, 10058, '蒋伟', '女', 36, 9);
INSERT INTO `employee` VALUES (179, 10059, '刘静', '女', 51, 2);
INSERT INTO `employee` VALUES (180, 10060, '蒋娟', '女', 38, 3);
INSERT INTO `employee` VALUES (181, 10061, '蔡艳', '女', 24, 9);
INSERT INTO `employee` VALUES (182, 10062, '于磊', '女', 28, 3);
INSERT INTO `employee` VALUES (183, 10063, '周超芳', '女', 60, 3);
INSERT INTO `employee` VALUES (184, 10064, '胡伟', '男', 53, 4);
INSERT INTO `employee` VALUES (185, 10065, '谢磊艳', '男', 33, 3);
INSERT INTO `employee` VALUES (186, 10066, '袁勇杰', '男', 53, 8);
INSERT INTO `employee` VALUES (187, 10067, '陈勇', '男', 23, NULL);
INSERT INTO `employee` VALUES (188, 10068, '蔡涛', '男', 52, 9);
INSERT INTO `employee` VALUES (189, 10069, '蒋娜', '男', 58, NULL);
INSERT INTO `employee` VALUES (190, 10070, '阎静', '男', 34, 5);
INSERT INTO `employee` VALUES (191, 10071, '程娜霞', '女', 40, 9);
INSERT INTO `employee` VALUES (192, 10072, '郭强娜', '女', 25, 3);
INSERT INTO `employee` VALUES (193, 10073, '袁娜军', '男', 36, 4);
INSERT INTO `employee` VALUES (194, 10074, '董强', '女', 42, 2);
INSERT INTO `employee` VALUES (195, 10075, '冯超强', '女', 59, NULL);
INSERT INTO `employee` VALUES (196, 10076, '曹秀兰静', '男', 36, 3);
INSERT INTO `employee` VALUES (197, 10077, '魏军伟', '男', 47, 3);
INSERT INTO `employee` VALUES (198, 10078, '程霞', '女', 22, 2);
INSERT INTO `employee` VALUES (199, 10079, '贾娜强', '女', 27, 5);
INSERT INTO `employee` VALUES (200, 10080, '傅秀兰', '男', 39, 2);
INSERT INTO `employee` VALUES (201, 10081, '梁娟丽', '女', 54, NULL);
INSERT INTO `employee` VALUES (202, 10082, '许明', '男', 44, 3);
INSERT INTO `employee` VALUES (203, 10083, '谢涛', '女', 24, NULL);
INSERT INTO `employee` VALUES (204, 10084, '周静伟', '女', 42, 8);
INSERT INTO `employee` VALUES (205, 10085, '苏杰', '女', 44, 5);
INSERT INTO `employee` VALUES (206, 10086, '吕磊敏', '男', 26, 9);
INSERT INTO `employee` VALUES (207, 10087, '张芳', '男', 36, 2);
INSERT INTO `employee` VALUES (208, 10088, '何伟', '男', 37, NULL);
INSERT INTO `employee` VALUES (209, 10089, '马伟秀兰', '男', 20, 8);
INSERT INTO `employee` VALUES (210, 10090, '刘芳', '男', 27, 3);
INSERT INTO `employee` VALUES (211, 10091, '萧艳', '男', 53, 3);
INSERT INTO `employee` VALUES (212, 10092, '贾明', '女', 55, 4);
INSERT INTO `employee` VALUES (213, 10093, '周磊艳', '女', 40, NULL);
INSERT INTO `employee` VALUES (214, 10094, '罗涛勇', '女', 36, 3);
INSERT INTO `employee` VALUES (215, 10095, '贾伟', '男', 55, NULL);
INSERT INTO `employee` VALUES (216, 10096, '邓秀兰勇', '男', 59, NULL);
INSERT INTO `employee` VALUES (217, 10097, '冯娜', '男', 54, 8);
INSERT INTO `employee` VALUES (218, 10098, '魏敏', '女', 50, 3);
INSERT INTO `employee` VALUES (219, 10099, '蒋军秀英', '男', 35, NULL);
INSERT INTO `employee` VALUES (220, 10100, '孙洋娟', '女', 34, NULL);
INSERT INTO `employee` VALUES (248, 10001, '何杰', '女', 58, 8);
INSERT INTO `employee` VALUES (249, 10002, '谢洋', '女', 28, 4);
INSERT INTO `employee` VALUES (250, 10003, '蒋杰芳', '男', 55, 9);
INSERT INTO `employee` VALUES (251, 10004, '沈娜', '男', 53, 9);
INSERT INTO `employee` VALUES (252, 10005, '胡静超', '男', 30, 4);
INSERT INTO `employee` VALUES (253, 10006, '冯丽明', '女', 30, 8);
INSERT INTO `employee` VALUES (254, 10007, '于磊磊', '男', 28, 2);
INSERT INTO `employee` VALUES (255, 10008, '徐艳杰', '男', 49, 5);
INSERT INTO `employee` VALUES (256, 10009, '冯磊磊', '女', 52, NULL);
INSERT INTO `employee` VALUES (257, 10010, '黄秀英', '男', 48, 9);
INSERT INTO `employee` VALUES (258, 10011, '董艳', '女', 43, 3);
INSERT INTO `employee` VALUES (259, 10012, '张丽', '女', 30, 4);
INSERT INTO `employee` VALUES (260, 10013, '董丽伟', '男', 41, NULL);
INSERT INTO `employee` VALUES (261, 10014, '苏静', '女', 34, 3);
INSERT INTO `employee` VALUES (262, 10015, '郑杰', '女', 40, 9);
INSERT INTO `employee` VALUES (263, 10016, '唐静娜', '女', 56, 4);
INSERT INTO `employee` VALUES (264, 10017, '曹静超', '男', 29, 9);
INSERT INTO `employee` VALUES (265, 10018, '高涛杰', '女', 47, NULL);
INSERT INTO `employee` VALUES (266, 10019, '刘伟', '男', 36, 5);
INSERT INTO `employee` VALUES (267, 10020, '魏强', '女', 35, 8);
INSERT INTO `employee` VALUES (268, 10021, '梁伟娜', '女', 23, 8);
INSERT INTO `employee` VALUES (269, 10022, '何杰', '男', 22, 3);
INSERT INTO `employee` VALUES (270, 10023, '王洋伟', '男', 30, 9);
INSERT INTO `employee` VALUES (271, 10024, '吴强', '女', 60, 2);
INSERT INTO `employee` VALUES (272, 10025, '傅霞芳', '男', 25, 2);
INSERT INTO `employee` VALUES (273, 10026, '许涛秀兰', '女', 54, NULL);
INSERT INTO `employee` VALUES (274, 10027, '刘艳丽', '女', 41, 4);
INSERT INTO `employee` VALUES (275, 10028, '袁磊', '女', 36, 2);
INSERT INTO `employee` VALUES (276, 10029, '赵娜', '男', 22, NULL);
INSERT INTO `employee` VALUES (277, 10030, '程磊', '女', 34, NULL);
INSERT INTO `employee` VALUES (278, 10031, '郭秀兰磊', '女', 20, 2);
INSERT INTO `employee` VALUES (279, 10032, '冯芳军', '女', 43, 5);
INSERT INTO `employee` VALUES (280, 10033, '徐娜', '女', 55, NULL);
INSERT INTO `employee` VALUES (281, 10034, '邓敏', '男', 23, 2);
INSERT INTO `employee` VALUES (282, 10035, '孙霞', '男', 36, 8);
INSERT INTO `employee` VALUES (283, 10036, '林娟伟', '女', 30, 5);
INSERT INTO `employee` VALUES (284, 10037, '何明', '女', 31, NULL);
INSERT INTO `employee` VALUES (285, 10038, '陈军', '男', 57, 2);
INSERT INTO `employee` VALUES (286, 10039, '朱军超', '女', 36, 8);
INSERT INTO `employee` VALUES (287, 10040, '蔡秀兰', '女', 27, 2);
INSERT INTO `employee` VALUES (288, 10041, '程伟', '女', 23, 2);
INSERT INTO `employee` VALUES (289, 10042, '刘芳', '女', 23, 8);
INSERT INTO `employee` VALUES (290, 10043, '林涛', '男', 36, 3);
INSERT INTO `employee` VALUES (291, 10044, '袁秀兰伟', '女', 28, NULL);
INSERT INTO `employee` VALUES (292, 10045, '苏超杰', '男', 31, 2);
INSERT INTO `employee` VALUES (293, 10046, '林艳', '男', 47, 2);
INSERT INTO `employee` VALUES (294, 10047, '唐娟', '男', 37, 9);
INSERT INTO `employee` VALUES (295, 10048, '赵丽', '男', 30, 8);
INSERT INTO `employee` VALUES (296, 10049, '马丽敏', '女', 30, 3);
INSERT INTO `employee` VALUES (297, 10050, '冯强', '女', 40, 9);
INSERT INTO `employee` VALUES (298, 10051, '罗勇明', '男', 20, 2);
INSERT INTO `employee` VALUES (299, 10052, '刘伟磊', '女', 57, 5);
INSERT INTO `employee` VALUES (300, 10053, '孙强', '男', 49, 3);
INSERT INTO `employee` VALUES (301, 10054, '叶丽娟', '女', 57, 5);
INSERT INTO `employee` VALUES (302, 10055, '薛娟敏', '女', 41, 4);
INSERT INTO `employee` VALUES (303, 10056, '许秀英伟', '女', 21, 4);
INSERT INTO `employee` VALUES (304, 10057, '杨娟', '女', 41, 5);
INSERT INTO `employee` VALUES (305, 10058, '曹军', '男', 58, 9);
INSERT INTO `employee` VALUES (306, 10059, '郭磊', '女', 41, NULL);
INSERT INTO `employee` VALUES (307, 10060, '李明', '男', 42, 3);
INSERT INTO `employee` VALUES (308, 10061, '张伟', '女', 28, 4);
INSERT INTO `employee` VALUES (309, 10062, '谢超', '女', 29, 2);
INSERT INTO `employee` VALUES (310, 10063, '曾静', '男', 50, 8);
INSERT INTO `employee` VALUES (311, 10064, '魏超伟', '男', 22, NULL);
INSERT INTO `employee` VALUES (312, 10065, '何秀兰娟', '男', 43, 4);
INSERT INTO `employee` VALUES (313, 10066, '马丽秀兰', '男', 35, 2);
INSERT INTO `employee` VALUES (314, 10067, '陈秀英涛', '男', 36, 8);
INSERT INTO `employee` VALUES (315, 10068, '宋娟', '女', 60, 9);
INSERT INTO `employee` VALUES (316, 10069, '许洋', '男', 47, NULL);
INSERT INTO `employee` VALUES (317, 10070, '叶杰杰', '男', 55, 2);
INSERT INTO `employee` VALUES (318, 10071, '黄秀英', '男', 57, NULL);
INSERT INTO `employee` VALUES (319, 10072, '董洋静', '女', 43, 4);
INSERT INTO `employee` VALUES (320, 10073, '何丽秀英', '男', 36, NULL);
INSERT INTO `employee` VALUES (321, 10074, '阎芳', '男', 35, 9);
INSERT INTO `employee` VALUES (322, 10075, '程霞', '女', 56, 5);
INSERT INTO `employee` VALUES (323, 10076, '郭丽明', '男', 24, 8);
INSERT INTO `employee` VALUES (324, 10077, '卢秀英', '女', 57, NULL);
INSERT INTO `employee` VALUES (325, 10078, '贾伟', '女', 33, NULL);
INSERT INTO `employee` VALUES (326, 10079, '张杰', '女', 60, 3);
INSERT INTO `employee` VALUES (327, 10080, '林明', '女', 24, 2);
INSERT INTO `employee` VALUES (328, 10081, '周勇', '女', 21, NULL);
INSERT INTO `employee` VALUES (329, 10082, '薛艳', '女', 35, NULL);
INSERT INTO `employee` VALUES (330, 10083, '朱娟静', '女', 29, 4);
INSERT INTO `employee` VALUES (331, 10084, '林伟', '女', 40, 5);
INSERT INTO `employee` VALUES (332, 10085, '徐艳霞', '女', 53, 9);
INSERT INTO `employee` VALUES (333, 10086, '林秀英', '女', 34, 4);
INSERT INTO `employee` VALUES (334, 10087, '萧强', '男', 56, 2);
INSERT INTO `employee` VALUES (335, 10088, '郭娟明', '女', 30, 3);
INSERT INTO `employee` VALUES (336, 10089, '张磊秀英', '女', 23, 5);
INSERT INTO `employee` VALUES (337, 10090, '于洋', '女', 37, 8);
INSERT INTO `employee` VALUES (338, 10091, '董丽洋', '女', 42, 9);
INSERT INTO `employee` VALUES (339, 10092, '王秀兰丽', '男', 58, NULL);
INSERT INTO `employee` VALUES (340, 10093, '董磊', '女', 20, 4);
INSERT INTO `employee` VALUES (341, 10094, '宋敏超', '男', 36, 3);
INSERT INTO `employee` VALUES (342, 10095, '薛芳洋', '男', 28, 5);
INSERT INTO `employee` VALUES (343, 10096, '曹勇伟', '女', 28, NULL);
INSERT INTO `employee` VALUES (344, 10097, '蒋敏', '男', 26, 2);
INSERT INTO `employee` VALUES (345, 10098, '薛磊', '男', 21, 4);
INSERT INTO `employee` VALUES (346, 10099, '冯秀英', '男', 48, 5);
INSERT INTO `employee` VALUES (347, 10100, '王洋勇', '女', 41, 8);
INSERT INTO `employee` VALUES (375, 10001, '郭丽涛', '女', 55, 3);
INSERT INTO `employee` VALUES (376, 10002, '冯明静', '男', 23, 13);
INSERT INTO `employee` VALUES (377, 10003, '杨娜', '男', 23, 5);
INSERT INTO `employee` VALUES (378, 10004, '蒋勇', '男', 54, NULL);
INSERT INTO `employee` VALUES (379, 10005, '唐娜', '女', 28, 2);
INSERT INTO `employee` VALUES (380, 10006, '宋娜', '男', 41, 3);
INSERT INTO `employee` VALUES (381, 10007, '蒋艳静', '男', 49, NULL);
INSERT INTO `employee` VALUES (382, 10008, '苏磊秀兰', '男', 57, 2);
INSERT INTO `employee` VALUES (383, 10009, '蒋霞', '女', 36, 3);
INSERT INTO `employee` VALUES (384, 10010, '蒋秀英', '女', 60, 9);
INSERT INTO `employee` VALUES (385, 10011, '李涛秀英', '男', 53, NULL);
INSERT INTO `employee` VALUES (386, 10012, '宋芳', '男', 27, 9);
INSERT INTO `employee` VALUES (387, 10013, '蒋秀英', '男', 57, NULL);
INSERT INTO `employee` VALUES (388, 10014, '董秀英', '男', 44, NULL);
INSERT INTO `employee` VALUES (389, 10015, '魏洋勇', '女', 35, 2);
INSERT INTO `employee` VALUES (390, 10016, '邓芳', '男', 54, 8);
INSERT INTO `employee` VALUES (391, 10017, '阎杰', '女', 55, 9);
INSERT INTO `employee` VALUES (392, 10018, '曾丽', '男', 44, 5);
INSERT INTO `employee` VALUES (393, 10019, '马磊', '男', 33, 9);
INSERT INTO `employee` VALUES (394, 10020, '黄洋', '男', 42, 8);
INSERT INTO `employee` VALUES (395, 10021, '蒋军磊', '男', 31, 4);
INSERT INTO `employee` VALUES (396, 10022, '蔡艳', '男', 40, 2);
INSERT INTO `employee` VALUES (397, 10023, '张军', '男', 44, 4);
INSERT INTO `employee` VALUES (398, 10024, '许强明', '男', 32, NULL);
INSERT INTO `employee` VALUES (399, 10025, '高杰艳', '女', 36, 2);
INSERT INTO `employee` VALUES (400, 10026, '马芳', '女', 33, 9);
INSERT INTO `employee` VALUES (401, 10027, '陈芳', '女', 42, NULL);
INSERT INTO `employee` VALUES (402, 10028, '萧洋芳', '男', 43, NULL);
INSERT INTO `employee` VALUES (403, 10029, '袁芳', '男', 59, NULL);
INSERT INTO `employee` VALUES (404, 10030, '彭娟', '男', 25, 8);
INSERT INTO `employee` VALUES (405, 10031, '李洋芳', '男', 23, 8);
INSERT INTO `employee` VALUES (406, 10032, '张涛静', '女', 34, NULL);
INSERT INTO `employee` VALUES (407, 10033, '梁磊洋', '男', 56, 2);
INSERT INTO `employee` VALUES (408, 10034, '贾强', '女', 58, 4);
INSERT INTO `employee` VALUES (409, 10035, '胡艳', '女', 21, 4);
INSERT INTO `employee` VALUES (410, 10036, '吴霞', '女', 47, 9);
INSERT INTO `employee` VALUES (411, 10037, '陈强丽', '男', 24, NULL);
INSERT INTO `employee` VALUES (412, 10038, '谢洋', '女', 48, 9);
INSERT INTO `employee` VALUES (413, 10039, '魏磊', '男', 44, 8);
INSERT INTO `employee` VALUES (414, 10040, '马磊磊', '女', 32, 8);
INSERT INTO `employee` VALUES (415, 10041, '卢军军', '男', 44, NULL);
INSERT INTO `employee` VALUES (416, 10042, '吕静', '男', 33, NULL);
INSERT INTO `employee` VALUES (417, 10043, '彭明霞', '女', 32, 8);
INSERT INTO `employee` VALUES (418, 10044, '程强涛', '男', 38, NULL);
INSERT INTO `employee` VALUES (419, 10045, '冯艳', '男', 29, 4);
INSERT INTO `employee` VALUES (420, 10046, '梁艳明', '女', 21, 2);
INSERT INTO `employee` VALUES (421, 10047, '陈杰', '男', 22, 4);
INSERT INTO `employee` VALUES (422, 10048, '苏敏娜', '女', 27, 4);
INSERT INTO `employee` VALUES (423, 10049, '蒋杰涛', '男', 41, 3);
INSERT INTO `employee` VALUES (424, 10050, '叶艳', '女', 43, NULL);
INSERT INTO `employee` VALUES (425, 10051, '宋涛杰', '男', 46, 2);
INSERT INTO `employee` VALUES (426, 10052, '叶伟', '女', 35, 2);
INSERT INTO `employee` VALUES (427, 10053, '吴芳艳', '男', 27, 2);
INSERT INTO `employee` VALUES (428, 10054, '冯静涛', '男', 43, 9);
INSERT INTO `employee` VALUES (429, 10055, '李磊强', '女', 44, 9);
INSERT INTO `employee` VALUES (430, 10056, '林洋超', '女', 22, 8);
INSERT INTO `employee` VALUES (431, 10057, '董勇', '女', 28, 9);
INSERT INTO `employee` VALUES (432, 10058, '吴霞', '女', 53, 5);
INSERT INTO `employee` VALUES (433, 10059, '程丽军', '男', 40, 9);
INSERT INTO `employee` VALUES (434, 10060, '曾丽', '男', 60, 9);
INSERT INTO `employee` VALUES (435, 10061, '郭静', '女', 44, NULL);
INSERT INTO `employee` VALUES (436, 10062, '唐超伟', '女', 30, NULL);
INSERT INTO `employee` VALUES (437, 10063, '孙静强', '男', 39, 3);
INSERT INTO `employee` VALUES (438, 10064, '王丽军', '女', 40, NULL);
INSERT INTO `employee` VALUES (439, 10065, '孙秀英', '男', 47, 8);
INSERT INTO `employee` VALUES (440, 10066, '于强', '男', 51, NULL);
INSERT INTO `employee` VALUES (441, 10067, '阎磊', '女', 28, NULL);
INSERT INTO `employee` VALUES (442, 10068, '萧秀英', '男', 20, NULL);
INSERT INTO `employee` VALUES (443, 10069, '黄伟伟', '女', 23, NULL);
INSERT INTO `employee` VALUES (444, 10070, '林霞', '女', 47, 8);
INSERT INTO `employee` VALUES (445, 10071, '马勇娟', '男', 46, 5);
INSERT INTO `employee` VALUES (446, 10072, '徐超勇', '女', 50, 5);
INSERT INTO `employee` VALUES (447, 10073, '曹勇娟', '男', 48, 4);
INSERT INTO `employee` VALUES (448, 10074, '曹芳', '女', 59, 5);
INSERT INTO `employee` VALUES (449, 10075, '彭伟艳', '男', 22, 9);
INSERT INTO `employee` VALUES (450, 10076, '程秀兰杰', '男', 28, 2);
INSERT INTO `employee` VALUES (451, 10077, '冯军伟', '女', 47, 5);
INSERT INTO `employee` VALUES (452, 10078, '谢秀兰', '男', 51, 4);
INSERT INTO `employee` VALUES (453, 10079, '谢秀兰', '男', 48, 5);
INSERT INTO `employee` VALUES (454, 10080, '冯娟', '女', 29, 3);
INSERT INTO `employee` VALUES (455, 10081, '陈涛丽', '女', 40, 8);
INSERT INTO `employee` VALUES (456, 10082, '唐涛', '女', 35, 9);
INSERT INTO `employee` VALUES (457, 10083, '林强', '男', 36, 8);
INSERT INTO `employee` VALUES (458, 10084, '程军杰', '男', 56, 4);
INSERT INTO `employee` VALUES (459, 10085, '孙霞', '女', 40, 2);
INSERT INTO `employee` VALUES (460, 10086, '苏勇芳', '男', 60, NULL);
INSERT INTO `employee` VALUES (461, 10087, '孙涛', '女', 38, NULL);
INSERT INTO `employee` VALUES (462, 10088, '刘磊敏', '男', 60, NULL);
INSERT INTO `employee` VALUES (463, 10089, '丁霞', '男', 36, 8);
INSERT INTO `employee` VALUES (464, 10090, '吕洋', '男', 51, 9);
INSERT INTO `employee` VALUES (465, 10091, '黄艳洋', '男', 48, NULL);
INSERT INTO `employee` VALUES (466, 10092, '傅伟涛', '女', 58, 4);
INSERT INTO `employee` VALUES (467, 10093, '傅伟', '男', 42, NULL);
INSERT INTO `employee` VALUES (468, 10094, '宋涛强', '女', 27, 2);
INSERT INTO `employee` VALUES (469, 10095, '冯强', '男', 23, NULL);
INSERT INTO `employee` VALUES (470, 10096, '唐霞', '男', 46, NULL);
INSERT INTO `employee` VALUES (471, 10097, '张静', '男', 59, NULL);
INSERT INTO `employee` VALUES (472, 10098, '蔡伟娟', '女', 52, 3);
INSERT INTO `employee` VALUES (473, 10099, '魏霞', '男', 41, 8);
INSERT INTO `employee` VALUES (474, 10100, '彭霞伟', '女', 26, 8);
INSERT INTO `employee` VALUES (502, 12321, '大三大四dddd', '女', 11, NULL);
INSERT INTO `employee` VALUES (504, 10011, '111', '女', 22, NULL);

-- ----------------------------
-- Table structure for m_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `m_role_permission`;
CREATE TABLE `m_role_permission`  (
  `r_id` int(0) NOT NULL,
  `p_id` int(0) NOT NULL,
  UNIQUE INDEX `UKauisyd1wev6xoufu43jp8nnc8`(`r_id`, `p_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of m_role_permission
-- ----------------------------
INSERT INTO `m_role_permission` VALUES (1, 1);
INSERT INTO `m_role_permission` VALUES (1, 2);
INSERT INTO `m_role_permission` VALUES (1, 3);
INSERT INTO `m_role_permission` VALUES (1, 4);
INSERT INTO `m_role_permission` VALUES (1, 5);
INSERT INTO `m_role_permission` VALUES (1, 6);
INSERT INTO `m_role_permission` VALUES (2, 1);
INSERT INTO `m_role_permission` VALUES (2, 2);
INSERT INTO `m_role_permission` VALUES (2, 6);
INSERT INTO `m_role_permission` VALUES (3, 6);

-- ----------------------------
-- Table structure for m_user_role
-- ----------------------------
DROP TABLE IF EXISTS `m_user_role`;
CREATE TABLE `m_user_role`  (
  `u_id` int(0) NOT NULL,
  `r_id` int(0) NOT NULL,
  UNIQUE INDEX `UKckkgm0u5uccg6q7do1xj6bipf`(`u_id`, `r_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of m_user_role
-- ----------------------------
INSERT INTO `m_user_role` VALUES (1, 1);
INSERT INTO `m_user_role` VALUES (2, 2);
INSERT INTO `m_user_role` VALUES (3, 3);
INSERT INTO `m_user_role` VALUES (4, 1);
INSERT INTO `m_user_role` VALUES (5, 2);
INSERT INTO `m_user_role` VALUES (6, 3);
INSERT INTO `m_user_role` VALUES (7, 1);
INSERT INTO `m_user_role` VALUES (7, 4);

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '启用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES (1, 'employee', '员工管理', '员工管理模块：支持员工信息的新增、修改、删除、查询', '启用');
INSERT INTO `permission` VALUES (2, 'department', '部门管理', '部门管理模块：支持部门信息的新增、修改、删除、查询', '启用');
INSERT INTO `permission` VALUES (3, 'sysUser', '用户管理', '系统用户管理：用于创建、修改、删除系统登录账号，并分配角色', '启用');
INSERT INTO `permission` VALUES (4, 'sysRole', '角色管理', '系统角色管理：用于维护角色信息以及角色与权限的关联', '启用');
INSERT INTO `permission` VALUES (5, 'sysPermission', '权限管理', '权限资源管理：维护系统菜单、按钮等权限点，供角色授权使用', '启用');
INSERT INTO `permission` VALUES (6, 'common', '通用管理', NULL, '启用');
INSERT INTO `permission` VALUES (8, '!1@asd反手的?？', 'test', '撒大声地', '启用');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '启用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, 'ROLE_ADMIN', '管理员', NULL, '启用');
INSERT INTO `role` VALUES (2, 'ROLE_MANAGER', '经理', NULL, '启用');
INSERT INTO `role` VALUES (3, 'ROLE_EMPLOYEE', '员工', NULL, '启用');
INSERT INTO `role` VALUES (4, '111', 'test', '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@', '禁用');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '启用',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '$2a$12$CSUS47sJcfWkdDiukF5JR.tE8LfrROGCE3PHg9wM5HIL2UYhOixRC', 'hank', NULL, '启用', 'admin');
INSERT INTO `user` VALUES (2, '$2a$12$CSUS47sJcfWkdDiukF5JR.tE8LfrROGCE3PHg9wM5HIL2UYhOixRC', NULL, NULL, '启用', 'abc');
INSERT INTO `user` VALUES (3, '$2a$12$CSUS47sJcfWkdDiukF5JR.tE8LfrROGCE3PHg9wM5HIL2UYhOixRC', NULL, NULL, '启用', 'tom');
INSERT INTO `user` VALUES (4, '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', NULL, NULL, '启用', 'testadmin');
INSERT INTO `user` VALUES (5, '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'ddddddddddddddddddddddddddddddddddddddddddd', NULL, '启用', 'testmanager');
INSERT INTO `user` VALUES (6, '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', NULL, NULL, '启用', 'testemployee');
INSERT INTO `user` VALUES (7, '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', NULL, NULL, '启用', 'admin123');
INSERT INTO `user` VALUES (12, '$2a$10$8K1p/a0dL1Yz5bJnNqJYqJYqJYqJYqJYqJYqJYqJYqJYqJYqJYqJ', NULL, '21@1.1', '启用', 'manager');
INSERT INTO `user` VALUES (13, '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'shzbxjd', NULL, '启用', 'testuser12ddddddddddddddddddddddasdasdaaaaaaaaaaaaaaaaaaaaaaaaaaa');
INSERT INTO `user` VALUES (14, '$2a$10$dXJ3SW6G7P50lGmMkkmwe.20cQQubK3.HFjVjF7KJYqJYqJYqJYqJ', NULL, NULL, '禁用', 'testuser2');
INSERT INTO `user` VALUES (15, '$2a$10$8K1p/a0dL1Yz5bJnNqJYqJYqJYqJYqJYqJYqJYqJYqJYqJYqJYqJ', NULL, '11', '启用', 'manager');
INSERT INTO `user` VALUES (16, '$2a$10$CXMCinnPt6ht5sR/ahCRo.yTCXaiqtjIBZB451vHLE/8J4rp7vRLq', NULL, NULL, '启用', '111');

SET FOREIGN_KEY_CHECKS = 1;
