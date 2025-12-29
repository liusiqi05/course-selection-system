<template>
  <div class="app-container">
    <!-- 统计卡片 -->
    <el-row :gutter="20" class="mb20">
      <el-col :span="24">
        <el-card shadow="hover">
          <div slot="header">
            <span><i class="el-icon-data-analysis"></i> 课程评价统计</span>
          </div>
          <el-table :data="statsList" v-loading="statsLoading" style="width: 100%">
            <el-table-column label="学期" align="center" prop="termName" width="150" />
            <el-table-column label="课程名称" align="center" prop="courseName" min-width="120" />
            <el-table-column label="评价人数" align="center" width="100">
              <template slot-scope="scope">
                <el-tag type="info">{{ scope.row.evalId || 0 }} 人</el-tag>
              </template>
            </el-table-column>
            <el-table-column label="教学质量" align="center" width="100">
              <template slot-scope="scope">
                <el-rate v-model="scope.row.teachingScore" disabled show-score text-color="#ff9900" />
              </template>
            </el-table-column>
            <el-table-column label="课程内容" align="center" width="100">
              <template slot-scope="scope">
                <el-rate v-model="scope.row.contentScore" disabled show-score text-color="#ff9900" />
              </template>
            </el-table-column>
            <el-table-column label="难度适中" align="center" width="100">
              <template slot-scope="scope">
                <el-rate v-model="scope.row.difficultyScore" disabled show-score text-color="#ff9900" />
              </template>
            </el-table-column>
            <el-table-column label="作业量" align="center" width="100">
              <template slot-scope="scope">
                <el-rate v-model="scope.row.workloadScore" disabled show-score text-color="#ff9900" />
              </template>
            </el-table-column>
            <el-table-column label="总体评价" align="center" width="100">
              <template slot-scope="scope">
                <el-rate v-model="scope.row.overallScore" disabled show-score text-color="#ff9900" />
              </template>
            </el-table-column>
            <el-table-column label="综合得分" align="center" width="100">
              <template slot-scope="scope">
                <el-tag :type="getScoreType(scope.row.avgScore)">{{ scope.row.avgScore || '-' }}</el-tag>
              </template>
            </el-table-column>
          </el-table>
          <el-empty v-if="!statsLoading && statsList.length === 0" description="暂无评价数据" />
        </el-card>
      </el-col>
    </el-row>

    <!-- 评价详情列表 -->
    <el-card shadow="hover">
      <div slot="header">
        <span><i class="el-icon-chat-line-square"></i> 学生评价详情</span>
        <el-button 
          style="float: right; padding: 3px 0" 
          type="text" 
          icon="el-icon-refresh"
          @click="getList"
        >刷新</el-button>
      </div>
      
      <el-table :data="evaluationList" v-loading="loading" style="width: 100%">
        <el-table-column label="课程名称" align="center" prop="courseName" min-width="120" />
        <el-table-column label="学期" align="center" prop="termName" width="150" />
        <el-table-column label="学生" align="center" width="100">
          <template slot-scope="scope">
            <span>{{ scope.row.studentName }}</span>
          </template>
        </el-table-column>
        <el-table-column label="教学质量" align="center" width="90">
          <template slot-scope="scope">
            <el-tag size="small">{{ scope.row.teachingScore }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="课程内容" align="center" width="90">
          <template slot-scope="scope">
            <el-tag size="small">{{ scope.row.contentScore }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="难度适中" align="center" width="90">
          <template slot-scope="scope">
            <el-tag size="small">{{ scope.row.difficultyScore }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="作业量" align="center" width="80">
          <template slot-scope="scope">
            <el-tag size="small">{{ scope.row.workloadScore }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="总体评价" align="center" width="90">
          <template slot-scope="scope">
            <el-tag size="small" :type="getScoreTagType(scope.row.overallScore)">{{ scope.row.overallScore }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="评价时间" align="center" prop="evalTime" width="160" />
        <el-table-column label="操作" align="center" width="80">
          <template slot-scope="scope">
            <el-button 
              type="text" 
              size="small" 
              icon="el-icon-view"
              @click="showComment(scope.row)"
            >详情</el-button>
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
    </el-card>

    <!-- 评价详情对话框 -->
    <el-dialog title="评价详情" :visible.sync="commentDialogVisible" width="500px">
      <div v-if="currentEvaluation">
        <el-descriptions :column="2" border>
          <el-descriptions-item label="课程名称">{{ currentEvaluation.courseName }}</el-descriptions-item>
          <el-descriptions-item label="学期">{{ currentEvaluation.termName }}</el-descriptions-item>
          <el-descriptions-item label="学生">{{ currentEvaluation.studentName }}</el-descriptions-item>
          <el-descriptions-item label="评价时间">{{ currentEvaluation.evalTime }}</el-descriptions-item>
          <el-descriptions-item label="教学质量">
            <el-rate v-model="currentEvaluation.teachingScore" disabled />
          </el-descriptions-item>
          <el-descriptions-item label="课程内容">
            <el-rate v-model="currentEvaluation.contentScore" disabled />
          </el-descriptions-item>
          <el-descriptions-item label="难度适中">
            <el-rate v-model="currentEvaluation.difficultyScore" disabled />
          </el-descriptions-item>
          <el-descriptions-item label="作业量">
            <el-rate v-model="currentEvaluation.workloadScore" disabled />
          </el-descriptions-item>
          <el-descriptions-item label="总体评价" :span="2">
            <el-rate v-model="currentEvaluation.overallScore" disabled />
          </el-descriptions-item>
        </el-descriptions>
        <div class="comment-section" v-if="currentEvaluation.comment">
          <div class="comment-label">文字评价：</div>
          <div class="comment-content">{{ currentEvaluation.comment }}</div>
        </div>
        <div class="comment-section" v-else>
          <el-empty description="该学生未填写文字评价" :image-size="80" />
        </div>
      </div>
      <span slot="footer">
        <el-button @click="commentDialogVisible = false">关闭</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import request from '@/utils/request'

export default {
  name: "TeacherEvaluationFeedback",
  data() {
    return {
      loading: false,
      statsLoading: false,
      total: 0,
      evaluationList: [],
      statsList: [],
      queryParams: {
        pageNum: 1,
        pageSize: 10
      },
      commentDialogVisible: false,
      currentEvaluation: null
    }
  },
  created() {
    this.getStats()
    this.getList()
  },
  methods: {
    getStats() {
      this.statsLoading = true
      request({
        url: '/education/evaluation/teacher/stats',
        method: 'get'
      }).then(res => {
        this.statsList = res.data || []
        this.statsLoading = false
      }).catch(() => {
        this.statsLoading = false
      })
    },
    getList() {
      this.loading = true
      request({
        url: '/education/evaluation/teacher/list',
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
    showComment(row) {
      this.currentEvaluation = row
      this.commentDialogVisible = true
    },
    getScoreType(score) {
      if (!score) return 'info'
      if (score >= 4.5) return 'success'
      if (score >= 3.5) return ''
      if (score >= 2.5) return 'warning'
      return 'danger'
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
.comment-section {
  margin-top: 20px;
  padding: 15px;
  background: #f5f7fa;
  border-radius: 8px;
}
.comment-label {
  font-weight: bold;
  margin-bottom: 10px;
  color: #606266;
}
.comment-content {
  line-height: 1.8;
  color: #303133;
  white-space: pre-wrap;
}
</style>
