package com.ruoyi.education.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.education.mapper.EduCourseApplyMapper;
import com.ruoyi.education.mapper.EduCourseOpeningMapper;
import com.ruoyi.education.mapper.EduCourseMapper;
import com.ruoyi.education.domain.EduCourseApply;
import com.ruoyi.education.domain.EduCourseOpening;
import com.ruoyi.education.domain.EduCourse;
import com.ruoyi.education.service.IEduCourseApplyService;

/**
 * 开课申请Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-01-09
 */
@Service
public class EduCourseApplyServiceImpl implements IEduCourseApplyService 
{
    @Autowired
    private EduCourseApplyMapper eduCourseApplyMapper;

    @Autowired
    private EduCourseOpeningMapper eduCourseOpeningMapper;

    @Autowired
    private EduCourseMapper eduCourseMapper;

    /**
     * 查询开课申请
     * 
     * @param applyId 开课申请主键
     * @return 开课申请
     */
    @Override
    public EduCourseApply selectEduCourseApplyByApplyId(Long applyId)
    {
        return eduCourseApplyMapper.selectEduCourseApplyByApplyId(applyId);
    }

    /**
     * 查询开课申请列表
     * 
     * @param eduCourseApply 开课申请
     * @return 开课申请
     */
    @Override
    public List<EduCourseApply> selectEduCourseApplyList(EduCourseApply eduCourseApply)
    {
        return eduCourseApplyMapper.selectEduCourseApplyList(eduCourseApply);
    }

    /**
     * 查询教师的开课申请列表
     * 
     * @param teacherId 教师ID
     * @return 开课申请集合
     */
    @Override
    public List<EduCourseApply> selectEduCourseApplyByTeacherId(Long teacherId)
    {
        return eduCourseApplyMapper.selectEduCourseApplyByTeacherId(teacherId);
    }

    /**
     * 查询某学期的已通过申请列表
     * 
     * @param termId 学期ID
     * @return 开课申请集合
     */
    @Override
    public List<EduCourseApply> selectApprovedApplyByTermId(Long termId)
    {
        return eduCourseApplyMapper.selectApprovedApplyByTermId(termId);
    }

    /**
     * 新增开课申请
     * 
     * @param eduCourseApply 开课申请
     * @return 结果
     */
    @Override
    public int insertEduCourseApply(EduCourseApply eduCourseApply)
    {
        eduCourseApply.setCreateTime(DateUtils.getNowDate());
        eduCourseApply.setStatus("0"); // 待审批
        return eduCourseApplyMapper.insertEduCourseApply(eduCourseApply);
    }

    /**
     * 修改开课申请
     * 
     * @param eduCourseApply 开课申请
     * @return 结果
     */
    @Override
    public int updateEduCourseApply(EduCourseApply eduCourseApply)
    {
        eduCourseApply.setUpdateTime(DateUtils.getNowDate());
        return eduCourseApplyMapper.updateEduCourseApply(eduCourseApply);
    }

    /**
     * 审批开课申请
     * 
     * @param applyId 申请ID
     * @param status 审批状态
     * @param rejectReason 拒绝原因
     * @return 结果
     */
    @Override
    public int approveEduCourseApply(Long applyId, String status, String rejectReason)
    {
        String approveBy = SecurityUtils.getUsername();
        return eduCourseApplyMapper.approveEduCourseApply(applyId, status, rejectReason, approveBy);
    }

    /**
     * 批量审批开课申请
     * 
     * @param applyIds 申请ID数组
     * @param status 审批状态
     * @return 结果
     */
    @Override
    public int batchApproveEduCourseApply(Long[] applyIds, String status)
    {
        String approveBy = SecurityUtils.getUsername();
        return eduCourseApplyMapper.batchApproveEduCourseApply(applyIds, status, approveBy);
    }

    /**
     * 批量删除开课申请
     * 
     * @param applyIds 需要删除的开课申请主键
     * @return 结果
     */
    @Override
    public int deleteEduCourseApplyByApplyIds(Long[] applyIds)
    {
        return eduCourseApplyMapper.deleteEduCourseApplyByApplyIds(applyIds);
    }

    /**
     * 删除开课申请信息
     * 
     * @param applyId 开课申请主键
     * @return 结果
     */
    @Override
    public int deleteEduCourseApplyByApplyId(Long applyId)
    {
        return eduCourseApplyMapper.deleteEduCourseApplyByApplyId(applyId);
    }

    /**
     * 将已通过的申请转换为开课安排
     * 
     * @param termId 学期ID
     * @return 转换的数量
     */
    @Override
    @Transactional
    public int convertApprovedToOpening(Long termId)
    {
        List<EduCourseApply> approvedList = eduCourseApplyMapper.selectApprovedApplyByTermId(termId);
        int count = 0;
        
        for (EduCourseApply apply : approvedList)
        {
            // 如果申请中没有课程ID，需要先创建课程
            Long courseId = apply.getCourseId();
            if (courseId == null && apply.getCourseCode() != null)
            {
                // 检查课程代码是否已存在
                EduCourse existCourse = eduCourseMapper.checkCourseCodeUnique(apply.getCourseCode());
                if (existCourse != null)
                {
                    courseId = existCourse.getCourseId();
                }
                else
                {
                    // 创建新课程
                    EduCourse newCourse = new EduCourse();
                    newCourse.setCourseCode(apply.getCourseCode());
                    newCourse.setCourseName(apply.getCourseName());
                    newCourse.setCredit(apply.getCredit());
                    newCourse.setCourseType(apply.getCourseType());
                    newCourse.setDescription(apply.getDescription());
                    newCourse.setStatus("0"); // 正常状态
                    newCourse.setCreateBy(SecurityUtils.getUsername());
                    newCourse.setCreateTime(DateUtils.getNowDate());
                    eduCourseMapper.insertEduCourse(newCourse);
                    courseId = newCourse.getCourseId();
                }
            }
            
            // 创建开课安排
            EduCourseOpening opening = new EduCourseOpening();
            opening.setTermId(apply.getTermId());
            opening.setCourseId(courseId);
            opening.setTeacherId(apply.getTeacherId());
            opening.setClassTime(apply.getClassTime());
            opening.setClassLocation(apply.getClassLocation());
            opening.setMaxStudents(apply.getMaxStudents());
            opening.setSelectedNum(0);
            opening.setStatus("0"); // 进行中
            opening.setCreateBy(SecurityUtils.getUsername());
            opening.setCreateTime(DateUtils.getNowDate());
            
            eduCourseOpeningMapper.insertEduCourseOpening(opening);
            count++;
        }
        
        return count;
    }
}
