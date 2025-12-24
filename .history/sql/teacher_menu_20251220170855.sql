-- 教师功能菜单
-- 添加"我的课程"菜单（教师查看自己开设的课程）
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES (4010, '我的课程', 4000, 10, 'teacherCourse', 'education/teacherCourse/index', NULL, 1, 0, 'C', '0', '0', 'education:teacherCourse:list', 'notebook', 'admin', NOW(), '', NULL, '教师查看自己的开课列表');

-- 添加"学生名单"菜单（教师查看选课学生，隐藏菜单用于路由）
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES (4011, '学生名单', 4000, 11, 'teacherStudent', 'education/teacherStudent/index', NULL, 1, 0, 'C', '1', '0', 'education:teacherStudent:list', 'peoples', 'admin', NOW(), '', NULL, '教师查看课程学生名单');

-- 我的课程权限按钮
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES (4012, '查询我的课程', 4010, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'education:teacherCourse:list', '#', 'admin', NOW(), '', NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES (4013, '修改课程信息', 4010, 2, '', NULL, NULL, 1, 0, 'F', '0', '0', 'education:teacherCourse:edit', '#', 'admin', NOW(), '', NULL, '');

-- 学生名单权限按钮
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES (4014, '查询学生名单', 4011, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'education:teacherStudent:list', '#', 'admin', NOW(), '', NULL, '');
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES (4015, '录入成绩', 4011, 2, '', NULL, NULL, 1, 0, 'F', '0', '0', 'education:teacherStudent:edit', '#', 'admin', NOW(), '', NULL, '');

-- 为教师角色(role_id=2)分配菜单权限
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 4010);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 4011);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 4012);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 4013);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 4014);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 4015);
