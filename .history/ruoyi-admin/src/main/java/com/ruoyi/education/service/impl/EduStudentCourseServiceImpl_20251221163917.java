package com.ruoyi.education.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.education.mapper.EduStudentCourseMapper;
import com.ruoyi.education.mapper.EduCourseOpeningMapper;
import com.ruoyi.education.mapper.EduTermMapper;
import com.ruoyi.education.domain.EduStudentCourse;
import com.ruoyi.education.domain.EduCourseOpening;
import com.ruoyi.education.domain.EduTerm;
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

    @Autowired
    private EduTermMapper eduTermMapper;

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
     * 查询学生的成绩列表
     * 
     * @param studentId 学生ID
     * @param termId 学期ID（可选）
     * @param scoreType 成绩类型（all-全部, pass-通过, fail-挂科）
     * @return 成绩记录集合
     */
    @Override
    public List<EduStudentCourse> selectMyScoreList(Long studentId, Long termId, String scoreType)
    {
        return eduStudentCourseMapper.selectMyScoreList(studentId, termId, scoreType);
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
        // 1. 检查课程是否存在
        EduCourseOpening opening = eduCourseOpeningMapper.selectEduCourseOpeningByOpenId(openId);
        if (opening == null)
        {
            return AjaxResult.error("课程不存在");
        }
        
        // 2. 检查选课时间是否在有效范围内
        EduTerm term = eduTermMapper.selectEduTermByTermId(opening.getTermId());
        if (term == null)
        {
            return AjaxResult.error("学期信息不存在");
        }
        Date now = new Date();
        if (term.getSelectionStart() != null && now.before(term.getSelectionStart()))
        {
            return AjaxResult.error("选课尚未开始，开始时间：" + DateUtils.parseDateToStr("yyyy-MM-dd HH:mm", term.getSelectionStart()));
        }
        if (term.getSelectionEnd() != null && now.after(term.getSelectionEnd()))
        {
            return AjaxResult.error("选课已结束，结束时间：" + DateUtils.parseDateToStr("yyyy-MM-dd HH:mm", term.getSelectionEnd()));
        }
        
        // 3. 检查是否已选该课程
        EduStudentCourse existing = eduStudentCourseMapper.checkSelected(studentId, openId);
        if (existing != null)
        {
            return AjaxResult.error("您已选择该课程，请勿重复选择");
        }
        
        // 4. 检查课程状态和容量
        if (!"0".equals(opening.getStatus()))
        {
            return AjaxResult.error("该课程当前不可选");
        }
        if (opening.getSelectedNum() >= opening.getMaxStudents())
        {
            return AjaxResult.error("该课程已满，无法选择");
        }
        
        // 5. 检查上课时间是否冲突
        String conflictResult = checkTimeConflict(studentId, opening.getTermId(), opening.getClassTime(), null);
        if (conflictResult != null)
        {
            return AjaxResult.error(conflictResult);
        }
        
        // 6. 创建选课记录
        EduStudentCourse studentCourse = new EduStudentCourse();
        studentCourse.setStudentId(studentId);
        studentCourse.setOpenId(openId);
        studentCourse.setEnrollTime(new Date());
        studentCourse.setStatus("0"); // 正常状态
        studentCourse.setCreateTime(DateUtils.getNowDate());
        eduStudentCourseMapper.insertEduStudentCourse(studentCourse);
        
        // 7. 更新已选人数
        eduCourseOpeningMapper.incrementSelectedNum(openId);
        
        return AjaxResult.success("选课成功");
    }

    /**
     * 检查上课时间冲突
     * @param studentId 学生ID
     * @param termId 学期ID
     * @param newClassTime 新课程的上课时间
     * @param excludeOpenId 排除的开课ID（用于编辑时）
     * @return 冲突信息，无冲突返回null
     */
    private String checkTimeConflict(Long studentId, Long termId, String newClassTime, Long excludeOpenId)
    {
        if (newClassTime == null || newClassTime.isEmpty())
        {
            return null;
        }
        
        // 解析新课程的时间槽
        Set<String> newTimeSlots = parseTimeSlots(newClassTime);
        if (newTimeSlots.isEmpty())
        {
            return null;
        }
        
        // 获取学生在该学期已选的所有课程
        List<EduCourseOpening> selectedCourses = eduCourseOpeningMapper.selectByStudentAndTerm(studentId, termId);
        
        for (EduCourseOpening course : selectedCourses)
        {
            // 排除指定的课程（用于编辑场景）
            if (excludeOpenId != null && excludeOpenId.equals(course.getOpenId()))
            {
                continue;
            }
            
            if (course.getClassTime() == null || course.getClassTime().isEmpty())
            {
                continue;
            }
            
            Set<String> existingTimeSlots = parseTimeSlots(course.getClassTime());
            
            // 检查是否有交集
            for (String slot : newTimeSlots)
            {
                if (existingTimeSlots.contains(slot))
                {
                    return "上课时间冲突：与【" + course.getCourseName() + "】的上课时间（" + course.getClassTime() + "）存在冲突";
                }
            }
        }
        
        return null;
    }

    /**
     * 解析上课时间字符串为时间槽集合
     * 例如："周一1-2节,周三3-4节" -> ["周一1", "周一2", "周三3", "周三4"]
     */
    private Set<String> parseTimeSlots(String classTime)
    {
        Set<String> slots = new HashSet<>();
        if (classTime == null || classTime.isEmpty())
        {
            return slots;
        }
        
        // 按逗号分隔多个时间段
        String[] parts = classTime.split("[,，]");
        for (String part : parts)
        {
            part = part.trim();
            // 匹配格式：周X N-M节
            if (part.matches("周[一二三四五六日][0-9]+-[0-9]+节?"))
            {
                String day = part.substring(0, 2); // 周X
                String periods = part.substring(2).replace("节", "");
                String[] range = periods.split("-");
                if (range.length == 2)
                {
                    try
                    {
                        int start = Integer.parseInt(range[0]);
                        int end = Integer.parseInt(range[1]);
                        for (int i = start; i <= end; i++)
                        {
                            slots.add(day + i);
                        }
                    }
                    catch (NumberFormatException e)
                    {
                        // 忽略解析错误
                    }
                }
            }
        }
        
        return slots;
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

    /**
     * 查询学生的GPA统计
     */
    @Override
    public java.util.Map<String, Object> selectGpaStats(Long studentId, Long termId)
    {
        java.util.Map<String, Object> stats = eduStudentCourseMapper.selectGpaStats(studentId, termId);
        if (stats == null)
        {
            stats = new java.util.HashMap<>();
            stats.put("gpa", 0.0);
            stats.put("totalCredit", 0.0);
            stats.put("courseCount", 0);
            stats.put("passCount", 0);
            stats.put("failCount", 0);
        }
        else
        {
            // 计算GPA = 加权绩点和 / 总学分
            Double weightedGpa = stats.get("weightedGpa") != null ? ((Number) stats.get("weightedGpa")).doubleValue() : 0.0;
            Double totalCredit = stats.get("totalCredit") != null ? ((Number) stats.get("totalCredit")).doubleValue() : 0.0;
            Double gpa = totalCredit > 0 ? Math.round(weightedGpa / totalCredit * 100) / 100.0 : 0.0;
            stats.put("gpa", gpa);
        }
        return stats;
    }

    /**
     * 查询学生各学期的GPA列表
     */
    @Override
    public java.util.List<java.util.Map<String, Object>> selectTermGpaList(Long studentId)
    {
        return eduStudentCourseMapper.selectTermGpaList(studentId);
    }
}
