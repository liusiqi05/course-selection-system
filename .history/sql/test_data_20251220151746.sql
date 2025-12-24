-- =============================================
-- 选课系统测试数据
-- 包含真实的教师、学生、课程数据
-- =============================================

-- ----------------------------
-- 1、新增教师用户 (密码统一为: 123456)
-- ----------------------------
-- 密码 123456 的BCrypt加密值
SET @pwd = '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2';

-- 教师用户
INSERT INTO sys_user(user_id, dept_id, user_name, nick_name, email, phonenumber, sex, password, status, create_by, create_time, remark)
VALUES 
(102, 103, 'teacher02', '王建国', 'wangjianguo@university.edu.cn', '13800138002', '0', @pwd, '0', 'admin', NOW(), '计算机学院教授'),
(103, 103, 'teacher03', '李春华', 'lichunhua@university.edu.cn', '13800138003', '1', @pwd, '0', 'admin', NOW(), '计算机学院副教授'),
(104, 104, 'teacher04', '刘明远', 'liumingyuan@university.edu.cn', '13800138004', '0', @pwd, '0', 'admin', NOW(), '数学学院教授'),
(105, 105, 'teacher05', '陈晓燕', 'chenxiaoyan@university.edu.cn', '13800138005', '1', @pwd, '0', 'admin', NOW(), '外语学院讲师');

-- 分配教师角色
INSERT INTO sys_user_role(user_id, role_id) VALUES 
(102, 2), (103, 2), (104, 2), (105, 2);

-- 创建教师扩展信息
INSERT INTO edu_teacher(user_id, title, education, research_area, create_by, create_time, remark)
VALUES 
(102, '教授', '博士', '数据库系统、大数据分析', 'admin', NOW(), '博士生导师'),
(103, '副教授', '博士', '软件工程、程序设计', 'admin', NOW(), '硕士生导师'),
(104, '教授', '博士', '高等数学、线性代数', 'admin', NOW(), '教学名师'),
(105, '讲师', '硕士', '英语语言文学', 'admin', NOW(), '大学英语教研室');

-- ----------------------------
-- 2、新增学生用户 (密码统一为: 123456)
-- ----------------------------
INSERT INTO sys_user(user_id, dept_id, user_name, nick_name, email, phonenumber, sex, password, status, create_by, create_time, remark)
VALUES 
(106, 103, '2021001', '张伟', 'zhangwei@stu.university.edu.cn', '15900001001', '0', @pwd, '0', 'admin', NOW(), '计算机科学与技术专业'),
(107, 103, '2021002', '王芳', 'wangfang@stu.university.edu.cn', '15900001002', '1', @pwd, '0', 'admin', NOW(), '软件工程专业'),
(108, 103, '2021003', '李强', 'liqiang@stu.university.edu.cn', '15900001003', '0', @pwd, '0', 'admin', NOW(), '计算机科学与技术专业'),
(109, 104, '2021004', '赵静', 'zhaojing@stu.university.edu.cn', '15900001004', '1', @pwd, '0', 'admin', NOW(), '信息与计算科学专业'),
(110, 103, '2021005', '刘洋', 'liuyang@stu.university.edu.cn', '15900001005', '0', @pwd, '0', 'admin', NOW(), '软件工程专业'),
(111, 103, '2022001', '陈明', 'chenming@stu.university.edu.cn', '15900002001', '0', @pwd, '0', 'admin', NOW(), '计算机科学与技术专业'),
(112, 103, '2022002', '杨雪', 'yangxue@stu.university.edu.cn', '15900002002', '1', @pwd, '0', 'admin', NOW(), '软件工程专业'),
(113, 104, '2022003', '周杰', 'zhoujie@stu.university.edu.cn', '15900002003', '0', @pwd, '0', 'admin', NOW(), '数学与应用数学专业'),
(114, 103, '2022004', '吴婷', 'wuting@stu.university.edu.cn', '15900002004', '1', @pwd, '0', 'admin', NOW(), '计算机科学与技术专业'),
(115, 103, '2022005', '孙磊', 'sunlei@stu.university.edu.cn', '15900002005', '0', @pwd, '0', 'admin', NOW(), '软件工程专业');

-- 分配学生角色
INSERT INTO sys_user_role(user_id, role_id) VALUES 
(106, 3), (107, 3), (108, 3), (109, 3), (110, 3),
(111, 3), (112, 3), (113, 3), (114, 3), (115, 3);

