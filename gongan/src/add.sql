SET
    NAMES utf8mb4;

SET
    FOREIGN_KEY_CHECKS = 0;

-- =================================================================
-- 重要说明：
-- 1. 本SQL文件需按顺序完整执行，不可单独执行视图创建语句
-- 2. 执行顺序：表结构变更(ALTER TABLE) -> 新建表 -> 数据字典 -> 视图
-- 3. 视图依赖表中的新字段，必须先执行ALTER TABLE添加字段后才能创建视图
-- 4. 如需单独执行某部分，请确保其依赖的前置语句已执行成功
-- =================================================================
-- =================================================================
-- 1. 人员基础信息表 (p_personnel_t) 改造
-- =================================================================
ALTER TABLE
    `p_personnel_t` -- 1.1 户籍地址结构化 (地级市、县级市、镇街)
    ADD
        COLUMN `house_province` varchar(25) NULL COMMENT '户籍-省',
    ADD
        COLUMN `house_city` varchar(25) NULL COMMENT '户籍-地级市',
    ADD
        COLUMN `house_county` varchar(25) NULL COMMENT '户籍-县级市/区',
    ADD
        COLUMN `house_town` varchar(25) NULL COMMENT '户籍-镇/街道',
    ADD
        COLUMN `house_police_station_id` int(11) NULL COMMENT '户籍-所属派出所ID(关联sys_department_t_new.id,江阴派出所ID:240-263)',
    -- 1.2 现住地址结构化 (省、市、县、镇、派出所) + 经纬度
    ADD
        COLUMN `home_province` varchar(25) NULL COMMENT '现住-省',
    ADD
        COLUMN `home_city` varchar(25) NULL COMMENT '现住-地级市',
    ADD
        COLUMN `home_county` varchar(25) NULL COMMENT '现住-县级市/区',
    ADD
        COLUMN `home_town` varchar(25) NULL COMMENT '现住-镇/街道',
    ADD
        COLUMN `home_police_station_id` int(11) NULL COMMENT '现住-所属派出所ID(关联sys_department_t_new.id,江阴派出所ID:240-263)',
    -- 1.4 前科标识
    ADD
        COLUMN `has_shedu_record` int(1) DEFAULT 0 COMMENT '是否有涉赌前科 0-无 1-有',
    ADD
        COLUMN `has_shechang_record` int(1) DEFAULT 0 COMMENT '是否有涉黄前科 0-无 1-有',
    ADD
        COLUMN `is_minor` int(1) DEFAULT 0 COMMENT '是否未成年标记(根据出生日期动态计算或标记) 0-否 1-是',
    -- 1.5 打处单位(外部接口获取，预留字段)
    ADD
        COLUMN `handle_unit` varchar(255) NULL COMMENT '打处单位(外部接口获取)',
    ADD
        COLUMN `handle_unit_code` varchar(255) NULL COMMENT '打处单位编码',
    ADD
        COLUMN `is_peishi` int(1) DEFAULT 0 COMMENT '是否陪侍人员 0-无 1-有';

-- =================================================================
-- 2. 新增：人员现住地址历史记录表
-- =================================================================
DROP TABLE IF EXISTS `p_homeplace_history_t`;

