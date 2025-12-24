package com.ruoyi.education.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.education.mapper.EduCourseMapper;
import com.ruoyi.education.domain.EduCourse;
import com.ruoyi.education.service.IEduCourseService;

/**
 * 课程信息Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-12-18
 */
@Service
public class EduCourseServiceImpl implements IEduCourseService 
{
    @Autowired
    private EduCourseMapper eduCourseMapper;

    /**
     * 查询课程信息
     * 
     * @param courseId 课程信息主键
     * @return 课程信息
     */
    @Override
    public EduCourse selectEduCourseByCourseId(Long courseId)
    {
        return eduCourseMapper.selectEduCourseByCourseId(courseId);
    }

    /**
     * 查询课程信息列表
     * 
     * @param eduCourse 课程信息
     * @return 课程信息
     */
    @Override
    public List<EduCourse> selectEduCourseList(EduCourse eduCourse)
    {
        return eduCourseMapper.selectEduCourseList(eduCourse);
    }

    /**
     * 查询所有课程（下拉选择用）
     * 
     * @return 课程信息集合
     */
    @Override
    public List<EduCourse> selectEduCourseAll()
    {
        return eduCourseMapper.selectEduCourseAll();
    }

    /**
     * 新增课程信息
     * 
     * @param eduCourse 课程信息
     * @return 结果
     */
    @Override
    public int insertEduCourse(EduCourse eduCourse)
    {
        eduCourse.setCreateTime(DateUtils.getNowDate());
        return eduCourseMapper.insertEduCourse(eduCourse);
    }

    /**
     * 修改课程信息
     * 
     * @param eduCourse 课程信息
     * @return 结果
     */
    @Override
    public int updateEduCourse(EduCourse eduCourse)
    {
        eduCourse.setUpdateTime(DateUtils.getNowDate());
        return eduCourseMapper.updateEduCourse(eduCourse);
    }

    /**
     * 批量删除课程信息
     * 
     * @param courseIds 需要删除的课程信息主键
     * @return 结果
     */
    @Override
    public int deleteEduCourseByCourseIds(Long[] courseIds)
    {
        return eduCourseMapper.deleteEduCourseByCourseIds(courseIds);
    }

    /**
     * 删除课程信息
     * 
     * @param courseId 课程信息主键
     * @return 结果
     */
    @Override
    public int deleteEduCourseByCourseId(Long courseId)
    {
        return eduCourseMapper.deleteEduCourseByCourseId(courseId);
    }

    /**
     * 校验课程代码是否唯一
     * 
     * @param eduCourse 课程信息
     * @return 结果
     */
    @Override
    public boolean checkCourseCodeUnique(EduCourse eduCourse)
    {
        Long courseId = StringUtils.isNull(eduCourse.getCourseId()) ? -1L : eduCourse.getCourseId();
        EduCourse info = eduCourseMapper.checkCourseCodeUnique(eduCourse.getCourseCode());
        if (StringUtils.isNotNull(info) && info.getCourseId().longValue() != courseId.longValue())
        {
            return false;
        }
        return true;
    }
}
