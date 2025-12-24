<template>
  <div class="app-container">
    <!-- 页面标题 -->
    <el-card class="box-card" shadow="hover">
      <div slot="header" class="clearfix">
        <span class="card-title"><i class="el-icon-star-on"></i> 课程评价</span>
        <span class="subtitle">对已结课的课程进行评价，帮助改进教学质量</span>
      </div>

      <!-- 待评价课程列表 -->
      <div v-if="pendingList.length > 0">
        <el-alert
          title="您有课程待评价"
          type="warning"
          :description="'共有 ' + pendingList.length + ' 门已结课课程需要评价'"
          show-icon
          :closable="false"
          style="margin-bottom: 20px"
        />
        
        <el-row :gutter="20">
          <el-col :span="8" v-for="item in pendingList" :key="item.scId">
            <el-card class="course-card" shadow="hover">
              <div class="course-header">
                <span class="course-name">{{ item.courseName }}</span>
                <el-tag size="small" type="info">待评价</el-tag>
              </div>
              <div class="course-info">
                <p><i class="el-icon-user"></i> 授课教师：{{ item.teacherName }}</p>
                <p><i class="el-icon-time"></i> 学期：{{ item.termName }}</p>
                <p v-if="item.overallScore"><i class="el-icon-trophy"></i> 成绩：{{ item.overallScore }}分</p>
              </div>
              <el-button type="primary" size="small" @click="openEvaluationDialog(item)" style="width: 100%">
                <i class="el-icon-edit"></i> 立即评价
              </el-button>
            </el-card>
          </el-col>
        </el-row>
      </div>

      <el-empty v-else description="暂无待评价课程">
        <template #image>
          <i class="el-icon-circle-check" style="font-size: 60px; color: #67C23A"></i>
        </template>
        <p>您已完成所有课程评价，感谢您的参与！</p>
      </el-empty>
    </el-card>

    <!-- 评价弹窗 -->
    <el-dialog 
      title="课程评价" 
      :visible.sync="dialogVisible" 
      width="600px"
      :close-on-click-modal="false"
    >
      <div v-if="currentCourse" class="eval-dialog">
        <div class="course-title">
          <h3>{{ currentCourse.courseName }}</h3>
          <p>授课教师：{{ currentCourse.teacherName }} | {{ currentCourse.termName }}</p>
        </div>

        <el-divider content-position="left">评分项目</el-divider>

        <el-form :model="evalForm" label-width="120px" :rules="rules" ref="evalForm">
          <el-form-item label="教学质量" prop="teachingScore">
            <el-rate 
              v-model="evalForm.teachingScore" 
              :colors="rateColors"
              :texts="rateTexts"
              show-text
            />
          </el-form-item>

          <el-form-item label="课程内容" prop="contentScore">
            <el-rate 
              v-model="evalForm.contentScore" 
              :colors="rateColors"
              :texts="rateTexts"
              show-text
            />
          </el-form-item>

          <el-form-item label="难度适中" prop="difficultyScore">
            <el-rate 
              v-model="evalForm.difficultyScore" 
              :colors="rateColors"
              :texts="rateTexts"
              show-text
            />
          </el-form-item>

          <el-form-item label="作业量" prop="workloadScore">
            <el-rate 
              v-model="evalForm.workloadScore" 
              :colors="rateColors"
              :texts="rateTexts"
              show-text
            />
          </el-form-item>

          <el-form-item label="总体评价" prop="overallScore">
            <el-rate 
              v-model="evalForm.overallScore" 
              :colors="rateColors"
              :texts="rateTexts"
              show-text
            />
          </el-form-item>

          <el-divider content-position="left">文字评价</el-divider>

          <el-form-item label="评价内容">
            <el-input 
              type="textarea" 
              v-model="evalForm.comment"
              :rows="4"
              placeholder="请输入您对课程的评价和建议（选填）"
              maxlength="500"
              show-word-limit
            />
          </el-form-item>

          <el-form-item label="匿名评价">
            <el-switch v-model="evalForm.isAnonymous" active-value="1" inactive-value="0" />
            <span style="margin-left: 10px; color: #909399; font-size: 12px">
              {{ evalForm.isAnonymous === '1' ? '教师将不会看到您的姓名' : '教师可以看到您的姓名' }}
            </span>
          </el-form-item>
        </el-form>
      </div>

      <span slot="footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="submitEval" :loading="submitting">提交评价</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import { getPendingEvaluations, submitEvaluation } from "@/api/education/evaluation";

export default {
  name: "StudentEvaluation",
  data() {
    return {
      pendingList: [],
      dialogVisible: false,
      currentCourse: null,
      submitting: false,
      evalForm: {
        openId: null,
        teachingScore: 5,
        contentScore: 5,
        difficultyScore: 5,
        workloadScore: 5,
        overallScore: 5,
        comment: '',
        isAnonymous: '1'
      },
      rateColors: ['#F56C6C', '#E6A23C', '#409EFF', '#67C23A', '#67C23A'],
      rateTexts: ['很差', '较差', '一般', '较好', '很好'],
      rules: {
        teachingScore: [{ required: true, message: '请评价教学质量', trigger: 'change' }],
        contentScore: [{ required: true, message: '请评价课程内容', trigger: 'change' }],
        difficultyScore: [{ required: true, message: '请评价难度', trigger: 'change' }],
        workloadScore: [{ required: true, message: '请评价作业量', trigger: 'change' }],
        overallScore: [{ required: true, message: '请进行总体评价', trigger: 'change' }]
      }
    };
  },
  created() {
    this.loadPendingList();
  },
  methods: {
    loadPendingList() {
      getPendingEvaluations().then(response => {
        this.pendingList = response.data || [];
      });
    },
    openEvaluationDialog(course) {
      this.currentCourse = course;
      this.evalForm = {
        openId: course.openId,
        teachingScore: 5,
        contentScore: 5,
        difficultyScore: 5,
        workloadScore: 5,
        overallScore: 5,
        comment: '',
        isAnonymous: '1'
      };
      this.dialogVisible = true;
    },
    submitEval() {
      this.$refs.evalForm.validate(valid => {
        if (valid) {
          this.submitting = true;
          submitEvaluation(this.evalForm).then(response => {
            this.$message.success("评价提交成功！");
            this.dialogVisible = false;
            this.loadPendingList();
          }).finally(() => {
            this.submitting = false;
          });
        }
      });
    }
  }
};
</script>

<style scoped>
.card-title {
  font-size: 18px;
  font-weight: bold;
  color: #303133;
}

.subtitle {
  float: right;
  font-size: 14px;
  color: #909399;
}

.course-card {
  margin-bottom: 20px;
}

.course-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 15px;
}

.course-name {
  font-size: 16px;
  font-weight: bold;
  color: #303133;
}

.course-info {
  color: #606266;
  font-size: 14px;
  margin-bottom: 15px;
}

.course-info p {
  margin: 8px 0;
}

.course-info i {
  margin-right: 5px;
  color: #909399;
}

.eval-dialog .course-title {
  text-align: center;
  margin-bottom: 20px;
}

.eval-dialog .course-title h3 {
  margin: 0 0 5px 0;
  color: #303133;
}

.eval-dialog .course-title p {
  margin: 0;
  color: #909399;
  font-size: 14px;
}

.el-rate {
  height: 30px;
  line-height: 30px;
}
</style>
