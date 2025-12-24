package com.ruoyi.education.controller;

import java.util.List;
import java.util.Collections;
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
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.education.domain.EduStudent;
import com.ruoyi.education.domain.EduTeacher;
import com.ruoyi.education.domain.EduCourseOpening;
import com.ruoyi.education.domain.EduStudentCourse;
import com.ruoyi.education.service.IEduStudentService;
import com.ruoyi.education.service.IEduTeacherService;
import com.ruoyi.education.service.IEduCourseOpeningService;
import com.ruoyi.education.service.IEduStudentCourseService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 选课记录Controller
 * 
 * @author ruoyi
 * @date 2025-12-18
 */
@RestController
@RequestMapping("/education/selection")
public class EduStudentCourseController extends BaseController
{
    @Autowired
    private IEduStudentCourseService eduStudentCourseService;

    @Autowired
    private IEduStudentService eduStudentService;

    @Autowired
    private IEduTeacherService eduTeacherService;

    @Autowired
    private IEduCourseOpeningService eduCourseOpeningService;

    /**
     * 查询选课记录列表（管理员/教师用）
     */
    @PreAuthorize("@ss.hasPermi('education:selection:list')")
    @GetMapping("/list")
    public TableDataInfo list(EduStudentCourse eduStudentCourse)
    {
        startPage();
        List<EduStudentCourse> list = eduStudentCourseService.selectEduStudentCourseList(eduStudentCourse);
        return getDataTable(list);
    }

    /**
     * 查询我的课程（学生用）
     */
    @GetMapping("/myCourses")
    public TableDataInfo myCourses()
    {
        Long userId = SecurityUtils.getUserId();
        EduStudent student = eduStudentService.selectEduStudentByUserId(userId);
        if (student == null)
        {
            return getDataTable(null);
        }
        startPage();
        List<EduStudentCourse> list = eduStudentCourseService.selectMyCourseList(student.getStudentId());
        return getDataTable(list);
    }

    /**
     * 查询我的成绩（学生用）
     * @param termId 学期ID（可选）
     * @param scoreType 成绩类型：all-全部, pass-通过(>=60), fail-挂科(<60)
     */
    @GetMapping("/myScores")
    public TableDataInfo myScores(Long termId, String scoreType)
    {
        Long userId = SecurityUtils.getUserId();
        EduStudent student = eduStudentService.selectEduStudentByUserId(userId);
        if (student == null)
        {
            return getDataTable(null);
        }
        startPage();
        List<EduStudentCourse> list = eduStudentCourseService.selectMyScoreList(student.getStudentId(), termId, scoreType);
        return getDataTable(list);
    }

    /**
     * 查询某开课的选课学生列表
     */
    @PreAuthorize("@ss.hasPermi('education:selection:list')")
    @GetMapping("/students/{openId}")
    public TableDataInfo studentsByOpening(@PathVariable("openId") Long openId)
    {
        startPage();
        List<EduStudentCourse> list = eduStudentCourseService.selectStudentsByOpenId(openId);
        return getDataTable(list);
    }

    /**
     * 导出选课记录列表
     */
    @PreAuthorize("@ss.hasPermi('education:selection:export')")
    @Log(title = "选课记录", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, EduStudentCourse eduStudentCourse)
    {
        List<EduStudentCourse> list = eduStudentCourseService.selectEduStudentCourseList(eduStudentCourse);
        ExcelUtil<EduStudentCourse> util = new ExcelUtil<EduStudentCourse>(EduStudentCourse.class);
        util.exportExcel(response, list, "选课记录数据");
    }

    /**
     * 获取选课记录详细信息
     */
    @PreAuthorize("@ss.hasPermi('education:selection:query')")
    @GetMapping(value = "/{scId}")
    public AjaxResult getInfo(@PathVariable("scId") Long scId)
    {
        return success(eduStudentCourseService.selectEduStudentCourseByScId(scId));
    }

