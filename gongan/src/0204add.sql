
-- =================================================================
-- 1. 陪侍背景表 (p_zaperson_pei_t) 升级
-- =================================================================
ALTER TABLE
    `p_zaperson_pei_t` -- 4.2 补充属性
    ADD
        COLUMN `has_shechang_record` int(1) DEFAULT 0 COMMENT '涉黄前科';
-- =================================================================
-- 1. 涉赌背景表 (p_zaperson_du_t) 升级
-- =================================================================
ALTER TABLE
    `p_zaperson_du_t` -- 3.2 补充属性 (对应新需求的选择项)
    ADD
        COLUMN `handle_unit_code` varchar(255) NULL COMMENT '打处单位编码';
-- =================================================================
-- 1. 涉娼背景表 (p_zaperson_chang_t) 升级
-- =================================================================
ALTER TABLE
    `p_zaperson_chang_t` -- 3.2 补充属性 (对应新需求的选择项)
    ADD
        COLUMN `handle_unit_code` varchar(255) NULL COMMENT '打处单位编码';

-- =================================================================
-- 7. 数据字典初始化 (治安人员相关)
-- =================================================================
-- 说明：
-- 1. 数据字典类型表：sys_basic_type_t (定义字典分类)
-- 2. 数据字典数据表：sys_basic_msg_t (存储具体字典项)
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
        310,
        '陪侍人员角色标签',
        0,
        0,
        0,
        1,
        'system',
        '2026-02-24',
        '治安-陪侍人员角色标签'
    ),
    (
        311,
        '陪侍采集来源',
        0,
        0,
        0,
        1,
        'system',
        '2026-02-24',
        '治安-陪侍采集来源'
    );

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
    (310, '陪侍人员', 1, 'system', '2026-02-24', 1),
    (310, '助教', 1, 'system', '2026-02-24', 2),
    (310, '其他', 1, 'system', '2026-02-24', 99);

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
    (311, '涉警', 1, 'system', '2026-02-24', 1),
    (311, '涉案', 1, 'system', '2026-02-24', 2),
    (311, '从业人员登记', 1, 'system', '2026-02-24', 3),
    (311, '日常工作发现', 1, 'system', '2026-02-24', 4),
    (311, '其他', 1, 'system', '2026-02-24', 99);

-- =========================
-- 1. 涉赌涉娼相关字典项调整 (治安人员相关)
-- =========================
DELETE FROM sys_basic_msg_t
WHERE basicType IN (301,302,303,304,305);

-- =========================
-- 2. 插入新字典
-- =========================

-- 301 涉赌人员属性
INSERT INTO sys_basic_msg_t
(basicType, basicName, validflag, addoperator, addtime, sort)
VALUES
    (301,'赌场局头',1,'system',NOW(),1),
    (301,'赌场参股',1,'system',NOW(),2),
    (301,'抽庄风',1,'system',NOW(),3),
    (301,'拎庄风包',1,'system',NOW(),4),
    (301,'苍蝇头',1,'system',NOW(),5),
    (301,'接送司机',1,'system',NOW(),6),
    (301,'望风人员',1,'system',NOW(),7),
    (301,'放水人员',1,'system',NOW(),8),
    (301,'结算人员',1,'system',NOW(),9),
    (301,'提供场地人员',1,'system',NOW(),10),
    (301,'野外搭棚人员',1,'system',NOW(),11),
    (301,'网赌代理',1,'system',NOW(),12),
    (301,'线下参赌人员',1,'system',NOW(),13),
    (301,'网上参赌人员',1,'system',NOW(),14);


-- 302 涉赌方式
INSERT INTO sys_basic_msg_t
(basicType, basicName, validflag, addoperator, addtime, sort)
VALUES
    (302,'德州扑克',1,'system',NOW(),1),
    (302,'二八杠',1,'system',NOW(),2),
    (302,'牛牛',1,'system',NOW(),3),
    (302,'扎金花',1,'system',NOW(),4),
    (302,'梭哈',1,'system',NOW(),5),
    (302,'牌九',1,'system',NOW(),6),
    (302,'麻将',1,'system',NOW(),7),
    (302,'棋牌',1,'system',NOW(),8),
    (302,'赌球',1,'system',NOW(),9),
    (302,'赌博机',1,'system',NOW(),10),
    (302,'割罗莎',1,'system',NOW(),11),
    (302,'斗地主',1,'system',NOW(),12),
    (302,'跑得快',1,'system',NOW(),13),
    (302,'地下彩票',1,'system',NOW(),14),
    (302,'网络赌博',1,'system',NOW(),15),
    (302,'跨境赌博',1,'system',NOW(),16),
    (302,'其他赌博',1,'system',NOW(),17);


