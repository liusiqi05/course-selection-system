import request from '@/utils/request'

// 查询开课申请列表（管理员）
export function listApply(query) {
  return request({
    url: '/education/apply/list',
    method: 'get',
    params: query
  })
}

// 查询我的开课申请列表（教师）
export function listMyApply(query) {
  return request({
    url: '/education/apply/myList',
    method: 'get',
    params: query
  })
}

// 查询开课申请详细
export function getApply(applyId) {
  return request({
    url: '/education/apply/' + applyId,
    method: 'get'
  })
}

// 新增开课申请
export function addApply(data) {
  return request({
    url: '/education/apply',
    method: 'post',
    data: data
  })
}

// 修改开课申请
export function updateApply(data) {
  return request({
    url: '/education/apply',
    method: 'put',
    data: data
  })
}

// 删除开课申请
export function delApply(applyId) {
  return request({
    url: '/education/apply/' + applyId,
    method: 'delete'
  })
}

// 审批开课申请
export function approveApply(data) {
  return request({
    url: '/education/apply/approve',
    method: 'put',
    data: data
  })
}

// 批量审批开课申请
export function batchApproveApply(status, applyIds) {
  return request({
    url: '/education/apply/batchApprove/' + status,
    method: 'put',
    data: applyIds
  })
}

// 转换已通过申请为开课安排
export function convertApply(termId) {
  return request({
    url: '/education/apply/convert/' + termId,
    method: 'post'
  })
}
