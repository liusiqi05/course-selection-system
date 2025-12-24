package com.ruoyi.education.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 学期信息对象 edu_term
 * 
 * @author ruoyi
 * @date 2025-12-18
 */
public class EduTerm extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 学期ID */
    private Long termId;

    /** 学期名称 */
    @Excel(name = "学期名称")
    private String termName;

    /** 学期开始日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "开始日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date startDate;

    /** 学期结束日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "结束日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date endDate;

    /** 是否当前学期 (0否 1是) */
    @Excel(name = "是否当前学期", readConverterExp = "0=否,1=是")
    private String isCurrent;

    /** 状态 (0正常 1停用) */
    @Excel(name = "状态", readConverterExp = "0=正常,1=停用")
    private String status;

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

    public void setStartDate(Date startDate) 
    {
        this.startDate = startDate;
    }

    public Date getStartDate() 
    {
        return startDate;
    }

    public void setEndDate(Date endDate) 
    {
        this.endDate = endDate;
    }

    public Date getEndDate() 
    {
        return endDate;
    }

    public void setIsCurrent(String isCurrent) 
    {
        this.isCurrent = isCurrent;
    }

    public String getIsCurrent() 
    {
        return isCurrent;
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
            .append("termId", getTermId())
            .append("termName", getTermName())
            .append("startDate", getStartDate())
            .append("endDate", getEndDate())
            .append("isCurrent", getIsCurrent())
            .append("status", getStatus())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
