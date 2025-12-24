-- ----------------------------
-- 教务管理系统菜单SQL
-- 运行此SQL前请确保 edu_tables.sql 已执行
-- ----------------------------

-- 菜单 教务管理
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2000, '教务管理', 0, 5, 'education', null, '', '', 1, 0, 'M', '0', '0', '', 'education', 'admin', sysdate(), '', null, '教务管理目录');

-- 菜单 学期管理
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2001, '学期管理', 2000, 1, 'term', 'education/term/index', '', '', 1, 0, 'C', '0', '0', 'education:term:list', 'date', 'admin', sysdate(), '', null, '学期管理菜单');

-- 学期管理按钮
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2011, '学期查询', 2001, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'education:term:query', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2012, '学期新增', 2001, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'education:term:add', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2013, '学期修改', 2001, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'education:term:edit', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2014, '学期删除', 2001, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'education:term:remove', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2015, '学期导出', 2001, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'education:term:export', '#', 'admin', sysdate(), '', null, '');

-- 菜单 学生管理
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2002, '学生管理', 2000, 2, 'student', 'education/student/index', '', '', 1, 0, 'C', '0', '0', 'education:student:list', 'peoples', 'admin', sysdate(), '', null, '学生管理菜单');

-- 学生管理按钮
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2021, '学生查询', 2002, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'education:student:query', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2022, '学生新增', 2002, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'education:student:add', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2023, '学生修改', 2002, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'education:student:edit', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2024, '学生删除', 2002, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'education:student:remove', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2025, '学生导出', 2002, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'education:student:export', '#', 'admin', sysdate(), '', null, '');

-- 菜单 教师管理
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2003, '教师管理', 2000, 3, 'teacher', 'education/teacher/index', '', '', 1, 0, 'C', '0', '0', 'education:teacher:list', 'user', 'admin', sysdate(), '', null, '教师管理菜单');

-- 教师管理按钮
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2031, '教师查询', 2003, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'education:teacher:query', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2032, '教师新增', 2003, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'education:teacher:add', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2033, '教师修改', 2003, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'education:teacher:edit', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2034, '教师删除', 2003, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'education:teacher:remove', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2035, '教师导出', 2003, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'education:teacher:export', '#', 'admin', sysdate(), '', null, '');

-- 菜单 课程管理
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2004, '课程管理', 2000, 4, 'course', 'education/course/index', '', '', 1, 0, 'C', '0', '0', 'education:course:list', 'list', 'admin', sysdate(), '', null, '课程管理菜单');

-- 课程管理按钮
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2041, '课程查询', 2004, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'education:course:query', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2042, '课程新增', 2004, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'education:course:add', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2043, '课程修改', 2004, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'education:course:edit', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2044, '课程删除', 2004, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'education:course:remove', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2045, '课程导出', 2004, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'education:course:export', '#', 'admin', sysdate(), '', null, '');

-- 菜单 开课安排
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2005, '开课安排', 2000, 5, 'opening', 'education/opening/index', '', '', 1, 0, 'C', '0', '0', 'education:opening:list', 'time-range', 'admin', sysdate(), '', null, '开课安排菜单');

-- 开课安排按钮
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2051, '开课查询', 2005, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'education:opening:query', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2052, '开课新增', 2005, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'education:opening:add', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2053, '开课修改', 2005, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'education:opening:edit', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2054, '开课删除', 2005, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'education:opening:remove', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2055, '开课导出', 2005, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'education:opening:export', '#', 'admin', sysdate(), '', null, '');

-- 菜单 选课记录
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2006, '选课记录', 2000, 6, 'selection', 'education/selection/index', '', '', 1, 0, 'C', '0', '0', 'education:selection:list', 'checkbox', 'admin', sysdate(), '', null, '选课记录菜单');

-- 选课记录按钮
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2061, '选课查询', 2006, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'education:selection:query', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2062, '选课新增', 2006, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'education:selection:add', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2063, '选课修改', 2006, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'education:selection:edit', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2064, '选课删除', 2006, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'education:selection:remove', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2065, '选课导出', 2006, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'education:selection:export', '#', 'admin', sysdate(), '', null, '');

-- 菜单 学生选课 (学生角色专用)
INSERT INTO sys_menu(menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
VALUES(2007, '学生选课', 2000, 7, 'enroll', 'education/selection/enroll', '', '', 1, 0, 'C', '0', '0', 'education:selection:enroll', 'shopping', 'admin', sysdate(), '', null, '学生选课菜单');

-- ----------------------------
-- 角色菜单权限分配
-- ----------------------------
-- 为管理员角色(1)分配教务管理权限 (通常管理员已有所有权限，以下仅作示例)
-- INSERT INTO sys_role_menu(role_id, menu_id) VALUES (1, 2000);
-- ... 省略管理员权限分配

-- 为教师角色(2)分配权限
INSERT INTO sys_role_menu(role_id, menu_id) VALUES (2, 2000);  -- 教务管理目录
INSERT INTO sys_role_menu(role_id, menu_id) VALUES (2, 2004);  -- 课程管理
INSERT INTO sys_role_menu(role_id, menu_id) VALUES (2, 2041);  -- 课程查询
INSERT INTO sys_role_menu(role_id, menu_id) VALUES (2, 2005);  -- 开课安排
INSERT INTO sys_role_menu(role_id, menu_id) VALUES (2, 2051);  -- 开课查询
INSERT INTO sys_role_menu(role_id, menu_id) VALUES (2, 2052);  -- 开课新增
INSERT INTO sys_role_menu(role_id, menu_id) VALUES (2, 2053);  -- 开课修改
INSERT INTO sys_role_menu(role_id, menu_id) VALUES (2, 2006);  -- 选课记录
INSERT INTO sys_role_menu(role_id, menu_id) VALUES (2, 2061);  -- 选课查询
INSERT INTO sys_role_menu(role_id, menu_id) VALUES (2, 2063);  -- 选课修改(录成绩)

-- 为学生角色(3)分配权限
INSERT INTO sys_role_menu(role_id, menu_id) VALUES (3, 2000);  -- 教务管理目录
INSERT INTO sys_role_menu(role_id, menu_id) VALUES (3, 2007);  -- 学生选课
