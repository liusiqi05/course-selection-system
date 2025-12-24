package com.ruoyi.education.service.impl;

import java.util.List;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.system.service.ISysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.education.mapper.EduTeacherMapper;
import com.ruoyi.education.domain.EduTeacher;
import com.ruoyi.education.service.IEduTeacherService;

/**
 * 教师信息Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-12-18
 */
@Service
public class EduTeacherServiceImpl implements IEduTeacherService 
{
    @Autowired
    private EduTeacherMapper eduTeacherMapper;

    @Autowired
    private ISysUserService userService;

    /** 教师角色ID */
    private static final Long TEACHER_ROLE_ID = 2L;

    /**
     * 查询教师信息
     * 
     * @param teacherId 教师信息主键
     * @return 教师信息
     */
    @Override
    public EduTeacher selectEduTeacherByTeacherId(Long teacherId)
    {
        return eduTeacherMapper.selectEduTeacherByTeacherId(teacherId);
    }

    /**
     * 根据用户ID查询教师信息
     * 
     * @param userId 用户ID
     * @return 教师信息
     */
    @Override
    public EduTeacher selectEduTeacherByUserId(Long userId)
    {
        return eduTeacherMapper.selectEduTeacherByUserId(userId);
    }

    /**
     * 查询教师信息列表
     * 
     * @param eduTeacher 教师信息
     * @return 教师信息
     */
    @Override
    public List<EduTeacher> selectEduTeacherList(EduTeacher eduTeacher)
    {
        return eduTeacherMapper.selectEduTeacherList(eduTeacher);
    }

    /**
     * 查询所有教师（下拉选择用）
     * 
     * @return 教师信息集合
     */
    @Override
    public List<EduTeacher> selectEduTeacherAll()
    {
        return eduTeacherMapper.selectEduTeacherAll();
    }

    /**
     * 新增教师信息（同时创建sys_user）
     * 
     * @param eduTeacher 教师信息
     * @return 结果
     */
    @Override
    @Transactional
    public int insertEduTeacher(EduTeacher eduTeacher)
    {
        // 1. 创建系统用户
        SysUser user = new SysUser();
        user.setUserName(eduTeacher.getTeacherNo()); // 教工号作为登录名
        user.setNickName(eduTeacher.getNickName());
        user.setPhonenumber(eduTeacher.getPhonenumber());
        user.setEmail(eduTeacher.getEmail());
        user.setSex(eduTeacher.getSex());
        user.setDeptId(eduTeacher.getDeptId());
        user.setUserType("01"); // 教师类型
        // 默认密码为教工号后6位
        String defaultPassword = eduTeacher.getTeacherNo().length() >= 6 
            ? eduTeacher.getTeacherNo().substring(eduTeacher.getTeacherNo().length() - 6)
            : eduTeacher.getTeacherNo();
        user.setPassword(SecurityUtils.encryptPassword(defaultPassword));
        user.setStatus("0"); // 正常状态
        // 设置教师角色
        user.setRoleIds(new Long[] { TEACHER_ROLE_ID });
        
        userService.insertUser(user);
        
        // 2. 创建教师扩展信息
        eduTeacher.setUserId(user.getUserId());
        eduTeacher.setCreateTime(DateUtils.getNowDate());
        return eduTeacherMapper.insertEduTeacher(eduTeacher);
    }

    /**
     * 修改教师信息
     * 
     * @param eduTeacher 教师信息
     * @return 结果
     */
    @Override
    @Transactional
    public int updateEduTeacher(EduTeacher eduTeacher)
    {
        // 1. 更新系统用户基本信息
        EduTeacher existing = eduTeacherMapper.selectEduTeacherByTeacherId(eduTeacher.getTeacherId());
        if (existing != null && existing.getUserId() != null)
        {
            SysUser user = new SysUser();
            user.setUserId(existing.getUserId());
            user.setNickName(eduTeacher.getNickName());
            user.setPhonenumber(eduTeacher.getPhonenumber());
            user.setEmail(eduTeacher.getEmail());
            user.setSex(eduTeacher.getSex());
            user.setDeptId(eduTeacher.getDeptId());
            userService.updateUser(user);
        }
        
        // 2. 更新教师扩展信息
        eduTeacher.setUpdateTime(DateUtils.getNowDate());
        return eduTeacherMapper.updateEduTeacher(eduTeacher);
    }

    /**
     * 批量删除教师信息
     * 
     * @param teacherIds 需要删除的教师信息主键
     * @return 结果
     */
    @Override
    @Transactional
    public int deleteEduTeacherByTeacherIds(Long[] teacherIds)
    {
        // 删除关联的系统用户
        for (Long teacherId : teacherIds)
        {
            EduTeacher teacher = eduTeacherMapper.selectEduTeacherByTeacherId(teacherId);
            if (teacher != null && teacher.getUserId() != null)
            {
                userService.deleteUserById(teacher.getUserId());
            }
        }
        return eduTeacherMapper.deleteEduTeacherByTeacherIds(teacherIds);
    }

    /**
     * 删除教师信息
     * 
     * @param teacherId 教师信息主键
     * @return 结果
     */
    @Override
    @Transactional
    public int deleteEduTeacherByTeacherId(Long teacherId)
    {
        // 删除关联的系统用户
        EduTeacher teacher = eduTeacherMapper.selectEduTeacherByTeacherId(teacherId);
        if (teacher != null && teacher.getUserId() != null)
        {
            userService.deleteUserById(teacher.getUserId());
        }
        return eduTeacherMapper.deleteEduTeacherByTeacherId(teacherId);
    }
}