    /**
     * 学生选课
     */
    @Log(title = "学生选课", businessType = BusinessType.INSERT)
    @PostMapping("/enroll/{openId}")
    public AjaxResult enroll(@PathVariable("openId") Long openId)
    {
        Long userId = SecurityUtils.getUserId();
        EduStudent student = eduStudentService.selectEduStudentByUserId(userId);
        if (student == null)
        {
            return error("您不是学生用户，无法选课");
        }
        return eduStudentCourseService.enrollCourse(student.getStudentId(), openId);
    }

    /**
     * 学生退课
     */
    @Log(title = "学生退课", businessType = BusinessType.DELETE)
    @DeleteMapping("/withdraw/{openId}")
    public AjaxResult withdraw(@PathVariable("openId") Long openId)
    {
        Long userId = SecurityUtils.getUserId();
        EduStudent student = eduStudentService.selectEduStudentByUserId(userId);
        if (student == null)
        {
            return error("您不是学生用户，无法退课");
        }
        return eduStudentCourseService.withdrawCourse(student.getStudentId(), openId);
    }

    /**
     * 新增选课记录（管理员手动添加）
     */
    @PreAuthorize("@ss.hasPermi('education:selection:add')")
    @Log(title = "选课记录", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody EduStudentCourse eduStudentCourse)
    {
        return toAjax(eduStudentCourseService.insertEduStudentCourse(eduStudentCourse));
    }

    /**
     * 修改选课记录（录入成绩）
     */
    @PreAuthorize("@ss.hasPermi('education:selection:edit')")
    @Log(title = "选课记录", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody EduStudentCourse eduStudentCourse)
    {
        return toAjax(eduStudentCourseService.updateEduStudentCourse(eduStudentCourse));
    }

    /**
     * 删除选课记录
     */
    @PreAuthorize("@ss.hasPermi('education:selection:remove')")
    @Log(title = "选课记录", businessType = BusinessType.DELETE)
	@DeleteMapping("/{scIds}")
    public AjaxResult remove(@PathVariable Long[] scIds)
    {
        return toAjax(eduStudentCourseService.deleteEduStudentCourseByScIds(scIds));
    }

    /**
     * 教师查看自己某门课程的学生名单
     */
    @PreAuthorize("@ss.hasPermi('education:teacherStudent:list')")
    @GetMapping("/myStudents/{openId}")
    public TableDataInfo myStudents(@PathVariable("openId") Long openId)
    {
        // 获取当前登录用户
        Long userId = SecurityUtils.getUserId();
        EduTeacher teacher = eduTeacherService.selectEduTeacherByUserId(userId);
        if (teacher == null)
        {
            return getDataTable(Collections.emptyList());
        }
        // 验证是否是自己的课程
        EduCourseOpening opening = eduCourseOpeningService.selectEduCourseOpeningByOpenId(openId);
        if (opening == null || !opening.getTeacherId().equals(teacher.getTeacherId()))
        {
            return getDataTable(Collections.emptyList());
        }
        startPage();
        List<EduStudentCourse> list = eduStudentCourseService.selectStudentsByOpenId(openId);
        return getDataTable(list);
    }

