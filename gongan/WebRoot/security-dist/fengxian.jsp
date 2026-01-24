<%@ page contentType='text/html;charset=UTF-8' language='java'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<!DOCTYPE HTML">
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	  <script type="text/javascript">
    var du_jointcontrollevel=${dujointcontrollevels};
    var chartOptions = {
      // https://echarts.apache.org/examples/zh/editor.html?c=map-HK
      option1: {
        tooltip: {
          trigger: 'item',
          formatter: function (params) {
            var str = ''
            str += '<p style="margin-bottom: 15px;">'+params.data.name+'</p>'
            str += '<p>涉稳人员：'+params.data.wen+'人</p>'
            str += '<p style="margin-bottom: 15px;"><span style="margin-right: 10px;">一级：'+params.data.wen1+'人</span><span style="margin-right: 10px;">二级：'+params.data.wen2+'人</span><span style="margin-right: 10px;">三级：'+params.data.wen3+'人</span></p>'
            str += '<p>涉恐人员：'+params.data.kong+'人</p>'
            str += '<p style="margin-bottom: 15px;"><span style="margin-right: 10px;">红：'+params.data.kong1+'人</span><span style="margin-right: 10px;">橙：'+params.data.kong2+'人</span><span style="margin-right: 10px;">黄：'+params.data.kong3+'人</span><span style="margin-right: 10px;">蓝：'+params.data.kong4+'人</span></p>'
            str += '<p>涉毒人员：'+params.data.du+'人</p>'
            str += '<p><span style="margin-right: 10px;">吸毒人员：'+params.data.du1+'人</span><span style="margin-right: 10px;">易制毒：'+params.data.du2+'人</span></p>'

            return str
          },
          backgroundColor: '#ecf1e4'
        },
        series: [
          {
            name: '态势分布',
            type: 'map',
            // 地图名
            map: '江阴',
            top: '5%',
            left: 0,
            right: 0,
            bottom: 0,
            // 地图区域的多边形图形样式
            itemStyle: {
              // 地图区域的颜色
              areaColor: '#8080ff',
              borderColor: '#fff',
              borderWidth: 1
            },
            // 高亮状态下的多边形图形样式
            emphasis: {
              itemStyle: {
                areaColor: '#c17fff',
              },
              label: {
                color: '#fff'
              }
            },
            // 选中状态下的多边形图形样式
            select: {
              itemStyle: {
                areaColor: '#c17fff',
              },
              label: {
                color: '#fff'
              }
            },
            // 地图上的文本标签
            label: {
              show: true,
              color: '#fff',
              lineHeight: 12,
              fontSize:10,
              formatter: function(params) {
                //return '{circle|}' + '\n' + (params.name ? params.name.split('').join('\n') : '')
                return '\n' + (params.name ? params.name.split('').join('\n') : '')
              },
              rich: {
                circle: {
                  width: 5,
                  height: 5,
                  lineHeight: 18,
                  borderWidth: 1,
                  borderType: 'solid',
                  borderColor: '#ffffff',
                  borderRadius: 20,
                  backgroundColor: '#d9001b',
                }
              }
            },
            data: ${mapdatas},
            // nameMap: {
            //   '江阴高新技术产业开发区': '高新区'
            // }
          }
        ]
      },

      // https://echarts.apache.org/examples/zh/editor.html?c=line-smooth
      option2: {
        textStyle: {
          color: '#fff'
        },
        tooltip: {
          trigger: 'axis'
        },
        grid: {
          left: 0,
          right: 0,
          bottom: 0,
          containLabel: true
        },
        xAxis: {
          axisLine: {
            lineStyle: {
               color: '#5a4d3c'
            }
          },
          splitLine: {
            show: false
          },
          // 坐标轴刻度
          axisTick: {
            show: false
          },
          type: 'category',
          data: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
        },
        yAxis: {
          axisLine: {
            lineStyle: {
               color: '#5a4d3c'
            }
          },
          splitLine: {
            lineStyle: {
               color: '#5a4d3c'
            }
          },
          type: 'value'
        },
        // legend、折线颜色
        color: ['#ff9900', '#97455b', '#d9001b', '#4b7902'],
        // 右上角图例
        legend: {
          right: 0,
          top: 0,
          textStyle: {
            color: '#fff',
          },
          icon: 'rect',
          data: ['涉稳', '涉恐', '涉黑', '涉毒']
        },
        series: [
          {
            name: '涉稳',
            type: 'line',
            smooth: true,
            symbol: 'none',
            data: _extractData(${trenddatas}, 'wen')//[5, 1, 3, 6, 4, 2, 8, 2, 3, 5, 6, 1, 8, 3, 6]
          },
          {
            name: '涉恐',
            type: 'line',
            smooth: true,
            symbol: 'none',
            data: _extractData(${trenddatas}, 'kong')//[3, 2, 1, 2, 0, 0, 4, 5, 6, 2, 2, 5, 3, 1, 3]
          },
          {
            name: '涉黑',
            type: 'line',
            smooth: true,
            symbol: 'none',
            data: _extractData(${trenddatas}, 'hei')//[1, 3, 0, 1, 1, 0, 1, 1, 2, 0, 2, 0, 1, 0, 2]
          },
          {
            name: '涉毒',
            type: 'line',
            smooth: true,
            symbol: 'none',
            data: _extractData(${trenddatas}, 'du')//[2, 1, 2, 0, 1, 0, 1, 3, 1, 1, 0, 1, 3, 0, 1]
          }
        ]
      },

      // https://echarts.apache.org/examples/zh/editor.html?c=pie-nest
      option3: {
        textStyle: {
          color: '#fff',
        },
        tooltip: {
          trigger: 'item'
        },
        series: [
          {
            type: 'pie',
            // 内圆半径、外圆半径
            radius: ['75%', '85%'],
            label: {
              formatter: '{b|{b}}\n{c|{c}}',
              rich: {
                b: {
                  align: 'center',
                  lineHeight: 16,
                  color: '#ccc'
                },
                c: {
                  align: 'center',
                  color: '#ccc'
                }
              }
            },
            color: ['orange', 'blue'],
            data: _extractToNameValue(${jointcontrollevels}, [1,2])
          },
          {
            name: '',
            type: 'pie',
            selectedMode: 'single',
            radius: ['75%', '65%'],
            label: {
              formatter: '{b|{b}}\n{c|{c}}',
              rich: {
                b: {
                  align: 'center',
                  lineHeight: 16,
                  color: '#ccc'
                },
                c: {
                  align: 'center',
                  color: '#ccc'
                }
              }
            },
            color: ['red'],
            data: _extractToNameValue(${jointcontrollevels}, [0])
          }
        ]
      },

      // https://echarts.apache.org/examples/zh/editor.html?c=bar-simple
      option4: {
        textStyle: {
          color: '#ccc'
        },
        tooltip: {
          trigger: 'axis'
        },
        title: {
          text: '单位/人数',
          textStyle: {
            color: '#fff',
            fontSize: calcfontSize(10)
          },
          top: 'top',
          right: 0
        },
        grid: {
          top: '15%',
          left: 0,
          right: '1%',
          bottom: 0,
          containLabel: true
        },
        xAxis: {
          axisLine: {
            lineStyle: {
               color: '#5a4d3c'
            }
          },
          splitLine: {
            show: false,
            lineStyle: {
               color: '#5a4d3c'
            }
          },
          axisLabel: {
            interval: 0
          },
          // 坐标轴刻度
          axisTick: {
            show: false
          },
          type: 'category',
          data: _extractData(${incontrollevels}.sort(_sortByValue).reverse(), 'text')
        },
        yAxis: [
          {
            type: 'value',
            axisLine: {
              show: true,
              lineStyle: {
                color: 'rgba(255, 255, 255, 0.2)'
              }
            },
            splitLine: {
              lineStyle: {
                color: 'rgba(255, 255, 255, 0.2)'
              }
            }
          },
          {
            axisLine: {
              show: true,
              lineStyle: {
                color: 'rgba(255, 255, 255, 0.2)'
              }
            }
          }
        ],
        series: [
          {
            type: 'bar',
            color: '#f59a23',
            data: _extractData(${incontrollevels}.sort(_sortByValue).reverse(), 'value')//[5117, 10, 0, 0, 0, 89, 32]
          }
        ]
      },

      // https://echarts.apache.org/examples/zh/editor.html?c=radar
      option5: {
        tooltip: {
          trigger: 'item'
        },
        textStyle: {
          color: '#ccc'
        },
        radar: {
          axisLine: {
            lineStyle: {
               color: '#41789e'
            }
          },
          splitLine: {
            lineStyle: {
               color: '#41789e'
            }
          },
          splitArea: {
            show: false,
            areaStyle: {
              color: 'transparent', // 图表背景的颜色
            },
          },
          splitNumber: 3,
          indicator: ${indicator}
<%--          indicator: [--%>
<%--            { name: '非访人员' },--%>
<%--            { name: '涉军人员' },--%>
<%--            { name: '利益受损' },--%>
<%--            { name: '极端风险' },--%>
<%--            { name: '电诈风险' },--%>
<%--            { name: '精神障碍' },--%>
<%--            { name: '问题青少年' }--%>
<%--          ]--%>
        },
        series: [
          {
            name: '涉稳专题-人员属性',
            type: 'radar',
            symbol: 'none',
            lineStyle: {
              color: '#41789e',
            },
            data: [
              {
                areaStyle: {
                  color: '#ff6699'
                },
                value: _extractData(${attributelabels}, 'value')//[643, 132, 1529, 386, 50, 1667],
              }
            ]
          }
        ]
      },

      option6: {
        textStyle: {
          color: '#ccc'
        },
        tooltip: {
          trigger: 'axis'
        },
        grid: {
          top: '10%',
          left: 0,
          bottom: 0,
          containLabel: true
        },
        xAxis: [
          {
            axisLine: {
              show: true,
              lineStyle: {
                color: 'rgba(255, 255, 255, 0.2)'
              }
            },
            splitLine: {
              lineStyle: {
                color: 'rgba(255, 255, 255, 0.2)'
              }
            },
            // 坐标轴刻度
            axisTick: {
              show: false
            },
            type: 'value'
          },
          {
            axisLine: {
              show: true,
              lineStyle: {
                color: 'rgba(255, 255, 255, 0.2)'
              }
            }
          }
        ],
        yAxis: {
          axisLine: {
            lineStyle: {
               color: 'rgba(255, 255, 255, 0.2)'
            }
          },
          splitLine: {
            show: false,
          },
          // 坐标轴刻度
          axisTick: {
            show: false
          },
          axisLabel: {
            interval: 0
          },
          type: 'category',
          data: _extractData(${nativeplaces}.sort(_sortByValue), 'text')//['和田地区', '喀什地区', '本地常口', '克孜勒苏柯尔克孜', '非新疆籍']
        },
        series: [
          {
            type: 'bar',
            color: '#ff73b9',

            itemStyle: {
              normal: {
                label: {
                  show: true,
                  color: '#fff',
                  formatter: function(params) {
                    if (params.value > 0) {
                      return params.value
                    } else {
                      return ' '
                    }
                  },
                }
              }
            },
            data: _extractData(${nativeplaces}.sort(_sortByValue), 'value')//[138, 30, 16, 8, 6]
          }
        ]
      },

      option7: {
        // 饼图中间文字
        graphic: {
          type: 'text',
          left: 'center',
          top: 'center',
          style: {
            // 数值
            text: ${jointtypes}[0].value,
            fill: '#fff',
          }
        },
        grid: {
          top: 0,
          left: 0,
          right: 0,
          bottom: 0
        },
        series: [
          {
            type: 'pie',
            radius: ['70%', '100%'],
            center: ['50%', '50%'],
            // 隐藏指示线
            labelLine: {
              show: false
            },
            // 隐藏圆环上文字
            label: {
              show: false
            },
            data: [
              // 数值圆环
              {
                itemStyle: {
                  color: '#d9001b'
                },
                value: ${jointtypes}[0].value,
              },
              // 背景圆环
              {
                itemStyle: {
                  color: "#e9e9e9",
                },
                value: 100 - ${jointtypes}[0].value,
              },
            ]
          }
        ]
      },

      option8: {
        // 饼图中间文字
        graphic: {
          type: 'text',
          left: 'center',
          top: 'center',
          style: {
            // 数值
            text: ${jointtypes}[1].value,
            fill: '#fff',
          }
        },
        grid: {
          top: 0,
          left: 0,
          right: 0,
          bottom: 0
        },
        series: [
          {
            type: 'pie',
            radius: ['70%', '100%'],
            center: ['50%', '50%'],
            // 隐藏指示线
            labelLine: {
              show: false
            },
            // 隐藏圆环上文字
            label: {
              show: false
            },
            data: [
              // 数值圆环
              {
                itemStyle: {
                  color: '#cc6600'
                },
                value: ${jointtypes}[1].value,
              },
              // 背景圆环
              {
                itemStyle: {
                  color: "#e9e9e9",
                },
                value: 100 - ${jointtypes}[1].value,
              },
            ]
          }
        ]
      },

      option9: {
        // 饼图中间文字
        graphic: {
          type: 'text',
          left: 'center',
          top: 'center',
          style: {
            // 数值
            text: ${jointtypes}[2].value,
            fill: '#fff',
          }
        },
        grid: {
          top: 0,
          left: 0,
          right: 0,
          bottom: 0
        },
        series: [
          {
            type: 'pie',
            radius: ['70%', '100%'],
            center: ['50%', '50%'],
            // 隐藏指示线
            labelLine: {
              show: false
            },
            // 隐藏圆环上文字
            label: {
              show: false
            },
            data: [
              // 数值圆环
              {
                itemStyle: {
                  color: '#ffff00'
                },
                value: ${jointtypes}[2].value,
              },
              // 背景圆环
              {
                itemStyle: {
                  color: "#e9e9e9",
                },
                value: 100 - ${jointtypes}[2].value,
              },
            ]
          }
        ]
      },

      option10: {
        // 饼图中间文字
        graphic: {
          type: 'text',
          left: 'center',
          top: 'center',
          style: {
            // 数值
            text: ${jointtypes}[3].value,
            fill: '#fff',
          }
        },
        grid: {
          top: 0,
          left: 0,
          right: 0,
          bottom: 0
        },
        series: [
          {
            type: 'pie',
            radius: ['70%', '100%'],
            center: ['50%', '50%'],
            // 隐藏指示线
            labelLine: {
              show: false
            },
            // 隐藏圆环上文字
            label: {
              show: false
            },
            data: [
              // 数值圆环
              {
                itemStyle: {
                  color: '#0079fe'
                },
                value: ${jointtypes}[3].value,
              },
              // 背景圆环
              {
                itemStyle: {
                  color: "#e9e9e9",
                },
                value: 100 - ${jointtypes}[3].value,
              },
            ]
          }
        ]
      },

      option11: {
        // 饼图中间文字
        graphic: {
          type: 'text',
          left: 'center',
          top: 'center',
          style: {
            // 数值
            text: ${incontrolleves}[0].text + ${incontrolleves}[0].value + '\n\n' + ${incontrolleves}[1].text + ${incontrolleves}[1].value,
            fill: '#fff',
          }
        },
        tooltip: {
          trigger: 'item'
        },
        grid: {
          top: 0,
          left: 0,
          right: 0,
          bottom: 0
        },
        color: ['#ff3399', '#6633ff'],
        series: [
          {
            type: 'pie',
            radius: ['65%', '95%'],
            avoidLabelOverlap: false,
            label: {
              show: false
            },
            labelLine: {
              show: false
            },
            data: _extractToNameValue(${incontrolleves})
            // data: [
            //   { name: '关注中', value: 1000, },
            //   { name: '已打击', value: 6063, }
            // ]
          }
        ]
      },

      // https://echarts.apache.org/examples/zh/editor.html?c=funnel
      option12: {
        textStyle: {
          color: '#fff'
        },
        tooltip: {
          trigger: 'item',
          formatter: function(params) {
            return params.name + ' ' + params.data.real_value + '%'
          }
        },
        color: ['#d87a80', '#ffb980', '#5ab1ef'],
        series: [
          {
            type: 'funnel',
            sort: 'ascending',
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            gap: 0,
            label: {
              show: true,
              position: 'inside',
              formatter: function(params) {
                return params.name + ' ' + params.data.real_value + '%'
              }
            },
            labelLine: {
              show: false
            },
            itemStyle: {
              borderColor: 'transparent',
              borderWidth: 0
            },
            data: _calcTotalPercentage()
            // data: [
            //   {
            //     name: '高风险',
            //     // value 使用假数据，用于控制漏斗不随值改变而变形
            //     value: 1,
            //     real_value: 1

            //   },
            //   {
            //     name: '中风险',
            //     value: 2,
            //     real_value: 5
            //   },
            //   {
            //     name:'低风险',
            //     value: 3,
            //     real_value: 94
            //   },
            // ]
          }
        ]
      },

      // https://echarts.apache.org/examples/zh/editor.html?c=bar-y-category-stack
      option13: {
      	textStyle:{
      	  color: '#fff'
      	},
        tooltip: {
          trigger: 'item',
          formatter: '{a}：{c}%'
        },
        legend: {
          textStyle: {
            color: '#fff'
          },
          icon: 'circle',
          bottom: 0
        },
        title: {
          text:'高风险类',
          textStyle: {
            color: '#fff',
            fontSize: calcfontSize(10)
          },
          bottom: 0
        },
        grid: {
          left: 0,
          right: 0,
          top: '10%',
          bottom: 0,
          containLabel: true
        },
        xAxis: {
          show: false
        },
        yAxis: {
          type: 'category',
          axisLine: {
            show: false
          },
          splitLine: {
            show: false
          },
          axisLabel: {
            show: false
          },
          axisTick: {
            show: false
          }
        },
        series: [
          {
            name: '社会吸毒人员',
            type: 'bar',
            stack: 'total',
            itemStyle: {
              color: '#69f0ff',
              borderWidth: 2,
              borderColor: "#3b3c5a",
            },
            bottom: 0,
            barWidth: 17,
            label: {
              show: true,
              formatter: '{c}%',
              position: 'bottom',
              color: '#fff',
              borderColor: 'transparent'
            },
            data: [_calcSinglePercentage(0, 'xi')]//[55]
          },
          {
            name: '易制毒人员',
            type: 'bar',
            stack: 'total',
            itemStyle: {
              color: '#50b9f6',
              borderWidth: 2,
              borderColor: "#3b3c5a",
            },
            bottom: 0,
            barWidth: 17,
            label: {
              show: true,
              formatter: '{c}%',
              position: 'bottom',
              color: '#fff',
              borderColor: 'transparent'
            },
            data: [_calcSinglePercentage(0, 'zhi')]
          }
        ]
      }
    }

    function fetchMap(success, fail) {
      $.ajax({
        url: './data/jiangyings.json',
        success: function(res){
          echarts.registerMap('江阴', res)

          success && success(res)
        },
        error: function() {
          fail && fail()
        }
      })
    }

    function initChart(index) {
      var dom = document.getElementById('chart'+index)

      if (!dom) return

      var chart = echarts.init(dom)

      return chart
    }

    function openFullScreen() {
      var de = document.documentElement;
      if (de.requestFullscreen) {
        de.requestFullscreen()
      } else if (de.msRequestFullscreen) {
        de.msRequestFullscreen()
      } else if (de.webkitRequestFullScreen) {
        de.webkitRequestFullScreen()
      } else if (de.mozRequestFullScreen) {
        de.mozRequestFullScreen()
      }
    }
    function exitFullscreen() {
      var de = document;
      if(de.exitFullscreen) {
        de.exitFullscreen()
      } else if(de.msExitFullscreen) {
        de.msExitFullscreen()
      } else if(de.mozCancelFullScreen) {
        de.mozCancelFullScreen()
      } else if(de.webkitExitFullscreen) {
        de.webkitExitFullscreen()
      }
    }

    function appendZero(value) {
      return (value + '').length < 2 ? '0' + value : value
    }
    function getDate() {
      var date = new Date()
      var y = date.getFullYear()
      var mon = date.getMonth() + 1
      var d = date.getDate()
      var h = date.getHours()
      var m = date.getMinutes()
      var s = date.getSeconds()
      var day = date.getDay()
      var weeks = ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六']

      $('#dateT').html(appendZero(h) + ':' + appendZero(m) + ':' + appendZero(s))
      $('#dateD').html(y + '年' + mon + '月' + d + '日 ' + weeks[day])
    }

    $(document).ready(function(){
      // 动态设置全局字号
      setRootFontSize()

      // 全屏、退出全屏
      $('#openFullScreen').show()
      $('#exitFullScreen').hide()
      $('#openFullScreen').click(function () {
        openFullScreen()
        $('#openFullScreen').hide()
        $('#exitFullScreen').show()
      })
      $('#exitFullScreen').click(function () {
        exitFullscreen()
        $('#openFullScreen').show()
        $('#exitFullScreen').hide()
      })

      // 实时显示当前时间
      getDate()
      window.setInterval(getDate ,1000)

      // 图表渲染
      // 态势分布
      var chart1 = initChart(1)
      fetchMap(function() {
        if (chart1) {
          chart1.setOption(chartOptions.option1)
          window.addEventListener('resize', chart1.resize)
        }
      })

      // 近15天走势
      var chart2 = initChart(2)
      if (chart2) {
        chart2.setOption(chartOptions.option2)
        window.addEventListener('resize', chart2.resize)
      }

      // 涉稳专题-管控级别
      var chart3 = initChart(3)
      if (chart3) {
        chart3.setOption(chartOptions.option3)
        window.addEventListener('resize', chart3.resize)
      }

      // 涉稳专题-在控状态
      var chart4 = initChart(4)
      if (chart4) {
        chart4.setOption(chartOptions.option4)
        window.addEventListener('resize', chart4.resize)
      }

      // 涉稳专题-人员属性
      var chart5 = initChart(5)
      if (chart5) {
        chart5.setOption(chartOptions.option5)
        window.addEventListener('resize', chart5.resize)
      }

      // 涉恐专题
      var chart6 = initChart(6)
      if (chart6) {
        chart6.setOption(chartOptions.option6)
        window.addEventListener('resize', chart6.resize)
      }
      // 涉恐专题-圆环1
      var chart7 = initChart(7)
      if (chart7) {
        chart7.setOption(chartOptions.option7)
        window.addEventListener('resize', chart7.resize)
      }
      // 涉恐专题-圆环2
      var chart8 = initChart(8)
      if (chart8) {
        chart8.setOption(chartOptions.option8)
        window.addEventListener('resize', chart8.resize)
      }
      // 涉恐专题-圆环3
      var chart9 = initChart(9)
      if (chart9) {
        chart9.setOption(chartOptions.option9)
        window.addEventListener('resize', chart9.resize)
      }
      // 涉恐专题-圆环4
      var chart10 = initChart(10)
      if (chart10) {
        chart10.setOption(chartOptions.option10)
        window.addEventListener('resize', chart10.resize)
      }

      // 涉黑专题
      var chart11 = initChart(11)
      if (chart11) {
        chart11.setOption(chartOptions.option11)
        window.addEventListener('resize', chart11.resize)
      }

      // 涉毒专题
      var chart12 = initChart(12)
      if (chart12) {
        chart12.setOption(chartOptions.option12)

        chart12.on('click', function(params) {
          if (params && chart13 && (chartOptions && chartOptions.option13)) {
            const index = params.dataIndex
			
			chartOptions.option13.title.text=['高风险类','中风险类','低风险类'][index]
            chartOptions.option13.series[0].data = [_calcSinglePercentage(index, 'xi')]
            chartOptions.option13.series[1].data = [_calcSinglePercentage(index, 'zhi')]

            chart13.setOption(chartOptions.option13)
          }
        })

        window.addEventListener('resize', chart12.resize)
      }
      // 涉毒专题-堆叠条形图
      var chart13 = initChart(13)
      if (chart13) {
        chart13.setOption(chartOptions.option13)
        window.addEventListener('resize', chart13.resize)
      }
    });
  </script>
