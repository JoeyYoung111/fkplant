<%@ page contentType='text/html;charset=UTF-8' language='java'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<!DOCTYPE HTML>
<html>
  <head>
    <title>涉恐人员统计</title>
		<script type="text/javascript">
			$(document).ready(function(){
				var dom1 = document.getElementById("container1");
				var dom2 = document.getElementById("container2");
				var dom3 = document.getElementById("container3");
				var myChart1 = echarts.init(dom1);
				var myChart2 = echarts.init(dom2);
				var myChart3 = echarts.init(dom3);
				
				var option1, option2, option3;
				option1 = {
					title: {
						text: '',
						subtext: '',
						left: 'center'
					},
					tooltip: {
						trigger: 'item'
					},
					legend: {
						orient: 'vertical',
						left: 'left'
					},
					series: [{
						name: '管控涉恐人数',
						type: 'pie',
						radius: ['25%', '75%'], //两个表示环：内半径,外半径
						center: ['43%', '48%'], //左右，上下
						avoidLabelOverlap: false,
						color:["#bb1600","#ff7900","#fdd400","#3696d2"],
						data: ${jsonList},
						emphasis: {
							itemStyle: {
								shadowBlur: 10,
								shadowOffsetX: 0,
						 	shadowColor: 'rgba(0, 0, 0, 0.5)'
							}
						}
			
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
						data: ${nativeplaceList},
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
						name: '人数',
						type: 'bar',
						barWidth: '60%',
						emphasis: {
							focus: 'series'
						},
						color:"#74be41",
						data: ${countList}
					}]
				};
				option3 = {
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
						data: ${policeList},
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
						name: '人数',
						type: 'bar',
						barWidth: '60%',
						emphasis: {
							focus: 'series'
						},
						color:"#3696d2",
						data: ${policecountList}
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
			});
		</script>
	</head>
  
	<body class="childrenBody" style="background-color: #EEEEEE;">
		<div class="h100">
			<div class="layui-row layui-col-space15">
				<div class="layui-col-lg6 layui-col-md6">
					<div class="layui-card top-panel">
						<div class="layui-card-header my-font-blue">汇总情况</div>
						<div class="layui-card-body" style="height: 250px;">
							 <div class="">
							 	截至目前，我市涉恐人员人数共<span class="my-font-green my-font18">${sum}</span>人。
							 </div>
							 <div class="btn-box">
							 	<c:forEach items="${kongextendList}" var="row" varStatus="num">
							 		<c:if test="${row.jointtype eq 1}">
							 			<div class="shekong-btn border-red my-font-red">
											<span>红色</span>
											<span>${row.personcount}</span>
										</div>
							 		</c:if>
							 		<c:if test="${row.jointtype eq 2}">
							 			<div class="shekong-btn border-orange my-font-orange">
									 		<span>橙色</span>
									 		<span>${row.personcount}</span>
									 	</div>
							 		</c:if>
							 		<c:if test="${row.jointtype eq 3}">
							 			<div class="shekong-btn border-yello my-font-yello">
									 		<span>黄色</span>
									 		<span>${row.personcount}</span>
									 	</div>
							 		</c:if>
							 		<c:if test="${row.jointtype eq 4}">
							 			<div class="shekong-btn border-blue my-font-blue">
									 		<span>蓝色</span>
									 		<span>${row.personcount}</span>
									 	</div>
							 		</c:if>
								</c:forEach>
							 </div>
						</div>
					</div>
				</div>
				<div class="layui-col-lg6 layui-col-md6">
					<div class="layui-card top-panel">
						<div class="layui-card-header my-font-blue">联控级别</div>
						<div class="layui-card-body" style="height: 250px;">
							<div id="container1" class="h100"></div> 
						</div>
					</div>
				</div>
			</div>
			<div class="layui-row layui-col-space15">
				<div class="layui-col-lg6 layui-col-md6">
					<div class="layui-card top-panel">
						<div class="layui-card-header my-font-blue">在澄关注人员户籍分布</div>
						<div class="layui-card-body" style="height: 400px;">
							<div id="container2" class="h90"></div> 
						</div>
					</div>
				</div>
				<div class="layui-col-lg6 layui-col-md6">
					<div class="layui-card top-panel">
						<div class="layui-card-header my-font-blue">在澄关注人员辖区分布</div>
						<div class="layui-card-body" style="height: 400px;">
							<div id="container3" class="h90"></div> 
						</div>
					</div>
				</div>
			</div>
			<div class="layui-row layui-col-space15">
				<div class="layui-col-lg6 layui-col-md6">
					<div class="layui-card top-panel">
						<div class="layui-card-header my-font-blue">最新三日一走访</div>
						<div class="layui-card-body" style="height: 300px; overflow-y: scroll;">
							<table class="layui-table" lay-skin="nob">
								<colgroup>
									<col width="100">
									<col width="150">
									<col>
									<col width="100">
								</colgroup>
								<tbody>
									<c:forEach items="${zfresult}" var="row" varStatus="num">
										<tr class="my-border-b">
											<td align="center">${row.personname }</td>
											<td align="center">${row.controltime }</td>
											<td align="center">
												<font size="2" title="${row.controlcontent }">
													<c:if test="${fn:length(row.controlcontent)>15}">
														${fn:substring(row.controlcontent,0,15) }......
													</c:if>
													<c:if test="${fn:length(row.controlcontent)<16}">
														${row.controlcontent }
													</c:if>
												</font>
											</td>
											<td align="center">${row.addoperator }</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="layui-col-lg6 layui-col-md6">
					<div class="layui-card top-panel">
						<div class="layui-card-header my-font-blue">最新每月评估</div>
						<div class="layui-card-body" style="height: 300px; overflow-y: scroll;">
							<table class="layui-table" lay-skin="nob">
								<colgroup>
									<col width="100">
									<col width="150">
									<col>
									<col width="100">
								</colgroup>
								<tbody>
									<c:forEach items="${pgresult}" var="row" varStatus="num">
										<tr class="my-border-b">
											<td align="center">${row.personname }</td>
											<td align="center">${row.controltime }</td>
											<td align="center">
												<font size="2" title="${row.controlcontent }">
													<c:if test="${fn:length(row.controlcontent)>15}">
														${fn:substring(row.controlcontent,0,15) }......
													</c:if>
													<c:if test="${fn:length(row.controlcontent)<16}">
														${row.controlcontent }
													</c:if>
												</font>
											</td>
											<td align="center">${row.addoperator }</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
  	</body>
</html>