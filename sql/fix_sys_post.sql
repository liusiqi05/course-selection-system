-- 创建 sys_post 表（若依框架必需）
drop table if exists sys_post;
create table sys_post (
  post_id       bigint(20)      not null auto_increment    comment '岗位ID',
  post_code     varchar(64)     not null                   comment '岗位编码',
  post_name     varchar(50)     not null                   comment '岗位名称',
  post_sort     int(4)          not null                   comment '显示顺序',
  status        char(1)         not null                   comment '状态（0正常 1停用）',
  create_by     varchar(64)     default ''                 comment '创建者',
  create_time   datetime                                   comment '创建时间',
  update_by     varchar(64)     default ''                 comment '更新者',
  update_time   datetime                                   comment '更新时间',
  remark        varchar(500)    default null               comment '备注',
  primary key (post_id)
) engine=innodb auto_increment=5 comment = '岗位信息表';

-- 初始化岗位数据
insert into sys_post values(1, 'admin',   '系统管理员', 1, '0', 'admin', sysdate(), '', null, '');
insert into sys_post values(2, 'teacher', '教师',       2, '0', 'admin', sysdate(), '', null, '');
insert into sys_post values(3, 'student', '学生',       3, '0', 'admin', sysdate(), '', null, '');

-- 同时确保 sys_user_post 表存在
drop table if exists sys_user_post;
create table sys_user_post (
  user_id   bigint(20) not null comment '用户ID',
  post_id   bigint(20) not null comment '岗位ID',
  primary key (user_id, post_id)
) engine=innodb comment = '用户与岗位关联表';

-- 初始化用户岗位关联
insert into sys_user_post values ('1', '1');
insert into sys_user_post values ('2', '2');
insert into sys_user_post values ('3', '3');
