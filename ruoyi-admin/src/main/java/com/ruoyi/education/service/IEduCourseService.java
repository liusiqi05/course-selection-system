package com.ruoyi.education.service;

import java.util.List;
import com.ruoyi.education.domain.EduCourse;

/**
 * 课程信息Service接口
 * 
 * @author ruoyi
 * @date 2025-12-18
 */
public interface IEduCourseService 
{
    /**
     * 查询课程信息
     * 
     * @param courseId 课程信息主键
     * @return 课程信息
     */
    public EduCourse selectEduCourseByCourseId(Long courseId);

    /**
     * 查询课程信息列表
     * 
     * @param eduCourse 课程信息
     * @return 课程信息集合
     */
    public List<EduCourse> selectEduCourseList(EduCourse eduCourse);

    /**
     * 查询所有课程（下拉选择用）
     * 
     * @return 课程信息集合
     */
    public List<EduCourse> selectEduCourseAll();

    /**
     * 新增课程信息
     * 
     * @param eduCourse 课程信息
     * @return 结果
     */
    public int insertEduCourse(EduCourse eduCourse);

    /**
     * 修改课程信息
     * 
     * @param eduCourse 课程信息
     * @return 结果
     */
    public int updateEduCourse(EduCourse eduCourse);

    /**
     * 批量删除课程信息
     * 
     * @param courseIds 需要删除的课程信息主键集合
     * @return 结果
     */
    public int deleteEduCourseByCourseIds(Long[] courseIds);

    /**
     * 删除课程信息
     * 
     * @param courseId 课程信息主键
     * @return 结果
     */
    public int deleteEduCourseByCourseId(Long courseId);

    /**
     * 校验课程代码是否唯一
     * 
     * @param eduCourse 课程信息
     * @return 结果
     */
    public boolean checkCourseCodeUnique(EduCourse eduCourse);
}
