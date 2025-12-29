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
import com.ruoyi.education.domain.EduCourseApply;
import com.ruoyi.system.domain.EduTeacher;
import com.ruoyi.education.service.IEduCourseApplyService;
import com.ruoyi.education.service.IEduTeacherService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 开课申请Controller
 * 
 * @author ruoyi
 * @date 2025-01-09
 */
@RestController
@RequestMapping("/education/apply")
public class EduCourseApplyController extends BaseController
{
    @Autowired
    private IEduCourseApplyService eduCourseApplyService;

    @Autowired
    private IEduTeacherService eduTeacherService;

    /**
     * 查询开课申请列表（管理员用）
     */
    @PreAuthorize("@ss.hasPermi('education:apply:list')")
    @GetMapping("/list")
    public TableDataInfo list(EduCourseApply eduCourseApply)
    {
        startPage();
        List<EduCourseApply> list = eduCourseApplyService.selectEduCourseApplyList(eduCourseApply);
        return getDataTable(list);
    }

    /**
     * 查询我的开课申请列表（教师用）
     */
    @GetMapping("/myList")
    public TableDataInfo myList(EduCourseApply eduCourseApply)
    {
        // 获取当前登录用户的教师ID
        Long userId = SecurityUtils.getUserId();
        EduTeacher teacher = eduTeacherService.selectEduTeacherByUserId(userId);
        if (teacher == null) {
            return getDataTable(null);
        }
        
        eduCourseApply.setTeacherId(teacher.getTeacherId());
        startPage();
        List<EduCourseApply> list = eduCourseApplyService.selectEduCourseApplyList(eduCourseApply);
        return getDataTable(list);
    }

    /**
     * 导出开课申请列表
     */
    @PreAuthorize("@ss.hasPermi('education:apply:export')")
    @Log(title = "开课申请", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, EduCourseApply eduCourseApply)
    {
        List<EduCourseApply> list = eduCourseApplyService.selectEduCourseApplyList(eduCourseApply);
        ExcelUtil<EduCourseApply> util = new ExcelUtil<EduCourseApply>(EduCourseApply.class);
        util.exportExcel(response, list, "开课申请数据");
    }

    /**
     * 获取开课申请详细信息
     */
    @GetMapping(value = "/{applyId}")
    public AjaxResult getInfo(@PathVariable("applyId") Long applyId)
    {
        return success(eduCourseApplyService.selectEduCourseApplyByApplyId(applyId));
    }

    /**
     * 新增开课申请（教师用）
     */
    @Log(title = "开课申请", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody EduCourseApply eduCourseApply)
    {
        // 获取当前登录用户的教师ID
        Long userId = SecurityUtils.getUserId();
        EduTeacher teacher = eduTeacherService.selectEduTeacherByUserId(userId);
        if (teacher == null) {
            return error("您不是教师，无法提交开课申请");
        }
        
        eduCourseApply.setTeacherId(teacher.getTeacherId());
        eduCourseApply.setCreateBy(SecurityUtils.getUsername());
        return toAjax(eduCourseApplyService.insertEduCourseApply(eduCourseApply));
    }

    /**
     * 修改开课申请（只能修改待审批的申请）
     */
    @Log(title = "开课申请", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody EduCourseApply eduCourseApply)
    {
        // 检查申请是否属于当前教师
        Long userId = SecurityUtils.getUserId();
        EduTeacher teacher = eduTeacherService.selectEduTeacherByUserId(userId);
        EduCourseApply existApply = eduCourseApplyService.selectEduCourseApplyByApplyId(eduCourseApply.getApplyId());
        
        if (existApply == null) {
            return error("申请不存在");
        }
        
        // 只有待审批状态才能修改
        if (!"0".equals(existApply.getStatus())) {
            return error("只能修改待审批的申请");
        }
        
        // 检查是否是本人的申请（管理员除外）
        if (teacher != null && !existApply.getTeacherId().equals(teacher.getTeacherId())) {
            return error("您只能修改自己的申请");
        }
        
        eduCourseApply.setUpdateBy(SecurityUtils.getUsername());
        return toAjax(eduCourseApplyService.updateEduCourseApply(eduCourseApply));
    }

    /**
     * 审批开课申请（管理员用）
     */
    @PreAuthorize("@ss.hasPermi('education:apply:approve')")
    @Log(title = "开课申请审批", businessType = BusinessType.UPDATE)
    @PutMapping("/approve")
    public AjaxResult approve(@RequestBody EduCourseApply eduCourseApply)
    {
        return toAjax(eduCourseApplyService.approveEduCourseApply(
            eduCourseApply.getApplyId(), 
            eduCourseApply.getStatus(), 
            eduCourseApply.getRejectReason()
        ));
    }

    /**
     * 批量审批开课申请（管理员用）
     */
    @PreAuthorize("@ss.hasPermi('education:apply:approve')")
    @Log(title = "开课申请批量审批", businessType = BusinessType.UPDATE)
    @PutMapping("/batchApprove/{status}")
    public AjaxResult batchApprove(@PathVariable String status, @RequestBody Long[] applyIds)
    {
        return toAjax(eduCourseApplyService.batchApproveEduCourseApply(applyIds, status));
    }

    /**
     * 删除开课申请（只能删除待审批的申请）
     */
    @Log(title = "开课申请", businessType = BusinessType.DELETE)
	@DeleteMapping("/{applyIds}")
    public AjaxResult remove(@PathVariable Long[] applyIds)
    {
        return toAjax(eduCourseApplyService.deleteEduCourseApplyByApplyIds(applyIds));
    }

    /**
     * 将已通过的申请转换为开课安排（管理员用）
     */
    @PreAuthorize("@ss.hasPermi('education:apply:convert')")
    @Log(title = "开课申请转换", businessType = BusinessType.UPDATE)
    @PostMapping("/convert/{termId}")
    public AjaxResult convert(@PathVariable Long termId)
    {
        int count = eduCourseApplyService.convertApprovedToOpening(termId);
        return success("成功转换 " + count + " 个开课申请");
    }
}
