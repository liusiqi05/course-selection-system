package com.ruoyi.education.mapper;

import java.util.List;
import com.ruoyi.education.domain.EduCourseApply;
import org.apache.ibatis.annotations.Param;

/**
 * 开课申请Mapper接口
 * 
 * @author ruoyi
 * @date 2025-01-09
 */
public interface EduCourseApplyMapper 
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
     * 统计某学期待审批的申请数量
     * 
     * @param termId 学期ID
     * @return 数量
     */
    public int countPendingApplyByTermId(Long termId);

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
     * @param approveBy 审批人
     * @return 结果
     */
    public int approveEduCourseApply(@Param("applyId") Long applyId, 
                                      @Param("status") String status, 
                                      @Param("rejectReason") String rejectReason,
                                      @Param("approveBy") String approveBy);

    /**
     * 批量审批开课申请
     * 
     * @param applyIds 申请ID数组
     * @param status 审批状态
     * @param approveBy 审批人
     * @return 结果
     */
    public int batchApproveEduCourseApply(@Param("applyIds") Long[] applyIds, 
                                           @Param("status") String status,
                                           @Param("approveBy") String approveBy);

    /**
     * 删除开课申请
     * 
     * @param applyId 开课申请主键
     * @return 结果
     */
    public int deleteEduCourseApplyByApplyId(Long applyId);

    /**
     * 批量删除开课申请
     * 
     * @param applyIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteEduCourseApplyByApplyIds(Long[] applyIds);
}