-- 303 涉赌部位
INSERT INTO sys_basic_msg_t
(basicType, basicName, validflag, addoperator, addtime, sort)
VALUES
    (303,'棋牌麻将',1,'system',NOW(),1),
    (303,'宾馆酒店',1,'system',NOW(),2),
    (303,'居民住宅',1,'system',NOW(),3),
    (303,'小区车库',1,'system',NOW(),4),
    (303,'出租房屋',1,'system',NOW(),5),
    (303,'沿街店铺',1,'system',NOW(),6),
    (303,'厂企单位',1,'system',NOW(),7),
    (303,'电子游艺',1,'system',NOW(),8),
    (303,'野外赌博',1,'system',NOW(),9),
    (303,'山麓区域',1,'system',NOW(),10),
    (303,'水域船只',1,'system',NOW(),11),
    (303,'单身公寓',1,'system',NOW(),12),
    (303,'网络涉赌',1,'system',NOW(),13),
    (303,'农贸市场',1,'system',NOW(),14),
    (303,'各类工地',1,'system',NOW(),15),
    (303,'其他',1,'system',NOW(),16);


-- 304 涉娼人员属性
INSERT INTO sys_basic_msg_t
(basicType, basicName, validflag, addoperator, addtime, sort)
VALUES
    (304,'实际经营人',1,'system',NOW(),1),
    (304,'股东',1,'system',NOW(),2),
    (304,'经理',1,'system',NOW(),3),
    (304,'领班',1,'system',NOW(),4),
    (304,'鸡头',1,'system',NOW(),5),
    (304,'收银员',1,'system',NOW(),6),
    (304,'介绍人员',1,'system',NOW(),7),
    (304,'接送人员',1,'system',NOW(),8),
    (304,'键盘手',1,'system',NOW(),9),
    (304,'卖淫人员',1,'system',NOW(),10),
    (304,'嫖娼人员',1,'system',NOW(),11),
    (304,'其他人员',1,'system',NOW(),12);


-- 305 涉黄方式
INSERT INTO sys_basic_msg_t
(basicType, basicName, validflag, addoperator, addtime, sort)
VALUES
    (305,'手淫',1,'system',NOW(),1),
    (305,'口淫',1,'system',NOW(),2),
    (305,'性交',1,'system',NOW(),3);

-- ============================================================================
-- 8. 全国行政区划数据字典转换（树形结构）
-- ============================================================================
-- 说明: 将gdmm_region区域数据转换为项目的数据字典表结构
-- 依赖: 需要先导入 shenshiqu.sql 文件中的gdmm_region表数据
-- 特点:
--   1. 使用单一basicType(500)管理所有层级的行政区划
--   2. 通过parentid构建完整的树形结构
--   3. 使用sort字段控制展示顺序
--   4. level_code保存在memo字段中便于追溯
-- ============================================================================

-- 8.1 幂等性处理：清理可能存在的旧数据
-- ============================================================================
-- 说明：如果脚本多次执行，先清理旧数据，避免重复插入
-- ============================================================================
DELETE FROM sys_basic_msg_t WHERE basicType = 500;
DELETE FROM sys_basic_type_t WHERE id = 500;

-- 8.2 创建行政区划数据字典类型
INSERT INTO `sys_basic_type_t` (
    `id`,
    `basicTypeName`,
    `isexternal`,
    `istree`,
    `externalid`,
    `validflag`,
    `addoperator`,
    `addtime`,
    `memo`,
    `parentid`
) VALUES (
    500,
    '行政区划',
    0,
    1,              -- 必须是树形结构
    0,
    1,
    'system',
    NOW(),
    '全国行政区划树结构（省-市-县区-镇街）',
    0
);

-- 8.3 迁移行政区划树（使用映射表方案避免主键冲突）
-- ============================================================================
-- 重要说明：
--   由于gdmm_region.id可能从1开始，而sys_basic_msg_t.id已使用1~4000，
--   必须使用自增ID，然后通过映射表修正parentid关系
-- ============================================================================

