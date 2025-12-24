<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="学生" prop="studentId">
        <el-input
          v-model="queryParams.studentNo"
          placeholder="请输入学号"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="开课ID" prop="openId">
        <el-input
          v-model="queryParams.openId"
          placeholder="请输入开课ID"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择状态" clearable>
          <el-option label="正常" value="0" />
          <el-option label="退选" value="1" />
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
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['education:selection:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['education:selection:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="selectionList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="选课ID" align="center" prop="scId" width="80" />
      <el-table-column label="学号" align="center" prop="studentNo" width="120" />
      <el-table-column label="学生姓名" align="center" prop="studentName" width="100" />
      <el-table-column label="课程名称" align="center" prop="courseName" width="150" />
      <el-table-column label="课程代码" align="center" prop="courseCode" width="100" />
      <el-table-column label="授课教师" align="center" prop="teacherName" width="100" />
      <el-table-column label="上课时间" align="center" prop="classTime" width="120" />
      <el-table-column label="选课时间" align="center" prop="enrollTime" width="180" />
      <el-table-column label="成绩" align="center" prop="score" width="80">
        <template slot-scope="scope">
          <span :class="getScoreClass(scope.row.score)">
            {{ scope.row.score != null ? scope.row.score : '未录入' }}
          </span>
        </template>
      </el-table-column>
      <el-table-column label="状态" align="center" prop="status" width="80">
        <template slot-scope="scope">
          <el-tag :type="scope.row.status === '0' ? 'success' : 'info'">
            {{ scope.row.status === '0' ? '正常' : '退选' }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="150">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleEditScore(scope.row)"
            v-hasPermi="['education:selection:edit']"
          >录入成绩</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['education:selection:remove']"
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

    <!-- 录入成绩对话框 -->
    <el-dialog title="录入成绩" :visible.sync="scoreDialogVisible" width="400px" append-to-body>
      <el-form ref="scoreForm" :model="scoreForm" :rules="scoreRules" label-width="80px">
        <el-form-item label="学生">
          <span>{{ scoreForm.studentName }} ({{ scoreForm.studentNo }})</span>
        </el-form-item>
        <el-form-item label="课程">
          <span>{{ scoreForm.courseName }}</span>
        </el-form-item>
        <el-form-item label="成绩" prop="score">
          <el-input-number v-model="scoreForm.score" :min="0" :max="100" :precision="1" placeholder="请输入成绩" style="width: 100%" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitScore">确 定</el-button>
        <el-button @click="scoreDialogVisible = false">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listSelection, getSelection, delSelection, updateSelection } from "@/api/education/selection";

export default {
  name: "Selection",
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 选课记录表格数据
      selectionList: [],
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        studentNo: null,
        openId: null,
        status: null
      },
      // 录入成绩对话框
      scoreDialogVisible: false,
      scoreForm: {},
      scoreRules: {
        score: [
          { required: true, message: "成绩不能为空", trigger: "blur" }
        ]
      }
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询选课记录列表 */
    getList() {
      this.loading = true;
      listSelection(this.queryParams).then(response => {
        this.selectionList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    // 获取成绩样式
    getScoreClass(score) {
      if (score == null) return '';
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
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.scId)
      this.multiple = !selection.length
    },
    /** 录入成绩 */
    handleEditScore(row) {
      this.scoreForm = {
        scId: row.scId,
        studentNo: row.studentNo,
        studentName: row.studentName,
        courseName: row.courseName,
        score: row.score
      };
      this.scoreDialogVisible = true;
    },
    /** 提交成绩 */
    submitScore() {
      this.$refs["scoreForm"].validate(valid => {
        if (valid) {
          updateSelection({ scId: this.scoreForm.scId, score: this.scoreForm.score }).then(response => {
            this.$modal.msgSuccess("成绩录入成功");
            this.scoreDialogVisible = false;
            this.getList();
          });
        }
      });
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const scIds = row.scId || this.ids;
      this.$modal.confirm('是否确认删除选课记录编号为"' + scIds + '"的数据项？').then(function() {
        return delSelection(scIds);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('education/selection/export', {
        ...this.queryParams
      }, `selection_${new Date().getTime()}.xlsx`)
    }
  }
};
</script>

<style scoped>
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
