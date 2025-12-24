package com.ruoyi.education.mapper;

import java.util.List;
import com.ruoyi.education.domain.EduCourse;

/**
 * 课程信息Mapper接口
 * 
 * @author ruoyi
 * @date 2025-12-18
 */
public interface EduCourseMapper 
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
     * 删除课程信息
     * 
     * @param courseId 课程信息主键
     * @return 结果
     */
    public int deleteEduCourseByCourseId(Long courseId);

    /**
     * 批量删除课程信息
     * 
     * @param courseIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteEduCourseByCourseIds(Long[] courseIds);

    /**
     * 校验课程代码是否唯一
     * 
     * @param courseCode 课程代码
     * @return 课程信息
     */
    public EduCourse checkCourseCodeUnique(String courseCode);
}
