<template>
  <div class="app-container">
    <!-- 搜索区域 -->
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch">
      <el-form-item label="学期" prop="termId">
        <el-select v-model="queryParams.termId" placeholder="请选择学期" clearable style="width: 200px">
          <el-option
            v-for="term in termList"
            :key="term.termId"
            :label="term.termName"
            :value="term.termId"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="课程" prop="courseName">
        <el-input
          v-model="queryParams.courseName"
          placeholder="请输入课程名称"
          clearable
          style="width: 200px"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="教师" prop="teacherName">
        <el-input
          v-model="queryParams.teacherName"
          placeholder="请输入教师姓名"
          clearable
          style="width: 200px"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <!-- 工具栏 -->
    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <!-- 统计信息 -->
    <el-row :gutter="20" class="stats-row mb20">
      <el-col :span="6">
        <div class="stat-card">
          <div class="stat-value">{{ totalEvaluations }}</div>
          <div class="stat-label">总评价数</div>
        </div>
      </el-col>
      <el-col :span="6">
        <div class="stat-card">
          <div class="stat-value">{{ avgTeachingScore }}</div>
          <div class="stat-label">平均教学质量</div>
        </div>
      </el-col>
      <el-col :span="6">
        <div class="stat-card">
          <div class="stat-value">{{ avgOverallScore }}</div>
          <div class="stat-label">平均总体评价</div>
        </div>
      </el-col>
      <el-col :span="6">
        <div class="stat-card">
          <div class="stat-value">{{ commentCount }}</div>
          <div class="stat-label">有文字评价</div>
        </div>
      </el-col>
    </el-row>

    <!-- 评价列表 -->
    <el-table :data="evaluationList" v-loading="loading" style="width: 100%">
      <el-table-column label="学期" align="center" prop="termName" width="150" />
      <el-table-column label="课程名称" align="center" prop="courseName" min-width="120" />
      <el-table-column label="授课教师" align="center" prop="teacherName" width="100" />
      <el-table-column label="学生" align="center" width="100">
        <template slot-scope="scope">
          <span>{{ scope.row.studentName }}</span>
          <el-tag v-if="scope.row.isAnonymous === '1'" size="mini" type="info" style="margin-left: 5px;">匿名</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="学号" align="center" prop="studentNo" width="120" />
      <el-table-column label="教学质量" align="center" width="80">
        <template slot-scope="scope">
          <el-tag size="small">{{ scope.row.teachingScore }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="课程内容" align="center" width="80">
        <template slot-scope="scope">
          <el-tag size="small">{{ scope.row.contentScore }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="难度适中" align="center" width="80">
        <template slot-scope="scope">
          <el-tag size="small">{{ scope.row.difficultyScore }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="作业量" align="center" width="70">
        <template slot-scope="scope">
          <el-tag size="small">{{ scope.row.workloadScore }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="总体评价" align="center" width="80">
        <template slot-scope="scope">
          <el-tag size="small" :type="getScoreTagType(scope.row.overallScore)">{{ scope.row.overallScore }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="评价时间" align="center" prop="evalTime" width="160" />
      <el-table-column label="操作" align="center" width="100">
        <template slot-scope="scope">
          <el-button 
            type="text" 
            size="small" 
            icon="el-icon-view"
            @click="showComment(scope.row)"
          >查看详情</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total > 0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 评价详情对话框 -->
    <el-dialog title="评价详情" :visible.sync="commentDialogVisible" width="600px">
      <div v-if="currentEvaluation">
        <el-descriptions :column="2" border>
          <el-descriptions-item label="学期">{{ currentEvaluation.termName }}</el-descriptions-item>
          <el-descriptions-item label="课程名称">{{ currentEvaluation.courseName }}</el-descriptions-item>
          <el-descriptions-item label="授课教师">{{ currentEvaluation.teacherName }}</el-descriptions-item>
          <el-descriptions-item label="评价时间">{{ currentEvaluation.evalTime }}</el-descriptions-item>
          <el-descriptions-item label="学生姓名">
            {{ currentEvaluation.studentName }}
            <el-tag v-if="currentEvaluation.isAnonymous === '1'" size="mini" type="info">匿名</el-tag>
          </el-descriptions-item>
          <el-descriptions-item label="学号">{{ currentEvaluation.studentNo }}</el-descriptions-item>
        </el-descriptions>

        <el-divider content-position="left">评分详情</el-divider>
        
        <el-row :gutter="20">
          <el-col :span="12">
            <div class="score-item">
              <span class="score-label">教学质量：</span>
              <el-rate v-model="currentEvaluation.teachingScore" disabled />
            </div>
          </el-col>
          <el-col :span="12">
            <div class="score-item">
              <span class="score-label">课程内容：</span>
              <el-rate v-model="currentEvaluation.contentScore" disabled />
            </div>
          </el-col>
          <el-col :span="12">
            <div class="score-item">
              <span class="score-label">难度适中：</span>
              <el-rate v-model="currentEvaluation.difficultyScore" disabled />
            </div>
          </el-col>
          <el-col :span="12">
            <div class="score-item">
              <span class="score-label">作业量：</span>
              <el-rate v-model="currentEvaluation.workloadScore" disabled />
            </div>
          </el-col>
          <el-col :span="24">
            <div class="score-item">
              <span class="score-label">总体评价：</span>
              <el-rate v-model="currentEvaluation.overallScore" disabled show-text :texts="['很差', '较差', '一般', '较好', '很好']" />
            </div>
          </el-col>
        </el-row>

        <el-divider content-position="left">文字评价</el-divider>
        <div class="comment-content" v-if="currentEvaluation.comment">
          {{ currentEvaluation.comment }}
        </div>
        <el-empty v-else description="该学生未填写文字评价" :image-size="60" />
      </div>
      <span slot="footer">
        <el-button @click="commentDialogVisible = false">关闭</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import request from '@/utils/request'
import { listTermOptions } from "@/api/education/term"

export default {
  name: "AdminEvaluationFeedback",
  data() {
    return {
      loading: false,
      showSearch: true,
      total: 0,
      evaluationList: [],
      termList: [],
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        termId: null,
        courseName: null,
        teacherName: null
      },
      commentDialogVisible: false,
      currentEvaluation: null
    }
  },
  computed: {
    totalEvaluations() {
      return this.total
    },
    avgTeachingScore() {
      if (this.evaluationList.length === 0) return '-'
      const avg = this.evaluationList.reduce((sum, e) => sum + (e.teachingScore || 0), 0) / this.evaluationList.length
      return avg.toFixed(1)
    },
    avgOverallScore() {
      if (this.evaluationList.length === 0) return '-'
      const avg = this.evaluationList.reduce((sum, e) => sum + (e.overallScore || 0), 0) / this.evaluationList.length
      return avg.toFixed(1)
    },
    commentCount() {
      return this.evaluationList.filter(e => e.comment && e.comment.trim()).length
    }
  },
  created() {
    this.loadTermList()
    this.getList()
  },
  methods: {
    loadTermList() {
      listTermOptions().then(res => {
        this.termList = res.data || []
      })
    },
    getList() {
      this.loading = true
      request({
        url: '/education/evaluation/admin/list',
        method: 'get',
        params: this.queryParams
      }).then(res => {
        this.evaluationList = res.rows || []
        this.total = res.total || 0
        this.loading = false
      }).catch(() => {
        this.loading = false
      })
    },
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
    },
    resetQuery() {
      this.resetForm("queryForm")
      this.handleQuery()
    },
    handleExport() {
      this.download('/education/evaluation/admin/export', {
        ...this.queryParams
      }, `评价数据_${new Date().getTime()}.xlsx`)
    },
    showComment(row) {
      this.currentEvaluation = row
      this.commentDialogVisible = true
    },
    getScoreTagType(score) {
      if (score >= 5) return 'success'
      if (score >= 4) return ''
      if (score >= 3) return 'warning'
      return 'danger'
    }
  }
}
</script>

<style scoped>
.mb20 {
  margin-bottom: 20px;
}
.stats-row .stat-card {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: #fff;
  padding: 20px;
  border-radius: 10px;
  text-align: center;
}
.stats-row .stat-card:nth-child(2) {
  background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
}
.stats-row .stat-card:nth-child(3) {
  background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
}
.stats-row .stat-card:nth-child(4) {
  background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
}
.stat-value {
  font-size: 28px;
  font-weight: bold;
}
.stat-label {
  font-size: 14px;
  margin-top: 5px;
  opacity: 0.9;
}
.score-item {
  display: flex;
  align-items: center;
  margin-bottom: 15px;
}
.score-label {
  width: 80px;
  color: #606266;
}
.comment-content {
  padding: 15px;
  background: #f5f7fa;
  border-radius: 8px;
  line-height: 1.8;
  white-space: pre-wrap;
}
</style>
