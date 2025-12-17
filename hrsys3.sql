/*
Navicat MySQL Data Transfer

Source Server         : a
Source Server Version : 50540
Source Host           : localhost:3306
Source Database       : hrsys3

Target Server Type    : MYSQL
Target Server Version : 50540
File Encoding         : 65001

Date: 2023-06-24 22:48:08
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `department`
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `number` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES ('1', '开发部', '101');
INSERT INTO `department` VALUES ('2', '测试部', '102');
INSERT INTO `department` VALUES ('3', '产品部', '103');
INSERT INTO `department` VALUES ('4', '设计部', '104');

-- ----------------------------
-- Table structure for `employee`
-- ----------------------------
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` int(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `dep_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of employee
-- ----------------------------
INSERT INTO `employee` VALUES ('84', '10001', '王悦', '女', '23', '3');
INSERT INTO `employee` VALUES ('86', '10002', '张婕', '女', '12', '2');
INSERT INTO `employee` VALUES ('94', '10003', '王聪', '男', '23', '2');
INSERT INTO `employee` VALUES ('95', '10004', '刘海', '男', '25', '1');
INSERT INTO `employee` VALUES ('96', '10005', '李越', '男', '26', '3');
INSERT INTO `employee` VALUES ('102', '10006', '杨静', '女', '25', '1');
INSERT INTO `employee` VALUES ('103', '10008', '周云', '男', '26', '2');
INSERT INTO `employee` VALUES ('105', '1', '1', '男', '1', '2');
INSERT INTO `employee` VALUES ('106', '2', '2', '男', '2', '2');
INSERT INTO `employee` VALUES ('108', '12', '12', '男', '12', '4');
INSERT INTO `employee` VALUES ('109', '3', '23', '男', '23', '1');
INSERT INTO `employee` VALUES ('110', '1', '1', '男', '1', '2');
INSERT INTO `employee` VALUES ('111', '1', '1', '男', '1', '2');
INSERT INTO `employee` VALUES ('112', '12', '12', '女', '12', '1');
INSERT INTO `employee` VALUES ('113', '1', 'qw', '女', '1', '1');
INSERT INTO `employee` VALUES ('114', '32', '23', '女', '23', '1');
INSERT INTO `employee` VALUES ('115', '32', '23', '男', '32', '2');
INSERT INTO `employee` VALUES ('116', '12', '12', '男', '12', '2');
INSERT INTO `employee` VALUES ('117', '32', '32', '男', '12', '4');

-- ----------------------------
-- Table structure for `m_role_permission`
-- ----------------------------
DROP TABLE IF EXISTS `m_role_permission`;
CREATE TABLE `m_role_permission` (
  `r_id` int(11) NOT NULL,
  `p_id` int(11) NOT NULL,
  UNIQUE KEY `UKauisyd1wev6xoufu43jp8nnc8` (`r_id`,`p_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of m_role_permission
-- ----------------------------
INSERT INTO `m_role_permission` VALUES ('1', '1');
INSERT INTO `m_role_permission` VALUES ('1', '2');
INSERT INTO `m_role_permission` VALUES ('1', '3');
INSERT INTO `m_role_permission` VALUES ('1', '4');
INSERT INTO `m_role_permission` VALUES ('1', '5');
INSERT INTO `m_role_permission` VALUES ('1', '6');
INSERT INTO `m_role_permission` VALUES ('2', '1');
INSERT INTO `m_role_permission` VALUES ('2', '2');
INSERT INTO `m_role_permission` VALUES ('2', '6');
INSERT INTO `m_role_permission` VALUES ('3', '6');

-- ----------------------------
-- Table structure for `m_user_role`
-- ----------------------------
DROP TABLE IF EXISTS `m_user_role`;
CREATE TABLE `m_user_role` (
  `u_id` int(11) NOT NULL,
  `r_id` int(11) NOT NULL,
  UNIQUE KEY `UKckkgm0u5uccg6q7do1xj6bipf` (`u_id`,`r_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of m_user_role
-- ----------------------------
INSERT INTO `m_user_role` VALUES ('1', '1');
INSERT INTO `m_user_role` VALUES ('2', '2');
INSERT INTO `m_user_role` VALUES ('3', '3');

-- ----------------------------
-- Table structure for `permission`
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES ('1', 'employee', '员工管理');
INSERT INTO `permission` VALUES ('2', 'department', '部门管理');
INSERT INTO `permission` VALUES ('3', 'sysUser', '用户管理');
INSERT INTO `permission` VALUES ('4', 'sysRole', '角色管理');
INSERT INTO `permission` VALUES ('5', 'sysPermission', '权限管理');
INSERT INTO `permission` VALUES ('6', 'common', '通用管理');

-- ----------------------------
-- Table structure for `role`
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', 'ROLE_ADMIN', '管理员');
INSERT INTO `role` VALUES ('2', 'ROLE_MANAGER', '经理');
INSERT INTO `role` VALUES ('3', 'ROLE_EMPLOYEE', '员工');

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', '$2a$10$YawFZD0Av3aGg5XDYYPiBeCuIFar3PpftRI/DK6Zby6UaU1rvT5Be', 'admin');
INSERT INTO `user` VALUES ('2', '$2a$10$ZdZmj4OgE8.EuVL17VcxiuiEtBBCFr0fccNOk1PrsVuqG8ir6Ktfu', 'abc');
INSERT INTO `user` VALUES ('3', '$2a$10$aOUZBkE/Gfc8s7qW3evJEePq4lFP7xcfadcpBQc3b0A9GyLw4xQ4m', 'tom');
