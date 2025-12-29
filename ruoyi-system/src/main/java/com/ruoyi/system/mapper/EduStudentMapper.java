package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.EduStudent;

/**
 * 学生信息Mapper接口
 * 
 * @author ruoyi
 * @date 2025-12-18
 */
public interface EduStudentMapper 
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
     * 新增学生信息
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
     * 删除学生信息
     * 
     * @param studentId 学生信息主键
     * @return 结果
     */
    public int deleteEduStudentByStudentId(Long studentId);

    /**
     * 批量删除学生信息
     * 
     * @param studentIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteEduStudentByStudentIds(Long[] studentIds);

    /**
     * 根据用户ID删除学生信息
     * 
     * @param userId 用户ID
     * @return 结果
     */
    public int deleteEduStudentByUserId(Long userId);

    /**
     * 查询学生总数
     * 
     * @return 学生总数
     */
    public int selectStudentCount();
}
