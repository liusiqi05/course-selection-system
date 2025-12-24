<template>
  <div class="app-container">
    <!-- 课程信息 -->
    <el-card class="box-card mb20" shadow="hover">
      <div slot="header" class="clearfix">
        <span><i class="el-icon-reading"></i> 课程信息</span>
        <el-button style="float: right; padding: 3px 0" type="text" @click="goBack">
          <i class="el-icon-back"></i> 返回我的课程
        </el-button>
      </div>
      <el-descriptions :column="4" border>
        <el-descriptions-item label="课程名称">{{ courseName }}</el-descriptions-item>
        <el-descriptions-item label="选课人数">{{ total }} 人</el-descriptions-item>
      </el-descriptions>
    </el-card>

    <!-- 搜索表单 -->
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="学号" prop="studentNo">
        <el-input
          v-model="queryParams.studentNo"
          placeholder="请输入学号"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="姓名" prop="studentName">
        <el-input
          v-model="queryParams.studentName"
          placeholder="请输入学生姓名"
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
        >导出名单</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="studentList">
      <el-table-column label="序号" type="index" width="60" align="center" />
      <el-table-column label="学号" align="center" prop="studentNo" width="150" />
      <el-table-column label="姓名" align="center" prop="studentName" width="120" />
      <el-table-column label="选课时间" align="center" prop="enrollTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.enrollTime, '{y}-{m}-{d} {h}:{i}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="成绩" align="center" prop="score" width="100">
        <template slot-scope="scope">
          <span v-if="scope.row.score !== null">{{ scope.row.score }}</span>
          <el-tag v-else type="info" size="mini">未录入</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="状态" align="center" prop="status" width="100">
        <template slot-scope="scope">
          <el-tag :type="scope.row.status === '0' ? 'success' : 'danger'">
            {{ scope.row.status === '0' ? '正常' : '已退课' }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="120">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleInputScore(scope.row)"
            v-if="scope.row.status === '0'"
          >录入成绩</el-button>
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

    <!-- 录入成绩对话框 -->
    <el-dialog title="录入成绩" :visible.sync="open" width="400px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="学号">
          <el-input v-model="form.studentNo" disabled />
        </el-form-item>
        <el-form-item label="姓名">
          <el-input v-model="form.studentName" disabled />
        </el-form-item>
        <el-form-item label="成绩" prop="score">
          <el-input-number v-model="form.score" :min="0" :max="100" :precision="1" controls-position="right" style="width: 100%;" />
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
import request from '@/utils/request';

export default {
  name: "TeacherStudent",
  data() {
    return {
      // 遮罩层
      loading: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 学生列表
      studentList: [],
      // 开课ID
      openId: null,
      // 课程名称
      courseName: '',
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        studentNo: null,
        studentName: null
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        score: [
          { required: true, message: "成绩不能为空", trigger: "blur" }
        ]
      }
    };
  },
  created() {
    this.openId = this.$route.query.openId;
    this.courseName = this.$route.query.courseName || '未知课程';
    if (this.openId) {
      this.getList();
    }
  },
  methods: {
    /** 查询学生列表 */
    getList() {
      this.loading = true;
      this.$axios({
        url: `/education/selection/myStudents/${this.openId}`,
        method: 'get',
        params: this.queryParams
      }).then(response => {
        this.studentList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        scId: null,
        studentNo: null,
        studentName: null,
        score: null
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
    /** 返回我的课程 */
    goBack() {
      this.$router.push('/education/teacherCourse');
    },
    /** 录入成绩按钮操作 */
    handleInputScore(row) {
      this.reset();
      this.form = {
        scId: row.scId,
        studentNo: row.studentNo,
        studentName: row.studentName,
        score: row.score
      };
      this.open = true;
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          this.$axios({
            url: '/education/selection/inputScore',
            method: 'put',
            data: {
              scId: this.form.scId,
              score: this.form.score
            }
          }).then(response => {
            this.$modal.msgSuccess("成绩录入成功");
            this.open = false;
            this.getList();
          });
        }
      });
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('education/selection/export', {
        openId: this.openId
      }, `${this.courseName}_学生名单_${new Date().getTime()}.xlsx`)
    }
  }
};
</script>

<style scoped>
.mb20 {
  margin-bottom: 20px;
}
</style>
