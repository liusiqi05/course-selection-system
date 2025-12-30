<template>
  <div class="app-container home">
    <!-- 顶部大横幅 - 使用玉兰花图片 -->
    <div class="hero-banner">
      <div class="hero-overlay"></div>
      <div class="hero-content">
        <h1>上海大学选课系统</h1>
        <p>欢迎您，<b>{{ nickName }}</b> <el-tag size="mini" effect="plain" type="info">{{ roleName }}</el-tag></p>
        <div class="term-info">
          <i class="el-icon-date"></i>
          当前学期：<b>{{ currentTerm || '未设置' }}</b>
        </div>
      </div>
    </div>

    <!-- 统计数据卡片 -->
    <el-row :gutter="20" class="stats-row">
      <el-col :xs="8" :sm="8" :md="8">
        <div class="stat-card stat-card-blue">
          <div class="stat-icon">
            <i class="el-icon-notebook-2"></i>
          </div>
          <div class="stat-info">
            <div class="stat-num">{{ courseCount }}</div>
            <div class="stat-label">开课数量</div>
          </div>
        </div>
      </el-col>
      <el-col :xs="8" :sm="8" :md="8">
        <div class="stat-card stat-card-green">
          <div class="stat-icon">
            <i class="el-icon-user"></i>
          </div>
          <div class="stat-info">
            <div class="stat-num">{{ studentCount }}</div>
            <div class="stat-label">学生人数</div>
          </div>
        </div>
      </el-col>
      <el-col :xs="8" :sm="8" :md="8">
        <div class="stat-card stat-card-orange">
          <div class="stat-icon">
            <i class="el-icon-s-custom"></i>
          </div>
          <div class="stat-info">
            <div class="stat-num">{{ teacherCount }}</div>
            <div class="stat-label">教师人数</div>
          </div>
        </div>
      </el-col>
    </el-row>

    <!-- 主体内容区域 -->
    <el-row :gutter="20">
      <!-- 左侧 - 快捷入口和选课指南 -->
      <el-col :xs="24" :sm="24" :md="14">
        <!-- 快捷功能 -->
        <div class="content-card">
          <div class="card-header">
            <i class="el-icon-menu"></i>
            <span>快捷入口</span>
          </div>
          <el-row :gutter="12" class="quick-grid">
            <el-col :xs="8" :sm="6" :md="6" v-for="item in quickLinks" :key="item.path">
              <div class="quick-item" @click="goTo(item.path)">
                <div class="quick-icon" :style="{ background: item.color }">
                  <i :class="item.icon"></i>
                </div>
                <span>{{ item.name }}</span>
              </div>
            </el-col>
          </el-row>
        </div>

        <!-- 选课指南 -->
        <div class="content-card">
          <div class="card-header">
            <i class="el-icon-guide"></i>
            <span>选课指南</span>
          </div>
          <div class="guide-steps">
            <div class="step-item">
              <div class="step-num">1</div>
              <div class="step-content">
                <div class="step-title">查看课程</div>
                <div class="step-desc">浏览当前学期开设的所有课程</div>
              </div>
            </div>
            <div class="step-arrow"><i class="el-icon-right"></i></div>
            <div class="step-item">
              <div class="step-num">2</div>
              <div class="step-content">
                <div class="step-title">选择课程</div>
                <div class="step-desc">根据个人情况选择合适的课程</div>
              </div>
            </div>
            <div class="step-arrow"><i class="el-icon-right"></i></div>
            <div class="step-item">
              <div class="step-num">3</div>
              <div class="step-content">
                <div class="step-title">确认选课</div>
                <div class="step-desc">提交选课申请并等待确认</div>
              </div>
            </div>
            <div class="step-arrow"><i class="el-icon-right"></i></div>
            <div class="step-item">
              <div class="step-num">4</div>
              <div class="step-content">
                <div class="step-title">查看结果</div>
                <div class="step-desc">查看选课结果和课程表</div>
              </div>
            </div>
          </div>
        </div>
      </el-col>

      <!-- 右侧 - 公告和图书馆图片 -->
      <el-col :xs="24" :sm="24" :md="10">
        <!-- 校园风光 -->
        <div class="content-card campus-card">
          <div class="card-header">
            <i class="el-icon-picture-outline"></i>
            <span>校园风光</span>
          </div>
          <div class="campus-image">
            <img src="../assets/images/campus-library.jpg" alt="上海大学图书馆" />
            <div class="campus-caption">上海大学图书馆</div>
          </div>
        </div>

        <!-- 系统公告 -->
        <div class="content-card">
          <div class="card-header">
            <i class="el-icon-bell"></i>
            <span>系统公告</span>
          </div>
          <div class="notice-list">
            <div class="notice-item" v-for="(notice, index) in notices" :key="index">
              <el-tag size="mini" :type="notice.type" effect="dark">{{ notice.tag }}</el-tag>
              <span class="notice-text">{{ notice.title }}</span>
              <span class="notice-date">{{ notice.date }}</span>
            </div>
          </div>
        </div>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import { getCurrentTerm } from "@/api/education/term"
