<template>
  <div class="app-container schedule-container">
    <!-- 学期选择和标题 -->
    <el-card class="header-card" shadow="hover">
      <div class="schedule-header">
        <div class="header-left">
          <el-select v-model="termId" placeholder="选择学期" @change="loadSchedule" size="medium">
            <el-option
              v-for="term in termList"
              :key="term.termId"
              :label="term.termName"
              :value="term.termId"
            />
          </el-select>
          <el-tag type="success" size="medium" style="margin-left: 15px;" v-if="courseList.length > 0">
            共 {{ courseList.length }} 门课程
          </el-tag>
        </div>
        <div class="header-center">
          <h2><i class="el-icon-date"></i> 我的授课表</h2>
        </div>
        <div class="header-right">
          <el-button type="primary" size="small" icon="el-icon-refresh" @click="loadSchedule">刷新</el-button>
          <el-tooltip content="点击课程卡片查看详情" placement="bottom">
            <el-button type="info" size="small" icon="el-icon-question" circle></el-button>
          </el-tooltip>
        </div>
      </div>
    </el-card>

    <!-- 课程表周视图 - 优化版 -->
    <div class="schedule-table-wrapper">
      <table class="schedule-table">
        <thead>
          <tr>
            <th class="time-col">节次/时间</th>
            <th v-for="day in weekDays" :key="day.key" class="day-col">{{ day.label }}</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="period in periods" :key="period.num" :class="{ 'period-divider': [2, 4, 6, 8].includes(period.num) }">
            <td class="time-cell">
              <div class="period-num">第{{ period.num }}节</div>
              <div class="period-time">{{ period.time }}</div>
            </td>
            <td v-for="day in weekDays" :key="day.key + '-' + period.num" class="course-cell">
              <div
                v-if="getCourse(day.key, period.num)"
                class="course-card"
                :style="{ backgroundColor: getCourse(day.key, period.num).color }"
                @click="showCourseDetail(getCourse(day.key, period.num))"
              >
                <div class="course-name" :title="getCourse(day.key, period.num).courseName">
                  {{ getCourse(day.key, period.num).courseName }}
                </div>
                <div class="course-info">
                  <span class="course-code">{{ getCourse(day.key, period.num).courseCode }}</span>
                </div>
                <div class="course-location" :title="getCourse(day.key, period.num).classLocation">
                  <i class="el-icon-location-outline"></i>
                  {{ getCourse(day.key, period.num).classLocation }}
                </div>
                <div class="course-students">
                  <i class="el-icon-user"></i>
                  {{ getCourse(day.key, period.num).selectedNum }}/{{ getCourse(day.key, period.num).maxStudents }}
                </div>
              </div>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- 课程列表汇总 -->
    <el-card class="course-summary" shadow="hover">
      <div slot="header">
        <span><i class="el-icon-s-grid"></i> 本学期授课汇总</span>
        <span class="summary-count">共 {{ courseList.length }} 门课程</span>
      </div>
      <el-table :data="courseList" stripe style="width: 100%">
        <el-table-column prop="courseName" label="课程名称" width="200">
          <template slot-scope="scope">
            <span :style="{ color: scope.row.color, fontWeight: 'bold' }">
              {{ scope.row.courseName }}
            </span>
          </template>
        </el-table-column>
        <el-table-column prop="courseCode" label="课程代码" width="120" />
        <el-table-column prop="credit" label="学分" width="80" align="center" />
        <el-table-column prop="classTime" label="上课时间" width="180" />
        <el-table-column prop="classLocation" label="上课地点" width="150" />
        <el-table-column label="选课人数" width="120" align="center">
          <template slot-scope="scope">
            <el-progress 
              :percentage="Math.round(scope.row.selectedNum / scope.row.maxStudents * 100)" 
              :color="scope.row.selectedNum >= scope.row.maxStudents ? '#F56C6C' : '#409EFF'"
            />
            <span class="progress-text">{{ scope.row.selectedNum }}/{{ scope.row.maxStudents }}</span>
          </template>
        </el-table-column>
        <el-table-column label="状态" width="100" align="center">
          <template slot-scope="scope">
            <el-tag :type="scope.row.status === '0' ? 'success' : 'info'" size="small">
              {{ scope.row.status === '0' ? '进行中' : '已结课' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="150" align="center">
          <template slot-scope="scope">
            <el-button type="text" size="small" @click="goToStudentList(scope.row)">
              <i class="el-icon-user"></i> 学生名单
            </el-button>
          </template>
        </el-table-column>
      </el-table>
      <el-empty v-if="courseList.length === 0" description="暂无授课"></el-empty>
    </el-card>

    <!-- 课程详情弹窗 -->
    <el-dialog :title="currentCourse ? currentCourse.courseName : ''" :visible.sync="dialogVisible" width="500px">
      <div v-if="currentCourse" class="course-detail">
        <el-descriptions :column="2" border>
          <el-descriptions-item label="课程代码">{{ currentCourse.courseCode }}</el-descriptions-item>
          <el-descriptions-item label="学分">{{ currentCourse.credit }}</el-descriptions-item>
          <el-descriptions-item label="上课时间">{{ currentCourse.classTime }}</el-descriptions-item>
          <el-descriptions-item label="上课地点">{{ currentCourse.classLocation }}</el-descriptions-item>
          <el-descriptions-item label="选课人数">{{ currentCourse.selectedNum }} / {{ currentCourse.maxStudents }}</el-descriptions-item>
          <el-descriptions-item label="课程状态">
            <el-tag :type="currentCourse.status === '0' ? 'success' : 'info'" size="small">
              {{ currentCourse.status === '0' ? '进行中' : '已结课' }}
            </el-tag>
          </el-descriptions-item>
        </el-descriptions>
      </div>
      <span slot="footer">
        <el-button @click="dialogVisible = false">关闭</el-button>
        <el-button type="primary" @click="goToStudentList(currentCourse)">查看学生名单</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import { listTermOptions } from "@/api/education/term";
import { listMyCourseAsTeacher } from "@/api/education/opening";

export default {
  name: "TeacherSchedule",
  data() {
    return {
      termId: null,
      termList: [],
      courseList: [],
      scheduleMap: {},
      dialogVisible: false,
      currentCourse: null,
      weekDays: [
        { key: "周一", label: "星期一" },
        { key: "周二", label: "星期二" },
        { key: "周三", label: "星期三" },
        { key: "周四", label: "星期四" },
        { key: "周五", label: "星期五" },
        { key: "周六", label: "星期六" },
        { key: "周日", label: "星期日" }
      ],
      periods: [
        { key: "1-2", num: 1, time: "08:00-09:40" },
        { key: "1-2", num: 2, time: "08:00-09:40" },
        { key: "3-4", num: 3, time: "10:00-11:40" },
        { key: "3-4", num: 4, time: "10:00-11:40" },
        { key: "5-6", num: 5, time: "14:00-15:40" },
        { key: "5-6", num: 6, time: "14:00-15:40" },
        { key: "7-8", num: 7, time: "16:00-17:40" },
        { key: "7-8", num: 8, time: "16:00-17:40" },
        { key: "9-10", num: 9, time: "19:00-20:40" },
        { key: "9-10", num: 10, time: "19:00-20:40" }
      ],
      colors: [
        "#409EFF", "#67C23A", "#E6A23C", "#F56C6C", "#909399",
        "#00CED1", "#FF6B6B", "#4ECDC4", "#45B7D1", "#96CEB4"
      ]
    };
  },
  created() {
    this.loadTermList();
  },
  methods: {
    loadTermList() {
      listTermOptions().then(response => {
        console.log('教师-学期列表响应:', response);
        this.termList = response.data || [];
        if (this.termList.length > 0) {
          this.termId = this.termList[0].termId;
          console.log('教师-选择学期:', this.termId);
          this.loadSchedule();
        }
      }).catch(error => {
        console.error('教师-获取学期列表失败:', error);
      });
    },
    loadSchedule() {
      if (!this.termId) return;
      console.log('教师-加载课表, termId:', this.termId);
      listMyCourseAsTeacher({ termId: this.termId }).then(response => {
        console.log('教师-我的课程响应:', response);
        const courses = response.rows || [];
        console.log('教师-课程数量:', courses.length);
        courses.forEach((course, index) => {
          course.color = this.colors[index % this.colors.length];
        });
        this.courseList = courses;
        this.parseSchedule();
      });
    },
    parseSchedule() {
      this.scheduleMap = {};
      this.courseList.forEach(course => {
        if (!course.classTime) return;
        const slots = this.parseTimeSlots(course.classTime);
        slots.forEach(slot => {
          const key = slot.day + "-" + slot.period;
          this.scheduleMap[key] = course;
        });
      });
    },
    parseTimeSlots(classTime) {
      const slots = [];
      const parts = classTime.split(/[,，]/);
      parts.forEach(part => {
        part = part.trim();
        const match = part.match(/^(周[一二三四五六日])(\d+)-(\d+)节?$/);
        if (match) {
          const day = match[1];
          const start = parseInt(match[2]);
          const end = parseInt(match[3]);
          for (let i = start; i <= end; i++) {
            slots.push({ day, period: i });
          }
        }
      });
      return slots;
    },
    getCourse(day, period) {
      const key = day + "-" + period;
      return this.scheduleMap[key] || null;
    },
    showCourseDetail(course) {
      this.currentCourse = course;
      this.dialogVisible = true;
    },
    goToStudentList(course) {
      this.dialogVisible = false;
      this.$router.push({ path: "/education/teacher/course", query: { openId: course.openId } });
    }
  }
};
</script>

<style scoped>
.schedule-container {
  padding: 15px;
}

.header-card {
  margin-bottom: 15px;
}

.schedule-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
}

.header-left {
  display: flex;
  align-items: center;
}

.header-center h2 {
  margin: 0;
  color: #303133;
}

.header-right {
  display: flex;
  gap: 10px;
}

.schedule-table-wrapper {
  overflow-x: auto;
  margin-bottom: 20px;
  border-radius: 8px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}

.schedule-table {
  width: 100%;
  min-width: 1000px;
  border-collapse: collapse;
  table-layout: fixed;
  background: #fff;
}

.schedule-table th,
.schedule-table td {
  border: 1px solid #EBEEF5;
  padding: 0;
  text-align: center;
  vertical-align: top;
}

.schedule-table th {
  background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
  color: #fff;
  padding: 12px 8px;
  font-weight: 500;
  font-size: 14px;
}

.time-col {
  width: 100px;
  min-width: 100px;
}

.day-col {
  min-width: 130px;
}

.time-cell {
  background: linear-gradient(180deg, #f5f7fa 0%, #e4e7ed 100%);
  padding: 8px 5px !important;
}

.period-num {
  font-weight: bold;
  color: #303133;
  font-size: 13px;
}

.period-time {
  font-size: 11px;
  color: #909399;
  margin-top: 3px;
}

.period-divider td {
  border-bottom: 2px solid #409EFF !important;
}

.course-cell {
  height: 90px;
  padding: 4px !important;
  vertical-align: middle !important;
  background: #fff;
}

.course-card {
  height: 100%;
  min-height: 80px;
  border-radius: 6px;
  padding: 6px 8px;
  color: #fff;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
  transition: all 0.2s ease;
  cursor: pointer;
  overflow: hidden;
}

.course-card:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
}

.course-name {
  font-weight: bold;
  font-size: 13px;
  line-height: 1.3;
  max-height: 34px;
  overflow: hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
}

.course-info {
  font-size: 10px;
  opacity: 0.85;
}

.course-code {
  background: rgba(255,255,255,0.2);
  padding: 1px 4px;
  border-radius: 3px;
}

.course-location {
  font-size: 11px;
  opacity: 0.9;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.course-students {
  font-size: 11px;
  opacity: 0.9;
}

.course-summary {
  margin-top: 20px;
}

.course-summary .el-card__header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.summary-count {
  color: #67C23A;
  font-weight: bold;
}

.progress-text {
  font-size: 12px;
  color: #606266;
}

.course-detail {
  padding: 10px 0;
}

/* 响应式调整 */
@media screen and (max-width: 1200px) {
  .day-col {
    min-width: 110px;
  }
  .course-cell {
    height: 85px;
  }
  .course-name {
    font-size: 12px;
  }
}
</style>
