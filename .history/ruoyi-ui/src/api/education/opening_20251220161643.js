import request from '@/utils/request'

// 查询开课安排列表
export function listOpening(query) {
  return request({
    url: '/education/opening/list',
    method: 'get',
    params: query
  })
}

// 查询可选课程列表（学生选课用）
export function listAvailable(query) {
  return request({
    url: '/education/opening/available',
    method: 'get',
    params: query
  })
}

// 查询开课安排详细
export function getOpening(openId) {
  return request({
    url: '/education/opening/' + openId,
    method: 'get'
  })
}

// 新增开课安排
export function addOpening(data) {
  return request({
    url: '/education/opening',
    method: 'post',
    data: data
  })
}

// 修改开课安排
export function updateOpening(data) {
  return request({
    url: '/education/opening',
    method: 'put',
    data: data
  })
}

// 删除开课安排
export function delOpening(openId) {
  return request({
    url: '/education/opening/' + openId,
    method: 'delete'
  })
}
