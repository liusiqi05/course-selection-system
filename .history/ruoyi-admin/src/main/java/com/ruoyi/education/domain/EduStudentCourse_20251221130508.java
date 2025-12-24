package com.ruoyi.education.domain;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 选课记录对象 edu_student_course
 * 
 * @author ruoyi
 * @date 2025-12-18
 */
public class EduStudentCourse extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 选课记录ID */
    private Long scId;

    /** 学生ID */
    @Excel(name = "学生ID")
    private Long studentId;

    /** 学号 */
    @Excel(name = "学号")
    private String studentNo;

    /** 学生姓名 */
    @Excel(name = "学生姓名")
    private String studentName;

    /** 开课ID */
    @Excel(name = "开课ID")
    private Long openId;

    /** 课程名称 */
    @Excel(name = "课程名称")
    private String courseName;

    /** 课程代码 */
    @Excel(name = "课程代码")
    private String courseCode;

    /** 学分 */
    @Excel(name = "学分")
    private String credit;

    /** 授课教师 */
    @Excel(name = "授课教师")
    private String teacherName;

    /** 学期名称 */
    @Excel(name = "学期")
    private String termName;

    /** 总成绩 */
    @Excel(name = "总成绩")
    private BigDecimal score;

    /** 平时成绩 */
    @Excel(name = "平时成绩")
    private BigDecimal usualScore;

    /** 考试成绩 */
    @Excel(name = "考试成绩")
    private BigDecimal examScore;

    /** 选课时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "选课时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date enrollTime;

    /** 状态 (0已选 1已修读) */
    @Excel(name = "状态", readConverterExp = "0=已选,1=已修读")
    private String status;

    public void setScId(Long scId) 
    {
        this.scId = scId;
    }

    public Long getScId() 
    {
        return scId;
    }

    public void setStudentId(Long studentId) 
    {
        this.studentId = studentId;
    }

    public Long getStudentId() 
    {
        return studentId;
    }

    public void setStudentNo(String studentNo) 
    {
        this.studentNo = studentNo;
    }

    public String getStudentNo() 
    {
        return studentNo;
    }

    public void setStudentName(String studentName) 
    {
        this.studentName = studentName;
    }

    public String getStudentName() 
    {
        return studentName;
    }

    public void setOpenId(Long openId) 
    {
        this.openId = openId;
    }

    public Long getOpenId() 
    {
        return openId;
    }

    public void setCourseName(String courseName) 
    {
        this.courseName = courseName;
    }

    public String getCourseName() 
    {
        return courseName;
    }

    public void setCourseCode(String courseCode) 
    {
        this.courseCode = courseCode;
    }

    public String getCourseCode() 
    {
        return courseCode;
    }

    public void setCredit(String credit) 
    {
        this.credit = credit;
    }

    public String getCredit() 
    {
        return credit;
    }

    public void setTeacherName(String teacherName) 
    {
        this.teacherName = teacherName;
    }

    public String getTeacherName() 
    {
        return teacherName;
    }

    public void setTermName(String termName) 
    {
        this.termName = termName;
    }

    public String getTermName() 
    {
        return termName;
    }

    public void setScore(BigDecimal score) 
    {
        this.score = score;
    }

    public BigDecimal getScore() 
    {
        return score;
    }

    public void setUsualScore(BigDecimal usualScore) 
    {
        this.usualScore = usualScore;
    }

    public BigDecimal getUsualScore() 
    {
        return usualScore;
    }

    public void setExamScore(BigDecimal examScore) 
    {
        this.examScore = examScore;
    }

    public BigDecimal getExamScore() 
    {
        return examScore;
    }

    public void setEnrollTime(Date enrollTime) 
    {
        this.enrollTime = enrollTime;
    }

    public Date getEnrollTime() 
    {
        return enrollTime;
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
            .append("scId", getScId())
            .append("studentId", getStudentId())
            .append("studentNo", getStudentNo())
            .append("studentName", getStudentName())
            .append("openId", getOpenId())
            .append("courseName", getCourseName())
            .append("score", getScore())
            .append("usualScore", getUsualScore())
            .append("examScore", getExamScore())
            .append("enrollTime", getEnrollTime())
            .append("status", getStatus())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
