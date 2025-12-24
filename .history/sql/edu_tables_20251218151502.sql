-- =============================================
-- 选课系统业务表 - 基于若依框架
-- 创建时间: 2025-12-18
-- 说明: 本文件包含选课系统核心业务表
-- =============================================

-- ----------------------------
-- 1、学期信息表
-- ----------------------------
drop table if exists edu_term;
create table edu_term (
  term_id           bigint(20)      not null auto_increment    comment '学期ID',
  term_name         varchar(64)     not null                   comment '学期名称 (如: 2024-2025学年第一学期)',
  start_date        date            default null               comment '学期开始日期',
  end_date          date            default null               comment '学期结束日期',
  is_current        char(1)         default '0'                comment '是否当前学期 (0否 1是)',
  status            char(1)         default '0'                comment '状态 (0正常 1停用)',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time       datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  remark            varchar(500)    default null               comment '备注',
  primary key (term_id)
) engine=innodb auto_increment=1 comment = '学期信息表';

-- ----------------------------
-- 初始化-学期数据
-- ----------------------------
insert into edu_term values(1, '2024-2025学年第一学期', '2024-09-01', '2025-01-15', '0', '0', 'admin', sysdate(), '', null, '秋季学期');
insert into edu_term values(2, '2024-2025学年第二学期', '2025-02-17', '2025-07-05', '1', '0', 'admin', sysdate(), '', null, '春季学期（当前）');


-- ----------------------------
-- 2、学生信息表 (扩展信息，基础信息在sys_user中)
-- ----------------------------
drop table if exists edu_student;
create table edu_student (
  student_id        bigint(20)      not null auto_increment    comment '学生ID',
  user_id           bigint(20)      not null                   comment '关联系统用户ID (sys_user.user_id)',
  class_name        varchar(64)     default ''                 comment '班级名称',
  enrollment_date   date            default null               comment '入学日期',
  expected_graduation date          default null               comment '预计毕业日期',
  student_status    char(1)         default '0'                comment '学籍状态 (0在读 1毕业 2休学 3退学)',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time       datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  remark            varchar(500)    default null               comment '备注',
  primary key (student_id),
  unique key uk_user_id (user_id)
) engine=innodb auto_increment=1 comment = '学生信息表';

-- ----------------------------
-- 初始化-学生数据 (关联sys_user中user_id=3的学生)
-- ----------------------------
insert into edu_student values(1, 3, '计科2101班', '2021-09-01', '2025-06-30', '0', 'admin', sysdate(), '', null, '测试学生');


-- ----------------------------
-- 3、教师信息表 (扩展信息，基础信息在sys_user中)
-- ----------------------------
drop table if exists edu_teacher;
create table edu_teacher (
  teacher_id        bigint(20)      not null auto_increment    comment '教师ID',
  user_id           bigint(20)      not null                   comment '关联系统用户ID (sys_user.user_id)',
  title             varchar(30)     default ''                 comment '职称 (教授/副教授/讲师/助教)',
  education         varchar(20)     default ''                 comment '学历 (博士/硕士/学士)',
  research_area     varchar(200)    default ''                 comment '研究方向',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time       datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  remark            varchar(500)    default null               comment '备注',
  primary key (teacher_id),
  unique key uk_user_id (user_id)
) engine=innodb auto_increment=1 comment = '教师信息表';

-- ----------------------------
-- 初始化-教师数据 (关联sys_user中user_id=2的教师)
-- ----------------------------
insert into edu_teacher values(1, 2, '教授', '博士', '人工智能、机器学习', 'admin', sysdate(), '', null, '测试教师');


-- ----------------------------
-- 4、课程信息表
-- ----------------------------
drop table if exists edu_course;
create table edu_course (
  course_id         bigint(20)      not null auto_increment    comment '课程ID',
  course_code       varchar(20)     not null                   comment '课程代码',
  course_name       varchar(64)     not null                   comment '课程名称',
  dept_id           bigint(20)      default null               comment '开课学院ID',
  credit            decimal(3,1)    not null default 0         comment '学分',
  hours             int(4)          default 0                  comment '学时',
  course_type       char(1)         default '1'                comment '课程类型 (1必修 2选修 3公选)',
  description       varchar(500)    default ''                 comment '课程简介',
  status            char(1)         default '0'                comment '状态 (0正常 1停用)',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time       datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  remark            varchar(500)    default null               comment '备注',
  primary key (course_id),
  unique key uk_course_code (course_code)
) engine=innodb auto_increment=1 comment = '课程信息表';

