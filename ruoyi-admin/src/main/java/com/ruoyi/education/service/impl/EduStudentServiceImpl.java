package com.ruoyi.education.service.impl;

import java.util.List;
import com.ruoyi.common.constant.UserConstants;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.system.service.ISysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.system.mapper.EduStudentMapper;
import com.ruoyi.system.domain.EduStudent;
import com.ruoyi.education.service.IEduStudentService;

/**
 * 学生信息Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-12-18
 */
@Service
public class EduStudentServiceImpl implements IEduStudentService 
{
    @Autowired
    private EduStudentMapper eduStudentMapper;

    @Autowired
    private ISysUserService userService;

    /** 学生角色ID */
    private static final Long STUDENT_ROLE_ID = 3L;

    /**
     * 查询学生信息
     * 
     * @param studentId 学生信息主键
     * @return 学生信息
     */
    @Override
    public EduStudent selectEduStudentByStudentId(Long studentId)
    {
        return eduStudentMapper.selectEduStudentByStudentId(studentId);
    }

    /**
     * 根据用户ID查询学生信息
     * 
     * @param userId 用户ID
     * @return 学生信息
     */
    @Override
    public EduStudent selectEduStudentByUserId(Long userId)
    {
        return eduStudentMapper.selectEduStudentByUserId(userId);
    }

    /**
     * 查询学生信息列表
     * 
     * @param eduStudent 学生信息
     * @return 学生信息
     */
    @Override
    public List<EduStudent> selectEduStudentList(EduStudent eduStudent)
    {
        return eduStudentMapper.selectEduStudentList(eduStudent);
    }

    /**
     * 新增学生信息（同时创建sys_user）
     * 
     * @param eduStudent 学生信息
     * @return 结果
     */
    @Override
    @Transactional
    public int insertEduStudent(EduStudent eduStudent)
    {
        // 1. 创建系统用户
        SysUser user = new SysUser();
        user.setUserName(eduStudent.getStudentNo()); // 学号作为登录名
        user.setNickName(eduStudent.getNickName());
        user.setPhonenumber(eduStudent.getPhonenumber());
        user.setEmail(eduStudent.getEmail());
        user.setSex(eduStudent.getSex());
        user.setDeptId(eduStudent.getDeptId());
        // 默认密码为学号后6位
        String defaultPassword = eduStudent.getStudentNo().length() >= 6 
            ? eduStudent.getStudentNo().substring(eduStudent.getStudentNo().length() - 6)
            : eduStudent.getStudentNo();
        user.setPassword(SecurityUtils.encryptPassword(defaultPassword));
        user.setStatus("0"); // 正常状态
        // 设置学生角色
        user.setRoleIds(new Long[] { STUDENT_ROLE_ID });
        
        userService.insertUser(user);
        
        // 2. 创建学生扩展信息
        eduStudent.setUserId(user.getUserId());
        eduStudent.setCreateTime(DateUtils.getNowDate());
        return eduStudentMapper.insertEduStudent(eduStudent);
    }

    /**
     * 修改学生信息
     * 
     * @param eduStudent 学生信息
     * @return 结果
     */
    @Override
    @Transactional
    public int updateEduStudent(EduStudent eduStudent)
    {
        // 1. 更新系统用户基本信息
        EduStudent existing = eduStudentMapper.selectEduStudentByStudentId(eduStudent.getStudentId());
        if (existing != null && existing.getUserId() != null)
        {
            SysUser user = new SysUser();
            user.setUserId(existing.getUserId());
            user.setNickName(eduStudent.getNickName());
            user.setPhonenumber(eduStudent.getPhonenumber());
            user.setEmail(eduStudent.getEmail());
            user.setSex(eduStudent.getSex());
            user.setDeptId(eduStudent.getDeptId());
            userService.updateUser(user);
        }
        
        // 2. 更新学生扩展信息
        eduStudent.setUpdateTime(DateUtils.getNowDate());
        return eduStudentMapper.updateEduStudent(eduStudent);
    }

    /**
     * 批量删除学生信息
     * 
     * @param studentIds 需要删除的学生信息主键
     * @return 结果
     */
    @Override
    @Transactional
    public int deleteEduStudentByStudentIds(Long[] studentIds)
    {
        // 删除关联的系统用户
        for (Long studentId : studentIds)
        {
            EduStudent student = eduStudentMapper.selectEduStudentByStudentId(studentId);
            if (student != null && student.getUserId() != null)
            {
                userService.deleteUserById(student.getUserId());
            }
        }
        return eduStudentMapper.deleteEduStudentByStudentIds(studentIds);
    }

    /**
     * 删除学生信息
     * 
     * @param studentId 学生信息主键
     * @return 结果
     */
    @Override
    @Transactional
    public int deleteEduStudentByStudentId(Long studentId)
    {
        // 删除关联的系统用户
        EduStudent student = eduStudentMapper.selectEduStudentByStudentId(studentId);
        if (student != null && student.getUserId() != null)
        {
            userService.deleteUserById(student.getUserId());
        }
        return eduStudentMapper.deleteEduStudentByStudentId(studentId);
    }
}
