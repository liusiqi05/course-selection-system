<template>
  <div class="app-container gpa-container">
    <!-- GPA概览卡片 -->
    <el-row :gutter="20">
      <el-col :span="6">
        <el-card class="stat-card gpa-card" shadow="hover">
          <div class="stat-icon">
            <i class="el-icon-trophy"></i>
          </div>
          <div class="stat-info">
            <div class="stat-value">{{ gpaStats.gpa || '0.00' }}</div>
            <div class="stat-label">总GPA</div>
          </div>
          <div class="stat-badge" :class="gpaLevel">
            {{ gpaLevelText }}
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card class="stat-card credit-card" shadow="hover">
          <div class="stat-icon">
            <i class="el-icon-document"></i>
          </div>
          <div class="stat-info">
            <div class="stat-value">{{ gpaStats.totalCredit || 0 }}</div>
            <div class="stat-label">已修学分</div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card class="stat-card pass-card" shadow="hover">
          <div class="stat-icon">
            <i class="el-icon-circle-check"></i>
          </div>
          <div class="stat-info">
            <div class="stat-value">{{ gpaStats.passCount || 0 }}</div>
            <div class="stat-label">通过课程</div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card class="stat-card fail-card" shadow="hover">
          <div class="stat-icon">
            <i class="el-icon-circle-close"></i>
          </div>
          <div class="stat-info">
            <div class="stat-value">{{ gpaStats.failCount || 0 }}</div>
            <div class="stat-label">挂科课程</div>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <!-- 学业预警 -->
    <el-card v-if="warningLevel" class="warning-card" shadow="hover">
      <div class="warning-content" :class="warningLevel">
        <i :class="warningIcon"></i>
        <div class="warning-text">
          <h3>{{ warningTitle }}</h3>
          <p>{{ warningMessage }}</p>
        </div>
      </div>
    </el-card>

    <!-- 学期GPA详情 -->
    <el-card class="term-gpa-card" shadow="hover">
      <div slot="header">
        <span><i class="el-icon-data-analysis"></i> 学期GPA趋势</span>
      </div>
      
      <!-- GPA趋势图 -->
      <div class="gpa-chart" ref="gpaChart"></div>

      <!-- 学期GPA表格 -->
      <el-table :data="termGpaList" stripe style="width: 100%; margin-top: 20px">
        <el-table-column prop="termName" label="学期" width="200" />
        <el-table-column prop="courseCount" label="课程数" width="100" align="center" />
        <el-table-column prop="totalCredit" label="学分" width="100" align="center" />
        <el-table-column label="GPA" width="120" align="center">
          <template slot-scope="scope">
            <span :class="getGpaClass(scope.row.gpa)" style="font-weight: bold">
              {{ scope.row.gpa }}
            </span>
          </template>
        </el-table-column>
        <el-table-column label="通过/挂科" width="120" align="center">
          <template slot-scope="scope">
            <span style="color: #67C23A">{{ scope.row.passCount }}</span>
            <span> / </span>
            <span style="color: #F56C6C">{{ scope.row.failCount }}</span>
          </template>
        </el-table-column>
        <el-table-column label="通过率" width="150" align="center">
          <template slot-scope="scope">
            <el-progress 
              :percentage="getPassRate(scope.row)" 
              :color="getPassRateColor(scope.row)"
              :stroke-width="10"
            />
          </template>
        </el-table-column>
      </el-table>
    </el-card>

    <!-- GPA计算规则说明 -->
    <el-card class="rule-card" shadow="hover">
      <div slot="header">
        <span><i class="el-icon-info"></i> GPA计算规则</span>
      </div>
      <el-table :data="gpaRules" stripe size="small">
        <el-table-column prop="score" label="百分制成绩" width="150" align="center" />
        <el-table-column prop="gpa" label="绩点" width="100" align="center" />
        <el-table-column prop="level" label="等级" width="100" align="center" />
      </el-table>
      <div class="rule-formula">
        <strong>计算公式：</strong>GPA = Σ(课程学分 × 课程绩点) / Σ(课程学分)
      </div>
    </el-card>
  </div>
</template>

<script>
import { getGpaStats, getTermGpaList } from "@/api/education/studentCourse";
import * as echarts from 'echarts';

