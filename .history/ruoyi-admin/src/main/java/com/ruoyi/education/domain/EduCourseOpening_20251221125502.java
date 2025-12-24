package com.ruoyi.education.domain;

import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 开课安排对象 edu_course_opening
 * 
 * @author ruoyi
 * @date 2025-12-18
 */
public class EduCourseOpening extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 开课ID */
    private Long openId;

    /** 学期ID */
    @Excel(name = "学期ID")
    private Long termId;

    /** 学期名称 */
    @Excel(name = "学期")
    private String termName;

    /** 课程ID */
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
    private String credit;

    /** 授课教师ID (edu_teacher.teacher_id) */
    @Excel(name = "教师ID")
    private Long teacherId;

    /** 授课教师姓名 */
    @Excel(name = "授课教师")
    private String teacherName;

    /** 上课时间 */
    @Excel(name = "上课时间")
    private String classTime;

    /** 上课地点 */
    @Excel(name = "上课地点")
    private String classLocation;

    /** 课程容量 */
    @Excel(name = "课程容量")
    private Integer maxStudents;

    /** 已选人数 */
    @Excel(name = "已选人数")
    private Integer selectedNum;

    /** 状态 (0进行中 1已结课) */
    @Excel(name = "状态", readConverterExp = "0=进行中,1=已结课")
    private String status;

    /** 待打分人数（非数据库字段，用于查询） */
    private Integer pendingCount;

    public void setOpenId(Long openId) 
    {
        this.openId = openId;
    }

    public Long getOpenId() 
    {
        return openId;;
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

    public void setCredit(String credit) 
    {
        this.credit = credit;
    }

    public String getCredit() 
    {
        return credit;
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

    public void setSelectedNum(Integer selectedNum) 
    {
        this.selectedNum = selectedNum;
    }

    public Integer getSelectedNum() 
    {
        return selectedNum;
    }

    public void setStatus(String status) 
    {
        this.status = status;
    }

    public String getStatus() 
    {
        return status;
    }

    public void setPendingCount(Integer pendingCount) 
    {
        this.pendingCount = pendingCount;
    }

    public Integer getPendingCount() 
    {
        return pendingCount;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("openId", getOpenId())
            .append("termId", getTermId())
            .append("termName", getTermName())
            .append("courseId", getCourseId())
            .append("courseName", getCourseName())
            .append("teacherId", getTeacherId())
            .append("teacherName", getTeacherName())
            .append("classTime", getClassTime())
            .append("classLocation", getClassLocation())
            .append("maxStudents", getMaxStudents())
            .append("selectedNum", getSelectedNum())
            .append("status", getStatus())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
