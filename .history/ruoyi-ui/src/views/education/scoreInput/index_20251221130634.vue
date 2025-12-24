<template>
  <div class="app-container">
    <!-- 打分时间提醒 -->
    <el-alert
      title="成绩录入须知"
      type="warning"
      :closable="false"
      show-icon
      class="mb20"
    >
      <template slot="default">
        <div>
          <p style="margin: 5px 0;"><i class="el-icon-time"></i> <b>录入截止时间：学期结束后两周内</b>，请及时完成成绩录入。</p>
          <p style="margin: 5px 0;"><i class="el-icon-info"></i> 成绩计算规则：<b>总成绩 = 平时成绩 × 40% + 考试成绩 × 60%</b></p>
          <p style="margin: 5px 0;"><i class="el-icon-warning"></i> 成绩一旦提交，将无法自行修改，如需修改请联系教务处。</p>
        </div>
      </template>
    </el-alert>

    <!-- 待录入课程列表 -->
    <el-card class="box-card mb20" shadow="hover" v-if="!selectedCourse">
      <div slot="header" class="clearfix">
        <span><i class="el-icon-edit-outline"></i> 待录入成绩的课程</span>
        <el-tag type="danger" size="small" style="margin-left: 10px;">{{ pendingCourses.length }} 门课程待录入</el-tag>
      </div>
      <el-table :data="pendingCourses" v-loading="loadingCourses" style="width: 100%">
        <el-table-column label="学期" align="center" prop="termName" width="180" />
        <el-table-column label="课程代码" align="center" prop="courseCode" width="120" />
        <el-table-column label="课程名称" align="center" prop="courseName" min-width="150" />
        <el-table-column label="学分" align="center" prop="credit" width="80" />
        <el-table-column label="选课人数" align="center" prop="selectedNum" width="100" />
        <el-table-column label="待录入" align="center" prop="pendingCount" width="100">
          <template slot-scope="scope">
            <el-tag type="danger">{{ scope.row.pendingCount }} 人</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" align="center" width="150">
          <template slot-scope="scope">
            <el-button type="primary" size="small" @click="selectCourse(scope.row)">
              <i class="el-icon-edit"></i> 录入成绩
            </el-button>
          </template>
        </el-table-column>
      </el-table>
      <el-empty v-if="!loadingCourses && pendingCourses.length === 0" description="暂无待录入成绩的课程"></el-empty>
    </el-card>

    <!-- 成绩录入区域 -->
    <template v-if="selectedCourse">
      <el-card class="box-card mb20" shadow="hover">
        <div slot="header" class="clearfix">
          <span><i class="el-icon-document"></i> {{ selectedCourse.courseName }} - 成绩录入</span>
          <el-button style="float: right; padding: 3px 0" type="text" @click="backToList">
            <i class="el-icon-back"></i> 返回课程列表
          </el-button>
        </div>
        <el-descriptions :column="4" border size="small">
          <el-descriptions-item label="学期">{{ selectedCourse.termName }}</el-descriptions-item>
          <el-descriptions-item label="课程代码">{{ selectedCourse.courseCode }}</el-descriptions-item>
          <el-descriptions-item label="学分">{{ selectedCourse.credit }}</el-descriptions-item>
          <el-descriptions-item label="选课人数">{{ selectedCourse.selectedNum }} 人</el-descriptions-item>
        </el-descriptions>
      </el-card>

      <!-- 学生成绩表格 -->
      <el-card class="box-card" shadow="hover">
        <div slot="header" class="clearfix">
          <span><i class="el-icon-user"></i> 学生成绩</span>
          <div style="float: right;">
            <el-button type="success" size="small" @click="batchSave" :loading="saving">
              <i class="el-icon-check"></i> 批量保存
            </el-button>
          </div>
        </div>
        
        <el-table :data="studentList" v-loading="loadingStudents" border stripe>
          <el-table-column label="序号" type="index" width="60" align="center" />
          <el-table-column label="学号" align="center" prop="studentNo" width="150" />
          <el-table-column label="姓名" align="center" prop="studentName" width="120" />
          <el-table-column label="平时成绩 (40%)" align="center" width="150">
            <template slot-scope="scope">
              <el-input-number
                v-model="scope.row.usualScore"
                :min="0"
                :max="100"
                :precision="1"
                :controls="false"
                size="small"
                style="width: 100px;"
                :disabled="scope.row.score !== null"
                @change="calcTotalScore(scope.row)"
              />
            </template>
          </el-table-column>
          <el-table-column label="考试成绩 (60%)" align="center" width="150">
            <template slot-scope="scope">
              <el-input-number
                v-model="scope.row.examScore"
                :min="0"
                :max="100"
                :precision="1"
                :controls="false"
                size="small"
                style="width: 100px;"
                :disabled="scope.row.score !== null"
                @change="calcTotalScore(scope.row)"
              />
            </template>
          </el-table-column>
          <el-table-column label="总成绩" align="center" width="120">
            <template slot-scope="scope">
              <el-tag :type="getScoreType(scope.row.totalScore || scope.row.score)" size="medium">
                {{ formatScore(scope.row.totalScore || scope.row.score) }}
              </el-tag>
            </template>
          </el-table-column>
          <el-table-column label="状态" align="center" width="100">
            <template slot-scope="scope">
              <el-tag :type="scope.row.score !== null ? 'success' : 'warning'" size="small">
                {{ scope.row.score !== null ? '已录入' : '待录入' }}
              </el-tag>
            </template>
          </el-table-column>
          <el-table-column label="操作" align="center" width="120">
            <template slot-scope="scope">
              <el-button
                v-if="scope.row.score === null"
                type="text"
                size="small"
                @click="saveSingleScore(scope.row)"
                :disabled="!scope.row.usualScore || !scope.row.examScore"
              >
                <i class="el-icon-check"></i> 保存
              </el-button>
              <span v-else style="color: #67c23a;"><i class="el-icon-success"></i> 已保存</span>
            </template>
          </el-table-column>
        </el-table>
        
        <div class="score-summary" v-if="studentList.length > 0">
          <el-row :gutter="20">
            <el-col :span="6">
              <div class="summary-item">
                <span class="label">总人数：</span>
                <span class="value">{{ studentList.length }}</span>
              </div>
            </el-col>
            <el-col :span="6">
              <div class="summary-item">
                <span class="label">已录入：</span>
                <span class="value success">{{ scoredCount }}</span>
              </div>
            </el-col>
            <el-col :span="6">
              <div class="summary-item">
                <span class="label">待录入：</span>
                <span class="value warning">{{ studentList.length - scoredCount }}</span>
              </div>
            </el-col>
            <el-col :span="6">
              <div class="summary-item">
                <span class="label">录入进度：</span>
                <el-progress :percentage="progressPercent" :status="progressPercent === 100 ? 'success' : ''" style="width: 150px; display: inline-block;"></el-progress>
              </div>
            </el-col>
          </el-row>
        </div>
      </el-card>
    </template>
  </div>
