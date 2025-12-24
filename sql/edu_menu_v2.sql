-- ----------------------------
-- 教务管理系统菜单SQL (修正版)
-- 运行此SQL前请确保 edu_tables.sql 已执行
-- ----------------------------

-- 菜单 教务管理
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(4000, '教务管理', 0, 5, 'education', null, '', '', 1, 0, 'M', '0', '0', '', 'education', 'admin', sysdate(), '', null, '教务管理目录');

-- 菜单 学期管理
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(4001, '学期管理', 4000, 1, 'term', 'education/term/index', '', '', 1, 0, 'C', '0', '0', 'education:term:list', 'date', 'admin', sysdate(), '', null, '学期管理菜单');

-- 学期管理按钮
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(4011, '学期查询', 4001, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'education:term:query', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(4012, '学期新增', 4001, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'education:term:add', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(4013, '学期修改', 4001, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'education:term:edit', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(4014, '学期删除', 4001, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'education:term:remove', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(4015, '学期导出', 4001, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'education:term:export', '#', 'admin', sysdate(), '', null, '');

-- 菜单 学生管理
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(4002, '学生管理', 4000, 2, 'student', 'education/student/index', '', '', 1, 0, 'C', '0', '0', 'education:student:list', 'peoples', 'admin', sysdate(), '', null, '学生管理菜单');

-- 学生管理按钮
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(4021, '学生查询', 4002, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'education:student:query', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(4022, '学生新增', 4002, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'education:student:add', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(4023, '学生修改', 4002, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'education:student:edit', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(4024, '学生删除', 4002, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'education:student:remove', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(4025, '学生导出', 4002, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'education:student:export', '#', 'admin', sysdate(), '', null, '');

-- 菜单 教师管理
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(4003, '教师管理', 4000, 3, 'teacher', 'education/teacher/index', '', '', 1, 0, 'C', '0', '0', 'education:teacher:list', 'user', 'admin', sysdate(), '', null, '教师管理菜单');

-- 教师管理按钮
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(4031, '教师查询', 4003, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'education:teacher:query', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(4032, '教师新增', 4003, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'education:teacher:add', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(4033, '教师修改', 4003, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'education:teacher:edit', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(4034, '教师删除', 4003, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'education:teacher:remove', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(4035, '教师导出', 4003, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'education:teacher:export', '#', 'admin', sysdate(), '', null, '');

-- 菜单 课程管理
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(4004, '课程管理', 4000, 4, 'course', 'education/course/index', '', '', 1, 0, 'C', '0', '0', 'education:course:list', 'list', 'admin', sysdate(), '', null, '课程管理菜单');

-- 课程管理按钮
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(4041, '课程查询', 4004, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'education:course:query', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(4042, '课程新增', 4004, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'education:course:add', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(4043, '课程修改', 4004, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'education:course:edit', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(4044, '课程删除', 4004, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'education:course:remove', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(4045, '课程导出', 4004, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'education:course:export', '#', 'admin', sysdate(), '', null, '');

-- 菜单 开课安排
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(4005, '开课安排', 4000, 5, 'opening', 'education/opening/index', '', '', 1, 0, 'C', '0', '0', 'education:opening:list', 'time-range', 'admin', sysdate(), '', null, '开课安排菜单');

-- 开课安排按钮
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(4051, '开课查询', 4005, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'education:opening:query', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(4052, '开课新增', 4005, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'education:opening:add', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(4053, '开课修改', 4005, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'education:opening:edit', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(4054, '开课删除', 4005, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'education:opening:remove', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(4055, '开课导出', 4005, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'education:opening:export', '#', 'admin', sysdate(), '', null, '');

-- 菜单 选课记录
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(4006, '选课记录', 4000, 6, 'selection', 'education/selection/index', '', '', 1, 0, 'C', '0', '0', 'education:selection:list', 'checkbox', 'admin', sysdate(), '', null, '选课记录菜单');

-- 选课记录按钮
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(4061, '选课查询', 4006, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'education:selection:query', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(4062, '选课新增', 4006, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'education:selection:add', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(4063, '选课修改', 4006, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'education:selection:edit', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(4064, '选课删除', 4006, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'education:selection:remove', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(4065, '选课导出', 4006, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'education:selection:export', '#', 'admin', sysdate(), '', null, '');

-- 菜单 学生选课 (学生角色专用)
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(4007, '学生选课', 4000, 7, 'enroll', 'education/selection/enroll', '', '', 1, 0, 'C', '0', '0', 'education:selection:enroll', 'shopping', 'admin', sysdate(), '', null, '学生选课菜单');

-- ----------------------------
-- 角色菜单权限分配
-- ----------------------------
-- 为教师角色(2)分配权限
INSERT INTO sys_role_menu(role_id, menu_id) VALUES (2, 4000);  -- 教务管理目录
INSERT INTO sys_role_menu(role_id, menu_id) VALUES (2, 4004);  -- 课程管理
INSERT INTO sys_role_menu(role_id, menu_id) VALUES (2, 4041);  -- 课程查询
INSERT INTO sys_role_menu(role_id, menu_id) VALUES (2, 4005);  -- 开课安排
INSERT INTO sys_role_menu(role_id, menu_id) VALUES (2, 4051);  -- 开课查询
INSERT INTO sys_role_menu(role_id, menu_id) VALUES (2, 4052);  -- 开课新增
INSERT INTO sys_role_menu(role_id, menu_id) VALUES (2, 4053);  -- 开课修改
INSERT INTO sys_role_menu(role_id, menu_id) VALUES (2, 4006);  -- 选课记录
INSERT INTO sys_role_menu(role_id, menu_id) VALUES (2, 4061);  -- 选课查询
INSERT INTO sys_role_menu(role_id, menu_id) VALUES (2, 4063);  -- 选课修改(录成绩)

-- 为学生角色(3)分配权限
INSERT INTO sys_role_menu(role_id, menu_id) VALUES (3, 4000);  -- 教务管理目录
INSERT INTO sys_role_menu(role_id, menu_id) VALUES (3, 4007);  -- 学生选课
