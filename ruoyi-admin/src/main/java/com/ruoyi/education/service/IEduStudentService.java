package com.ruoyi.education.service;

import java.util.List;
import com.ruoyi.education.domain.EduStudent;

/**
 * 学生信息Service接口
 * 
 * @author ruoyi
 * @date 2025-12-18
 */
public interface IEduStudentService 
{
    /**
     * 查询学生信息
     * 
     * @param studentId 学生信息主键
     * @return 学生信息
     */
    public EduStudent selectEduStudentByStudentId(Long studentId);

    /**
     * 根据用户ID查询学生信息
     * 
     * @param userId 用户ID
     * @return 学生信息
     */
    public EduStudent selectEduStudentByUserId(Long userId);

    /**
     * 查询学生信息列表
     * 
     * @param eduStudent 学生信息
     * @return 学生信息集合
     */
    public List<EduStudent> selectEduStudentList(EduStudent eduStudent);

    /**
     * 新增学生信息（同时创建sys_user）
     * 
     * @param eduStudent 学生信息
     * @return 结果
     */
    public int insertEduStudent(EduStudent eduStudent);

    /**
     * 修改学生信息
     * 
     * @param eduStudent 学生信息
     * @return 结果
     */
    public int updateEduStudent(EduStudent eduStudent);

    /**
     * 批量删除学生信息
     * 
     * @param studentIds 需要删除的学生信息主键集合
     * @return 结果
     */
    public int deleteEduStudentByStudentIds(Long[] studentIds);

    /**
     * 删除学生信息
     * 
     * @param studentId 学生信息主键
     * @return 结果
     */
    public int deleteEduStudentByStudentId(Long studentId);
}
