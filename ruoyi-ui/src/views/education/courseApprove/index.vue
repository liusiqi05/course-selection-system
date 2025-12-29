<template>
  <div class="app-container">
    <!-- 统计卡片 -->
    <el-row :gutter="20" class="mb20">
      <el-col :span="6">
        <el-card shadow="hover" class="stat-card">
          <div class="stat-content">
            <div class="stat-icon pending">
              <i class="el-icon-time"></i>
            </div>
            <div class="stat-info">
              <div class="stat-value">{{ stats.pending }}</div>
              <div class="stat-label">待审批</div>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card shadow="hover" class="stat-card">
          <div class="stat-content">
            <div class="stat-icon approved">
              <i class="el-icon-circle-check"></i>
            </div>
            <div class="stat-info">
              <div class="stat-value">{{ stats.approved }}</div>
              <div class="stat-label">已通过</div>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card shadow="hover" class="stat-card">
          <div class="stat-content">
            <div class="stat-icon rejected">
              <i class="el-icon-circle-close"></i>
            </div>
            <div class="stat-info">
              <div class="stat-value">{{ stats.rejected }}</div>
              <div class="stat-label">已拒绝</div>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card shadow="hover" class="stat-card">
          <div class="stat-content">
            <div class="stat-icon total">
              <i class="el-icon-document"></i>
            </div>
            <div class="stat-info">
              <div class="stat-value">{{ stats.total }}</div>
              <div class="stat-label">总申请</div>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>

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
      <el-form-item label="申请教师" prop="teacherName">
        <el-input
          v-model="queryParams.teacherName"
          placeholder="请输入教师姓名"
          clearable
          @keyup.enter.native="handleQuery"
        />
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
          type="success"
          plain
          icon="el-icon-check"
          size="mini"
          :disabled="!hasPendingSelected"
          @click="handleBatchApprove"
          v-hasPermi="['education:apply:approve']"
        >批量通过</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-close"
          size="mini"
          :disabled="!hasPendingSelected"
          @click="handleBatchReject"
          v-hasPermi="['education:apply:approve']"
        >批量拒绝</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['education:apply:export']"
        >导出</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-refresh"
          size="mini"
          @click="handleConvert"
          v-hasPermi="['education:apply:convert']"
        >转换为开课</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <!-- 申请列表 -->
    <el-table v-loading="loading" :data="applyList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="学期" align="center" prop="termName" width="160" />
      <el-table-column label="申请教师" align="center" prop="teacherName" width="100" />
      <el-table-column label="课程代码" align="center" prop="courseCode" width="120" />
      <el-table-column label="课程名称" align="center" prop="courseName" min-width="150" />
      <el-table-column label="学分" align="center" prop="credit" width="70" />
      <el-table-column label="课程类型" align="center" prop="courseType" width="90" />
      <el-table-column label="上课时间" align="center" prop="classTime" width="130" />
      <el-table-column label="上课地点" align="center" prop="classLocation" width="100" />
      <el-table-column label="课程容量" align="center" prop="maxStudents" width="80" />
      <el-table-column label="审批状态" align="center" width="100">
        <template slot-scope="scope">
          <el-tag :type="getStatusType(scope.row.status)" size="small">
            {{ getStatusLabel(scope.row.status) }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="申请时间" align="center" prop="createTime" width="160" />
      <el-table-column label="操作" align="center" width="180" fixed="right">
        <template slot-scope="scope">
          <el-button size="mini" type="text" icon="el-icon-view" @click="handleView(scope.row)">
            查看
          </el-button>
          <template v-if="scope.row.status === '0'">
            <el-button size="mini" type="text" icon="el-icon-check" @click="handleApprove(scope.row)" class="text-success">
              通过
            </el-button>
            <el-button size="mini" type="text" icon="el-icon-close" @click="handleReject(scope.row)" class="text-danger">
              拒绝
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

    <!-- 查看详情对话框 -->
    <el-dialog title="申请详情" :visible.sync="viewDialogVisible" width="700px" append-to-body>
      <el-descriptions :column="2" border v-if="currentApply">
        <el-descriptions-item label="学期">{{ currentApply.termName }}</el-descriptions-item>
        <el-descriptions-item label="审批状态">
          <el-tag :type="getStatusType(currentApply.status)">{{ getStatusLabel(currentApply.status) }}</el-tag>
        </el-descriptions-item>
        <el-descriptions-item label="申请教师">{{ currentApply.teacherName }}</el-descriptions-item>
        <el-descriptions-item label="申请时间">{{ currentApply.createTime }}</el-descriptions-item>
        <el-descriptions-item label="课程代码">{{ currentApply.courseCode }}</el-descriptions-item>
        <el-descriptions-item label="课程名称">{{ currentApply.courseName }}</el-descriptions-item>
        <el-descriptions-item label="学分">{{ currentApply.credit }}</el-descriptions-item>
        <el-descriptions-item label="课程类型">{{ currentApply.courseType || '未设置' }}</el-descriptions-item>
        <el-descriptions-item label="上课时间">{{ currentApply.classTime }}</el-descriptions-item>
        <el-descriptions-item label="上课地点">{{ currentApply.classLocation }}</el-descriptions-item>
        <el-descriptions-item label="课程容量">{{ currentApply.maxStudents }}人</el-descriptions-item>
        <el-descriptions-item label="是否新课程">
          {{ currentApply.courseId ? '否（已有课程）' : '是（新课程）' }}
        </el-descriptions-item>
        <el-descriptions-item label="课程简介" :span="2">{{ currentApply.description || '无' }}</el-descriptions-item>
        <template v-if="currentApply.status !== '0'">
          <el-descriptions-item label="审批人">{{ currentApply.approveBy }}</el-descriptions-item>
          <el-descriptions-item label="审批时间">{{ currentApply.approveTime }}</el-descriptions-item>
          <el-descriptions-item label="拒绝原因" :span="2" v-if="currentApply.status === '2'">
            <span class="text-danger">{{ currentApply.rejectReason || '无' }}</span>
          </el-descriptions-item>
        </template>
      </el-descriptions>
      <div slot="footer" class="dialog-footer" v-if="currentApply && currentApply.status === '0'">
        <el-button @click="viewDialogVisible = false">取 消</el-button>
        <el-button type="danger" @click="handleRejectFromDialog">拒 绝</el-button>
        <el-button type="success" @click="handleApproveFromDialog">通 过</el-button>
      </div>
      <div slot="footer" class="dialog-footer" v-else>
        <el-button @click="viewDialogVisible = false">关 闭</el-button>
      </div>
    </el-dialog>

    <!-- 拒绝原因对话框 -->
    <el-dialog title="拒绝申请" :visible.sync="rejectDialogVisible" width="500px" append-to-body>
      <el-form ref="rejectForm" :model="rejectForm" :rules="rejectRules" label-width="80px">
        <el-form-item label="拒绝原因" prop="rejectReason">
          <el-input
            type="textarea"
            v-model="rejectForm.rejectReason"
            placeholder="请输入拒绝原因"
            :rows="4"
          />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="rejectDialogVisible = false">取 消</el-button>
        <el-button type="danger" @click="confirmReject" :loading="submitLoading">确认拒绝</el-button>
      </div>
    </el-dialog>

    <!-- 转换对话框 -->
    <el-dialog title="转换为开课安排" :visible.sync="convertDialogVisible" width="500px" append-to-body>
      <el-form ref="convertForm" :model="convertForm" label-width="100px">
        <el-alert
          title="温馨提示"
          type="info"
          :closable="false"
          class="mb20"
        >
          该操作将把指定学期内所有已通过的开课申请转换为正式的开课安排，学生可以进行选课。
        </el-alert>
        <el-form-item label="选择学期" prop="termId">
          <el-select v-model="convertForm.termId" placeholder="请选择学期" style="width: 100%;">
            <el-option
              v-for="term in termList"
              :key="term.termId"
              :label="term.termName"
              :value="term.termId"
            >
              <span style="float: left">{{ term.termName }}</span>
              <span style="float: right; color: #8492a6; font-size: 13px">
                {{ term.isCurrent === '1' ? '(当前学期)' : '' }}
              </span>
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="已通过申请" v-if="convertForm.termId">
          <el-tag type="success" size="medium">
            {{ getApprovedCount(convertForm.termId) }} 个
          </el-tag>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="convertDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="confirmConvert" :loading="submitLoading" :disabled="!convertForm.termId">
          确认转换
        </el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listApply, getApply, approveApply, batchApproveApply, convertApply } from "@/api/education/courseApply";
