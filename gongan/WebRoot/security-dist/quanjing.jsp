<%@ page contentType='text/html;charset=UTF-8' language='java'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<!DOCTYPE HTML>
<html>
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <script type="text/javascript">
    var chartOptions = {
      option1: {
        tooltip: {
          trigger: 'item',
          formatter: '{b}：{c}%'
        },
        legend: {
          textStyle: {
            color: '#cccccc'
          },
          icon: 'roundRect',
          bottom: 0
        },
        color: ['#3e7d97', '#8ec9f4', '#cdbfe8', '#70d9da', '#e9b6b9'],
        series: [
          {
            name: '外边框',
            type: 'pie',
            z: 1,
            tooltip: {
              show: false,
            },
            left: 0,
            right: 0,
            top: 0,
            bottom: '35%',
            // 边框大小
            radius: ['82%', '80%'],
            // 边框位置
            center: ['50%', '50%'],
            emphasis: {
              disabled: true
            },
            labelLine: {
              show: false
            },
            data: [
              {
                value: 0,
                itemStyle: {
                  normal: {
                    borderWidth: 3,
                    borderColor: '#fff'
                  }
                }
              }
            ]
          },
          {
            type: 'pie',
            z: 2,
            left: 0,
            right: 0,
            top: 0,
            bottom: '35%',
            radius: ['55%', '80%'],
            label: {
              textStyle: {
                color: '#ccc',
                borderColor: 'transparent',
                borderWidth: 0
              },
              formatter: '{b}：{c}%'
            },
            labelLine: {
              show: true,
              lineStyle: {
                color: '#0b809e'
              }
            },
            data: [
              { name: '涉稳', value: '${wenpercent}' },
              { name: '涉恐', value: '${kongpercent}' },
              { name: '涉黑', value: '${heipercent}' },
              { name: '涉毒', value: '${dupercent}' },
              { name: '其他', value: '${otherpersonpercent}' }
            ]
          }
        ]
      },

      option2: {
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
        grid: {
          left: 0,
          right: 0,
          top: 0,
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
            name: '已化解',
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
            data: [(${cdtresults[0].value}/${eventcount}*100).toFixed(0)]
          },
          {
            name: '已钝化',
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
            data: [(${cdtresults[1].value}/${eventcount}*100).toFixed(0)]
          },
          {
            name: '处置中',
            type: 'bar',
            stack: 'total',
            itemStyle: {
              color: '#2363f6',
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
            data: [(${cdtresults[2].value}/${eventcount}*100).toFixed(0)]
          }
        ]
      },

      option3: {
        tooltip: {
          trigger: 'item'
        },
        textStyle: {
          color: '#fff'
        },
        radar: {
          axisLine: {
            lineStyle: {
                color: '#0099ff'
            },
          },
          splitLine: {
            lineStyle: {
                color: '#0099ff'
            }
          },
          splitArea: {
            // 图表背景的颜色
            areaStyle: {
              color:  ['transparent', '#21456a', 'transparent', '#21456a'],
            },
          },
          indicator: ${indicator},
        },
        series: [
          {
            name: '风险矛盾事件',
            type: 'radar',
            lineStyle: {
              color: '#41789e',
            },
            data: [
              {
                areaStyle: {
                  color: '#8e4e6b'
                },
                symbol: 'circle',
                symbolSize: 0,
                label: {
                  show: true,
                  textStyle: {
                    color: '#fff'
                  },
                  formatter: function (params) {
                    return params.value;
                  }
                },
                value: _extractData(${cdttypes}, 'value')
              }
            ]
          }
        ]
      },

      option4: {
        tooltip: {
          trigger: 'item',
          formatter: function (params) {
            var str = '';
            str += '<p style="margin-bottom: 5px;">'+params.data.name+'</p>'
            str += '<p>风险人员：'+params.data.allperson+'人</p>'
            str += '<p style="margin-bottom: 5px;"><span style="margin-right: 10px;">涉稳：'+params.data.wen+'人</span><span style="margin-right: 10px;">涉恐：'+params.data.kong+'人</span><span style="margin-right: 10px;">涉毒：'+params.data.du+'人</span></p>'
            str += '<p>风险矛盾：'+params.data.allevent+'件</p>'
            str += '<p style="margin-bottom: 15px;"><span style="margin-right: 10px;">已化解：'+params.data.event1+'件</span><span style="margin-right: 10px;">已钝化：'+params.data.event2+'件</span><span style="margin-right: 10px;">处置中：'+params.data.event3+'件</span></p>'
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
            right: 140,
            bottom: 0,
            // 地图区域的多边形图形样式
            itemStyle: {
              // 地图区域的颜色
              areaColor: '#daf9ff',
              borderColor: '#fff',
              borderWidth: 1
            },
            // 高亮状态下的多边形图形样式
            emphasis: {
              itemStyle: {
                areaColor: '#c17fff',
              },
              label: {
                color: '#333'
              }
            },
            // 选中状态下的多边形图形样式
            select: {
              itemStyle: {
                areaColor: '#c17fff',
              },
              label: {
                color: '#333'
              }
            },
            // 地图上的文本标签
            label: {
              show: true,
              color: '#333',
              lineHeight: 12,
              fontSize:10,
              formatter: function(params) {
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
          }
        ]
      },

      option5: {
        tooltip: {
          trigger: 'axis',
          axisPointer: {
            type: 'cross',
            crossStyle: {
              color: '#999'
            }
          }
        },
        textStyle: {
          color: '#01bcba'
        },
        color: ['#ff9900', '#33a3ff', '#33ffff'],
        grid: {
          top: '20%',
          left: 0,
          right: 0,
          bottom: 0,
          containLabel: true
        },
        legend: {
          textStyle: {
            color: '#fff'
          },
          top: 0,
          right: 0,
          icon: 'rect',
          data: ['风险人员', '矛盾事件']
        },
        xAxis: [
          {
            type: 'category',
            axisLabel: {
              interval: 0
            },
            data: _extractData(${departments}, 'text')
          },
        ],
        yAxis: [
          {
            type: 'value',
            alignTicks: true,
            axisLine: {
              show: true,
              lineStyle: {
                color: '#33ffff'
              }
            },
            splitLine: {
              lineStyle: {
                color: '#166881'
              }
            },
            axisLabel: {
              formatter: '{value}'
            }
          }
        ],
        series: [
          {
            name: '风险人员',
            type: 'bar',
            data: _extractData(${departments}, 'value')
          },
          {
            name: '矛盾事件',
            type: 'bar',
            data: _extractData(${departments}, 'memo')
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
          top: 0,
          left: 0,
          right: '2%',
          bottom: 0,
          containLabel: true
        },
        xAxis: [
          {
            type: 'value',
            axisLine: {
              show: true,
              lineStyle: {
                color: '#324463'
              }
            },
            splitLine: {
              show: true,
              lineStyle: {
                color: '#324463'
              }
            },
            // 坐标轴刻度
            axisTick: {
              show: false
            }
          },
          {
            axisLine: {
              show: true,
              lineStyle: {
                color: '#324463'
              }
            },
          }
        ],
        yAxis: {
          type: 'category',
          axisLine: {
            show: true,
            lineStyle: {
               color: '#324463'
            }
          },
          splitLine: {
            show: false,
          },
          axisLabel: {
            interval: 0
          },
          axisTick: {
            show: false
          },
          data: _extractData(${affecttypes}.sort(_sortByValue), 'text')//['生产', '经营', '运输', '使用', '仓储']
        },
        series: [
          {
            type: 'bar',
            color: '#ff73b9',

            itemStyle: {
              normal: {
                label: {
                  show: true,
                  color: '#cccccc',
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
            data: _extractData(${affecttypes}.sort(_sortByValue), 'value')//[13, 119, 15, 751, 1]
          }
        ]
      },

      // https://echarts.apache.org/examples/zh/editor.html?c=treemap-simple&version=5.4.1
      option7: {
        tooltip: {
          trigger: 'item'
        },
        color: ['#facd91', '#70b603','orange'],
        series: [
          {
            type: 'treemap',
            roam: false,
            nodeClick: false,
            leafDepth: null,
            squareRatio: 0,
            breadcrumb: {
              show: false
            },
            label: {
              show: true,
              textStyle: {
                color: '#fff',
                fontSize: calcfontSize(12)
              },
              formatter: '{b}：{c}'
            },
            left: 0,
            top: 0,
            right: 0,
            bottom: 0,
            visibleMin: 0,
            data: ${vehicletypes}
          },
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

    function setCircleHeight() {
      for (let i = 1; i <= 4; i++) {
        var dom = '#circle' + i
        $(dom).css({
          height: $(dom).width() + 'px'
        })
      }
    }

    function handleTodaydata(interval = 5000) {
      var isToday = true

      setInterval(function() {
        if (isToday) {
          $('#todayData').fadeOut()
          $('#yesterdayData').fadeIn()
        } else {
          $('#todayData').fadeIn()
          $('#yesterdayData').fadeOut()
        }

        isToday = !isToday
      }, interval)
    }

    function handleTableScroll() {
      var $table = $('.table')
      var $first = $table.find('.tbody .tr:first')
      var $height = $first.height()

      $first.animate({
        marginTop: -$height + 'px'
      }, 500, function() {
        $first.css({ marginTop: 0 }).appendTo('.table .tbody')
      })
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

      // 设置风险人员的4个圆圈高度
      setCircleHeight()
      window.addEventListener('resize', setCircleHeight)

      // 实时显示当前时间
      getDate()
      window.setInterval(getDate ,1000)

      // 动态显示今日、昨日数据
      $('#todayData').show()
      $('#yesterdayData').hide()
      handleTodaydata(3000)

      // 表格循环滚动
      window.setInterval(handleTableScroll, 2000)

      // 图表渲染
      // 风险人员
      var chart1 = initChart(1)
      fetchMap(function() {
        if (chart1) {
          chart1.setOption(chartOptions.option1)
          window.addEventListener('resize', chart1.resize)
        }
      })

      // 风险矛盾事件
      var chart2 = initChart(2)
      if (chart2) {
        chart2.setOption(chartOptions.option2)
        window.addEventListener('resize', chart2.resize)
      }
      // 风险矛盾事件
      var chart3 = initChart(3)
      if (chart3) {
        chart3.setOption(chartOptions.option3)
        window.addEventListener('resize', chart3.resize)
      }

      // 态势分布
      var chart4 = initChart(4)
      fetchMap(function() {
        if (chart4) {
          chart4.setOption(chartOptions.option4)
          window.addEventListener('resize', chart4.resize)
        }
      })

      // 主要风险分布
      var chart5 = initChart(5)
      if (chart5) {
        chart5.setOption(chartOptions.option5)
        window.addEventListener('resize', chart5.resize)
      }

      // 风险单位
      var chart6 = initChart(6)
      if (chart6) {
        chart6.setOption(chartOptions.option6)
        window.addEventListener('resize', chart6.resize)
      }

      // 风险车辆
      var chart7 = initChart(7)
      if (chart7) {
        chart7.setOption(chartOptions.option7)
        window.addEventListener('resize', chart7.resize)
      }
    });
  </script>
</head>
<body class="body">
  <div class="container">
    <!-- 全屏、时间 -->
    <div class="funcs">
      <div class="date">
        <p id="dateD" class="d"></p>
        <p id="dateT" class="t"></p>
      </div>
      <div class="data">
        <div class="flex justify-between items-center">
          <div class="flex flex-col justify-center items-center">
            <p class="key">风险人员</p>
            <p class="value">${allpersoncount }</p>
          </div>
          <div class="flex flex-col justify-center items-center">
            <p class="key">风险矛盾事件</p>
            <p class="value">${eventcount }</p>
          </div>
          <div class="flex flex-col justify-center items-center">
            <p class="key">风险地址</p>
            <p class="value">${companycount }</p>
          </div>
          <div class="flex flex-col justify-center items-center">
            <p class="key">风险物品</p>
            <p class="value">${goodcount }</p>
          </div>
          <div class="flex flex-col justify-center items-center">
            <p class="key">风险车辆</p>
            <p class="value">${vehiclecount }</p>
          </div>
        </div>
      </div>
      <div class="btns">
        <div id="openFullScreen" class="btn">全屏</div>
        <div id="exitFullScreen" class="btn">退出</div>
      </div>
    </div>

    <!-- 数据面板 -->
    <div class="panels">
      <div class="layui-container">
        <div class="layui-col-space10 h-full">
          <div class="layui-col-sm3 layui-col-md3 layui-col-lg3 h-full">
            <div class="block block-1">
              <div class="decorators">
                <div class="tl"></div>
                <div class="tr"></div>
                <div class="bl"></div>
                <div class="br"></div>
              </div>

              <div class="block-inner">
                <div class="title">
                  <p>风险人员</p>
                </div>

                <div class="flex flex-col w-full h-full">
                  <div class="circles">
                    <div id="circle1" class="circle">
                      <div class="top">
                        <img src="./images/bg-8.png" class="ring ring1" />
                        <img src="./images/bg-9.png" class="ring ring2" />
                        <img src="./images/bg-10.png" class="ring ring3" />
                        <img src="./images/bg-11.png" class="ring ring4" />

                        <div class="outer">
                          <div class="inner">
                            <p>涉稳</p>
                            <p>${wencount}</p>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div id="circle2" class="circle">
                      <div class="top">
                        <img src="./images/bg-8.png" class="ring ring1" />
                        <img src="./images/bg-9.png" class="ring ring2" />
                        <img src="./images/bg-10.png" class="ring ring3" />
                        <img src="./images/bg-11.png" class="ring ring4" />

                        <div class="outer">
                          <div class="inner">
                            <p>涉黑</p>
                            <p>${heicount}</p>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div id="circle3" class="circle">
                      <div class="top">
                        <img src="./images/bg-8.png" class="ring ring1" />
                        <img src="./images/bg-9.png" class="ring ring2" />
                        <img src="./images/bg-10.png" class="ring ring3" />
                        <img src="./images/bg-11.png" class="ring ring4" />

                        <div class="outer">
                          <div class="inner">
                            <p>涉恐</p>
                            <p>${kongcount}</p>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div id="circle4" class="circle">
                      <div class="top">
                        <img src="./images/bg-8.png" class="ring ring1" />
                        <img src="./images/bg-9.png" class="ring ring2" />
                        <img src="./images/bg-10.png" class="ring ring3" />
                        <img src="./images/bg-11.png" class="ring ring4" />

                        <div class="outer">
                          <div class="inner">
                            <p>涉毒</p>
                            <p>${ducount}</p>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>

                  <div id="chart1" class="w-full h-full"></div>
                </div>
              </div>
            </div>

            <div class="block block-2">
              <div class="decorators">
                <div class="tl"></div>
                <div class="tr"></div>
                <div class="bl"></div>
                <div class="br"></div>
              </div>

              <div class="block-inner">
                <div class="title">
                  <p>风险矛盾事件</p>
                </div>

                <div class="flex flex-col w-full h-full">
                  <div class="item">
                    <div id="chart2" class="w-full h-full"></div>
                  </div>

                  <div id="chart3" class="w-full h-full"></div>
                </div>
              </div>
            </div>
          </div>

          <div class="layui-col-sm6 layui-col-md6 layui-col-lg6 h-full">
            <div class="block block-3">
              <h1 class="title">江阴市公安局风控平台全景数据看板</h1>

              <div class="w-full" style="position: relative; height: 90%; text-align: left;">
                <div id="todayData" class="data">
                  <div class="item toady1">
                    <p>风险人员</p>
                    <p>今日新增${adddatas[0].allperson}人</p>
                  </div>
                  <div class="item toady2">
                    <p>风险矛盾</p>
                    <p>今日新增${adddatas[0].allevent}项</p>
                  </div>
                  <div class="item toady3">
                    <p>风险单位</p>
                    <p>今日新增${adddatas[0].allcompany}家</p>
                  </div>
                  <div class="item toady4">
                    <p>风险车辆</p>
                    <p>今日新增${adddatas[0].allvehicle}辆</p>
                  </div>
                </div>
                <div id="yesterdayData" class="data">
                  <div class="item yesterday">
                    <p>风险人员</p>
                    <p>昨日新增${adddatas[1].allperson}人</p>
                  </div>
                  <div class="item yesterday">
                    <p>风险矛盾</p>
                    <p>昨日新增${adddatas[1].allevent}项</p>
                  </div>
                  <div class="item yesterday">
                    <p>风险单位</p>
                    <p>昨日新增${adddatas[1].allcompany}家</p>
                  </div>
                  <div class="item yesterday">
                    <p>风险车辆</p>
                    <p>昨日新增${adddatas[1].allvehicle}辆</p>
                  </div>
                </div>

                <div id="chart4" class="w-full h-full">
              </div>
              </div>
            </div>

            <div class="block block-4">
              <div class="decorators">
                <div class="tl"></div>
                <div class="tr"></div>
                <div class="bl"></div>
                <div class="br"></div>
              </div>

              <div class="block-inner">
                <div class="title">
                  <p>主要风险分布</p>
                </div>

                <div id="chart5" class="w-full h-full"></div>
              </div>
            </div>
          </div>
          <div class="layui-col-sm3 layui-col-md3 layui-col-lg3 h-full">
            <div class="block block-5">
              <div class="decorators">
                <div class="tl"></div>
                <div class="tr"></div>
                <div class="bl"></div>
                <div class="br"></div>
              </div>

              <div class="block-inner">
                <div class="title">
                  <p>风险单位</p>
                </div>

                <div id="chart6" class="w-full h-full"></div>
              </div>
            </div>

            <div class="block block-6">
              <div class="decorators">
                <div class="tl"></div>
                <div class="tr"></div>
                <div class="bl"></div>
                <div class="br"></div>
              </div>

              <div class="block-inner">
                <div class="title">
                  <p>风险车辆</p>
                </div>

                <div id="chart7" class="w-full h-full"></div>
              </div>
            </div>

            <div class="block block-7">
              <div class="decorators">
                <div class="tl"></div>
                <div class="tr"></div>
                <div class="bl"></div>
                <div class="br"></div>
              </div>

              <div class="block-inner">
                <div class="title">
                  <p>风险物品</p>
                </div>

                <div class="table">
                  <div class="thead">
                    <div class="tr">
                      <div class="th">物品编号</div>
                      <div class="th">物品名称</div>
                      <div class="th">收缴对象</div>
                      <div class="th">数量</div>
                    </div>
                  </div>
                  <div class="tbody">
                    <c:forEach items="${goods}" begin="1" end="5" var="row" varStatus="num">
	                    <div class="tr">
	                      <div class="td">...${fn:substring(row.codenum,14,18)}</div>
	                      <div class="td">${row.itemtype}</div>
	                      <div class="td">${row.sjdx}</div>
	                      <div class="td">${row.sl}</div>
	                    </div>
					</c:forEach>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>