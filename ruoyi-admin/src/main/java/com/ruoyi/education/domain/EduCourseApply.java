package com.ruoyi.education.domain;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 开课申请对象 edu_course_apply
 * 
 * @author ruoyi
 * @date 2025-01-09
 */
public class EduCourseApply extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 申请ID */
    private Long applyId;

    /** 学期ID */
    @Excel(name = "学期ID")
    private Long termId;

    /** 学期名称（关联查询） */
    @Excel(name = "学期")
    private String termName;

    /** 申请教师ID */
    @Excel(name = "教师ID")
    private Long teacherId;

    /** 教师姓名（关联查询） */
    @Excel(name = "申请教师")
    private String teacherName;

    /** 课程ID（选择已有课程时） */
    @Excel(name = "课程ID")
    private Long courseId;

    /** 课程代码 */
    @Excel(name = "课程代码")
    private String courseCode;

    /** 课程名称 */
    @Excel(name = "课程名称")
    private String courseName;

    /** 学分 */
    @Excel(name = "学分")
    private BigDecimal credit;

    /** 课程类型 */
    @Excel(name = "课程类型")
    private String courseType;

    /** 上课时间 */
    @Excel(name = "上课时间")
    private String classTime;

    /** 上课地点 */
    @Excel(name = "上课地点")
    private String classLocation;

    /** 课程容量 */
    @Excel(name = "课程容量")
    private Integer maxStudents;

    /** 课程简介/申请理由 */
    @Excel(name = "课程简介")
    private String description;

    /** 审批状态（0待审批 1已通过 2已拒绝） */
    @Excel(name = "审批状态", readConverterExp = "0=待审批,1=已通过,2=已拒绝")
    private String status;

    /** 拒绝原因 */
    @Excel(name = "拒绝原因")
    private String rejectReason;

    /** 审批人 */
    @Excel(name = "审批人")
    private String approveBy;

    /** 审批时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "审批时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date approveTime;

    public void setApplyId(Long applyId) 
    {
        this.applyId = applyId;
    }

    public Long getApplyId() 
    {
        return applyId;
    }

    public void setTermId(Long termId) 
    {
        this.termId = termId;
    }

    public Long getTermId() 
    {
        return termId;
    }

    public void setTermName(String termName) 
    {
        this.termName = termName;
    }

    public String getTermName() 
    {
        return termName;
    }

    public void setTeacherId(Long teacherId) 
    {
        this.teacherId = teacherId;
    }

    public Long getTeacherId() 
    {
        return teacherId;
    }

    public void setTeacherName(String teacherName) 
    {
        this.teacherName = teacherName;
    }

    public String getTeacherName() 
    {
        return teacherName;
    }

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

    public void setCredit(BigDecimal credit) 
    {
        this.credit = credit;
    }

    public BigDecimal getCredit() 
    {
        return credit;
    }

    public void setCourseType(String courseType) 
    {
        this.courseType = courseType;
    }

    public String getCourseType() 
    {
        return courseType;
    }

    public void setClassTime(String classTime) 
    {
        this.classTime = classTime;
    }

    public String getClassTime() 
    {
        return classTime;
    }

    public void setClassLocation(String classLocation) 
    {
        this.classLocation = classLocation;
    }

    public String getClassLocation() 
    {
        return classLocation;
    }

    public void setMaxStudents(Integer maxStudents) 
    {
        this.maxStudents = maxStudents;
    }

    public Integer getMaxStudents() 
    {
        return maxStudents;
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

    public void setRejectReason(String rejectReason) 
    {
        this.rejectReason = rejectReason;
    }

    public String getRejectReason() 
    {
        return rejectReason;
    }

    public void setApproveBy(String approveBy) 
    {
        this.approveBy = approveBy;
    }

    public String getApproveBy() 
    {
        return approveBy;
    }

    public void setApproveTime(Date approveTime) 
    {
        this.approveTime = approveTime;
    }

    public Date getApproveTime() 
    {
        return approveTime;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("applyId", getApplyId())
            .append("termId", getTermId())
            .append("termName", getTermName())
            .append("teacherId", getTeacherId())
            .append("teacherName", getTeacherName())
            .append("courseId", getCourseId())
            .append("courseCode", getCourseCode())
            .append("courseName", getCourseName())
            .append("credit", getCredit())
            .append("courseType", getCourseType())
            .append("classTime", getClassTime())
            .append("classLocation", getClassLocation())
            .append("maxStudents", getMaxStudents())
            .append("description", getDescription())
            .append("status", getStatus())
            .append("rejectReason", getRejectReason())
            .append("approveBy", getApproveBy())
            .append("approveTime", getApproveTime())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