export default {
  name: "StudentGpa",
  data() {
    return {
      gpaStats: {},
      termGpaList: [],
      chart: null,
      gpaRules: [
        { score: '90-100', gpa: '4.0', level: 'A' },
        { score: '85-89', gpa: '3.7', level: 'A-' },
        { score: '82-84', gpa: '3.3', level: 'B+' },
        { score: '78-81', gpa: '3.0', level: 'B' },
        { score: '75-77', gpa: '2.7', level: 'B-' },
        { score: '72-74', gpa: '2.3', level: 'C+' },
        { score: '68-71', gpa: '2.0', level: 'C' },
        { score: '64-67', gpa: '1.5', level: 'C-' },
        { score: '60-63', gpa: '1.0', level: 'D' },
        { score: '0-59', gpa: '0', level: 'F' }
      ]
    };
  },
  computed: {
    gpaLevel() {
      const gpa = this.gpaStats.gpa || 0;
      if (gpa >= 3.5) return 'excellent';
      if (gpa >= 3.0) return 'good';
      if (gpa >= 2.0) return 'pass';
      return 'warning';
    },
    gpaLevelText() {
      const gpa = this.gpaStats.gpa || 0;
      if (gpa >= 3.5) return '优秀';
      if (gpa >= 3.0) return '良好';
      if (gpa >= 2.0) return '合格';
      return '预警';
    },
    warningLevel() {
      const gpa = this.gpaStats.gpa || 0;
      const failCount = this.gpaStats.failCount || 0;
      
      if (failCount >= 3 || gpa < 1.5) return 'danger';
      if (failCount >= 2 || gpa < 2.0) return 'warning';
      if (failCount >= 1) return 'info';
      return null;
    },
    warningIcon() {
      if (this.warningLevel === 'danger') return 'el-icon-error';
      if (this.warningLevel === 'warning') return 'el-icon-warning';
      return 'el-icon-info';
    },
    warningTitle() {
      if (this.warningLevel === 'danger') return '⚠️ 严重学业预警';
      if (this.warningLevel === 'warning') return '⚠️ 学业预警';
      return '💡 温馨提示';
    },
    warningMessage() {
      const gpa = this.gpaStats.gpa || 0;
      const failCount = this.gpaStats.failCount || 0;
      
      if (failCount >= 3) {
        return `您目前有 ${failCount} 门课程不及格，GPA为 ${gpa}，已触发严重学业预警。请立即联系辅导员制定学业恢复计划。`;
      }
      if (gpa < 1.5) {
        return `您的GPA (${gpa}) 低于1.5，已触发严重学业预警。建议优先重修挂科课程，努力提升成绩。`;
      }
      if (failCount >= 2 || gpa < 2.0) {
        return `您目前有 ${failCount} 门课程不及格，GPA为 ${gpa}。建议合理安排学习时间，积极参加补考或重修。`;
      }
      if (failCount >= 1) {
        return `您有 ${failCount} 门课程不及格，建议尽快安排补考或重修，以免影响毕业和学位获取。`;
      }
      return '';
    }
  },
  mounted() {
    this.loadGpaStats();
    this.loadTermGpaList();
  },
  beforeDestroy() {
    if (this.chart) {
      this.chart.dispose();
    }
  },
  methods: {
    loadGpaStats() {
      getGpaStats().then(response => {
        this.gpaStats = response.data || {};
      });
    },
    loadTermGpaList() {
      getTermGpaList().then(response => {
        this.termGpaList = response.data || [];
        this.$nextTick(() => {
          this.initChart();
        });
      });
    },
    initChart() {
      if (!this.$refs.gpaChart || this.termGpaList.length === 0) return;
      
      if (this.chart) {
        this.chart.dispose();
      }
      
      this.chart = echarts.init(this.$refs.gpaChart);
      
      const termNames = this.termGpaList.map(t => t.termName).reverse();
      const gpaValues = this.termGpaList.map(t => t.gpa).reverse();
      
      const option = {
        tooltip: {
          trigger: 'axis',
          formatter: '{b}<br/>GPA: {c}'
        },
        grid: {
          left: '3%',
          right: '4%',
          bottom: '3%',
          containLabel: true
        },
        xAxis: {
          type: 'category',
          boundaryGap: false,
          data: termNames,
          axisLabel: {
            rotate: 20
          }
        },
        yAxis: {
          type: 'value',
          min: 0,
          max: 4,
          interval: 0.5
        },
        series: [{
          name: 'GPA',
          type: 'line',
          data: gpaValues,
          smooth: true,
          lineStyle: {
            color: '#409EFF',
            width: 3
          },
          areaStyle: {
            color: {
              type: 'linear',
              x: 0, y: 0, x2: 0, y2: 1,
              colorStops: [
                { offset: 0, color: 'rgba(64, 158, 255, 0.3)' },
                { offset: 1, color: 'rgba(64, 158, 255, 0.05)' }
              ]
            }
          },
          itemStyle: {
            color: '#409EFF'
          },
          markLine: {
            data: [
              { yAxis: 2.0, name: '及格线', lineStyle: { color: '#E6A23C' } },
              { yAxis: 3.5, name: '优秀线', lineStyle: { color: '#67C23A' } }
            ]
          }
        }]
      };
      
      this.chart.setOption(option);
      
      window.addEventListener('resize', () => {
        this.chart && this.chart.resize();
      });
    },
    getGpaClass(gpa) {
      if (gpa >= 3.5) return 'gpa-excellent';
      if (gpa >= 3.0) return 'gpa-good';
      if (gpa >= 2.0) return 'gpa-pass';
      return 'gpa-fail';
    },
    getPassRate(row) {
      const total = (row.passCount || 0) + (row.failCount || 0);
      if (total === 0) return 0;
      return Math.round((row.passCount / total) * 100);
    },
    getPassRateColor(row) {
      const rate = this.getPassRate(row);
      if (rate >= 90) return '#67C23A';
      if (rate >= 70) return '#E6A23C';
      return '#F56C6C';
    }
  }
};
</script>

