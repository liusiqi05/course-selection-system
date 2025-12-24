package com.ruoyi.education.domain;

import java.math.BigDecimal;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 课程信息对象 edu_course
 * 
 * @author ruoyi
 * @date 2025-12-18
 */
public class EduCourse extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 课程ID */
    private Long courseId;

    /** 课程代码 */
    @Excel(name = "课程代码")
    private String courseCode;

    /** 课程名称 */
    @Excel(name = "课程名称")
    private String courseName;

    /** 开课学院ID */
    @Excel(name = "开课学院ID")
    private Long deptId;

    /** 开课学院名称 */
    @Excel(name = "开课学院")
    private String deptName;

    /** 学分 */
    @Excel(name = "学分")
    private BigDecimal credit;

    /** 学时 */
    @Excel(name = "学时")
    private Integer hours;

    /** 课程类型 (1必修 2选修 3公选) */
    @Excel(name = "课程类型", readConverterExp = "1=必修,2=选修,3=公选")
    private String courseType;

    /** 课程简介 */
    @Excel(name = "课程简介")
    private String description;

    /** 状态 (0正常 1停用) */
    @Excel(name = "状态", readConverterExp = "0=正常,1=停用")
    private String status;

    public void setCourseId(Long courseId) 
    {
        this.courseId = courseId;
    }

    public Long getCourseId() 
    {
        return courseId;
    }

    public void setCourseCode(String courseCode) 
    {
        this.courseCode = courseCode;
    }

    public String getCourseCode() 
    {
        return courseCode;
    }

    public void setCourseName(String courseName) 
    {
        this.courseName = courseName;
    }

    public String getCourseName() 
    {
        return courseName;
    }

    public void setDeptId(Long deptId) 
    {
        this.deptId = deptId;
    }

    public Long getDeptId() 
    {
        return deptId;
    }

    public void setDeptName(String deptName) 
    {
        this.deptName = deptName;
    }

    public String getDeptName() 
    {
        return deptName;
    }

    public void setCredit(BigDecimal credit) 
    {
        this.credit = credit;
    }

    public BigDecimal getCredit() 
    {
        return credit;
    }

    public void setHours(Integer hours) 
    {
        this.hours = hours;
    }

    public Integer getHours() 
    {
        return hours;
    }

    public void setCourseType(String courseType) 
    {
        this.courseType = courseType;
    }

    public String getCourseType() 
    {
        return courseType;
    }

    public void setDescription(String description) 
    {
        this.description = description;
    }

    public String getDescription() 
    {
        return description;
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
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("courseId", getCourseId())
            .append("courseCode", getCourseCode())
            .append("courseName", getCourseName())
            .append("deptId", getDeptId())
            .append("deptName", getDeptName())
            .append("credit", getCredit())
            .append("hours", getHours())
            .append("courseType", getCourseType())
            .append("description", getDescription())
            .append("status", getStatus())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
