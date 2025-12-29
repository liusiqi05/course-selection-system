<template>
  <div class="app-container">
    <!-- 超期警告 -->
    <el-alert
      v-if="expiredCourses.length > 0"
      title="成绩录入已超期！"
      type="error"
      :closable="false"
      show-icon
      class="mb20"
    >
      <template slot="default">
        <div>
          <p style="margin: 5px 0;"><i class="el-icon-warning-outline"></i> 以下课程已超过录入截止时间，请尽快完成并联系教务处说明情况：</p>
          <el-tag
            v-for="course in expiredCourses"
            :key="course.openId"
            type="danger"
            style="margin: 2px 4px; cursor: pointer;"
            @click="selectCourse(course)"
          >
            {{ course.courseName }}（截止：{{ course.scoreDeadline }}，待录入 {{ course.pendingCount }} 人）
          </el-tag>
        </div>
      </template>
    </el-alert>

    <!-- 成绩录入须知 -->
    <el-alert
      v-if="showNotice && expiredCourses.length === 0"
      title="成绩录入须知"
      type="warning"
      :closable="true"
      show-icon
      class="mb20"
      @close="showNotice = false"
    >
      <template slot="default">
        <div>
          <p style="margin: 5px 0;"><i class="el-icon-time"></i> 请在 <b>截止日期</b> 前完成成绩录入，超期录入需联系教务处。</p>
          <p style="margin: 5px 0;"><i class="el-icon-info"></i> 成绩计算规则：<b>总成绩 = 平时成绩 × 40% + 考试成绩 × 60%</b></p>
          <p style="margin: 5px 0;"><i class="el-icon-warning"></i> 成绩一旦提交，将无法自行修改，如需修改请联系教务处。</p>
        </div>
      </template>
    </el-alert>

    <!-- 待录入课程列表 -->
    <el-card class="box-card mb20" shadow="hover" v-if="!selectedCourse">
      <div slot="header" class="clearfix">
        <span><i class="el-icon-edit-outline"></i> 我的授课 - 成绩录入</span>
        <el-tag v-if="pendingCourses.length > 0" type="danger" size="small" style="margin-left: 10px;">
          {{ pendingCourses.length }} 门课程待录入
        </el-tag>
        <el-tag v-else type="success" size="small" style="margin-left: 10px;">
          全部完成
        </el-tag>
      </div>

      <!-- 学期筛选 -->
      <el-form :inline="true" size="small" class="mb10">
        <el-form-item label="学期">
          <el-select v-model="selectedTermId" placeholder="全部学期" clearable @change="filterCourses">
            <el-option
              v-for="term in termList"
              :key="term.termId"
              :label="term.termName"
              :value="term.termId"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="状态">
          <el-select v-model="filterStatus" placeholder="全部" clearable @change="filterCourses">
            <el-option label="待录入" value="pending" />
            <el-option label="已超期" value="expired" />
            <el-option label="已完成" value="completed" />
          </el-select>
        </el-form-item>
      </el-form>

      <el-table :data="filteredCourseList" v-loading="loadingCourses" style="width: 100%">
        <el-table-column label="学期" align="center" prop="termName" width="180" />
        <el-table-column label="课程代码" align="center" prop="courseCode" width="110" />
        <el-table-column label="课程名称" align="center" prop="courseName" min-width="140" />
        <el-table-column label="学分" align="center" prop="credit" width="60" />
        <el-table-column label="选课人数" align="center" prop="selectedNum" width="90" />
        <el-table-column label="录入进度" align="center" width="150">
          <template slot-scope="scope">
            <el-progress
              :percentage="getProgress(scope.row)"
              :color="getProgressColor(scope.row)"
              :stroke-width="10"
              :show-text="false"
            />
            <span class="progress-text">{{ scope.row.selectedNum - scope.row.pendingCount }}/{{ scope.row.selectedNum }}</span>
          </template>
        </el-table-column>
        <el-table-column label="截止日期" align="center" width="120">
          <template slot-scope="scope">
            <span v-if="scope.row.scoreDeadline" :class="{ 'expired-text': isExpired(scope.row) }">
              {{ scope.row.scoreDeadline }}
            </span>
            <el-tag v-else type="info" size="mini">未设置</el-tag>
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
        <el-table-column label="操作" align="center" width="140">
          <template slot-scope="scope">
            <el-button 
              :type="scope.row.pendingCount > 0 ? 'primary' : 'success'" 
              size="small" 
              @click="selectCourse(scope.row)"
            >
              <i :class="scope.row.pendingCount > 0 ? 'el-icon-edit' : 'el-icon-view'"></i>
              {{ scope.row.pendingCount > 0 ? '录入成绩' : '查看成绩' }}
            </el-button>
          </template>
        </el-table-column>
      </el-table>
      <el-empty v-if="!loadingCourses && filteredCourseList.length === 0" description="暂无课程"></el-empty>
    </el-card>

    <!-- 成绩录入区域 -->
    <template v-if="selectedCourse">
      <el-card class="box-card mb20" shadow="hover">
        <div slot="header" class="clearfix">
          <span><i class="el-icon-document"></i> {{ selectedCourse.courseName }} - 成绩录入</span>
          <el-tag v-if="selectedCourse.pendingCount === 0" type="success" style="margin-left: 10px;">已完成</el-tag>
          <el-tag v-else-if="isExpired(selectedCourse)" type="danger" style="margin-left: 10px;" effect="dark">
            <i class="el-icon-warning"></i> 已超期
          </el-tag>
          <el-tag v-else type="warning" style="margin-left: 10px;">待录入 {{ selectedCourse.pendingCount }} 人</el-tag>
          <el-button style="float: right; padding: 3px 0" type="text" @click="backToList">
            <i class="el-icon-back"></i> 返回课程列表
          </el-button>
        </div>
        <el-descriptions :column="5" border size="small">
          <el-descriptions-item label="学期">{{ selectedCourse.termName }}</el-descriptions-item>
          <el-descriptions-item label="课程代码">{{ selectedCourse.courseCode }}</el-descriptions-item>
          <el-descriptions-item label="学分">{{ selectedCourse.credit }}</el-descriptions-item>
          <el-descriptions-item label="选课人数">{{ selectedCourse.selectedNum }} 人</el-descriptions-item>
          <el-descriptions-item label="截止日期">
            <span v-if="selectedCourse.scoreDeadline" :class="{ 'expired-text': isExpired(selectedCourse) }">
              {{ selectedCourse.scoreDeadline }}
            </span>
            <el-tag v-else type="info" size="mini">未设置</el-tag>
          </el-descriptions-item>
        </el-descriptions>
      </el-card>

      <!-- 学生成绩表格 -->
      <el-card class="box-card" shadow="hover">
        <div slot="header" class="clearfix">
          <div style="display: flex; align-items: center; flex-wrap: wrap; gap: 10px;">
            <el-input
              v-model="searchText"
              placeholder="按学号或姓名搜索"
              prefix-icon="el-icon-search"
              size="small"
              style="width: 200px;"
              clearable
            />
            <el-button type="primary" size="small" @click="autoFillScores" v-if="unscoredCount > 0">
              <i class="el-icon-s-tools"></i> 一键填充
            </el-button>
            <el-button type="success" size="small" @click="batchSave" :loading="saving" v-if="unscoredFilledCount > 0">
              <i class="el-icon-check"></i> 批量保存 ({{ unscoredFilledCount }})
            </el-button>
            <el-button type="info" size="small" @click="backToList">
              <i class="el-icon-back"></i> 返回列表
            </el-button>
          </div>
          <div style="margin-top: 10px;">
            <el-progress
              :percentage="progressPercent"
              :color="progressPercent === 100 ? '#67C23A' : '#E6A23C'"
              :stroke-width="16"
            >
              <span>{{ scoredCount }}/{{ studentList.length }} ({{ progressPercent }}%)</span>
            </el-progress>
          </div>
        </div>

        <el-table :data="filteredStudentList" v-loading="loadingStudents" style="width: 100%">
          <el-table-column label="学号" align="center" prop="studentNo" width="120" />
          <el-table-column label="姓名" align="center" prop="studentName" width="100" />
          <el-table-column label="班级" align="center" prop="className" width="120" />
          <el-table-column label="平时成绩" align="center" width="110">
            <template slot-scope="scope">
              <el-input-number
                v-model="scope.row.usualScore"
                :min="0"
                :max="100"
                :precision="1"
                @change="calcTotalScore(scope.row)"
                :disabled="scope.row.score !== null"
                size="small"
                controls-position="right"
              />
            </template>
          </el-table-column>
          <el-table-column label="考试成绩" align="center" width="110">
            <template slot-scope="scope">
              <el-input-number
                v-model="scope.row.examScore"
                :min="0"
                :max="100"
                :precision="1"
                @change="calcTotalScore(scope.row)"
                :disabled="scope.row.score !== null"
                size="small"
                controls-position="right"
              />
            </template>
          </el-table-column>
          <el-table-column label="总成绩" align="center" width="100">
            <template slot-scope="scope">
              <el-tag v-if="scope.row.score !== null" :type="getScoreType(scope.row.score)" size="small">
                {{ scope.row.score }}
              </el-tag>
              <el-tag v-else-if="scope.row.totalScore" :type="getScoreType(scope.row.totalScore)" size="small" effect="plain">
                {{ scope.row.totalScore }}
              </el-tag>
              <span v-else>-</span>
            </template>
          </el-table-column>
          <el-table-column label="状态" align="center" width="90">
            <template slot-scope="scope">
              <el-tag v-if="scope.row.needRetake === '1'" type="danger" size="mini">需重修</el-tag>
              <el-tag v-else-if="scope.row.makeupScore !== null && scope.row.makeupScore >= 60" type="warning" size="mini">补考通过</el-tag>
              <el-tag v-else-if="scope.row.score !== null && scope.row.score < 60" type="danger" size="mini">挂科</el-tag>
              <el-tag v-else-if="scope.row.score !== null" type="success" size="mini">已提交</el-tag>
              <el-tag v-else-if="scope.row.totalScore" type="warning" size="mini">待保存</el-tag>
              <el-tag v-else type="info" size="mini">未录入</el-tag>
            </template>
          </el-table-column>
          <el-table-column label="操作" align="center" width="100">
            <template slot-scope="scope">
              <el-button
                type="primary"
                size="mini"
                @click="saveSingleScore(scope.row)"
                :disabled="!scope.row.totalScore || scope.row.score !== null"
                v-if="scope.row.score === null"
              >
                保存
              </el-button>
              <el-tag v-else type="success" size="mini">已提交</el-tag>
            </template>
          </el-table-column>
        </el-table>
      </el-card>

      <!-- 补考成绩录入区域 -->
      <el-card class="box-card" shadow="hover" v-if="failedStudentList.length > 0" style="margin-top: 20px;">
        <div slot="header" class="clearfix">
          <span><i class="el-icon-warning-outline"></i> 补考成绩录入</span>
          <el-tag type="danger" style="margin-left: 10px;">{{ failedStudentList.length }} 名学生挂科</el-tag>
          <el-button 
            style="float: right; padding: 3px 0" 
            type="text" 
            @click="loadFailedStudents(selectedCourse.openId)"
          >
            <i class="el-icon-refresh"></i> 刷新
          </el-button>
        </div>

        <el-alert type="info" :closable="false" show-icon class="mb10">
          <template slot="title">
            补考规则：补考成绩只能录入一次；补考通过者最终成绩按60分计算；补考不及格需重修。
          </template>
        </el-alert>

        <el-table :data="failedStudentList" v-loading="loadingFailed" style="width: 100%">
          <el-table-column label="学号" align="center" prop="studentNo" width="120" />
          <el-table-column label="姓名" align="center" prop="studentName" width="100" />
          <el-table-column label="班级" align="center" prop="className" width="120" />
          <el-table-column label="初考成绩" align="center" width="100">
            <template slot-scope="scope">
              <el-tag type="danger" size="small">{{ scope.row.score }}</el-tag>
            </template>
          </el-table-column>
          <el-table-column label="补考成绩" align="center" width="130">
            <template slot-scope="scope">
              <el-input-number
                v-if="scope.row.makeupScore === null"
                v-model="scope.row.newMakeupScore"
                :min="0"
                :max="100"
                :precision="1"
                size="small"
                controls-position="right"
                placeholder="输入补考成绩"
              />
              <el-tag v-else :type="scope.row.makeupScore >= 60 ? 'success' : 'danger'" size="small">
                {{ scope.row.makeupScore }}
              </el-tag>
            </template>
          </el-table-column>
          <el-table-column label="最终成绩" align="center" width="100">
            <template slot-scope="scope">
              <template v-if="scope.row.makeupScore !== null">
                <el-tag v-if="scope.row.makeupScore >= 60" type="warning" size="small">60</el-tag>
                <el-tag v-else type="danger" size="small">{{ scope.row.score }}</el-tag>
              </template>
              <span v-else>-</span>
            </template>
          </el-table-column>
          <el-table-column label="状态" align="center" width="100">
            <template slot-scope="scope">
              <el-tag v-if="scope.row.needRetake === '1'" type="danger" size="mini" effect="dark">需重修</el-tag>
              <el-tag v-else-if="scope.row.makeupScore !== null && scope.row.makeupScore >= 60" type="success" size="mini">补考通过</el-tag>
              <el-tag v-else-if="scope.row.makeupScore !== null" type="danger" size="mini">补考未过</el-tag>
              <el-tag v-else type="warning" size="mini">待补考</el-tag>
            </template>
          </el-table-column>
          <el-table-column label="操作" align="center" width="100">
            <template slot-scope="scope">
              <el-button
                v-if="scope.row.makeupScore === null"
                type="warning"
                size="mini"
                @click="saveMakeupScore(scope.row)"
                :disabled="scope.row.newMakeupScore === null || scope.row.newMakeupScore === undefined"
              >
                录入
              </el-button>
              <el-tag v-else type="info" size="mini">已录入</el-tag>
            </template>
          </el-table-column>
        </el-table>

        <div style="margin-top: 15px; text-align: right;">
          <el-button 
            type="warning" 
            size="small" 
            @click="batchSaveMakeupScore" 
            :loading="savingMakeup"
            :disabled="makeupToSaveCount === 0"
          >
            <i class="el-icon-check"></i> 批量保存补考成绩 ({{ makeupToSaveCount }})
          </el-button>
        </div>
      </el-card>
    </template>
  </div>
