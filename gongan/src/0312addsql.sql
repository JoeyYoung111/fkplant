/*
 Navicat Premium Data Transfer

 Source Server         : 50.64.130.123 root
 Source Server Type    : MySQL
 Source Server Version : 50722
 Source Host           : 50.64.130.123:3306
 Source Schema         : csaqys

 Target Server Type    : MySQL
 Target Server Version : 50722
 File Encoding         : 65001

 Date: 09/03/2026 09:28:36
*/
/*
`f_xt_xd_ajxx_new`结构：
DROP TABLE IF EXISTS `f_xt_xd_ajxx_new`;
CREATE TABLE `f_xt_xd_ajxx_new`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sfzh` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '身份证',
  `xm` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `jjbh` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '案件编号',
  `ajlb` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '案件类别',
  `ajmc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '案件名称',
  `slsj` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '受理时间',
  `sldw` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '受理单位',
  `sldwmc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '受理单位名称',
  `jyaq` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '简要案情',
  `cfqk` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '处罚情况',
  `cfrq` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '处罚日期',
  `flag` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标志',
  `insert_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '插入时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ajcardnum`(`sfzh`) USING BTREE,
  INDEX `idx_sfzh_jjbh_cfrq`(`sfzh`, `jjbh`, `cfrq`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5258 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

SET FOREIGN_KEY_CHECKS = 1;
 */
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_xjw_aj_clcs_jgzxb
-- ----------------------------
DROP TABLE IF EXISTS `t_xjw_aj_clcs_jgzxb`;
CREATE TABLE `t_xjw_aj_clcs_jgzxb`  (
                                        `JLBH` varchar(23) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '记录编号',
                                        `CSBH` varchar(23) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '案件编号',
                                        `JDJG` char(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '决定结果(处罚情况f_xt_ajxx_dic表中code)',
                                        `JDQX` char(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '决定期限',
                                        `JDJE` decimal(12, 0) NULL DEFAULT NULL COMMENT '决定金额',
                                        `JDSJ` char(8) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '决定时间(处罚时间)',
                                        `JDR` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '决定人',
                                        `JDRXM` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '决定人',
                                        `JDDW` char(12) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '决定单位',
                                        `JDDWMC` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '决定单位',
                                        `ZXR` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '执行人',
                                        `ZXDW` char(12) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '执行单位',
                                        `WSH` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文书号',
                                        `ZXJE` decimal(12, 0) NULL DEFAULT NULL COMMENT '执行金额',
                                        `ZXQX` char(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '执行期限',
                                        `ZXDD` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '执行地点',
                                        `ZXQK` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '执行情况',
                                        `ZXKSSJ` varchar(14) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '执行开始时间',
                                        `ZXJSSJ` varchar(14) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '执行结束时间',
                                        `JSDW` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '接收单位',
                                        `JSR` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '接收人',
                                        `JSSJ` varchar(14) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '接收时间',
                                        `RAS` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'RAS标识',
                                        `DJSJ` varchar(14) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '登记时间',
                                        `DJR` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '登记人',
                                        `DJRXM` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '登记人',
                                        `DJDW` char(12) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '登记单位',
                                        `DJDWMC` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '登记单位',
                                        `XGSJ` varchar(14) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改时间',
                                        `XGR` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
                                        `XGRXM` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
                                        `XGDW` char(12) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改单位',
                                        `XGDWMC` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改单位',
                                        `AJBH` varchar(23) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '案件编号',
                                        `CQLB` char(4) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '呈请类别',
                                        `DXBH` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '对象编号',
                                        `DXLB` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '对象类别',
                                        `DXMC` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '对象名称',
                                        `ZXDWMC` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '执行单位名称',
                                        `JGFLYJ` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '法律依据',
                                        `ZXYY` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '执行原因',
                                        `TZJSQK` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '通知家属情况',
                                        `BZCJSFDW` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '不准出境是否登记',
                                        `YWWS` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '有无外伤',
                                        `SFJRHWS` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否进入候问室',
                                        `CHFS` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '传唤方式',
                                        `JPWLY` char(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '继续盘问理由',
                                        `DSYX` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '代收银行',
                                        `JCJGCSYJ` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '检察机关措施意见',
                                        `BLR` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '办理人',
                                        `JZRXX` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '见证人',
                                        `JLR` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '记录人',
                                        `JDFS` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '鉴定方式',
                                        `XZSX` char(6) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '协作具体事项',
                                        `FBFW` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发布范围',
                                        `BZR` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '结果执行保证人',
                                        `TZDX` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '结果执行通知对象',
                                        `BCXX` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '结果执行补充信息',
                                        `YXBS` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '有效标识',
                                        `GLCSBH` varchar(23) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关联措施编号',
                                        `ZXJG` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '执行结果',
                                        `ZJQK` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '证据情况',
                                        `ZXFS` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '执行方式',
                                        `FYJG` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '复议机关',
                                        `SSJG` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '诉讼机构',
                                        `CLQD` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '材料清单',
                                        `CLQDSL` decimal(3, 0) NULL DEFAULT NULL COMMENT '材料清单数量',
                                        `TZDXDZ` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '结果执行通知对象地址',
                                        `ZGLCSBH` varchar(23) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主关联措施编号',
                                        `JCJG` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '检查机关',
                                        `JCJGMC` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '检查机关名称',
                                        `JCJGJDJG` char(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '检查机关决定结果',
                                        `JCJGJDQX` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '检查机关决定期限',
                                        `JCJGJDSJ` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '检查机关决定时间',
                                        `JCJGYJ` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '检查机关意见',
                                        `ZXCSMC` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '执行处所名称',
                                        `ZXCSDM` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '执行处所代码',
                                        `RYMC` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '人员姓名',
                                        `RYXB` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别',
                                        `RYCSRQ` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '出生日期',
                                        `RYZJZLHM` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '证件种类号码',
                                        `RYXZZ` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '住(地)址',
                                        `RYGZDW` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '工作单位',
                                        `RYLXFS` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系方式',
                                        `ZXZH` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '执行字号',
                                        `JCJGWSH` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '检察机关文书号',
                                        `CSRYBH` varchar(23) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '人员编号',
                                        `CSZXSJ` varchar(14) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '执行时间',
                                        `JGZXLXDW` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '结果执行联系单位',
                                        `JGZXLXDH` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '结果执行联系电话',
                                        `JGZXLXR` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '结果执行联系人',
                                        `FY` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '法院',
                                        `FYCSYJ` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '法院措施意见',
                                        `FYJDJG` char(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '法院决定结果',
                                        `FYJDQX` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '法院决定期限',
                                        `FYJDSJ` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '法院决定时间',
                                        `FYMC` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '法院名称',
                                        `FYWSH` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '法院文书号',
                                        `FYYJ` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '法院意见',
                                        `ZYCLLB` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
                                        `SSQK` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '事实情况',
                                        `DSRXX` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '当事人信息',
                                        `WSBH` varchar(23) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
                                        `SJJE` decimal(12, 0) NULL DEFAULT NULL,
                                        `CXMSJE` decimal(12, 0) NULL DEFAULT NULL,
                                        `SJJSSJ` varchar(14) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
                                        `TZSJ` varchar(14) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
                                        `HFSJ` varchar(14) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
                                        `XJZSJLY` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
                                        `GMSFHM` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '身份证号码',
                                        PRIMARY KEY (`JLBH`) USING BTREE,
                                        INDEX `INDX_T_XJW_AJ_CLCS_JGZXB_AJBH`(`AJBH`) USING BTREE,
                                        INDEX `INDX_T_XJW_AJ_CLCS_JGZXB_CQLB`(`CQLB`) USING BTREE,
                                        INDEX `INDX_T_XJW_AJ_CLCS_JGZXB_CSBH`(`CSBH`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic
COMMENT='案件处罚日期/结果表';




DROP TABLE IF EXISTS `f_xt_ajxx_dic`;

CREATE TABLE `f_xt_ajxx_dic` (
                                 `code` VARCHAR(10) NOT NULL COMMENT '字典编码',
                                 `item` VARCHAR(100) NOT NULL COMMENT '处罚结果名称',

                                 PRIMARY KEY (`code`)
) ENGINE=InnoDB
DEFAULT CHARSET=utf8
COLLATE=utf8_general_ci
COMMENT='案件信息字典表';

SET FOREIGN_KEY_CHECKS = 1;

/*导入字典命令
LOAD DATA LOCAL INFILE '/data/chufacidian.CSV'
INTO TABLE f_xt_ajxx_dic
CHARACTER SET utf8
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(code,item);
    */

-- 存量人员标签处理sql
UPDATE p_personnel_t p
    JOIN (
    SELECT
    sfzh,
    CASE
    WHEN ajlb IN (
    '引诱未成年人聚众淫乱案','卖淫','嫖娼','拉客招嫖',
    '引诱、容留、介绍卖淫','组织、强迫、引诱、容留、介绍卖淫案',
    '组织卖淫案','强迫卖淫案','协助组织卖淫案',
    '引诱、容留、介绍卖淫案','引诱卖淫案','容留卖淫案','介绍卖淫案',
    '制作、贩卖、传播淫秽物品案','聚众淫乱案',
    '制作、运输、复制、出售、出租淫秽物品',
    '传播淫秽信息','组织播放淫秽音像','组织淫秽表演',
    '进行淫秽表演','参与聚众淫乱','为淫秽活动提供条件'
    ) THEN '2219'

    WHEN ajlb IN (
    '赌博案','开设赌场案','组织参与国（境）外赌博案',
    '为赌博提供条件','赌博'
    ) THEN '2178'
    END AS new_label
    FROM f_xt_xd_ajxx_new
    ) t ON p.cardnumber = t.sfzh

    SET p.zslabel2 =
        CASE
        -- 原本为空
        WHEN p.zslabel2 IS NULL OR p.zslabel2 = '' THEN t.new_label

        -- 已包含，不处理
        WHEN FIND_IN_SET(t.new_label, p.zslabel2) > 0 THEN p.zslabel2

        -- 不包含，追加
        ELSE CONCAT(p.zslabel2, ',', t.new_label)
END

WHERE t.new_label IS NOT NULL;