-- 创建学生扩展信息
INSERT INTO edu_student(user_id, class_name, enrollment_date, expected_graduation, student_status, create_by, create_time, remark)
VALUES 
(106, '计科2101班', '2021-09-01', '2025-06-30', '0', 'admin', NOW(), '班长'),
(107, '软工2101班', '2021-09-01', '2025-06-30', '0', 'admin', NOW(), '学习委员'),
(108, '计科2101班', '2021-09-01', '2025-06-30', '0', 'admin', NOW(), NULL),
(109, '信计2101班', '2021-09-01', '2025-06-30', '0', 'admin', NOW(), NULL),
(110, '软工2101班', '2021-09-01', '2025-06-30', '0', 'admin', NOW(), '体育委员'),
(111, '计科2201班', '2022-09-01', '2026-06-30', '0', 'admin', NOW(), NULL),
(112, '软工2201班', '2022-09-01', '2026-06-30', '0', 'admin', NOW(), '文艺委员'),
(113, '数学2201班', '2022-09-01', '2026-06-30', '0', 'admin', NOW(), NULL),
(114, '计科2201班', '2022-09-01', '2026-06-30', '0', 'admin', NOW(), '团支书'),
(115, '软工2201班', '2022-09-01', '2026-06-30', '0', 'admin', NOW(), NULL);

-- ----------------------------
-- 3、新增课程数据
-- ----------------------------
INSERT INTO edu_course(course_code, course_name, dept_id, credit, hours, course_type, description, status, create_by, create_time)
VALUES 
('CS101', '计算机导论', 103, 2.0, 32, '1', '计算机科学基础入门课程，介绍计算机的基本概念、发展历史和应用领域', '0', 'admin', NOW()),
('CS201', '数据结构', 103, 4.0, 64, '1', '讲授常用数据结构及其算法，包括线性表、树、图等', '0', 'admin', NOW()),
('CS202', '操作系统', 103, 3.5, 56, '1', '介绍操作系统的基本原理，包括进程管理、内存管理、文件系统等', '0', 'admin', NOW()),
('CS203', '计算机网络', 103, 3.0, 48, '1', '讲授计算机网络的基本原理和TCP/IP协议体系', '0', 'admin', NOW()),
('CS301', '数据库原理', 103, 3.5, 56, '1', '数据库系统的基本概念、关系模型、SQL语言及数据库设计', '0', 'admin', NOW()),
('CS302', '软件工程', 103, 3.0, 48, '1', '软件开发的基本方法和过程，包括需求分析、设计、测试等', '0', 'admin', NOW()),
('CS401', '人工智能导论', 103, 3.0, 48, '2', '人工智能的基本概念、搜索算法、机器学习入门', '0', 'admin', NOW()),
('CS402', 'Python程序设计', 103, 2.5, 40, '2', 'Python语言基础及其在数据分析中的应用', '0', 'admin', NOW()),
('MA101', '高等数学(上)', 104, 5.0, 80, '1', '函数、极限、导数、积分的基本概念和计算方法', '0', 'admin', NOW()),
('MA102', '高等数学(下)', 104, 5.0, 80, '1', '多元函数微积分、无穷级数、常微分方程', '0', 'admin', NOW()),
('MA201', '线性代数', 104, 3.0, 48, '1', '矩阵、行列式、线性方程组、特征值与特征向量', '0', 'admin', NOW()),
('MA202', '概率论与数理统计', 104, 3.0, 48, '1', '随机事件与概率、随机变量及其分布、统计推断', '0', 'admin', NOW()),
('EN101', '大学英语(1)', 105, 2.0, 32, '1', '大学英语基础课程，提高听说读写能力', '0', 'admin', NOW()),
('EN102', '大学英语(2)', 105, 2.0, 32, '1', '大学英语进阶课程，强化综合应用能力', '0', 'admin', NOW()),
('GE001', '体育(1)', 100, 1.0, 32, '1', '体育基础课程，增强体质', '0', 'admin', NOW()),
('GE002', '创新创业基础', 100, 2.0, 32, '3', '创新思维与创业实践入门', '0', 'admin', NOW());