</head>
<body>
  <div class="container">
    <h1 class="title">风控平台-风险人员</h1>

    <!-- 四周装饰 -->
    <div class="decorators">
      <img src="./images/bg-2.png" class="tl">
      <img src="./images/bg-3.png" class="tr">
      <img src="./images/bg-4.png" class="bl">
      <img src="./images/bg-5.png" class="br">
    </div>

    <!-- 全屏、时间 -->
    <div class="funcs">
      <div class="tr">
        <div id="openFullScreen" class="btn">全屏</div>
        <div id="exitFullScreen" class="btn">退出</div>

        <div class="date">
          <p id="dateT" class="t"></p>
          <p id="dateD" class="d"></p>
        </div>
      </div>
    </div>


    <!-- 数据面板 -->
    <div class="panels">
      <div class="layui-container">
        <div class="layui-col-space10 h-full">
          <div class="layui-col-sm5 layui-col-md5 layui-col-lg5 h-full">
            <div class="block block-1">
              <div class="common-title-1">
                <img src="./images/icon-1.png" class="icon" />
                <p>风险人员总数</p>
              </div>

              <div class="flex justify-between items-end">
                <h2 class="total">${allcount}</h2>

                <div class="flex justify-between items-center">
                  <div class="flex flex-col justify-center items-center">
                    <p class="key">涉稳人员</p>
                    <p class="value">${wencount}</p>
                  </div>
                  <div class="flex flex-col justify-center items-center">
                    <p class="key">涉恐人员</p>
                    <p class="value">${kongcount}</p>
                  </div>
                  <div class="flex flex-col justify-center items-center">
                    <p class="key">涉黑人员</p>
                    <p class="value">${heicount}</p>
                  </div>
                  <div class="flex flex-col justify-center items-center">
                    <p class="key">涉毒人员</p>
                    <p class="value">${ducount}</p>
                  </div>
                </div>
              </div>
            </div>

            <div class="block block-2">
              <div class="common-title-1">
                <img src="./images/icon-1.png" class="icon" />
                <p>态势分布</p>
              </div>

              <div id="chart1" class="w-full h-full"></div>
            </div>

            <div class="block block-3">
              <div class="common-title-1">
                <img src="./images/icon-1.png" class="icon" />
                <p>近15天走势</p>
              </div>

              <div id="chart2" class="w-full h-full"></div>
            </div>
          </div>

          <div class="layui-col-sm3 layui-col-md3 layui-col-lg3 h-full">
            <div class="block block-4">
              <div class="common-title-2">
                <p>涉稳专题-管控级别</p>
              </div>

              <div class="content">
                <div class="levels">
                  <div class="level">
                    <div class="cell">
                      <p class="key">管控一级人员</p>
                      <p class="value">${controllevelone}</p>
                    </div>
                  </div>
                  <div class="gutter"></div>
                  <div class="level">
                    <div class="cell">
                      <p class="key">管控二级人员</p>
                      <p class="value">${controlleveltwo}</p>
                    </div>
                  </div>
                  <div class="gutter"></div>
                  <div class="level">
                    <div class="cell">
                      <p class="key">管控三级人员</p>
                      <p class="value">${controllevelthree}</p>
                    </div>
                  </div>
                </div>
                <div class="gutter1"></div>
                <div class="levels">
                  <div class="level">
                    <img src="./images/icon-10.png" alt="" class="icon">
                    <div class="right">
                      <p class="key">今日管控级别调整人次</p>
                      <p class="value">${todayLevelAdjustCount}</p>
                    </div>
                  </div>
                  <div class="gutter"></div>
                  <div class="level">
                    <img src="./images/icon-11.png" alt="" class="icon">
                    <div class="right">
                      <div class="cell flex">
                        <p class="key">今日管控升级</p>
                        <p class="value">${todayLevelUpCount}</p>
                      </div>
                      <div class="cell flex">
                        <p class="key">今日管控降级</p>
                        <p class="value">${todayLevelDownCount}</p>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <!-- <div id="chart3" class="w-full h-full"></div> -->
            </div>

            <div class="block block-5">
              <div class="common-title-2">
                <p>涉稳专题-在控状态</p>
              </div>

              <div id="chart4" class="w-full h-full"></div>
            </div>

            <div class="block block-6">
              <div class="common-title-2">
                <p>涉稳专题-人员属性</p>
              </div>

              <div class="flex justify-between items-center w-full h-full">
                <div id="chart5" class="w-full h-full"></div>

