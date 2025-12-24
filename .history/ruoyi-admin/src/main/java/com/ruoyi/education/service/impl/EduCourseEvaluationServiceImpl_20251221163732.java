package com.ruoyi.education.service.impl;

import java.util.Date;
import java.util.List;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.education.mapper.EduCourseEvaluationMapper;
import com.ruoyi.education.mapper.EduStudentCourseMapper;
import com.ruoyi.education.domain.EduCourseEvaluation;
import com.ruoyi.education.domain.EduStudentCourse;
import com.ruoyi.education.service.IEduCourseEvaluationService;

/**
 * 课程评价Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-12-21
 */
@Service
public class EduCourseEvaluationServiceImpl implements IEduCourseEvaluationService 
{
    @Autowired
    private EduCourseEvaluationMapper eduCourseEvaluationMapper;

    @Autowired
    private EduStudentCourseMapper eduStudentCourseMapper;

    /**
     * 查询课程评价
     */
    @Override
    public EduCourseEvaluation selectEduCourseEvaluationByEvalId(Long evalId)
    {
        return eduCourseEvaluationMapper.selectEduCourseEvaluationByEvalId(evalId);
    }

    /**
     * 查询课程评价列表
     */
    @Override
    public List<EduCourseEvaluation> selectEduCourseEvaluationList(EduCourseEvaluation eduCourseEvaluation)
    {
        return eduCourseEvaluationMapper.selectEduCourseEvaluationList(eduCourseEvaluation);
    }

    /**
     * 查询某开课的评价统计
     */
    @Override
    public EduCourseEvaluation selectEvaluationStats(Long openId)
    {
        return eduCourseEvaluationMapper.selectEvaluationStats(openId);
    }

    /**
     * 学生提交评价
     */
    @Override
    @Transactional
    public AjaxResult submitEvaluation(Long studentId, EduCourseEvaluation evaluation)
    {
        // 1. 检查是否已评价
        EduCourseEvaluation existing = eduCourseEvaluationMapper.selectByStudentAndOpen(studentId, evaluation.getOpenId());
        if (existing != null)
        {
            return AjaxResult.error("您已评价过该课程");
        }

        // 2. 检查选课记录是否存在
        EduStudentCourse sc = eduStudentCourseMapper.checkSelected(studentId, evaluation.getOpenId());
        if (sc == null)
        {
            return AjaxResult.error("您未选择该课程，无法评价");
        }

        // 3. 检查课程是否已结课
        if (!"1".equals(sc.getCourseStatus()))
        {
            return AjaxResult.error("课程尚未结课，暂不能评价");
        }

        // 4. 保存评价
        evaluation.setScId(sc.getScId());
        evaluation.setStudentId(studentId);
        evaluation.setEvalTime(new Date());
        evaluation.setCreateTime(DateUtils.getNowDate());
        eduCourseEvaluationMapper.insertEduCourseEvaluation(evaluation);

        // 5. 更新选课记录的评价状态
        EduStudentCourse updateSc = new EduStudentCourse();
        updateSc.setScId(sc.getScId());
        updateSc.setIsEvaluated("1");
        eduStudentCourseMapper.updateEduStudentCourse(updateSc);

        return AjaxResult.success("评价提交成功");
    }

    /**
     * 查询学生待评价的课程
     */
    @Override
    public List<EduCourseEvaluation> selectPendingEvaluations(Long studentId)
    {
        return eduStudentCourseMapper.selectPendingEvaluations(studentId);
    }

    /**
     * 新增课程评价
     */
    @Override
    public int insertEduCourseEvaluation(EduCourseEvaluation eduCourseEvaluation)
    {
        eduCourseEvaluation.setCreateTime(DateUtils.getNowDate());
        return eduCourseEvaluationMapper.insertEduCourseEvaluation(eduCourseEvaluation);
    }

    /**
     * 修改课程评价
     */
    @Override
    public int updateEduCourseEvaluation(EduCourseEvaluation eduCourseEvaluation)
    {
        eduCourseEvaluation.setUpdateTime(DateUtils.getNowDate());
        return eduCourseEvaluationMapper.updateEduCourseEvaluation(eduCourseEvaluation);
    }

    /**
     * 批量删除课程评价
     */
    @Override
    public int deleteEduCourseEvaluationByEvalIds(Long[] evalIds)
    {
        return eduCourseEvaluationMapper.deleteEduCourseEvaluationByEvalIds(evalIds);
    }

    /**
     * 删除课程评价
     */
    @Override
    public int deleteEduCourseEvaluationByEvalId(Long evalId)
    {
        return eduCourseEvaluationMapper.deleteEduCourseEvaluationByEvalId(evalId);
    }
}
