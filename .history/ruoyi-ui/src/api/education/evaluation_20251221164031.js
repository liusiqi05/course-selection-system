import request from '@/utils/request'

// 查询课程评价列表
export function listEvaluation(query) {
  return request({
    url: '/education/evaluation/list',
    method: 'get',
    params: query
  })
}

// 查询课程评价详细
export function getEvaluation(evalId) {
  return request({
    url: '/education/evaluation/' + evalId,
    method: 'get'
  })
}

// 获取课程评价统计
export function getEvaluationStats(openId) {
  return request({
    url: '/education/evaluation/stats/' + openId,
    method: 'get'
  })
}

// 提交评价
export function submitEvaluation(data) {
  return request({
    url: '/education/evaluation/submit',
    method: 'post',
    data: data
  })
}

// 获取待评价课程列表
export function getPendingEvaluations() {
  return request({
    url: '/education/evaluation/pending',
    method: 'get'
  })
}

// 删除课程评价
export function delEvaluation(evalId) {
  return request({
    url: '/education/evaluation/' + evalId,
    method: 'delete'
  })
}