-- ----------------------------
-- 4、新增开课数据 (2024-2025学年第二学期)
-- ----------------------------
INSERT INTO edu_course_opening(term_id, course_id, teacher_id, class_time, class_location, max_students, selected_num, status, create_by, create_time)
VALUES 
-- 计算机学院课程
(2, (SELECT course_id FROM edu_course WHERE course_code='CS201'), 2, '周一3-4节,周三3-4节', '教学楼A301', 60, 0, '0', 'admin', NOW()),
(2, (SELECT course_id FROM edu_course WHERE course_code='CS202'), 3, '周二1-2节,周四1-2节', '教学楼A302', 50, 0, '0', 'admin', NOW()),
(2, (SELECT course_id FROM edu_course WHERE course_code='CS301'), 2, '周一5-6节,周四5-6节', '教学楼B201', 45, 0, '0', 'admin', NOW()),
(2, (SELECT course_id FROM edu_course WHERE course_code='CS302'), 3, '周三1-2节,周五1-2节', '教学楼B202', 55, 0, '0', 'admin', NOW()),
(2, (SELECT course_id FROM edu_course WHERE course_code='CS401'), 1, '周二5-6节,周五5-6节', '教学楼A401', 40, 0, '0', 'admin', NOW()),
(2, (SELECT course_id FROM edu_course WHERE course_code='CS402'), 1, '周三5-6节', '机房C101', 35, 0, '0', 'admin', NOW()),
-- 数学学院课程
(2, (SELECT course_id FROM edu_course WHERE course_code='MA102'), 4, '周一1-2节,周三1-2节,周五1-2节', '教学楼D101', 120, 0, '0', 'admin', NOW()),
(2, (SELECT course_id FROM edu_course WHERE course_code='MA201'), 4, '周二3-4节,周四3-4节', '教学楼D102', 100, 0, '0', 'admin', NOW()),
(2, (SELECT course_id FROM edu_course WHERE course_code='MA202'), 4, '周一7-8节,周三7-8节', '教学楼D103', 80, 0, '0', 'admin', NOW()),
-- 外语学院课程
(2, (SELECT course_id FROM edu_course WHERE course_code='EN102'), 5, '周二7-8节,周四7-8节', '外语楼E201', 40, 0, '0', 'admin', NOW()),
(2, (SELECT course_id FROM edu_course WHERE course_code='EN102'), 5, '周一7-8节,周三7-8节', '外语楼E202', 40, 0, '0', 'admin', NOW()),
-- 公共课
(2, (SELECT course_id FROM edu_course WHERE course_code='GE002'), 1, '周六上午', '创业园区', 100, 0, '0', 'admin', NOW());

-- ----------------------------
-- 5、模拟部分选课数据
-- ----------------------------
-- 获取学生ID和开课ID
SET @stu1 = (SELECT student_id FROM edu_student WHERE user_id = 106);
SET @stu2 = (SELECT student_id FROM edu_student WHERE user_id = 107);
SET @stu3 = (SELECT student_id FROM edu_student WHERE user_id = 108);
SET @stu4 = (SELECT student_id FROM edu_student WHERE user_id = 111);
SET @stu5 = (SELECT student_id FROM edu_student WHERE user_id = 112);

-- 选课记录
INSERT INTO edu_student_course(student_id, open_id, enroll_time, score, status, create_by, create_time)
SELECT @stu1, open_id, NOW(), NULL, '0', 'admin', NOW() 
FROM edu_course_opening WHERE course_id = (SELECT course_id FROM edu_course WHERE course_code='CS201');

INSERT INTO edu_student_course(student_id, open_id, enroll_time, score, status, create_by, create_time)
SELECT @stu1, open_id, NOW(), NULL, '0', 'admin', NOW() 
FROM edu_course_opening WHERE course_id = (SELECT course_id FROM edu_course WHERE course_code='CS401');

INSERT INTO edu_student_course(student_id, open_id, enroll_time, score, status, create_by, create_time)
SELECT @stu2, open_id, NOW(), NULL, '0', 'admin', NOW() 
FROM edu_course_opening WHERE course_id = (SELECT course_id FROM edu_course WHERE course_code='CS201');

INSERT INTO edu_student_course(student_id, open_id, enroll_time, score, status, create_by, create_time)
SELECT @stu2, open_id, NOW(), NULL, '0', 'admin', NOW() 
FROM edu_course_opening WHERE course_id = (SELECT course_id FROM edu_course WHERE course_code='CS302');

INSERT INTO edu_student_course(student_id, open_id, enroll_time, score, status, create_by, create_time)
SELECT @stu3, open_id, NOW(), NULL, '0', 'admin', NOW() 
FROM edu_course_opening WHERE course_id = (SELECT course_id FROM edu_course WHERE course_code='MA102');

INSERT INTO edu_student_course(student_id, open_id, enroll_time, score, status, create_by, create_time)
SELECT @stu4, open_id, NOW(), NULL, '0', 'admin', NOW() 
FROM edu_course_opening WHERE course_id = (SELECT course_id FROM edu_course WHERE course_code='CS402');

INSERT INTO edu_student_course(student_id, open_id, enroll_time, score, status, create_by, create_time)
SELECT @stu5, open_id, NOW(), NULL, '0', 'admin', NOW() 
FROM edu_course_opening WHERE course_id = (SELECT course_id FROM edu_course WHERE course_code='GE002');

-- 更新开课的已选人数
UPDATE edu_course_opening SET selected_num = (
    SELECT COUNT(*) FROM edu_student_course WHERE edu_student_course.open_id = edu_course_opening.open_id AND status = '0'
);

SELECT '测试数据导入完成！' AS message;
