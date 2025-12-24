package com.ruoyi.education.service.impl;

import java.util.List;
import java.util.Collections;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.education.mapper.EduCourseOpeningMapper;
import com.ruoyi.education.mapper.EduTermMapper;
import com.ruoyi.education.domain.EduCourseOpening;
import com.ruoyi.education.domain.EduTerm;
import com.ruoyi.education.service.IEduCourseOpeningService;

/**
 * 开课安排Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-12-18
 */
@Service
public class EduCourseOpeningServiceImpl implements IEduCourseOpeningService 
{
    @Autowired
    private EduCourseOpeningMapper eduCourseOpeningMapper;

    @Autowired
    private EduTermMapper eduTermMapper;

    /**
     * 查询开课安排
     * 
     * @param openId 开课安排主键
     * @return 开课安排
     */
    @Override
    public EduCourseOpening selectEduCourseOpeningByOpenId(Long openId)
    {
        return eduCourseOpeningMapper.selectEduCourseOpeningByOpenId(openId);
    }

    /**
     * 查询开课安排列表
     * 
     * @param eduCourseOpening 开课安排
     * @return 开课安排
     */
    @Override
    public List<EduCourseOpening> selectEduCourseOpeningList(EduCourseOpening eduCourseOpening)
    {
        return eduCourseOpeningMapper.selectEduCourseOpeningList(eduCourseOpening);
    }

    /**
     * 查询可选课程列表（学生选课用）
     * 只显示当前学期、状态正常的课程
     * 
     * @param eduCourseOpening 开课安排
     * @return 开课安排集合
     */
    @Override
    public List<EduCourseOpening> selectAvailableCourseList(EduCourseOpening eduCourseOpening)
    {
        // 如果没有指定学期，自动获取当前学期
        if (eduCourseOpening.getTermId() == null)
        {
            EduTerm currentTerm = eduTermMapper.selectCurrentTerm();
            if (currentTerm == null)
            {
                // 没有当前学期，返回空列表
                return Collections.emptyList();
            }
            eduCourseOpening.setTermId(currentTerm.getTermId());
        }
        // 设置状态为正常
        eduCourseOpening.setStatus("0");
        return eduCourseOpeningMapper.selectEduCourseOpeningList(eduCourseOpening);
    }

    /**
     * 新增开课安排
     * 
     * @param eduCourseOpening 开课安排
     * @return 结果
     */
    @Override
    public int insertEduCourseOpening(EduCourseOpening eduCourseOpening)
    {
        eduCourseOpening.setCreateTime(DateUtils.getNowDate());
        // 初始化已选人数
        if (eduCourseOpening.getSelectedNum() == null)
        {
            eduCourseOpening.setSelectedNum(0);
        }
        return eduCourseOpeningMapper.insertEduCourseOpening(eduCourseOpening);
    }

    /**
     * 修改开课安排
     * 
     * @param eduCourseOpening 开课安排
     * @return 结果
     */
    @Override
    public int updateEduCourseOpening(EduCourseOpening eduCourseOpening)
    {
        eduCourseOpening.setUpdateTime(DateUtils.getNowDate());
        return eduCourseOpeningMapper.updateEduCourseOpening(eduCourseOpening);
    }

    /**
     * 批量删除开课安排
     * 
     * @param openIds 需要删除的开课安排主键
     * @return 结果
     */
    @Override
    public int deleteEduCourseOpeningByOpenIds(Long[] openIds)
    {
        return eduCourseOpeningMapper.deleteEduCourseOpeningByOpenIds(openIds);
    }

    /**
     * 删除开课安排
     * 
     * @param openId 开课安排主键
     * @return 结果
     */
    @Override
    public int deleteEduCourseOpeningByOpenId(Long openId)
    {
        return eduCourseOpeningMapper.deleteEduCourseOpeningByOpenId(openId);
    }

    /**
     * 查询教师待打分的课程列表（已结课但有学生未打分）
     * 
     * @param teacherId 教师ID
     * @return 课程列表
     */
    @Override
    public List<EduCourseOpening> selectPendingScoreCourses(Long teacherId)
    {
        return eduCourseOpeningMapper.selectPendingScoreCourses(teacherId);
    }
}