<!--                 <div class="legends">
                  <p class="legend"><span>非访：</span><span>643</span></p>
                  <p class="legend"><span>涉军：</span><span>132</span></p>
                  <p class="legend"><span>利益受损：</span><span>1529</span></p>
                  <p class="legend"><span>极端风险：</span><span>386</span></p>
                  <p class="legend"><span>电诈风险：</span><span>50</span></p>
                  <p class="legend"><span>精神障碍：</span><span>1667</span></p>
                </div> -->
              </div>
            </div>
          </div>
          <div class="layui-col-sm4 layui-col-md4 layui-col-lg4 h-full">
            <div class="block block-7">
              <div class="common-title-2">
                <p>涉恐专题</p>
              </div>

              <div class="flex justify-between items-center w-full h-full">
                <div id="chart6" class="w-full h-full"></div>

<%--                <div class="circles">--%>
<%--                  <div class="circle">--%>
<%--                    <div id="chart7" class="w-full h-full"></div>--%>
<%--                  </div>--%>
<%--                  <div class="circle">--%>
<%--                    <div id="chart8" class="w-full h-full"></div>--%>
<%--                  </div>--%>
<%--                  <div class="circle">--%>
<%--                    <div id="chart9" class="w-full h-full"></div>--%>
<%--                  </div>--%>
<%--                  <div class="circle">--%>
<%--                    <div id="chart10" class="w-full h-full"></div>--%>
<%--                  </div>--%>
<%--                </div>--%>
				<div class="squares">
                  <p class="square-title">分色管控</p>
                  <div class="square square-1">
                    <p>${jointtype0}</p>
                  </div>
                  <div class="square square-2">
                    <p>${jointtype1}</p>
                  </div>
                  <div class="square square-3">
                    <p>${jointtype2}</p>
                  </div>
                  <div class="square square-4">
                    <p>${jointtype3}</p>
                  </div>
                </div>
              </div>
            </div>

            <div class="block block-8">
              <div class="common-title-2">
                <p>涉黑专题</p>
              </div>

              <div id="chart11" class="w-full h-full"></div>
            </div>

            <div class="block block-9">
              <div class="common-title-2">
                <p>涉毒专题</p>
              </div>

              <div class="flex flex-col w-full h-full">
                <div class="item">
                  <div id="chart13" class="w-full h-full"></div>
                </div>

                <div id="chart12" class="w-full h-full"></div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
