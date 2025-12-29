package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.EduOfficeTeacher;

/**
 * 教务处老师Mapper接口
 * 
 * @author ruoyi
 * @date 2025-12-29
 */
public interface EduOfficeTeacherMapper 
{
    /**
     * 查询教务处老师
     * 
     * @param officeTeacherId 教务处老师主键
     * @return 教务处老师
     */
    public EduOfficeTeacher selectEduOfficeTeacherByOfficeTeacherId(Long officeTeacherId);

    /**
     * 查询教务处老师列表
     * 
     * @param eduOfficeTeacher 教务处老师
     * @return 教务处老师集合
     */
    public List<EduOfficeTeacher> selectEduOfficeTeacherList(EduOfficeTeacher eduOfficeTeacher);

    /**
     * 新增教务处老师
     * 
     * @param eduOfficeTeacher 教务处老师
     * @return 结果
     */
    public int insertEduOfficeTeacher(EduOfficeTeacher eduOfficeTeacher);

    /**
     * 修改教务处老师
     * 
     * @param eduOfficeTeacher 教务处老师
     * @return 结果
     */
    public int updateEduOfficeTeacher(EduOfficeTeacher eduOfficeTeacher);

    /**
     * 删除教务处老师
     * 
     * @param officeTeacherId 教务处老师主键
     * @return 结果
     */
    public int deleteEduOfficeTeacherByOfficeTeacherId(Long officeTeacherId);

    /**
     * 批量删除教务处老师
     * 
     * @param officeTeacherIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteEduOfficeTeacherByOfficeTeacherIds(Long[] officeTeacherIds);
}
