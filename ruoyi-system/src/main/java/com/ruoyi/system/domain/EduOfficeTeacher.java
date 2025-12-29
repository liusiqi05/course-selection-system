package com.ruoyi.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 教务处老师对象 edu_office_teacher
 * 
 * @author ruoyi
 * @date 2025-12-29
 */
public class EduOfficeTeacher extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 教务处老师ID */
    private Long officeTeacherId;

    /** 关联系统用户ID */
    @Excel(name = "用户ID")
    private Long userId;

    /** 姓名 */
    @Excel(name = "姓名")
    private String name;

    /** 性别 */
    @Excel(name = "性别")
    private String gender;

    /** 电话 */
    @Excel(name = "电话")
    private String phone;

    /** 邮箱 */
    @Excel(name = "邮箱")
    private String email;

    /** 部门ID */
    @Excel(name = "部门ID")
    private Long deptId;

    /** 岗位 */
    @Excel(name = "岗位")
    private String position;

    /** 状态（0在职 1离职） */
    @Excel(name = "状态", readConverterExp = "0=在职,1=离职")
    private String status;

    public void setOfficeTeacherId(Long officeTeacherId) 
    {
        this.officeTeacherId = officeTeacherId;
    }

    public Long getOfficeTeacherId() 
    {
        return officeTeacherId;
    }
    public void setUserId(Long userId) 
    {
        this.userId = userId;
    }

    public Long getUserId() 
    {
        return userId;
    }
    public void setName(String name) 
    {
        this.name = name;
    }

    public String getName() 
    {
        return name;
    }
    public void setGender(String gender) 
    {
        this.gender = gender;
    }

    public String getGender() 
    {
        return gender;
    }
    public void setPhone(String phone) 
    {
        this.phone = phone;
    }

    public String getPhone() 
    {
        return phone;
    }
    public void setEmail(String email) 
    {
        this.email = email;
    }

    public String getEmail() 
    {
        return email;
    }
    public void setDeptId(Long deptId) 
    {
        this.deptId = deptId;
    }

    public Long getDeptId() 
    {
        return deptId;
    }
    public void setPosition(String position) 
    {
        this.position = position;
    }

    public String getPosition() 
    {
        return position;
    }
    public void setStatus(String status) 
    {
        this.status = status;
    }

    public String getStatus() 
    {
        return status;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("officeTeacherId", getOfficeTeacherId())
            .append("userId", getUserId())
            .append("name", getName())
            .append("gender", getGender())
            .append("phone", getPhone())
            .append("email", getEmail())
            .append("deptId", getDeptId())
            .append("position", getPosition())
            .append("status", getStatus())
            .append("createTime", getCreateTime())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
