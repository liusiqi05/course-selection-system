# 选课系统 (Course Selection System)

## 简介

本项目是基于 [RuoYi-Vue](https://gitee.com/y_project/RuoYi-Vue) v3.9.0 框架二次开发的大学生选课系统。系统实现了从课程管理、开课申请、学生选课到成绩录入、教学评价的全流程业务闭环。

## 核心功能

### 1. 用户角色体系
系统包含四种主要角色，并在创建系统用户时自动同步至对应的业务人员表：
*   **系统管理员**：负责系统基础配置、菜单权限、字典管理等。
*   **教务处老师**：负责学期管理、课程库建设、审核开课申请、排课管理。
*   **教师**：负责提交开课申请、查看选课名单、录入学生成绩。
*   **学生**：负责网上选课、退课、查看课表、查询成绩、进行课程评价。

### 2. 业务模块
*   **基础数据**：学院管理、专业设置、班级管理、学期设置。
*   **课程管理**：
    *   **课程库**：维护学校所有开设课程的基本信息。
    *   **开课申请**：教师发起下学期开课意向。
    *   **开课安排**：教务处审核申请，设置上课时间、地点、容量。
*   **选课中心**：
    *   学生在选课时段内进行选课/退课操作。
    *   系统自动校验冲突（时间冲突、容量限制）。
*   **成绩与评价**：
    *   教师录入平时成绩、期末成绩。
    *   学生对修读课程进行匿名评价。

## 技术栈

### 后端
*   **核心框架**：Spring Boot 2.5.x
*   **安全框架**：Spring Security + JWT
*   **持久层**：MyBatis + PageHelper
*   **数据库**：MySQL 8.0
*   **缓存**：Redis
*   **工具**：Maven, Swagger

### 前端
*   **核心框架**：Vue 2.x
*   **UI组件库**：Element UI
*   **路由/状态**：Vue Router, Vuex
*   **网络请求**：Axios

## 快速开始

### 1. 环境要求
*   JDK >= 1.8
*   MySQL >= 5.7 (推荐 8.0)
*   Redis >= 3.0
*   Maven >= 3.0
*   Node.js >= 12

### 2. 后端启动
1.  **导入数据库**：
    *   创建数据库 `course_selection`。
    *   导入项目提供的 SQL 脚本（初始化表结构及数据）。
2.  **配置数据库**：
    *   修改 `ruoyi-admin/src/main/resources/application-druid.yml`，更新数据库连接地址、账号和密码。
3.  **编译运行**：
    ```bash
    # 进入项目根目录
    cd /path/to/CourseSelection

    # 编译项目
    mvn clean package -Dmaven.test.skip=true

    # 运行后端服务
    java -jar ruoyi-admin/target/ruoyi-admin.jar
    ```
    后端启动成功后，默认运行在 `8080` 端口。

### 3. 前端启动
1.  **安装依赖**：
    ```bash
    cd ruoyi-ui
    npm install --registry=https://registry.npmmirror.com
    ```
2.  **启动服务**：
    ```bash
    npm run dev
    ```
    前端启动成功后，浏览器访问 `http://localhost:80` (或控制台提示的端口)。

## 项目结构说明

```text
CourseSelection
├── ruoyi-admin         // 后台服务入口，包含 Controller 层
├── ruoyi-common        // 通用工具类
├── ruoyi-framework     // 框架核心配置
├── ruoyi-generator     // 代码生成模块
├── ruoyi-quartz        // 定时任务
├── ruoyi-system        // 系统模块 & 业务核心逻辑
│   └── src/main/java/com/ruoyi/system
│       ├── domain      // 包含 EduStudent, EduTeacher 等实体
│       └── mapper      // 包含对应的 DAO 接口
└── ruoyi-ui            // 前端 Vue 工程
```

## 特别说明
*   **数据同步机制**：在“系统管理-用户管理”中新增用户时，若选择了“学生”、“教师”或“教务处老师”角色，系统会自动在 `edu_student`、`edu_teacher` 或 `edu_office_teacher` 表中创建对应档案。
