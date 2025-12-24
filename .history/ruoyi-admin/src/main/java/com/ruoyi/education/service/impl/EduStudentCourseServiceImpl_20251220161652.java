package com.ruoyi.education.service.impl;

import java.util.Date;
import java.util.List;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.education.mapper.EduStudentCourseMapper;
import com.ruoyi.education.mapper.EduCourseOpeningMapper;
import com.ruoyi.education.domain.EduStudentCourse;
import com.ruoyi.education.domain.EduCourseOpening;
import com.ruoyi.education.service.IEduStudentCourseService;

/**
 * 选课记录Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-12-18
 */
@Service
public class EduStudentCourseServiceImpl implements IEduStudentCourseService 
{
    @Autowired
    private EduStudentCourseMapper eduStudentCourseMapper;

    @Autowired
    private EduCourseOpeningMapper eduCourseOpeningMapper;

    /**
     * 查询选课记录
     * 
     * @param scId 选课记录主键
     * @return 选课记录
     */
    @Override
    public EduStudentCourse selectEduStudentCourseByScId(Long scId)
    {
        return eduStudentCourseMapper.selectEduStudentCourseByScId(scId);
    }

    /**
     * 查询选课记录列表
     * 
     * @param eduStudentCourse 选课记录
     * @return 选课记录
     */
    @Override
    public List<EduStudentCourse> selectEduStudentCourseList(EduStudentCourse eduStudentCourse)
    {
        return eduStudentCourseMapper.selectEduStudentCourseList(eduStudentCourse);
    }

    /**
     * 查询学生的选课列表（我的课程）
     * 
     * @param studentId 学生ID
     * @return 选课记录集合
     */
    @Override
    public List<EduStudentCourse> selectMyCourseList(Long studentId)
    {
        EduStudentCourse query = new EduStudentCourse();
        query.setStudentId(studentId);
        return eduStudentCourseMapper.selectEduStudentCourseList(query);
    }

    /**
     * 查询某开课的选课学生列表
     * 
     * @param openId 开课ID
     * @return 选课记录集合
     */
    @Override
    public List<EduStudentCourse> selectStudentsByOpenId(Long openId)
    {
        EduStudentCourse query = new EduStudentCourse();
        query.setOpenId(openId);
        return eduStudentCourseMapper.selectEduStudentCourseList(query);
    }

    /**
     * 学生选课
     * 
     * @param studentId 学生ID
     * @param openId 开课ID
     * @return 结果
     */
    @Override
    @Transactional
    public AjaxResult enrollCourse(Long studentId, Long openId)
    {
        // 1. 检查是否已选该课程
        EduStudentCourse existing = eduStudentCourseMapper.checkSelected(studentId, openId);
        if (existing != null)
        {
            return AjaxResult.error("您已选择该课程，请勿重复选择");
        }
        
        // 2. 检查课程容量
        EduCourseOpening opening = eduCourseOpeningMapper.selectEduCourseOpeningByOpenId(openId);
        if (opening == null)
        {
            return AjaxResult.error("课程不存在");
        }
        if (!"0".equals(opening.getStatus()))
        {
            return AjaxResult.error("该课程当前不可选");
        }
        if (opening.getSelectedNum() >= opening.getMaxStudents())
        {
            return AjaxResult.error("该课程已满，无法选择");
        }
        
        // 3. 创建选课记录
        EduStudentCourse studentCourse = new EduStudentCourse();
        studentCourse.setStudentId(studentId);
        studentCourse.setOpenId(openId);
        studentCourse.setEnrollTime(new Date());
        studentCourse.setStatus("0"); // 正常状态
        studentCourse.setCreateTime(DateUtils.getNowDate());
        eduStudentCourseMapper.insertEduStudentCourse(studentCourse);
        
        // 4. 更新已选人数
        eduCourseOpeningMapper.incrementSelectedNum(openId);
        
        return AjaxResult.success("选课成功");
    }

    /**
     * 学生退课
     * 
     * @param studentId 学生ID
     * @param openId 开课ID
     * @return 结果
     */
    @Override
    @Transactional
    public AjaxResult withdrawCourse(Long studentId, Long openId)
    {
        // 1. 检查是否已选该课程
        EduStudentCourse existing = eduStudentCourseMapper.checkSelected(studentId, openId);
        if (existing == null)
        {
            return AjaxResult.error("您未选择该课程");
        }
        
        // 2. 删除选课记录
        eduStudentCourseMapper.withdrawCourse(studentId, openId);
        
        // 3. 更新已选人数
        eduCourseOpeningMapper.decrementSelectedNum(openId);
        
        return AjaxResult.success("退课成功");
    }

    /**
     * 新增选课记录
     * 
     * @param eduStudentCourse 选课记录
     * @return 结果
     */
    @Override
    public int insertEduStudentCourse(EduStudentCourse eduStudentCourse)
    {
        eduStudentCourse.setCreateTime(DateUtils.getNowDate());
        return eduStudentCourseMapper.insertEduStudentCourse(eduStudentCourse);
    }

    /**
     * 修改选课记录（录入成绩）
     * 
     * @param eduStudentCourse 选课记录
     * @return 结果
     */
    @Override
    public int updateEduStudentCourse(EduStudentCourse eduStudentCourse)
    {
        eduStudentCourse.setUpdateTime(DateUtils.getNowDate());
        return eduStudentCourseMapper.updateEduStudentCourse(eduStudentCourse);
    }

    /**
     * 批量删除选课记录
     * 
     * @param scIds 需要删除的选课记录主键
     * @return 结果
     */
    @Override
    public int deleteEduStudentCourseByScIds(Long[] scIds)
    {
        return eduStudentCourseMapper.deleteEduStudentCourseByScIds(scIds);
    }

    /**
     * 删除选课记录
     * 
     * @param scId 选课记录主键
     * @return 结果
     */
    @Override
    public int deleteEduStudentCourseByScId(Long scId)
    {
        return eduStudentCourseMapper.deleteEduStudentCourseByScId(scId);
    }
}
