package com.ruoyi.education.controller;

import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.system.mapper.EduStudentMapper;
import com.ruoyi.system.mapper.EduTeacherMapper;
import com.ruoyi.education.mapper.EduCourseOpeningMapper;
import com.ruoyi.education.mapper.EduTermMapper;
import com.ruoyi.education.domain.EduTerm;

/**
 * 首页统计Controller
 * 
 * @author ruoyi
 * @date 2025-12-25
 */
@RestController
@RequestMapping("/education/home")
public class EduHomeController extends BaseController
{
    @Autowired
    private EduStudentMapper eduStudentMapper;
    
    @Autowired
    private EduTeacherMapper eduTeacherMapper;
    
    @Autowired
    private EduCourseOpeningMapper eduCourseOpeningMapper;
    
    @Autowired
    private EduTermMapper eduTermMapper;

    /**
     * 获取首页统计数据
     */
    @GetMapping("/statistics")
    public AjaxResult getStatistics()
    {
        Map<String, Object> data = new HashMap<>();
        
        // 获取学生总数
        int studentCount = eduStudentMapper.selectStudentCount();
        data.put("studentCount", studentCount);
        
        // 获取教师总数
        int teacherCount = eduTeacherMapper.selectTeacherCount();
        data.put("teacherCount", teacherCount);
        
        // 获取当前学期开课数量
        EduTerm currentTerm = eduTermMapper.selectCurrentTerm();
        int courseCount = 0;
        if (currentTerm != null) {
            courseCount = eduCourseOpeningMapper.selectCourseCountByTermId(currentTerm.getTermId());
        }
        data.put("courseCount", courseCount);
        
        return success(data);
    }
}
