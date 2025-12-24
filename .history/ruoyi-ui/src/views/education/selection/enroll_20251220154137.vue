<template>
  <div class="app-container">
    <!-- 当前学期信息 -->
    <el-alert
      v-if="currentTerm"
      :title="'当前选课学期：' + currentTerm.termName"
      type="info"
      :closable="false"
      show-icon
      style="margin-bottom: 15px;"
    >
      <template slot="title">
        <span style="font-size: 16px; font-weight: bold;">
          <i class="el-icon-date"></i> 当前选课学期：{{ currentTerm.termName }}
        </span>
      </template>
    </el-alert>
    <el-alert
      v-else
      title="暂无可选课学期"
      type="warning"
      :closable="false"
      show-icon
      style="margin-bottom: 15px;"
      description="当前没有开放选课的学期，请联系教务处。"
    />

    <!-- 可选课程列表 -->
    <el-card class="box-card" shadow="hover">
      <div slot="header" class="clearfix">
        <span><i class="el-icon-reading"></i> 可选课程列表</span>
        <el-button style="float: right;" type="text" @click="refreshList">
          <i class="el-icon-refresh"></i> 刷新
        </el-button>
      </div>
      
      <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" label-width="68px">
        <el-form-item label="课程名称" prop="courseName">
          <el-input
            v-model="queryParams.courseName"
            placeholder="请输入课程名称"
            clearable
            @keyup.enter.native="handleQuery"
          />
        </el-form-item>
        <el-form-item label="授课教师" prop="teacherName">
          <el-input
            v-model="queryParams.teacherName"
            placeholder="请输入教师姓名"
            clearable
            @keyup.enter.native="handleQuery"
          />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
          <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
        </el-form-item>
      </el-form>

      <el-table v-loading="loading" :data="courseList">
        <el-table-column label="课程名称" align="center" prop="courseName" width="150" />
        <el-table-column label="课程代码" align="center" prop="courseCode" width="100" />
        <el-table-column label="学分" align="center" prop="credit" width="60" />
        <el-table-column label="授课教师" align="center" prop="teacherName" width="100" />
        <el-table-column label="上课时间" align="center" prop="classTime" width="130" />
        <el-table-column label="上课地点" align="center" prop="classLocation" width="120" />
        <el-table-column label="选课人数" align="center" width="100">
          <template slot-scope="scope">
            <el-progress 
              :percentage="getPercentage(scope.row.selectedNum, scope.row.maxStudents)" 
              :color="getProgressColor(scope.row.selectedNum, scope.row.maxStudents)"
              :format="() => scope.row.selectedNum + '/' + scope.row.maxStudents"
            />
          </template>
        </el-table-column>
        <el-table-column label="操作" align="center" width="120">
          <template slot-scope="scope">
            <el-button
              v-if="!isSelected(scope.row.openId)"
              size="mini"
              type="primary"
              :disabled="scope.row.selectedNum >= scope.row.maxStudents"
              @click="handleEnroll(scope.row)"
            >
              {{ scope.row.selectedNum >= scope.row.maxStudents ? '已满' : '选课' }}
            </el-button>
            <el-tag v-else type="success">已选</el-tag>
          </template>
        </el-table-column>
      </el-table>
      
      <pagination
        v-show="total>0"
        :total="total"
        :page.sync="queryParams.pageNum"
        :limit.sync="queryParams.pageSize"
        @pagination="getList"
      />
    </el-card>

    <!-- 我的课程 -->
    <el-card class="box-card mt20" shadow="hover">
      <div slot="header" class="clearfix">
        <span><i class="el-icon-notebook-2"></i> 我的课程</span>
        <el-tag type="info" style="float: right;">已选 {{ myCourseList.length }} 门课程</el-tag>
      </div>
      
      <el-table v-loading="myLoading" :data="myCourseList" empty-text="暂无已选课程">
        <el-table-column label="课程名称" align="center" prop="courseName" width="150" />
        <el-table-column label="课程代码" align="center" prop="courseCode" width="100" />
        <el-table-column label="学分" align="center" prop="credit" width="60" />
        <el-table-column label="授课教师" align="center" prop="teacherName" width="100" />
        <el-table-column label="上课时间" align="center" prop="classTime" width="130" />
        <el-table-column label="上课地点" align="center" prop="classLocation" width="120" />
        <el-table-column label="选课时间" align="center" prop="enrollTime" width="180" />
        <el-table-column label="成绩" align="center" prop="score" width="80">
          <template slot-scope="scope">
            <span :class="getScoreClass(scope.row.score)">
              {{ scope.row.score != null ? scope.row.score : '未公布' }}
            </span>
          </template>
        </el-table-column>
        <el-table-column label="操作" align="center" width="100">
          <template slot-scope="scope">
            <el-button
              v-if="scope.row.score == null"
              size="mini"
              type="danger"
              @click="handleWithdraw(scope.row)"
            >退课</el-button>
            <span v-else class="text-muted">已结课</span>
          </template>
        </el-table-column>
      </el-table>
    </el-card>
  </div>
