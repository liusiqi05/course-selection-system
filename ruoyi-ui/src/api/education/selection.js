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

// 查询我的课程（带学期筛选）
export function listMyCourse(query) {
  return request({
    url: '/education/selection/myCourses',
    method: 'get',
    params: query
  })
}

// 查询我的成绩
export function listMyScore(query) {
  return request({
    url: '/education/selection/myScores',
    method: 'get',
    params: query
  })
}

// 获取GPA统计
export function getGpaStats(termId) {
  return request({
    url: '/education/selection/gpa/stats',
    method: 'get',
    params: { termId }
  })
}

// 获取各学期GPA列表
export function getTermGpaList() {
  return request({
    url: '/education/selection/gpa/termList',
    method: 'get'
  })
}

// 教师查看某开课的学生名单
export function getMyStudents(openId) {
  return request({
    url: '/education/selection/myStudents/' + openId,
    method: 'get'
  })
}

// 教师录入学生成绩
export function inputScore(data) {
  return request({
    url: '/education/selection/inputScore',
    method: 'put',
    data: data
  })
}

// 教师批量录入成绩
export function batchInputScore(data) {
  return request({
    url: '/education/selection/batchInputScore',
    method: 'put',
    data: data
  })
}
