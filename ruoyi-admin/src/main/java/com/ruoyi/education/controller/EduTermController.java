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
import com.ruoyi.education.domain.EduTerm;
import com.ruoyi.education.service.IEduTermService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 学期信息Controller
 * 
 * @author ruoyi
 * @date 2025-12-18
 */
@RestController
@RequestMapping("/education/term")
public class EduTermController extends BaseController
{
    @Autowired
    private IEduTermService eduTermService;

    /**
     * 查询学期信息列表
     */
    @PreAuthorize("@ss.hasPermi('education:term:list')")
    @GetMapping("/list")
    public TableDataInfo list(EduTerm eduTerm)
    {
        startPage();
        List<EduTerm> list = eduTermService.selectEduTermList(eduTerm);
        return getDataTable(list);
    }

    /**
     * 导出学期信息列表
     */
    @PreAuthorize("@ss.hasPermi('education:term:export')")
    @Log(title = "学期信息", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, EduTerm eduTerm)
    {
        List<EduTerm> list = eduTermService.selectEduTermList(eduTerm);
        ExcelUtil<EduTerm> util = new ExcelUtil<EduTerm>(EduTerm.class);
        util.exportExcel(response, list, "学期信息数据");
    }

    /**
     * 获取学期信息详细信息
     */
    @PreAuthorize("@ss.hasPermi('education:term:query')")
    @GetMapping(value = "/{termId}")
    public AjaxResult getInfo(@PathVariable("termId") Long termId)
    {
        return success(eduTermService.selectEduTermByTermId(termId));
    }

    /**
     * 获取当前学期
     */
    @GetMapping(value = "/current")
    public AjaxResult getCurrentTerm()
    {
        return success(eduTermService.selectCurrentTerm());
    }

    /**
     * 获取学期选项列表（不需要权限，用于下拉选择）
     */
    @GetMapping("/options")
    public TableDataInfo options()
    {
        List<EduTerm> list = eduTermService.selectEduTermList(new EduTerm());
        return getDataTable(list);
    }

    /**
     * 新增学期信息
     */
    @PreAuthorize("@ss.hasPermi('education:term:add')")
    @Log(title = "学期信息", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody EduTerm eduTerm)
    {
        return toAjax(eduTermService.insertEduTerm(eduTerm));
    }

    /**
     * 修改学期信息
     */
    @PreAuthorize("@ss.hasPermi('education:term:edit')")
    @Log(title = "学期信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody EduTerm eduTerm)
    {
        return toAjax(eduTermService.updateEduTerm(eduTerm));
    }

    /**
     * 删除学期信息
     */
    @PreAuthorize("@ss.hasPermi('education:term:remove')")
    @Log(title = "学期信息", businessType = BusinessType.DELETE)
	@DeleteMapping("/{termIds}")
    public AjaxResult remove(@PathVariable Long[] termIds)
    {
        return toAjax(eduTermService.deleteEduTermByTermIds(termIds));
    }
}