import { listNotice } from "@/api/system/notice"
import request from '@/utils/request'

export default {
  name: "Index",
  data() {
    return {
      currentTerm: '',
      courseCount: 0,
      studentCount: 0,
      teacherCount: 0,
      // 所有快捷入口定义
      allQuickLinks: {
        // 管理员专用
        termManage: { name: '学期管理', path: '/education/term', icon: 'el-icon-date', color: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)' },
        courseManage: { name: '课程管理', path: '/education/course', icon: 'el-icon-notebook-2', color: 'linear-gradient(135deg, #f093fb 0%, #f5576c 100%)' },
        openingManage: { name: '开课管理', path: '/education/opening', icon: 'el-icon-s-grid', color: 'linear-gradient(135deg, #4facfe 0%, #00f2fe 100%)' },
        studentEnroll: { name: '学生选课', path: '/education/enroll', icon: 'el-icon-edit-outline', color: 'linear-gradient(135deg, #43e97b 0%, #38f9d7 100%)' },
        studentInfo: { name: '学生信息', path: '/education/student', icon: 'el-icon-user', color: 'linear-gradient(135deg, #fa709a 0%, #fee140 100%)' },
        teacherInfo: { name: '教师信息', path: '/education/teacher', icon: 'el-icon-s-custom', color: 'linear-gradient(135deg, #a8edea 0%, #fed6e3 100%)' },
        scoreManage: { name: '成绩管理', path: '/education/scoreManage', icon: 'el-icon-s-claim', color: 'linear-gradient(135deg, #ff9a9e 0%, #fecfef 100%)' },
        courseApprove: { name: '申请审批', path: '/education/courseApprove', icon: 'el-icon-s-check', color: 'linear-gradient(135deg, #a1c4fd 0%, #c2e9fb 100%)' },
        evaluationAdmin: { name: '评价管理', path: '/education/evaluationAdmin', icon: 'el-icon-chat-line-square', color: 'linear-gradient(135deg, #ffecd2 0%, #fcb69f 100%)' },
        // 教师专用
        courseApply: { name: '开课申请', path: '/education/courseApply', icon: 'el-icon-document-add', color: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)' },
        teacherCourse: { name: '我的课程', path: '/education/teacherCourse', icon: 'el-icon-notebook-2', color: 'linear-gradient(135deg, #f093fb 0%, #f5576c 100%)' },
        inputScore: { name: '录入成绩', path: '/education/scoreInput', icon: 'el-icon-edit', color: 'linear-gradient(135deg, #4facfe 0%, #00f2fe 100%)' },
        teacherSchedule: { name: '教师课表', path: '/education/schedule/teacher', icon: 'el-icon-date', color: 'linear-gradient(135deg, #43e97b 0%, #38f9d7 100%)' },
        evaluationTeacher: { name: '评价反馈', path: '/education/evaluationTeacher', icon: 'el-icon-chat-dot-round', color: 'linear-gradient(135deg, #fa709a 0%, #fee140 100%)' },
        // 学生专用
        selectCourse: { name: '选课中心', path: '/education/enroll', icon: 'el-icon-shopping-cart-2', color: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)' },
        myCourse: { name: '我的课程', path: '/education/selection', icon: 'el-icon-notebook-2', color: 'linear-gradient(135deg, #f093fb 0%, #f5576c 100%)' },
        myScore: { name: '成绩查询', path: '/education/myScore', icon: 'el-icon-trophy', color: 'linear-gradient(135deg, #4facfe 0%, #00f2fe 100%)' },
        courseTable: { name: '我的课表', path: '/education/schedule/student', icon: 'el-icon-date', color: 'linear-gradient(135deg, #43e97b 0%, #38f9d7 100%)' }
      },
      notices: []
    }
  },
  computed: {
    ...mapGetters(['name', 'roles']),
    nickName() {
      return this.$store.state.user.name || '用户'
    },
    roleName() {
      const roles = this.$store.state.user.roles || []
      if (roles.includes('admin')) return '管理员'
      if (roles.includes('leader')) return '教务处老师'
      if (roles.includes('teacher')) return '教师'
      if (roles.includes('student')) return '学生'
      return '普通用户'
    },
    // 根据角色返回不同的快捷入口
    quickLinks() {
      const roles = this.$store.state.user.roles || []
      const links = this.allQuickLinks
      
      // 管理员：显示所有管理功能
      if (roles.includes('admin')) {
        return [
          links.termManage,
          links.courseManage,
          links.openingManage,
          links.studentEnroll,
          links.studentInfo,
          links.teacherInfo,
          links.scoreManage,
          links.courseApprove,
          links.evaluationAdmin
        ]
      }
      
      // 教务处老师：管理功能，但不显示学生选课
      if (roles.includes('leader')) {
        return [
          links.termManage,
          links.courseManage,
          links.openingManage,
          links.studentInfo,
          links.teacherInfo,
          links.scoreManage,
          links.courseApprove,
          links.evaluationAdmin
        ]
      }
      
      // 教师：显示教师相关功能
      if (roles.includes('teacher')) {
        return [
          links.courseApply,
          links.teacherCourse,
          links.inputScore,
          links.teacherSchedule,
          links.evaluationTeacher
        ]
      }
      
      // 学生：显示学生相关功能
      if (roles.includes('student')) {
        return [
          links.selectCourse,
          links.myCourse,
          links.myScore,
          links.courseTable
        ]
      }
      
      // 默认返回空数组
      return []
    }
  },
  created() {
    this.loadCurrentTerm()
    this.loadStatistics()
    this.loadNotices()
  },
  methods: {
    goTo(path) {
      this.$router.push(path)
    },
    loadCurrentTerm() {
      getCurrentTerm().then(res => {
        if (res.data) {
          this.currentTerm = res.data.termName
        }
      }).catch(() => {})
    },
    loadStatistics() {
      request({
        url: '/education/home/statistics',
        method: 'get'
      }).then(res => {
        // 确保数据类型和值的一致性
        if (res && res.data) {
          this.courseCount = res.data.courseCount !== undefined ? parseInt(res.data.courseCount) : 0
          this.studentCount = res.data.studentCount !== undefined ? parseInt(res.data.studentCount) : 0
          this.teacherCount = res.data.teacherCount !== undefined ? parseInt(res.data.teacherCount) : 0
        } else {
          // 接口返回异常格式时的默认值
          this.courseCount = 0
          this.studentCount = 0
          this.teacherCount = 0
        }
      }).catch(error => {
        // 接口异常时使用默认值
        console.error('获取统计数据失败:', error)
        this.courseCount = 0
        this.studentCount = 0
        this.teacherCount = 0
      })
    },
    loadNotices() {
      listNotice({ pageNum: 1, pageSize: 5, status: '0' }).then(res => {
        if (res.rows && res.rows.length > 0) {
          this.notices = res.rows.map(notice => {
            // 将数据库字段映射到前端显示格式
            let tag = '提示'
            let type = 'info'
            
            // notice_type: 1-通知公告 2-系统消息
            // 这里根据notice_type或其他字段来决定标签
            if (notice.noticeType === '1') {
              tag = '通知'
              type = 'warning'
            } else if (notice.noticeType === '2') {
              tag = '重要'
              type = 'danger'
            }
            
            return {
              tag: tag,
              type: type,
              title: notice.noticeTitle,
              date: notice.createTime ? notice.createTime.substring(0, 10) : ''
            }
          })
        }
      }).catch(error => {
        console.error('获取公告失败:', error)
      })
    }
  }
}
</script>