</template>

<script>
import { listMyCourseAsTeacher } from "@/api/education/opening";
import { listTermOptions } from "@/api/education/term";
import request from '@/utils/request';

export default {
  name: "ScoreInput",
  data() {
    return {
      showNotice: true,
      loadingCourses: false,
      courseList: [],
      termList: [],
      selectedTermId: null,
      filterStatus: null,
      // 选中的课程
      selectedCourse: null,
      studentList: [],
      loadingStudents: false,
      searchText: '',
      saving: false,
      // 补考相关
      failedStudentList: [],
      loadingFailed: false,
      savingMakeup: false
    };
  },
  computed: {
    // 过滤后的课程列表
    filteredCourseList() {
      let list = this.courseList;
      if (this.selectedTermId) {
        list = list.filter(c => c.termId === this.selectedTermId);
      }
      if (this.filterStatus === 'pending') {
        list = list.filter(c => c.pendingCount > 0 && !this.isExpired(c));
      } else if (this.filterStatus === 'expired') {
        list = list.filter(c => c.pendingCount > 0 && this.isExpired(c));
      } else if (this.filterStatus === 'completed') {
        list = list.filter(c => c.pendingCount === 0);
      }
      return list;
    },
    pendingCourses() {
      return this.courseList.filter(c => c.pendingCount > 0);
    },
    expiredCourses() {
      return this.courseList.filter(c => c.pendingCount > 0 && this.isExpired(c));
    },
    // 学生列表相关
    filteredStudentList() {
      if (!this.searchText) return this.studentList;
      const keyword = this.searchText.toLowerCase();
      return this.studentList.filter(s =>
        (s.studentNo && s.studentNo.toLowerCase().includes(keyword)) ||
        (s.studentName && s.studentName.toLowerCase().includes(keyword))
      );
    },
    scoredCount() {
      return this.studentList.filter(s => s.score !== null).length;
    },
    unscoredCount() {
      return this.studentList.filter(s => s.score === null).length;
    },
    unscoredFilledCount() {
      return this.studentList.filter(s => s.score === null && s.totalScore).length;
    },
    progressPercent() {
      if (this.studentList.length === 0) return 0;
      return Math.round((this.scoredCount / this.studentList.length) * 100);
    },
    makeupToSaveCount() {
      return this.failedStudentList.filter(s => s.makeupScore === null && s.newMakeupScore !== null && s.newMakeupScore !== undefined).length;
    }
  },
  created() {
    this.loadTermList();
    this.getCourseList();
  },
  methods: {
    loadTermList() {
      listTermOptions().then(response => {
        this.termList = response.data || [];
      });
    },
    getCourseList() {
      this.loadingCourses = true;
      listMyCourseAsTeacher({}).then(response => {
        this.courseList = response.rows || [];
        this.loadingCourses = false;
      });
    },
    filterCourses() {
      // 触发computed重新计算
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
    selectCourse(course) {
      this.selectedCourse = course;
      this.searchText = '';
      this.loadStudentList(course.openId);
      this.loadFailedStudents(course.openId);
    },
    backToList() {
      this.selectedCourse = null;
      this.studentList = [];
      this.failedStudentList = [];
      this.searchText = '';
      this.getCourseList(); // 刷新课程列表以同步数据
    },
    loadStudentList(openId) {
      this.loadingStudents = true;
      request({
        url: '/education/selection/myStudents/' + openId,
        method: 'get'
      }).then(response => {
        this.studentList = (response.rows || []).map(s => ({
          ...s,
          totalScore: s.score ? null : null
        }));
        this.loadingStudents = false;
      });
    },
    calcTotalScore(row) {
      if (row.usualScore != null && row.examScore != null) {
        row.totalScore = (row.usualScore * 0.4 + row.examScore * 0.6).toFixed(1);
      } else {
        row.totalScore = null;
      }
    },
    autoFillScores() {
      this.$confirm('将为所有未录入成绩的学生自动填充：平时成绩85分，考试成绩85分。是否继续？', '一键填充', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.studentList.forEach(s => {
          if (s.score === null) {
            s.usualScore = 85;
            s.examScore = 85;
            this.calcTotalScore(s);
          }
        });
        this.$message.success('已自动填充成绩，请检查后点击批量保存');
      });
    },
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
      }).then(() => {
        this.$message.success('保存成功');
        row.score = row.totalScore;
        this.updateCourseStatus();
      });
    },
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
        this.$message.success(response.msg || '保存成功');
        this.loadStudentList(this.selectedCourse.openId);
        this.saving = false;
        this.updateCourseStatus();
      }).catch(() => {
        this.saving = false;
      });
    },
    updateCourseStatus() {
      // 更新当前课程的待录入数
      const unscored = this.studentList.filter(s => s.score === null).length;
      if (this.selectedCourse) {
        this.selectedCourse.pendingCount = unscored;
      }
    },
    getScoreType(score) {
      if (score === null || score === undefined) return 'info';
      const s = parseFloat(score);
      if (s >= 90) return 'success';
      if (s >= 60) return '';
      return 'danger';
    },
    // 补考相关方法
    loadFailedStudents(openId) {
      this.loadingFailed = true;
      request({
        url: '/education/selection/failedStudents/' + openId,
        method: 'get'
      }).then(response => {
        this.failedStudentList = (response.rows || []).map(s => ({
          ...s,
          newMakeupScore: null
        }));
        this.loadingFailed = false;
      }).catch(() => {
        this.loadingFailed = false;
      });
    },
    saveMakeupScore(row) {
      if (row.newMakeupScore === null || row.newMakeupScore === undefined) {
        this.$message.warning('请输入补考成绩');
        return;
      }
      this.$confirm(
        `确认录入 ${row.studentName} 的补考成绩为 ${row.newMakeupScore} 分？` +
        (row.newMakeupScore >= 60 ? '（通过，最终成绩按60分计算）' : '（不及格，需重修）') +
        '\n注意：补考成绩只能录入一次，无法修改！',
        '确认录入补考成绩',
        {
          confirmButtonText: '确定录入',
          cancelButtonText: '取消',
          type: 'warning'
        }
      ).then(() => {
        request({
          url: '/education/selection/inputMakeupScore',
          method: 'put',
          data: {
            scId: row.scId,
            makeupScore: row.newMakeupScore
          }
        }).then(response => {
          this.$message.success(response.msg || '补考成绩录入成功');
          this.loadFailedStudents(this.selectedCourse.openId);
          this.loadStudentList(this.selectedCourse.openId);
        });
      });
    },
    batchSaveMakeupScore() {
      const toSave = this.failedStudentList.filter(s => s.makeupScore === null && s.newMakeupScore !== null && s.newMakeupScore !== undefined);
      if (toSave.length === 0) {
        this.$message.warning('没有需要保存的补考成绩');
        return;
      }
      this.$confirm(
        `确认批量录入 ${toSave.length} 名学生的补考成绩？\n注意：补考成绩只能录入一次，无法修改！`,
        '批量录入补考成绩',
        {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }
      ).then(() => {
        this.savingMakeup = true;
        request({
          url: '/education/selection/batchInputMakeupScore',
          method: 'put',
          data: toSave.map(s => ({
            scId: s.scId,
            makeupScore: s.newMakeupScore
          }))
        }).then(response => {
          this.$message.success(response.msg || '批量录入成功');
          this.loadFailedStudents(this.selectedCourse.openId);
          this.loadStudentList(this.selectedCourse.openId);
          this.savingMakeup = false;
        }).catch(() => {
          this.savingMakeup = false;
        });
      });
    }
  }
};
</script>

<style scoped>
.mb20 { margin-bottom: 20px; }
.mb10 { margin-bottom: 10px; }
.progress-text {
  font-size: 12px;
  color: #606266;
  display: block;
  text-align: center;
  margin-top: 2px;
}
.expired-text {
  color: #F56C6C;
  font-weight: bold;
}
</style>
