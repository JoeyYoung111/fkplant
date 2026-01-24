/**
 * [_extractData 从结构数组中返回keyName指定属性的序列]
 * @param  {array}  array   [需要转换的对象数组]
 * @param  {string} keyName [需要转换的key]
 * @return {array}          [转换后的序列]
 */
function _extractData(array, keyName) {
  let newStructure = array.map((item) => {
    return item[keyName]
  })
  return newStructure
}

/**
 * [_extractToNameValue 转换数据结构]
 * @param  {array}          array [需要转换的对象数组]
 * @param  {array|integer}  index [只转换指定的索引位置，不传则全部返回]
 * @return {array}                [结构为{"name":"", "value": number}的对象数组]
 */
function _extractToNameValue(array, index) {
  // 不传index默认整个数组
  if (!index) {
    index = Array.from(Array(array.length).keys())
  }
  
  // 只传一个值时做兼容
  if (!Array.isArray(index)) {
    index = [index]
  }

  let newStructure = index.map((item) => {
    return {
      'name': array[item].text,
      'value': array[item].value
    }
  })
  return newStructure
}

/**
 * [_calcTotalPercentage 涉毒数据转换成百分比数值]
 * @return {array} [结构为{"name":"高风险", "value": 百分比数值}的对象数组]
 */
function _calcTotalPercentage() {
  let total = 0

  // 计算总数
  du_jointcontrollevel.map((item) => {
    // 本项吸毒和制毒人员总数
    let numberOfIndex = parseInt(item.xi) + parseInt(item.zhi)
    // 全部总数累加
    total += numberOfIndex
  })

  let newStructure = du_jointcontrollevel.map((item, idx) => {
    return {
      'name': item.text,
      'value': idx + 1,
      'real_value': Math.round(100 * (parseInt(item.xi) + parseInt(item.zhi)) / total)
    }
  })
  return newStructure
}

function _calcSinglePercentage(index, key) {
  return Math.round(du_jointcontrollevel[index][key] / (parseInt(du_jointcontrollevel[index].xi) + parseInt(du_jointcontrollevel[index].zhi)) * 100)
}

function _sortByValue(item1, item2) {
  return item1.value - item2.value
}

function calcfontSize(size) {
  var clientWidth = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth

  if (!clientWidth) return

  var res = size * (clientWidth / 1920)

  return res < 12 ? 12 : Math.ceil(res)
}

function setRootFontSize(dom = 'html') {
  $(dom).css({
    fontSize: calcfontSize(16) + 'px'
  })
}