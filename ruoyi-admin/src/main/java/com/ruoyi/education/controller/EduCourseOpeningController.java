package com.ruoyi.education.controller;

import java.util.List;
import java.util.LinkedHashMap;
import java.util.function.Function;
import java.util.stream.Collectors;
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
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.education.domain.EduCourseOpening;
import com.ruoyi.system.domain.EduTeacher;
import com.ruoyi.system.domain.EduStudent;
import com.ruoyi.education.service.IEduCourseOpeningService;
import com.ruoyi.education.service.IEduTeacherService;
import com.ruoyi.education.service.IEduStudentService;
import com.ruoyi.education.mapper.EduStudentCourseMapper;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 开课安排Controller
 * 
 * @author ruoyi
 * @date 2025-12-18
 */
@RestController
@RequestMapping("/education/opening")
public class EduCourseOpeningController extends BaseController
{
    @Autowired
    private IEduCourseOpeningService eduCourseOpeningService;

    @Autowired
    private IEduTeacherService eduTeacherService;

    @Autowired
    private IEduStudentService eduStudentService;

    @Autowired
    private EduStudentCourseMapper eduStudentCourseMapper;

    /**
     * 查询开课安排列表
     */
    @PreAuthorize("@ss.hasPermi('education:opening:list')")
    @GetMapping("/list")
    public TableDataInfo list(EduCourseOpening eduCourseOpening)
    {
        startPage();
        List<EduCourseOpening> list = eduCourseOpeningService.selectEduCourseOpeningList(eduCourseOpening);
        return getDataTable(list);
    }

    /**
     * 查询可选课程列表（学生选课用）
     * 过滤掉学生已选的同名课程
     */
    @GetMapping("/available")
    public TableDataInfo availableList(EduCourseOpening eduCourseOpening)
    {
        startPage();
        List<EduCourseOpening> list = eduCourseOpeningService.selectAvailableCourseList(eduCourseOpening);
        // 以 openId 去重，避免任何意外重复
        list = new java.util.ArrayList<>(
            list.stream().collect(
                java.util.stream.Collectors.toMap(
                    EduCourseOpening::getOpenId,
                    Function.identity(),
                    (a, b) -> a,
                    LinkedHashMap::new
                )
            ).values()
        );
        
        // 获取当前学生已选的课程名称列表，过滤掉同名课程
        Long userId = SecurityUtils.getUserId();
        EduStudent student = eduStudentService.selectEduStudentByUserId(userId);
        if (student != null && eduCourseOpening.getTermId() != null) {
            List<String> selectedCourseNames = eduStudentCourseMapper.selectSelectedCourseNames(
                student.getStudentId(), eduCourseOpening.getTermId());
            if (selectedCourseNames != null && !selectedCourseNames.isEmpty()) {
                list = list.stream()
                    .filter(course -> !selectedCourseNames.contains(course.getCourseName()))
                    .collect(Collectors.toList());
            }
        }
        
        return getDataTable(list);
    }

    /**
     * 导出开课安排列表
     */
    @PreAuthorize("@ss.hasPermi('education:opening:export')")
    @Log(title = "开课安排", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, EduCourseOpening eduCourseOpening)
    {
        List<EduCourseOpening> list = eduCourseOpeningService.selectEduCourseOpeningList(eduCourseOpening);
        ExcelUtil<EduCourseOpening> util = new ExcelUtil<EduCourseOpening>(EduCourseOpening.class);
        util.exportExcel(response, list, "开课安排数据");
    }

    /**
     * 获取开课安排详细信息
     */
    @PreAuthorize("@ss.hasPermi('education:opening:query')")
    @GetMapping(value = "/{openId}")
    public AjaxResult getInfo(@PathVariable("openId") Long openId)
    {
        return success(eduCourseOpeningService.selectEduCourseOpeningByOpenId(openId));
    }

    /**
     * 新增开课安排
     */
    @PreAuthorize("@ss.hasPermi('education:opening:add')")
    @Log(title = "开课安排", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody EduCourseOpening eduCourseOpening)
    {
        return toAjax(eduCourseOpeningService.insertEduCourseOpening(eduCourseOpening));
    }

    /**
     * 修改开课安排
     */
    @PreAuthorize("@ss.hasPermi('education:opening:edit')")
    @Log(title = "开课安排", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody EduCourseOpening eduCourseOpening)
    {
        return toAjax(eduCourseOpeningService.updateEduCourseOpening(eduCourseOpening));
    }

