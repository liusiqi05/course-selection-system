<template>
  <div class="app-container home">
    <!-- 当前学期横幅 -->
    <div class="term-banner">
      <i class="el-icon-date"></i>
      <span>当前学期：<b>{{ currentTerm || '未设置' }}</b></span>
    </div>

    <!-- 欢迎区域 -->
    <el-row :gutter="20">
      <el-col :span="24">
        <div class="welcome-section">
          <div class="welcome-text">
            <h1>上海大学选课系统</h1>
            <p>欢迎您，<b>{{ nickName }}</b> <el-tag size="mini" effect="plain">{{ roleName }}</el-tag></p>
          </div>
        </div>
      </el-col>
    </el-row>

    <!-- 统计数据 -->
    <el-row :gutter="16" style="margin-top: 20px;">
      <el-col :xs="8" :sm="8" :md="8">
        <div class="stat-item">
          <div class="stat-num">{{ courseCount }}</div>
          <div class="stat-label">开课数量</div>
        </div>
      </el-col>
      <el-col :xs="8" :sm="8" :md="8">
        <div class="stat-item">
          <div class="stat-num">{{ studentCount }}</div>
          <div class="stat-label">学生人数</div>
        </div>
      </el-col>
      <el-col :xs="8" :sm="8" :md="8">
        <div class="stat-item">
          <div class="stat-num">{{ teacherCount }}</div>
          <div class="stat-label">教师人数</div>
        </div>
      </el-col>
    </el-row>

    <!-- 快捷功能 -->
    <div class="section-title">快捷入口</div>
    <el-row :gutter="12">
      <el-col :xs="8" :sm="6" :md="4" v-for="item in quickLinks" :key="item.path">
        <div class="quick-item" @click="goTo(item.path)">
          <i :class="item.icon"></i>
          <span>{{ item.name }}</span>
        </div>
      </el-col>
    </el-row>

    <!-- 公告区域 -->
    <div class="section-title">系统公告</div>
    <div class="notice-card">
      <div class="notice-item" v-for="(notice, index) in notices" :key="index">
        <el-tag size="mini" :type="notice.type">{{ notice.tag }}</el-tag>
        <span class="notice-text">{{ notice.title }}</span>
        <span class="notice-date">{{ notice.date }}</span>
      </div>
    </div>

    <!-- 选课指南 -->
    <div class="section-title">选课指南</div>
    <div class="guide-card">
      <div class="guide-steps">
        <div class="step-item">
          <div class="step-num">1</div>
          <div class="step-text">查看可选课程</div>
        </div>
        <div class="step-arrow">→</div>
        <div class="step-item">
          <div class="step-num">2</div>
          <div class="step-text">选择课程</div>
        </div>
        <div class="step-arrow">→</div>
        <div class="step-item">
          <div class="step-num">3</div>
          <div class="step-text">确认选课</div>
        </div>
        <div class="step-arrow">→</div>
        <div class="step-item">
          <div class="step-num">4</div>
          <div class="step-text">查看结果</div>
        </div>
      </div>
    </div>
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
        { name: '学期管理', path: '/education/term', icon: 'el-icon-date' },
        { name: '课程管理', path: '/education/course', icon: 'el-icon-notebook-2' },
        { name: '开课安排', path: '/education/opening', icon: 'el-icon-s-grid' },
        { name: '学生选课', path: '/education/enroll', icon: 'el-icon-edit-outline' },
        { name: '学生信息', path: '/education/student', icon: 'el-icon-user' },
        { name: '教师信息', path: '/education/teacher', icon: 'el-icon-s-custom' }
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
      this.courseCount = 9
      this.studentCount = 13
      this.teacherCount = 5
    }
  }
}
</script>

<style scoped lang="scss">
.home {
  padding: 0 20px 20px;
  background: #fff;
  min-height: calc(100vh - 84px);
}

.term-banner {
  background: #1890ff;
  color: #fff;
  padding: 12px 20px;
  margin: 0 -20px 20px;
  font-size: 15px;
  display: flex;
  align-items: center;
  
  i {
    margin-right: 8px;
    font-size: 18px;
  }
  
  b {
    margin-left: 4px;
  }
}

.welcome-section {
  padding: 30px 0 20px;
  border-bottom: 1px solid #f0f0f0;
  
  .welcome-text {
    h1 {
      font-size: 28px;
      font-weight: 600;
      color: #1a1a1a;
      margin: 0 0 10px 0;
    }
    
    p {
      font-size: 14px;
      color: #666;
      margin: 0;
      
      b {
        color: #1890ff;
        margin-right: 8px;
      }
    }
  }
}

.stat-item {
  text-align: center;
  padding: 20px 0;
  
  .stat-num {
    font-size: 32px;
    font-weight: 600;
    color: #1890ff;
  }
  
  .stat-label {
    font-size: 13px;
    color: #999;
    margin-top: 4px;
  }
}

.section-title {
  font-size: 16px;
  font-weight: 600;
  color: #1a1a1a;
  margin: 24px 0 12px;
  padding-left: 10px;
  border-left: 3px solid #1890ff;
}

.quick-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 16px 8px;
  margin-bottom: 12px;
  background: #fafafa;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.2s;
  
  &:hover {
    background: #e6f7ff;
  }
  
  i {
    font-size: 28px;
    color: #1890ff;
    margin-bottom: 8px;
  }
  
  span {
    font-size: 12px;
    color: #666;
  }
}

.notice-card {
  background: #fafafa;
  border-radius: 8px;
  padding: 4px 16px;
  
  .notice-item {
    display: flex;
    align-items: center;
    padding: 12px 0;
    border-bottom: 1px solid #f0f0f0;
    
    &:last-child {
      border-bottom: none;
    }
    
    .notice-text {
      flex: 1;
      margin-left: 10px;
      font-size: 14px;
      color: #333;
    }
    
    .notice-date {
      font-size: 12px;
      color: #999;
    }
  }
}

.guide-card {
  background: #fafafa;
  border-radius: 8px;
  padding: 20px;
  
  .guide-steps {
    display: flex;
    align-items: center;
    justify-content: center;
    flex-wrap: wrap;
    gap: 8px;
  }
  
  .step-item {
    display: flex;
    flex-direction: column;
    align-items: center;
    
    .step-num {
      width: 32px;
      height: 32px;
      border-radius: 50%;
      background: #1890ff;
      color: #fff;
      display: flex;
      align-items: center;
      justify-content: center;
      font-weight: 600;
      margin-bottom: 6px;
    }
    
    .step-text {
      font-size: 12px;
      color: #666;
    }
  }
  
  .step-arrow {
    color: #ccc;
    font-size: 18px;
    margin: 0 8px;
  }
}
</style>
