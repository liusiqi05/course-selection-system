package com.ruoyi.education.mapper;

import java.util.List;
import com.ruoyi.education.domain.EduCourseEvaluation;
import org.apache.ibatis.annotations.Param;

/**
 * 课程评价Mapper接口
 * 
 * @author ruoyi
 * @date 2025-12-21
 */
public interface EduCourseEvaluationMapper 
{
    /**
     * 查询课程评价
     * 
     * @param evalId 评价ID
     * @return 课程评价
     */
    public EduCourseEvaluation selectEduCourseEvaluationByEvalId(Long evalId);

    /**
     * 查询课程评价列表
     * 
     * @param eduCourseEvaluation 查询条件
     * @return 课程评价集合
     */
    public List<EduCourseEvaluation> selectEduCourseEvaluationList(EduCourseEvaluation eduCourseEvaluation);

    /**
     * 查询某开课的评价统计
     * 
     * @param openId 开课ID
     * @return 评价统计
     */
    public EduCourseEvaluation selectEvaluationStats(Long openId);

    /**
     * 查询学生对某课程的评价
     * 
     * @param studentId 学生ID
     * @param openId 开课ID
     * @return 评价信息
     */
    public EduCourseEvaluation selectByStudentAndOpen(@Param("studentId") Long studentId, @Param("openId") Long openId);

    /**
     * 新增课程评价
     * 
     * @param eduCourseEvaluation 课程评价
     * @return 结果
     */
    public int insertEduCourseEvaluation(EduCourseEvaluation eduCourseEvaluation);

    /**
     * 修改课程评价
     * 
     * @param eduCourseEvaluation 课程评价
     * @return 结果
     */
    public int updateEduCourseEvaluation(EduCourseEvaluation eduCourseEvaluation);

    /**
     * 删除课程评价
     * 
     * @param evalId 评价ID
     * @return 结果
     */
    public int deleteEduCourseEvaluationByEvalId(Long evalId);

    /**
     * 批量删除课程评价
     * 
     * @param evalIds 评价ID数组
     * @return 结果
     */
    public int deleteEduCourseEvaluationByEvalIds(Long[] evalIds);

    /**
     * 查询教师的课程评价列表
     * 
     * @param teacherId 教师ID
     * @return 评价列表
     */
    public List<EduCourseEvaluation> selectEvaluationByTeacherId(Long teacherId);

    /**
     * 查询教师课程的评价统计汇总
     * 
     * @param teacherId 教师ID
     * @return 评价统计列表
     */
    public List<EduCourseEvaluation> selectEvaluationStatsByTeacherId(Long teacherId);
}