<style scoped lang="scss">
.home {
  padding: 0;
  background: #f5f7fa;
  min-height: calc(100vh - 84px);
}

/* 顶部大横幅 */
.hero-banner {
  position: relative;
  height: 200px;
  background-image: url('../assets/images/campus-magnolia.jpg');
  background-size: cover;
  background-position: center;
  margin: -20px -20px 20px -20px;
  display: flex;
  align-items: center;
  justify-content: center;
  
  .hero-overlay {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: linear-gradient(135deg, rgba(0, 82, 147, 0.7) 0%, rgba(0, 40, 80, 0.8) 100%);
  }
  
  .hero-content {
    position: relative;
    z-index: 1;
    text-align: center;
    color: #fff;
    
    h1 {
      font-size: 32px;
      font-weight: 600;
      margin: 0 0 12px 0;
      letter-spacing: 4px;
      text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
    }
    
    p {
      font-size: 16px;
      margin: 0 0 15px 0;
      opacity: 0.95;
      
      b {
        color: #ffd700;
        margin-right: 8px;
      }
      
      .el-tag {
        background: rgba(255, 255, 255, 0.2);
        border: 1px solid rgba(255, 255, 255, 0.3);
        color: #fff;
      }
    }
    
    .term-info {
      font-size: 14px;
      background: rgba(255, 255, 255, 0.15);
      padding: 8px 20px;
      border-radius: 20px;
      display: inline-block;
      
      i {
        margin-right: 6px;
      }
      
      b {
        color: #ffd700;
      }
    }
  }
}

