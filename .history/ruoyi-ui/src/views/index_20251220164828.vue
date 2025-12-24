<template>
  <div class="app-container home">
    <!-- 欢迎区域 -->
    <el-row :gutter="20">
      <el-col :span="24">
        <el-card class="welcome-card" shadow="hover">
          <div class="welcome-content">
            <div class="welcome-left">
              <h1>欢迎使用上海大学选课系统</h1>
              <p class="welcome-desc">
                本系统为上海大学教务管理选课平台，提供学期管理、课程管理、开课安排、学生选课等功能。
                学生可以在线浏览可选课程、进行选课和退课操作，教师可以查看授课课程和学生名单。
              </p>
              <p class="user-info">
                <span>当前用户：<b>{{ nickName }}</b></span>
                <el-tag size="small" style="margin-left: 10px;">{{ roleName }}</el-tag>
              </p>
            </div>
            <div class="welcome-right">
              <img src="@/assets/logo/logo.png" alt="校徽" class="school-logo" />
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <!-- 快捷功能入口 -->
    <el-row :gutter="20" style="margin-top: 20px;">
      <el-col :xs="12" :sm="8" :md="6" :lg="4" v-for="item in quickLinks" :key="item.path">
        <el-card class="quick-card" shadow="hover" @click.native="goTo(item.path)">
          <div class="quick-content">
            <i :class="item.icon" :style="{ color: item.color }"></i>
            <span>{{ item.name }}</span>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <!-- 统计信息 -->
    <el-row :gutter="20" style="margin-top: 20px;">
      <el-col :xs="24" :sm="12" :md="6">
        <el-card class="stat-card" shadow="hover">
          <div class="stat-content">
            <div class="stat-icon" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
              <i class="el-icon-date"></i>
            </div>
            <div class="stat-info">
              <p class="stat-title">当前学期</p>
              <p class="stat-value">{{ currentTerm || '未设置' }}</p>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :xs="24" :sm="12" :md="6">
        <el-card class="stat-card" shadow="hover">
          <div class="stat-content">
            <div class="stat-icon" style="background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);">
              <i class="el-icon-reading"></i>
            </div>
            <div class="stat-info">
              <p class="stat-title">开课数量</p>
              <p class="stat-value">{{ courseCount }} 门</p>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :xs="24" :sm="12" :md="6">
        <el-card class="stat-card" shadow="hover">
          <div class="stat-content">
            <div class="stat-icon" style="background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);">
              <i class="el-icon-user"></i>
            </div>
            <div class="stat-info">
              <p class="stat-title">学生人数</p>
              <p class="stat-value">{{ studentCount }} 人</p>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :xs="24" :sm="12" :md="6">
        <el-card class="stat-card" shadow="hover">
          <div class="stat-content">
            <div class="stat-icon" style="background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);">
              <i class="el-icon-s-custom"></i>
            </div>
            <div class="stat-info">
              <p class="stat-title">教师人数</p>
              <p class="stat-value">{{ teacherCount }} 人</p>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <!-- 公告和选课须知 -->
    <el-row :gutter="20" style="margin-top: 20px;">
      <el-col :xs="24" :md="12">
        <el-card class="info-card" shadow="hover">
          <div slot="header" class="card-header">
            <span><i class="el-icon-bell"></i> 系统公告</span>
          </div>
          <div class="notice-list">
            <div class="notice-item" v-for="(notice, index) in notices" :key="index">
              <el-tag size="mini" :type="notice.type">{{ notice.tag }}</el-tag>
              <span class="notice-title">{{ notice.title }}</span>
              <span class="notice-date">{{ notice.date }}</span>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :xs="24" :md="12">
        <el-card class="info-card" shadow="hover">
          <div slot="header" class="card-header">
            <span><i class="el-icon-document"></i> 选课须知</span>
          </div>
          <div class="guide-content">
            <el-timeline>
              <el-timeline-item color="#0bbd87" icon="el-icon-check">
                <p><b>第一步：</b>查看当前学期可选课程列表</p>
              </el-timeline-item>
              <el-timeline-item color="#e6a23c" icon="el-icon-edit">
                <p><b>第二步：</b>根据个人培养计划选择课程</p>
              </el-timeline-item>
              <el-timeline-item color="#409eff" icon="el-icon-s-claim">
                <p><b>第三步：</b>点击"选课"按钮完成选课</p>
              </el-timeline-item>
              <el-timeline-item color="#67c23a" icon="el-icon-star-on">
                <p><b>第四步：</b>在"我的课程"中确认选课结果</p>
              </el-timeline-item>
            </el-timeline>
            <el-alert
              title="温馨提示：选课结束后请及时查看课表，如有冲突请尽快调整"
              type="warning"
              :closable="false"
              show-icon
              style="margin-top: 10px;"
            />
          </div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import { getCurrentTerm } from "@/api/education/term"

