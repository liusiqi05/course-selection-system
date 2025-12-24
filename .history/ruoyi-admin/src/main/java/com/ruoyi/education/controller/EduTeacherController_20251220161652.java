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
import com.ruoyi.education.domain.EduTeacher;
import com.ruoyi.education.service.IEduTeacherService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 教师信息Controller
 * 
 * @author ruoyi
 * @date 2025-12-18
 */
@RestController
@RequestMapping("/education/teacher")
public class EduTeacherController extends BaseController
{
    @Autowired
    private IEduTeacherService eduTeacherService;

    /**
     * 查询教师信息列表
     */
    @PreAuthorize("@ss.hasPermi('education:teacher:list')")
    @GetMapping("/list")
    public TableDataInfo list(EduTeacher eduTeacher)
    {
        startPage();
        List<EduTeacher> list = eduTeacherService.selectEduTeacherList(eduTeacher);
        return getDataTable(list);
    }

    /**
     * 查询所有教师（下拉选择用）
     */
    @GetMapping("/all")
    public AjaxResult all()
    {
        return success(eduTeacherService.selectEduTeacherAll());
    }

    /**
     * 导出教师信息列表
     */
    @PreAuthorize("@ss.hasPermi('education:teacher:export')")
    @Log(title = "教师信息", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, EduTeacher eduTeacher)
    {
        List<EduTeacher> list = eduTeacherService.selectEduTeacherList(eduTeacher);
        ExcelUtil<EduTeacher> util = new ExcelUtil<EduTeacher>(EduTeacher.class);
        util.exportExcel(response, list, "教师信息数据");
    }

    /**
     * 获取教师信息详细信息
     */
    @PreAuthorize("@ss.hasPermi('education:teacher:query')")
    @GetMapping(value = "/{teacherId}")
    public AjaxResult getInfo(@PathVariable("teacherId") Long teacherId)
    {
        return success(eduTeacherService.selectEduTeacherByTeacherId(teacherId));
    }

    /**
     * 获取当前登录教师信息
     */
    @GetMapping(value = "/profile")
    public AjaxResult getProfile()
    {
        Long userId = SecurityUtils.getUserId();
        return success(eduTeacherService.selectEduTeacherByUserId(userId));
    }

    /**
     * 新增教师信息
     */
    @PreAuthorize("@ss.hasPermi('education:teacher:add')")
    @Log(title = "教师信息", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody EduTeacher eduTeacher)
    {
        return toAjax(eduTeacherService.insertEduTeacher(eduTeacher));
    }

    /**
     * 修改教师信息
     */
    @PreAuthorize("@ss.hasPermi('education:teacher:edit')")
    @Log(title = "教师信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody EduTeacher eduTeacher)
    {
        return toAjax(eduTeacherService.updateEduTeacher(eduTeacher));
    }

    /**
     * 删除教师信息
     */
    @PreAuthorize("@ss.hasPermi('education:teacher:remove')")
    @Log(title = "教师信息", businessType = BusinessType.DELETE)
	@DeleteMapping("/{teacherIds}")
    public AjaxResult remove(@PathVariable Long[] teacherIds)
    {
        return toAjax(eduTeacherService.deleteEduTeacherByTeacherIds(teacherIds));
    }
}
