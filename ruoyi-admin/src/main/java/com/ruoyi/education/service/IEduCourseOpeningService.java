package com.ruoyi.education.service;

import java.util.List;
import com.ruoyi.education.domain.EduCourseOpening;

/**
 * 开课安排Service接口
 * 
 * @author ruoyi
 * @date 2025-12-18
 */
public interface IEduCourseOpeningService 
{
    /**
     * 查询开课安排
     * 
     * @param openId 开课安排主键
     * @return 开课安排
     */
    public EduCourseOpening selectEduCourseOpeningByOpenId(Long openId);

    /**
     * 查询开课安排列表
     * 
     * @param eduCourseOpening 开课安排
     * @return 开课安排集合
     */
    public List<EduCourseOpening> selectEduCourseOpeningList(EduCourseOpening eduCourseOpening);

    /**
     * 查询可选课程列表（学生选课用）
     * 
     * @param eduCourseOpening 开课安排
     * @return 开课安排集合
     */
    public List<EduCourseOpening> selectAvailableCourseList(EduCourseOpening eduCourseOpening);

    /**
     * 新增开课安排
     * 
     * @param eduCourseOpening 开课安排
     * @return 结果
     */
    public int insertEduCourseOpening(EduCourseOpening eduCourseOpening);

    /**
     * 修改开课安排
     * 
     * @param eduCourseOpening 开课安排
     * @return 结果
     */
    public int updateEduCourseOpening(EduCourseOpening eduCourseOpening);

    /**
     * 批量删除开课安排
     * 
     * @param openIds 需要删除的开课安排主键集合
     * @return 结果
     */
    public int deleteEduCourseOpeningByOpenIds(Long[] openIds);

    /**
     * 删除开课安排
     * 
     * @param openId 开课安排主键
     * @return 结果
     */
    public int deleteEduCourseOpeningByOpenId(Long openId);

    /**
     * 查询教师待打分的课程列表（已结课但有学生未打分）
     * 
     * @param teacherId 教师ID
     * @return 课程列表
     */
    public List<EduCourseOpening> selectPendingScoreCourses(Long teacherId);

    /**
     * 查询教师课程列表（包含待录入人数）
     * 
     * @param eduCourseOpening 开课安排
     * @return 课程列表
     */
    public List<EduCourseOpening> selectTeacherCoursesWithPending(EduCourseOpening eduCourseOpening);

    /**
     * 查询学期所有课程（包含待录入人数，管理员用）
     * 
     * @param termId 学期ID
     * @return 课程列表
     */
    public List<EduCourseOpening> selectTermCoursesWithPending(Long termId);

    /**
     * 结课操作
     * 
     * @param openId 开课ID
     * @return 结果
     */
    public int finishCourse(Long openId);

    /**
     * 取消结课
     * 
     * @param openId 开课ID
     * @return 结果
     */
    public int cancelFinishCourse(Long openId);

    /**
     * 调用存储过程重新计算课程的所有学生成绩（占比变更时保持数据一致性）
     * 
     * @param openId 开课ID
     */
    public void recalcCourseScores(Long openId);
}
