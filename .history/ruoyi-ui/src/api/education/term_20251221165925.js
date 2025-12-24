import request from '@/utils/request'

// 查询学期信息列表
export function listTerm(query) {
  return request({
    url: '/education/term/list',
    method: 'get',
    params: query
  })
}

// 查询学期选项列表（不需要权限，用于下拉选择）
export function listTermOptions() {
  return request({
    url: '/education/term/options',
    method: 'get'
  })
}

// 查询学期信息详细
export function getTerm(termId) {
  return request({
    url: '/education/term/' + termId,
    method: 'get'
  })
}

// 查询当前学期
export function getCurrentTerm() {
  return request({
    url: '/education/term/current',
    method: 'get'
  })
}

// 新增学期信息
export function addTerm(data) {
  return request({
    url: '/education/term',
    method: 'post',
    data: data
  })
}

// 修改学期信息
export function updateTerm(data) {
  return request({
    url: '/education/term',
    method: 'put',
    data: data
  })
}

// 删除学期信息
export function delTerm(termId) {
  return request({
    url: '/education/term/' + termId,
    method: 'delete'
  })
}