CREATE TABLE `p_homeplace_history_t` (
                                         `id` int(11) NOT NULL AUTO_INCREMENT,
                                         `personnelid` int(11) NOT NULL COMMENT '关联人员ID',
    -- 现住地结构化字段
                                         `home_province` varchar(50) DEFAULT NULL COMMENT '现住-省',
                                         `home_city` varchar(50) DEFAULT NULL COMMENT '现住-地级市',
                                         `home_county` varchar(50) DEFAULT NULL COMMENT '现住-县级市/区',
                                         `home_town` varchar(50) DEFAULT NULL COMMENT '现住-镇/街道',
                                         `home_police_station_id` int(11) DEFAULT NULL COMMENT '现住-所属派出所ID(关联sys_department_t_new.id, 江阴派出所ID:240-263)',
                                         `home_detail` varchar(255) DEFAULT NULL COMMENT '现住-详细地址',
                                         `home_lng` varchar(50) DEFAULT NULL COMMENT '现住-经度',
                                         `home_lat` varchar(50) DEFAULT NULL COMMENT '现住-纬度',
                                         `validflag` int(2) DEFAULT 1 COMMENT '状态 1有效 0无效',
                                         `remark` varchar(255) DEFAULT NULL COMMENT '备注',
                                         `addoperator` varchar(50) DEFAULT NULL COMMENT '创建人',
                                         `addtime` varchar(50) DEFAULT NULL COMMENT '创建时间',
                                         PRIMARY KEY (`id`),
                                         KEY `idx_personnelid` (`personnelid`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT = '治安-人员现住地址历史记录';

-- =================================================================
-- 新增：新增风险人员信息表
-- =================================================================
DROP TABLE IF EXISTS `p_fxpersonnel_add_t`;
CREATE TABLE `p_fxpersonnel_add_t` (
                                       `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
                                       `cardnumber` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '身份证号',
                                       `personname` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名',
                                       `houseplace` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '户籍地详址',

                                       `extra1` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '扩展字段1',
                                       `extra2` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '扩展字段2',

                                       PRIMARY KEY (`id`),
                                       KEY `index_cardnumber` (`cardnumber`) USING BTREE
) ENGINE=InnoDB
  AUTO_INCREMENT=105093
  DEFAULT CHARSET=utf8
  COLLATE=utf8_general_ci
    COMMENT='新增风险人员信息表'
  ROW_FORMAT=COMPACT;


-- ----------------------------
-- 给 f_xt_xd_jqxx_new 表添加自增主键 id
-- ----------------------------
# -- 第一步：先加普通 id 列
# ALTER TABLE `f_xt_xd_jqxx_new`
#     ADD COLUMN `id` int(11) NULL FIRST;
#
# -- 第二步：填充 id（只在 MySQL 中）
# SET @i := 0;
# UPDATE `f_xt_xd_jqxx_new` SET id = (@i := @i + 1);
#
# -- 第三步：再改成主键 + 自增
# ALTER TABLE `f_xt_xd_jqxx_new`
#     MODIFY COLUMN `id` int(11) NOT NULL AUTO_INCREMENT,
#     ADD PRIMARY KEY (`id`);


-- ----------------------------
-- 给 f_xt_xd_ajxx_new 表新增自增ID和字段
-- ----------------------------
# ALTER TABLE `f_xt_xd_ajxx_new`
#     ADD COLUMN `id` int(11) NULL FIRST,
#     ADD COLUMN `cfqk` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '处罚情况' AFTER `jyaq`,
#     ADD COLUMN `cfrq` varchar(50) NULL DEFAULT NULL COMMENT '处罚日期' AFTER `cfqk`;
# SET @i := 0;
# UPDATE `f_xt_xd_ajxx_new`
# SET id = (@i := @i + 1);
# ALTER TABLE `f_xt_xd_ajxx_new`
#     MODIFY COLUMN `id` int(11) NOT NULL AUTO_INCREMENT,
#     ADD PRIMARY KEY (`id`);


-- =================================================================
-- 3. 涉赌背景表 (p_zaperson_du_t) 升级
-- =================================================================
ALTER TABLE
    `p_zaperson_du_t` -- 3.2 补充属性 (对应新需求的选择项)
    ADD
        COLUMN `person_attribute` varchar(50) NULL COMMENT '涉赌人员属性(数据字典)',
    ADD
        COLUMN `collect_source` varchar(50) NULL COMMENT '采集来源(案件/警情/日常工作发现)',
    ADD
        COLUMN `other_memo` varchar(500) NULL COMMENT '其他备注(选择其他时必填)',
    -- 3.3 现住地结构化字段
    ADD
        COLUMN `home_province` varchar(50) NULL COMMENT '现住-省',
    ADD
        COLUMN `home_city` varchar(50) NULL COMMENT '现住-地级市',
    ADD
        COLUMN `home_county` varchar(50) NULL COMMENT '现住-县级市/区',
    ADD
        COLUMN `home_town` varchar(50) NULL COMMENT '现住-镇/街道',
    ADD
        COLUMN `home_police_station_id` int(11) NULL COMMENT '现住-所属派出所ID(关联sys_department_t_new.id,江阴派出所ID:240-263)',
    ADD
        COLUMN `home_detail` varchar(255) NULL COMMENT '现住-详细地址',
    ADD
        COLUMN `home_lng` varchar(50) NULL COMMENT '现住-经度',
    ADD
        COLUMN `home_lat` varchar(50) NULL COMMENT '现住-纬度',
    -- 3.4 涉赌前科标记
    ADD
        COLUMN `has_shedu_record` int(1) DEFAULT 0 COMMENT '涉赌前科 0-否 1-是(首次填写后续自动)',
    -- 3.5 手机号码
    ADD
        COLUMN `phone` varchar(50) NULL COMMENT '手机号码',
    -- 3.6 涉案地址列表 & 采集日期
    ADD
        COLUMN `case_address_list` varchar(1000) NULL COMMENT '涉案地址列表，多个地址用逗号分隔',
    ADD
        COLUMN `collect_date` varchar(20) NULL COMMENT '采集日期';

-- ----------------------------
-- 涉赌记录 ↔ 案件 关联表
-- ----------------------------
DROP TABLE IF EXISTS `p_zaperson_du_aj_rel_t`;

CREATE TABLE `p_zaperson_du_aj_rel_t` (
                                          `id` int(11) NOT NULL AUTO_INCREMENT,
                                          `du_id` int(11) NOT NULL COMMENT '涉赌记录ID(p_zaperson_du_t.id)',
                                          `personnelid` int(11) NOT NULL COMMENT '人员ID(冗余字段，便于查询)',
                                          `aj_id` int(11) NOT NULL COMMENT '案件ID(f_xt_xd_ajxx_new.id)',
                                          `sldw` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '打处单位(f_xt_xd_ajxx_new.sldw)',
                                          `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
                                          `validflag` int(2) DEFAULT 1 COMMENT '状态 1有效 0无效',
                                          `addtime` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建时间',
                                          PRIMARY KEY (`id`),
                                          KEY `idx_personnelid` (`personnelid`),
                                          KEY `idx_du_id` (`du_id`),
                                          KEY `idx_aj_id` (`aj_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT = '治安人员-涉赌记录与案件关联表';

-- ----------------------------
-- 涉赌记录 ↔ 警情 关联表
-- ----------------------------
DROP TABLE IF EXISTS `p_zaperson_du_jq_rel_t`;

CREATE TABLE `p_zaperson_du_jq_rel_t` (
                                          `id` int(11) NOT NULL AUTO_INCREMENT,
                                          `du_id` int(11) NOT NULL COMMENT '涉赌记录ID(p_zaperson_du_t.id)',
                                          `personnelid` int(11) NOT NULL COMMENT '人员ID(冗余字段，便于查询)',
                                          `jq_id` int(11) NOT NULL COMMENT '警情ID(f_xt_xd_jqxx_new.id)',
                                          `cjdw` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '打处单位(f_xt_xd_jqxx_new.cjdw)',
                                          `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
                                          `validflag` int(2) DEFAULT 1 COMMENT '状态 1有效 0无效',
                                          `addtime` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建时间',
                                          PRIMARY KEY (`id`),
                                          KEY `idx_personnelid` (`personnelid`),
                                          KEY `idx_du_id` (`du_id`),
                                          KEY `idx_jq_id` (`jq_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT = '治安人员-涉赌记录与警情关联表';

-- =================================================================
-- 4. 涉娼背景表 (p_zaperson_chang_t) 升级
-- =================================================================
ALTER TABLE
    `p_zaperson_chang_t` -- 4.2 补充属性
    ADD
        COLUMN `chang_type` varchar(50) NULL COMMENT '涉黄类型(数据字典)',
    ADD
        COLUMN `collect_source` varchar(50) NULL COMMENT '采集来源(案件/警情/日常工作发现)',
    ADD
        COLUMN `other_memo` varchar(500) NULL COMMENT '其他备注',
    -- 4.3 未成年判定
    ADD
        COLUMN `is_minor_case` int(1) DEFAULT 0 COMMENT '是否属于未成年案件 0-否 1-是',
    -- 4.4 现住地结构化字段
    ADD
        COLUMN `home_province` varchar(50) NULL COMMENT '现住-省',
    ADD
        COLUMN `home_city` varchar(50) NULL COMMENT '现住-地级市',
    ADD
        COLUMN `home_county` varchar(50) NULL COMMENT '现住-县级市/区',
    ADD
        COLUMN `home_town` varchar(50) NULL COMMENT '现住-镇/街道',
    ADD
        COLUMN `home_police_station_id` int(11) NULL COMMENT '现住-所属派出所ID(关联sys_department_t_new.id,江阴派出所ID:240-263)',
    ADD
        COLUMN `home_detail` varchar(255) NULL COMMENT '现住-详细地址',
    ADD
        COLUMN `home_lng` varchar(50) NULL COMMENT '现住-经度',
    ADD
        COLUMN `home_lat` varchar(50) NULL COMMENT '现住-纬度',
    -- 4.5 涉黄前科标记
    ADD
        COLUMN `has_shechang_record` int(1) DEFAULT 0 COMMENT '涉黄前科 0-否 1-是(首次填写后续自动)',
    -- 4.6 手机号码
    ADD
        COLUMN `phone` varchar(50) NULL COMMENT '手机号码',
    -- 4.7 涉案地址列表 & 采集日期
    ADD
        COLUMN `case_address_list` varchar(1000) NULL COMMENT '涉案地址列表，多个地址用逗号分隔',
    ADD
        COLUMN `collect_date` varchar(20) NULL COMMENT '采集日期';

-- ----------------------------
-- 涉娼记录 ↔ 案件 关联表
-- ----------------------------
DROP TABLE IF EXISTS `p_zaperson_chang_aj_rel_t`;

CREATE TABLE `p_zaperson_chang_aj_rel_t` (
                                             `id` int(11) NOT NULL AUTO_INCREMENT,
                                             `chang_id` int(11) NOT NULL COMMENT '涉娼记录ID(p_zaperson_chang_t.id)',
                                             `personnelid` int(11) NOT NULL COMMENT '人员ID(冗余字段，便于查询)',
                                             `aj_id` int(11) NOT NULL COMMENT '案件ID(f_xt_xd_ajxx_new.id)',
                                             `sldw` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '打处单位(f_xt_xd_ajxx_new.sldw)',
                                             `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
                                             `validflag` int(2) DEFAULT 1 COMMENT '状态 1有效 0无效',
                                             `addtime` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建时间',
                                             PRIMARY KEY (`id`),
                                             KEY `idx_personnelid` (`personnelid`),
                                             KEY `idx_chang_id` (`chang_id`),
                                             KEY `idx_aj_id` (`aj_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT = '治安人员-涉娼记录与案件关联表';

-- ----------------------------
-- 涉娼记录 ↔ 警情 关联表
-- ----------------------------
DROP TABLE IF EXISTS `p_zaperson_chang_jq_rel_t`;

CREATE TABLE `p_zaperson_chang_jq_rel_t` (
                                             `id` int(11) NOT NULL AUTO_INCREMENT,
                                             `chang_id` int(11) NOT NULL COMMENT '涉娼记录ID(p_zaperson_chang_t.id)',
                                             `personnelid` int(11) NOT NULL COMMENT '人员ID(冗余字段，便于查询)',
                                             `jq_id` int(11) NOT NULL COMMENT '警情ID(f_xt_xd_jqxx_new.id)',
                                             `cjdw` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '打处单位(f_xt_xd_jqxx_new.cjdw)',
                                             `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
                                             `validflag` int(2) DEFAULT 1 COMMENT '状态 1有效 0无效',
                                             `addtime` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建时间',
                                             PRIMARY KEY (`id`),
                                             KEY `idx_personnelid` (`personnelid`),
                                             KEY `idx_chang_id` (`chang_id`),
                                             KEY `idx_jq_id` (`jq_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT = '治安人员-涉娼记录与警情关联表';

-- ----------------------------
-- 新增：陪侍人员表
-- ----------------------------
DROP TABLE IF EXISTS `p_zaperson_pei_t`;

CREATE TABLE `p_zaperson_pei_t` (
                                    `id` int(11) NOT NULL AUTO_INCREMENT,
                                    `personnelid` int(11) NULL DEFAULT 0 COMMENT '外键,人员主表id',
    -- 基本采集信息
                                    `collect_source` varchar(50) NULL COMMENT '采集来源(案件/警情/日常工作发现)',
                                    `collect_date` varchar(20) NULL COMMENT '采集日期',
                                    `activity_venue` varchar(255) NULL COMMENT '活动场所',
                                    `other_memo` varchar(500) NULL COMMENT '其他备注(选择其他时必填)',
    -- 现住地结构化信息
                                    `home_province` varchar(50) NULL COMMENT '现住-省',
                                    `home_city` varchar(50) NULL COMMENT '现住-地级市',
                                    `home_county` varchar(50) NULL COMMENT '现住-县级市/区',
                                    `home_town` varchar(50) NULL COMMENT '现住-镇/街道',
                                    `home_police_station_id` int(11) NULL COMMENT '现住-所属派出所ID(关联sys_department_t_new.id,江阴派出所ID:240-263)',
                                    `home_detail` varchar(255) NULL COMMENT '现住-详细地址',
                                    `home_lng` varchar(50) NULL COMMENT '现住-经度',
                                    `home_lat` varchar(50) NULL COMMENT '现住-纬度',
    -- 审计字段
                                    `addoperator` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '添加人',
                                    `addtime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '添加时间',
                                    `updateoperator` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最新修改人',
                                    `updatetime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最新修改时间',
                                    `memo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注信息',
                                    `validflag` int(11) NULL DEFAULT 1 COMMENT '状态标识',
                                    PRIMARY KEY (`id`) USING BTREE,
                                    KEY `idx_personnelid` (`personnelid`)
) ENGINE = InnoDB AUTO_INCREMENT = 5 DEFAULT CHARSET = utf8 COLLATE = utf8_general_ci COMMENT = '治安人员-陪侍人员' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- 陪侍记录 ↔ 案件 关联表
-- ----------------------------
DROP TABLE IF EXISTS `p_zaperson_pei_aj_rel_t`;

CREATE TABLE `p_zaperson_pei_aj_rel_t` (
                                           `id` int(11) NOT NULL AUTO_INCREMENT,
                                           `pei_id` int(11) NOT NULL COMMENT '陪侍记录ID(p_zaperson_pei_t.id)',
                                           `personnelid` int(11) NOT NULL COMMENT '人员ID(冗余字段，便于查询)',
                                           `aj_id` int(11) NOT NULL COMMENT '案件ID(f_xt_xd_ajxx_new.id)',
                                           `sldw` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '打处单位(f_xt_xd_ajxx_new.sldw)',
                                           `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
                                           `validflag` int(2) DEFAULT 1 COMMENT '状态 1有效 0无效',
                                           `addtime` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建时间',
                                           PRIMARY KEY (`id`),
                                           KEY `idx_personnelid` (`personnelid`),
                                           KEY `idx_pei_id` (`pei_id`),
                                           KEY `idx_aj_id` (`aj_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT = '治安人员-陪侍记录与案件关联表';

-- ----------------------------
-- 陪侍记录 ↔ 警情 关联表
-- ----------------------------
DROP TABLE IF EXISTS `p_zaperson_pei_jq_rel_t`;

CREATE TABLE `p_zaperson_pei_jq_rel_t` (
                                           `id` int(11) NOT NULL AUTO_INCREMENT,
                                           `pei_id` int(11) NOT NULL COMMENT '陪侍记录ID(p_zaperson_pei_t.id)',
                                           `personnelid` int(11) NOT NULL COMMENT '人员ID(冗余字段，便于查询)',
                                           `jq_id` int(11) NOT NULL COMMENT '警情ID(f_xt_xd_jqxx_new.id)',
                                           `cjdw` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '打处单位(f_xt_xd_jqxx_new.cjdw)',
                                           `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
                                           `validflag` int(2) DEFAULT 1 COMMENT '状态 1有效 0无效',
                                           `addtime` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建时间',
                                           PRIMARY KEY (`id`),
                                           KEY `idx_personnelid` (`personnelid`),
                                           KEY `idx_pei_id` (`pei_id`),
                                           KEY `idx_jq_id` (`jq_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT = '治安人员-陪侍记录与警情关联表';

-- =================================================================
-- 6. 治安人员标签新增 (治安人员相关)
-- =================================================================
INSERT INTO
    `p_attributelabel_t`
(
    `id`,
    `parentid`,
    `rootid`,
    `attributelabel`,
    `examineflag`,
    `validflag`,
    `adddepartmentid`,
    `addoperatorid`,
    `addoperator`,
    `addtime`
)
VALUES
    (
        5001,
        2046,
        2046,
        '陪侍人员',
        1,
        1,
        1,
        1,
        '管理员',
        NOW()
    ),
    (
        5002,
        2046,
        2046,
        '治安风险未成年人',
        1,
        1,
        1,
        1,
        '管理员',
        NOW()
    );


-- =================================================================
-- 7. 数据字典初始化 (治安人员相关)
-- =================================================================
-- 说明：
-- 1. 数据字典类型表：sys_basic_type_t (定义字典分类)
-- 2. 数据字典数据表：sys_basic_msg_t (存储具体字典项)
-- 3. 派出所数据直接使用 sys_department_t_new 表 (id: 240-263 为江阴24个派出所)
-- =================================================================
-- 7.0 首先插入数据字典类型定义 (sys_basic_type_t)
INSERT INTO
    `sys_basic_type_t` (
    `id`,
    `basicTypeName`,
    `isexternal`,
    `istree`,
    `externalid`,
    `validflag`,
    `addoperator`,
    `addtime`,
    `memo`
)
VALUES
    (
        301,
        '涉赌人员属性',
        0,
        0,
        0,
        1,
        'system',
        '2026-01-06',
        '治安-涉赌人员属性分类'
    ),
    (
        302,
        '涉赌方式',
        0,
        0,
        0,
        1,
        'system',
        '2026-01-06',
        '治安-涉赌方式分类'
    ),
    (
        303,
        '涉赌部位',
        0,
        0,
        0,
        1,
        'system',
        '2026-01-06',
        '治安-涉赌部位分类'
    ),
    (
        304,
        '涉娼人员属性',
        0,
        0,
        0,
        1,
        'system',
        '2026-01-06',
        '治安-涉娼人员属性分类'
    ),
    (
        305,
        '涉黄方式',
        0,
        0,
        0,
        1,
        'system',
        '2026-01-06',
        '治安-涉黄方式分类'
    ),
    (
        306,
        '涉黄类型',
        0,
        0,
        0,
        1,
        'system',
        '2026-01-06',
        '治安-涉黄类型分类'
    ),
    (
        307,
        '采集来源',
        0,
        0,
        0,
        1,
        'system',
        '2026-01-06',
        '治安-采集来源分类'
    ),
    (
        308,
        '涉娼部位',
        0,
        0,
        0,
        1,
        'system',
        '2026-01-06',
        '治安-涉娼部位分类'
    );

-- 7.1 涉赌人员属性 (basicType = 301)
INSERT INTO
    `sys_basic_msg_t` (
    `basicType`,
    `basicName`,
    `validflag`,
    `addoperator`,
    `addtime`,
    `sort`
)
VALUES
    (301, '赌博参与者', 1, 'system', '2026-01-06', 1),
    (301, '赌博组织者', 1, 'system', '2026-01-06', 2),
    (301, '赌博提供者', 1, 'system', '2026-01-06', 3),
    (301, '其他', 1, 'system', '2026-01-06', 99);

-- 7.2 涉赌方式 (basicType = 302)
INSERT INTO
    `sys_basic_msg_t` (
    `basicType`,
    `basicName`,
    `validflag`,
    `addoperator`,
    `addtime`,
    `sort`
)
VALUES
    (302, '二八杠', 1, 'system', '2026-01-06', 1),
    (302, '牛牛', 1, 'system', '2026-01-06', 2),
    (302, '扎金花', 1, 'system', '2026-01-06', 3),
    (302, '梭哈', 1, 'system', '2026-01-06', 4),
    (302, '牌九', 1, 'system', '2026-01-06', 5),
    (302, '赌球', 1, 'system', '2026-01-06', 6),
    (302, '网络赌博', 1, 'system', '2026-01-06', 7),
    (302, '跨境赌博', 1, 'system', '2026-01-06', 8),
    (302, '其他', 1, 'system', '2026-01-06', 99);

-- 7.3 涉赌部位 (basicType = 303)
INSERT INTO
    `sys_basic_msg_t` (
    `basicType`,
    `basicName`,
    `validflag`,
    `addoperator`,
    `addtime`,
    `sort`
)
VALUES
    (303, '棋牌麻将', 1, 'system', '2026-01-06', 1),
    (303, '宾馆酒店', 1, 'system', '2026-01-06', 2),
    (303, '居民住宅', 1, 'system', '2026-01-06', 3),
    (303, '小区车库', 1, 'system', '2026-01-06', 4),
    (303, '出租房屋', 1, 'system', '2026-01-06', 5),
    (303, '沿街店铺', 1, 'system', '2026-01-06', 6),
    (303, '厂企单位', 1, 'system', '2026-01-06', 7),
    (303, '电子游艺', 1, 'system', '2026-01-06', 8),
    (303, '野外涉赌', 1, 'system', '2026-01-06', 9),
    (303, '山麓区域', 1, 'system', '2026-01-06', 10),
    (303, '水域船只', 1, 'system', '2026-01-06', 11),
    (303, '单身公寓', 1, 'system', '2026-01-06', 12),
    (303, '网络涉赌', 1, 'system', '2026-01-06', 13),
    (303, '农贸市场', 1, 'system', '2026-01-06', 14),
    (303, '各类工地', 1, 'system', '2026-01-06', 15),
    (303, '其他', 1, 'system', '2026-01-06', 99);

-- 7.4 涉娼人员属性 (basicType = 304)
INSERT INTO
    `sys_basic_msg_t` (
    `basicType`,
    `basicName`,
    `validflag`,
    `addoperator`,
    `addtime`,
    `sort`
)
VALUES
    (304, '实际经营人', 1, 'system', '2026-01-06', 1),
    (304, '股东', 1, 'system', '2026-01-06', 2),
    (304, '经理', 1, 'system', '2026-01-06', 3),
    (304, '领班', 1, 'system', '2026-01-06', 4),
    (304, '鸡头', 1, 'system', '2026-01-06', 5),
    (304, '收银员', 1, 'system', '2026-01-06', 6),
    (304, '介绍人员', 1, 'system', '2026-01-06', 7),
    (304, '容留人员', 1, 'system', '2026-01-06', 8),
    (304, '键盘手', 1, 'system', '2026-01-06', 9),
    (304, '其他工作人员', 1, 'system', '2026-01-06', 10),
    (304, '卖淫人员', 1, 'system', '2026-01-06', 11),
    (304, '嫖娼人员', 1, 'system', '2026-01-06', 12),
    (304, '其他', 1, 'system', '2026-01-06', 99);

-- 7.5 涉黄方式 (basicType = 305)
INSERT INTO
    `sys_basic_msg_t` (
    `basicType`,
    `basicName`,
    `validflag`,
    `addoperator`,
    `addtime`,
    `sort`
)
VALUES
    (305, '性交', 1, 'system', '2026-01-06', 1),
    (305, '口淫', 1, 'system', '2026-01-06', 2),
    (305, '打飞机', 1, 'system', '2026-01-06', 3),
    (305, '其他', 1, 'system', '2026-01-06', 99);

-- 7.6 涉黄类型 (basicType = 306)
INSERT INTO
    `sys_basic_msg_t` (
    `basicType`,
    `basicName`,
    `validflag`,
    `addoperator`,
    `addtime`,
    `sort`
)
VALUES
    (306, '实体店涉黄', 1, 'system', '2026-01-06', 1),
    (306, '网络涉黄(OTO)', 1, 'system', '2026-01-06', 2),
    (306, '其他', 1, 'system', '2026-01-06', 99);

-- 7.7 采集来源 (basicType = 307)
INSERT INTO
    `sys_basic_msg_t` (
    `basicType`,
    `basicName`,
    `validflag`,
    `addoperator`,
    `addtime`,
    `sort`
)
VALUES
    (307, '案件', 1, 'system', '2026-01-06', 1),
    (307, '警情', 1, 'system', '2026-01-06', 2),
    (307, '日常工作发现', 1, 'system', '2026-01-06', 3);

-- 7.8 涉娼部位 (basicType = 308)
INSERT INTO
    `sys_basic_msg_t` (
    `basicType`,
    `basicName`,
    `validflag`,
    `addoperator`,
    `addtime`,
    `sort`
)
VALUES
    (308, 'KTV', 1, 'system', '2026-01-06', 1),
    (308, '舞厅', 1, 'system', '2026-01-06', 2),
    (308, '酒吧', 1, 'system', '2026-01-06', 3),
    (308, '茶吧茶室', 1, 'system', '2026-01-06', 4),
    (308, '桑拿洗浴', 1, 'system', '2026-01-06', 5),
    (308, '足浴按摩', 1, 'system', '2026-01-06', 6),
    (308, '美容美发', 1, 'system', '2026-01-06', 7),
    (308, '站街招嫖', 1, 'system', '2026-01-06', 8),
    (308, '宾馆酒店', 1, 'system', '2026-01-06', 9),
    (308, '居民住宅', 1, 'system', '2026-01-06', 10),
    (308, '出租房屋', 1, 'system', '2026-01-06', 11),
    (308, '单身公寓', 1, 'system', '2026-01-06', 12),
    (308, '网络涉黄', 1, 'system', '2026-01-06', 13),
    (308, '其他', 1, 'system', '2026-01-06', 99);

-- =================================================================
-- 8. 派出所关联视图 (用于查询时展示派出所名称)
-- =================================================================
-- 说明：江阴24个派出所数据存储在 sys_department_t_new 表中，ID范围：240-263
-- 以下视图用于方便查询时关联派出所名称
-- 8.1 人员基础信息关联派出所视图
DROP VIEW IF EXISTS `v_personnel_with_police_station`;

CREATE VIEW `v_personnel_with_police_station` AS
SELECT
    p.*,
    d.departname AS home_police_station_name,
    d.departcode AS home_police_station_code,
    d.lingwuid AS home_police_station_lingwuid
FROM
    `p_personnel_t` p
        LEFT JOIN `sys_department_t_new` d ON p.home_police_station_id = d.id
        AND d.validflag = 1;

-- 8.2 涉赌背景关联派出所视图
DROP VIEW IF EXISTS `v_zaperson_du_with_police_station`;

CREATE VIEW `v_zaperson_du_with_police_station` AS
SELECT
    du.*,
    d.departname AS home_police_station_name,
    d.departcode AS home_police_station_code,
    d.lingwuid AS home_police_station_lingwuid
FROM
    `p_zaperson_du_t` du
        LEFT JOIN `sys_department_t_new` d ON du.home_police_station_id = d.id
        AND d.validflag = 1;

-- 8.3 涉娼背景关联派出所视图
DROP VIEW IF EXISTS `v_zaperson_chang_with_police_station`;

CREATE VIEW `v_zaperson_chang_with_police_station` AS
SELECT
    c.*,
    d.departname AS home_police_station_name,
    d.departcode AS home_police_station_code,
    d.lingwuid AS home_police_station_lingwuid
FROM
    `p_zaperson_chang_t` c
        LEFT JOIN `sys_department_t_new` d ON c.home_police_station_id = d.id
        AND d.validflag = 1;

-- 8.4 住址历史关联派出所视图
DROP VIEW IF EXISTS `v_homeplace_history_with_police_station`;

CREATE VIEW `v_homeplace_history_with_police_station` AS
SELECT
    h.*,
    d.departname AS police_station_name,
    d.departcode AS police_station_code,
    d.lingwuid AS police_station_lingwuid
FROM
    `p_homeplace_history_t` h
        LEFT JOIN `sys_department_t_new` d ON h.police_station_id = d.id
        AND d.validflag = 1;

-- 8.5 江阴派出所列表查询视图 (用于前端下拉选择)
DROP VIEW IF EXISTS `v_jiangyin_police_stations`;

CREATE VIEW `v_jiangyin_police_stations` AS
SELECT
    id,
    departname,
    departcode,
    lingwuid
FROM
    `sys_department_t_new`
WHERE
    id BETWEEN 240
        AND 263
  AND validflag = 1
ORDER BY
    id;

SET
    FOREIGN_KEY_CHECKS = 1;