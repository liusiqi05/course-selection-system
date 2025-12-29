<template>
  <div class="app-container">
    <!-- 页面标题 -->
    <el-card class="box-card mb20" shadow="hover">
      <div slot="header" class="clearfix">
        <span><i class="el-icon-s-management"></i> 成绩管理（管理员）</span>
      </div>
      <el-alert
        title="成绩管理说明"
        type="info"
        :closable="false"
        show-icon
      >
        <template slot="default">
          <p style="margin: 5px 0;"><i class="el-icon-warning"></i> 在切换学期之前，必须确保当前学期所有课程的成绩都已录入完成。</p>
          <p style="margin: 5px 0;"><i class="el-icon-time"></i> 您可以在此设置每门课程的成绩录入截止日期，提醒教师及时完成成绩录入。</p>
        </template>
      </el-alert>
    </el-card>

    <!-- 学期选择和统计 -->
    <el-card class="box-card mb20" shadow="hover">
      <div slot="header" class="clearfix">
        <span><i class="el-icon-date"></i> 学期课程成绩概况</span>
      </div>
      <el-form :inline="true" size="small">
        <el-form-item label="选择学期">
          <el-select v-model="selectedTermId" placeholder="请选择学期" @change="loadCourseList">
            <el-option
              v-for="term in termList"
              :key="term.termId"
              :label="term.termName + (term.isCurrent === '1' ? ' (当前)' : '')"
              :value="term.termId"
            />
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="el-icon-refresh" @click="loadCourseList">刷新</el-button>
        </el-form-item>
        <el-form-item>
          <el-button type="warning" icon="el-icon-time" @click="showBatchDeadlineDialog">批量设置截止日期</el-button>
        </el-form-item>
      </el-form>

      <!-- 统计信息 -->
      <el-row :gutter="20" class="stats-row" v-if="courseList.length > 0">
        <el-col :span="6">
          <div class="stat-card stat-total">
            <div class="stat-value">{{ courseList.length }}</div>
            <div class="stat-label">总课程数</div>
          </div>
        </el-col>
        <el-col :span="6">
          <div class="stat-card stat-completed">
            <div class="stat-value">{{ completedCourses.length }}</div>
            <div class="stat-label">已完成</div>
          </div>
        </el-col>
        <el-col :span="6">
          <div class="stat-card stat-pending">
            <div class="stat-value">{{ pendingCourses.length }}</div>
            <div class="stat-label">待录入</div>
          </div>
        </el-col>
        <el-col :span="6">
          <div class="stat-card stat-expired">
            <div class="stat-value">{{ expiredCourses.length }}</div>
            <div class="stat-label">已超期</div>
          </div>
        </el-col>
      </el-row>

      <!-- 进度条 -->
      <div class="progress-section" v-if="courseList.length > 0">
        <span class="progress-label">总体完成进度：</span>
        <el-progress 
          :percentage="overallProgress" 
          :color="overallProgress === 100 ? '#67C23A' : '#E6A23C'"
          :stroke-width="20"
        />
        <span class="progress-info">
          {{ totalScored }}/{{ totalStudents }} 人已录入成绩
        </span>
      </div>
    </el-card>

    <!-- 课程列表 -->
    <el-card class="box-card" shadow="hover">
      <div slot="header" class="clearfix">
        <span><i class="el-icon-notebook-2"></i> 课程成绩录入状态</span>
        <el-input
          v-model="searchText"
          placeholder="搜索课程名称/教师"
          prefix-icon="el-icon-search"
          size="small"
          style="width: 200px; float: right;"
          clearable
        />
      </div>

      <el-table :data="filteredCourseList" v-loading="loading" style="width: 100%">
        <el-table-column label="课程代码" align="center" prop="courseCode" width="110" />
        <el-table-column label="课程名称" align="center" prop="courseName" min-width="140" />
        <el-table-column label="授课教师" align="center" prop="teacherName" width="100" />
        <el-table-column label="选课人数" align="center" prop="selectedNum" width="90" />
        <el-table-column label="录入进度" align="center" width="180">
          <template slot-scope="scope">
            <el-progress
              :percentage="getProgress(scope.row)"
              :color="getProgressColor(scope.row)"
              :stroke-width="10"
              :show-text="false"
            />
            <span class="progress-text">
              {{ scope.row.selectedNum - scope.row.pendingCount }}/{{ scope.row.selectedNum }}
              ({{ scope.row.pendingCount }} 人待录入)
            </span>
          </template>
        </el-table-column>
        <el-table-column label="截止日期" align="center" width="150">
          <template slot-scope="scope">
            <el-date-picker
              v-model="scope.row.scoreDeadline"
              type="date"
              placeholder="设置截止日期"
              size="mini"
              value-format="yyyy-MM-dd"
              style="width: 130px;"
              @change="setDeadline(scope.row)"
              :class="{ 'expired-picker': isExpired(scope.row) }"
            />
          </template>
        </el-table-column>
        <el-table-column label="状态" align="center" width="100">
          <template slot-scope="scope">
            <el-tag v-if="scope.row.pendingCount === 0" type="success" size="small">已完成</el-tag>
            <el-tag v-else-if="isExpired(scope.row)" type="danger" size="small" effect="dark">
              <i class="el-icon-warning"></i> 超期
            </el-tag>
            <el-tag v-else type="warning" size="small">待录入</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" align="center" width="120">
          <template slot-scope="scope">
            <el-button 
              type="text" 
              size="small" 
              icon="el-icon-view"
              @click="viewStudents(scope.row)"
            >
              查看学生
            </el-button>
          </template>
        </el-table-column>
      </el-table>
      <el-empty v-if="!loading && filteredCourseList.length === 0" description="暂无课程数据"></el-empty>
    </el-card>

    <!-- 批量设置截止日期对话框 -->
    <el-dialog title="批量设置截止日期" :visible.sync="batchDialogVisible" width="400px">
      <el-form label-width="100px">
        <el-form-item label="截止日期">
          <el-date-picker
            v-model="batchDeadline"
            type="date"
            placeholder="选择截止日期"
            value-format="yyyy-MM-dd"
            style="width: 100%;"
          />
        </el-form-item>
        <el-form-item label="应用范围">
          <el-radio-group v-model="batchScope">
            <el-radio label="all">所有课程</el-radio>
            <el-radio label="pending">仅待录入课程</el-radio>
            <el-radio label="noDeadline">仅未设置截止日期的课程</el-radio>
          </el-radio-group>
        </el-form-item>
      </el-form>
      <span slot="footer">
        <el-button @click="batchDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="batchSetDeadline" :loading="batchSaving">确定</el-button>
      </span>
    </el-dialog>

    <!-- 学生列表对话框 -->
    <el-dialog :title="currentCourse ? currentCourse.courseName + ' - 学生成绩' : ''" :visible.sync="studentDialogVisible" width="800px">
      <el-table :data="studentList" v-loading="loadingStudents" style="width: 100%">
        <el-table-column label="学号" align="center" prop="studentNo" width="120" />
        <el-table-column label="姓名" align="center" prop="studentName" width="100" />
        <el-table-column label="班级" align="center" prop="className" width="120" />
        <el-table-column label="平时成绩" align="center" prop="usualScore" width="100" />
        <el-table-column label="考试成绩" align="center" prop="examScore" width="100" />
        <el-table-column label="总成绩" align="center" width="100">
          <template slot-scope="scope">
            <el-tag v-if="scope.row.score !== null" :type="getScoreType(scope.row.score)" size="small">
              {{ scope.row.score }}
            </el-tag>
            <el-tag v-else type="info" size="small">未录入</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="状态" align="center" width="80">
          <template slot-scope="scope">
            <el-tag v-if="scope.row.score !== null" type="success" size="mini">已录入</el-tag>
            <el-tag v-else type="danger" size="mini">待录入</el-tag>
          </template>
        </el-table-column>
      </el-table>
      <span slot="footer">
        <el-button @click="studentDialogVisible = false">关闭</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import { listTermOptions } from "@/api/education/term";
