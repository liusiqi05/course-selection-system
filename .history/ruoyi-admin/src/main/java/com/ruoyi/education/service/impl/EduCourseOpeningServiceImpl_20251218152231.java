package com.ruoyi.education.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.education.mapper.EduCourseOpeningMapper;
import com.ruoyi.education.domain.EduCourseOpening;
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
     * 
     * @param eduCourseOpening 开课安排
     * @return 开课安排集合
     */
    @Override
    public List<EduCourseOpening> selectAvailableCourseList(EduCourseOpening eduCourseOpening)
    {
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
}
