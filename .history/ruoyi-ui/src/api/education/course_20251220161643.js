import request from '@/utils/request'

// 查询课程信息列表
export function listCourse(query) {
  return request({
    url: '/education/course/list',
    method: 'get',
    params: query
  })
}

// 查询所有课程（下拉选择用）
export function listCourseAll() {
  return request({
    url: '/education/course/all',
    method: 'get'
  })
}

// 查询课程信息详细
export function getCourse(courseId) {
  return request({
    url: '/education/course/' + courseId,
    method: 'get'
  })
}

// 新增课程信息
export function addCourse(data) {
  return request({
    url: '/education/course',
    method: 'post',
    data: data
  })
}

// 修改课程信息
export function updateCourse(data) {
  return request({
    url: '/education/course',
    method: 'put',
    data: data
  })
}

// 删除课程信息
export function delCourse(courseId) {
  return request({
    url: '/education/course/' + courseId,
    method: 'delete'
  })
}
