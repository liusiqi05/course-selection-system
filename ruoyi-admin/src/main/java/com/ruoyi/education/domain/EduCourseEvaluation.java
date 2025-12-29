package com.ruoyi.education.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 课程评价对象 edu_course_evaluation
 * 
 * @author ruoyi
 * @date 2025-12-21
 */
public class EduCourseEvaluation extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 评价ID */
    private Long evalId;

    /** 选课记录ID */
    private Long scId;

    /** 学生ID */
    @Excel(name = "学生ID")
    private Long studentId;

    /** 开课ID */
    @Excel(name = "开课ID")
    private Long openId;

    /** 教学质量评分(1-5) */
    @Excel(name = "教学质量")
    private Integer teachingScore;

    /** 课程内容评分(1-5) */
    @Excel(name = "课程内容")
    private Integer contentScore;

    /** 难度适中评分(1-5) */
    @Excel(name = "难度适中")
    private Integer difficultyScore;

    /** 作业量评分(1-5) */
    @Excel(name = "作业量")
    private Integer workloadScore;

    /** 总体评分(1-5) */
    @Excel(name = "总体评分")
    private Integer overallScore;

    /** 文字评价 */
    @Excel(name = "评价内容")
    private String comment;

    /** 是否匿名(0否 1是) */
    private String isAnonymous;

    /** 评价时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "评价时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date evalTime;

    // 关联信息（非数据库字段）
    /** 学生姓名 */
    private String studentName;
    
    /** 学号 */
    private String studentNo;
    
    /** 课程名称 */
    private String courseName;
    
    /** 教师姓名 */
    private String teacherName;
    
    /** 学期名称 */
    private String termName;

    /** 学期ID（用于查询筛选） */
    private Long termId;

    /** 平均分 */
    private Double avgScore;

    public void setEvalId(Long evalId)
    {
        this.evalId = evalId;
    }

    public Long getEvalId()
    {
        return evalId;
    }

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

    public void setOpenId(Long openId)
    {
        this.openId = openId;
    }

    public Long getOpenId()
    {
        return openId;
    }

    public void setTeachingScore(Integer teachingScore)
    {
        this.teachingScore = teachingScore;
    }

    public Integer getTeachingScore()
    {
        return teachingScore;
    }

    public void setContentScore(Integer contentScore)
    {
        this.contentScore = contentScore;
    }

    public Integer getContentScore()
    {
        return contentScore;
    }

    public void setDifficultyScore(Integer difficultyScore)
    {
        this.difficultyScore = difficultyScore;
    }

    public Integer getDifficultyScore()
    {
        return difficultyScore;
    }

    public void setWorkloadScore(Integer workloadScore)
    {
        this.workloadScore = workloadScore;
    }

    public Integer getWorkloadScore()
    {
        return workloadScore;
    }

    public void setOverallScore(Integer overallScore)
    {
        this.overallScore = overallScore;
    }

    public Integer getOverallScore()
    {
        return overallScore;
    }

    public void setComment(String comment)
    {
        this.comment = comment;
    }

    public String getComment()
    {
        return comment;
    }

    public void setIsAnonymous(String isAnonymous)
    {
        this.isAnonymous = isAnonymous;
    }

    public String getIsAnonymous()
    {
        return isAnonymous;
    }

    public void setEvalTime(Date evalTime)
    {
        this.evalTime = evalTime;
    }

    public Date getEvalTime()
    {
        return evalTime;
    }

    public String getStudentName()
    {
        return studentName;
    }

    public void setStudentName(String studentName)
    {
        this.studentName = studentName;
    }

    public String getStudentNo()
    {
        return studentNo;
    }

    public void setStudentNo(String studentNo)
    {
        this.studentNo = studentNo;
    }

    public String getCourseName()
    {
        return courseName;
    }

    public void setCourseName(String courseName)
    {
        this.courseName = courseName;
    }

    public String getTeacherName()
    {
        return teacherName;
    }

    public void setTeacherName(String teacherName)
    {
        this.teacherName = teacherName;
    }

    public String getTermName()
    {
        return termName;
    }

    public void setTermName(String termName)
    {
        this.termName = termName;
    }

    public Long getTermId()
    {
        return termId;
    }

    public void setTermId(Long termId)
    {
        this.termId = termId;
    }

    public Double getAvgScore()
    {
        return avgScore;
    }

    public void setAvgScore(Double avgScore)
    {
        this.avgScore = avgScore;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("evalId", getEvalId())
            .append("scId", getScId())
            .append("studentId", getStudentId())
            .append("openId", getOpenId())
            .append("teachingScore", getTeachingScore())
            .append("contentScore", getContentScore())
            .append("difficultyScore", getDifficultyScore())
            .append("workloadScore", getWorkloadScore())
            .append("overallScore", getOverallScore())
            .append("comment", getComment())
            .append("isAnonymous", getIsAnonymous())
            .append("evalTime", getEvalTime())
            .append("createTime", getCreateTime())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
