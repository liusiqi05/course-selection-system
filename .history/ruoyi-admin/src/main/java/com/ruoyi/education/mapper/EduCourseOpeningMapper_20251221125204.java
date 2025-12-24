package com.ruoyi.education.mapper;

import java.util.List;
import com.ruoyi.education.domain.EduCourseOpening;

/**
 * 开课安排Mapper接口
 * 
 * @author ruoyi
 * @date 2025-12-18
 */
public interface EduCourseOpeningMapper 
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
     * 更新已选人数 (+1)
     * 
     * @param openId 开课ID
     * @return 结果
     */
    public int incrementSelectedNum(Long openId);

    /**
     * 更新已选人数 (-1)
     * 
     * @param openId 开课ID
     * @return 结果
     */
    public int decrementSelectedNum(Long openId);

    /**
     * 删除开课安排
     * 
     * @param openId 开课安排主键
     * @return 结果
     */
    public int deleteEduCourseOpeningByOpenId(Long openId);

    /**
     * 批量删除开课安排
     * 
     * @param openIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteEduCourseOpeningByOpenIds(Long[] openIds);

    /**
     * 将指定学期的所有课程设为已结课
     * 
     * @param termId 学期ID
     * @return 结果
     */
    public int closeTermCourses(Long termId);
}
