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
            eduTermMapper.resetCurrentTerm();
            // 将之前学期的所有课程设为已结课（status='1'）
            if (oldCurrentTerm != null && !oldCurrentTerm.getTermId().equals(eduTerm.getTermId()))
            {
                eduCourseOpeningMapper.closeTermCourses(oldCurrentTerm.getTermId());
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