import { listTerm } from "@/api/education/term";

export default {
  name: "CourseApprove",
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
      // 选中的申请
      selectedApplies: [],
      // 学期列表
      termList: [],
      // 当前查看的申请
      currentApply: null,
      // 对话框
      viewDialogVisible: false,
      rejectDialogVisible: false,
      convertDialogVisible: false,
      // 提交loading
      submitLoading: false,
      // 统计数据
      stats: {
        pending: 0,
        approved: 0,
        rejected: 0,
        total: 0
      },
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        termId: null,
        teacherName: null,
        courseName: null,
        status: null
      },
      // 拒绝表单
      rejectForm: {
        applyId: null,
        rejectReason: ''
      },
      rejectRules: {
        rejectReason: [
          { required: true, message: "请输入拒绝原因", trigger: "blur" }
        ]
      },
      // 转换表单
      convertForm: {
        termId: null
      }
    };
  },
  computed: {
    /** 是否有选中的待审批申请 */
    hasPendingSelected() {
      return this.selectedApplies.some(item => item.status === '0');
    }
  },
  created() {
    this.getTermList();
    this.getList();
  },
  methods: {
    /** 查询学期列表 */
    getTermList() {
      listTerm({ status: '0' }).then(response => {
        this.termList = response.rows || [];
      });
    },
    /** 查询申请列表 */
    getList() {
      this.loading = true;
      listApply(this.queryParams).then(response => {
        this.applyList = response.rows || [];
        this.total = response.total || 0;
        this.loading = false;
        this.calcStats();
      });
    },
    /** 计算统计数据 */
    calcStats() {
      // 这里简单计算当前页的统计，实际项目中应该从后端获取总体统计
      this.stats.pending = this.applyList.filter(item => item.status === '0').length;
      this.stats.approved = this.applyList.filter(item => item.status === '1').length;
      this.stats.rejected = this.applyList.filter(item => item.status === '2').length;
      this.stats.total = this.total;
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
    /** 多选框选中数据 */
    handleSelectionChange(selection) {
      this.selectedApplies = selection;
    },
    /** 查看详情 */
    handleView(row) {
      this.currentApply = row;
      this.viewDialogVisible = true;
    },
    /** 通过申请 */
    handleApprove(row) {
      this.$modal.confirm('确认通过该开课申请吗？').then(() => {
        return approveApply({ applyId: row.applyId, status: '1' });
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("审批成功");
      }).catch(() => {});
    },
    /** 从详情对话框通过 */
    handleApproveFromDialog() {
      this.$modal.confirm('确认通过该开课申请吗？').then(() => {
        return approveApply({ applyId: this.currentApply.applyId, status: '1' });
      }).then(() => {
        this.viewDialogVisible = false;
        this.getList();
        this.$modal.msgSuccess("审批成功");
      }).catch(() => {});
    },
    /** 拒绝申请 */
    handleReject(row) {
      this.rejectForm.applyId = row.applyId;
      this.rejectForm.rejectReason = '';
      this.rejectDialogVisible = true;
    },
    /** 从详情对话框拒绝 */
    handleRejectFromDialog() {
      this.rejectForm.applyId = this.currentApply.applyId;
      this.rejectForm.rejectReason = '';
      this.viewDialogVisible = false;
      this.rejectDialogVisible = true;
    },
    /** 确认拒绝 */
    confirmReject() {
      this.$refs["rejectForm"].validate(valid => {
        if (valid) {
          this.submitLoading = true;
          approveApply({
            applyId: this.rejectForm.applyId,
            status: '2',
            rejectReason: this.rejectForm.rejectReason
          }).then(() => {
            this.rejectDialogVisible = false;
            this.getList();
            this.$modal.msgSuccess("已拒绝该申请");
          }).finally(() => {
            this.submitLoading = false;
          });
        }
      });
    },
    /** 批量通过 */
    handleBatchApprove() {
      const pendingIds = this.selectedApplies
        .filter(item => item.status === '0')
        .map(item => item.applyId);
      
      if (pendingIds.length === 0) {
        this.$modal.msgWarning("请选择待审批的申请");
        return;
      }
      
      this.$modal.confirm(`确认批量通过选中的 ${pendingIds.length} 个申请吗？`).then(() => {
        return batchApproveApply('1', pendingIds);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("批量审批成功");
      }).catch(() => {});
    },
    /** 批量拒绝 */
    handleBatchReject() {
      const pendingIds = this.selectedApplies
        .filter(item => item.status === '0')
        .map(item => item.applyId);
      
      if (pendingIds.length === 0) {
        this.$modal.msgWarning("请选择待审批的申请");
        return;
      }
      
      this.$modal.confirm(`确认批量拒绝选中的 ${pendingIds.length} 个申请吗？`).then(() => {
        return batchApproveApply('2', pendingIds);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("批量拒绝成功");
      }).catch(() => {});
    },
    /** 转换为开课安排 */
    handleConvert() {
      this.convertForm.termId = null;
      this.convertDialogVisible = true;
    },
    /** 获取指定学期已通过的申请数量 */
    getApprovedCount(termId) {
      return this.applyList.filter(item => item.termId === termId && item.status === '1').length;
    },
    /** 确认转换 */
    confirmConvert() {
      if (!this.convertForm.termId) {
        this.$modal.msgWarning("请选择学期");
        return;
      }
      
      this.$modal.confirm('确认将该学期已通过的申请转换为开课安排吗？').then(() => {
        this.submitLoading = true;
        return convertApply(this.convertForm.termId);
      }).then(response => {
        this.convertDialogVisible = false;
        this.$modal.msgSuccess(response.msg || "转换成功");
        this.getList();
      }).finally(() => {
        this.submitLoading = false;
      });
    },
    /** 导出 */
    handleExport() {
      this.download('education/apply/export', {
        ...this.queryParams
      }, `开课申请_${new Date().getTime()}.xlsx`);
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
    }
  }
};
</script>

<style scoped>
.mb20 {
  margin-bottom: 20px;
}
.stat-card {
  cursor: pointer;
}
.stat-card:hover {
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}
.stat-content {
  display: flex;
  align-items: center;
}
.stat-icon {
  width: 60px;
  height: 60px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-right: 15px;
}
.stat-icon i {
  font-size: 28px;
  color: #fff;
}
.stat-icon.pending {
  background: linear-gradient(135deg, #f6d365 0%, #fda085 100%);
}
.stat-icon.approved {
  background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
}
.stat-icon.rejected {
  background: linear-gradient(135deg, #ee0979 0%, #ff6a00 100%);
}
.stat-icon.total {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}
.stat-info {
  flex: 1;
}
.stat-value {
  font-size: 28px;
  font-weight: bold;
  color: #303133;
}
.stat-label {
  font-size: 14px;
  color: #909399;
  margin-top: 5px;
}
.text-success {
  color: #67c23a;
}
.text-danger {
  color: #f56c6c;
}
</style>
