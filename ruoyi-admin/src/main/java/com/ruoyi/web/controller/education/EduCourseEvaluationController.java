package com.ruoyi.web.controller.education;

import java.util.List;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.education.domain.EduCourseEvaluation;
import com.ruoyi.system.domain.EduStudent;
import com.ruoyi.system.domain.EduTeacher;
import com.ruoyi.education.service.IEduCourseEvaluationService;
import com.ruoyi.education.service.IEduStudentService;
import com.ruoyi.education.service.IEduTeacherService;
import com.ruoyi.education.mapper.EduCourseEvaluationMapper;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 课程评价Controller
 * 
 * @author ruoyi
 * @date 2025-12-21
 */
@RestController
@RequestMapping("/education/evaluation")
public class EduCourseEvaluationController extends BaseController
{
    @Autowired
    private IEduCourseEvaluationService eduCourseEvaluationService;

    @Autowired
    private IEduStudentService eduStudentService;

    @Autowired
    private IEduTeacherService eduTeacherService;

    @Autowired
    private EduCourseEvaluationMapper eduCourseEvaluationMapper;

    /**
     * 查询课程评价列表
     */
    @PreAuthorize("@ss.hasPermi('education:evaluation:list')")
    @GetMapping("/list")
    public TableDataInfo list(EduCourseEvaluation eduCourseEvaluation)
    {
        startPage();
        List<EduCourseEvaluation> list = eduCourseEvaluationService.selectEduCourseEvaluationList(eduCourseEvaluation);
        return getDataTable(list);
    }

    /**
     * 导出课程评价列表
     */
    @PreAuthorize("@ss.hasPermi('education:evaluation:export')")
    @Log(title = "课程评价", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, EduCourseEvaluation eduCourseEvaluation)
    {
        List<EduCourseEvaluation> list = eduCourseEvaluationService.selectEduCourseEvaluationList(eduCourseEvaluation);
        ExcelUtil<EduCourseEvaluation> util = new ExcelUtil<EduCourseEvaluation>(EduCourseEvaluation.class);
        util.exportExcel(response, list, "课程评价数据");
    }

    /**
     * 获取课程评价详情
     */
    @PreAuthorize("@ss.hasPermi('education:evaluation:query')")
    @GetMapping(value = "/{evalId}")
    public AjaxResult getInfo(@PathVariable("evalId") Long evalId)
    {
        return success(eduCourseEvaluationService.selectEduCourseEvaluationByEvalId(evalId));
    }

    /**
     * 获取课程评价统计
     */
    @GetMapping(value = "/stats/{openId}")
    public AjaxResult getStats(@PathVariable("openId") Long openId)
    {
        return success(eduCourseEvaluationService.selectEvaluationStats(openId));
    }

    /**
     * 学生提交评价
     */
    @Log(title = "课程评价", businessType = BusinessType.INSERT)
    @PostMapping("/submit")
    public AjaxResult submit(@RequestBody EduCourseEvaluation evaluation)
    {
        // 获取当前学生ID
        EduStudent student = eduStudentService.selectEduStudentByUserId(getUserId());
        if (student == null)
        {
            return error("学生信息不存在");
        }
        return eduCourseEvaluationService.submitEvaluation(student.getStudentId(), evaluation);
    }

    /**
     * 获取待评价课程列表
     */
    @GetMapping("/pending")
    public AjaxResult getPendingEvaluations()
    {
        EduStudent student = eduStudentService.selectEduStudentByUserId(getUserId());
        if (student == null)
        {
            return error("学生信息不存在");
        }
        return success(eduCourseEvaluationService.selectPendingEvaluations(student.getStudentId()));
    }

    /**
     * 删除课程评价
     */
    @PreAuthorize("@ss.hasPermi('education:evaluation:remove')")
    @Log(title = "课程评价", businessType = BusinessType.DELETE)
    @DeleteMapping("/{evalIds}")
    public AjaxResult remove(@PathVariable Long[] evalIds)
    {
        return toAjax(eduCourseEvaluationService.deleteEduCourseEvaluationByEvalIds(evalIds));
    }

    /**
     * 教师查看自己课程的评价列表
     */
    @PreAuthorize("@ss.hasPermi('education:evaluation:teacher')")
    @GetMapping("/teacher/list")
    public TableDataInfo teacherEvaluationList()
    {
        EduTeacher teacher = eduTeacherService.selectEduTeacherByUserId(getUserId());
        if (teacher == null)
        {
            return getDataTable(new java.util.ArrayList<>());
        }
        startPage();
        List<EduCourseEvaluation> list = eduCourseEvaluationMapper.selectEvaluationByTeacherId(teacher.getTeacherId());
        return getDataTable(list);
    }

    /**
     * 教师查看自己课程的评价统计汇总
     */
    @PreAuthorize("@ss.hasPermi('education:evaluation:teacher')")
    @GetMapping("/teacher/stats")
    public AjaxResult teacherEvaluationStats()
    {
        EduTeacher teacher = eduTeacherService.selectEduTeacherByUserId(getUserId());
        if (teacher == null)
        {
            return success(new java.util.ArrayList<>());
        }
        List<EduCourseEvaluation> list = eduCourseEvaluationMapper.selectEvaluationStatsByTeacherId(teacher.getTeacherId());
        return success(list);
    }

    /**
     * 管理员/教务老师查看所有评价列表
     */
    @PreAuthorize("@ss.hasAnyRoles('admin,leader')")
    @GetMapping("/admin/list")
    public TableDataInfo adminEvaluationList(EduCourseEvaluation eduCourseEvaluation)
    {
        startPage();
        List<EduCourseEvaluation> list = eduCourseEvaluationService.selectEduCourseEvaluationList(eduCourseEvaluation);
        return getDataTable(list);
    }

    /**
     * 管理员/教务老师导出评价数据
     */
    @PreAuthorize("@ss.hasAnyRoles('admin,leader')")
    @Log(title = "导出评价数据", businessType = BusinessType.EXPORT)
    @PostMapping("/admin/export")
    public void adminExport(HttpServletResponse response, EduCourseEvaluation eduCourseEvaluation)
    {
        List<EduCourseEvaluation> list = eduCourseEvaluationService.selectEduCourseEvaluationList(eduCourseEvaluation);
        ExcelUtil<EduCourseEvaluation> util = new ExcelUtil<EduCourseEvaluation>(EduCourseEvaluation.class);
        util.exportExcel(response, list, "课程评价数据");
    }
}