</template>

<script>
import { listAvailable } from "@/api/education/opening";
import { listMyCourses, enrollCourse, withdrawCourse } from "@/api/education/selection";

export default {
  name: "CourseEnroll",
  data() {
    return {
      // 遮罩层
      loading: true,
      myLoading: true,
      // 总条数
      total: 0,
      // 可选课程列表
      courseList: [],
      // 我的课程列表
      myCourseList: [],
      // 已选课程ID集合
      selectedOpenIds: [],
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        courseName: null,
        teacherName: null
      }
    };
  },
  created() {
    this.getList();
    this.getMyCourses();
  },
  methods: {
    /** 查询可选课程列表 */
    getList() {
      this.loading = true;
      listAvailable(this.queryParams).then(response => {
        this.courseList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    /** 查询我的课程 */
    getMyCourses() {
      this.myLoading = true;
      listMyCourses().then(response => {
        this.myCourseList = response.rows || [];
        this.selectedOpenIds = this.myCourseList.map(item => item.openId);
        this.myLoading = false;
      });
    },
    /** 刷新列表 */
    refreshList() {
      this.getList();
      this.getMyCourses();
    },
    /** 判断是否已选 */
    isSelected(openId) {
      return this.selectedOpenIds.includes(openId);
    },
    /** 计算百分比 */
    getPercentage(selected, max) {
      return Math.round((selected / max) * 100);
    },
    /** 获取进度条颜色 */
    getProgressColor(selected, max) {
      const percentage = (selected / max) * 100;
      if (percentage >= 90) return '#F56C6C';
      if (percentage >= 70) return '#E6A23C';
      return '#67C23A';
    },
    /** 获取成绩样式 */
    getScoreClass(score) {
      if (score == null) return 'text-muted';
      if (score >= 90) return 'score-excellent';
      if (score >= 60) return 'score-pass';
      return 'score-fail';
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm");
      this.handleQuery();
    },
    /** 选课 */
    handleEnroll(row) {
      this.$modal.confirm('确定要选择课程"' + row.courseName + '"吗？').then(() => {
        return enrollCourse(row.openId);
      }).then(response => {
        if (response.code === 200) {
          this.$modal.msgSuccess(response.msg || "选课成功");
          this.refreshList();
        } else {
          this.$modal.msgError(response.msg);
        }
      }).catch(() => {});
    },
    /** 退课 */
    handleWithdraw(row) {
      this.$modal.confirm('确定要退选课程"' + row.courseName + '"吗？退课后需要重新选课。').then(() => {
        return withdrawCourse(row.openId);
      }).then(response => {
        if (response.code === 200) {
          this.$modal.msgSuccess(response.msg || "退课成功");
          this.refreshList();
        } else {
          this.$modal.msgError(response.msg);
        }
      }).catch(() => {});
    }
  }
};
</script>

<style scoped>
.mt20 {
  margin-top: 20px;
}
.text-muted {
  color: #909399;
}
.score-excellent {
  color: #67C23A;
  font-weight: bold;
}
.score-pass {
  color: #409EFF;
}
.score-fail {
  color: #F56C6C;
  font-weight: bold;
}
</style>
