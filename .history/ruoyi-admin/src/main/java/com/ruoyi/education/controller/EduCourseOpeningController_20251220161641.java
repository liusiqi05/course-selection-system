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
import com.ruoyi.education.domain.EduCourseOpening;
import com.ruoyi.education.service.IEduCourseOpeningService;
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
     */
    @GetMapping("/available")
    public TableDataInfo availableList(EduCourseOpening eduCourseOpening)
    {
        startPage();
        List<EduCourseOpening> list = eduCourseOpeningService.selectAvailableCourseList(eduCourseOpening);
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
}
