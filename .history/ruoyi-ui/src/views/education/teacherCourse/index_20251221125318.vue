<template>
  <div class="app-container">
    <!-- 待打分提醒 -->
    <el-alert
      v-if="pendingScoreCourses.length > 0"
      title="成绩录入提醒"
      type="warning"
      :closable="false"
      show-icon
      class="mb20"
    >
      <template slot="default">
        <span>您有 <b>{{ pendingScoreCourses.length }}</b> 门课程需要录入学生成绩：</span>
        <el-tag
          v-for="course in pendingScoreCourses"
          :key="course.openId"
          type="danger"
          size="small"
          style="margin-left: 8px; cursor: pointer;"
          @click="handleViewStudents(course)"
        >
          {{ course.courseName }}（{{ course.termName }}）
        </el-tag>
      </template>
    </el-alert>

    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="学期" prop="termId">
        <el-select v-model="queryParams.termId" placeholder="请选择学期" clearable>
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
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

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

    <el-table v-loading="loading" :data="courseList">
      <el-table-column label="学期" align="center" prop="termName" width="180" />
      <el-table-column label="课程代码" align="center" prop="courseCode" width="120" />
      <el-table-column label="课程名称" align="center" prop="courseName" min-width="150" />
      <el-table-column label="学分" align="center" prop="credit" width="80" />
      <el-table-column label="上课时间" align="center" prop="classTime" width="150" />
      <el-table-column label="上课地点" align="center" prop="classLocation" width="120" />
      <el-table-column label="容量" align="center" prop="maxStudents" width="80" />
      <el-table-column label="已选" align="center" prop="selectedNum" width="80">
        <template slot-scope="scope">
          <el-tag :type="scope.row.selectedNum >= scope.row.maxStudents ? 'danger' : 'success'">
            {{ scope.row.selectedNum }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="状态" align="center" prop="status" width="100">
        <template slot-scope="scope">
          <el-tag :type="statusType(scope.row.status)">{{ statusText(scope.row.status) }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="200">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-user"
            @click="handleViewStudents(scope.row)"
          >学生名单</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
          >修改</el-button>
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

    <!-- 修改开课信息对话框 -->
    <el-dialog title="修改课程信息" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="课程名称">
          <el-input v-model="form.courseName" disabled />
        </el-form-item>
        <el-form-item label="上课时间" prop="classTime">
          <el-input v-model="form.classTime" placeholder="请输入上课时间，如：周一1-2节" />
        </el-form-item>
        <el-form-item label="上课地点" prop="classLocation">
          <el-input v-model="form.classLocation" placeholder="请输入上课地点" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listTerm } from "@/api/education/term";
import request from '@/utils/request';

export default {
  name: "TeacherCourse",
  data() {
    return {
      // 遮罩层
      loading: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 课程列表
      courseList: [],
      // 学期列表
      termList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        termId: null,
        courseName: null
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        classTime: [
          { required: true, message: "上课时间不能为空", trigger: "blur" }
        ],
        classLocation: [
          { required: true, message: "上课地点不能为空", trigger: "blur" }
        ]
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
      listTerm().then(response => {
        this.termList = response.rows;
      });
    },
    /** 查询我的课程列表 */
    getList() {
      this.loading = true;
      request({
        url: '/education/opening/myCourses',
        method: 'get',
        params: this.queryParams
      }).then(response => {
        this.courseList = response.rows;
        this.total = response.total;
        this.loading = false;
      }).catch(() => {
        this.loading = false;
      });
    },
    /** 状态显示 */
    statusType(status) {
      const types = { '0': 'success', '1': 'primary', '2': 'info' };
      return types[status] || 'info';
    },
    statusText(status) {
      const texts = { '0': '报名中', '1': '已开课', '2': '已结课' };
      return texts[status] || '未知';
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        openId: null,
        courseName: null,
        classTime: null,
        classLocation: null
      };
      this.resetForm("form");
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
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      this.form = {
        openId: row.openId,
        courseName: row.courseName,
        classTime: row.classTime,
        classLocation: row.classLocation
      };
      this.open = true;
    },
    /** 查看学生名单 */
    handleViewStudents(row) {
      this.$router.push({
        path: '/education/teacherStudent',
        query: { openId: row.openId, courseName: row.courseName }
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          request({
            url: '/education/opening/updateMyCourse',
            method: 'put',
            data: this.form
          }).then(response => {
            this.$modal.msgSuccess("修改成功");
            this.open = false;
            this.getList();
          });
        }
      });
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('education/opening/export', {
        ...this.queryParams
      }, `我的课程_${new Date().getTime()}.xlsx`)
    }
  }
};
</script>
