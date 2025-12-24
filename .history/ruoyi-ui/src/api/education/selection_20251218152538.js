import request from '@/utils/request'

// 查询选课记录列表（管理员/教师用）
export function listSelection(query) {
  return request({
    url: '/education/selection/list',
    method: 'get',
    params: query
  })
}

// 查询我的课程（学生用）
export function listMyCourses() {
  return request({
    url: '/education/selection/myCourses',
    method: 'get'
  })
}

// 查询某开课的选课学生列表
export function listStudentsByOpening(openId) {
  return request({
    url: '/education/selection/students/' + openId,
    method: 'get'
  })
}

// 查询选课记录详细
export function getSelection(scId) {
  return request({
    url: '/education/selection/' + scId,
    method: 'get'
  })
}

// 学生选课
export function enrollCourse(openId) {
  return request({
    url: '/education/selection/enroll/' + openId,
    method: 'post'
  })
}

// 学生退课
export function withdrawCourse(openId) {
  return request({
    url: '/education/selection/withdraw/' + openId,
    method: 'delete'
  })
}

// 新增选课记录（管理员手动添加）
export function addSelection(data) {
  return request({
    url: '/education/selection',
    method: 'post',
    data: data
  })
}

// 修改选课记录（录入成绩）
export function updateSelection(data) {
  return request({
    url: '/education/selection',
    method: 'put',
    data: data
  })
}

// 删除选课记录
export function delSelection(scId) {
  return request({
    url: '/education/selection/' + scId,
    method: 'delete'
  })
}
