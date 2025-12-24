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
import com.ruoyi.education.domain.EduCourse;
import com.ruoyi.education.service.IEduCourseService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 课程信息Controller
 * 
 * @author ruoyi
 * @date 2025-12-18
 */
@RestController
@RequestMapping("/education/course")
public class EduCourseController extends BaseController
{
    @Autowired
    private IEduCourseService eduCourseService;

    /**
     * 查询课程信息列表
     */
    @PreAuthorize("@ss.hasPermi('education:course:list')")
    @GetMapping("/list")
    public TableDataInfo list(EduCourse eduCourse)
    {
        startPage();
        List<EduCourse> list = eduCourseService.selectEduCourseList(eduCourse);
        return getDataTable(list);
    }

    /**
     * 查询所有课程（下拉选择用）
     */
    @GetMapping("/all")
    public AjaxResult all()
    {
        return success(eduCourseService.selectEduCourseAll());
    }

    /**
     * 导出课程信息列表
     */
    @PreAuthorize("@ss.hasPermi('education:course:export')")
    @Log(title = "课程信息", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, EduCourse eduCourse)
    {
        List<EduCourse> list = eduCourseService.selectEduCourseList(eduCourse);
        ExcelUtil<EduCourse> util = new ExcelUtil<EduCourse>(EduCourse.class);
        util.exportExcel(response, list, "课程信息数据");
    }

    /**
     * 获取课程信息详细信息
     */
    @PreAuthorize("@ss.hasPermi('education:course:query')")
    @GetMapping(value = "/{courseId}")
    public AjaxResult getInfo(@PathVariable("courseId") Long courseId)
    {
        return success(eduCourseService.selectEduCourseByCourseId(courseId));
    }

    /**
     * 新增课程信息
     */
    @PreAuthorize("@ss.hasPermi('education:course:add')")
    @Log(title = "课程信息", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody EduCourse eduCourse)
    {
        if (!eduCourseService.checkCourseCodeUnique(eduCourse))
        {
            return error("新增课程'" + eduCourse.getCourseName() + "'失败，课程代码已存在");
        }
        return toAjax(eduCourseService.insertEduCourse(eduCourse));
    }

    /**
     * 修改课程信息
     */
    @PreAuthorize("@ss.hasPermi('education:course:edit')")
    @Log(title = "课程信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody EduCourse eduCourse)
    {
        if (!eduCourseService.checkCourseCodeUnique(eduCourse))
        {
            return error("修改课程'" + eduCourse.getCourseName() + "'失败，课程代码已存在");
        }
        return toAjax(eduCourseService.updateEduCourse(eduCourse));
    }

    /**
     * 删除课程信息
     */
    @PreAuthorize("@ss.hasPermi('education:course:remove')")
    @Log(title = "课程信息", businessType = BusinessType.DELETE)
	@DeleteMapping("/{courseIds}")
    public AjaxResult remove(@PathVariable Long[] courseIds)
    {
        return toAjax(eduCourseService.deleteEduCourseByCourseIds(courseIds));
    }
}
