<template>
  <div class="app-container">
    <!-- 页面提示 -->
    <el-alert
      title="开课申请说明"
      type="info"
      :closable="false"
      show-icon
      class="mb20"
    >
      <template slot="default">
        <span>请填写开课信息并提交申请，管理员审批通过后，课程将在相应学期开放选课。</span>
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
          <el-option label="待审批" value="0" />
          <el-option label="已通过" value="1" />
          <el-option label="已拒绝" value="2" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
        >新增申请</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <!-- 申请列表 -->
    <el-table v-loading="loading" :data="applyList">
      <el-table-column label="学期" align="center" prop="termName" width="160" />
      <el-table-column label="课程代码" align="center" prop="courseCode" width="120" />
      <el-table-column label="课程名称" align="center" prop="courseName" min-width="150" />
      <el-table-column label="学分" align="center" prop="credit" width="70" />
      <el-table-column label="课程类型" align="center" prop="courseType" width="100">
        <template slot-scope="scope">
          <span>{{ getCourseTypeLabel(scope.row.courseType) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="上课时间" align="center" prop="classTime" width="140" />
      <el-table-column label="上课地点" align="center" prop="classLocation" width="100" />
      <el-table-column label="课程容量" align="center" prop="maxStudents" width="90" />
      <el-table-column label="审批状态" align="center" width="100">
        <template slot-scope="scope">
          <el-tag :type="getStatusType(scope.row.status)" size="small">
            {{ getStatusLabel(scope.row.status) }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="申请时间" align="center" prop="createTime" width="160" />
      <el-table-column label="审批信息" align="center" min-width="150">
        <template slot-scope="scope">
          <template v-if="scope.row.status === '1'">
            <span class="text-success">{{ scope.row.approveBy }} 于 {{ scope.row.approveTime }} 通过</span>
          </template>
          <template v-else-if="scope.row.status === '2'">
            <el-popover trigger="hover" placement="top" v-if="scope.row.rejectReason">
              <p>拒绝原因: {{ scope.row.rejectReason }}</p>
              <span slot="reference" class="text-danger" style="cursor: pointer;">
                {{ scope.row.approveBy }} 拒绝 <i class="el-icon-info"></i>
              </span>
            </el-popover>
            <span v-else class="text-danger">{{ scope.row.approveBy }} 拒绝</span>
          </template>
          <template v-else>
            <span class="text-muted">等待审批中...</span>
          </template>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="150" fixed="right">
        <template slot-scope="scope">
          <template v-if="scope.row.status === '0'">
            <el-button size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)">
              修改
            </el-button>
            <el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)">
              撤销
            </el-button>
          </template>
          <template v-else>
            <el-button size="mini" type="text" icon="el-icon-view" @click="handleView(scope.row)">
              查看
            </el-button>
          </template>
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

    <!-- 新增/修改对话框 -->
    <el-dialog :title="dialogTitle" :visible.sync="dialogVisible" width="700px" append-to-body>
      <el-form ref="applyForm" :model="form" :rules="rules" label-width="100px">
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="申请学期" prop="termId">
              <el-select v-model="form.termId" placeholder="请选择学期" style="width: 100%;">
                <el-option
                  v-for="term in availableTermList"
                  :key="term.termId"
                  :label="term.termName"
                  :value="term.termId"
                />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="课程来源">
              <el-radio-group v-model="courseSource" @change="handleCourseSourceChange">
                <el-radio label="existing">已有课程</el-radio>
                <el-radio label="new">新课程</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>
        </el-row>

        <!-- 选择已有课程 -->
        <el-form-item label="选择课程" prop="courseId" v-if="courseSource === 'existing'">
          <el-select 
            v-model="form.courseId" 
            placeholder="请选择课程" 
            filterable 
            style="width: 100%;"
            @change="handleCourseSelect"
          >
            <el-option
              v-for="course in courseList"
              :key="course.courseId"
              :label="course.courseCode + ' - ' + course.courseName"
              :value="course.courseId"
            >
              <span style="float: left">{{ course.courseCode }}</span>
              <span style="float: right; color: #8492a6; font-size: 13px">{{ course.courseName }} ({{ course.credit }}学分)</span>
            </el-option>
          </el-select>
        </el-form-item>

        <!-- 新课程信息 -->
        <template v-if="courseSource === 'new'">
          <el-row :gutter="20">
            <el-col :span="12">
              <el-form-item label="课程代码" prop="courseCode">
                <el-input v-model="form.courseCode" placeholder="请输入课程代码" />
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="课程名称" prop="courseName">
                <el-input v-model="form.courseName" placeholder="请输入课程名称" />
              </el-form-item>
            </el-col>
          </el-row>
          <el-row :gutter="20">
            <el-col :span="12">
              <el-form-item label="学分" prop="credit">
                <el-input-number v-model="form.credit" :min="0.5" :max="10" :step="0.5" :precision="1" style="width: 100%;" />
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="课程类型" prop="courseType">
                <el-select v-model="form.courseType" placeholder="请选择课程类型" style="width: 100%;">
                  <el-option label="必修课" value="必修" />
                  <el-option label="选修课" value="选修" />
                  <el-option label="公共课" value="公共" />
                  <el-option label="实践课" value="实践" />
                </el-select>
              </el-form-item>
            </el-col>
          </el-row>
        </template>

        <!-- 显示已选课程信息 -->
        <el-descriptions v-if="courseSource === 'existing' && selectedCourse" :column="3" border size="small" class="mb20">
          <el-descriptions-item label="课程代码">{{ selectedCourse.courseCode }}</el-descriptions-item>
          <el-descriptions-item label="课程名称">{{ selectedCourse.courseName }}</el-descriptions-item>
          <el-descriptions-item label="学分">{{ selectedCourse.credit }}</el-descriptions-item>
        </el-descriptions>

        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="上课时间" prop="classTime">
              <el-input v-model="form.classTime" placeholder="如：周一3-4节" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="上课地点" prop="classLocation">
              <el-input v-model="form.classLocation" placeholder="如：教学楼A301" />
            </el-form-item>
          </el-col>
        </el-row>

        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="课程容量" prop="maxStudents">
              <el-input-number v-model="form.maxStudents" :min="10" :max="500" style="width: 100%;" />
            </el-form-item>
          </el-col>
        </el-row>

        <el-form-item label="课程简介" prop="description">
          <el-input 
            type="textarea" 
            v-model="form.description" 
            placeholder="请输入课程简介或申请理由（选填）" 
            :rows="4"
          />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="submitForm" :loading="submitLoading">提 交</el-button>
      </div>
    </el-dialog>

    <!-- 查看详情对话框 -->
    <el-dialog title="申请详情" :visible.sync="viewDialogVisible" width="600px" append-to-body>
      <el-descriptions :column="2" border v-if="currentApply">
        <el-descriptions-item label="学期">{{ currentApply.termName }}</el-descriptions-item>
        <el-descriptions-item label="审批状态">
          <el-tag :type="getStatusType(currentApply.status)">{{ getStatusLabel(currentApply.status) }}</el-tag>
        </el-descriptions-item>
        <el-descriptions-item label="课程代码">{{ currentApply.courseCode }}</el-descriptions-item>
        <el-descriptions-item label="课程名称">{{ currentApply.courseName }}</el-descriptions-item>
        <el-descriptions-item label="学分">{{ currentApply.credit }}</el-descriptions-item>
        <el-descriptions-item label="课程类型">{{ getCourseTypeLabel(currentApply.courseType) }}</el-descriptions-item>
        <el-descriptions-item label="上课时间">{{ currentApply.classTime }}</el-descriptions-item>
        <el-descriptions-item label="上课地点">{{ currentApply.classLocation }}</el-descriptions-item>
        <el-descriptions-item label="课程容量">{{ currentApply.maxStudents }}人</el-descriptions-item>
        <el-descriptions-item label="申请时间">{{ currentApply.createTime }}</el-descriptions-item>
        <el-descriptions-item label="课程简介" :span="2">{{ currentApply.description || '无' }}</el-descriptions-item>
        <template v-if="currentApply.status !== '0'">
          <el-descriptions-item label="审批人">{{ currentApply.approveBy }}</el-descriptions-item>
          <el-descriptions-item label="审批时间">{{ currentApply.approveTime }}</el-descriptions-item>
          <el-descriptions-item label="拒绝原因" :span="2" v-if="currentApply.status === '2'">
            <span class="text-danger">{{ currentApply.rejectReason || '无' }}</span>
          </el-descriptions-item>
        </template>
      </el-descriptions>
      <div slot="footer" class="dialog-footer">
        <el-button @click="viewDialogVisible = false">关 闭</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listMyApply, getApply, addApply, updateApply, delApply } from "@/api/education/courseApply";