</template>

<script>
import request from '@/utils/request';

export default {
  name: "ScoreInput",
  data() {
    return {
      // 待录入课程列表
      pendingCourses: [],
      loadingCourses: false,
      // 当前选中课程
      selectedCourse: null,
      // 学生列表
      studentList: [],
      loadingStudents: false,
      // 保存中
      saving: false
    };
  },
  computed: {
    scoredCount() {
      return this.studentList.filter(s => s.score !== null).length;
    },
    progressPercent() {
      if (this.studentList.length === 0) return 0;
      return Math.round((this.scoredCount / this.studentList.length) * 100);
    }
  },
  created() {
    this.getPendingCourses();
  },
  methods: {
    /** 获取待录入成绩的课程 */
    getPendingCourses() {
      this.loadingCourses = true;
      request({
        url: '/education/opening/pendingScore',
        method: 'get'
      }).then(response => {
        this.pendingCourses = response.data || [];
        this.loadingCourses = false;
      }).catch(() => {
        this.loadingCourses = false;
      });
    },
    /** 选择课程进行录入 */
    selectCourse(course) {
      this.selectedCourse = course;
      this.getStudentList(course.openId);
    },
    /** 返回课程列表 */
    backToList() {
      this.selectedCourse = null;
      this.studentList = [];
      this.getPendingCourses();
    },
    /** 获取学生列表 */
    getStudentList(openId) {
      this.loadingStudents = true;
      request({
        url: `/education/selection/myStudents/${openId}`,
        method: 'get'
      }).then(response => {
        this.studentList = (response.rows || []).map(s => ({
          ...s,
          usualScore: s.usualScore,
          examScore: s.examScore,
          totalScore: null
        }));
        this.loadingStudents = false;
      }).catch(() => {
        this.loadingStudents = false;
      });
    },
    /** 计算总成绩 */
    calcTotalScore(row) {
      if (row.usualScore != null && row.examScore != null) {
        row.totalScore = (row.usualScore * 0.4 + row.examScore * 0.6).toFixed(1);
      } else {
        row.totalScore = null;
      }
    },
    /** 保存单个学生成绩 */
    saveSingleScore(row) {
      if (!row.usualScore || !row.examScore) {
        this.$message.warning('请填写完整成绩');
        return;
      }
      request({
        url: '/education/selection/inputScore',
        method: 'put',
        data: {
          scId: row.scId,
          usualScore: row.usualScore,
          examScore: row.examScore
        }
      }).then(response => {
        this.$message.success('保存成功');
        row.score = row.totalScore;
      });
    },
    /** 批量保存成绩 */
    batchSave() {
      const toSave = this.studentList.filter(s => s.score === null && s.usualScore && s.examScore);
      if (toSave.length === 0) {
        this.$message.warning('没有需要保存的成绩');
        return;
      }
      this.saving = true;
      request({
        url: '/education/selection/batchInputScore',
        method: 'put',
        data: toSave.map(s => ({
          scId: s.scId,
          usualScore: s.usualScore,
          examScore: s.examScore
        }))
      }).then(response => {
        this.$message.success(response.msg);
        // 刷新数据
        this.getStudentList(this.selectedCourse.openId);
        this.saving = false;
      }).catch(() => {
        this.saving = false;
      });
    },
    /** 成绩等级颜色 */
    getScoreType(score) {
      if (score === null || score === undefined) return 'info';
      const s = parseFloat(score);
      if (s >= 90) return 'success';
      if (s >= 60) return '';
      return 'danger';
    },
    /** 格式化成绩 */
    formatScore(score) {
      if (score === null || score === undefined) return '—';
      return parseFloat(score).toFixed(1);
    }
  }
};
</script>

<style scoped>
.mb20 {
  margin-bottom: 20px;
}
.score-summary {
  margin-top: 20px;
  padding: 15px;
  background-color: #f5f7fa;
  border-radius: 4px;
}
.summary-item {
  display: flex;
  align-items: center;
}
.summary-item .label {
  color: #606266;
  font-size: 14px;
}
.summary-item .value {
  font-size: 18px;
  font-weight: bold;
  color: #303133;
  margin-left: 5px;
}
.summary-item .value.success {
  color: #67c23a;
}
.summary-item .value.warning {
  color: #e6a23c;
}
</style>
