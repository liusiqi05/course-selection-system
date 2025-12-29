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
import com.ruoyi.system.domain.EduStudent;
import com.ruoyi.system.domain.EduTeacher;
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
     * @param termId 学期ID（可选）
     */
    @GetMapping("/myCourses")
    public TableDataInfo myCourses(Long termId)
    {
        Long userId = SecurityUtils.getUserId();
        EduStudent student = eduStudentService.selectEduStudentByUserId(userId);
        if (student == null)
        {
            return getDataTable(Collections.emptyList());
        }
        startPage();
        EduStudentCourse query = new EduStudentCourse();
        query.setStudentId(student.getStudentId());
        query.setTermId(termId);
        List<EduStudentCourse> list = eduStudentCourseService.selectEduStudentCourseList(query);
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
        
        // 检查是否已经提交过成绩，防止重复提交
        if (existing.getScore() != null)
        {
            return error("该学生的成绩已经提交，无法修改");
        }
        
        // 验证是否是自己的课程
        EduCourseOpening opening = eduCourseOpeningService.selectEduCourseOpeningByOpenId(existing.getOpenId());
        if (opening == null || !opening.getTeacherId().equals(teacher.getTeacherId()))
        {
            return error("无权操作此课程");
        }

        // 检查是否超过录入截止时间
        if (opening.getScoreDeadline() != null && new java.util.Date().after(opening.getScoreDeadline()))
        {
            // 只有管理员和教务处老师可以录入
            if (!SecurityUtils.isAdmin(userId) && !SecurityUtils.hasRole("leader"))
            {
                return error("已超过成绩录入截止时间，请联系教务处");
            }
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
        int result = eduStudentCourseService.updateEduStudentCourse(updateObj);
        
        // 更新课程状态：检查该课程是否所有学生都已录入成绩
        if (result > 0)
        {
            updateCourseStatusIfAllScored(opening.getOpenId());
        }
        
        return toAjax(result);
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
        
        Long openIdToUpdate = null;
        int successCount = 0;
        
        for (EduStudentCourse sc : list)
        {
            EduStudentCourse existing = eduStudentCourseService.selectEduStudentCourseByScId(sc.getScId());
            if (existing == null) continue;
            
            // 检查是否已经提交过成绩
            if (existing.getScore() != null)
            {
                continue; // 已提交则跳过
            }
            
            EduCourseOpening opening = eduCourseOpeningService.selectEduCourseOpeningByOpenId(existing.getOpenId());
            if (opening == null || !opening.getTeacherId().equals(teacher.getTeacherId())) continue;

            // 检查是否超过录入截止时间
            if (opening.getScoreDeadline() != null && new java.util.Date().after(opening.getScoreDeadline()))
            {
                // 只有管理员和教务处老师可以录入
                if (!SecurityUtils.isAdmin(userId) && !SecurityUtils.hasRole("leader"))
                {
                    continue; // 跳过该记录
                }
            }
            
            openIdToUpdate = existing.getOpenId();
            
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
        
        // 检查并更新课程状态
        if (successCount > 0 && openIdToUpdate != null)
        {
            updateCourseStatusIfAllScored(openIdToUpdate);
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
    
    /**
     * 检查课程是否所有学生都已录入成绩，如果是则自动更新课程状态
     */
    private void updateCourseStatusIfAllScored(Long openId)
    {
        try
        {
            EduCourseOpening opening = eduCourseOpeningService.selectEduCourseOpeningByOpenId(openId);
            if (opening == null || "1".equals(opening.getStatus()))
            {
                return; // 课程不存在或已结课
            }
            
            // 查询该课程所有学生
            EduStudentCourse query = new EduStudentCourse();
            query.setOpenId(openId);
            List<EduStudentCourse> courseStudents = eduStudentCourseService.selectEduStudentCourseList(query);
            
            if (courseStudents.isEmpty())
            {
                return; // 没有学生
            }
            
            // 检查是否所有学生都有成绩
            boolean allScored = courseStudents.stream().allMatch(s -> s.getScore() != null);
            
            if (allScored)
            {
                // 更新课程状态为已结课
                EduCourseOpening update = new EduCourseOpening();
                update.setOpenId(openId);
                update.setStatus("1");
                update.setPendingCount(0);
                eduCourseOpeningService.updateEduCourseOpening(update);
            }
        }
        catch (Exception e)
        {
            // 记录异常但不影响成绩保存
            logger.error("更新课程状态失败", e);
        }
    }

    /**
     * 管理员修改学生成绩（可以修改已提交的成绩）
     */
    @PreAuthorize("@ss.hasAnyRoles('admin,leader')")
    @Log(title = "管理员修改成绩", businessType = BusinessType.UPDATE)
    @PutMapping("/adminInputScore")
    public AjaxResult adminInputScore(@RequestBody EduStudentCourse eduStudentCourse)
    {
        // 获取选课记录
        EduStudentCourse existing = eduStudentCourseService.selectEduStudentCourseByScId(eduStudentCourse.getScId());
        if (existing == null)
        {
            return error("选课记录不存在");
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
            updateObj.setStatus("1");
        }
        int result = eduStudentCourseService.updateEduStudentCourse(updateObj);
        return toAjax(result);
    }

    /**
     * 导出某门课程的学生名单
     */
    @PreAuthorize("@ss.hasPermi('education:teacherStudent:list')")
    @Log(title = "导出学生名单", businessType = BusinessType.EXPORT)
    @PostMapping("/exportStudents/{openId}")
    public void exportStudents(HttpServletResponse response, @PathVariable("openId") Long openId)
    {
        // 获取当前登录用户
        Long userId = SecurityUtils.getUserId();
        EduTeacher teacher = eduTeacherService.selectEduTeacherByUserId(userId);
        
        // 验证权限：管理员或课程教师
        boolean isAdmin = SecurityUtils.getLoginUser().getUser().isAdmin();
        if (!isAdmin && teacher != null)
        {
            EduCourseOpening opening = eduCourseOpeningService.selectEduCourseOpeningByOpenId(openId);
            if (opening == null || !opening.getTeacherId().equals(teacher.getTeacherId()))
            {
                return; // 无权导出
            }
        }
        
        List<EduStudentCourse> list = eduStudentCourseService.selectStudentsByOpenId(openId);
        ExcelUtil<EduStudentCourse> util = new ExcelUtil<EduStudentCourse>(EduStudentCourse.class);
        util.exportExcel(response, list, "学生名单");
    }

    /**
     * 查询某门课程的挂科学生列表（用于补考成绩录入）
     */
    @PreAuthorize("@ss.hasPermi('education:score:edit')")
    @GetMapping("/failedStudents/{openId}")
    public TableDataInfo failedStudents(@PathVariable("openId") Long openId)
    {
        // 获取当前登录用户
        Long userId = SecurityUtils.getUserId();
        EduTeacher teacher = eduTeacherService.selectEduTeacherByUserId(userId);
        
        // 验证权限：管理员或课程教师
        boolean isAdmin = SecurityUtils.getLoginUser().getUser().isAdmin();
        if (!isAdmin && teacher != null)
        {
            EduCourseOpening opening = eduCourseOpeningService.selectEduCourseOpeningByOpenId(openId);
            if (opening == null || !opening.getTeacherId().equals(teacher.getTeacherId()))
            {
                return getDataTable(Collections.emptyList());
            }
        }
        
        startPage();
        List<EduStudentCourse> list = eduStudentCourseService.selectFailedStudentsByOpenId(openId);
        return getDataTable(list);
    }

    /**
     * 教师录入补考成绩（只能录入一次）
     */
    @PreAuthorize("@ss.hasPermi('education:score:edit')")
    @Log(title = "录入补考成绩", businessType = BusinessType.UPDATE)
    @PutMapping("/inputMakeupScore")
    public AjaxResult inputMakeupScore(@RequestBody EduStudentCourse eduStudentCourse)
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
        
        eduStudentCourse.setUpdateBy(SecurityUtils.getUsername());
        return eduStudentCourseService.submitMakeupScore(eduStudentCourse);
    }

    /**
     * 批量录入补考成绩
     */
    @PreAuthorize("@ss.hasPermi('education:score:edit')")
    @Log(title = "批量录入补考成绩", businessType = BusinessType.UPDATE)
    @PutMapping("/batchInputMakeupScore")
    public AjaxResult batchInputMakeupScore(@RequestBody List<EduStudentCourse> list)
    {
        Long userId = SecurityUtils.getUserId();
        EduTeacher teacher = eduTeacherService.selectEduTeacherByUserId(userId);
        if (teacher == null)
        {
            return error("您不是教师，无法操作");
        }
        
        int successCount = 0;
        int failCount = 0;
        StringBuilder failMsg = new StringBuilder();
        
        for (EduStudentCourse sc : list)
        {
            if (sc.getMakeupScore() == null)
            {
                continue;
            }
            
            EduStudentCourse existing = eduStudentCourseService.selectEduStudentCourseByScId(sc.getScId());
            if (existing == null)
            {
                failCount++;
                continue;
            }
            
            // 验证是否是自己的课程
            EduCourseOpening opening = eduCourseOpeningService.selectEduCourseOpeningByOpenId(existing.getOpenId());
            if (opening == null || !opening.getTeacherId().equals(teacher.getTeacherId()))
            {
                failCount++;
                failMsg.append(existing.getStudentName()).append("(无权操作); ");
                continue;
            }
            
            sc.setUpdateBy(SecurityUtils.getUsername());
            AjaxResult result = eduStudentCourseService.submitMakeupScore(sc);
            if (result.isSuccess())
            {
                successCount++;
            }
            else
            {
                failCount++;
                failMsg.append(existing.getStudentName()).append("(").append(result.get("msg")).append("); ");
            }
        }
        
        if (failCount == 0)
        {
            return success("成功录入" + successCount + "条补考成绩");
        }
        else
        {
            return success("成功" + successCount + "条，失败" + failCount + "条。" + failMsg.toString());
        }
    }
}
