<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="学期" prop="termId">
        <el-select v-model="queryParams.termId" placeholder="请选择学期" clearable>
          <el-option
            v-for="item in termList"
            :key="item.termId"
            :label="item.termName"
            :value="item.termId"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="课程" prop="courseId">
        <el-select v-model="queryParams.courseId" placeholder="请选择课程" clearable filterable>
          <el-option
            v-for="item in courseList"
            :key="item.courseId"
            :label="item.courseName"
            :value="item.courseId"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="教师" prop="teacherId">
        <el-select v-model="queryParams.teacherId" placeholder="请选择教师" clearable filterable>
          <el-option
            v-for="item in teacherList"
            :key="item.teacherId"
            :label="item.nickName"
            :value="item.teacherId"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择状态" clearable>
          <el-option label="正常" value="0" />
          <el-option label="停用" value="1" />
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
          v-hasPermi="['education:opening:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['education:opening:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['education:opening:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['education:opening:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="openingList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="开课ID" align="center" prop="openId" width="80" />
      <el-table-column label="学期" align="center" prop="termName" width="180" />
      <el-table-column label="课程名称" align="center" prop="courseName" width="150" />
      <el-table-column label="课程代码" align="center" prop="courseCode" width="100" />
      <el-table-column label="授课教师" align="center" prop="teacherName" width="100" />
      <el-table-column label="上课时间" align="center" prop="classTime" width="150" />
      <el-table-column label="上课地点" align="center" prop="classLocation" width="120" />
      <el-table-column label="容量" align="center" width="100">
        <template slot-scope="scope">
          <span :class="{'text-danger': scope.row.selectedNum >= scope.row.maxStudents}">
            {{ scope.row.selectedNum }} / {{ scope.row.maxStudents }}
          </span>
        </template>
      </el-table-column>
      <el-table-column label="状态" align="center" prop="status" width="80">
        <template slot-scope="scope">
          <el-tag :type="scope.row.status === '0' ? 'success' : 'danger'">
            {{ scope.row.status === '0' ? '可选' : '停用' }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="180">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-view"
            @click="handleViewStudents(scope.row)"
          >查看选课</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['education:opening:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['education:opening:remove']"
          >删除</el-button>
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

    <!-- 添加或修改开课安排对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="600px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-row>
          <el-col :span="12">
            <el-form-item label="学期" prop="termId">
              <el-select v-model="form.termId" placeholder="请选择学期" style="width: 100%">
                <el-option
                  v-for="item in termList"
                  :key="item.termId"
                  :label="item.termName"
                  :value="item.termId"
                />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="课程" prop="courseId">
              <el-select v-model="form.courseId" placeholder="请选择课程" filterable style="width: 100%">
                <el-option
                  v-for="item in courseList"
                  :key="item.courseId"
                  :label="item.courseName + ' (' + item.courseCode + ')'"
                  :value="item.courseId"
                />
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="授课教师" prop="teacherId">
              <el-select v-model="form.teacherId" placeholder="请选择教师" filterable style="width: 100%">
                <el-option
                  v-for="item in teacherList"
                  :key="item.teacherId"
                  :label="item.nickName + (item.title ? ' (' + item.title + ')' : '')"
                  :value="item.teacherId"
                />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="选课容量" prop="maxStudents">
              <el-input-number v-model="form.maxStudents" :min="1" :max="500" placeholder="最大选课人数" style="width: 100%" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="上课时间" prop="classTime">
              <el-input v-model="form.classTime" placeholder="如：周一1-2节" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="上课地点" prop="classLocation">
              <el-input v-model="form.classLocation" placeholder="如：教学楼A101" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="状态" prop="status">
              <el-radio-group v-model="form.status">
                <el-radio label="0">可选</el-radio>
                <el-radio label="1">停用</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="24">
            <el-form-item label="备注" prop="remark">
              <el-input v-model="form.remark" type="textarea" placeholder="请输入内容" />
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>

    <!-- 查看选课学生对话框 -->
    <el-dialog title="选课学生列表" :visible.sync="studentDialogVisible" width="800px" append-to-body>
      <div v-if="currentOpening" class="mb10">
        <el-descriptions :column="3" border size="small">
          <el-descriptions-item label="课程">{{ currentOpening.courseName }}</el-descriptions-item>
          <el-descriptions-item label="教师">{{ currentOpening.teacherName }}</el-descriptions-item>
          <el-descriptions-item label="选课人数">{{ currentOpening.selectedNum }} / {{ currentOpening.maxStudents }}</el-descriptions-item>
        </el-descriptions>
      </div>
      <el-table v-loading="studentLoading" :data="selectedStudents" max-height="400">
        <el-table-column label="学号" align="center" prop="studentNo" width="120" />
        <el-table-column label="姓名" align="center" prop="studentName" width="100" />
        <el-table-column label="院系" align="center" prop="deptName" width="150" />
        <el-table-column label="班级" align="center" prop="className" width="100" />
        <el-table-column label="选课时间" align="center" prop="enrollTime" width="180" />
        <el-table-column label="成绩" align="center" prop="score" width="80">
          <template slot-scope="scope">
            <span>{{ scope.row.score != null ? scope.row.score : '未录入' }}</span>
          </template>
        </el-table-column>
      </el-table>
      <div slot="footer" class="dialog-footer">
        <el-button @click="studentDialogVisible = false">关 闭</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listOpening, getOpening, delOpening, addOpening, updateOpening } from "@/api/education/opening";
import { listTerm } from "@/api/education/term";
import { listCourseAll } from "@/api/education/course";
import { listTeacherAll } from "@/api/education/teacher";
import { listStudentsByOpening } from "@/api/education/selection";

export default {
  name: "Opening",
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 开课安排表格数据
      openingList: [],
      // 学期列表
      termList: [],
      // 课程列表
      courseList: [],
      // 教师列表
      teacherList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查看选课学生对话框
      studentDialogVisible: false,
      studentLoading: false,
      selectedStudents: [],
      currentOpening: null,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        termId: null,
        courseId: null,
        teacherId: null,
        status: null
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        termId: [
          { required: true, message: "学期不能为空", trigger: "change" }
        ],
        courseId: [
          { required: true, message: "课程不能为空", trigger: "change" }
        ],
        teacherId: [
          { required: true, message: "授课教师不能为空", trigger: "change" }
        ],
        maxStudents: [
          { required: true, message: "选课容量不能为空", trigger: "blur" }
        ]
      }
    };
  },
  created() {
    this.getList();
    this.getTermList();
    this.getCourseList();
    this.getTeacherList();
  },
  methods: {
    /** 查询开课安排列表 */
    getList() {
      this.loading = true;
      listOpening(this.queryParams).then(response => {
        this.openingList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    /** 获取学期列表 */
    getTermList() {
      listTerm({ status: '0' }).then(response => {
        this.termList = response.rows;
      });
    },
    /** 获取课程列表 */
    getCourseList() {
      listCourseAll().then(response => {
        this.courseList = response.data;
      });
    },
    /** 获取教师列表 */
    getTeacherList() {
      listTeacherAll().then(response => {
        this.teacherList = response.data;
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
        openId: null,
        termId: null,
        courseId: null,
        teacherId: null,
        classTime: null,
        classLocation: null,
        maxStudents: 60,
        selectedNum: 0,
        status: "0",
        remark: null
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
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.openId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      // 默认选择当前学期
      const currentTerm = this.termList.find(t => t.isCurrent === '1');
      if (currentTerm) {
        this.form.termId = currentTerm.termId;
      }
      this.open = true;
      this.title = "添加开课安排";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const openId = row.openId || this.ids
      getOpening(openId).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改开课安排";
      });
    },
    /** 查看选课学生 */
    handleViewStudents(row) {
      this.currentOpening = row;
      this.studentDialogVisible = true;
      this.studentLoading = true;
      listStudentsByOpening(row.openId).then(response => {
        this.selectedStudents = response.rows;
        this.studentLoading = false;
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.openId != null) {
            updateOpening(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addOpening(this.form).then(response => {
              this.$modal.msgSuccess("新增成功");
              this.open = false;
              this.getList();
            });
          }
        }
      });
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const openIds = row.openId || this.ids;
      this.$modal.confirm('是否确认删除开课安排编号为"' + openIds + '"的数据项？').then(function() {
        return delOpening(openIds);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('education/opening/export', {
        ...this.queryParams
      }, `opening_${new Date().getTime()}.xlsx`)
    }
  }
};
</script>

<style scoped>
.text-danger {
  color: #F56C6C;
  font-weight: bold;
}
.mb10 {
  margin-bottom: 10px;
}
</style>
