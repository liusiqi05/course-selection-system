package com.ruoyi.education.service;

import java.util.List;
import com.ruoyi.system.domain.EduTeacher;

/**
 * 教师信息Service接口
 * 
 * @author ruoyi
 * @date 2025-12-18
 */
public interface IEduTeacherService 
{
    /**
     * 查询教师信息
     * 
     * @param teacherId 教师信息主键
     * @return 教师信息
     */
    public EduTeacher selectEduTeacherByTeacherId(Long teacherId);

    /**
     * 根据用户ID查询教师信息
     * 
     * @param userId 用户ID
     * @return 教师信息
     */
    public EduTeacher selectEduTeacherByUserId(Long userId);

    /**
     * 查询教师信息列表
     * 
     * @param eduTeacher 教师信息
     * @return 教师信息集合
     */
    public List<EduTeacher> selectEduTeacherList(EduTeacher eduTeacher);

    /**
     * 查询所有教师（下拉选择用）
     * 
     * @return 教师信息集合
     */
    public List<EduTeacher> selectEduTeacherAll();

    /**
     * 新增教师信息（同时创建sys_user）
     * 
     * @param eduTeacher 教师信息
     * @return 结果
     */
    public int insertEduTeacher(EduTeacher eduTeacher);

    /**
     * 修改教师信息
     * 
     * @param eduTeacher 教师信息
     * @return 结果
     */
    public int updateEduTeacher(EduTeacher eduTeacher);

    /**
     * 批量删除教师信息
     * 
     * @param teacherIds 需要删除的教师信息主键集合
     * @return 结果
     */
    public int deleteEduTeacherByTeacherIds(Long[] teacherIds);

    /**
     * 删除教师信息
     * 
     * @param teacherId 教师信息主键
     * @return 结果
     */
    public int deleteEduTeacherByTeacherId(Long teacherId);
}
