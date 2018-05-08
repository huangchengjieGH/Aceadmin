/*
Navicat MySQL Data Transfer

Source Server         : ace
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : sbw_db

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2018-04-01 00:48:13
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for sbw_admin
-- ----------------------------
DROP TABLE IF EXISTS `sbw_admin`;
CREATE TABLE `sbw_admin` (
  `id` mediumint(6) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL DEFAULT '',
  `password` varchar(32) NOT NULL DEFAULT '',
  `encrypt` varchar(6) NOT NULL DEFAULT '',
  `lastloginip` varchar(50) NOT NULL,
  `lastlogintime` int(10) unsigned NOT NULL DEFAULT '0',
  `email` varchar(40) NOT NULL DEFAULT '',
  `mobile` varchar(11) NOT NULL DEFAULT '',
  `realname` varchar(50) NOT NULL DEFAULT '',
  `openid` varchar(255) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效(2:无效,1:有效)',
  `updatetime` int(10) NOT NULL DEFAULT '0',
  `registertime` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `username` (`username`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sbw_admin
-- ----------------------------
INSERT INTO `sbw_admin` VALUES ('1', '墨夜瞳', '4e8baa6b218fa1ef22b9182283a82a19', '', '2130706433', '1522506306', 'yehith@sina.com', '15011911867', '墨夜瞳', '', '1', '1520088934', '1520088934');
INSERT INTO `sbw_admin` VALUES ('2', '13311857969', 'e10adc3949ba59abbe56e057f20f883e', '', '2130706433', '1522499543', 'Morihith@qq.com', '13311857969', '', '', '1', '0', '1521371903');
INSERT INTO `sbw_admin` VALUES ('3', '13314564959', 'e10adc3949ba59abbe56e057f20f883e', '', '2130706433', '1521617118', 'UIUI@qq.com', '13314564959', '', '', '1', '0', '1521385657');
INSERT INTO `sbw_admin` VALUES ('4', '供销商', 'e10adc3949ba59abbe56e057f20f883e', '', '2130706433', '1522500127', 'qwe@qq.com', '13314564896', '供销商', '', '1', '0', null);
INSERT INTO `sbw_admin` VALUES ('5', '我是合作商', 'e10adc3949ba59abbe56e057f20f883e', '', '', '1521688789', 'Email', '13354658456', '合作商', '', '1', '0', null);
INSERT INTO `sbw_admin` VALUES ('6', '18156569853', 'e10adc3949ba59abbe56e057f20f883e', '', '', '0', '1234@qq.com', '18156569853', '', '', '1', '0', '1521770103');
INSERT INTO `sbw_admin` VALUES ('7', '15011811857', 'e10adc3949ba59abbe56e057f20f883e', '', '', '0', '1234@qq.com', '15011811857', '', '', '1', '0', '1521968694');
INSERT INTO `sbw_admin` VALUES ('8', '15011811856', 'e10adc3949ba59abbe56e057f20f883e', '', '', '0', '', '15011811856', '', '', '1', '0', '1521969261');
INSERT INTO `sbw_admin` VALUES ('9', '15011311957', 'd0dcbf0d12a6b1e7fbfa2ce5848f3eff', '', '', '0', 'qq@qq.com', '15011311957', '', '', '1', '0', '1522048424');
INSERT INTO `sbw_admin` VALUES ('10', '15011911857', 'f270a8be7d56766ba4ec712dd4f27d78', '', '', '0', 'Qqq@qq.com', '15011911857', '', '', '1', '0', '1522306691');
INSERT INTO `sbw_admin` VALUES ('11', '13172077835', '98641e30ace18a76f07bd7e5fbf7cd6c', '', '', '0', '123@qq.com', '13172077835', '', '', '1', '0', '1522310929');

-- ----------------------------
-- Table structure for sbw_admin_group
-- ----------------------------
DROP TABLE IF EXISTS `sbw_admin_group`;
CREATE TABLE `sbw_admin_group` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` text,
  `rules` varchar(500) NOT NULL DEFAULT '' COMMENT '用户组拥有的规则id，多个规则 , 隔开',
  `listorder` smallint(5) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `listorder` (`listorder`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sbw_admin_group
-- ----------------------------
INSERT INTO `sbw_admin_group` VALUES ('2', '市场部管理员', '仅拥有日志管理权限', '35,36,34,38,23,41,42', '1', '1520607086');
INSERT INTO `sbw_admin_group` VALUES ('4', '加盟商', '拥有加盟商的所有权限', '31,1,23,32,33,39,40,50,51,37,43,46,36', '2', '1522497355');
INSERT INTO `sbw_admin_group` VALUES ('5', '运维', '管理库存', '37', '3', '1520607095');
INSERT INTO `sbw_admin_group` VALUES ('6', '供销商', '提供桶装水', '41,42,45', '4', '1520831171');
INSERT INTO `sbw_admin_group` VALUES ('7', '合作商', '可以添加用户', '34,47', '5', '1521688710');
INSERT INTO `sbw_admin_group` VALUES ('8', '管理员', '管理用户与管理员', '1,2,3,23', '6', '1521475894');
INSERT INTO `sbw_admin_group` VALUES ('9', '代理商', '', '', '7', '1522376560');

-- ----------------------------
-- Table structure for sbw_admin_group_access
-- ----------------------------
DROP TABLE IF EXISTS `sbw_admin_group_access`;
CREATE TABLE `sbw_admin_group_access` (
  `uid` int(10) unsigned NOT NULL COMMENT '用户id',
  `group_id` mediumint(8) NOT NULL COMMENT '权限id',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sbw_admin_group_access
-- ----------------------------
INSERT INTO `sbw_admin_group_access` VALUES ('2', '4');
INSERT INTO `sbw_admin_group_access` VALUES ('3', '4');
INSERT INTO `sbw_admin_group_access` VALUES ('6', '4');
INSERT INTO `sbw_admin_group_access` VALUES ('7', '4');
INSERT INTO `sbw_admin_group_access` VALUES ('8', '4');
INSERT INTO `sbw_admin_group_access` VALUES ('9', '4');
INSERT INTO `sbw_admin_group_access` VALUES ('10', '4');
INSERT INTO `sbw_admin_group_access` VALUES ('11', '4');
INSERT INTO `sbw_admin_group_access` VALUES ('4', '6');
INSERT INTO `sbw_admin_group_access` VALUES ('5', '7');

-- ----------------------------
-- Table structure for sbw_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `sbw_admin_log`;
CREATE TABLE `sbw_admin_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `m` varchar(15) NOT NULL,
  `c` varchar(20) NOT NULL,
  `a` varchar(20) NOT NULL,
  `querystring` varchar(255) NOT NULL,
  `userid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `username` varchar(20) NOT NULL,
  `ip` varchar(50) NOT NULL DEFAULT '',
  `time` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15036 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sbw_admin_log
-- ----------------------------
INSERT INTO `sbw_admin_log` VALUES ('14117', 'admin', 'Product', 'send_stock_look', '', '1', '墨夜瞳', '2130706433', '1521697923');
INSERT INTO `sbw_admin_log` VALUES ('14118', 'admin', 'Product', 'send_stock_look', '', '1', '墨夜瞳', '2130706433', '1521697933');
INSERT INTO `sbw_admin_log` VALUES ('14119', 'admin', 'Product', 'send_stock_look', '', '1', '墨夜瞳', '2130706433', '1521697939');
INSERT INTO `sbw_admin_log` VALUES ('14120', 'admin', 'Product', 'index', '', '1', '墨夜瞳', '2130706433', '1521697941');
INSERT INTO `sbw_admin_log` VALUES ('14121', 'admin', 'Product', 'send_stock_look', '', '1', '墨夜瞳', '2130706433', '1521697942');
INSERT INTO `sbw_admin_log` VALUES ('14122', 'admin', 'Product', 'send_stock_look', '', '1', '墨夜瞳', '2130706433', '1521707917');
INSERT INTO `sbw_admin_log` VALUES ('14123', 'admin', 'Product', 'query_stock', '', '1', '墨夜瞳', '2130706433', '1521707918');
INSERT INTO `sbw_admin_log` VALUES ('14124', 'admin', 'Group', 'index', '', '1', '墨夜瞳', '2130706433', '1521707918');
INSERT INTO `sbw_admin_log` VALUES ('14125', 'admin', 'Group', 'index', '', '1', '墨夜瞳', '2130706433', '1521707920');
INSERT INTO `sbw_admin_log` VALUES ('14126', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1521707921');
INSERT INTO `sbw_admin_log` VALUES ('14127', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1521707921');
INSERT INTO `sbw_admin_log` VALUES ('14128', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1521707922');
INSERT INTO `sbw_admin_log` VALUES ('14129', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1521707922');
INSERT INTO `sbw_admin_log` VALUES ('14130', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1521707923');
INSERT INTO `sbw_admin_log` VALUES ('14131', 'admin', 'Menu', 'look', '', '1', '墨夜瞳', '2130706433', '1521708189');
INSERT INTO `sbw_admin_log` VALUES ('14132', 'admin', 'Menu', 'info', '?id=18', '1', '墨夜瞳', '2130706433', '1521708194');
INSERT INTO `sbw_admin_log` VALUES ('14133', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1521709927');
INSERT INTO `sbw_admin_log` VALUES ('14134', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1521710002');
INSERT INTO `sbw_admin_log` VALUES ('14135', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1521710053');
INSERT INTO `sbw_admin_log` VALUES ('14136', 'admin', 'Shoper', 'info_pic', '', '1', '墨夜瞳', '2130706433', '1521710056');
INSERT INTO `sbw_admin_log` VALUES ('14137', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1521710151');
INSERT INTO `sbw_admin_log` VALUES ('14138', 'admin', 'Shoper', 'info_pic', '', '1', '墨夜瞳', '2130706433', '1521710152');
INSERT INTO `sbw_admin_log` VALUES ('14139', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1521710242');
INSERT INTO `sbw_admin_log` VALUES ('14140', 'admin', 'Admin', 'index', '', '1', '墨夜瞳', '2130706433', '1521710248');
INSERT INTO `sbw_admin_log` VALUES ('14141', 'admin', 'Group', 'index', '', '1', '墨夜瞳', '2130706433', '1521710250');
INSERT INTO `sbw_admin_log` VALUES ('14142', 'admin', 'Admin', 'public_edit_info', '', '1', '墨夜瞳', '2130706433', '1521710252');
INSERT INTO `sbw_admin_log` VALUES ('14143', 'admin', 'Product', 'query_stock', '', '1', '墨夜瞳', '2130706433', '1521710254');
INSERT INTO `sbw_admin_log` VALUES ('14144', 'admin', 'Product', 'query_stock', '', '1', '墨夜瞳', '2130706433', '1521710299');
INSERT INTO `sbw_admin_log` VALUES ('14145', 'admin', 'Product', 'query_stock', '', '1', '墨夜瞳', '2130706433', '1521710485');
INSERT INTO `sbw_admin_log` VALUES ('14146', 'admin', 'Product', 'enter_send', '', '1', '墨夜瞳', '2130706433', '1521710490');
INSERT INTO `sbw_admin_log` VALUES ('14147', 'admin', 'Product', 'send_stock_look', '', '1', '墨夜瞳', '2130706433', '1521710499');
INSERT INTO `sbw_admin_log` VALUES ('14148', 'admin', 'Product', 'add_stock', '', '1', '墨夜瞳', '2130706433', '1521710505');
INSERT INTO `sbw_admin_log` VALUES ('14149', 'admin', 'Shoperinfo', 'add', '', '1', '墨夜瞳', '2130706433', '1521710555');
INSERT INTO `sbw_admin_log` VALUES ('14150', 'admin', 'Shoperinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1521710557');
INSERT INTO `sbw_admin_log` VALUES ('14151', 'admin', 'Shoperinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1521710865');
INSERT INTO `sbw_admin_log` VALUES ('14152', 'admin', 'Menu', 'look', '', '1', '墨夜瞳', '2130706433', '1521710867');
INSERT INTO `sbw_admin_log` VALUES ('14153', 'admin', 'Product', 'send_stock_look', '', '1', '墨夜瞳', '2130706433', '1521710874');
INSERT INTO `sbw_admin_log` VALUES ('14154', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1521957762');
INSERT INTO `sbw_admin_log` VALUES ('14155', 'admin', 'Shoper', 'info_pic', '', '1', '墨夜瞳', '2130706433', '1521957788');
INSERT INTO `sbw_admin_log` VALUES ('14156', 'admin', 'Product', 'query_stock', '', '1', '墨夜瞳', '2130706433', '1521991595');
INSERT INTO `sbw_admin_log` VALUES ('14157', 'admin', 'Product', 'enter_send', '', '1', '墨夜瞳', '2130706433', '1521991602');
INSERT INTO `sbw_admin_log` VALUES ('14158', 'admin', 'Product', 'send_stock_look', '', '1', '墨夜瞳', '2130706433', '1522048700');
INSERT INTO `sbw_admin_log` VALUES ('14159', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522048705');
INSERT INTO `sbw_admin_log` VALUES ('14160', 'admin', 'Shoper', 'info_pic', '', '1', '墨夜瞳', '2130706433', '1522048736');
INSERT INTO `sbw_admin_log` VALUES ('14161', 'admin', 'Shoper', 'info_pic', '', '1', '墨夜瞳', '2130706433', '1522048742');
INSERT INTO `sbw_admin_log` VALUES ('14162', 'admin', 'Shoper', 'ispass', '', '1', '墨夜瞳', '2130706433', '1522048767');
INSERT INTO `sbw_admin_log` VALUES ('14163', 'admin', 'Product', 'send_stock_look', '', '1', '墨夜瞳', '2130706433', '1522048783');
INSERT INTO `sbw_admin_log` VALUES ('14164', 'admin', 'Product', 'send_stock_look', '', '1', '墨夜瞳', '2130706433', '1522048801');
INSERT INTO `sbw_admin_log` VALUES ('14165', 'admin', 'Menu', 'look', '', '1', '墨夜瞳', '2130706433', '1522049254');
INSERT INTO `sbw_admin_log` VALUES ('14166', 'admin', 'Shoperinfo', 'add', '', '1', '墨夜瞳', '2130706433', '1522049259');
INSERT INTO `sbw_admin_log` VALUES ('14167', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522049262');
INSERT INTO `sbw_admin_log` VALUES ('14168', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522049680');
INSERT INTO `sbw_admin_log` VALUES ('14169', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522049718');
INSERT INTO `sbw_admin_log` VALUES ('14170', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522049744');
INSERT INTO `sbw_admin_log` VALUES ('14171', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522049775');
INSERT INTO `sbw_admin_log` VALUES ('14172', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522049800');
INSERT INTO `sbw_admin_log` VALUES ('14173', 'admin', 'Product', 'query_stock', '', '1', '墨夜瞳', '2130706433', '1522049806');
INSERT INTO `sbw_admin_log` VALUES ('14174', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522049880');
INSERT INTO `sbw_admin_log` VALUES ('14175', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522049904');
INSERT INTO `sbw_admin_log` VALUES ('14176', 'admin', 'Product', 'send_stock_look', '', '1', '墨夜瞳', '2130706433', '1522113113');
INSERT INTO `sbw_admin_log` VALUES ('14177', 'admin', 'Product', 'query_stock', '', '1', '墨夜瞳', '2130706433', '1522113136');
INSERT INTO `sbw_admin_log` VALUES ('14178', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522113162');
INSERT INTO `sbw_admin_log` VALUES ('14179', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522113177');
INSERT INTO `sbw_admin_log` VALUES ('14180', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522113975');
INSERT INTO `sbw_admin_log` VALUES ('14181', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522114059');
INSERT INTO `sbw_admin_log` VALUES ('14182', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522114061');
INSERT INTO `sbw_admin_log` VALUES ('14183', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522114091');
INSERT INTO `sbw_admin_log` VALUES ('14184', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522114098');
INSERT INTO `sbw_admin_log` VALUES ('14185', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522114240');
INSERT INTO `sbw_admin_log` VALUES ('14186', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522114430');
INSERT INTO `sbw_admin_log` VALUES ('14187', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522114470');
INSERT INTO `sbw_admin_log` VALUES ('14188', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522114680');
INSERT INTO `sbw_admin_log` VALUES ('14189', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522114798');
INSERT INTO `sbw_admin_log` VALUES ('14190', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522114927');
INSERT INTO `sbw_admin_log` VALUES ('14191', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522114958');
INSERT INTO `sbw_admin_log` VALUES ('14192', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522114997');
INSERT INTO `sbw_admin_log` VALUES ('14193', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522115204');
INSERT INTO `sbw_admin_log` VALUES ('14194', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522115315');
INSERT INTO `sbw_admin_log` VALUES ('14195', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522116027');
INSERT INTO `sbw_admin_log` VALUES ('14196', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522116041');
INSERT INTO `sbw_admin_log` VALUES ('14197', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522116084');
INSERT INTO `sbw_admin_log` VALUES ('14198', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522116109');
INSERT INTO `sbw_admin_log` VALUES ('14199', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522116135');
INSERT INTO `sbw_admin_log` VALUES ('14200', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522116135');
INSERT INTO `sbw_admin_log` VALUES ('14201', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522116207');
INSERT INTO `sbw_admin_log` VALUES ('14202', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522116209');
INSERT INTO `sbw_admin_log` VALUES ('14203', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522116210');
INSERT INTO `sbw_admin_log` VALUES ('14204', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522116210');
INSERT INTO `sbw_admin_log` VALUES ('14205', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522116210');
INSERT INTO `sbw_admin_log` VALUES ('14206', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522116210');
INSERT INTO `sbw_admin_log` VALUES ('14207', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522116211');
INSERT INTO `sbw_admin_log` VALUES ('14208', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522116211');
INSERT INTO `sbw_admin_log` VALUES ('14209', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522116218');
INSERT INTO `sbw_admin_log` VALUES ('14210', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522116252');
INSERT INTO `sbw_admin_log` VALUES ('14211', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522116270');
INSERT INTO `sbw_admin_log` VALUES ('14212', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522116277');
INSERT INTO `sbw_admin_log` VALUES ('14213', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522116316');
INSERT INTO `sbw_admin_log` VALUES ('14214', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522116327');
INSERT INTO `sbw_admin_log` VALUES ('14215', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522116327');
INSERT INTO `sbw_admin_log` VALUES ('14216', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522116328');
INSERT INTO `sbw_admin_log` VALUES ('14217', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522116328');
INSERT INTO `sbw_admin_log` VALUES ('14218', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522116328');
INSERT INTO `sbw_admin_log` VALUES ('14219', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522116328');
INSERT INTO `sbw_admin_log` VALUES ('14220', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522116395');
INSERT INTO `sbw_admin_log` VALUES ('14221', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522116396');
INSERT INTO `sbw_admin_log` VALUES ('14222', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522116398');
INSERT INTO `sbw_admin_log` VALUES ('14223', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522116400');
INSERT INTO `sbw_admin_log` VALUES ('14224', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522116400');
INSERT INTO `sbw_admin_log` VALUES ('14225', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522116400');
INSERT INTO `sbw_admin_log` VALUES ('14226', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522116401');
INSERT INTO `sbw_admin_log` VALUES ('14227', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522116401');
INSERT INTO `sbw_admin_log` VALUES ('14228', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522116401');
INSERT INTO `sbw_admin_log` VALUES ('14229', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522116485');
INSERT INTO `sbw_admin_log` VALUES ('14230', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522116587');
INSERT INTO `sbw_admin_log` VALUES ('14231', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522116616');
INSERT INTO `sbw_admin_log` VALUES ('14232', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522116727');
INSERT INTO `sbw_admin_log` VALUES ('14233', 'admin', 'Shoperinfo', 'add', '', '1', '墨夜瞳', '2130706433', '1522116754');
INSERT INTO `sbw_admin_log` VALUES ('14234', 'admin', 'Shoperinfo', 'add', '', '1', '墨夜瞳', '2130706433', '1522117230');
INSERT INTO `sbw_admin_log` VALUES ('14235', 'admin', 'Shoperinfo', 'add', '', '1', '墨夜瞳', '2130706433', '1522117277');
INSERT INTO `sbw_admin_log` VALUES ('14236', 'admin', 'Shoperinfo', 'add', '', '1', '墨夜瞳', '2130706433', '1522117293');
INSERT INTO `sbw_admin_log` VALUES ('14237', 'admin', 'Shoperinfo', 'add', '', '1', '墨夜瞳', '2130706433', '1522117394');
INSERT INTO `sbw_admin_log` VALUES ('14238', 'admin', 'Shoperinfo', 'add', '', '1', '墨夜瞳', '2130706433', '1522117409');
INSERT INTO `sbw_admin_log` VALUES ('14239', 'admin', 'Shoperinfo', 'add', '', '1', '墨夜瞳', '2130706433', '1522117590');
INSERT INTO `sbw_admin_log` VALUES ('14240', 'admin', 'Shoperinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522117609');
INSERT INTO `sbw_admin_log` VALUES ('14241', 'admin', 'Shoperinfo', 'add', '', '1', '墨夜瞳', '2130706433', '1522117642');
INSERT INTO `sbw_admin_log` VALUES ('14242', 'admin', 'Index', 'admin', '', '1', '墨夜瞳', '2130706433', '1522119054');
INSERT INTO `sbw_admin_log` VALUES ('14243', 'admin', 'Index', 'admin', '', '1', '墨夜瞳', '2130706433', '1522119062');
INSERT INTO `sbw_admin_log` VALUES ('14244', 'admin', 'Index', 'admin', '', '1', '墨夜瞳', '2130706433', '1522120913');
INSERT INTO `sbw_admin_log` VALUES ('14245', 'admin', 'Menu', 'info', '?id=47', '1', '墨夜瞳', '2130706433', '1522121487');
INSERT INTO `sbw_admin_log` VALUES ('14246', 'admin', 'Menu', 'edit', '', '1', '墨夜瞳', '2130706433', '1522121504');
INSERT INTO `sbw_admin_log` VALUES ('14247', 'admin', 'Menu', 'setlistorder', '', '1', '墨夜瞳', '2130706433', '1522121507');
INSERT INTO `sbw_admin_log` VALUES ('14248', 'admin', 'Userinfo', 'add_info', '', '1', '墨夜瞳', '2130706433', '1522121512');
INSERT INTO `sbw_admin_log` VALUES ('14249', 'admin', 'Userinfo', 'add_info', '', '1', '墨夜瞳', '2130706433', '1522121591');
INSERT INTO `sbw_admin_log` VALUES ('14250', 'admin', 'Userinfo', 'add_info', '', '1', '墨夜瞳', '2130706433', '1522121593');
INSERT INTO `sbw_admin_log` VALUES ('14251', 'admin', 'Userinfo', 'add_info', '', '1', '墨夜瞳', '2130706433', '1522121594');
INSERT INTO `sbw_admin_log` VALUES ('14252', 'admin', 'Product', 'query_stock', '', '1', '墨夜瞳', '2130706433', '1522122392');
INSERT INTO `sbw_admin_log` VALUES ('14253', 'admin', 'Product', 'enter_send', '', '1', '墨夜瞳', '2130706433', '1522122400');
INSERT INTO `sbw_admin_log` VALUES ('14254', 'admin', 'Shoperinfo', 'add', '', '1', '墨夜瞳', '2130706433', '1522122434');
INSERT INTO `sbw_admin_log` VALUES ('14255', 'admin', 'Shoperinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522122451');
INSERT INTO `sbw_admin_log` VALUES ('14256', 'admin', 'Admin', 'public_edit_info', '', '1', '墨夜瞳', '2130706433', '1522122500');
INSERT INTO `sbw_admin_log` VALUES ('14257', 'admin', 'Group', 'index', '', '1', '墨夜瞳', '2130706433', '1522122503');
INSERT INTO `sbw_admin_log` VALUES ('14258', 'admin', 'Admin', 'index', '', '1', '墨夜瞳', '2130706433', '1522122506');
INSERT INTO `sbw_admin_log` VALUES ('14259', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522122509');
INSERT INTO `sbw_admin_log` VALUES ('14260', 'admin', 'Group', 'index', '', '1', '墨夜瞳', '2130706433', '1522122512');
INSERT INTO `sbw_admin_log` VALUES ('14261', 'admin', 'Product', 'send_stock_look', '', '1', '墨夜瞳', '2130706433', '1522122514');
INSERT INTO `sbw_admin_log` VALUES ('14262', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522128662');
INSERT INTO `sbw_admin_log` VALUES ('14263', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522128671');
INSERT INTO `sbw_admin_log` VALUES ('14264', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522128969');
INSERT INTO `sbw_admin_log` VALUES ('14265', 'admin', 'Userinfo', 'add_info', '', '1', '墨夜瞳', '2130706433', '1522128997');
INSERT INTO `sbw_admin_log` VALUES ('14266', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522128998');
INSERT INTO `sbw_admin_log` VALUES ('14267', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522128999');
INSERT INTO `sbw_admin_log` VALUES ('14268', 'admin', 'Product', 'send_stock_look', '', '1', '墨夜瞳', '2130706433', '1522129013');
INSERT INTO `sbw_admin_log` VALUES ('14269', 'admin', 'Product', 'index', '', '1', '墨夜瞳', '2130706433', '1522129021');
INSERT INTO `sbw_admin_log` VALUES ('14270', 'admin', 'Product', 'send_stock_look', '', '1', '墨夜瞳', '2130706433', '1522129022');
INSERT INTO `sbw_admin_log` VALUES ('14271', 'admin', 'Product', 'send_stock_look', '', '1', '墨夜瞳', '2130706433', '1522129224');
INSERT INTO `sbw_admin_log` VALUES ('14272', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522132465');
INSERT INTO `sbw_admin_log` VALUES ('14273', 'admin', 'Admin', 'index', '', '1', '墨夜瞳', '2130706433', '1522132477');
INSERT INTO `sbw_admin_log` VALUES ('14274', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522132575');
INSERT INTO `sbw_admin_log` VALUES ('14275', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522132590');
INSERT INTO `sbw_admin_log` VALUES ('14276', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522132593');
INSERT INTO `sbw_admin_log` VALUES ('14277', 'admin', 'Userinfo', 'add_info', '', '1', '墨夜瞳', '2130706433', '1522132601');
INSERT INTO `sbw_admin_log` VALUES ('14278', 'admin', 'Userinfo', 'add_info', '', '1', '墨夜瞳', '2130706433', '1522132606');
INSERT INTO `sbw_admin_log` VALUES ('14279', 'admin', 'Product', 'index', '', '1', '墨夜瞳', '2130706433', '1522132619');
INSERT INTO `sbw_admin_log` VALUES ('14280', 'admin', 'Shoperinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522132630');
INSERT INTO `sbw_admin_log` VALUES ('14281', 'admin', 'Shoperinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522132992');
INSERT INTO `sbw_admin_log` VALUES ('14282', 'admin', 'Shoperinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522133103');
INSERT INTO `sbw_admin_log` VALUES ('14283', 'admin', 'Shoperinfo', 'index', '?page=1&limit=30', '1', '墨夜瞳', '2130706433', '1522133103');
INSERT INTO `sbw_admin_log` VALUES ('14284', 'admin', 'Shoperinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522133140');
INSERT INTO `sbw_admin_log` VALUES ('14285', 'admin', 'Shoperinfo', 'index', '?page=1&limit=30', '1', '墨夜瞳', '2130706433', '1522133140');
INSERT INTO `sbw_admin_log` VALUES ('14286', 'admin', 'Shoperinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522133491');
INSERT INTO `sbw_admin_log` VALUES ('14287', 'admin', 'Shoperinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522133571');
INSERT INTO `sbw_admin_log` VALUES ('14288', 'admin', 'Admin', 'index', '', '1', '墨夜瞳', '2130706433', '1522133875');
INSERT INTO `sbw_admin_log` VALUES ('14289', 'admin', 'Product', 'index', '', '1', '墨夜瞳', '2130706433', '1522133934');
INSERT INTO `sbw_admin_log` VALUES ('14290', 'admin', 'Admin', 'index', '', '1', '墨夜瞳', '2130706433', '1522134058');
INSERT INTO `sbw_admin_log` VALUES ('14291', 'admin', 'Group', 'index', '', '1', '墨夜瞳', '2130706433', '1522134071');
INSERT INTO `sbw_admin_log` VALUES ('14292', 'admin', 'Product', 'query_stock', '', '1', '墨夜瞳', '2130706433', '1522134177');
INSERT INTO `sbw_admin_log` VALUES ('14293', 'admin', 'Shoperinfo', 'add', '', '1', '墨夜瞳', '2130706433', '1522134196');
INSERT INTO `sbw_admin_log` VALUES ('14294', 'admin', 'Shoperinfo', 'add', '', '1', '墨夜瞳', '2130706433', '1522134200');
INSERT INTO `sbw_admin_log` VALUES ('14295', 'admin', 'Userinfo', 'add_info', '', '1', '墨夜瞳', '2130706433', '1522134507');
INSERT INTO `sbw_admin_log` VALUES ('14296', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522134987');
INSERT INTO `sbw_admin_log` VALUES ('14297', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522135081');
INSERT INTO `sbw_admin_log` VALUES ('14298', 'admin', 'Product', 'send_stock_look', '', '1', '墨夜瞳', '2130706433', '1522135088');
INSERT INTO `sbw_admin_log` VALUES ('14299', 'admin', 'Product', 'query_stock', '', '1', '墨夜瞳', '2130706433', '1522136036');
INSERT INTO `sbw_admin_log` VALUES ('14300', 'admin', 'Product', 'query_stock', '', '1', '墨夜瞳', '2130706433', '1522136038');
INSERT INTO `sbw_admin_log` VALUES ('14301', 'admin', 'Product', 'index', '', '1', '墨夜瞳', '2130706433', '1522136040');
INSERT INTO `sbw_admin_log` VALUES ('14302', 'admin', 'Product', 'send_stock_look', '', '1', '墨夜瞳', '2130706433', '1522136041');
INSERT INTO `sbw_admin_log` VALUES ('14303', 'admin', 'Menu', 'info', '?id=42', '1', '墨夜瞳', '2130706433', '1522136195');
INSERT INTO `sbw_admin_log` VALUES ('14304', 'admin', 'Menu', 'edit', '', '1', '墨夜瞳', '2130706433', '1522136258');
INSERT INTO `sbw_admin_log` VALUES ('14305', 'admin', 'Menu', 'setlistorder', '', '1', '墨夜瞳', '2130706433', '1522136261');
INSERT INTO `sbw_admin_log` VALUES ('14306', 'admin', 'Admin', 'index', '', '1', '墨夜瞳', '2130706433', '1522137218');
INSERT INTO `sbw_admin_log` VALUES ('14307', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522137224');
INSERT INTO `sbw_admin_log` VALUES ('14308', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522137243');
INSERT INTO `sbw_admin_log` VALUES ('14309', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522137244');
INSERT INTO `sbw_admin_log` VALUES ('14310', 'admin', 'Shoper', 'ispass', '', '1', '墨夜瞳', '2130706433', '1522137250');
INSERT INTO `sbw_admin_log` VALUES ('14311', 'admin', 'Shoper', 'ispass', '', '1', '墨夜瞳', '2130706433', '1522137252');
INSERT INTO `sbw_admin_log` VALUES ('14312', 'admin', 'Shoper', 'ispass', '', '1', '墨夜瞳', '2130706433', '1522137256');
INSERT INTO `sbw_admin_log` VALUES ('14313', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522137273');
INSERT INTO `sbw_admin_log` VALUES ('14314', 'admin', 'Shoper', 'ispass', '', '1', '墨夜瞳', '2130706433', '1522137281');
INSERT INTO `sbw_admin_log` VALUES ('14315', 'admin', 'Shoper', 'ispass', '', '1', '墨夜瞳', '2130706433', '1522137282');
INSERT INTO `sbw_admin_log` VALUES ('14316', 'admin', 'Shoper', 'ispass', '', '1', '墨夜瞳', '2130706433', '1522137282');
INSERT INTO `sbw_admin_log` VALUES ('14317', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522137629');
INSERT INTO `sbw_admin_log` VALUES ('14318', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522138062');
INSERT INTO `sbw_admin_log` VALUES ('14319', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522138310');
INSERT INTO `sbw_admin_log` VALUES ('14320', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522138312');
INSERT INTO `sbw_admin_log` VALUES ('14321', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522138334');
INSERT INTO `sbw_admin_log` VALUES ('14322', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522138368');
INSERT INTO `sbw_admin_log` VALUES ('14323', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522138421');
INSERT INTO `sbw_admin_log` VALUES ('14324', 'admin', 'Product', 'index', '', '1', '墨夜瞳', '2130706433', '1522138469');
INSERT INTO `sbw_admin_log` VALUES ('14325', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522138602');
INSERT INTO `sbw_admin_log` VALUES ('14326', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522138822');
INSERT INTO `sbw_admin_log` VALUES ('14327', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522139030');
INSERT INTO `sbw_admin_log` VALUES ('14328', 'admin', 'Menu', 'info', '', '1', '墨夜瞳', '2130706433', '1522139102');
INSERT INTO `sbw_admin_log` VALUES ('14329', 'admin', 'Menu', 'add', '', '1', '墨夜瞳', '2130706433', '1522139122');
INSERT INTO `sbw_admin_log` VALUES ('14330', 'admin', 'Menu', 'info', '?id=48', '1', '墨夜瞳', '2130706433', '1522139129');
INSERT INTO `sbw_admin_log` VALUES ('14331', 'admin', 'Menu', 'edit', '', '1', '墨夜瞳', '2130706433', '1522139145');
INSERT INTO `sbw_admin_log` VALUES ('14332', 'admin', 'Menu', 'setlistorder', '', '1', '墨夜瞳', '2130706433', '1522139149');
INSERT INTO `sbw_admin_log` VALUES ('14333', 'admin', 'Menu', 'info', '?id=48', '1', '墨夜瞳', '2130706433', '1522139170');
INSERT INTO `sbw_admin_log` VALUES ('14334', 'admin', 'Menu', 'edit', '', '1', '墨夜瞳', '2130706433', '1522139181');
INSERT INTO `sbw_admin_log` VALUES ('14335', 'admin', 'Menu', 'setlistorder', '', '1', '墨夜瞳', '2130706433', '1522139188');
INSERT INTO `sbw_admin_log` VALUES ('14336', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522139214');
INSERT INTO `sbw_admin_log` VALUES ('14337', 'admin', 'Group', 'index', '', '1', '墨夜瞳', '2130706433', '1522139259');
INSERT INTO `sbw_admin_log` VALUES ('14338', 'admin', 'Admin', 'index', '', '1', '墨夜瞳', '2130706433', '1522139260');
INSERT INTO `sbw_admin_log` VALUES ('14339', 'admin', 'Userinfo', 'add_info', '', '1', '墨夜瞳', '2130706433', '1522139262');
INSERT INTO `sbw_admin_log` VALUES ('14340', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522139263');
INSERT INTO `sbw_admin_log` VALUES ('14341', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522139264');
INSERT INTO `sbw_admin_log` VALUES ('14342', 'admin', 'Userinfo', 'add_info', '', '1', '墨夜瞳', '2130706433', '1522139265');
INSERT INTO `sbw_admin_log` VALUES ('14343', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522139287');
INSERT INTO `sbw_admin_log` VALUES ('14344', 'admin', 'Admin', 'index', '', '1', '墨夜瞳', '2130706433', '1522139291');
INSERT INTO `sbw_admin_log` VALUES ('14345', 'admin', 'Group', 'index', '', '1', '墨夜瞳', '2130706433', '1522139293');
INSERT INTO `sbw_admin_log` VALUES ('14346', 'admin', 'Admin', 'public_edit_info', '', '1', '墨夜瞳', '2130706433', '1522139294');
INSERT INTO `sbw_admin_log` VALUES ('14347', 'admin', 'Group', 'index', '', '1', '墨夜瞳', '2130706433', '1522139296');
INSERT INTO `sbw_admin_log` VALUES ('14348', 'admin', 'Userinfo', 'add_info', '', '1', '墨夜瞳', '2130706433', '1522139309');
INSERT INTO `sbw_admin_log` VALUES ('14349', 'admin', 'Group', 'index', '', '1', '墨夜瞳', '2130706433', '1522139335');
INSERT INTO `sbw_admin_log` VALUES ('14350', 'admin', 'Admin', 'index', '', '1', '墨夜瞳', '2130706433', '1522139340');
INSERT INTO `sbw_admin_log` VALUES ('14351', 'admin', 'Admin', 'index', '', '1', '墨夜瞳', '2130706433', '1522139346');
INSERT INTO `sbw_admin_log` VALUES ('14352', 'admin', 'Admin', 'index', '', '1', '墨夜瞳', '2130706433', '1522139359');
INSERT INTO `sbw_admin_log` VALUES ('14353', 'admin', 'Admin', 'index', '', '1', '墨夜瞳', '2130706433', '1522139362');
INSERT INTO `sbw_admin_log` VALUES ('14354', 'admin', 'Admin', 'index', '', '1', '墨夜瞳', '2130706433', '1522139364');
INSERT INTO `sbw_admin_log` VALUES ('14355', 'admin', 'Admin', 'index', '', '1', '墨夜瞳', '2130706433', '1522139366');
INSERT INTO `sbw_admin_log` VALUES ('14356', 'admin', 'Admin', 'index', '', '1', '墨夜瞳', '2130706433', '1522139369');
INSERT INTO `sbw_admin_log` VALUES ('14357', 'admin', 'Product', 'send_stock_look', '', '1', '墨夜瞳', '2130706433', '1522139406');
INSERT INTO `sbw_admin_log` VALUES ('14358', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522139431');
INSERT INTO `sbw_admin_log` VALUES ('14359', 'admin', 'Product', 'send_stock_look', '', '1', '墨夜瞳', '2130706433', '1522139442');
INSERT INTO `sbw_admin_log` VALUES ('14360', 'admin', 'Admin', 'public_edit_info', '', '1', '墨夜瞳', '2130706433', '1522139489');
INSERT INTO `sbw_admin_log` VALUES ('14361', 'admin', 'Product', 'query_stock', '', '1', '墨夜瞳', '2130706433', '1522139490');
INSERT INTO `sbw_admin_log` VALUES ('14362', 'admin', 'Product', 'send_stock_look', '', '1', '墨夜瞳', '2130706433', '1522139491');
INSERT INTO `sbw_admin_log` VALUES ('14363', 'admin', 'Product', 'index', '', '1', '墨夜瞳', '2130706433', '1522139492');
INSERT INTO `sbw_admin_log` VALUES ('14364', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522139590');
INSERT INTO `sbw_admin_log` VALUES ('14365', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522139656');
INSERT INTO `sbw_admin_log` VALUES ('14366', 'admin', 'Product', 'query_stock', '', '1', '墨夜瞳', '2130706433', '1522139688');
INSERT INTO `sbw_admin_log` VALUES ('14367', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522139691');
INSERT INTO `sbw_admin_log` VALUES ('14368', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522139817');
INSERT INTO `sbw_admin_log` VALUES ('14369', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522139838');
INSERT INTO `sbw_admin_log` VALUES ('14370', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522139974');
INSERT INTO `sbw_admin_log` VALUES ('14371', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522140000');
INSERT INTO `sbw_admin_log` VALUES ('14372', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522140002');
INSERT INTO `sbw_admin_log` VALUES ('14373', 'admin', 'Product', 'query_stock', '', '1', '墨夜瞳', '2130706433', '1522140012');
INSERT INTO `sbw_admin_log` VALUES ('14374', 'admin', 'Product', 'send_stock_look', '', '1', '墨夜瞳', '2130706433', '1522140015');
INSERT INTO `sbw_admin_log` VALUES ('14375', 'admin', 'Menu', 'look', '', '1', '墨夜瞳', '2130706433', '1522140110');
INSERT INTO `sbw_admin_log` VALUES ('14376', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522140368');
INSERT INTO `sbw_admin_log` VALUES ('14377', 'admin', 'Product', 'query_stock', '', '1', '墨夜瞳', '2130706433', '1522140371');
INSERT INTO `sbw_admin_log` VALUES ('14378', 'admin', 'Product', 'send_stock_look', '', '1', '墨夜瞳', '2130706433', '1522140373');
INSERT INTO `sbw_admin_log` VALUES ('14379', 'admin', 'Product', 'send_stock_look', '', '1', '墨夜瞳', '2130706433', '1522140499');
INSERT INTO `sbw_admin_log` VALUES ('14380', 'admin', 'Product', 'send_stock_look', '', '1', '墨夜瞳', '2130706433', '1522140521');
INSERT INTO `sbw_admin_log` VALUES ('14381', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522140704');
INSERT INTO `sbw_admin_log` VALUES ('14382', 'admin', 'Product', 'send_stock_look', '', '1', '墨夜瞳', '2130706433', '1522140730');
INSERT INTO `sbw_admin_log` VALUES ('14383', 'admin', 'Product', 'send_stock_look', '', '1', '墨夜瞳', '2130706433', '1522140847');
INSERT INTO `sbw_admin_log` VALUES ('14384', 'admin', 'Product', 'send_stock_look', '', '1', '墨夜瞳', '2130706433', '1522141206');
INSERT INTO `sbw_admin_log` VALUES ('14385', 'admin', 'Product', 'index', '', '1', '墨夜瞳', '2130706433', '1522198564');
INSERT INTO `sbw_admin_log` VALUES ('14386', 'admin', 'Product', 'info', '', '1', '墨夜瞳', '2130706433', '1522198567');
INSERT INTO `sbw_admin_log` VALUES ('14387', 'admin', 'Product', 'add', '', '1', '墨夜瞳', '2130706433', '1522198639');
INSERT INTO `sbw_admin_log` VALUES ('14388', 'admin', 'Product', 'index', '', '1', '墨夜瞳', '2130706433', '1522198639');
INSERT INTO `sbw_admin_log` VALUES ('14389', 'admin', 'Product', 'send_stock_look', '', '1', '墨夜瞳', '2130706433', '1522198695');
INSERT INTO `sbw_admin_log` VALUES ('14390', 'admin', 'Product', 'send_stock_look', '', '1', '墨夜瞳', '2130706433', '1522198787');
INSERT INTO `sbw_admin_log` VALUES ('14391', 'admin', 'Product', 'send_stock_look', '', '1', '墨夜瞳', '2130706433', '1522198840');
INSERT INTO `sbw_admin_log` VALUES ('14392', 'admin', 'Product', 'send_stock_look', '', '1', '墨夜瞳', '2130706433', '1522199158');
INSERT INTO `sbw_admin_log` VALUES ('14393', 'admin', 'Product', 'send_stock_look', '', '1', '墨夜瞳', '2130706433', '1522199266');
INSERT INTO `sbw_admin_log` VALUES ('14394', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522199606');
INSERT INTO `sbw_admin_log` VALUES ('14395', 'admin', 'Shoper', 'ispass', '', '1', '墨夜瞳', '2130706433', '1522199611');
INSERT INTO `sbw_admin_log` VALUES ('14396', 'admin', 'Shoper', 'info_pic', '', '1', '墨夜瞳', '2130706433', '1522200299');
INSERT INTO `sbw_admin_log` VALUES ('14397', 'admin', 'Menu', 'info', '?id=32', '1', '墨夜瞳', '2130706433', '1522209405');
INSERT INTO `sbw_admin_log` VALUES ('14398', 'admin', 'Menu', 'edit', '', '1', '墨夜瞳', '2130706433', '1522209432');
INSERT INTO `sbw_admin_log` VALUES ('14399', 'admin', 'Menu', 'setlistorder', '', '1', '墨夜瞳', '2130706433', '1522209434');
INSERT INTO `sbw_admin_log` VALUES ('14400', 'admin', 'Product', 'send_stock_look', '', '1', '墨夜瞳', '2130706433', '1522214310');
INSERT INTO `sbw_admin_log` VALUES ('14401', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522215338');
INSERT INTO `sbw_admin_log` VALUES ('14402', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522215340');
INSERT INTO `sbw_admin_log` VALUES ('14403', 'admin', 'Userinfo', 'add_info', '', '1', '墨夜瞳', '2130706433', '1522215340');
INSERT INTO `sbw_admin_log` VALUES ('14404', 'admin', 'Menu', 'info', '?id=31', '1', '墨夜瞳', '2130706433', '1522215364');
INSERT INTO `sbw_admin_log` VALUES ('14405', 'admin', 'Menu', 'edit', '', '1', '墨夜瞳', '2130706433', '1522215369');
INSERT INTO `sbw_admin_log` VALUES ('14406', 'admin', 'Menu', 'info', '?parentid=31', '1', '墨夜瞳', '2130706433', '1522215372');
INSERT INTO `sbw_admin_log` VALUES ('14407', 'admin', 'Menu', 'add', '', '1', '墨夜瞳', '2130706433', '1522215393');
INSERT INTO `sbw_admin_log` VALUES ('14408', 'admin', 'Menu', 'info', '?id=31', '1', '墨夜瞳', '2130706433', '1522215398');
INSERT INTO `sbw_admin_log` VALUES ('14409', 'admin', 'Menu', 'info', '?id=49', '1', '墨夜瞳', '2130706433', '1522215408');
INSERT INTO `sbw_admin_log` VALUES ('14410', 'admin', 'Menu', 'edit', '', '1', '墨夜瞳', '2130706433', '1522215413');
INSERT INTO `sbw_admin_log` VALUES ('14411', 'admin', 'Menu', 'setlistorder', '', '1', '墨夜瞳', '2130706433', '1522215414');
INSERT INTO `sbw_admin_log` VALUES ('14412', 'admin', 'Shoperinfo', 'add', '', '1', '墨夜瞳', '2130706433', '1522215459');
INSERT INTO `sbw_admin_log` VALUES ('14413', 'admin', 'Menu', 'info', '?id=49', '1', '墨夜瞳', '2130706433', '1522216222');
INSERT INTO `sbw_admin_log` VALUES ('14414', 'admin', 'Menu', 'edit', '', '1', '墨夜瞳', '2130706433', '1522216228');
INSERT INTO `sbw_admin_log` VALUES ('14415', 'admin', 'Menu', 'setlistorder', '', '1', '墨夜瞳', '2130706433', '1522216247');
INSERT INTO `sbw_admin_log` VALUES ('14416', 'admin', 'Index', 'index_mod', '', '1', '墨夜瞳', '2130706433', '1522216253');
INSERT INTO `sbw_admin_log` VALUES ('14417', 'admin', 'Index', 'index_mod', '', '1', '墨夜瞳', '2130706433', '1522216260');
INSERT INTO `sbw_admin_log` VALUES ('14418', 'admin', 'Index', 'index_mod', '', '1', '墨夜瞳', '2130706433', '1522216282');
INSERT INTO `sbw_admin_log` VALUES ('14419', 'admin', 'Menu', 'info', '?id=1', '1', '墨夜瞳', '2130706433', '1522216403');
INSERT INTO `sbw_admin_log` VALUES ('14420', 'admin', 'Menu', 'edit', '', '1', '墨夜瞳', '2130706433', '1522216409');
INSERT INTO `sbw_admin_log` VALUES ('14421', 'admin', 'Menu', 'setlistorder', '', '1', '墨夜瞳', '2130706433', '1522216412');
INSERT INTO `sbw_admin_log` VALUES ('14422', 'admin', 'Admin', 'admin', '', '1', '墨夜瞳', '2130706433', '1522216417');
INSERT INTO `sbw_admin_log` VALUES ('14423', 'admin', 'Admin', 'admin', '', '1', '墨夜瞳', '2130706433', '1522216419');
INSERT INTO `sbw_admin_log` VALUES ('14424', 'admin', 'Admin', 'admin', '', '1', '墨夜瞳', '2130706433', '1522216420');
INSERT INTO `sbw_admin_log` VALUES ('14425', 'admin', 'Admin', 'admin', '', '1', '墨夜瞳', '2130706433', '1522216421');
INSERT INTO `sbw_admin_log` VALUES ('14426', 'admin', 'Product', 'send_stock_look', '', '1', '墨夜瞳', '2130706433', '1522228650');
INSERT INTO `sbw_admin_log` VALUES ('14427', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522228669');
INSERT INTO `sbw_admin_log` VALUES ('14428', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522228710');
INSERT INTO `sbw_admin_log` VALUES ('14429', 'admin', 'Product', 'query_stock', '', '1', '墨夜瞳', '2130706433', '1522228716');
INSERT INTO `sbw_admin_log` VALUES ('14430', 'admin', 'Product', 'send_stock_look', '', '1', '墨夜瞳', '2130706433', '1522228719');
INSERT INTO `sbw_admin_log` VALUES ('14431', 'admin', 'Product', 'index', '', '1', '墨夜瞳', '2130706433', '1522228856');
INSERT INTO `sbw_admin_log` VALUES ('14432', 'admin', 'Admin', 'admin', '', '1', '墨夜瞳', '2130706433', '1522228881');
INSERT INTO `sbw_admin_log` VALUES ('14433', 'admin', 'Admin', 'index', '', '1', '墨夜瞳', '2130706433', '1522228882');
INSERT INTO `sbw_admin_log` VALUES ('14434', 'admin', 'Admin', 'index', '', '1', '墨夜瞳', '2130706433', '1522228889');
INSERT INTO `sbw_admin_log` VALUES ('14435', 'admin', 'Admin', 'index', '', '1', '墨夜瞳', '2130706433', '1522228891');
INSERT INTO `sbw_admin_log` VALUES ('14436', 'admin', 'Admin', 'index', '', '1', '墨夜瞳', '2130706433', '1522228892');
INSERT INTO `sbw_admin_log` VALUES ('14437', 'admin', 'Admin', 'index', '', '1', '墨夜瞳', '2130706433', '1522228897');
INSERT INTO `sbw_admin_log` VALUES ('14438', 'admin', 'Admin', 'admin', '', '1', '墨夜瞳', '2130706433', '1522228913');
INSERT INTO `sbw_admin_log` VALUES ('14439', 'admin', 'Shoperinfo', 'add', '', '1', '墨夜瞳', '2130706433', '1522228915');
INSERT INTO `sbw_admin_log` VALUES ('14440', 'admin', 'Shoperinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522228917');
INSERT INTO `sbw_admin_log` VALUES ('14441', 'admin', 'Shoperinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522228918');
INSERT INTO `sbw_admin_log` VALUES ('14442', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522229208');
INSERT INTO `sbw_admin_log` VALUES ('14443', 'admin', 'Userinfo', 'add_info', '', '1', '墨夜瞳', '2130706433', '1522229222');
INSERT INTO `sbw_admin_log` VALUES ('14444', 'admin', 'Userinfo', 'add_info', '', '1', '墨夜瞳', '2130706433', '1522229232');
INSERT INTO `sbw_admin_log` VALUES ('14445', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522229289');
INSERT INTO `sbw_admin_log` VALUES ('14446', 'admin', 'Shoperinfo', 'add', '', '1', '墨夜瞳', '2130706433', '1522229330');
INSERT INTO `sbw_admin_log` VALUES ('14447', 'admin', 'Shoperinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522229332');
INSERT INTO `sbw_admin_log` VALUES ('14448', 'admin', 'Menu', 'info', '?id=33', '1', '墨夜瞳', '2130706433', '1522229386');
INSERT INTO `sbw_admin_log` VALUES ('14449', 'admin', 'Menu', 'info', '?parentid=32', '1', '墨夜瞳', '2130706433', '1522229395');
INSERT INTO `sbw_admin_log` VALUES ('14450', 'admin', 'Menu', 'add', '', '1', '墨夜瞳', '2130706433', '1522229413');
INSERT INTO `sbw_admin_log` VALUES ('14451', 'admin', 'Menu', 'setlistorder', '', '1', '墨夜瞳', '2130706433', '1522229415');
INSERT INTO `sbw_admin_log` VALUES ('14452', 'admin', 'Menu', 'info', '?id=32', '1', '墨夜瞳', '2130706433', '1522369479');
INSERT INTO `sbw_admin_log` VALUES ('14453', 'admin', 'Menu', 'info', '?parentid=32', '1', '墨夜瞳', '2130706433', '1522369491');
INSERT INTO `sbw_admin_log` VALUES ('14454', 'admin', 'Menu', 'add', '', '1', '墨夜瞳', '2130706433', '1522369511');
INSERT INTO `sbw_admin_log` VALUES ('14455', 'admin', 'Menu', 'setlistorder', '', '1', '墨夜瞳', '2130706433', '1522369516');
INSERT INTO `sbw_admin_log` VALUES ('14456', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522369529');
INSERT INTO `sbw_admin_log` VALUES ('14457', 'admin', 'Shoper', 'info_pic', '', '1', '墨夜瞳', '2130706433', '1522369545');
INSERT INTO `sbw_admin_log` VALUES ('14458', 'admin', 'Menu', 'info', '?id=50', '1', '墨夜瞳', '2130706433', '1522369584');
INSERT INTO `sbw_admin_log` VALUES ('14459', 'admin', 'Menu', 'edit', '', '1', '墨夜瞳', '2130706433', '1522369586');
INSERT INTO `sbw_admin_log` VALUES ('14460', 'admin', 'Menu', 'setlistorder', '', '1', '墨夜瞳', '2130706433', '1522369591');
INSERT INTO `sbw_admin_log` VALUES ('14461', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522373346');
INSERT INTO `sbw_admin_log` VALUES ('14462', 'admin', 'Product', 'send_stock_look', '', '1', '墨夜瞳', '2130706433', '1522373365');
INSERT INTO `sbw_admin_log` VALUES ('14463', 'admin', 'Userinfo', 'add_info', '', '1', '墨夜瞳', '2130706433', '1522375336');
INSERT INTO `sbw_admin_log` VALUES ('14464', 'admin', 'Userinfo', 'add_info', '', '1', '墨夜瞳', '2130706433', '1522375586');
INSERT INTO `sbw_admin_log` VALUES ('14465', 'admin', 'Admin', 'admin', '', '1', '墨夜瞳', '2130706433', '1522376485');
INSERT INTO `sbw_admin_log` VALUES ('14466', 'admin', 'Admin', 'index', '', '1', '墨夜瞳', '2130706433', '1522376485');
INSERT INTO `sbw_admin_log` VALUES ('14467', 'admin', 'Menu', 'info', '?id=1', '1', '墨夜瞳', '2130706433', '1522376501');
INSERT INTO `sbw_admin_log` VALUES ('14468', 'admin', 'Menu', 'edit', '', '1', '墨夜瞳', '2130706433', '1522376505');
INSERT INTO `sbw_admin_log` VALUES ('14469', 'admin', 'Menu', 'setlistorder', '', '1', '墨夜瞳', '2130706433', '1522376511');
INSERT INTO `sbw_admin_log` VALUES ('14470', 'admin', 'Group', 'index', '', '1', '墨夜瞳', '2130706433', '1522376522');
INSERT INTO `sbw_admin_log` VALUES ('14471', 'admin', 'Group', 'info', '', '1', '墨夜瞳', '2130706433', '1522376534');
INSERT INTO `sbw_admin_log` VALUES ('14472', 'admin', 'Group', 'add', '', '1', '墨夜瞳', '2130706433', '1522376547');
INSERT INTO `sbw_admin_log` VALUES ('14473', 'admin', 'Group', 'info', '?id=9', '1', '墨夜瞳', '2130706433', '1522376555');
INSERT INTO `sbw_admin_log` VALUES ('14474', 'admin', 'Group', 'edit', '', '1', '墨夜瞳', '2130706433', '1522376559');
INSERT INTO `sbw_admin_log` VALUES ('14475', 'admin', 'Admin', 'index', '', '1', '墨夜瞳', '2130706433', '1522376584');
INSERT INTO `sbw_admin_log` VALUES ('14476', 'admin', 'Admin', 'index', '', '1', '墨夜瞳', '2130706433', '1522376600');
INSERT INTO `sbw_admin_log` VALUES ('14477', 'admin', 'Admin', 'index', '', '1', '墨夜瞳', '2130706433', '1522376602');
INSERT INTO `sbw_admin_log` VALUES ('14478', 'admin', 'Product', 'send_stock_look', '', '1', '墨夜瞳', '2130706433', '1522376611');
INSERT INTO `sbw_admin_log` VALUES ('14479', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522376615');
INSERT INTO `sbw_admin_log` VALUES ('14480', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522376642');
INSERT INTO `sbw_admin_log` VALUES ('14481', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522376644');
INSERT INTO `sbw_admin_log` VALUES ('14482', 'admin', 'Userinfo', 'add_info', '', '1', '墨夜瞳', '2130706433', '1522379343');
INSERT INTO `sbw_admin_log` VALUES ('14483', 'admin', 'Userinfo', 'add_info', '', '1', '墨夜瞳', '2130706433', '1522390830');
INSERT INTO `sbw_admin_log` VALUES ('14484', 'admin', 'Userinfo', 'add_info', '', '1', '墨夜瞳', '2130706433', '1522391072');
INSERT INTO `sbw_admin_log` VALUES ('14485', 'admin', 'Userinfo', 'send_sms', '', '1', '墨夜瞳', '2130706433', '1522391076');
INSERT INTO `sbw_admin_log` VALUES ('14486', 'admin', 'Userinfo', 'add_info', '', '1', '墨夜瞳', '2130706433', '1522391192');
INSERT INTO `sbw_admin_log` VALUES ('14487', 'admin', 'Userinfo', 'add_info', '', '1', '墨夜瞳', '2130706433', '1522391233');
INSERT INTO `sbw_admin_log` VALUES ('14488', 'admin', 'Userinfo', 'add_info', '', '1', '墨夜瞳', '2130706433', '1522391281');
INSERT INTO `sbw_admin_log` VALUES ('14489', 'admin', 'Userinfo', 'send_sms', '', '1', '墨夜瞳', '2130706433', '1522391288');
INSERT INTO `sbw_admin_log` VALUES ('14490', 'admin', 'Userinfo', 'send_sms', '', '1', '墨夜瞳', '2130706433', '1522391370');
INSERT INTO `sbw_admin_log` VALUES ('14491', 'admin', 'Userinfo', 'send_sms', '', '1', '墨夜瞳', '2130706433', '1522391412');
INSERT INTO `sbw_admin_log` VALUES ('14492', 'admin', 'Userinfo', 'send_sms', '', '1', '墨夜瞳', '2130706433', '1522391474');
INSERT INTO `sbw_admin_log` VALUES ('14493', 'admin', 'Userinfo', 'add_info', '', '1', '墨夜瞳', '2130706433', '1522392200');
INSERT INTO `sbw_admin_log` VALUES ('14494', 'admin', 'Userinfo', 'send_sms', '', '1', '墨夜瞳', '2130706433', '1522392230');
INSERT INTO `sbw_admin_log` VALUES ('14495', 'admin', 'Userinfo', 'send_sms', '', '1', '墨夜瞳', '2130706433', '1522392236');
INSERT INTO `sbw_admin_log` VALUES ('14496', 'admin', 'Userinfo', 'send_sms', '', '1', '墨夜瞳', '2130706433', '1522393265');
INSERT INTO `sbw_admin_log` VALUES ('14497', 'admin', 'Userinfo', 'send_sms', '', '1', '墨夜瞳', '2130706433', '1522393418');
INSERT INTO `sbw_admin_log` VALUES ('14498', 'admin', 'Userinfo', 'send_sms', '', '1', '墨夜瞳', '2130706433', '1522393510');
INSERT INTO `sbw_admin_log` VALUES ('14499', 'admin', 'Userinfo', 'add_info', '', '1', '墨夜瞳', '2130706433', '1522393620');
INSERT INTO `sbw_admin_log` VALUES ('14500', 'admin', 'Userinfo', 'send_sms', '', '1', '墨夜瞳', '2130706433', '1522393628');
INSERT INTO `sbw_admin_log` VALUES ('14501', 'admin', 'Userinfo', 'send_sms', '', '1', '墨夜瞳', '2130706433', '1522393796');
INSERT INTO `sbw_admin_log` VALUES ('14502', 'admin', 'Userinfo', 'send_sms', '', '1', '墨夜瞳', '2130706433', '1522394144');
INSERT INTO `sbw_admin_log` VALUES ('14503', 'admin', 'Userinfo', 'send_sms', '', '1', '墨夜瞳', '2130706433', '1522394298');
INSERT INTO `sbw_admin_log` VALUES ('14504', 'admin', 'Userinfo', 'send_sms', '', '1', '墨夜瞳', '2130706433', '1522394823');
INSERT INTO `sbw_admin_log` VALUES ('14505', 'admin', 'Userinfo', 'send_sms', '', '1', '墨夜瞳', '2130706433', '1522394854');
INSERT INTO `sbw_admin_log` VALUES ('14506', 'admin', 'Userinfo', 'send_sms', '', '1', '墨夜瞳', '2130706433', '1522394905');
INSERT INTO `sbw_admin_log` VALUES ('14507', 'admin', 'Userinfo', 'send_sms', '', '1', '墨夜瞳', '2130706433', '1522396498');
INSERT INTO `sbw_admin_log` VALUES ('14508', 'admin', 'Userinfo', 'add_info', '', '1', '墨夜瞳', '2130706433', '1522397111');
INSERT INTO `sbw_admin_log` VALUES ('14509', 'admin', 'Userinfo', 'add_info', '', '1', '墨夜瞳', '2130706433', '1522397150');
INSERT INTO `sbw_admin_log` VALUES ('14510', 'admin', 'Shoperinfo', 'add', '', '1', '墨夜瞳', '2130706433', '1522397156');
INSERT INTO `sbw_admin_log` VALUES ('14511', 'admin', 'Index', 'index_mod', '', '1', '墨夜瞳', '2130706433', '1522398258');
INSERT INTO `sbw_admin_log` VALUES ('14512', 'admin', 'Menu', 'info', '?parentid=34', '1', '墨夜瞳', '2130706433', '1522398302');
INSERT INTO `sbw_admin_log` VALUES ('14513', 'admin', 'Menu', 'add', '', '1', '墨夜瞳', '2130706433', '1522398897');
INSERT INTO `sbw_admin_log` VALUES ('14514', 'admin', 'Menu', 'setlistorder', '', '1', '墨夜瞳', '2130706433', '1522398899');
INSERT INTO `sbw_admin_log` VALUES ('14515', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522398976');
INSERT INTO `sbw_admin_log` VALUES ('14516', 'admin', 'Menu', 'info', '?id=44', '1', '墨夜瞳', '2130706433', '1522398997');
INSERT INTO `sbw_admin_log` VALUES ('14517', 'admin', 'Menu', 'edit', '', '1', '墨夜瞳', '2130706433', '1522399007');
INSERT INTO `sbw_admin_log` VALUES ('14518', 'admin', 'Menu', 'info', '?id=44', '1', '墨夜瞳', '2130706433', '1522399022');
INSERT INTO `sbw_admin_log` VALUES ('14519', 'admin', 'Menu', 'info', '?parentid=44', '1', '墨夜瞳', '2130706433', '1522399034');
INSERT INTO `sbw_admin_log` VALUES ('14520', 'admin', 'Menu', 'add', '', '1', '墨夜瞳', '2130706433', '1522399050');
INSERT INTO `sbw_admin_log` VALUES ('14521', 'admin', 'Menu', 'setlistorder', '', '1', '墨夜瞳', '2130706433', '1522399054');
INSERT INTO `sbw_admin_log` VALUES ('14522', 'admin', 'Menu', 'info', '?id=47', '1', '墨夜瞳', '2130706433', '1522399086');
INSERT INTO `sbw_admin_log` VALUES ('14523', 'admin', 'Menu', 'edit', '', '1', '墨夜瞳', '2130706433', '1522399097');
INSERT INTO `sbw_admin_log` VALUES ('14524', 'admin', 'Menu', 'setlistorder', '', '1', '墨夜瞳', '2130706433', '1522399099');
INSERT INTO `sbw_admin_log` VALUES ('14525', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522399113');
INSERT INTO `sbw_admin_log` VALUES ('14526', 'admin', 'Userinfo', 'add_info', '', '1', '墨夜瞳', '2130706433', '1522399114');
INSERT INTO `sbw_admin_log` VALUES ('14527', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522399140');
INSERT INTO `sbw_admin_log` VALUES ('14528', 'admin', 'Product', 'send_stock_look', '', '1', '墨夜瞳', '2130706433', '1522399150');
INSERT INTO `sbw_admin_log` VALUES ('14529', 'admin', 'Product', 'index', '', '1', '墨夜瞳', '2130706433', '1522399156');
INSERT INTO `sbw_admin_log` VALUES ('14530', 'admin', 'Product', 'query_stock', '', '1', '墨夜瞳', '2130706433', '1522399172');
INSERT INTO `sbw_admin_log` VALUES ('14531', 'admin', 'Shoperinfo', 'add', '', '1', '墨夜瞳', '2130706433', '1522399207');
INSERT INTO `sbw_admin_log` VALUES ('14532', 'admin', 'Menu', 'info', '?id=51', '1', '墨夜瞳', '2130706433', '1522399797');
INSERT INTO `sbw_admin_log` VALUES ('14533', 'admin', 'Menu', 'edit', '', '1', '墨夜瞳', '2130706433', '1522399832');
INSERT INTO `sbw_admin_log` VALUES ('14534', 'admin', 'Menu', 'setlistorder', '', '1', '墨夜瞳', '2130706433', '1522399834');
INSERT INTO `sbw_admin_log` VALUES ('14535', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522399843');
INSERT INTO `sbw_admin_log` VALUES ('14536', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522403941');
INSERT INTO `sbw_admin_log` VALUES ('14537', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522403978');
INSERT INTO `sbw_admin_log` VALUES ('14538', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522404041');
INSERT INTO `sbw_admin_log` VALUES ('14539', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522404091');
INSERT INTO `sbw_admin_log` VALUES ('14540', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522404232');
INSERT INTO `sbw_admin_log` VALUES ('14541', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522495068');
INSERT INTO `sbw_admin_log` VALUES ('14542', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522495377');
INSERT INTO `sbw_admin_log` VALUES ('14543', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522495467');
INSERT INTO `sbw_admin_log` VALUES ('14544', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522495615');
INSERT INTO `sbw_admin_log` VALUES ('14545', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522495650');
INSERT INTO `sbw_admin_log` VALUES ('14546', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522495824');
INSERT INTO `sbw_admin_log` VALUES ('14547', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522495936');
INSERT INTO `sbw_admin_log` VALUES ('14548', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522495961');
INSERT INTO `sbw_admin_log` VALUES ('14549', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522496185');
INSERT INTO `sbw_admin_log` VALUES ('14550', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522496205');
INSERT INTO `sbw_admin_log` VALUES ('14551', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522496269');
INSERT INTO `sbw_admin_log` VALUES ('14552', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522496373');
INSERT INTO `sbw_admin_log` VALUES ('14553', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522496439');
INSERT INTO `sbw_admin_log` VALUES ('14554', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522496463');
INSERT INTO `sbw_admin_log` VALUES ('14555', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522496876');
INSERT INTO `sbw_admin_log` VALUES ('14556', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522496881');
INSERT INTO `sbw_admin_log` VALUES ('14557', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522496907');
INSERT INTO `sbw_admin_log` VALUES ('14558', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522496934');
INSERT INTO `sbw_admin_log` VALUES ('14559', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522496941');
INSERT INTO `sbw_admin_log` VALUES ('14560', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522496959');
INSERT INTO `sbw_admin_log` VALUES ('14561', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522496962');
INSERT INTO `sbw_admin_log` VALUES ('14562', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522496986');
INSERT INTO `sbw_admin_log` VALUES ('14563', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522496988');
INSERT INTO `sbw_admin_log` VALUES ('14564', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522496989');
INSERT INTO `sbw_admin_log` VALUES ('14565', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522497036');
INSERT INTO `sbw_admin_log` VALUES ('14566', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522497064');
INSERT INTO `sbw_admin_log` VALUES ('14567', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522497095');
INSERT INTO `sbw_admin_log` VALUES ('14568', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522497099');
INSERT INTO `sbw_admin_log` VALUES ('14569', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522497115');
INSERT INTO `sbw_admin_log` VALUES ('14570', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522497155');
INSERT INTO `sbw_admin_log` VALUES ('14571', 'admin', 'Product', 'query_stock', '', '2', '13311857969', '2130706433', '1522497291');
INSERT INTO `sbw_admin_log` VALUES ('14572', 'admin', 'Product', 'query_stock', '', '2', '13311857969', '2130706433', '1522497293');
INSERT INTO `sbw_admin_log` VALUES ('14573', 'admin', 'Shoperinfo', 'add', '', '2', '13311857969', '2130706433', '1522497294');
INSERT INTO `sbw_admin_log` VALUES ('14574', 'admin', 'Shoperinfo', 'index', '', '2', '13311857969', '2130706433', '1522497298');
INSERT INTO `sbw_admin_log` VALUES ('14575', 'admin', 'Shoperinfo', 'add', '', '2', '13311857969', '2130706433', '1522497313');
INSERT INTO `sbw_admin_log` VALUES ('14576', 'admin', 'Shoperinfo', 'index', '', '2', '13311857969', '2130706433', '1522497315');
INSERT INTO `sbw_admin_log` VALUES ('14577', 'admin', 'Product', 'query_stock', '', '2', '13311857969', '2130706433', '1522497316');
INSERT INTO `sbw_admin_log` VALUES ('14578', 'admin', 'Shoperinfo', 'index', '', '2', '13311857969', '2130706433', '1522497318');
INSERT INTO `sbw_admin_log` VALUES ('14579', 'admin', 'Product', 'query_stock', '', '2', '13311857969', '2130706433', '1522497320');
INSERT INTO `sbw_admin_log` VALUES ('14580', 'admin', 'Group', 'index', '', '1', '墨夜瞳', '2130706433', '1522497340');
INSERT INTO `sbw_admin_log` VALUES ('14581', 'admin', 'Group', 'rule', '?id=4', '1', '墨夜瞳', '2130706433', '1522497345');
INSERT INTO `sbw_admin_log` VALUES ('14582', 'admin', 'Group', 'editrule', '', '1', '墨夜瞳', '2130706433', '1522497355');
INSERT INTO `sbw_admin_log` VALUES ('14583', 'admin', 'Shoper', 'eavl_info', '', '2', '13311857969', '2130706433', '1522497372');
INSERT INTO `sbw_admin_log` VALUES ('14584', 'admin', 'Shoper', 'eavl_info', '', '2', '13311857969', '2130706433', '1522497415');
INSERT INTO `sbw_admin_log` VALUES ('14585', 'admin', 'Product', 'query_stock', '', '2', '13311857969', '2130706433', '1522497988');
INSERT INTO `sbw_admin_log` VALUES ('14586', 'admin', 'Shoper', 'eavl_info', '', '2', '13311857969', '2130706433', '1522497989');
INSERT INTO `sbw_admin_log` VALUES ('14587', 'admin', 'Shoper', 'eavl_info', '', '2', '13311857969', '2130706433', '1522498143');
INSERT INTO `sbw_admin_log` VALUES ('14588', 'admin', 'Shoper', 'eavl_info', '', '2', '13311857969', '2130706433', '1522498147');
INSERT INTO `sbw_admin_log` VALUES ('14589', 'admin', 'Shoper', 'eavl_info', '', '2', '13311857969', '2130706433', '1522498163');
INSERT INTO `sbw_admin_log` VALUES ('14590', 'admin', 'Shoper', 'eavl_info', '', '2', '13311857969', '2130706433', '1522498175');
INSERT INTO `sbw_admin_log` VALUES ('14591', 'admin', 'Shoper', 'eavl_info', '', '2', '13311857969', '2130706433', '1522498221');
INSERT INTO `sbw_admin_log` VALUES ('14592', 'admin', 'Shoper', 'eavl_info', '', '2', '13311857969', '2130706433', '1522498835');
INSERT INTO `sbw_admin_log` VALUES ('14593', 'admin', 'Shoper', 'eavl_add', '', '2', '13311857969', '2130706433', '1522498867');
INSERT INTO `sbw_admin_log` VALUES ('14594', 'admin', 'Shoper', 'eavl_add', '', '2', '13311857969', '2130706433', '1522498894');
INSERT INTO `sbw_admin_log` VALUES ('14595', 'admin', 'Shoper', 'eavl_add', '', '2', '13311857969', '2130706433', '1522498931');
INSERT INTO `sbw_admin_log` VALUES ('14596', 'admin', 'Shoper', 'eavl_add', '', '2', '13311857969', '2130706433', '1522498932');
INSERT INTO `sbw_admin_log` VALUES ('14597', 'admin', 'Shoper', 'eavl_add', '', '2', '13311857969', '2130706433', '1522498933');
INSERT INTO `sbw_admin_log` VALUES ('14598', 'admin', 'Shoper', 'eavl_add', '', '2', '13311857969', '2130706433', '1522498933');
INSERT INTO `sbw_admin_log` VALUES ('14599', 'admin', 'Shoper', 'eavl_add', '', '2', '13311857969', '2130706433', '1522498933');
INSERT INTO `sbw_admin_log` VALUES ('14600', 'admin', 'Shoper', 'eavl_add', '', '2', '13311857969', '2130706433', '1522498933');
INSERT INTO `sbw_admin_log` VALUES ('14601', 'admin', 'Shoper', 'eavl_add', '', '2', '13311857969', '2130706433', '1522498933');
INSERT INTO `sbw_admin_log` VALUES ('14602', 'admin', 'Shoper', 'eavl_add', '', '2', '13311857969', '2130706433', '1522498934');
INSERT INTO `sbw_admin_log` VALUES ('14603', 'admin', 'Shoper', 'eavl_add', '', '2', '13311857969', '2130706433', '1522498934');
INSERT INTO `sbw_admin_log` VALUES ('14604', 'admin', 'Shoper', 'eavl_add', '', '2', '13311857969', '2130706433', '1522498934');
INSERT INTO `sbw_admin_log` VALUES ('14605', 'admin', 'Shoper', 'eavl_add', '', '2', '13311857969', '2130706433', '1522498934');
INSERT INTO `sbw_admin_log` VALUES ('14606', 'admin', 'Shoper', 'eavl_add', '', '2', '13311857969', '2130706433', '1522498934');
INSERT INTO `sbw_admin_log` VALUES ('14607', 'admin', 'Shoper', 'eavl_info', '', '2', '13311857969', '2130706433', '1522499028');
INSERT INTO `sbw_admin_log` VALUES ('14608', 'admin', 'Shoper', 'eavl_info', '', '2', '13311857969', '2130706433', '1522499045');
INSERT INTO `sbw_admin_log` VALUES ('14609', 'admin', 'Shoper', 'eavl_info', '', '2', '13311857969', '2130706433', '1522499048');
INSERT INTO `sbw_admin_log` VALUES ('14610', 'admin', 'Shoper', 'eavl_info', '', '2', '13311857969', '2130706433', '1522499050');
INSERT INTO `sbw_admin_log` VALUES ('14611', 'admin', 'Shoper', 'eavl_info', '', '2', '13311857969', '2130706433', '1522499052');
INSERT INTO `sbw_admin_log` VALUES ('14612', 'admin', 'Shoper', 'eavl_info', '', '2', '13311857969', '2130706433', '1522499056');
INSERT INTO `sbw_admin_log` VALUES ('14613', 'admin', 'Shoper', 'eavl_info', '', '2', '13311857969', '2130706433', '1522499057');
INSERT INTO `sbw_admin_log` VALUES ('14614', 'admin', 'Shoper', 'eavl_add', '', '2', '13311857969', '2130706433', '1522499306');
INSERT INTO `sbw_admin_log` VALUES ('14615', 'admin', 'Shoper', 'eavl_add', '', '2', '13311857969', '2130706433', '1522499306');
INSERT INTO `sbw_admin_log` VALUES ('14616', 'admin', 'Shoper', 'eavl_add', '', '2', '13311857969', '2130706433', '1522499306');
INSERT INTO `sbw_admin_log` VALUES ('14617', 'admin', 'Shoper', 'eavl_add', '', '2', '13311857969', '2130706433', '1522499307');
INSERT INTO `sbw_admin_log` VALUES ('14618', 'admin', 'Shoper', 'eavl_add', '', '2', '13311857969', '2130706433', '1522499307');
INSERT INTO `sbw_admin_log` VALUES ('14619', 'admin', 'Shoper', 'eavl_add', '', '2', '13311857969', '2130706433', '1522499307');
INSERT INTO `sbw_admin_log` VALUES ('14620', 'admin', 'Shoper', 'eavl_add', '', '2', '13311857969', '2130706433', '1522499308');
INSERT INTO `sbw_admin_log` VALUES ('14621', 'admin', 'Shoper', 'eavl_add', '', '2', '13311857969', '2130706433', '1522499309');
INSERT INTO `sbw_admin_log` VALUES ('14622', 'admin', 'Shoper', 'eavl_add', '', '2', '13311857969', '2130706433', '1522499310');
INSERT INTO `sbw_admin_log` VALUES ('14623', 'admin', 'Shoper', 'eavl_add', '', '2', '13311857969', '2130706433', '1522499310');
INSERT INTO `sbw_admin_log` VALUES ('14624', 'admin', 'Shoper', 'eavl_add', '', '2', '13311857969', '2130706433', '1522499310');
INSERT INTO `sbw_admin_log` VALUES ('14625', 'admin', 'Shoper', 'eavl_add', '', '2', '13311857969', '2130706433', '1522499310');
INSERT INTO `sbw_admin_log` VALUES ('14626', 'admin', 'Shoper', 'eavl_add', '', '2', '13311857969', '2130706433', '1522499310');
INSERT INTO `sbw_admin_log` VALUES ('14627', 'admin', 'Shoper', 'eavl_add', '', '2', '13311857969', '2130706433', '1522499311');
INSERT INTO `sbw_admin_log` VALUES ('14628', 'admin', 'Shoper', 'eavl_info', '', '2', '13311857969', '2130706433', '1522499325');
INSERT INTO `sbw_admin_log` VALUES ('14629', 'admin', 'Shoper', 'eavl_info', '', '2', '13311857969', '2130706433', '1522499337');
INSERT INTO `sbw_admin_log` VALUES ('14630', 'admin', 'Shoper', 'eavl_info', '', '2', '13311857969', '2130706433', '1522499422');
INSERT INTO `sbw_admin_log` VALUES ('14631', 'admin', 'Product', 'query_stock', '', '2', '13311857969', '2130706433', '1522499434');
INSERT INTO `sbw_admin_log` VALUES ('14632', 'admin', 'Shoperinfo', 'add', '', '2', '13311857969', '2130706433', '1522499447');
INSERT INTO `sbw_admin_log` VALUES ('14633', 'admin', 'Shoper', 'eavl_info', '', '2', '13311857969', '2130706433', '1522499504');
INSERT INTO `sbw_admin_log` VALUES ('14634', 'admin', 'Shoperinfo', 'add', '', '2', '13311857969', '2130706433', '1522499506');
INSERT INTO `sbw_admin_log` VALUES ('14635', 'admin', 'Product', 'query_stock', '', '2', '13311857969', '2130706433', '1522499510');
INSERT INTO `sbw_admin_log` VALUES ('14636', 'admin', 'Product', 'query_stock', '', '2', '13311857969', '2130706433', '1522499527');
INSERT INTO `sbw_admin_log` VALUES ('14637', 'admin', 'Shoperinfo', 'add', '', '1', '墨夜瞳', '2130706433', '1522499957');
INSERT INTO `sbw_admin_log` VALUES ('14638', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522499968');
INSERT INTO `sbw_admin_log` VALUES ('14639', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522499971');
INSERT INTO `sbw_admin_log` VALUES ('14640', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522499972');
INSERT INTO `sbw_admin_log` VALUES ('14641', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522499977');
INSERT INTO `sbw_admin_log` VALUES ('14642', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522499986');
INSERT INTO `sbw_admin_log` VALUES ('14643', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522499992');
INSERT INTO `sbw_admin_log` VALUES ('14644', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522499994');
INSERT INTO `sbw_admin_log` VALUES ('14645', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522499995');
INSERT INTO `sbw_admin_log` VALUES ('14646', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522499996');
INSERT INTO `sbw_admin_log` VALUES ('14647', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522499997');
INSERT INTO `sbw_admin_log` VALUES ('14648', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522499997');
INSERT INTO `sbw_admin_log` VALUES ('14649', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522499998');
INSERT INTO `sbw_admin_log` VALUES ('14650', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522500001');
INSERT INTO `sbw_admin_log` VALUES ('14651', 'admin', 'Admin', 'index', '', '1', '墨夜瞳', '2130706433', '1522500024');
INSERT INTO `sbw_admin_log` VALUES ('14652', 'admin', 'Admin', 'index', '', '1', '墨夜瞳', '2130706433', '1522500028');
INSERT INTO `sbw_admin_log` VALUES ('14653', 'admin', 'Product', 'send_stock_look', '', '4', '供销商', '2130706433', '1522500051');
INSERT INTO `sbw_admin_log` VALUES ('14654', 'admin', 'Index', 'index_mod', '', '1', '墨夜瞳', '2130706433', '1522500119');
INSERT INTO `sbw_admin_log` VALUES ('14655', 'admin', 'Product', 'send_stock_look', '', '4', '供销商', '2130706433', '1522500142');
INSERT INTO `sbw_admin_log` VALUES ('14656', 'admin', 'Product', 'index', '', '4', '供销商', '2130706433', '1522500143');
INSERT INTO `sbw_admin_log` VALUES ('14657', 'admin', 'Index', 'index_mod', '', '1', '墨夜瞳', '2130706433', '1522502516');
INSERT INTO `sbw_admin_log` VALUES ('14658', 'admin', 'Index', 'index_mod', '', '1', '墨夜瞳', '2130706433', '1522502583');
INSERT INTO `sbw_admin_log` VALUES ('14659', 'admin', 'Index', 'index_mod', '', '1', '墨夜瞳', '2130706433', '1522502654');
INSERT INTO `sbw_admin_log` VALUES ('14660', 'admin', 'Index', 'index_mod', '', '1', '墨夜瞳', '2130706433', '1522502674');
INSERT INTO `sbw_admin_log` VALUES ('14661', 'admin', 'Index', 'index_mod', '', '1', '墨夜瞳', '2130706433', '1522503244');
INSERT INTO `sbw_admin_log` VALUES ('14662', 'admin', 'Index', 'index_mod', '', '1', '墨夜瞳', '2130706433', '1522503280');
INSERT INTO `sbw_admin_log` VALUES ('14663', 'admin', 'Index', 'index_mod', '', '1', '墨夜瞳', '2130706433', '1522503420');
INSERT INTO `sbw_admin_log` VALUES ('14664', 'admin', 'Index', 'index_mod', '', '1', '墨夜瞳', '2130706433', '1522506307');
INSERT INTO `sbw_admin_log` VALUES ('14665', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522506312');
INSERT INTO `sbw_admin_log` VALUES ('14666', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522506672');
INSERT INTO `sbw_admin_log` VALUES ('14667', 'admin', 'Index', 'index_mod', '', '1', '墨夜瞳', '2130706433', '1522506798');
INSERT INTO `sbw_admin_log` VALUES ('14668', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522506804');
INSERT INTO `sbw_admin_log` VALUES ('14669', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522506808');
INSERT INTO `sbw_admin_log` VALUES ('14670', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522506812');
INSERT INTO `sbw_admin_log` VALUES ('14671', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522506814');
INSERT INTO `sbw_admin_log` VALUES ('14672', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522506815');
INSERT INTO `sbw_admin_log` VALUES ('14673', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522506816');
INSERT INTO `sbw_admin_log` VALUES ('14674', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522506819');
INSERT INTO `sbw_admin_log` VALUES ('14675', 'admin', 'Index', 'index_mod', '', '1', '墨夜瞳', '2130706433', '1522506867');
INSERT INTO `sbw_admin_log` VALUES ('14676', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522506874');
INSERT INTO `sbw_admin_log` VALUES ('14677', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522506877');
INSERT INTO `sbw_admin_log` VALUES ('14678', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522506946');
INSERT INTO `sbw_admin_log` VALUES ('14679', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522506951');
INSERT INTO `sbw_admin_log` VALUES ('14680', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522506953');
INSERT INTO `sbw_admin_log` VALUES ('14681', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522506954');
INSERT INTO `sbw_admin_log` VALUES ('14682', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522506956');
INSERT INTO `sbw_admin_log` VALUES ('14683', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522506975');
INSERT INTO `sbw_admin_log` VALUES ('14684', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522506979');
INSERT INTO `sbw_admin_log` VALUES ('14685', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522506983');
INSERT INTO `sbw_admin_log` VALUES ('14686', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522506986');
INSERT INTO `sbw_admin_log` VALUES ('14687', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522506987');
INSERT INTO `sbw_admin_log` VALUES ('14688', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522507021');
INSERT INTO `sbw_admin_log` VALUES ('14689', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522507125');
INSERT INTO `sbw_admin_log` VALUES ('14690', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522507130');
INSERT INTO `sbw_admin_log` VALUES ('14691', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522507131');
INSERT INTO `sbw_admin_log` VALUES ('14692', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522507132');
INSERT INTO `sbw_admin_log` VALUES ('14693', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522507134');
INSERT INTO `sbw_admin_log` VALUES ('14694', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522507135');
INSERT INTO `sbw_admin_log` VALUES ('14695', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522507254');
INSERT INTO `sbw_admin_log` VALUES ('14696', 'admin', 'Index', 'index_mod', '', '1', '墨夜瞳', '2130706433', '1522507271');
INSERT INTO `sbw_admin_log` VALUES ('14697', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522507279');
INSERT INTO `sbw_admin_log` VALUES ('14698', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522507291');
INSERT INTO `sbw_admin_log` VALUES ('14699', 'admin', 'Index', 'index_mod', '', '1', '墨夜瞳', '2130706433', '1522507325');
INSERT INTO `sbw_admin_log` VALUES ('14700', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522507328');
INSERT INTO `sbw_admin_log` VALUES ('14701', 'admin', 'Index', 'index_mod', '', '1', '墨夜瞳', '2130706433', '1522507360');
INSERT INTO `sbw_admin_log` VALUES ('14702', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522507365');
INSERT INTO `sbw_admin_log` VALUES ('14703', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522507533');
INSERT INTO `sbw_admin_log` VALUES ('14704', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522507540');
INSERT INTO `sbw_admin_log` VALUES ('14705', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522507543');
INSERT INTO `sbw_admin_log` VALUES ('14706', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522507546');
INSERT INTO `sbw_admin_log` VALUES ('14707', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522507548');
INSERT INTO `sbw_admin_log` VALUES ('14708', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522507581');
INSERT INTO `sbw_admin_log` VALUES ('14709', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522507583');
INSERT INTO `sbw_admin_log` VALUES ('14710', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522507584');
INSERT INTO `sbw_admin_log` VALUES ('14711', 'admin', 'Userinfo', 'index', '', '1', '墨夜瞳', '2130706433', '1522507585');
INSERT INTO `sbw_admin_log` VALUES ('14712', 'admin', 'Index', 'index_mod', '', '1', '墨夜瞳', '2130706433', '1522507660');
INSERT INTO `sbw_admin_log` VALUES ('14713', 'admin', 'Product', 'index', '', '1', '墨夜瞳', '2130706433', '1522507756');
INSERT INTO `sbw_admin_log` VALUES ('14714', 'admin', 'Product', 'send_stock_look', '', '1', '墨夜瞳', '2130706433', '1522507817');
INSERT INTO `sbw_admin_log` VALUES ('14715', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522507821');
INSERT INTO `sbw_admin_log` VALUES ('14716', 'admin', 'Shoper', 'info_pic', '', '1', '墨夜瞳', '2130706433', '1522507824');
INSERT INTO `sbw_admin_log` VALUES ('14717', 'admin', 'Index', 'index_mod', '', '1', '墨夜瞳', '2130706433', '1522507936');
INSERT INTO `sbw_admin_log` VALUES ('14718', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522507941');
INSERT INTO `sbw_admin_log` VALUES ('14719', 'admin', 'Index', 'index_mod', '', '1', '墨夜瞳', '2130706433', '1522507983');
INSERT INTO `sbw_admin_log` VALUES ('14720', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522507990');
INSERT INTO `sbw_admin_log` VALUES ('14721', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522508135');
INSERT INTO `sbw_admin_log` VALUES ('14722', 'admin', 'Index', 'index_mod', '', '1', '墨夜瞳', '2130706433', '1522508153');
INSERT INTO `sbw_admin_log` VALUES ('14723', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522508158');
INSERT INTO `sbw_admin_log` VALUES ('14724', 'admin', 'Index', 'index_mod', '', '1', '墨夜瞳', '2130706433', '1522508186');
INSERT INTO `sbw_admin_log` VALUES ('14725', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522508190');
INSERT INTO `sbw_admin_log` VALUES ('14726', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522508236');
INSERT INTO `sbw_admin_log` VALUES ('14727', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522508431');
INSERT INTO `sbw_admin_log` VALUES ('14728', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522508434');
INSERT INTO `sbw_admin_log` VALUES ('14729', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522508435');
INSERT INTO `sbw_admin_log` VALUES ('14730', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522508436');
INSERT INTO `sbw_admin_log` VALUES ('14731', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522508436');
INSERT INTO `sbw_admin_log` VALUES ('14732', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522508436');
INSERT INTO `sbw_admin_log` VALUES ('14733', 'admin', 'Index', 'index_mod', '', '1', '墨夜瞳', '2130706433', '1522508639');
INSERT INTO `sbw_admin_log` VALUES ('14734', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522508657');
INSERT INTO `sbw_admin_log` VALUES ('14735', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522508660');
INSERT INTO `sbw_admin_log` VALUES ('14736', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522508661');
INSERT INTO `sbw_admin_log` VALUES ('14737', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522508662');
INSERT INTO `sbw_admin_log` VALUES ('14738', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522508662');
INSERT INTO `sbw_admin_log` VALUES ('14739', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522508664');
INSERT INTO `sbw_admin_log` VALUES ('14740', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522508665');
INSERT INTO `sbw_admin_log` VALUES ('14741', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522508666');
INSERT INTO `sbw_admin_log` VALUES ('14742', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522508667');
INSERT INTO `sbw_admin_log` VALUES ('14743', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522508668');
INSERT INTO `sbw_admin_log` VALUES ('14744', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522508670');
INSERT INTO `sbw_admin_log` VALUES ('14745', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522509291');
INSERT INTO `sbw_admin_log` VALUES ('14746', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522509332');
INSERT INTO `sbw_admin_log` VALUES ('14747', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522509569');
INSERT INTO `sbw_admin_log` VALUES ('14748', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522509627');
INSERT INTO `sbw_admin_log` VALUES ('14749', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522510087');
INSERT INTO `sbw_admin_log` VALUES ('14750', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522510173');
INSERT INTO `sbw_admin_log` VALUES ('14751', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522510205');
INSERT INTO `sbw_admin_log` VALUES ('14752', 'admin', 'Index', 'index_mod', '', '1', '墨夜瞳', '2130706433', '1522510272');
INSERT INTO `sbw_admin_log` VALUES ('14753', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522510276');
INSERT INTO `sbw_admin_log` VALUES ('14754', 'admin', 'Product', 'index', '', '1', '墨夜瞳', '2130706433', '1522510295');
INSERT INTO `sbw_admin_log` VALUES ('14755', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522510305');
INSERT INTO `sbw_admin_log` VALUES ('14756', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522510312');
INSERT INTO `sbw_admin_log` VALUES ('14757', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522510338');
INSERT INTO `sbw_admin_log` VALUES ('14758', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522510344');
INSERT INTO `sbw_admin_log` VALUES ('14759', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522510382');
INSERT INTO `sbw_admin_log` VALUES ('14760', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522510386');
INSERT INTO `sbw_admin_log` VALUES ('14761', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522510409');
INSERT INTO `sbw_admin_log` VALUES ('14762', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522510412');
INSERT INTO `sbw_admin_log` VALUES ('14763', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522510414');
INSERT INTO `sbw_admin_log` VALUES ('14764', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522510424');
INSERT INTO `sbw_admin_log` VALUES ('14765', 'admin', 'Index', 'index_mod', '', '1', '墨夜瞳', '2130706433', '1522510450');
INSERT INTO `sbw_admin_log` VALUES ('14766', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522510456');
INSERT INTO `sbw_admin_log` VALUES ('14767', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522510475');
INSERT INTO `sbw_admin_log` VALUES ('14768', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522510476');
INSERT INTO `sbw_admin_log` VALUES ('14769', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522510481');
INSERT INTO `sbw_admin_log` VALUES ('14770', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522510490');
INSERT INTO `sbw_admin_log` VALUES ('14771', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522510497');
INSERT INTO `sbw_admin_log` VALUES ('14772', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522510498');
INSERT INTO `sbw_admin_log` VALUES ('14773', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522510510');
INSERT INTO `sbw_admin_log` VALUES ('14774', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522510512');
INSERT INTO `sbw_admin_log` VALUES ('14775', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522510798');
INSERT INTO `sbw_admin_log` VALUES ('14776', 'admin', 'Index', 'index_mod', '', '1', '墨夜瞳', '2130706433', '1522510834');
INSERT INTO `sbw_admin_log` VALUES ('14777', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522510848');
INSERT INTO `sbw_admin_log` VALUES ('14778', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522510969');
INSERT INTO `sbw_admin_log` VALUES ('14779', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511042');
INSERT INTO `sbw_admin_log` VALUES ('14780', 'admin', 'Index', 'index_mod', '', '1', '墨夜瞳', '2130706433', '1522511073');
INSERT INTO `sbw_admin_log` VALUES ('14781', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511076');
INSERT INTO `sbw_admin_log` VALUES ('14782', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511411');
INSERT INTO `sbw_admin_log` VALUES ('14783', 'admin', 'Index', 'index_mod', '', '1', '墨夜瞳', '2130706433', '1522511416');
INSERT INTO `sbw_admin_log` VALUES ('14784', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511441');
INSERT INTO `sbw_admin_log` VALUES ('14785', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511503');
INSERT INTO `sbw_admin_log` VALUES ('14786', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511561');
INSERT INTO `sbw_admin_log` VALUES ('14787', 'admin', 'Index', 'index_mod', '', '1', '墨夜瞳', '2130706433', '1522511563');
INSERT INTO `sbw_admin_log` VALUES ('14788', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511566');
INSERT INTO `sbw_admin_log` VALUES ('14789', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511600');
INSERT INTO `sbw_admin_log` VALUES ('14790', 'admin', 'Index', 'index_mod', '', '1', '墨夜瞳', '2130706433', '1522511628');
INSERT INTO `sbw_admin_log` VALUES ('14791', 'admin', 'Index', 'index_mod', '', '1', '墨夜瞳', '2130706433', '1522511633');
INSERT INTO `sbw_admin_log` VALUES ('14792', 'admin', 'Index', 'index_mod', '', '1', '墨夜瞳', '2130706433', '1522511635');
INSERT INTO `sbw_admin_log` VALUES ('14793', 'admin', 'Index', 'index_mod', '', '1', '墨夜瞳', '2130706433', '1522511636');
INSERT INTO `sbw_admin_log` VALUES ('14794', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511639');
INSERT INTO `sbw_admin_log` VALUES ('14795', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511691');
INSERT INTO `sbw_admin_log` VALUES ('14796', 'admin', 'Index', 'index_mod', '', '1', '墨夜瞳', '2130706433', '1522511694');
INSERT INTO `sbw_admin_log` VALUES ('14797', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511697');
INSERT INTO `sbw_admin_log` VALUES ('14798', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511731');
INSERT INTO `sbw_admin_log` VALUES ('14799', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511778');
INSERT INTO `sbw_admin_log` VALUES ('14800', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511780');
INSERT INTO `sbw_admin_log` VALUES ('14801', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511782');
INSERT INTO `sbw_admin_log` VALUES ('14802', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511783');
INSERT INTO `sbw_admin_log` VALUES ('14803', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511785');
INSERT INTO `sbw_admin_log` VALUES ('14804', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511787');
INSERT INTO `sbw_admin_log` VALUES ('14805', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511789');
INSERT INTO `sbw_admin_log` VALUES ('14806', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511791');
INSERT INTO `sbw_admin_log` VALUES ('14807', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511793');
INSERT INTO `sbw_admin_log` VALUES ('14808', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511794');
INSERT INTO `sbw_admin_log` VALUES ('14809', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511796');
INSERT INTO `sbw_admin_log` VALUES ('14810', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511797');
INSERT INTO `sbw_admin_log` VALUES ('14811', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511797');
INSERT INTO `sbw_admin_log` VALUES ('14812', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511798');
INSERT INTO `sbw_admin_log` VALUES ('14813', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511799');
INSERT INTO `sbw_admin_log` VALUES ('14814', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511801');
INSERT INTO `sbw_admin_log` VALUES ('14815', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511805');
INSERT INTO `sbw_admin_log` VALUES ('14816', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511842');
INSERT INTO `sbw_admin_log` VALUES ('14817', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511868');
INSERT INTO `sbw_admin_log` VALUES ('14818', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511870');
INSERT INTO `sbw_admin_log` VALUES ('14819', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511872');
INSERT INTO `sbw_admin_log` VALUES ('14820', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511874');
INSERT INTO `sbw_admin_log` VALUES ('14821', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511893');
INSERT INTO `sbw_admin_log` VALUES ('14822', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511919');
INSERT INTO `sbw_admin_log` VALUES ('14823', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511923');
INSERT INTO `sbw_admin_log` VALUES ('14824', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511937');
INSERT INTO `sbw_admin_log` VALUES ('14825', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511942');
INSERT INTO `sbw_admin_log` VALUES ('14826', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511944');
INSERT INTO `sbw_admin_log` VALUES ('14827', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511945');
INSERT INTO `sbw_admin_log` VALUES ('14828', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511946');
INSERT INTO `sbw_admin_log` VALUES ('14829', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511948');
INSERT INTO `sbw_admin_log` VALUES ('14830', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511953');
INSERT INTO `sbw_admin_log` VALUES ('14831', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511960');
INSERT INTO `sbw_admin_log` VALUES ('14832', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511963');
INSERT INTO `sbw_admin_log` VALUES ('14833', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511973');
INSERT INTO `sbw_admin_log` VALUES ('14834', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511975');
INSERT INTO `sbw_admin_log` VALUES ('14835', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511985');
INSERT INTO `sbw_admin_log` VALUES ('14836', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511987');
INSERT INTO `sbw_admin_log` VALUES ('14837', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511988');
INSERT INTO `sbw_admin_log` VALUES ('14838', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511989');
INSERT INTO `sbw_admin_log` VALUES ('14839', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511990');
INSERT INTO `sbw_admin_log` VALUES ('14840', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511992');
INSERT INTO `sbw_admin_log` VALUES ('14841', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511994');
INSERT INTO `sbw_admin_log` VALUES ('14842', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522511995');
INSERT INTO `sbw_admin_log` VALUES ('14843', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512051');
INSERT INTO `sbw_admin_log` VALUES ('14844', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512056');
INSERT INTO `sbw_admin_log` VALUES ('14845', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512059');
INSERT INTO `sbw_admin_log` VALUES ('14846', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512066');
INSERT INTO `sbw_admin_log` VALUES ('14847', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512068');
INSERT INTO `sbw_admin_log` VALUES ('14848', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512070');
INSERT INTO `sbw_admin_log` VALUES ('14849', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512152');
INSERT INTO `sbw_admin_log` VALUES ('14850', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512203');
INSERT INTO `sbw_admin_log` VALUES ('14851', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512206');
INSERT INTO `sbw_admin_log` VALUES ('14852', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512210');
INSERT INTO `sbw_admin_log` VALUES ('14853', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512212');
INSERT INTO `sbw_admin_log` VALUES ('14854', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512214');
INSERT INTO `sbw_admin_log` VALUES ('14855', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512219');
INSERT INTO `sbw_admin_log` VALUES ('14856', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512234');
INSERT INTO `sbw_admin_log` VALUES ('14857', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512236');
INSERT INTO `sbw_admin_log` VALUES ('14858', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512241');
INSERT INTO `sbw_admin_log` VALUES ('14859', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512244');
INSERT INTO `sbw_admin_log` VALUES ('14860', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512258');
INSERT INTO `sbw_admin_log` VALUES ('14861', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512260');
INSERT INTO `sbw_admin_log` VALUES ('14862', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512262');
INSERT INTO `sbw_admin_log` VALUES ('14863', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512263');
INSERT INTO `sbw_admin_log` VALUES ('14864', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512265');
INSERT INTO `sbw_admin_log` VALUES ('14865', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512270');
INSERT INTO `sbw_admin_log` VALUES ('14866', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512341');
INSERT INTO `sbw_admin_log` VALUES ('14867', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512343');
INSERT INTO `sbw_admin_log` VALUES ('14868', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512344');
INSERT INTO `sbw_admin_log` VALUES ('14869', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512345');
INSERT INTO `sbw_admin_log` VALUES ('14870', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512346');
INSERT INTO `sbw_admin_log` VALUES ('14871', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512347');
INSERT INTO `sbw_admin_log` VALUES ('14872', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512348');
INSERT INTO `sbw_admin_log` VALUES ('14873', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512349');
INSERT INTO `sbw_admin_log` VALUES ('14874', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512350');
INSERT INTO `sbw_admin_log` VALUES ('14875', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512352');
INSERT INTO `sbw_admin_log` VALUES ('14876', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512352');
INSERT INTO `sbw_admin_log` VALUES ('14877', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512353');
INSERT INTO `sbw_admin_log` VALUES ('14878', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512354');
INSERT INTO `sbw_admin_log` VALUES ('14879', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512355');
INSERT INTO `sbw_admin_log` VALUES ('14880', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512374');
INSERT INTO `sbw_admin_log` VALUES ('14881', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512391');
INSERT INTO `sbw_admin_log` VALUES ('14882', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512393');
INSERT INTO `sbw_admin_log` VALUES ('14883', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512409');
INSERT INTO `sbw_admin_log` VALUES ('14884', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512411');
INSERT INTO `sbw_admin_log` VALUES ('14885', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512440');
INSERT INTO `sbw_admin_log` VALUES ('14886', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512442');
INSERT INTO `sbw_admin_log` VALUES ('14887', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512464');
INSERT INTO `sbw_admin_log` VALUES ('14888', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512465');
INSERT INTO `sbw_admin_log` VALUES ('14889', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512466');
INSERT INTO `sbw_admin_log` VALUES ('14890', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512489');
INSERT INTO `sbw_admin_log` VALUES ('14891', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512492');
INSERT INTO `sbw_admin_log` VALUES ('14892', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512494');
INSERT INTO `sbw_admin_log` VALUES ('14893', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512495');
INSERT INTO `sbw_admin_log` VALUES ('14894', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512497');
INSERT INTO `sbw_admin_log` VALUES ('14895', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512526');
INSERT INTO `sbw_admin_log` VALUES ('14896', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512559');
INSERT INTO `sbw_admin_log` VALUES ('14897', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512561');
INSERT INTO `sbw_admin_log` VALUES ('14898', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512563');
INSERT INTO `sbw_admin_log` VALUES ('14899', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512564');
INSERT INTO `sbw_admin_log` VALUES ('14900', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512566');
INSERT INTO `sbw_admin_log` VALUES ('14901', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512583');
INSERT INTO `sbw_admin_log` VALUES ('14902', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512585');
INSERT INTO `sbw_admin_log` VALUES ('14903', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512587');
INSERT INTO `sbw_admin_log` VALUES ('14904', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512588');
INSERT INTO `sbw_admin_log` VALUES ('14905', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512656');
INSERT INTO `sbw_admin_log` VALUES ('14906', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512658');
INSERT INTO `sbw_admin_log` VALUES ('14907', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512659');
INSERT INTO `sbw_admin_log` VALUES ('14908', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512660');
INSERT INTO `sbw_admin_log` VALUES ('14909', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512663');
INSERT INTO `sbw_admin_log` VALUES ('14910', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512677');
INSERT INTO `sbw_admin_log` VALUES ('14911', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512717');
INSERT INTO `sbw_admin_log` VALUES ('14912', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512766');
INSERT INTO `sbw_admin_log` VALUES ('14913', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512777');
INSERT INTO `sbw_admin_log` VALUES ('14914', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512779');
INSERT INTO `sbw_admin_log` VALUES ('14915', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512780');
INSERT INTO `sbw_admin_log` VALUES ('14916', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512782');
INSERT INTO `sbw_admin_log` VALUES ('14917', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512783');
INSERT INTO `sbw_admin_log` VALUES ('14918', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512784');
INSERT INTO `sbw_admin_log` VALUES ('14919', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512785');
INSERT INTO `sbw_admin_log` VALUES ('14920', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512786');
INSERT INTO `sbw_admin_log` VALUES ('14921', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512787');
INSERT INTO `sbw_admin_log` VALUES ('14922', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512787');
INSERT INTO `sbw_admin_log` VALUES ('14923', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512788');
INSERT INTO `sbw_admin_log` VALUES ('14924', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512790');
INSERT INTO `sbw_admin_log` VALUES ('14925', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512790');
INSERT INTO `sbw_admin_log` VALUES ('14926', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512792');
INSERT INTO `sbw_admin_log` VALUES ('14927', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522512792');
INSERT INTO `sbw_admin_log` VALUES ('14928', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513229');
INSERT INTO `sbw_admin_log` VALUES ('14929', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513246');
INSERT INTO `sbw_admin_log` VALUES ('14930', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513248');
INSERT INTO `sbw_admin_log` VALUES ('14931', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513249');
INSERT INTO `sbw_admin_log` VALUES ('14932', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513250');
INSERT INTO `sbw_admin_log` VALUES ('14933', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513262');
INSERT INTO `sbw_admin_log` VALUES ('14934', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513263');
INSERT INTO `sbw_admin_log` VALUES ('14935', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513265');
INSERT INTO `sbw_admin_log` VALUES ('14936', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513266');
INSERT INTO `sbw_admin_log` VALUES ('14937', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513267');
INSERT INTO `sbw_admin_log` VALUES ('14938', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513268');
INSERT INTO `sbw_admin_log` VALUES ('14939', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513270');
INSERT INTO `sbw_admin_log` VALUES ('14940', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513271');
INSERT INTO `sbw_admin_log` VALUES ('14941', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513272');
INSERT INTO `sbw_admin_log` VALUES ('14942', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513288');
INSERT INTO `sbw_admin_log` VALUES ('14943', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513289');
INSERT INTO `sbw_admin_log` VALUES ('14944', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513290');
INSERT INTO `sbw_admin_log` VALUES ('14945', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513291');
INSERT INTO `sbw_admin_log` VALUES ('14946', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513293');
INSERT INTO `sbw_admin_log` VALUES ('14947', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513294');
INSERT INTO `sbw_admin_log` VALUES ('14948', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513298');
INSERT INTO `sbw_admin_log` VALUES ('14949', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513375');
INSERT INTO `sbw_admin_log` VALUES ('14950', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513376');
INSERT INTO `sbw_admin_log` VALUES ('14951', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513378');
INSERT INTO `sbw_admin_log` VALUES ('14952', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513379');
INSERT INTO `sbw_admin_log` VALUES ('14953', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513380');
INSERT INTO `sbw_admin_log` VALUES ('14954', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513381');
INSERT INTO `sbw_admin_log` VALUES ('14955', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513382');
INSERT INTO `sbw_admin_log` VALUES ('14956', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513383');
INSERT INTO `sbw_admin_log` VALUES ('14957', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513384');
INSERT INTO `sbw_admin_log` VALUES ('14958', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513385');
INSERT INTO `sbw_admin_log` VALUES ('14959', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513386');
INSERT INTO `sbw_admin_log` VALUES ('14960', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513408');
INSERT INTO `sbw_admin_log` VALUES ('14961', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513409');
INSERT INTO `sbw_admin_log` VALUES ('14962', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513410');
INSERT INTO `sbw_admin_log` VALUES ('14963', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513411');
INSERT INTO `sbw_admin_log` VALUES ('14964', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513412');
INSERT INTO `sbw_admin_log` VALUES ('14965', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513413');
INSERT INTO `sbw_admin_log` VALUES ('14966', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513533');
INSERT INTO `sbw_admin_log` VALUES ('14967', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513535');
INSERT INTO `sbw_admin_log` VALUES ('14968', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513537');
INSERT INTO `sbw_admin_log` VALUES ('14969', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513537');
INSERT INTO `sbw_admin_log` VALUES ('14970', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513539');
INSERT INTO `sbw_admin_log` VALUES ('14971', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513559');
INSERT INTO `sbw_admin_log` VALUES ('14972', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513560');
INSERT INTO `sbw_admin_log` VALUES ('14973', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513561');
INSERT INTO `sbw_admin_log` VALUES ('14974', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513562');
INSERT INTO `sbw_admin_log` VALUES ('14975', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513563');
INSERT INTO `sbw_admin_log` VALUES ('14976', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513591');
INSERT INTO `sbw_admin_log` VALUES ('14977', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513593');
INSERT INTO `sbw_admin_log` VALUES ('14978', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513595');
INSERT INTO `sbw_admin_log` VALUES ('14979', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513597');
INSERT INTO `sbw_admin_log` VALUES ('14980', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513600');
INSERT INTO `sbw_admin_log` VALUES ('14981', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513601');
INSERT INTO `sbw_admin_log` VALUES ('14982', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513615');
INSERT INTO `sbw_admin_log` VALUES ('14983', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513617');
INSERT INTO `sbw_admin_log` VALUES ('14984', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513617');
INSERT INTO `sbw_admin_log` VALUES ('14985', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513618');
INSERT INTO `sbw_admin_log` VALUES ('14986', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513620');
INSERT INTO `sbw_admin_log` VALUES ('14987', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513632');
INSERT INTO `sbw_admin_log` VALUES ('14988', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513634');
INSERT INTO `sbw_admin_log` VALUES ('14989', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513634');
INSERT INTO `sbw_admin_log` VALUES ('14990', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513635');
INSERT INTO `sbw_admin_log` VALUES ('14991', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513636');
INSERT INTO `sbw_admin_log` VALUES ('14992', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513690');
INSERT INTO `sbw_admin_log` VALUES ('14993', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513692');
INSERT INTO `sbw_admin_log` VALUES ('14994', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513692');
INSERT INTO `sbw_admin_log` VALUES ('14995', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513693');
INSERT INTO `sbw_admin_log` VALUES ('14996', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513694');
INSERT INTO `sbw_admin_log` VALUES ('14997', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513733');
INSERT INTO `sbw_admin_log` VALUES ('14998', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513735');
INSERT INTO `sbw_admin_log` VALUES ('14999', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513735');
INSERT INTO `sbw_admin_log` VALUES ('15000', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513736');
INSERT INTO `sbw_admin_log` VALUES ('15001', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513737');
INSERT INTO `sbw_admin_log` VALUES ('15002', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513738');
INSERT INTO `sbw_admin_log` VALUES ('15003', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513739');
INSERT INTO `sbw_admin_log` VALUES ('15004', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513741');
INSERT INTO `sbw_admin_log` VALUES ('15005', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513744');
INSERT INTO `sbw_admin_log` VALUES ('15006', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513752');
INSERT INTO `sbw_admin_log` VALUES ('15007', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513754');
INSERT INTO `sbw_admin_log` VALUES ('15008', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513755');
INSERT INTO `sbw_admin_log` VALUES ('15009', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513755');
INSERT INTO `sbw_admin_log` VALUES ('15010', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513756');
INSERT INTO `sbw_admin_log` VALUES ('15011', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513760');
INSERT INTO `sbw_admin_log` VALUES ('15012', 'admin', 'Index', 'index_mod', '', '1', '墨夜瞳', '2130706433', '1522513830');
INSERT INTO `sbw_admin_log` VALUES ('15013', 'admin', 'Shoper', 'eavl_info', '', '1', '墨夜瞳', '2130706433', '1522513833');
INSERT INTO `sbw_admin_log` VALUES ('15014', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522513853');
INSERT INTO `sbw_admin_log` VALUES ('15015', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522513858');
INSERT INTO `sbw_admin_log` VALUES ('15016', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522513861');
INSERT INTO `sbw_admin_log` VALUES ('15017', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522513862');
INSERT INTO `sbw_admin_log` VALUES ('15018', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522513862');
INSERT INTO `sbw_admin_log` VALUES ('15019', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522513875');
INSERT INTO `sbw_admin_log` VALUES ('15020', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522513955');
INSERT INTO `sbw_admin_log` VALUES ('15021', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522513959');
INSERT INTO `sbw_admin_log` VALUES ('15022', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522513960');
INSERT INTO `sbw_admin_log` VALUES ('15023', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522513960');
INSERT INTO `sbw_admin_log` VALUES ('15024', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522513960');
INSERT INTO `sbw_admin_log` VALUES ('15025', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522514004');
INSERT INTO `sbw_admin_log` VALUES ('15026', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522514008');
INSERT INTO `sbw_admin_log` VALUES ('15027', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522514009');
INSERT INTO `sbw_admin_log` VALUES ('15028', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522514011');
INSERT INTO `sbw_admin_log` VALUES ('15029', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522514012');
INSERT INTO `sbw_admin_log` VALUES ('15030', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522514047');
INSERT INTO `sbw_admin_log` VALUES ('15031', 'admin', 'Shoper', 'index', '', '1', '墨夜瞳', '2130706433', '1522514049');
INSERT INTO `sbw_admin_log` VALUES ('15032', 'admin', 'Product', 'index', '', '1', '墨夜瞳', '2130706433', '1522514410');
INSERT INTO `sbw_admin_log` VALUES ('15033', 'admin', 'Product', 'send_stock_look', '', '1', '墨夜瞳', '2130706433', '1522514411');
INSERT INTO `sbw_admin_log` VALUES ('15034', 'admin', 'Index', 'index_mod', '', '1', '墨夜瞳', '2130706433', '1522514421');
INSERT INTO `sbw_admin_log` VALUES ('15035', 'admin', 'Product', 'send_stock_look', '', '1', '墨夜瞳', '2130706433', '1522514428');

-- ----------------------------
-- Table structure for sbw_app
-- ----------------------------
DROP TABLE IF EXISTS `sbw_app`;
CREATE TABLE `sbw_app` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `keyword` varchar(100) NOT NULL DEFAULT '',
  `price` decimal(10,0) NOT NULL DEFAULT '0',
  `icon` varchar(100) NOT NULL DEFAULT '' COMMENT '图标',
  `total` int(11) NOT NULL DEFAULT '0' COMMENT '数量',
  `type` tinyint(2) NOT NULL DEFAULT '1' COMMENT '1软件，2游戏，3付费',
  `add_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `user_id` int(11) NOT NULL COMMENT '发布人ID',
  `position` smallint(5) NOT NULL DEFAULT '0' COMMENT '位置',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '标记说明',
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL COMMENT '开始时间',
  `s_time` time DEFAULT NULL,
  `date_total` int(11) DEFAULT NULL,
  `time_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '时间类型：1全天，2时间段',
  PRIMARY KEY (`id`),
  KEY `nums` (`total`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sbw_app
-- ----------------------------

-- ----------------------------
-- Table structure for sbw_cap
-- ----------------------------
DROP TABLE IF EXISTS `sbw_cap`;
CREATE TABLE `sbw_cap` (
  `cap` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sbw_cap
-- ----------------------------
INSERT INTO `sbw_cap` VALUES ('774884', '1', '15011911857');

-- ----------------------------
-- Table structure for sbw_comm
-- ----------------------------
DROP TABLE IF EXISTS `sbw_comm`;
CREATE TABLE `sbw_comm` (
  `id` int(11) NOT NULL,
  `commission` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sbw_comm
-- ----------------------------

-- ----------------------------
-- Table structure for sbw_config
-- ----------------------------
DROP TABLE IF EXISTS `sbw_config`;
CREATE TABLE `sbw_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '配置ID',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '配置名称',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置类型',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '配置说明',
  `group` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置分组',
  `extra` varchar(255) NOT NULL DEFAULT '' COMMENT '配置值',
  `remark` varchar(100) NOT NULL COMMENT '配置说明',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态',
  `value` text NOT NULL COMMENT '配置值',
  `sort` smallint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`),
  KEY `type` (`type`),
  KEY `group` (`group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sbw_config
-- ----------------------------

-- ----------------------------
-- Table structure for sbw_freset
-- ----------------------------
DROP TABLE IF EXISTS `sbw_freset`;
CREATE TABLE `sbw_freset` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fre` int(11) NOT NULL,
  `fre_type` int(4) DEFAULT NULL,
  `updatetime` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sbw_freset
-- ----------------------------

-- ----------------------------
-- Table structure for sbw_fretype
-- ----------------------------
DROP TABLE IF EXISTS `sbw_fretype`;
CREATE TABLE `sbw_fretype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fre_name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sbw_fretype
-- ----------------------------

-- ----------------------------
-- Table structure for sbw_menu
-- ----------------------------
DROP TABLE IF EXISTS `sbw_menu`;
CREATE TABLE `sbw_menu` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(40) NOT NULL DEFAULT '',
  `parentid` smallint(6) DEFAULT '0',
  `icon` varchar(20) NOT NULL DEFAULT '',
  `c` varchar(20) DEFAULT NULL,
  `a` varchar(20) DEFAULT NULL,
  `data` varchar(50) NOT NULL DEFAULT '',
  `tip` varchar(255) NOT NULL DEFAULT '' COMMENT '提示',
  `group` varchar(50) DEFAULT '' COMMENT '分组',
  `listorder` smallint(6) unsigned NOT NULL DEFAULT '999',
  `display` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否显示(1:显示,2:不显示)',
  `updatetime` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `listorder` (`listorder`),
  KEY `parentid` (`parentid`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sbw_menu
-- ----------------------------
INSERT INTO `sbw_menu` VALUES ('1', '管理设置', '18', 'fa-users', '', '', '', '', '', '3', '1', '1522399834');
INSERT INTO `sbw_menu` VALUES ('2', '角色管理', '1', '', 'Admin', 'index', '', '', '', '0', '1', '1522399834');
INSERT INTO `sbw_menu` VALUES ('3', '详情', '2', '', 'Admin', 'info', '', '', '', '0', '2', '1522399834');
INSERT INTO `sbw_menu` VALUES ('4', '添加', '2', '', 'Admin', 'add', '', '', '', '0', '2', '1522399834');
INSERT INTO `sbw_menu` VALUES ('5', '修改', '2', '', 'Admin', 'edit', '', '', '', '0', '2', '1522399834');
INSERT INTO `sbw_menu` VALUES ('6', '删除', '2', '', 'Admin', 'del', '', '', '', '0', '2', '1522399834');
INSERT INTO `sbw_menu` VALUES ('7', '分组管理', '1', '', 'Group', 'index', '', '', '', '0', '1', '1522399834');
INSERT INTO `sbw_menu` VALUES ('8', '详情', '7', '', 'Group', 'info', '', '', '', '0', '2', '1522399834');
INSERT INTO `sbw_menu` VALUES ('9', '添加', '7', '', 'Group', 'add', '', '', '', '0', '2', '1522399834');
INSERT INTO `sbw_menu` VALUES ('10', '修改', '7', '', 'Group', 'edit', '', '', '', '0', '2', '1522399834');
INSERT INTO `sbw_menu` VALUES ('11', '删除', '7', '', 'Group', 'del', '', '', '', '0', '2', '1522399835');
INSERT INTO `sbw_menu` VALUES ('12', '菜单管理', '18', 'fa-navicon', '', '', '', '', '', '0', '1', '1522399835');
INSERT INTO `sbw_menu` VALUES ('13', '查看', '12', '', 'Menu', 'look', '', '', '', '0', '1', '1522399835');
INSERT INTO `sbw_menu` VALUES ('14', '添加', '12', '', 'Menu', 'add', '', '', '', '0', '2', '1522399835');
INSERT INTO `sbw_menu` VALUES ('15', '修改', '12', '', 'Menu', 'index', '', '', '', '0', '1', '1522399835');
INSERT INTO `sbw_menu` VALUES ('16', '删除', '12', '', 'Menu', 'del', '', '', '', '0', '2', '1522399835');
INSERT INTO `sbw_menu` VALUES ('18', '系统设置', '0', 'fa-cogs', '', '', '', '', '', '1', '1', '1522399835');
INSERT INTO `sbw_menu` VALUES ('22', '权限设置', '2', '', 'Group', 'rule', '', '', '', '999', '2', '1522399835');
INSERT INTO `sbw_menu` VALUES ('23', '个人设置', '1', '', 'Admin', 'public_edit_info', '', '', '', '999', '1', '1522399835');
INSERT INTO `sbw_menu` VALUES ('27', '日志管理', '18', 'fa-bug', 'Log', 'index', '', '', '', '999', '1', '1522399835');
INSERT INTO `sbw_menu` VALUES ('31', '系统首页', '0', 'fa-bank', '', '', '', '', '', '0', '1', '1522399835');
INSERT INTO `sbw_menu` VALUES ('32', '水店管理', '0', '', '', '', '', '', '', '1', '1', '1522399835');
INSERT INTO `sbw_menu` VALUES ('33', '送水员管理', '32', 'fa-cloud ', '', '', '', '', '', '999', '1', '1522399835');
INSERT INTO `sbw_menu` VALUES ('34', '用户管理', '0', '', '', '', '', '', '', '2', '1', '1522399835');
INSERT INTO `sbw_menu` VALUES ('36', '订单报表', '46', 'fa-table', 'Order', 'index', '', '', '', '999', '1', '1522399835');
INSERT INTO `sbw_menu` VALUES ('37', '库存管理', '0', '', '', '', '', '', '', '999', '1', '1522399835');
INSERT INTO `sbw_menu` VALUES ('38', '服务点管理', '34', 'fa-map-pin', 'Shoper', 'index', '', '', '', '999', '1', '1522399835');
INSERT INTO `sbw_menu` VALUES ('39', '骑手添加', '33', '', 'Shoperinfo', 'add', '', '', '', '999', '1', '1522399835');
INSERT INTO `sbw_menu` VALUES ('40', '骑手管理', '33', '', 'Shoperinfo', 'index', '', '', '', '999', '1', '1522399835');
INSERT INTO `sbw_menu` VALUES ('41', '供应商', '0', '', '', '', '', '', '', '999', '1', '1522399835');
INSERT INTO `sbw_menu` VALUES ('42', '库存调配', '41', '', 'Product', 'send_stock_look', '', '', '', '999', '1', '1522399835');
INSERT INTO `sbw_menu` VALUES ('43', '库存管理', '37', '', 'product', 'query_stock', '', '', '', '999', '1', '1522399835');
INSERT INTO `sbw_menu` VALUES ('44', '用户信息', '34', 'fa-users', '', '', '', '', '', '999', '1', '1522399835');
INSERT INTO `sbw_menu` VALUES ('45', '产品管理', '41', '', 'Product', 'index', '', '', '', '999', '1', '1522399835');
INSERT INTO `sbw_menu` VALUES ('46', '报表信息', '0', '', '', '', '', '', '', '999', '1', '1522399835');
INSERT INTO `sbw_menu` VALUES ('47', '会员用户注册', '44', '', 'Userinfo', 'add_info', '', '', '', '999', '1', '1522399835');
INSERT INTO `sbw_menu` VALUES ('48', '押金设置', '32', '', '', '', '', '', '', '999', '1', '1522399835');
INSERT INTO `sbw_menu` VALUES ('49', '首页', '31', 'fa-bank', 'Index', 'index_mod', '', '', '', '999', '1', '1522399835');
INSERT INTO `sbw_menu` VALUES ('50', '接单', '32', '', '', '', '', '', '', '999', '2', '1522399835');
INSERT INTO `sbw_menu` VALUES ('51', '查看评价', '32', '', 'Shoper', 'eavl_info', '', '', '', '999', '1', '1522399835');
INSERT INTO `sbw_menu` VALUES ('52', '推广业务', '34', '', '', '', '', '', '', '999', '1', '1522399835');
INSERT INTO `sbw_menu` VALUES ('53', '用户信息', '44', '', 'Userinfo', 'index', '', '', '', '999', '1', '1522399835');

-- ----------------------------
-- Table structure for sbw_order
-- ----------------------------
DROP TABLE IF EXISTS `sbw_order`;
CREATE TABLE `sbw_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` varchar(16) DEFAULT NULL,
  `num` int(11) DEFAULT NULL,
  `order_status` int(1) DEFAULT NULL,
  `shop_id` int(11) DEFAULT NULL,
  `shoper_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `updatetime` int(10) DEFAULT NULL,
  `o_builddate` int(10) DEFAULT NULL,
  `senddate` int(10) DEFAULT NULL,
  `o_address` varchar(255) DEFAULT NULL,
  `payway` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=597 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sbw_order
-- ----------------------------
INSERT INTO `sbw_order` VALUES ('550', '1521618002135', '3', '1', '2', '0', '10', '9', '1521618002', '1521618002', null, '广州花都区测试街111号', null);
INSERT INTO `sbw_order` VALUES ('551', '1521618156876', '2', '1', '1', '0', '10', '9', '1521618156', '1521618156', null, '广州花都区测试街111号', null);
INSERT INTO `sbw_order` VALUES ('552', '1521618157268', '2', '1', '1', '0', '10', '9', '1521618157', '1521618157', null, '广州花都区测试街111号', null);
INSERT INTO `sbw_order` VALUES ('553', '1521618158355', '2', '1', '1', '0', '10', '9', '1521618158', '1521618158', null, '广州花都区测试街111号', null);
INSERT INTO `sbw_order` VALUES ('554', '1521618158949', '2', '1', '1', '0', '10', '9', '1521618158', '1521618158', null, '广州花都区测试街111号', null);
INSERT INTO `sbw_order` VALUES ('555', '1521618159209', '2', '1', '1', '0', '10', '9', '1521618159', '1521618159', null, '广州花都区测试街111号', null);
INSERT INTO `sbw_order` VALUES ('556', '1521618159642', '2', '1', '1', '0', '10', '9', '1521618159', '1521618159', null, '广州花都区测试街111号', null);
INSERT INTO `sbw_order` VALUES ('557', '1521618160229', '2', '1', '1', '0', '10', '9', '1521618160', '1521618160', null, '广州花都区测试街111号', null);
INSERT INTO `sbw_order` VALUES ('558', '1521618160976', '2', '1', '1', '0', '10', '9', '1521618160', '1521618160', null, '广州花都区测试街111号', null);
INSERT INTO `sbw_order` VALUES ('559', '1521618161466', '2', '1', '1', '0', '10', '9', '1521618161', '1521618161', null, '广州花都区测试街111号', null);
INSERT INTO `sbw_order` VALUES ('560', '1521618162107', '2', '1', '1', '0', '10', '9', '1521618162', '1521618162', null, '广州花都区测试街111号', null);
INSERT INTO `sbw_order` VALUES ('561', '1521618175984', '6', '1', '2', '0', '10', '9', '1521618175', '1521618175', null, '广州花都区测试街111号', null);
INSERT INTO `sbw_order` VALUES ('562', '1521618175777', '6', '1', '2', '0', '10', '9', '1521618175', '1521618175', null, '广州花都区测试街111号', null);
INSERT INTO `sbw_order` VALUES ('563', '1521618176820', '6', '1', '2', '0', '10', '9', '1521618176', '1521618176', null, '广州花都区测试街111号', null);
INSERT INTO `sbw_order` VALUES ('564', '1521618176827', '6', '1', '2', '0', '10', '9', '1521618176', '1521618176', null, '广州花都区测试街111号', null);
INSERT INTO `sbw_order` VALUES ('565', '1521618176238', '6', '1', '2', '0', '10', '9', '1521618176', '1521618176', null, '广州花都区测试街111号', null);
INSERT INTO `sbw_order` VALUES ('566', '1521618176115', '6', '1', '2', '0', '10', '9', '1521618176', '1521618176', null, '广州花都区测试街111号', null);
INSERT INTO `sbw_order` VALUES ('567', '1521618176253', '6', '1', '2', '0', '10', '9', '1521618176', '1521618176', null, '广州花都区测试街111号', null);
INSERT INTO `sbw_order` VALUES ('568', '1521618176668', '6', '1', '2', '0', '10', '9', '1521618176', '1521618176', null, '广州花都区测试街111号', null);
INSERT INTO `sbw_order` VALUES ('569', '1521618177577', '6', '1', '2', '0', '10', '9', '1521618177', '1521618177', null, '广州花都区测试街111号', null);
INSERT INTO `sbw_order` VALUES ('570', '1521619667276', '4', '1', '2', '0', '10', '9', '1521619667', '1521619667', null, '广州花都区111号', null);
INSERT INTO `sbw_order` VALUES ('571', '1521619667760', '5', '1', '2', '0', '10', '9', '1521619667', '1521619667', null, '广州花都区111号', null);
INSERT INTO `sbw_order` VALUES ('572', '1521619668359', '10', '1', '2', '0', '10', '9', '1521619668', '1521619668', null, '广州花都区111号', null);
INSERT INTO `sbw_order` VALUES ('573', '1521619669364', '2', '1', '2', '0', '10', '9', '1521619669', '1521619669', null, '广州花都区111号', null);
INSERT INTO `sbw_order` VALUES ('574', '1521619670229', '11', '1', '2', '0', '10', '9', '1521619670', '1521619670', null, '广州花都区111号', null);
INSERT INTO `sbw_order` VALUES ('575', '1521619670186', '11', '1', '2', '0', '10', '9', '1521619670', '1521619670', null, '广州花都区111号', null);
INSERT INTO `sbw_order` VALUES ('576', '1521619671164', '11', '1', '2', '0', '10', '9', '1521619671', '1521619671', null, '广州花都区111号', null);
INSERT INTO `sbw_order` VALUES ('577', '1521619671227', '7', '1', '2', '0', '10', '9', '1521619671', '1521619671', null, '广州花都区111号', null);
INSERT INTO `sbw_order` VALUES ('578', '1521619672302', '10', '1', '2', '0', '10', '9', '1521619672', '1521619672', null, '广州花都区111号', null);
INSERT INTO `sbw_order` VALUES ('579', '1521619672283', '12', '1', '2', '0', '10', '9', '1521619672', '1521619672', null, '广州花都区111号', null);
INSERT INTO `sbw_order` VALUES ('580', '1521619673981', '8', '1', '2', '0', '10', '9', '1521619673', '1521619673', null, '广州花都区111号', null);
INSERT INTO `sbw_order` VALUES ('581', '1521619673475', '4', '1', '2', '0', '10', '9', '1521619673', '1521619673', null, '广州花都区111号', null);
INSERT INTO `sbw_order` VALUES ('582', '1521619673544', '10', '1', '2', '0', '10', '9', '1521619673', '1521619673', null, '广州花都区111号', null);
INSERT INTO `sbw_order` VALUES ('583', '1521619673684', '15', '1', '2', '0', '10', '9', '1521619673', '1521619673', null, '广州花都区111号', null);
INSERT INTO `sbw_order` VALUES ('584', '1521619674339', '5', '1', '2', '0', '10', '9', '1521619674', '1521619674', null, '广州花都区111号', null);
INSERT INTO `sbw_order` VALUES ('585', '1521619674701', '15', '1', '2', '0', '10', '9', '1521619674', '1521619674', null, '广州花都区111号', null);
INSERT INTO `sbw_order` VALUES ('586', '1521619675942', '4', '1', '2', '0', '10', '9', '1521619675', '1521619675', null, '广州花都区111号', null);
INSERT INTO `sbw_order` VALUES ('587', '1521619675692', '11', '1', '2', '0', '10', '9', '1521619675', '1521619675', null, '广州花都区111号', null);
INSERT INTO `sbw_order` VALUES ('588', '1521619675214', '6', '1', '2', '0', '10', '9', '1521619675', '1521619675', null, '广州花都区111号', null);
INSERT INTO `sbw_order` VALUES ('589', '1521619675184', '13', '1', '2', '0', '10', '9', '1521619675', '1521619675', null, '广州花都区111号', null);
INSERT INTO `sbw_order` VALUES ('590', '1521619676666', '5', '1', '2', '0', '10', '9', '1521619676', '1521619676', null, '广州花都区111号', null);
INSERT INTO `sbw_order` VALUES ('591', '1521619676575', '10', '1', '2', '0', '10', '9', '1521619676', '1521619676', null, '广州花都区111号', null);
INSERT INTO `sbw_order` VALUES ('592', '1521619676693', '11', '1', '2', '0', '10', '9', '1521619676', '1521619676', null, '广州花都区111号', null);
INSERT INTO `sbw_order` VALUES ('593', '1521619676367', '7', '1', '2', '0', '10', '9', '1521619676', '1521619676', null, '广州花都区111号', null);
INSERT INTO `sbw_order` VALUES ('594', '1521627048693', '10', '1', '2', '0', '10', '9', '1521627048', '1521627048', null, '广州花都区111号', null);
INSERT INTO `sbw_order` VALUES ('595', '1521627923884', '10', '1', '2', '0', '10', '9', '1521627923', '1521627923', null, '广州花都区111号', null);
INSERT INTO `sbw_order` VALUES ('596', '1521689746200', '6', '1', '1', '0', '10', '9', '1521689746', '1521689746', null, '广州花都区111号', null);

-- ----------------------------
-- Table structure for sbw_orderinfo
-- ----------------------------
DROP TABLE IF EXISTS `sbw_orderinfo`;
CREATE TABLE `sbw_orderinfo` (
  `uid` int(11) DEFAULT NULL,
  `shop_id` int(11) DEFAULT NULL,
  `Order_num` varchar(16) NOT NULL,
  `num` int(11) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `user` varchar(20) DEFAULT NULL,
  `product` varchar(255) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `builddate` int(10) DEFAULT NULL,
  `shopname` varchar(255) DEFAULT NULL,
  `overdate` int(10) DEFAULT NULL,
  PRIMARY KEY (`Order_num`)
) ENGINE=MyISAM AUTO_INCREMENT=92 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sbw_orderinfo
-- ----------------------------

-- ----------------------------
-- Table structure for sbw_product
-- ----------------------------
DROP TABLE IF EXISTS `sbw_product`;
CREATE TABLE `sbw_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_N` varchar(255) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `product_pic` varchar(255) DEFAULT NULL,
  `product_info` varchar(255) DEFAULT NULL,
  `builddate` int(10) DEFAULT NULL,
  `updatatime` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sbw_product
-- ----------------------------
INSERT INTO `sbw_product` VALUES ('9', '必宝', '12', 'public/upload/product/2018-03-17/1521216080bibao (1).jpg,public/upload/product/2018-03-17/1521216080bibao (2).jpg,public/upload/product/2018-03-17/1521216080bibao (3).jpg', '必宝水质有保证', '1521216080', '1521216080');
INSERT INTO `sbw_product` VALUES ('10', '水桶', '35', 'public/upload/product/2018-03-28/1522198639.jpg', '装水用的', '1522198639', '1522198639');

-- ----------------------------
-- Table structure for sbw_shop
-- ----------------------------
DROP TABLE IF EXISTS `sbw_shop`;
CREATE TABLE `sbw_shop` (
  `shop_id` int(11) NOT NULL AUTO_INCREMENT,
  `shop_name` varchar(20) DEFAULT NULL,
  `shop_phone` varchar(20) DEFAULT NULL,
  `shop_HQ` varchar(255) DEFAULT NULL,
  `updatetime` int(11) DEFAULT NULL,
  `longitude` int(11) DEFAULT NULL,
  `latitude` int(11) DEFAULT NULL,
  `shop_pic` varchar(255) DEFAULT NULL,
  `id_pic` varchar(255) DEFAULT NULL,
  `lience_pic` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `registertime` int(10) DEFAULT NULL,
  PRIMARY KEY (`shop_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sbw_shop
-- ----------------------------
INSERT INTO `sbw_shop` VALUES ('1', '魔都服务站', '13311857969', '广州花都区龙珠商务大夏', '1521371903', '113229428', '23403597', 'public/upload/shoper/2018-03-18/1521371903bibao (3).jpg', 'public/upload/shoper/2018-03-18/1521371903bibao (2).jpg', 'public/upload/shoper/2018-03-18/1521371903bibao (1).jpg', 'Morihith@qq.com', '1521371903');
INSERT INTO `sbw_shop` VALUES ('2', '魔都服务站2', '13314564959', '广东省广州市花都区龙珠路8号12栋', '1521385657', '113224045', '23402963', 'public/upload/shoper/2018-03-18/1521385657bibao (3).jpg', 'public/upload/shoper/2018-03-18/1521385657bibao (2).jpg', 'public/upload/shoper/2018-03-18/1521385657bibao (1).jpg', 'UIUI@qq.com', '1521385657');
INSERT INTO `sbw_shop` VALUES ('3', '某度服务站', '18156569853', '广东省广州市花都区美雅直街6', '1521770103', '113227275', '23399559', 'public/upload/shoper/2018-03-23/1521770103bibao (3).jpg', 'public/upload/shoper/2018-03-23/1521770103bibao (2).jpg', 'public/upload/shoper/2018-03-23/1521770103bibao (1).jpg', '1234@qq.com', '1521770103');
INSERT INTO `sbw_shop` VALUES ('4', '曙光服务点', '15011811857', '广东省广州市花都区曙光路36号', '1521968694', '113232747', '23399949', 'public/upload/shoper/2018-03-25/1521968694bibao (2).jpg', 'public/upload/shoper/2018-03-25/1521968694bibao (1).jpg', 'public/upload/shoper/2018-03-25/1521968694bibao (3).jpg', '1234@qq.com', '1521968694');
INSERT INTO `sbw_shop` VALUES ('5', '曙光服务点2', '15011811856', '广东省广州市花都区松园路', '1521969261', '113222013', '23398734', 'public/upload/shoper/2018-03-25/1521969261bibao (1).jpg', 'public/upload/shoper/2018-03-25/1521969261bibao (3).jpg', 'public/upload/shoper/2018-03-25/1521969261bibao (3).jpg', '', '1521969261');
INSERT INTO `sbw_shop` VALUES ('6', '迎宾服务点', '15011311957', '广东省广州市花都区迎宾大道65号', '1522048424', '113222143', '23406735', 'public/upload/shoper/2018-03-26/1522048424.png', 'public/upload/shoper/2018-03-26/1522048424.jpg', 'public/upload/shoper/2018-03-26/1522048424.jpg', 'qq@qq.com', '1522048424');
INSERT INTO `sbw_shop` VALUES ('7', '11223', '15011911857', '广东省广州市花都区雅居乐雍华庭', '1522306691', '113242714', '23402946', 'public/upload/shoper/2018-03-29/1522306691.jpg', 'public/upload/shoper/2018-03-29/1522306691.jpg', 'public/upload/shoper/2018-03-29/1522306691.jpg', 'Qqq@qq.com', '1522306691');
INSERT INTO `sbw_shop` VALUES ('8', '123456qq', '13172077835', '广东省广州市花都区迎宾大道95', '1522310929', '113231988', '23406466', 'public/upload/shoper/2018-03-29/1522310929.jpg', 'public/upload/shoper/2018-03-29/1522310929.jpg', 'public/upload/shoper/2018-03-29/1522310929.jpg', '123@qq.com', '1522310929');

-- ----------------------------
-- Table structure for sbw_shoperinfo
-- ----------------------------
DROP TABLE IF EXISTS `sbw_shoperinfo`;
CREATE TABLE `sbw_shoperinfo` (
  `sid` int(11) NOT NULL AUTO_INCREMENT,
  `shop_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  `realname` varchar(50) DEFAULT NULL,
  `mobile` varchar(11) DEFAULT NULL,
  `id_pic` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`sid`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sbw_shoperinfo
-- ----------------------------
INSERT INTO `sbw_shoperinfo` VALUES ('5', '1', '啦啦啦', 'e10adc3949ba59abbe56', '特步', '13174514094', null);
INSERT INTO `sbw_shoperinfo` VALUES ('6', '2', '送水啦', 'e10adc3949ba59abbe56', '12331', '1234561111', null);

-- ----------------------------
-- Table structure for sbw_shop_admin_access
-- ----------------------------
DROP TABLE IF EXISTS `sbw_shop_admin_access`;
CREATE TABLE `sbw_shop_admin_access` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shopid` int(11) DEFAULT NULL,
  `admin_id` int(11) DEFAULT NULL,
  `shop_fre` int(11) DEFAULT '0',
  `ispass` int(1) DEFAULT '0',
  `bucket_null` int(11) DEFAULT '0',
  `bucket_allnum` int(11) DEFAULT '0',
  `send_num` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sbw_shop_admin_access
-- ----------------------------
INSERT INTO `sbw_shop_admin_access` VALUES ('7', '1', '2', '20000', '1', '276', '500', '0');
INSERT INTO `sbw_shop_admin_access` VALUES ('8', '2', '3', '20000', '1', '496', '500', '10');
INSERT INTO `sbw_shop_admin_access` VALUES ('9', '3', '6', '0', '0', '500', '500', '0');
INSERT INTO `sbw_shop_admin_access` VALUES ('10', '4', '7', '0', '0', '500', '500', '0');
INSERT INTO `sbw_shop_admin_access` VALUES ('11', '5', '8', '0', '0', '500', '500', '0');
INSERT INTO `sbw_shop_admin_access` VALUES ('12', '6', '9', '0', '0', '500', '500', '0');
INSERT INTO `sbw_shop_admin_access` VALUES ('13', '7', '10', '0', '0', '0', '0', '0');
INSERT INTO `sbw_shop_admin_access` VALUES ('14', '8', '11', '0', '0', '0', '0', '0');

-- ----------------------------
-- Table structure for sbw_shop_eavl
-- ----------------------------
DROP TABLE IF EXISTS `sbw_shop_eavl`;
CREATE TABLE `sbw_shop_eavl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shop_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `eavl` varchar(255) DEFAULT NULL,
  `time` int(10) DEFAULT NULL,
  `star` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sbw_shop_eavl
-- ----------------------------
INSERT INTO `sbw_shop_eavl` VALUES ('1', '2', '10', '还行吧', '1521371903', '4');
INSERT INTO `sbw_shop_eavl` VALUES ('2', '2', '10', '还行吧', '1521371903', '5');
INSERT INTO `sbw_shop_eavl` VALUES ('3', '2', '10', '还行吧', '1521371903', '2');
INSERT INTO `sbw_shop_eavl` VALUES ('4', '2', '10', '还行吧', '1521371903', '3');
INSERT INTO `sbw_shop_eavl` VALUES ('5', '1', '11', '还行吧', '1521371903', '3');
INSERT INTO `sbw_shop_eavl` VALUES ('6', '1', '11', '还行吧', '1521371903', '3');
INSERT INTO `sbw_shop_eavl` VALUES ('7', '1', '11', '还行吧', '1521371903', '3');
INSERT INTO `sbw_shop_eavl` VALUES ('8', '2', '10', '测试', '1522498896', '1');
INSERT INTO `sbw_shop_eavl` VALUES ('9', '2', '10', '测试', '1522498931', '4');
INSERT INTO `sbw_shop_eavl` VALUES ('10', '2', '10', '测试', '1522498932', '5');
INSERT INTO `sbw_shop_eavl` VALUES ('11', '2', '12', '测试', '1522498933', '4');
INSERT INTO `sbw_shop_eavl` VALUES ('12', '4', '11', '测试', '1522498933', '2');
INSERT INTO `sbw_shop_eavl` VALUES ('13', '1', '12', '测试', '1522498933', '1');
INSERT INTO `sbw_shop_eavl` VALUES ('14', '1', '10', '测试', '1522498933', '4');
INSERT INTO `sbw_shop_eavl` VALUES ('15', '1', '10', '测试', '1522498933', '2');
INSERT INTO `sbw_shop_eavl` VALUES ('16', '3', '10', '测试', '1522498934', '1');
INSERT INTO `sbw_shop_eavl` VALUES ('17', '3', '10', '测试', '1522498934', '5');
INSERT INTO `sbw_shop_eavl` VALUES ('18', '3', '12', '测试', '1522498934', '3');
INSERT INTO `sbw_shop_eavl` VALUES ('19', '2', '11', '测试', '1522498934', '5');
INSERT INTO `sbw_shop_eavl` VALUES ('20', '3', '11', '测试', '1522498935', '2');
INSERT INTO `sbw_shop_eavl` VALUES ('21', '3', '11', '不错，好评', '1522499306', '3');
INSERT INTO `sbw_shop_eavl` VALUES ('22', '2', '12', '五星好评', '1522499306', '4');
INSERT INTO `sbw_shop_eavl` VALUES ('23', '1', '11', '服务有点差', '1522499307', '2');
INSERT INTO `sbw_shop_eavl` VALUES ('24', '4', '11', '不错，好评', '1522499307', '3');
INSERT INTO `sbw_shop_eavl` VALUES ('25', '3', '11', '服务有点差', '1522499307', '1');
INSERT INTO `sbw_shop_eavl` VALUES ('26', '3', '12', '五星好评', '1522499307', '2');
INSERT INTO `sbw_shop_eavl` VALUES ('27', '4', '11', '五星好评', '1522499308', '5');
INSERT INTO `sbw_shop_eavl` VALUES ('28', '3', '10', '不错，好评', '1522499309', '1');
INSERT INTO `sbw_shop_eavl` VALUES ('29', '3', '12', '服务有点差', '1522499310', '5');
INSERT INTO `sbw_shop_eavl` VALUES ('30', '1', '12', '五星好评', '1522499310', '3');
INSERT INTO `sbw_shop_eavl` VALUES ('31', '1', '10', '五星好评', '1522499310', '3');
INSERT INTO `sbw_shop_eavl` VALUES ('32', '3', '10', '服务有点差', '1522499310', '4');
INSERT INTO `sbw_shop_eavl` VALUES ('33', '2', '10', '不错，好评', '1522499310', '5');
INSERT INTO `sbw_shop_eavl` VALUES ('34', '1', '11', '不错，好评', '1522499311', '5');

-- ----------------------------
-- Table structure for sbw_shop_product_access
-- ----------------------------
DROP TABLE IF EXISTS `sbw_shop_product_access`;
CREATE TABLE `sbw_shop_product_access` (
  `id` int(11) NOT NULL,
  `shop_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sbw_shop_product_access
-- ----------------------------
INSERT INTO `sbw_shop_product_access` VALUES ('0', '54', '1', '12');

-- ----------------------------
-- Table structure for sbw_user
-- ----------------------------
DROP TABLE IF EXISTS `sbw_user`;
CREATE TABLE `sbw_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(20) DEFAULT NULL,
  `user_wxid` varchar(255) DEFAULT NULL,
  `user_status` int(1) DEFAULT '1',
  `updatatime` int(10) DEFAULT NULL,
  `registertime` int(10) DEFAULT NULL,
  `u_gender` int(1) DEFAULT NULL,
  `u_isvip` int(1) DEFAULT '0',
  `u_spread` varchar(6) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=66 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sbw_user
-- ----------------------------
INSERT INTO `sbw_user` VALUES ('10', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('11', 'test', null, '1', '1521391661', '1521391661', '0', '0', '');
INSERT INTO `sbw_user` VALUES ('12', 'test', null, '1', '1521391661', '1521391661', '2', '0', '');
INSERT INTO `sbw_user` VALUES ('13', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('14', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('15', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('16', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('17', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('18', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('19', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('20', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('21', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('22', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('23', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('24', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('25', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('26', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('27', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('28', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('29', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('30', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('31', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('32', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('33', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('34', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('35', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('36', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('37', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('38', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('39', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('40', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('41', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('42', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('43', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('44', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('45', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('46', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('47', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('48', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('49', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('50', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('51', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('52', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('53', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('54', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('55', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('56', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('57', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('58', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('59', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('60', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('61', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('62', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('63', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('64', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');
INSERT INTO `sbw_user` VALUES ('65', '(｀・ω・´)', 'o27rv0Ora7ZGjztTZLoQ0Fb6gM98', '1', '1521391661', '1521391661', '1', '1', '');

-- ----------------------------
-- Table structure for sbw_userinfo
-- ----------------------------
DROP TABLE IF EXISTS `sbw_userinfo`;
CREATE TABLE `sbw_userinfo` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `user_phone` varchar(20) DEFAULT NULL,
  `user_address` varchar(255) DEFAULT NULL,
  `user_floor` int(11) DEFAULT NULL,
  `user_iselevator` int(1) DEFAULT NULL,
  `user_fre` int(11) DEFAULT NULL,
  `updatatime` int(10) DEFAULT NULL,
  `u_money` int(10) DEFAULT '0',
  PRIMARY KEY (`uid`)
) ENGINE=MyISAM AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sbw_userinfo
-- ----------------------------
INSERT INTO `sbw_userinfo` VALUES ('5', '10', '15011911867', '广州市龙珠商务大夏', '6', '1', '1200', '1521391661', '200');
INSERT INTO `sbw_userinfo` VALUES ('6', '11', '13112244343', '', '6', '0', '300', '1521391661', '0');
INSERT INTO `sbw_userinfo` VALUES ('7', '12', '13114422554', null, '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('8', '14', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('9', '15', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('10', '16', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('11', '17', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('12', '18', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('13', '19', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('14', '20', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('15', '21', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('16', '22', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('17', '23', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('18', '24', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('19', '25', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('20', '26', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('21', '27', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('22', '28', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('23', '29', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('24', '30', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('25', '31', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('26', '32', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('27', '33', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('28', '34', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('29', '35', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('30', '36', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('31', '37', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('32', '38', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('33', '39', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('34', '40', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('35', '41', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('36', '42', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('37', '43', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('38', '44', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('39', '45', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('40', '46', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('41', '47', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('42', '48', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('43', '49', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('44', '50', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('45', '51', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('46', '52', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('47', '53', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('48', '54', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('49', '13', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('53', '55', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('54', '56', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('55', '57', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('56', '58', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('57', '59', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('58', '60', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('59', '61', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('60', '62', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('61', '63', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('62', '64', '13114422554', '', '0', '0', '300', '1521391661', '60');
INSERT INTO `sbw_userinfo` VALUES ('63', '65', '13114422554', '', '0', '0', '300', '1521391661', '60');

-- ----------------------------
-- Table structure for sbw_user_shop_access
-- ----------------------------
DROP TABLE IF EXISTS `sbw_user_shop_access`;
CREATE TABLE `sbw_user_shop_access` (
  `id` int(11) NOT NULL,
  `shop_id` int(11) DEFAULT NULL,
  `u_id` int(11) DEFAULT NULL,
  `updatatime` int(10) DEFAULT NULL,
  `registertime` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sbw_user_shop_access
-- ----------------------------
INSERT INTO `sbw_user_shop_access` VALUES ('0', '2', '10', '1521618002', '1521618002');