export default {
  name: "Index",
  data() {
    return {
      currentTerm: '',
      courseCount: 0,
      studentCount: 0,
      teacherCount: 0,
      quickLinks: [
        { name: '学期管理', path: '/education/term', icon: 'el-icon-date', color: '#409EFF' },
        { name: '课程管理', path: '/education/course', icon: 'el-icon-notebook-2', color: '#67C23A' },
        { name: '开课安排', path: '/education/opening', icon: 'el-icon-s-grid', color: '#E6A23C' },
        { name: '学生选课', path: '/education/enroll', icon: 'el-icon-edit-outline', color: '#F56C6C' },
        { name: '学生信息', path: '/education/student', icon: 'el-icon-user', color: '#909399' },
        { name: '教师信息', path: '/education/teacher', icon: 'el-icon-s-custom', color: '#9B59B6' }
      ],
      notices: [
        { tag: '重要', type: 'danger', title: '2025-2026学年第一学期选课已开始', date: '2025-12-20' },
        { tag: '通知', type: 'warning', title: '选课时间：12月20日-12月30日', date: '2025-12-18' },
        { tag: '提示', type: 'info', title: '请同学们合理安排选课时间，避免课程冲突', date: '2025-12-15' }
      ]
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
      if (roles.includes('teacher')) return '教师'
      if (roles.includes('student')) return '学生'
      return '普通用户'
    }
  },
  created() {
    this.loadCurrentTerm()
    this.loadStatistics()
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
      // 这里可以调用后端接口获取真实数据
      // 暂时使用模拟数据
      this.courseCount = 9
      this.studentCount = 13
      this.teacherCount = 5
    }
  }
}
</script>

<style scoped lang="scss">
.home {
  padding: 24px;
  background: linear-gradient(180deg, #f0f5ff 0%, #ffffff 100%);
  min-height: calc(100vh - 84px);
}

.welcome-card {
  background: linear-gradient(135deg, #4391d9 0%, #096dd9 100%);
  border: none;
  border-radius: 16px;
  box-shadow: 0 8px 24px rgba(24, 144, 255, 0.25);
  
  .welcome-content {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px;
    
    .welcome-left {
      flex: 1;
      
      h1 {
        color: #fff;
        font-size: 32px;
        font-weight: 600;
        margin: 0 0 16px 0;
        letter-spacing: 1px;
      }
      
      .welcome-desc {
        color: rgba(255, 255, 255, 0.9);
        font-size: 15px;
        line-height: 1.8;
        margin-bottom: 16px;
      }
      
      .user-info {
        color: #fff;
        font-size: 14px;
        
        b {
          font-size: 16px;
        }
      }
    }
    
    .welcome-right {
      margin-left: 40px;
      
      .school-logo {
        width: 120px;
        height: auto;
        max-height: 120px;
        object-fit: contain;
        filter: brightness(0) invert(1);
        opacity: 0.9;
      }
    }
  }
}

.quick-card {
  background: #fff;
  border: 1px solid #e6f0ff;
  border-radius: 12px;
  cursor: pointer;
  transition: all 0.3s ease;
  margin-bottom: 16px;
  
  &:hover {
    transform: translateY(-6px);
    box-shadow: 0 12px 24px rgba(24, 144, 255, 0.15);
    border-color: #1890ff;
  }
  
  .quick-content {
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 16px 0;
    
    i {
      font-size: 36px;
      margin-bottom: 12px;
    }
    
    span {
      font-size: 14px;
      font-weight: 500;
      color: #303133;
    }
  }
}

.stat-card {
  background: #fff;
  border: none;
  border-radius: 12px;
  margin-bottom: 16px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.06);
  transition: all 0.3s ease;
  
  &:hover {
    box-shadow: 0 6px 20px rgba(24, 144, 255, 0.12);
  }
  
  .stat-content {
    display: flex;
    align-items: center;
    
    .stat-icon {
      width: 56px;
      height: 56px;
      border-radius: 12px;
      display: flex;
      align-items: center;
      justify-content: center;
      margin-right: 16px;
      
      i {
        font-size: 26px;
        color: #fff;
      }
    }
    
    .stat-info {
      .stat-title {
        font-size: 13px;
        color: #909399;
        margin: 0 0 6px 0;
      }
      
      .stat-value {
        font-size: 20px;
        font-weight: 600;
        color: #1890ff;
        margin: 0;
      }
    }
  }
}

.info-card {
  background: #fff;
  border: none;
  border-radius: 12px;
  margin-bottom: 16px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.06);
  
  .card-header {
    font-size: 16px;
    font-weight: 600;
    color: #1890ff;
    
    i {
      margin-right: 8px;
    }
  }
}

.notice-list {
  .notice-item {
    display: flex;
    align-items: center;
    padding: 14px 0;
    border-bottom: 1px solid #f0f5ff;
    transition: background 0.2s;
    
    &:hover {
      background: #fafcff;
    }
    
    &:last-child {
      border-bottom: none;
    }
    
    .notice-title {
      flex: 1;
      margin-left: 12px;
      font-size: 14px;
      color: #303133;
    }
    
    .notice-date {
      font-size: 12px;
      color: #909399;
    }
  }
}

.guide-content {
  padding: 10px 0;
  
  p {
    margin: 0;
    font-size: 14px;
    color: #606266;
    line-height: 1.6;
  }
  
  ::v-deep .el-timeline-item__icon {
    font-size: 14px;
  }
}
</style>