import { listTermOptions } from "@/api/education/term";
import { listCourseAll } from "@/api/education/course";

export default {
  name: "CourseApply",
  data() {
    return {
      // 遮罩层
      loading: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 申请列表
      applyList: [],
      // 学期列表
      termList: [],
      // 可申请学期列表（排除已过期学期）
      availableTermList: [],
      // 课程列表
      courseList: [],
      // 选中的课程
      selectedCourse: null,
      // 课程来源
      courseSource: 'existing',
      // 对话框标题
      dialogTitle: '',
      // 对话框是否显示
      dialogVisible: false,
      // 查看对话框
      viewDialogVisible: false,
      // 当前查看的申请
      currentApply: null,
      // 提交loading
      submitLoading: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        termId: null,
        courseName: null,
        status: null
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        termId: [
          { required: true, message: "请选择学期", trigger: "change" }
        ],
        courseId: [
          { required: true, message: "请选择课程", trigger: "change" }
        ],
        courseCode: [
          { required: true, message: "请输入课程代码", trigger: "blur" }
        ],
        courseName: [
          { required: true, message: "请输入课程名称", trigger: "blur" }
        ],
        credit: [
          { required: true, message: "请输入学分", trigger: "blur" }
        ],
        classTime: [
          { required: true, message: "请输入上课时间", trigger: "blur" }
        ],
        classLocation: [
          { required: true, message: "请输入上课地点", trigger: "blur" }
        ],
        maxStudents: [
          { required: true, message: "请输入课程容量", trigger: "blur" }
        ]
      }
    };
  },
  created() {
    this.getTermList();
    this.getCourseList();
    this.getList();
  },
  methods: {
    /** 查询学期列表 */
    getTermList() {
      listTermOptions().then(response => {
        this.termList = response.data || [];
        // 所有正常状态的学期都可以申请
        this.availableTermList = this.termList;
      });
    },
    /** 查询课程列表 */
    getCourseList() {
      listCourseAll().then(response => {
        this.courseList = response.data || [];
      });
    },
    /** 查询申请列表 */
    getList() {
      this.loading = true;
      listMyApply(this.queryParams).then(response => {
        this.applyList = response.rows || [];
        this.total = response.total || 0;
        this.loading = false;
      });
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
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.dialogTitle = "新增开课申请";
      this.dialogVisible = true;
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      getApply(row.applyId).then(response => {
        this.form = response.data;
        if (this.form.courseId) {
          this.courseSource = 'existing';
          this.selectedCourse = this.courseList.find(c => c.courseId === this.form.courseId);
        } else {
          this.courseSource = 'new';
        }
        this.dialogTitle = "修改开课申请";
        this.dialogVisible = true;
      });
    },
    /** 查看详情 */
    handleView(row) {
      this.currentApply = row;
      this.viewDialogVisible = true;
    },
    /** 表单重置 */
    reset() {
      this.form = {
        applyId: null,
        termId: null,
        courseId: null,
        courseCode: null,
        courseName: null,
        credit: 2.0,
        courseType: '选修',
        classTime: null,
        classLocation: null,
        maxStudents: 50,
        description: null
      };
      this.selectedCourse = null;
      this.courseSource = 'existing';
      this.resetForm("applyForm");
    },
    /** 课程来源切换 */
    handleCourseSourceChange(val) {
      if (val === 'existing') {
        this.form.courseCode = null;
        this.form.courseName = null;
        this.form.credit = null;
        this.form.courseType = null;
      } else {
        this.form.courseId = null;
        this.selectedCourse = null;
        this.form.credit = 2.0;
        this.form.courseType = '选修';
      }
    },
    /** 选择课程 */
    handleCourseSelect(courseId) {
      this.selectedCourse = this.courseList.find(c => c.courseId === courseId);
      if (this.selectedCourse) {
        this.form.courseCode = this.selectedCourse.courseCode;
        this.form.courseName = this.selectedCourse.courseName;
        this.form.credit = this.selectedCourse.credit;
        this.form.courseType = this.selectedCourse.courseType;
      }
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["applyForm"].validate(valid => {
        if (valid) {
          this.submitLoading = true;
          if (this.form.applyId != null) {
            updateApply(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.dialogVisible = false;
              this.getList();
            }).finally(() => {
              this.submitLoading = false;
            });
          } else {
            addApply(this.form).then(response => {
              this.$modal.msgSuccess("申请提交成功，请等待管理员审批");
              this.dialogVisible = false;
              this.getList();
            }).finally(() => {
              this.submitLoading = false;
            });
          }
        }
      });
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      this.$modal.confirm('确认撤销该申请吗？').then(() => {
        return delApply(row.applyId);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("撤销成功");
      }).catch(() => {});
    },
    /** 获取状态标签 */
    getStatusLabel(status) {
      const map = { '0': '待审批', '1': '已通过', '2': '已拒绝' };
      return map[status] || '未知';
    },
    /** 获取状态类型 */
    getStatusType(status) {
      const map = { '0': 'warning', '1': 'success', '2': 'danger' };
      return map[status] || 'info';
    },
    /** 获取课程类型标签 */
    getCourseTypeLabel(type) {
      return type || '未设置';
    }
  }
};
</script>

<style scoped>
.mb20 {
  margin-bottom: 20px;
}
.text-success {
  color: #67c23a;
}
.text-danger {
  color: #f56c6c;
}
.text-muted {
  color: #909399;
}
</style>