-- ----------------------------
-- 初始化-课程数据
-- ----------------------------
insert into edu_course values(1, 'CS101', '程序设计基础', 101, 4.0, 64, '1', 'C语言程序设计入门课程', '0', 'admin', sysdate(), '', null, '');
insert into edu_course values(2, 'CS201', '数据结构', 101, 4.0, 64, '1', '数据结构与算法基础', '0', 'admin', sysdate(), '', null, '');
insert into edu_course values(3, 'CS301', '操作系统', 101, 3.5, 56, '1', '计算机操作系统原理', '0', 'admin', sysdate(), '', null, '');
insert into edu_course values(4, 'CS401', '计算机网络', 101, 3.0, 48, '1', '计算机网络原理与应用', '0', 'admin', sysdate(), '', null, '');
insert into edu_course values(5, 'GE101', '大学英语', 104, 2.0, 32, '1', '大学英语基础课程', '0', 'admin', sysdate(), '', null, '');
insert into edu_course values(6, 'GE201', '高等数学', 105, 4.0, 64, '1', '高等数学基础', '0', 'admin', sysdate(), '', null, '');
insert into edu_course values(7, 'EL101', 'Python编程', 101, 2.0, 32, '2', 'Python程序设计选修课', '0', 'admin', sysdate(), '', null, '');
insert into edu_course values(8, 'EL102', '人工智能导论', 101, 2.0, 32, '3', 'AI入门公选课', '0', 'admin', sysdate(), '', null, '');


-- ----------------------------
-- 5、开课安排表 (某学期某课程由某老师开设)
-- ----------------------------
drop table if exists edu_course_opening;
create table edu_course_opening (
  open_id           bigint(20)      not null auto_increment    comment '开课ID',
  term_id           bigint(20)      not null                   comment '学期ID',
  course_id         bigint(20)      not null                   comment '课程ID',
  teacher_id        bigint(20)      not null                   comment '授课教师ID (edu_teacher.teacher_id)',
  class_time        varchar(100)    default ''                 comment '上课时间 (如: 周一1-2节,周三3-4节)',
  class_location    varchar(100)    default ''                 comment '上课地点',
  max_students      int(4)          default 50                 comment '课程容量',
  selected_num      int(4)          default 0                  comment '已选人数',
  status            char(1)         default '0'                comment '状态 (0报名中 1已开课 2已结课)',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time       datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  remark            varchar(500)    default null               comment '备注',
  primary key (open_id),
  key idx_term_course (term_id, course_id)
) engine=innodb auto_increment=1 comment = '开课安排表';

-- ----------------------------
-- 初始化-开课数据 (当前学期, teacher_id关联edu_teacher)
-- ----------------------------
insert into edu_course_opening values(1, 2, 1, 1, '周一1-2节,周三1-2节', '教学楼A101', 60, 1, '0', 'admin', sysdate(), '', null, '');
insert into edu_course_opening values(2, 2, 2, 1, '周二3-4节,周四3-4节', '教学楼A102', 50, 0, '0', 'admin', sysdate(), '', null, '');
insert into edu_course_opening values(3, 2, 3, 1, '周一5-6节,周三5-6节', '教学楼B201', 45, 0, '0', 'admin', sysdate(), '', null, '');
insert into edu_course_opening values(4, 2, 5, 1, '周二1-2节', '教学楼C301', 80, 0, '0', 'admin', sysdate(), '', null, '');
insert into edu_course_opening values(5, 2, 7, 1, '周五1-2节', '机房D101', 40, 0, '0', 'admin', sysdate(), '', null, '');
insert into edu_course_opening values(6, 2, 8, 1, '周四7-8节', '教学楼A201', 100, 0, '0', 'admin', sysdate(), '', null, '');


