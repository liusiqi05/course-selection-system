package com.ruoyi.education.mapper;

import java.util.List;
import com.ruoyi.education.domain.EduTerm;

/**
 * 学期信息Mapper接口
 * 
 * @author ruoyi
 * @date 2025-12-18
 */
public interface EduTermMapper 
{
    /**
     * 查询学期信息
     * 
     * @param termId 学期信息主键
     * @return 学期信息
     */
    public EduTerm selectEduTermByTermId(Long termId);

    /**
     * 查询学期信息列表
     * 
     * @param eduTerm 学期信息
     * @return 学期信息集合
     */
    public List<EduTerm> selectEduTermList(EduTerm eduTerm);

    /**
     * 查询当前学期
     * 
     * @return 当前学期
     */
    public EduTerm selectCurrentTerm();

    /**
     * 新增学期信息
     * 
     * @param eduTerm 学期信息
     * @return 结果
     */
    public int insertEduTerm(EduTerm eduTerm);

    /**
     * 修改学期信息
     * 
     * @param eduTerm 学期信息
     * @return 结果
     */
    public int updateEduTerm(EduTerm eduTerm);

    /**
     * 删除学期信息
     * 
     * @param termId 学期信息主键
     * @return 结果
     */
    public int deleteEduTermByTermId(Long termId);

    /**
     * 批量删除学期信息
     * 
     * @param termIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteEduTermByTermIds(Long[] termIds);

    /**
     * 取消所有当前学期标记
     * 
     * @return 结果
     */
    public int resetCurrentTerm();
}
