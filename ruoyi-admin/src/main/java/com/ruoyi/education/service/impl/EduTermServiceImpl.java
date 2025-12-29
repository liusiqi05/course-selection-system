package com.ruoyi.education.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.education.mapper.EduTermMapper;
import com.ruoyi.education.mapper.EduCourseOpeningMapper;
import com.ruoyi.education.domain.EduTerm;
import com.ruoyi.education.service.IEduTermService;
import com.ruoyi.education.service.IEduCourseApplyService;

/**
 * 学期信息Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-12-18
 */
@Service
public class EduTermServiceImpl implements IEduTermService 
{
    @Autowired
    private EduTermMapper eduTermMapper;

    @Autowired
    private EduCourseOpeningMapper eduCourseOpeningMapper;

    @Autowired
    private IEduCourseApplyService eduCourseApplyService;

    /**
     * 查询学期信息
     * 
     * @param termId 学期信息主键
     * @return 学期信息
     */
    @Override
    public EduTerm selectEduTermByTermId(Long termId)
    {
        return eduTermMapper.selectEduTermByTermId(termId);
    }

    /**
     * 查询学期信息列表
     * 
     * @param eduTerm 学期信息
     * @return 学期信息
     */
    @Override
    public List<EduTerm> selectEduTermList(EduTerm eduTerm)
    {
        return eduTermMapper.selectEduTermList(eduTerm);
    }

    /**
     * 查询当前学期
     * 
     * @return 当前学期
     */
    @Override
    public EduTerm selectCurrentTerm()
    {
        return eduTermMapper.selectCurrentTerm();
    }

    /**
     * 新增学期信息
     * 
     * @param eduTerm 学期信息
     * @return 结果
     */
    @Override
    @Transactional
    public int insertEduTerm(EduTerm eduTerm)
    {
        eduTerm.setCreateTime(DateUtils.getNowDate());
        // 如果设置为当前学期，先重置其他学期并将之前学期的课程设为已结课
        if ("1".equals(eduTerm.getIsCurrent()))
        {
            // 获取之前的当前学期
            EduTerm oldCurrentTerm = eduTermMapper.selectCurrentTerm();
            eduTermMapper.resetCurrentTerm();
            // 将之前学期的课程全部设为已结课
            if (oldCurrentTerm != null)
            {
                eduCourseOpeningMapper.closeTermCourses(oldCurrentTerm.getTermId());
            }
        }
        return eduTermMapper.insertEduTerm(eduTerm);
    }

    /**
     * 修改学期信息
     * 
     * @param eduTerm 学期信息
     * @return 结果
     */
    @Override
    @Transactional
    public int updateEduTerm(EduTerm eduTerm)
    {
        eduTerm.setUpdateTime(DateUtils.getNowDate());
        // 如果设置为当前学期，先重置其他学期并将之前学期的课程设为已结课
        if ("1".equals(eduTerm.getIsCurrent()))
        {
            // 获取之前的当前学期
            EduTerm oldCurrentTerm = eduTermMapper.selectCurrentTerm();
            
            // 检查之前学期是否所有成绩都已录入
            if (oldCurrentTerm != null && !oldCurrentTerm.getTermId().equals(eduTerm.getTermId()))
            {
                int pendingCount = eduCourseOpeningMapper.countPendingScoreByTermId(oldCurrentTerm.getTermId());
                if (pendingCount > 0)
                {
                    throw new com.ruoyi.common.exception.ServiceException(
                        "无法切换学期：当前学期还有 " + pendingCount + " 个学生的成绩未录入，请先完成成绩录入！");
                }
            }
            
            eduTermMapper.resetCurrentTerm();
            // 将之前学期的所有课程设为已结课（status='1'）
            if (oldCurrentTerm != null && !oldCurrentTerm.getTermId().equals(eduTerm.getTermId()))
            {
                eduCourseOpeningMapper.closeTermCourses(oldCurrentTerm.getTermId());
            }
            
            // 将新学期已批准的开课申请转换为开课安排
            int convertedCount = eduCourseApplyService.convertApprovedToOpening(eduTerm.getTermId());
            if (convertedCount > 0)
            {
                // 记录转换日志（可选）
                System.out.println("学期切换：已将 " + convertedCount + " 个已批准的开课申请转换为开课安排");
            }
            
            // 将新学期的所有课程设为可选状态（开放选课）
            int openedCount = eduCourseOpeningMapper.openTermCourses(eduTerm.getTermId());
            if (openedCount > 0)
            {
                System.out.println("学期切换：已开放 " + openedCount + " 门课程的选课");
            }
        }
        return eduTermMapper.updateEduTerm(eduTerm);
    }

    /**
     * 批量删除学期信息
     * 
     * @param termIds 需要删除的学期信息主键
     * @return 结果
     */
    @Override
    public int deleteEduTermByTermIds(Long[] termIds)
    {
        return eduTermMapper.deleteEduTermByTermIds(termIds);
    }

    /**
     * 删除学期信息信息
     * 
     * @param termId 学期信息主键
     * @return 结果
     */
    @Override
    public int deleteEduTermByTermId(Long termId)
    {
        return eduTermMapper.deleteEduTermByTermId(termId);
    }
}
