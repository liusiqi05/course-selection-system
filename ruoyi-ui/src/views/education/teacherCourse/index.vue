<template>
  <div class="app-container">
    <!-- 成绩录入截止提醒 -->
    <el-alert
      v-if="expiredCourses.length > 0"
      title="成绩录入已超期"
      type="error"
      :closable="false"
      show-icon
      class="mb20"
    >
      <template slot="default">
        <span>以下课程已超过成绩录入截止时间，请尽快完成：</span>
        <el-tag
          v-for="course in expiredCourses"
          :key="course.openId"
          type="danger"
          size="small"
          style="margin-left: 8px;"
        >
          {{ course.courseName }}（截止：{{ course.scoreDeadline || '未设置' }}）
        </el-tag>
      </template>
    </el-alert>

    <!-- 待录入提醒 -->
    <el-alert
      v-if="pendingCourses.length > 0 && expiredCourses.length === 0"
      title="成绩录入提醒"
      type="warning"
      :closable="false"
      show-icon
      class="mb20"
    >
      <template slot="default">
        <span>您有 <b>{{ pendingCourses.length }}</b> 门课程需要录入学生成绩，请前往【录入成绩】模块完成录入</span>
      </template>
    </el-alert>

    <!-- 筛选条件 -->
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="学期" prop="termId">
        <el-select v-model="queryParams.termId" placeholder="请选择学期" clearable @change="handleQuery">
          <el-option
            v-for="term in termList"
            :key="term.termId"
            :label="term.termName"
            :value="term.termId"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="课程名称" prop="courseName">
        <el-input
          v-model="queryParams.courseName"
          placeholder="请输入课程名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择状态" clearable>
          <el-option label="进行中" value="0" />
          <el-option label="已结课" value="1" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <!-- 课程列表 -->
    <el-table v-loading="loading" :data="courseList" @row-click="handleRowClick" highlight-current-row>
      <el-table-column label="学期" align="center" prop="termName" width="180" />
      <el-table-column label="课程代码" align="center" prop="courseCode" width="120" />
      <el-table-column label="课程名称" align="center" prop="courseName" min-width="150" />
      <el-table-column label="学分" align="center" prop="credit" width="70" />
      <el-table-column label="上课时间" align="center" prop="classTime" width="140" />
      <el-table-column label="上课地点" align="center" prop="classLocation" width="100" />
      <el-table-column label="选课人数" align="center" width="100">
        <template slot-scope="scope">
          <el-tag :type="scope.row.selectedNum >= scope.row.maxStudents ? 'danger' : 'success'" size="small">
            {{ scope.row.selectedNum }}/{{ scope.row.maxStudents }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="成绩录入" align="center" width="120">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.pendingCount === 0" type="success" size="small">已完成</el-tag>
          <el-tag v-else-if="isExpired(scope.row)" type="danger" size="small">超期 {{ scope.row.pendingCount }}人</el-tag>
          <el-tag v-else type="warning" size="small">待录入 {{ scope.row.pendingCount }}人</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="课程状态" align="center" width="120">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.status === '1'" type="success" size="small">
            <i class="el-icon-check"></i> 已结课
          </el-tag>
          <el-tag v-else type="primary" size="small">
            <i class="el-icon-loading"></i> 进行中
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="260" fixed="right">
        <template slot-scope="scope">
          <el-button size="mini" type="text" icon="el-icon-user" @click.stop="viewStudents(scope.row)">
            学生名单
          </el-button>
          <el-button size="mini" type="text" icon="el-icon-setting" @click.stop="editCourse(scope.row)">
            设置
          </el-button>
          <el-button 
            v-if="scope.row.status !== '1'" 
            size="mini" 
            type="text" 
            icon="el-icon-finished"
            style="color: #E6A23C;"
            @click.stop="handleFinishCourse(scope.row)"
          >
            结课
          </el-button>
          <el-button 
            v-else 
            size="mini" 
            type="text" 
            icon="el-icon-refresh-left"
            style="color: #909399;"
            @click.stop="handleCancelFinish(scope.row)"
          >
            取消结课
          </el-button>
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

    <!-- 学生名单抽屉 -->
    <el-drawer
      :title="currentCourse ? currentCourse.courseName + ' - 学生名单' : '学生名单'"
      :visible.sync="studentDrawerVisible"
      size="60%"
      direction="rtl"
    >
      <div class="drawer-content">
        <!-- 课程信息摘要 -->
        <el-descriptions :column="3" border size="small" class="mb20" v-if="currentCourse">
          <el-descriptions-item label="课程代码">{{ currentCourse.courseCode }}</el-descriptions-item>
          <el-descriptions-item label="学分">{{ currentCourse.credit }}</el-descriptions-item>
          <el-descriptions-item label="选课人数">{{ studentList.length }} 人</el-descriptions-item>
          <el-descriptions-item label="上课时间">{{ currentCourse.classTime }}</el-descriptions-item>
          <el-descriptions-item label="上课地点">{{ currentCourse.classLocation }}</el-descriptions-item>
          <el-descriptions-item label="成绩录入">
            <el-tag :type="currentCourse.pendingCount === 0 ? 'success' : 'warning'" size="small">
              {{ currentCourse.pendingCount === 0 ? '已全部录入' : '待录入 ' + currentCourse.pendingCount + ' 人' }}
            </el-tag>
          </el-descriptions-item>
        </el-descriptions>

        <!-- 操作按钮 -->
        <el-row :gutter="10" class="mb10">
          <el-col :span="12">
            <el-input
              v-model="studentSearch"
              placeholder="搜索学号/姓名"
              prefix-icon="el-icon-search"
              size="small"
              clearable
            />
          </el-col>
          <el-col :span="12" style="text-align: right;">
            <el-button type="warning" size="small" icon="el-icon-download" @click="exportStudentList">
              导出名单
            </el-button>
            <el-button type="primary" size="small" icon="el-icon-edit" @click="goToScoreInput" v-if="currentCourse && currentCourse.pendingCount > 0">
              去录入成绩
            </el-button>
          </el-col>
        </el-row>

        <!-- 学生表格 -->
        <el-table :data="filteredStudentList" v-loading="loadingStudents" size="small" max-height="500">
          <el-table-column label="序号" type="index" width="50" align="center" />
          <el-table-column label="学号" prop="studentNo" width="120" align="center" />
          <el-table-column label="姓名" prop="studentName" width="100" align="center" />
          <el-table-column label="班级" prop="className" width="120" align="center" />
          <el-table-column label="选课时间" prop="enrollTime" width="160" align="center">
            <template slot-scope="scope">
              {{ parseTime(scope.row.enrollTime, '{y}-{m}-{d} {h}:{i}') }}
            </template>
          </el-table-column>
          <el-table-column label="平时成绩" prop="usualScore" width="90" align="center">
            <template slot-scope="scope">
              <span v-if="scope.row.usualScore != null">{{ scope.row.usualScore }}</span>
              <el-tag v-else type="info" size="mini">-</el-tag>
            </template>
          </el-table-column>
          <el-table-column label="考试成绩" prop="examScore" width="90" align="center">
            <template slot-scope="scope">
              <span v-if="scope.row.examScore != null">{{ scope.row.examScore }}</span>
              <el-tag v-else type="info" size="mini">-</el-tag>
            </template>
          </el-table-column>
          <el-table-column label="总成绩" prop="score" width="90" align="center">
            <template slot-scope="scope">
              <el-tag v-if="scope.row.score != null" :type="getScoreType(scope.row.score)" size="small">
                {{ scope.row.score }}
              </el-tag>
              <el-tag v-else type="info" size="mini">未录入</el-tag>
            </template>
          </el-table-column>
          <el-table-column label="操作" width="100" align="center" v-if="isAdmin">
            <template slot-scope="scope">
              <el-button size="mini" type="text" icon="el-icon-edit" @click="adminEditScore(scope.row)">
                编辑
              </el-button>
            </template>
          </el-table-column>
        </el-table>
      </div>
    </el-drawer>

    <!-- 课程设置对话框 -->
    <el-dialog title="课程设置" :visible.sync="settingDialogVisible" width="550px" append-to-body>
      <el-form ref="settingForm" :model="settingForm" :rules="settingRules" label-width="120px">
        <el-form-item label="课程名称">
          <el-input v-model="settingForm.courseName" disabled />
        </el-form-item>
        <el-form-item label="上课时间" prop="classTime">
          <el-input v-model="settingForm.classTime" placeholder="如：周一1-2节,周三3-4节" />
        </el-form-item>
        <el-form-item label="上课地点" prop="classLocation">
          <el-input v-model="settingForm.classLocation" placeholder="请输入上课地点" />
        </el-form-item>
        <el-form-item label="成绩截止日期" prop="scoreDeadline">
          <el-date-picker
            v-model="settingForm.scoreDeadline"
            type="date"
            placeholder="选择成绩录入截止日期"
            value-format="yyyy-MM-dd"
            style="width: 100%;"
          />
        </el-form-item>
        <el-divider content-position="left">成绩比例设置</el-divider>
        <el-form-item label="平时成绩占比" prop="usualRatio">
          <el-slider 
            v-model="settingForm.usualRatioPercent" 
            :min="0" 
            :max="100" 
            :step="5"
            :format-tooltip="val => val + '%'"
            @input="onRatioChange"
          />
          <span class="ratio-display">{{ settingForm.usualRatioPercent }}%</span>
        </el-form-item>
        <el-form-item label="期末成绩占比">
          <el-slider 
            v-model="settingForm.examRatioPercent" 
            :min="0" 
            :max="100" 
            :step="5"
            :format-tooltip="val => val + '%'"
            disabled
          />
          <span class="ratio-display">{{ settingForm.examRatioPercent }}%</span>
        </el-form-item>
        <el-alert type="info" :closable="false" style="margin-top: 10px;">
          <template slot="title">
            <i class="el-icon-info"></i> 
            总成绩 = 平时成绩 × {{ settingForm.usualRatioPercent }}% + 期末成绩 × {{ settingForm.examRatioPercent }}%
          </template>
        </el-alert>
      </el-form>
      <div slot="footer">
        <el-button @click="settingDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="saveSetting">确 定</el-button>
      </div>
    </el-dialog>

    <!-- 管理员编辑成绩对话框 -->
    <el-dialog title="编辑成绩（管理员）" :visible.sync="adminScoreDialogVisible" width="400px" append-to-body>
      <el-alert type="warning" :closable="false" class="mb20">
        <template slot="title">
          <i class="el-icon-warning"></i> 此操作仅限管理员使用，修改后将直接生效
        </template>
      </el-alert>
      <el-form ref="adminScoreForm" :model="adminScoreForm" :rules="adminScoreRules" label-width="80px">
        <el-form-item label="学号">
          <el-input v-model="adminScoreForm.studentNo" disabled />
        </el-form-item>
        <el-form-item label="姓名">
          <el-input v-model="adminScoreForm.studentName" disabled />
        </el-form-item>
        <el-form-item label="平时成绩" prop="usualScore">
          <el-input-number v-model="adminScoreForm.usualScore" :min="0" :max="100" :precision="1" style="width: 100%;" />
        </el-form-item>
        <el-form-item label="考试成绩" prop="examScore">
          <el-input-number v-model="adminScoreForm.examScore" :min="0" :max="100" :precision="1" style="width: 100%;" />
        </el-form-item>
        <el-form-item label="总成绩">
          <el-tag type="primary" size="medium">{{ calcTotalScore }}</el-tag>
          <span style="margin-left: 10px; color: #909399; font-size: 12px;">= 平时×40% + 考试×60%</span>
        </el-form-item>
      </el-form>
      <div slot="footer">
        <el-button @click="adminScoreDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="saveAdminScore">保 存</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listMyCourseAsTeacher, updateOpening, finishCourse, cancelFinishCourse } from "@/api/education/opening";
import { listTermOptions } from "@/api/education/term";
import request from '@/utils/request';

export default {
  name: "TeacherCourse",
  data() {
    return {
      loading: false,
      showSearch: true,
      total: 0,
      courseList: [],
      termList: [],
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        termId: null,
        courseName: null,
        status: null
      },
      // 学生名单抽屉
      studentDrawerVisible: false,
      currentCourse: null,
      studentList: [],
      loadingStudents: false,
      studentSearch: '',
      // 课程设置
      settingDialogVisible: false,
      settingForm: {
        openId: null,
        courseName: '',
        classTime: '',
        classLocation: '',
        scoreDeadline: null,
        usualRatioPercent: 40,
        examRatioPercent: 60
      },
      settingRules: {
        classTime: [{ required: true, message: '请输入上课时间', trigger: 'blur' }],
        classLocation: [{ required: true, message: '请输入上课地点', trigger: 'blur' }]
      },
      // 管理员编辑成绩
      adminScoreDialogVisible: false,
      adminScoreForm: {},
      adminScoreRules: {
        usualScore: [{ required: true, message: '请输入平时成绩', trigger: 'blur' }],
        examScore: [{ required: true, message: '请输入考试成绩', trigger: 'blur' }]
      }
    };
  },
  computed: {
    pendingCourses() {
      return this.courseList.filter(c => c.pendingCount > 0);
    },
    expiredCourses() {
      return this.courseList.filter(c => c.pendingCount > 0 && this.isExpired(c));
    },
    filteredStudentList() {
      if (!this.studentSearch) return this.studentList;
      const keyword = this.studentSearch.toLowerCase();
      return this.studentList.filter(s =>
        (s.studentNo && s.studentNo.toLowerCase().includes(keyword)) ||
        (s.studentName && s.studentName.toLowerCase().includes(keyword))
      );
    },
    isAdmin() {
      const roles = this.$store.getters.roles || [];
      return roles.includes('admin');
    },
    calcTotalScore() {
      const { usualScore, examScore } = this.adminScoreForm;
      if (usualScore != null && examScore != null) {
        return (usualScore * 0.4 + examScore * 0.6).toFixed(1);
      }
      return '-';
    }
  },
  created() {
    this.loadTermList();
  },
  methods: {
    loadTermList() {
      listTermOptions().then(response => {
        this.termList = response.data || [];
        if (this.termList.length > 0) {
          this.queryParams.termId = this.termList[0].termId;
        }
        this.getList();
      });
    },
    getList() {
      this.loading = true;
      listMyCourseAsTeacher(this.queryParams).then(response => {
        this.courseList = response.rows || [];
        this.total = response.total || 0;
        this.loading = false;
      });
    },
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    resetQuery() {
      this.resetForm("queryForm");
      this.handleQuery();
    },
    handleRowClick(row) {
      this.viewStudents(row);
    },
    isExpired(course) {
      if (!course.scoreDeadline) return false;
      return new Date(course.scoreDeadline) < new Date();
    },
    viewStudents(course) {
      this.currentCourse = course;
      this.studentDrawerVisible = true;
      this.loadStudentList(course.openId);
    },
    loadStudentList(openId) {
      this.loadingStudents = true;
      request({
        url: '/education/selection/myStudents/' + openId,
        method: 'get'
      }).then(response => {
        this.studentList = response.rows || [];
        this.loadingStudents = false;
      });
    },
    exportStudentList() {
      if (!this.currentCourse) return;
      this.$confirm('是否导出当前课程的学生名单？', '提示', {
        type: 'warning'
      }).then(() => {
        this.download('/education/selection/exportStudents/' + this.currentCourse.openId, {}, 
          `${this.currentCourse.courseName}_学生名单.xlsx`);
      });
    },
    goToScoreInput() {
      this.studentDrawerVisible = false;
      this.$router.push('/education/score/input');
    },
    getScoreType(score) {
      if (score >= 90) return 'success';
      if (score >= 60) return '';
      return 'danger';
    },
    editCourse(course) {
      // 将比例转换为百分比显示
      const usualRatio = course.usualRatio || 0.40;
      const examRatio = course.examRatio || 0.60;
      this.settingForm = {
        openId: course.openId,
        courseName: course.courseName,
        classTime: course.classTime,
        classLocation: course.classLocation,
        scoreDeadline: course.scoreDeadline,
        usualRatioPercent: Math.round(usualRatio * 100),
        examRatioPercent: Math.round(examRatio * 100)
      };
      this.settingDialogVisible = true;
    },
    onRatioChange(val) {
      // 平时成绩变化时，期末成绩自动调整
      this.settingForm.examRatioPercent = 100 - val;
    },
    saveSetting() {
      this.$refs.settingForm.validate(valid => {
        if (valid) {
          // 转换百分比为小数
          const data = {
            openId: this.settingForm.openId,
            classTime: this.settingForm.classTime,
            classLocation: this.settingForm.classLocation,
            scoreDeadline: this.settingForm.scoreDeadline,
            usualRatio: this.settingForm.usualRatioPercent / 100,
            examRatio: this.settingForm.examRatioPercent / 100
          };
          request({
            url: '/education/opening/updateMyCourse',
            method: 'put',
            data: data
          }).then(() => {
            this.$message.success('保存成功');
            this.settingDialogVisible = false;
            this.getList();
          });
        }
      });
    },
    adminEditScore(row) {
      this.adminScoreForm = {
        scId: row.scId,
        studentNo: row.studentNo,
        studentName: row.studentName,
        usualScore: row.usualScore,
        examScore: row.examScore
      };
      this.adminScoreDialogVisible = true;
    },
    saveAdminScore() {
      this.$refs.adminScoreForm.validate(valid => {
        if (valid) {
          request({
            url: '/education/selection/adminInputScore',
            method: 'put',
            data: this.adminScoreForm
          }).then(() => {
            this.$message.success('成绩保存成功');
            this.adminScoreDialogVisible = false;
            this.loadStudentList(this.currentCourse.openId);
            this.getList();
          });
        }
      });
    },
    /** 结课操作 */
    handleFinishCourse(row) {
      this.$confirm(`确认将课程【${row.courseName}】标记为结课吗？结课后学生才能对该课程进行评价。`, '结课确认', {
        confirmButtonText: '确定结课',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        finishCourse(row.openId).then(() => {
          this.$message.success('结课成功，学生现在可以评价该课程了');
          this.getList();
        });
      }).catch(() => {});
    },
    /** 取消结课 */
    handleCancelFinish(row) {
      this.$confirm(`确认取消课程【${row.courseName}】的结课状态吗？取消后学生将无法评价该课程。`, '取消结课', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        cancelFinishCourse(row.openId).then(() => {
          this.$message.success('已取消结课');
          this.getList();
        });
      }).catch(() => {});
    }
  }
};
</script>

<style scoped>
.mb20 { margin-bottom: 20px; }
.mb10 { margin-bottom: 10px; }
.drawer-content { padding: 20px; }
.ratio-display {
  display: inline-block;
  width: 50px;
  text-align: right;
  font-weight: bold;
  color: #409EFF;
}
</style>