/* 统计卡片 */
.stats-row {
  padding: 0 20px;
  margin-bottom: 20px;
}

.stat-card {
  display: flex;
  align-items: center;
  padding: 20px;
  border-radius: 12px;
  color: #fff;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  
  .stat-icon {
    width: 50px;
    height: 50px;
    border-radius: 12px;
    background: rgba(255, 255, 255, 0.2);
    display: flex;
    align-items: center;
    justify-content: center;
    margin-right: 15px;
    
    i {
      font-size: 24px;
    }
  }
  
  .stat-info {
    .stat-num {
      font-size: 28px;
      font-weight: 700;
    }
    
    .stat-label {
      font-size: 13px;
      opacity: 0.9;
      margin-top: 2px;
    }
  }
}

.stat-card-blue {
  background: linear-gradient(135deg, #005293 0%, #0077b6 100%);
}

.stat-card-green {
  background: linear-gradient(135deg, #00a676 0%, #00c896 100%);
}

.stat-card-orange {
  background: linear-gradient(135deg, #f39c12 0%, #f1c40f 100%);
}

/* 内容卡片 */
.content-card {
  background: #fff;
  border-radius: 12px;
  margin: 0 20px 20px 20px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
  overflow: hidden;
  
  .card-header {
    padding: 15px 20px;
    border-bottom: 1px solid #f0f0f0;
    font-size: 16px;
    font-weight: 600;
    color: #1a1a1a;
    
    i {
      margin-right: 8px;
      color: #005293;
    }
  }
}

/* 快捷入口 */
.quick-grid {
  padding: 20px 15px 10px;
}

.quick-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 15px 8px;
  margin-bottom: 10px;
  cursor: pointer;
  transition: all 0.3s;
  border-radius: 10px;
  
  &:hover {
    background: #f5f7fa;
    transform: translateY(-3px);
  }
  
  .quick-icon {
    width: 48px;
    height: 48px;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-bottom: 10px;
    
    i {
      font-size: 22px;
      color: #fff;
    }
  }
  
  span {
    font-size: 12px;
    color: #666;
    text-align: center;
  }
}

/* 选课指南 */
.guide-steps {
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
  padding: 25px 20px;
  flex-wrap: wrap;
  
  .step-item {
    display: flex;
    align-items: flex-start;
    flex: 1;
    min-width: 100px;
    
    .step-num {
      width: 32px;
      height: 32px;
      border-radius: 50%;
      background: linear-gradient(135deg, #005293 0%, #0077b6 100%);
      color: #fff;
      display: flex;
      align-items: center;
      justify-content: center;
      font-weight: 600;
      margin-right: 10px;
      flex-shrink: 0;
    }
    
    .step-content {
      .step-title {
        font-size: 14px;
        font-weight: 600;
        color: #1a1a1a;
        margin-bottom: 4px;
      }
      
      .step-desc {
        font-size: 12px;
        color: #999;
        line-height: 1.4;
      }
    }
  }
  
  .step-arrow {
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 0 8px;
    color: #ddd;
    font-size: 18px;
    margin-top: 6px;
  }
}

/* 校园风光 */
.campus-card {
  .campus-image {
    position: relative;
    
    img {
      width: 100%;
      height: 180px;
      object-fit: cover;
      display: block;
    }
    
    .campus-caption {
      position: absolute;
      bottom: 0;
      left: 0;
      right: 0;
      padding: 10px 15px;
      background: linear-gradient(transparent, rgba(0, 0, 0, 0.7));
      color: #fff;
      font-size: 13px;
      text-align: center;
    }
  }
}

/* 公告列表 */
.notice-list {
  padding: 10px 20px;
  
  .notice-item {
    display: flex;
    align-items: center;
    padding: 12px 0;
    border-bottom: 1px solid #f5f5f5;
    
    &:last-child {
      border-bottom: none;
    }
    
    .notice-text {
      flex: 1;
      margin-left: 10px;
      font-size: 14px;
      color: #333;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }
    
    .notice-date {
      font-size: 12px;
      color: #999;
      margin-left: 10px;
    }
  }
}

/* 响应式调整 */
@media (max-width: 768px) {
  .hero-banner {
    height: 160px;
    
    .hero-content h1 {
      font-size: 24px;
    }
  }
  
  .guide-steps {
    flex-direction: column;
    
    .step-item {
      margin-bottom: 15px;
    }
    
    .step-arrow {
      display: none;
    }
  }
}
</style>