    /**
     * 删除开课安排
     */
    @PreAuthorize("@ss.hasPermi('education:opening:remove')")
    @Log(title = "开课安排", businessType = BusinessType.DELETE)
	@DeleteMapping("/{openIds}")
    public AjaxResult remove(@PathVariable Long[] openIds)
    {
        return toAjax(eduCourseOpeningService.deleteEduCourseOpeningByOpenIds(openIds));
    }

    /**
     * 查询教师自己的开课列表（我的课程，包含待录入成绩人数）
     */
    @GetMapping("/myCourses")
    public TableDataInfo myCourseList(EduCourseOpening eduCourseOpening)
    {
        // 获取当前登录用户
        Long userId = SecurityUtils.getUserId();
        // 根据userId获取teacherId
        EduTeacher teacher = eduTeacherService.selectEduTeacherByUserId(userId);
        if (teacher == null)
        {
            return getDataTable(java.util.Collections.emptyList());
        }
        eduCourseOpening.setTeacherId(teacher.getTeacherId());
        startPage();
        List<EduCourseOpening> list = eduCourseOpeningService.selectTeacherCoursesWithPending(eduCourseOpening);
        return getDataTable(list);
    }

    /**
     * 教师修改自己的开课信息（只能改上课时间、地点和成绩比例）
     */
    @PreAuthorize("@ss.hasPermi('education:teacherCourse:edit')")
    @Log(title = "教师修改课程", businessType = BusinessType.UPDATE)
    @PutMapping("/updateMyCourse")
    public AjaxResult updateMyCourse(@RequestBody EduCourseOpening eduCourseOpening)
    {
        // 获取当前登录用户
        Long userId = SecurityUtils.getUserId();
        EduTeacher teacher = eduTeacherService.selectEduTeacherByUserId(userId);
        if (teacher == null)
        {
            return error("您不是教师，无法操作");
        }
        // 验证是否是自己的课程
        EduCourseOpening existing = eduCourseOpeningService.selectEduCourseOpeningByOpenId(eduCourseOpening.getOpenId());
        if (existing == null || !existing.getTeacherId().equals(teacher.getTeacherId()))
        {
            return error("无权修改此课程");
        }
        // 验证成绩比例之和必须等于1
        boolean ratioChanged = false;
        if (eduCourseOpening.getUsualRatio() != null && eduCourseOpening.getExamRatio() != null)
        {
            java.math.BigDecimal sum = eduCourseOpening.getUsualRatio().add(eduCourseOpening.getExamRatio());
            if (sum.compareTo(java.math.BigDecimal.ONE) != 0)
            {
                return error("平时成绩占比和期末成绩占比之和必须等于100%");
            }
            // 检查比例是否有变化
            java.math.BigDecimal oldUsualRatio = existing.getUsualRatio() != null ? existing.getUsualRatio() : new java.math.BigDecimal("0.40");
            java.math.BigDecimal oldExamRatio = existing.getExamRatio() != null ? existing.getExamRatio() : new java.math.BigDecimal("0.60");
            if (eduCourseOpening.getUsualRatio().compareTo(oldUsualRatio) != 0 
                || eduCourseOpening.getExamRatio().compareTo(oldExamRatio) != 0)
            {
                ratioChanged = true;
            }
        }
        // 允许修改上课时间、地点、成绩录入截止日期和成绩比例
        EduCourseOpening updateObj = new EduCourseOpening();
        updateObj.setOpenId(eduCourseOpening.getOpenId());
        updateObj.setClassTime(eduCourseOpening.getClassTime());
        updateObj.setClassLocation(eduCourseOpening.getClassLocation());
        updateObj.setScoreDeadline(eduCourseOpening.getScoreDeadline());
        updateObj.setUsualRatio(eduCourseOpening.getUsualRatio());
        updateObj.setExamRatio(eduCourseOpening.getExamRatio());
        int result = eduCourseOpeningService.updateEduCourseOpening(updateObj);
        
        // 如果成绩比例改变，调用存储过程重新计算所有学生成绩以保持数据一致性
        if (ratioChanged && result > 0)
        {
            eduCourseOpeningService.recalcCourseScores(eduCourseOpening.getOpenId());
        }
        return toAjax(result);
    }

    /**
     * 获取教师待打分的课程列表（已结课但有学生未打分的课程）
     */
    @PreAuthorize("@ss.hasPermi('education:teacherCourse:list')")
    @GetMapping("/pendingScore")
    public AjaxResult getPendingScoreCourses()
    {
        Long userId = SecurityUtils.getUserId();
        EduTeacher teacher = eduTeacherService.selectEduTeacherByUserId(userId);
        if (teacher == null)
        {
            return success(java.util.Collections.emptyList());
        }
        List<EduCourseOpening> list = eduCourseOpeningService.selectPendingScoreCourses(teacher.getTeacherId());
        return success(list);
    }