<style scoped>
.gpa-container {
  padding: 20px;
}

.stat-card {
  display: flex;
  align-items: center;
  padding: 20px;
  border-radius: 10px;
  position: relative;
  overflow: hidden;
}

.stat-icon {
  font-size: 40px;
  margin-right: 20px;
  opacity: 0.8;
}

.gpa-card .stat-icon { color: #409EFF; }
.credit-card .stat-icon { color: #67C23A; }
.pass-card .stat-icon { color: #67C23A; }
.fail-card .stat-icon { color: #F56C6C; }

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

.stat-badge {
  position: absolute;
  top: 10px;
  right: 10px;
  padding: 3px 10px;
  border-radius: 10px;
  font-size: 12px;
  color: #fff;
}

.stat-badge.excellent { background: linear-gradient(135deg, #67C23A, #85ce61); }
.stat-badge.good { background: linear-gradient(135deg, #409EFF, #66b1ff); }
.stat-badge.pass { background: linear-gradient(135deg, #E6A23C, #ebb563); }
.stat-badge.warning { background: linear-gradient(135deg, #F56C6C, #f78989); }

.warning-card {
  margin-top: 20px;
}

.warning-content {
  display: flex;
  align-items: center;
  padding: 15px;
  border-radius: 8px;
}

.warning-content.danger {
  background: linear-gradient(135deg, #fff5f5, #ffe6e6);
  border-left: 4px solid #F56C6C;
}

.warning-content.warning {
  background: linear-gradient(135deg, #fffbe6, #fff3cd);
  border-left: 4px solid #E6A23C;
}

.warning-content.info {
  background: linear-gradient(135deg, #e6f7ff, #bae7ff);
  border-left: 4px solid #409EFF;
}

.warning-content i {
  font-size: 40px;
  margin-right: 20px;
}

.warning-content.danger i { color: #F56C6C; }
.warning-content.warning i { color: #E6A23C; }
.warning-content.info i { color: #409EFF; }

.warning-text h3 {
  margin: 0 0 5px 0;
  color: #303133;
}

.warning-text p {
  margin: 0;
  color: #606266;
}

.term-gpa-card {
  margin-top: 20px;
}

.gpa-chart {
  height: 300px;
}

.gpa-excellent { color: #67C23A; }
.gpa-good { color: #409EFF; }
.gpa-pass { color: #E6A23C; }
.gpa-fail { color: #F56C6C; }

.rule-card {
  margin-top: 20px;
}

.rule-formula {
  margin-top: 15px;
  padding: 10px;
  background: #f5f7fa;
  border-radius: 4px;
  color: #606266;
}
</style>
