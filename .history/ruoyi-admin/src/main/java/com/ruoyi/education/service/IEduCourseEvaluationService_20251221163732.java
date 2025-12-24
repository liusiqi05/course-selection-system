package com.ruoyi.education.service;

import java.util.List;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.education.domain.EduCourseEvaluation;

/**
 * 课程评价Service接口
 * 
 * @author ruoyi
 * @date 2025-12-21
 */
public interface IEduCourseEvaluationService 
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
     * 学生提交评价
     * 
     * @param studentId 学生ID
     * @param evaluation 评价信息
     * @return 结果
     */
    public AjaxResult submitEvaluation(Long studentId, EduCourseEvaluation evaluation);

    /**
     * 查询学生待评价的课程
     * 
     * @param studentId 学生ID
     * @return 待评价课程列表
     */
    public List<EduCourseEvaluation> selectPendingEvaluations(Long studentId);

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
     * 批量删除课程评价
     * 
     * @param evalIds 评价ID数组
     * @return 结果
     */
    public int deleteEduCourseEvaluationByEvalIds(Long[] evalIds);

    /**
     * 删除课程评价
     * 
     * @param evalId 评价ID
     * @return 结果
     */
    public int deleteEduCourseEvaluationByEvalId(Long evalId);
}
