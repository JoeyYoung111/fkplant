<%@ page contentType='text/html;charset=UTF-8' language='java'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<!DOCTYPE HTML">
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body class="body">
  <div class="container">
    <!-- 数据面板 -->
    <div class="panels">
      <div class="layui-container">
        <div class="layui-col-space15 h-full">
          <div class="layui-col-sm6 layui-col-md6 layui-col-lg6 h-full">
            <div class="block block-1">
              <div class="flex flex-between items-center w-full h-full">
                <div class="item item1">
                  <div id="chart1" class="chart"></div>

                  <p class="key">矛盾总数</p>
                  <p class="value">${eventcount}</p>
                </div>
                <div class="item item2">
                  <p class="key">已化解</p>
                  <p class="value">${cdtresults[0].value}</p>
                </div>
                <div class="item item3">
                  <p class="key">已钝化</p>
                  <p class="value">${cdtresults[1].value}</p>
                </div>
                <div class="item item4">
                  <p class="key">处置中</p>
                  <p class="value">${cdtresults[2].value}</p>
                </div>
                <div class="item item5">
                  <div id="chart2" class="w-full h-full"></div>
                </div>
              </div>
            </div>

            <div class="block block-2">
              <div class="title">
                <p>矛盾区域分布统计</p>
              </div>

              <div id="chart3" class="w-full h-full"></div>
            </div>

            <div class="block block-3">
              <div class="title">
                <p>矛盾类别统计</p>
              </div>

              <div id="chart4" class="w-full h-full"></div>
            </div>
          </div>

          <div class="layui-col-sm6 layui-col-md6 layui-col-lg6 h-full">
            <div class="block block-4">
              <div class="title">
                <p>矛盾风险分析</p>
              </div>

              <div id="chart5" class="w-full h-full"></div>
            </div>

            <div class="block block-5">
              <div class="title">
                <p>矛盾人数统计</p>
              </div>

              <div id="chart6" class="w-full h-full"></div>
            </div>

            <div class="block block-6">
              <div class="title">
                <p>矛盾每月趋势</p>
              </div>

              <div id="chart7" class="w-full h-full"></div>
            </div>

            <div class="block block-7">
              <div class="title">
                <p>新入库矛盾</p>

                <div onclick="toEvent()" class="btn">
                  <img src="./images/icon-6.png">
                  <p>More</p>
                </div>
              </div>

              <div class="table">
                <div class="tbody">
                  <c:forEach items="${events}" begin="1" end="6" var="row" varStatus="num">
	                    <div class="tr">
	                      <div class="td file" width="200px">${row.cdtname}</div>
	                      <div class="td">${row.ssrs}</div>
	                      <div class="td">${row.cdtlevel}</div>
	                      <c:if test="${row.nowstate eq 1}"><div class="td pending">新申请（未审核）</div></c:if>
	                      <c:if test="${row.nowstate eq 2}"><div class="td pass">已审核（通过）</div></c:if>
	                      <c:if test="${row.nowstate eq 3}"><div class="td nopass">已审核（不通过）</div></c:if>
	                      <div class="td">${row.addtime}</div>
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
  <script type="text/javascript">
    var chartOptions = {
      option1: {
        color: ['#0000ff'],
        xAxis: {
          type: 'category',
          data: _extractData(${trend}, 'text'),
          show: false,
          axisLine: {
            show: false
          },
          splitLine: {
            show: false
          },
          axisLabel: {
            interval: 0
          },
          axisTick: {
            show: false
          },
        },
        yAxis: {
          type: 'value',
          show: false,
          axisLine: {
            show: false
          },
          splitLine: {
            show: false
          },
          axisLabel: {
            interval: 0
          },
          axisTick: {
            show: false
          },
        },
        series: [
          {
            data: _extractData(${trend}, 'value'),
            type: 'line',
            symbol: 'none',
            smooth: true
          }
        ]
      },

      option2: {
        series: [
          {
            type: 'gauge',
            radius: '100%',
            startAngle: 180,
            endAngle: 0,
            min: 0,
            max: 100,
            progress: {
              show: true,
              roundCap: true,
              width: 8,
              itemStyle: {
                // 前景色
                color: '#15d187',
              },
            },
            pointer: {
              show: false
            },
            axisLine: {
              roundCap: true,
              lineStyle: {
                width: 8,
                // 背景色
                color: [[1, '#d2f6e9']]
              }
            },
            axisTick: {
              show: false,
            },
            splitLine: {
              show: false
            },
            axisLabel: {
              show: false
            },
            title: {
              offsetCenter: [0, '-15%'],
              fontSize: calcfontSize(14),
              fontWeight: 'bold'
            },
            detail: {
              offsetCenter: [0, '70%'],
              formatter: function (value) {
                return value + '%'
              },
              color: '#15d187'
            },
            data: [
              {
                name: '化解率',
                value: (${cdtresults[0].value}/${eventcount}*100).toFixed(1)
              }
            ]
          }
        ]
      },

      option3: {
        tooltip: {
          trigger: 'item',
          formatter: '{b}：{c}%'
        },
        legend: {
          orient: 'vertical',
          y: 'center',
          x: 'right'
        },
        gird: {
          left: 0,
        },
        series: [
          {
            name: '矛盾总数',
            type: 'pie',
            color: ['#051640'],
            tooltip: {
              show: false
            },
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            // 边框大小
            radius: [0, '40%'],
            // 边框位置
            center: ['35%', '50%'],
            emphasis: {
              disabled: true
            },
            label: {
              show: true,
              position: 'center',
              formatter: '矛盾总数\n\n{c}',
              textStyle: {
                color: '#fff',
                fontSize: calcfontSize(16)
              }
            },
            data: [
              {
                value: ${eventcount},
                // itemStyle: {
                //   normal: {
                //     borderWidth: 3,
                //     borderColor: '#fff'
                //   }
                // }
              }
            ]
          },
          {
            name: '矛盾区域分布统计',
            type: 'pie',
            radius: ['40%', '140%'],
            center: ['35%', '50%'],
            roseType: 'area',
            data: ${eventpercent}
          }
        ]
      },
      
      option4: {
        tooltip: {
          trigger: 'item'
        },
        textStyle: {
          color: '#000'
        },
        radar: {
          axisLine: {
            lineStyle: {
                color: '#18a3ff'
            },
          },
          splitLine: {
            lineStyle: {
                color: '#18a3ff'
            }
          },
          splitArea: {
            // 图表背景的颜色
            areaStyle: {
              color:  ['#fff', '#21456a'],
            },
          },
          indicator: ${indicator},
        },
        series: [
          {
            name: '矛盾类别统计',
            type: 'radar',
            lineStyle: {
              color: '#18a3ff',
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
                    color: '#000'
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

      option5: {
        tooltip: {
          trigger: 'item',
          formatter: '{a}：{c}%'
        },
        legend: {
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
            name: '${cdtlevels[0].text}',
            type: 'bar',
            stack: 'total',
            itemStyle: {
              color: '#ff00c9',
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
            data: [(${cdtlevels[0].value}/${eventcount}*100).toFixed(1)]
          },
          {
            name: '${cdtlevels[1].text}',
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
            data: [(${cdtlevels[1].value}/${eventcount}*100).toFixed(1)]
          },
          {
            name: '${cdtlevels[2].text}',
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
            data: [(${cdtlevels[2].value}/${eventcount}*100).toFixed(1)]
          },
          {
            name: '${cdtlevels[3].text}',
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
            data: [(${cdtlevels[3].value}/${eventcount}*100).toFixed(1)]
          },
          {
            name: '${cdtlevels[4].text}',
            type: 'bar',
            stack: 'total',
            itemStyle: {
              color: '#4e37f6',
              borderWidth: 1,
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
            data: [(${cdtlevels[4].value}/${eventcount}*100).toFixed(1)]
          }
        ]
      },

      option6: {
        textStyle: {
          color: '#000'
        },
        tooltip: {
          trigger: 'axis'
        },
        grid: {
          top: '5%',
          left: 0,
          right: '1%',
          bottom: 0,
          containLabel: true
        },
        xAxis: {
          axisLine: {
            lineStyle: {
               color: '#ccccff'
            }
          },
          splitLine: {
            show: false,
            lineStyle: {
               color: '#ccccff'
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
          data: _extractData(${ssrss}, 'text')
        },
        yAxis: [
          {
            type: 'value',
            axisLine: {
              show: true,
              lineStyle: {
                color: '#ccccff'
              }
            },
            splitLine: {
              lineStyle: {
                color: '#ccccff'
              }
            }
          },
          {
            axisLine: {
              show: true,
              lineStyle: {
                color: '#ccccff'
              }
            }
          }
        ],
        series: [
          {
            type: 'bar',
            color: '#8080ff',
            emphasis: {
              itemStyle: {
                color: '#ff85ff'
              }
            },
            data: _extractData(${ssrss}, 'value')
          }
        ]
      },

      option7: {
        textStyle: {
          color: '#a0b3cf'
        },
        tooltip: {
          trigger: 'axis'
        },
        grid: {
          top: '5%',
          left: 0,
          right: '1%',
          bottom: 0,
          containLabel: true
        },
        xAxis: {
          axisLine: {
            lineStyle: {
              color: '#ccccff',
              type: 'dashed'
            }
          },
          splitLine: {
            show: false,
            lineStyle: {
               color: '#ccccff'
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
          data: _extractData(${trend}, 'name')
        },
        yAxis: {
          type: 'value',
          axisLine: {
            show: false
          },
          splitLine: {
            lineStyle: {
              color: '#ccccff',
              type: 'dashed'
            }
          }
        },
        series: [
          {
            type: 'bar',
            color: '#2c7be5',
            barWidth: 8,
            itemStyle: {
              borderWidth: 1,
              borderColor: '#0000ff',
              borderRadius: 20
            },
            data: _extractData(${trend}, 'value')
          }
        ]
      }
    }

    function initChart(index) {
      var dom = document.getElementById('chart'+index)

      if (!dom) return

      var chart = echarts.init(dom)

      return chart
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

      // 表格循环滚动
      window.setInterval(handleTableScroll, 2000)

      // 图表渲染
      // 矛盾总数
      var chart1 = initChart(1)
      if (chart1) {
        chart1.setOption(chartOptions.option1)
        window.addEventListener('resize', chart1.resize)
      }

      // 化解率
      var chart2 = initChart(2)
      if (chart2) {
        chart2.setOption(chartOptions.option2)
        window.addEventListener('resize', chart2.resize)
      }

      // 矛盾区域分布统计
      var chart3 = initChart(3)
      if (chart3) {
        chart3.setOption(chartOptions.option3)
        window.addEventListener('resize', chart3.resize)
      }

      // 矛盾类别统计
      var chart4 = initChart(4)
      if (chart4) {
        chart4.setOption(chartOptions.option4)
        window.addEventListener('resize', chart4.resize)
      }

      // 矛盾风险分析
      var chart5 = initChart(5)
      if (chart5) {
        chart5.setOption(chartOptions.option5)
        window.addEventListener('resize', chart5.resize)
      }

      // 矛盾人数统计
      var chart6 = initChart(6)
      if (chart6) {
        chart6.setOption(chartOptions.option6)
        window.addEventListener('resize', chart6.resize)
      }

      // 矛盾每月趋势
      var chart7 = initChart(7)
      if (chart7) {
        chart7.setOption(chartOptions.option7)
        window.addEventListener('resize', chart7.resize)
      }
    });
    function toEvent(){
    	parent.$('a[data-title=矛盾风险信息]').click();
    }
  </script>
</body>
</html>