    /**
     * 教师录入学生成绩（支持平时分和考试分）
     */
    @PreAuthorize("@ss.hasPermi('education:score:edit')")
    @Log(title = "教师录入成绩", businessType = BusinessType.UPDATE)
    @PutMapping("/inputScore")
    public AjaxResult inputScore(@RequestBody EduStudentCourse eduStudentCourse)
    {
        // 获取当前登录用户
        Long userId = SecurityUtils.getUserId();
        EduTeacher teacher = eduTeacherService.selectEduTeacherByUserId(userId);
        if (teacher == null)
        {
            return error("您不是教师，无法操作");
        }
        // 获取选课记录对应的开课信息
        EduStudentCourse existing = eduStudentCourseService.selectEduStudentCourseByScId(eduStudentCourse.getScId());
        if (existing == null)
        {
            return error("选课记录不存在");
        }
        // 验证是否是自己的课程
        EduCourseOpening opening = eduCourseOpeningService.selectEduCourseOpeningByOpenId(existing.getOpenId());
        if (opening == null || !opening.getTeacherId().equals(teacher.getTeacherId()))
        {
            return error("无权操作此课程");
        }
        // 计算总成绩：平时成绩 * 40% + 考试成绩 * 60%
        EduStudentCourse updateObj = new EduStudentCourse();
        updateObj.setScId(eduStudentCourse.getScId());
        updateObj.setUsualScore(eduStudentCourse.getUsualScore());
        updateObj.setExamScore(eduStudentCourse.getExamScore());
        if (eduStudentCourse.getUsualScore() != null && eduStudentCourse.getExamScore() != null)
        {
            java.math.BigDecimal totalScore = eduStudentCourse.getUsualScore()
                .multiply(new java.math.BigDecimal("0.4"))
                .add(eduStudentCourse.getExamScore().multiply(new java.math.BigDecimal("0.6")));
            updateObj.setScore(totalScore.setScale(1, java.math.RoundingMode.HALF_UP));
            // 设置状态为已修读
            updateObj.setStatus("1");
        }
        return toAjax(eduStudentCourseService.updateEduStudentCourse(updateObj));
    }

    /**
     * 批量录入成绩
     */
    @PreAuthorize("@ss.hasPermi('education:score:edit')")
    @Log(title = "批量录入成绩", businessType = BusinessType.UPDATE)
    @PutMapping("/batchInputScore")
    public AjaxResult batchInputScore(@RequestBody List<EduStudentCourse> list)
    {
        Long userId = SecurityUtils.getUserId();
        EduTeacher teacher = eduTeacherService.selectEduTeacherByUserId(userId);
        if (teacher == null)
        {
            return error("您不是教师，无法操作");
        }
        int successCount = 0;
        for (EduStudentCourse sc : list)
        {
            EduStudentCourse existing = eduStudentCourseService.selectEduStudentCourseByScId(sc.getScId());
            if (existing == null) continue;
            EduCourseOpening opening = eduCourseOpeningService.selectEduCourseOpeningByOpenId(existing.getOpenId());
            if (opening == null || !opening.getTeacherId().equals(teacher.getTeacherId())) continue;
            
            EduStudentCourse updateObj = new EduStudentCourse();
            updateObj.setScId(sc.getScId());
            updateObj.setUsualScore(sc.getUsualScore());
            updateObj.setExamScore(sc.getExamScore());
            if (sc.getUsualScore() != null && sc.getExamScore() != null)
            {
                java.math.BigDecimal totalScore = sc.getUsualScore()
                    .multiply(new java.math.BigDecimal("0.4"))
                    .add(sc.getExamScore().multiply(new java.math.BigDecimal("0.6")));
                updateObj.setScore(totalScore.setScale(1, java.math.RoundingMode.HALF_UP));
                updateObj.setStatus("1");
            }
            eduStudentCourseService.updateEduStudentCourse(updateObj);
            successCount++;
        }
        return success("成功录入 " + successCount + " 条成绩");
    }

    /**
     * 查询学生的GPA统计
     */
    @GetMapping("/gpa/stats")
    public AjaxResult getGpaStats(Long termId)
    {
        Long userId = SecurityUtils.getUserId();
        EduStudent student = eduStudentService.selectEduStudentByUserId(userId);
        if (student == null)
        {
            return error("学生信息不存在");
        }
        return success(eduStudentCourseService.selectGpaStats(student.getStudentId(), termId));
    }

    /**
     * 查询学生各学期的GPA列表
     */
    @GetMapping("/gpa/termList")
    public AjaxResult getTermGpaList()
    {
        Long userId = SecurityUtils.getUserId();
        EduStudent student = eduStudentService.selectEduStudentByUserId(userId);
        if (student == null)
        {
            return error("学生信息不存在");
        }
        return success(eduStudentCourseService.selectTermGpaList(student.getStudentId()));
    }
}