    /**
     * 管理员查询学期所有课程列表（含待录入人数，用于成绩管理）
     */
    @PreAuthorize("@ss.hasAnyRoles('admin,leader')")
    @GetMapping("/termCourses/{termId}")
    public TableDataInfo getTermCourses(@PathVariable("termId") Long termId)
    {
        startPage();
        List<EduCourseOpening> list = eduCourseOpeningService.selectTermCoursesWithPending(termId);
        return getDataTable(list);
    }

    /**
     * 管理员设置课程成绩录入截止日期
     */
    @PreAuthorize("@ss.hasAnyRoles('admin,leader')")
    @Log(title = "设置成绩截止日期", businessType = BusinessType.UPDATE)
    @PutMapping("/setDeadline")
    public AjaxResult setScoreDeadline(@RequestBody EduCourseOpening eduCourseOpening)
    {
        EduCourseOpening updateObj = new EduCourseOpening();
        updateObj.setOpenId(eduCourseOpening.getOpenId());
        updateObj.setScoreDeadline(eduCourseOpening.getScoreDeadline());
        return toAjax(eduCourseOpeningService.updateEduCourseOpening(updateObj));
    }

    /**
     * 管理员批量设置课程成绩录入截止日期
     */
    @PreAuthorize("@ss.hasAnyRoles('admin,leader')")
    @Log(title = "批量设置成绩截止日期", businessType = BusinessType.UPDATE)
    @PutMapping("/batchSetDeadline")
    public AjaxResult batchSetScoreDeadline(@RequestBody List<EduCourseOpening> list)
    {
        int count = 0;
        for (EduCourseOpening course : list)
        {
            EduCourseOpening updateObj = new EduCourseOpening();
            updateObj.setOpenId(course.getOpenId());
            updateObj.setScoreDeadline(course.getScoreDeadline());
            count += eduCourseOpeningService.updateEduCourseOpening(updateObj);
        }
        return success("成功设置 " + count + " 门课程的截止日期");
    }

    /**
     * 教师结课操作（结课后学生才能评价）
     */
    @PreAuthorize("@ss.hasPermi('education:teacherCourse:edit')")
    @Log(title = "课程结课", businessType = BusinessType.UPDATE)
    @PutMapping("/finish/{openId}")
    public AjaxResult finishCourse(@PathVariable("openId") Long openId)
    {
        // 获取当前登录用户
        Long userId = SecurityUtils.getUserId();
        EduTeacher teacher = eduTeacherService.selectEduTeacherByUserId(userId);
        if (teacher == null)
        {
            return error("您不是教师，无法操作");
        }
        // 验证是否是自己的课程
        EduCourseOpening existing = eduCourseOpeningService.selectEduCourseOpeningByOpenId(openId);
        if (existing == null || !existing.getTeacherId().equals(teacher.getTeacherId()))
        {
            return error("无权操作此课程");
        }
        // 检查是否已结课（status='1'表示已结课）
        if ("1".equals(existing.getStatus()))
        {
            return error("该课程已经结课");
        }
        return toAjax(eduCourseOpeningService.finishCourse(openId));
    }

    /**
     * 教师取消结课
     */
    @PreAuthorize("@ss.hasPermi('education:teacherCourse:edit')")
    @Log(title = "取消结课", businessType = BusinessType.UPDATE)
    @PutMapping("/cancelFinish/{openId}")
    public AjaxResult cancelFinishCourse(@PathVariable("openId") Long openId)
    {
        // 获取当前登录用户
        Long userId = SecurityUtils.getUserId();
        EduTeacher teacher = eduTeacherService.selectEduTeacherByUserId(userId);
        if (teacher == null)
        {
            return error("您不是教师，无法操作");
        }
        // 验证是否是自己的课程
        EduCourseOpening existing = eduCourseOpeningService.selectEduCourseOpeningByOpenId(openId);
        if (existing == null || !existing.getTeacherId().equals(teacher.getTeacherId()))
        {
            return error("无权操作此课程");
        }
        // 检查是否已结课（status='1'表示已结课）
        if (!"1".equals(existing.getStatus()))
        {
            return error("该课程尚未结课");
        }
        return toAjax(eduCourseOpeningService.cancelFinishCourse(openId));
    }
}
