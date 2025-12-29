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
     * 检查学生是否已选同名课程（同一学期内）
     * 
     * @param studentId 学生ID
     * @param termId 学期ID
     * @param courseName 课程名称
     * @return 选课记录
     */
    public EduStudentCourse checkSameCourseSelected(@Param("studentId") Long studentId, 
                                                     @Param("termId") Long termId,
                                                     @Param("courseName") String courseName);

    /**
     * 获取学生在指定学期已选的课程名称列表
     * 
     * @param studentId 学生ID
     * @param termId 学期ID
     * @return 课程名称列表
     */
    public List<String> selectSelectedCourseNames(@Param("studentId") Long studentId, @Param("termId") Long termId);

    /**
     * 查询学生的成绩列表
     * 
     * @param studentId 学生ID
     * @param termId 学期ID（可选）
     * @param scoreType 成绩类型（all-全部, pass-通过, fail-挂科）
     * @return 成绩记录集合
     */
    public List<EduStudentCourse> selectMyScoreList(@Param("studentId") Long studentId, 
                                                     @Param("termId") Long termId, 
                                                     @Param("scoreType") String scoreType);

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

    /**
     * 查询待评价的课程列表
     * 
     * @param studentId 学生ID
     * @return 待评价课程列表
     */
    public List<com.ruoyi.education.domain.EduCourseEvaluation> selectPendingEvaluations(Long studentId);

    /**
     * 查询学生的GPA统计
     * 
     * @param studentId 学生ID
     * @param termId 学期ID（为空则计算总GPA）
     * @return GPA统计
     */
    public java.util.Map<String, Object> selectGpaStats(@Param("studentId") Long studentId, @Param("termId") Long termId);

    /**
     * 查询学生各学期的GPA列表
     * 
     * @param studentId 学生ID
     * @return 学期GPA列表
     */
    public List<java.util.Map<String, Object>> selectTermGpaList(Long studentId);

    /**
     * 查询挂科学生列表（用于补考成绩录入）
     * 
     * @param openId 开课ID
     * @return 挂科学生列表
     */
    public List<EduStudentCourse> selectFailedStudentsByOpenId(Long openId);

    /**
     * 录入补考成绩（只能录入一次）
     * 
     * @param eduStudentCourse 选课记录
     * @return 结果
     */
    public int updateMakeupScore(EduStudentCourse eduStudentCourse);
}
