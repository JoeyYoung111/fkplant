<%@ page contentType='text/html;charset=UTF-8' language='java'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<!DOCTYPE HTML>
<html>
  <head>
    <title>统计考核</title>
		<script type="text/javascript">
			$(document).ready(function(){
				var dom1 = document.getElementById("container1");
				var dom2 = document.getElementById("container2");
<%--				var dom3 = document.getElementById("container3");--%>
<%--				var dom4 = document.getElementById("container4");--%>
				var myChart1 = echarts.init(dom1);
				var myChart2 = echarts.init(dom2);
<%--				var myChart3 = echarts.init(dom3);--%>
<%--				var myChart4 = echarts.init(dom4);--%>
				
				var option1, option2, option3, option4;
				
				option1 = {
					tooltip: {
						trigger: 'axis',
						axisPointer: {
							type: 'shadow'
						}
					},
					legend: {},
					grid: {
						left: '3%',
						right: '4%',
						bottom: '3%',
						containLabel: true
					},
					xAxis: [{
						type: 'category',
						data: ${sendpoliceList},
						axisLabel: {
							interval: 0,
							rotate: 60, //倾斜度 -90 至 90 默认为0
							margin: 2,
							textStyle: {
								fontSize: "12px",
								color: "#000000"
						 }
						}
					}],
					yAxis: [{
						type: 'value'
					}],
					series: [{
						name: '条数',
						type: 'bar',
						barWidth: '60%',
						emphasis: {
							focus: 'series'
						},
						data: ${sendpolicecountList}
					}]
				};
				
				option2 = {
					tooltip: {
						trigger: 'axis',
						axisPointer: {
							type: 'shadow'
						}
					},
					legend: {},
					grid: {
						left: '3%',
						right: '4%',
						bottom: '3%',
						containLabel: true
					},
					xAxis: [{
						type: 'category',
						data: ${thsendpoliceList},
						axisLabel: {
							interval: 0,
							rotate: 60, //倾斜度 -90 至 90 默认为0
							margin: 2,
							textStyle: {
								fontSize: "12px",
								color: "#000000"
						 }
						}
					}],
					yAxis: [{
						type: 'value'
					}],
					series: [{
						name: '条数',
						type: 'bar',
						barWidth: '60%',
						emphasis: {
							focus: 'series'
						},
						data: ${thsendpolicecountList}
					}]
				};
				
				if (option1 && typeof option1 === 'object') {
					myChart1.setOption(option1);
				}
				if (option2 && typeof option2 === 'object') {
					myChart2.setOption(option2);
				}
				if (option3 && typeof option3 === 'object') {
					myChart3.setOption(option3);
				}
				if (option4 && typeof option4 === 'object') {
					myChart4.setOption(option4);
				}
			});
		</script>
	</head>
  
	<body class="childrenBody">
		<div class="h100 shedu">
			<div class="layui-card top-panel">
				<div class="layui-card-header bg-blue">统计考核</div>
				<div class="layui-card-body">
					<div class="layui-row my-border-b  shedu-title">
						报送数<span class="my-font-green"><c:if test="${!empty zj}">${zj }</c:if><c:if test="${empty zj}">0</c:if></span>条，
						采用数<span class="my-font-red"><c:if test="${!empty cy}">${cy }</c:if><c:if test="${empty cy}">0</c:if></span>条，
						退回数<span class="my-font-orange"><c:if test="${!empty th}">${th }</c:if><c:if test="${empty th}">0</c:if></span>条。
					</div>
					<div class="layui-row" style="height: 400px;">
						<div class="layui-col-lg6 h100">
							<div class="my-font-blue shedu-sub-title">
								派出所报送条数
							</div>
							<div id="container1" class="h90"></div>
						</div>
						<div class="layui-col-lg6 my-border-l h100">
							<div class="my-font-blue shedu-sub-title">
								派出所退回条数
							</div>
							<div id="container2" class="h90"></div>
						</div>
					</div>
				</div>
			</div>
<%--			<div class="layui-card top-panel">--%>
<%--				<div class="layui-card-header bg-blue">制贩毒人员</div>--%>
<%--				<div class="layui-card-body">--%>
<%--					<div class="layui-row my-border-b shedu-title" >--%>
<%--						共计<span class="my-font-green"><c:if test="${!empty zfdzj}">${zfdzj }</c:if><c:if test="${empty zfdzj}">0</c:if></span>人，--%>
<%--						本地在册<span class="my-font-red"><c:if test="${!empty zfdbdzc}">${zfdbdzc }</c:if><c:if test="${empty zfdbdzc}">0</c:if></span>人，--%>
<%--						外来前科<span class="my-font-orange"><c:if test="${!empty zfdwlqk}">${zfdwlqk }</c:if><c:if test="${empty zfdwlqk}">0</c:if></span>人。--%>
<%--					</div>--%>
<%--					<div class="layui-row" style="height: 400px;">--%>
<%--						<div class="layui-col-lg6 h100">--%>
<%--							<div class="my-font-blue shedu-sub-title">--%>
<%--								派出所管控分析--%>
<%--							</div>--%>
<%--							<div id="container3" class="h90"></div>--%>
<%--						</div>--%>
<%--						<div class="layui-col-lg6 my-border-l h100">--%>
<%--							<div class="my-font-blue shedu-sub-title">--%>
<%--								派出所管控统计--%>
<%--							</div>--%>
<%--							<div id="container4" class="h90"></div>--%>
<%--						</div>--%>
<%--					</div>--%>
<%--				</div>--%>
<%--			</div>--%>
		</div>
  	</body>
</html>