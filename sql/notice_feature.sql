-- ================================================
-- 系统公告功能配置
-- 功能：让教务处老师可以管理首页显示的公告
-- 日期：2025-12-30
-- ================================================

-- 1. 添加初始公告数据（如果数据库中已有公告，可忽略此部分）
INSERT INTO sys_notice (notice_title, notice_type, notice_content, status, create_by, create_time) 
VALUES 
('2025-2026学年第一学期选课已开始', '2', 
'各位同学：

本学期选课系统现已开放，请各位同学在规定时间内完成选课。选课时间为12月20日至12月30日，请合理安排时间，避免课程冲突。

教务处
2025年12月20日', 
'0', 'admin', NOW()),

('选课时间：12月20日-12月30日', '1', 
'本学期选课时间为12月20日至12月30日，请各位同学及时登录系统完成选课。', 
'0', 'admin', NOW()),

('请同学们合理安排选课时间，避免课程冲突', '1', 
'选课时请注意查看课程时间，避免课程时间冲突。系统会自动检测时间冲突并给出提示。', 
'0', 'admin', NOW());

-- 2. 给教务处角色添加公告管理权限
-- 菜单ID 107: 通知公告主菜单
-- 菜单ID 1035: 公告查询
-- 菜单ID 1036: 公告新增
-- 菜单ID 1037: 公告修改
-- 菜单ID 1038: 公告删除

-- 先检查是否已存在权限，避免重复插入
INSERT INTO sys_role_menu (role_id, menu_id)
SELECT 4, 107 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 4 AND menu_id = 107);

INSERT INTO sys_role_menu (role_id, menu_id)
SELECT 4, 1035 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 4 AND menu_id = 1035);

INSERT INTO sys_role_menu (role_id, menu_id)
SELECT 4, 1036 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 4 AND menu_id = 1036);

INSERT INTO sys_role_menu (role_id, menu_id)
SELECT 4, 1037 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 4 AND menu_id = 1037);

INSERT INTO sys_role_menu (role_id, menu_id)
SELECT 4, 1038 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 4 AND menu_id = 1038);

-- 3. 验证配置
-- 查看公告数据
SELECT notice_id, notice_title, notice_type, status, create_time 
FROM sys_notice 
ORDER BY create_time DESC 
LIMIT 5;

-- 查看教务处角色的公告权限
SELECT m.menu_name, m.path, m.perms
FROM sys_role_menu rm
JOIN sys_menu m ON rm.menu_id = m.menu_id
WHERE rm.role_id = 4 AND m.menu_name LIKE '%公告%'
ORDER BY m.menu_id;
