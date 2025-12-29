package com.ruoyi.education.service;

import java.util.List;
import com.ruoyi.education.domain.EduCourseApply;

/**
 * 开课申请Service接口
 * 
 * @author ruoyi
 * @date 2025-01-09
 */
public interface IEduCourseApplyService 
{
    /**
     * 查询开课申请
     * 
     * @param applyId 开课申请主键
     * @return 开课申请
     */
    public EduCourseApply selectEduCourseApplyByApplyId(Long applyId);

    /**
     * 查询开课申请列表
     * 
     * @param eduCourseApply 开课申请
     * @return 开课申请集合
     */
    public List<EduCourseApply> selectEduCourseApplyList(EduCourseApply eduCourseApply);

    /**
     * 查询教师的开课申请列表
     * 
     * @param teacherId 教师ID
     * @return 开课申请集合
     */
    public List<EduCourseApply> selectEduCourseApplyByTeacherId(Long teacherId);

    /**
     * 查询某学期的已通过申请列表
     * 
     * @param termId 学期ID
     * @return 开课申请集合
     */
    public List<EduCourseApply> selectApprovedApplyByTermId(Long termId);

    /**
     * 新增开课申请
     * 
     * @param eduCourseApply 开课申请
     * @return 结果
     */
    public int insertEduCourseApply(EduCourseApply eduCourseApply);

    /**
     * 修改开课申请
     * 
     * @param eduCourseApply 开课申请
     * @return 结果
     */
    public int updateEduCourseApply(EduCourseApply eduCourseApply);

    /**
     * 审批开课申请
     * 
     * @param applyId 申请ID
     * @param status 审批状态
     * @param rejectReason 拒绝原因
     * @return 结果
     */
    public int approveEduCourseApply(Long applyId, String status, String rejectReason);

    /**
     * 批量审批开课申请
     * 
     * @param applyIds 申请ID数组
     * @param status 审批状态
     * @return 结果
     */
    public int batchApproveEduCourseApply(Long[] applyIds, String status);

    /**
     * 批量删除开课申请
     * 
     * @param applyIds 需要删除的开课申请主键集合
     * @return 结果
     */
    public int deleteEduCourseApplyByApplyIds(Long[] applyIds);

    /**
     * 删除开课申请信息
     * 
     * @param applyId 开课申请主键
     * @return 结果
     */
    public int deleteEduCourseApplyByApplyId(Long applyId);

    /**
     * 将已通过的申请转换为开课安排
     * 
     * @param termId 学期ID
     * @return 转换的数量
     */
    public int convertApprovedToOpening(Long termId);
}