-- ----------------------------
-- 6、选课记录表 (学生选课与成绩)
-- ----------------------------
drop table if exists edu_student_course;
create table edu_student_course (
  sc_id             bigint(20)      not null auto_increment    comment '选课记录ID',
  student_id        bigint(20)      not null                   comment '学生ID (edu_student.student_id)',
  open_id           bigint(20)      not null                   comment '开课ID',
  score             decimal(5,2)    default null               comment '成绩',
  enroll_time       datetime                                   comment '选课时间',
  status            char(1)         default '0'                comment '状态 (0正常 1退课)',
  create_by         varchar(64)     default ''                 comment '创建者',
  create_time       datetime                                   comment '创建时间',
  update_by         varchar(64)     default ''                 comment '更新者',
  update_time       datetime                                   comment '更新时间',
  remark            varchar(500)    default null               comment '备注',
  primary key (sc_id),
  unique key uk_student_open (student_id, open_id) comment '防止重复选课'
) engine=innodb auto_increment=1 comment = '选课记录表';

-- ----------------------------
-- 初始化-选课数据 (student_id=1 对应 edu_student 中的记录)
-- ----------------------------
insert into edu_student_course values(1, 1, 1, null, sysdate(), '0', 'admin', sysdate(), '', null, '');


-- ----------------------------
-- 7、字典类型数据 (选课系统专用)
-- ----------------------------
insert into sys_dict_type values(100, '课程类型', 'edu_course_type', '0', 'admin', sysdate(), '', null, '课程类型列表');
insert into sys_dict_type values(101, '学生状态', 'edu_student_status', '0', 'admin', sysdate(), '', null, '学生在校状态');
insert into sys_dict_type values(102, '选课状态', 'edu_selection_status', '0', 'admin', sysdate(), '', null, '选课记录状态');
insert into sys_dict_type values(103, '开课状态', 'edu_opening_status', '0', 'admin', sysdate(), '', null, '开课安排状态');

-- ----------------------------
-- 8、字典数据
-- ----------------------------
-- 课程类型
insert into sys_dict_data values(1001, 1, '必修课', '1', 'edu_course_type', '', 'primary', 'N', '0', 'admin', sysdate(), '', null, '');
insert into sys_dict_data values(1002, 2, '选修课', '2', 'edu_course_type', '', 'success', 'N', '0', 'admin', sysdate(), '', null, '');
insert into sys_dict_data values(1003, 3, '公选课', '3', 'edu_course_type', '', 'info', 'N', '0', 'admin', sysdate(), '', null, '');
-- 学生状态
insert into sys_dict_data values(1004, 1, '在读', '0', 'edu_student_status', '', 'success', 'Y', '0', 'admin', sysdate(), '', null, '');
insert into sys_dict_data values(1005, 2, '毕业', '1', 'edu_student_status', '', 'info', 'N', '0', 'admin', sysdate(), '', null, '');
insert into sys_dict_data values(1006, 3, '休学', '2', 'edu_student_status', '', 'warning', 'N', '0', 'admin', sysdate(), '', null, '');
insert into sys_dict_data values(1007, 4, '退学', '3', 'edu_student_status', '', 'danger', 'N', '0', 'admin', sysdate(), '', null, '');
-- 选课状态
insert into sys_dict_data values(1008, 1, '正常', '0', 'edu_selection_status', '', 'success', 'Y', '0', 'admin', sysdate(), '', null, '');
insert into sys_dict_data values(1009, 2, '退课', '1', 'edu_selection_status', '', 'info', 'N', '0', 'admin', sysdate(), '', null, '');
-- 开课状态
insert into sys_dict_data values(1010, 1, '报名中', '0', 'edu_opening_status', '', 'primary', 'Y', '0', 'admin', sysdate(), '', null, '');
insert into sys_dict_data values(1011, 2, '已开课', '1', 'edu_opening_status', '', 'success', 'N', '0', 'admin', sysdate(), '', null, '');
insert into sys_dict_data values(1012, 3, '已结课', '2', 'edu_opening_status', '', 'info', 'N', '0', 'admin', sysdate(), '', null, '');