import request from '@/utils/request';

export default {
  name: "ScoreManage",
  data() {
    return {
      loading: false,
      termList: [],
      selectedTermId: null,
      courseList: [],
      searchText: '',
      // 批量设置
      batchDialogVisible: false,
      batchDeadline: null,
      batchScope: 'pending',
      batchSaving: false,
      // 学生列表
      studentDialogVisible: false,
      currentCourse: null,
      studentList: [],
      loadingStudents: false
    };
  },
  computed: {
    filteredCourseList() {
      if (!this.searchText) return this.courseList;
      const keyword = this.searchText.toLowerCase();
      return this.courseList.filter(c =>
        (c.courseName && c.courseName.toLowerCase().includes(keyword)) ||
        (c.teacherName && c.teacherName.toLowerCase().includes(keyword))
      );
    },
    completedCourses() {
      return this.courseList.filter(c => c.pendingCount === 0);
    },
    pendingCourses() {
      return this.courseList.filter(c => c.pendingCount > 0);
    },
    expiredCourses() {
      return this.courseList.filter(c => c.pendingCount > 0 && this.isExpired(c));
    },
    totalStudents() {
      return this.courseList.reduce((sum, c) => sum + (c.selectedNum || 0), 0);
    },
    totalScored() {
      return this.courseList.reduce((sum, c) => sum + ((c.selectedNum || 0) - (c.pendingCount || 0)), 0);
    },
    overallProgress() {
      if (this.totalStudents === 0) return 100;
      return Math.round((this.totalScored / this.totalStudents) * 100);
    }
  },
  created() {
    this.loadTermList();
  },
  methods: {
    loadTermList() {
      listTermOptions().then(response => {
        this.termList = response.data || [];
        // 默认选中当前学期
        const currentTerm = this.termList.find(t => t.isCurrent === '1');
        if (currentTerm) {
          this.selectedTermId = currentTerm.termId;
          this.loadCourseList();
        }
      });
    },
    loadCourseList() {
      if (!this.selectedTermId) return;
      this.loading = true;
      request({
        url: '/education/opening/termCourses/' + this.selectedTermId,
        method: 'get'
      }).then(response => {
        this.courseList = response.rows || [];
        this.loading = false;
      });
    },
    isExpired(course) {
      if (!course.scoreDeadline) return false;
      return new Date(course.scoreDeadline) < new Date();
    },
    getProgress(course) {
      if (course.selectedNum === 0) return 100;
      return Math.round(((course.selectedNum - course.pendingCount) / course.selectedNum) * 100);
    },
    getProgressColor(course) {
      if (course.pendingCount === 0) return '#67C23A';
      if (this.isExpired(course)) return '#F56C6C';
      return '#E6A23C';
    },
    setDeadline(course) {
      request({
        url: '/education/opening/setDeadline',
        method: 'put',
        data: {
          openId: course.openId,
          scoreDeadline: course.scoreDeadline
        }
      }).then(() => {
        this.$message.success('截止日期设置成功');
      });
    },
    showBatchDeadlineDialog() {
      this.batchDeadline = null;
      this.batchScope = 'pending';
      this.batchDialogVisible = true;
    },
    batchSetDeadline() {
      if (!this.batchDeadline) {
        this.$message.warning('请选择截止日期');
        return;
      }
      let coursesToUpdate = [];
      if (this.batchScope === 'all') {
        coursesToUpdate = this.courseList;
      } else if (this.batchScope === 'pending') {
        coursesToUpdate = this.courseList.filter(c => c.pendingCount > 0);
      } else if (this.batchScope === 'noDeadline') {
        coursesToUpdate = this.courseList.filter(c => !c.scoreDeadline);
      }
      if (coursesToUpdate.length === 0) {
        this.$message.warning('没有符合条件的课程');
        return;
      }
      this.batchSaving = true;
      request({
        url: '/education/opening/batchSetDeadline',
        method: 'put',
        data: coursesToUpdate.map(c => ({
          openId: c.openId,
          scoreDeadline: this.batchDeadline
        }))
      }).then(response => {
        this.$message.success(response.msg || '设置成功');
        this.batchDialogVisible = false;
        this.batchSaving = false;
        this.loadCourseList();
      }).catch(() => {
        this.batchSaving = false;
      });
    },
    viewStudents(course) {
      this.currentCourse = course;
      this.studentDialogVisible = true;
      this.loadingStudents = true;
      request({
        url: '/education/selection/students/' + course.openId,
        method: 'get'
      }).then(response => {
        this.studentList = response.rows || [];
        this.loadingStudents = false;
      });
    },
    getScoreType(score) {
      if (score === null || score === undefined) return 'info';
      const s = parseFloat(score);
      if (s >= 90) return 'success';
      if (s >= 60) return '';
      return 'danger';
    }
  }
};
</script>

<style scoped>
.mb20 { margin-bottom: 20px; }
.stats-row { margin: 20px 0; }
.stat-card {
  text-align: center;
  padding: 20px;
  border-radius: 8px;
  color: #fff;
}
.stat-total { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
.stat-completed { background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%); }
.stat-pending { background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%); }
.stat-expired { background: linear-gradient(135deg, #eb3349 0%, #f45c43 100%); }
.stat-value { font-size: 32px; font-weight: bold; }
.stat-label { font-size: 14px; margin-top: 5px; opacity: 0.9; }
.progress-section {
  display: flex;
  align-items: center;
  gap: 15px;
  margin-top: 20px;
  padding: 15px;
  background: #f5f7fa;
  border-radius: 8px;
}
.progress-label { font-weight: bold; white-space: nowrap; }
.progress-info { white-space: nowrap; color: #606266; }
.progress-text {
  font-size: 12px;
  color: #606266;
  display: block;
  text-align: center;
  margin-top: 2px;
}
.expired-picker >>> .el-input__inner {
  border-color: #F56C6C;
  color: #F56C6C;
}
</style>