-- 步骤1：插入数据（暂时parentid使用原始parent_id，后续修正）
INSERT INTO `sys_basic_msg_t` (
    `basicType`,
    `basicName`,
    `basicPyCode`,
    `basicWbCode`,
    `validflag`,
    `addoperator`,
    `addtime`,
    `memo`,
    `parentid`,
    `sort`
) SELECT
    500,                                        -- basicType (所有层级统一使用500)
    r.name,                                     -- basicName
    NULL,                                       -- basicPyCode (可后续补充)
    NULL,                                       -- basicWbCode (可后续补充)
    1,                                          -- validflag
    'system',                                   -- addoperator
    NOW(),                                      -- addtime
    CONCAT('region_code:', r.level_code, '|old_id:', r.id),  -- memo (保存原始编码和ID)
    r.parent_id,                                -- parentid (暂存原始parent_id，后续修正)
    r.id                                        -- sort (按原始id排序)
FROM gdmm_region r
ORDER BY r.parent_id, r.id;

-- 第二步：创建临时映射表（old_id → new_id）
CREATE TEMPORARY TABLE IF NOT EXISTS region_id_map (
    old_id INT,
    new_id INT,
    PRIMARY KEY (old_id),
    INDEX idx_new_id (new_id)
);

-- 第三步：填充映射表（从memo字段提取old_id，对应新的自增id）
INSERT INTO region_id_map (old_id, new_id)
SELECT
    CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(memo, 'old_id:', -1), '|', 1) AS UNSIGNED) AS old_id,
    id AS new_id
FROM sys_basic_msg_t
WHERE basicType = 500;

-- 第四步：修正parentid（使用映射表将old_id转换为new_id）
UPDATE sys_basic_msg_t t
INNER JOIN region_id_map rm ON t.parentid = rm.old_id
SET t.parentid = rm.new_id
WHERE t.basicType = 500;

-- 步骤5：修正顶级节点（原始parent_id为-1或0的记录）
-- 说明：统一处理所有顶级节点，无需判断memo内容
UPDATE sys_basic_msg_t
SET parentid = 0
WHERE basicType = 500
  AND (parentid = -1 OR parentid = 0);

-- 步骤6：清理临时映射表
DROP TEMPORARY TABLE IF EXISTS region_id_map;

-- ============================================================================
-- 数据验证和统计查询
-- ============================================================================

-- 统计各层级数据量
/*
SELECT '========== 行政区划数据统计 ==========' AS '状态';

SELECT
    '总数据量' AS '类型',
    COUNT(*) AS '数量'
FROM sys_basic_msg_t
WHERE basicType = 500

UNION ALL

SELECT
    '顶级节点(国家)' AS '类型',
    COUNT(*) AS '数量'
FROM sys_basic_msg_t
WHERE basicType = 500 AND parentid = -1

UNION ALL

SELECT
    '省级(parentid=0)' AS '类型',
    COUNT(*) AS '数量'
FROM sys_basic_msg_t
WHERE basicType = 500
  AND parentid = (SELECT id FROM sys_basic_msg_t WHERE basicType = 500 AND parentid = -1 LIMIT 1)

UNION ALL

SELECT
    '其他层级' AS '类型',
    COUNT(*) AS '数量'
FROM sys_basic_msg_t
WHERE basicType = 500
  AND parentid NOT IN (-1, 0)
  AND parentid NOT IN (SELECT id FROM sys_basic_msg_t WHERE basicType = 500 AND parentid = -1);

-- ============================================================================
-- 完成提示
-- ============================================================================
SELECT '
============================================================
行政区划树形数据字典导入完成！

查询示例：
1. 查询所有行政区划：
   SELECT * FROM sys_basic_msg_t WHERE basicType = 500 ORDER BY parentid, sort;

2. 查询省级（以北京为例，假设id=1）：
   SELECT * FROM sys_basic_msg_t WHERE basicType = 500 AND parentid = 0;

3. 查询某省下的市（以北京市为例）：
   SELECT * FROM sys_basic_msg_t WHERE basicType = 500 AND parentid = 1;

4. 查询某市下的区县：
   SELECT * FROM sys_basic_msg_t WHERE basicType = 500 AND parentid = 37;

回滚方法：
   DELETE FROM sys_basic_msg_t WHERE basicType = 500;
   DELETE FROM sys_basic_type_t WHERE id = 500;
============================================================
' AS '使用说明';
 */
