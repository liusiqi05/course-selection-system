package com.ruoyi.education.service;

import java.util.List;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.education.domain.EduStudentCourse;

/**
 * 选课记录Service接口
 * 
 * @author ruoyi
 * @date 2025-12-18
 */
public interface IEduStudentCourseService 
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
    public List<EduStudentCourse> selectMyCourseList(Long studentId);

    /**
     * 查询某开课的选课学生列表
     * 
     * @param openId 开课ID
     * @return 选课记录集合
     */
    public List<EduStudentCourse> selectStudentsByOpenId(Long openId);

    /**
     * 查询学生的成绩列表
     * 
     * @param studentId 学生ID
     * @param termId 学期ID（可选）
     * @param scoreType 成绩类型（all-全部, pass-通过, fail-挂科）
     * @return 成绩记录集合
     */
    public List<EduStudentCourse> selectMyScoreList(Long studentId, Long termId, String scoreType);

    /**
     * 学生选课
     * 
     * @param studentId 学生ID
     * @param openId 开课ID
     * @return 结果
     */
    public AjaxResult enrollCourse(Long studentId, Long openId);

    /**
     * 学生退课
     * 
     * @param studentId 学生ID
     * @param openId 开课ID
     * @return 结果
     */
    public AjaxResult withdrawCourse(Long studentId, Long openId);

    /**
     * 新增选课记录
     * 
     * @param eduStudentCourse 选课记录
     * @return 结果
     */
    public int insertEduStudentCourse(EduStudentCourse eduStudentCourse);

    /**
     * 修改选课记录（录入成绩）
     * 
     * @param eduStudentCourse 选课记录
     * @return 结果
     */
    public int updateEduStudentCourse(EduStudentCourse eduStudentCourse);

    /**
     * 批量删除选课记录
     * 
     * @param scIds 需要删除的选课记录主键集合
     * @return 结果
     */
    public int deleteEduStudentCourseByScIds(Long[] scIds);

    /**
     * 删除选课记录
     * 
     * @param scId 选课记录主键
     * @return 结果
     */
    public int deleteEduStudentCourseByScId(Long scId);

    /**
     * 查询学生的GPA统计
     * 
     * @param studentId 学生ID
     * @param termId 学期ID（为空则计算总GPA）
     * @return GPA统计
     */
    public java.util.Map<String, Object> selectGpaStats(Long studentId, Long termId);

    /**
     * 查询学生各学期的GPA列表
     * 
     * @param studentId 学生ID
     * @return 学期GPA列表
     */
    public java.util.List<java.util.Map<String, Object>> selectTermGpaList(Long studentId);
}
