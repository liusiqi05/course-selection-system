<template>
  <div class="app-container">
    <!-- 成绩统计卡片 -->
    <el-row :gutter="20" class="mb20">
      <el-col :span="6">
        <el-card shadow="hover" class="stat-card">
          <div class="stat-content">
            <div class="stat-icon total"><i class="el-icon-document"></i></div>
            <div class="stat-info">
              <div class="stat-value">{{ statistics.totalCourses }}</div>
              <div class="stat-label">已修课程</div>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card shadow="hover" class="stat-card">
          <div class="stat-content">
            <div class="stat-icon pass"><i class="el-icon-success"></i></div>
            <div class="stat-info">
              <div class="stat-value success">{{ statistics.passCount }}</div>
              <div class="stat-label">通过课程</div>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card shadow="hover" class="stat-card">
          <div class="stat-content">
            <div class="stat-icon fail"><i class="el-icon-error"></i></div>
            <div class="stat-info">
              <div class="stat-value danger">{{ statistics.failCount }}</div>
              <div class="stat-label">挂科课程</div>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card shadow="hover" class="stat-card">
          <div class="stat-content">
            <div class="stat-icon credit"><i class="el-icon-medal"></i></div>
            <div class="stat-info">
              <div class="stat-value primary">{{ statistics.totalCredits }}</div>
              <div class="stat-label">已获学分</div>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <!-- 查询条件 -->
    <el-card shadow="hover" class="mb20">
      <el-form :model="queryParams" ref="queryForm" :inline="true">
        <el-form-item label="学期" prop="termId">
          <el-select v-model="queryParams.termId" placeholder="全部学期" clearable style="width: 200px">
            <el-option
              v-for="term in termList"
              :key="term.termId"
              :label="term.termName"
              :value="term.termId"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="成绩筛选" prop="scoreType">
          <el-radio-group v-model="queryParams.scoreType">
            <el-radio-button label="all">全部</el-radio-button>
            <el-radio-button label="pass">
              <i class="el-icon-success"></i> 通过 (≥60)
            </el-radio-button>
            <el-radio-button label="fail">
              <i class="el-icon-error"></i> 挂科 (&lt;60)
            </el-radio-button>
          </el-radio-group>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="el-icon-search" @click="handleQuery">查询</el-button>
          <el-button icon="el-icon-refresh" @click="resetQuery">重置</el-button>
        </el-form-item>
      </el-form>
    </el-card>

    <!-- 成绩列表 -->
    <el-card shadow="hover">
      <div slot="header" class="clearfix">
        <span><i class="el-icon-notebook-2"></i> 成绩列表</span>
        <span style="float: right; color: #909399; font-size: 14px;">
          共 {{ total }} 条记录
        </span>
      </div>
      <el-table v-loading="loading" :data="scoreList" border stripe>
        <el-table-column label="学期" align="center" prop="termName" min-width="180" />
        <el-table-column label="课程代码" align="center" prop="courseCode" width="120" />
        <el-table-column label="课程名称" align="center" prop="courseName" min-width="150" />
        <el-table-column label="学分" align="center" prop="credit" width="80">
          <template slot-scope="scope">
            <el-tag size="small">{{ scope.row.credit }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="授课教师" align="center" prop="teacherName" width="100" />
        <el-table-column label="平时成绩" align="center" prop="usualScore" width="100">
          <template slot-scope="scope">
            <span v-if="scope.row.usualScore != null">{{ scope.row.usualScore }}</span>
            <span v-else class="text-muted">-</span>
          </template>
        </el-table-column>
        <el-table-column label="考试成绩" align="center" prop="examScore" width="100">
          <template slot-scope="scope">
            <span v-if="scope.row.examScore != null">{{ scope.row.examScore }}</span>
            <span v-else class="text-muted">-</span>
          </template>
        </el-table-column>
        <el-table-column label="总成绩" align="center" prop="score" width="100">
          <template slot-scope="scope">
            <el-tag :type="getScoreType(scope.row.score)" size="medium" effect="dark">
              {{ scope.row.score != null ? scope.row.score : '-' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="状态" align="center" width="100">
          <template slot-scope="scope">
            <el-tag v-if="scope.row.score >= 60" type="success" effect="plain">
              <i class="el-icon-success"></i> 通过
            </el-tag>
            <el-tag v-else type="danger" effect="plain">
              <i class="el-icon-error"></i> 挂科
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="获得学分" align="center" width="100">
          <template slot-scope="scope">
            <span v-if="scope.row.score >= 60" class="text-success">{{ scope.row.credit }}</span>
            <span v-else class="text-danger">0</span>
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

    <!-- GPA 信息 -->
    <el-card shadow="hover" class="mt20" v-if="scoreList.length > 0">
      <div slot="header">
        <span><i class="el-icon-data-analysis"></i> 学业概况</span>
      </div>
      <el-descriptions :column="4" border>
        <el-descriptions-item label="平均成绩">
          <span class="highlight-value">{{ statistics.avgScore }}</span> 分
        </el-descriptions-item>
        <el-descriptions-item label="最高成绩">
          <span class="highlight-value success">{{ statistics.maxScore }}</span> 分
        </el-descriptions-item>
        <el-descriptions-item label="最低成绩">
          <span class="highlight-value" :class="statistics.minScore < 60 ? 'danger' : ''">{{ statistics.minScore }}</span> 分
        </el-descriptions-item>
        <el-descriptions-item label="通过率">
          <span class="highlight-value primary">{{ statistics.passRate }}%</span>
        </el-descriptions-item>
      </el-descriptions>
    </el-card>
  </div>
</template>

<script>
import request from '@/utils/request';

export default {
  name: "MyScore",
  data() {
    return {
      // 遮罩层
      loading: false,
      // 总条数
      total: 0,
      // 成绩列表
      scoreList: [],
      // 学期列表
      termList: [],
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 20,
        termId: null,
        scoreType: 'all'
      },
      // 统计信息
      statistics: {
        totalCourses: 0,
        passCount: 0,
        failCount: 0,
        totalCredits: 0,
        avgScore: 0,
        maxScore: 0,
        minScore: 0,
        passRate: 0
      }
    };
  },
  created() {
    this.getTermList();
    this.getList();
  },
  methods: {
    /** 获取学期列表 */
    getTermList() {
      request({
        url: '/education/term/list',
        method: 'get',
        params: { pageSize: 100 }
      }).then(response => {
        this.termList = response.rows || [];
      });
    },
    /** 查询成绩列表 */
    getList() {
      this.loading = true;
      request({
        url: '/education/selection/myScores',
        method: 'get',
        params: this.queryParams
      }).then(response => {
        this.scoreList = response.rows || [];
        this.total = response.total || 0;
        this.calcStatistics();
        this.loading = false;
      }).catch(() => {
        this.loading = false;
      });
    },
    /** 计算统计信息 */
    calcStatistics() {
      const list = this.scoreList;
      if (list.length === 0) {
        this.statistics = {
          totalCourses: 0,
          passCount: 0,
          failCount: 0,
          totalCredits: 0,
          avgScore: 0,
          maxScore: 0,
          minScore: 0,
          passRate: 0
        };
        return;
      }
      
      let passCount = 0;
      let failCount = 0;
      let totalCredits = 0;
      let totalScore = 0;
      let maxScore = 0;
      let minScore = 100;
      
      list.forEach(item => {
        const score = parseFloat(item.score) || 0;
        totalScore += score;
        if (score >= 60) {
          passCount++;
          totalCredits += parseFloat(item.credit) || 0;
        } else {
          failCount++;
        }
        if (score > maxScore) maxScore = score;
        if (score < minScore) minScore = score;
      });
      
      this.statistics = {
        totalCourses: list.length,
        passCount: passCount,
        failCount: failCount,
        totalCredits: totalCredits.toFixed(1),
        avgScore: (totalScore / list.length).toFixed(1),
        maxScore: maxScore.toFixed(1),
        minScore: minScore.toFixed(1),
        passRate: ((passCount / list.length) * 100).toFixed(1)
      };
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.queryParams = {
        pageNum: 1,
        pageSize: 20,
        termId: null,
        scoreType: 'all'
      };
      this.getList();
    },
    /** 成绩等级颜色 */
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
.mb20 {
  margin-bottom: 20px;
}
.mt20 {
  margin-top: 20px;
}
.stat-card {
  border-radius: 8px;
}
.stat-content {
  display: flex;
  align-items: center;
}
.stat-icon {
  width: 60px;
  height: 60px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 28px;
  margin-right: 15px;
}
.stat-icon.total {
  background-color: #e6f7ff;
  color: #1890ff;
}
.stat-icon.pass {
  background-color: #f6ffed;
  color: #52c41a;
}
.stat-icon.fail {
  background-color: #fff2f0;
  color: #ff4d4f;
}
.stat-icon.credit {
  background-color: #fff7e6;
  color: #fa8c16;
}
.stat-info {
  flex: 1;
}
.stat-value {
  font-size: 28px;
  font-weight: bold;
  color: #303133;
}
.stat-value.success {
  color: #52c41a;
}
.stat-value.danger {
  color: #ff4d4f;
}
.stat-value.primary {
  color: #1890ff;
}
.stat-label {
  font-size: 14px;
  color: #909399;
  margin-top: 5px;
}
.text-success {
  color: #67c23a;
  font-weight: bold;
}
.text-danger {
  color: #f56c6c;
  font-weight: bold;
}
.text-muted {
  color: #c0c4cc;
}
.highlight-value {
  font-size: 18px;
  font-weight: bold;
  color: #303133;
}
.highlight-value.success {
  color: #67c23a;
}
.highlight-value.danger {
  color: #f56c6c;
}
.highlight-value.primary {
  color: #409eff;
}
</style>
