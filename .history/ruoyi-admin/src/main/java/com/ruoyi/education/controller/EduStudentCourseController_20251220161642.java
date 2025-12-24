package com.ruoyi.education.controller;

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
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.education.domain.EduStudent;
import com.ruoyi.education.domain.EduStudentCourse;
import com.ruoyi.education.service.IEduStudentService;
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
}
