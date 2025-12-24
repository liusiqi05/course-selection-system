package com.ruoyi.education.mapper;

import java.util.List;
import com.ruoyi.education.domain.EduStudentCourse;
import org.apache.ibatis.annotations.Param;

/**
 * 选课记录Mapper接口
 * 
 * @author ruoyi
 * @date 2025-12-18
 */
public interface EduStudentCourseMapper 
{
    /**
     * 查询选课记录
     * 
     * @param scId 选课记录主键
     * @return 选课记录
     */
    public EduStudentCourse selectEduStudentCourseByScId(Long scId);

    /**
     * 查询选课记录列表
     * 
     * @param eduStudentCourse 选课记录
     * @return 选课记录集合
     */
    public List<EduStudentCourse> selectEduStudentCourseList(EduStudentCourse eduStudentCourse);

    /**
     * 查询学生的选课列表（我的课程）
     * 
     * @param studentId 学生ID
     * @return 选课记录集合
     */
    public List<EduStudentCourse> selectMyCourselist(Long studentId);

    /**
     * 查询某开课的选课学生列表
     * 
     * @param openId 开课ID
     * @return 选课记录集合
     */
    public List<EduStudentCourse> selectStudentsByOpenId(Long openId);

    /**
     * 检查是否已选该课程
     * 
     * @param studentId 学生ID
     * @param openId 开课ID
     * @return 选课记录
     */
    public EduStudentCourse checkSelected(@Param("studentId") Long studentId, @Param("openId") Long openId);

    /**
     * 新增选课记录
     * 
     * @param eduStudentCourse 选课记录
     * @return 结果
     */
    public int insertEduStudentCourse(EduStudentCourse eduStudentCourse);

    /**
     * 修改选课记录
     * 
     * @param eduStudentCourse 选课记录
     * @return 结果
     */
    public int updateEduStudentCourse(EduStudentCourse eduStudentCourse);

    /**
     * 删除选课记录
     * 
     * @param scId 选课记录主键
     * @return 结果
     */
    public int deleteEduStudentCourseByScId(Long scId);

    /**
     * 批量删除选课记录
     * 
     * @param scIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteEduStudentCourseByScIds(Long[] scIds);

    /**
     * 退课（更新状态为1）
     * 
     * @param studentId 学生ID
     * @param openId 开课ID
     * @return 结果
     */
    public int withdrawCourse(@Param("studentId") Long studentId, @Param("openId") Long openId);
}
