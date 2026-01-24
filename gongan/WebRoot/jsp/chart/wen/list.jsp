<%@ page contentType='text/html;charset=UTF-8' language='java'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<!DOCTYPE HTML>
<html>
  <head>
    <title>涉稳人员统计</title>
		<script type="text/javascript">
			$(document).ready(function(){
				//人员图片展示栏
				var swiper = new Swiper(".mySwiper1", {
					slidesPerView: 4,
					centeredSlides: false,
					spaceBetween: 5,
					pagination: {
						el: ".swiper-pagination1",
						type: "fraction",
					},
					navigation: {
						nextEl: ".swiper-button-next1",
						prevEl: ".swiper-button-prev1",
					},
				});
				var swiper2 = new Swiper(".mySwiper2", {
					slidesPerView: 4,
					centeredSlides: false,
					spaceBetween: 20,
					pagination: {
						el: ".swiper-pagination2",
						type: "fraction",
					},
					navigation: {
						nextEl: ".swiper-button-next2",
						prevEl: ".swiper-button-prev2",
					},
				});
				var swiper3 = new Swiper(".mySwiper3", {
					slidesPerView: 4,
					centeredSlides: false,
					spaceBetween: 20,
					pagination: {
						el: ".swiper-pagination3",
						type: "fraction",
					},
					navigation: {
						nextEl: ".swiper-button-next3",
						prevEl: ".swiper-button-prev3",
					},
				});
				
				//柱状图、饼状图
				var dom1 = document.getElementById("container1");
				var dom2 = document.getElementById("container2");
				var myChart1 = echarts.init(dom1);
				var myChart2 = echarts.init(dom2);
				
				var option1 = {
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
						data: ${departmentList },
						axisLabel: {
							interval: 0,
							rotate: 60, //倾斜度 -90 至 90 默认为0
							margin: 2,
							fontSize: "12px",
							color: "#000000"
						}
					}],
					yAxis: [{
						type: 'value'
					}],
					series: [{
							name: '一级',
							type: 'bar',
							stack: 'Ad',
							emphasis: {
								focus: 'series'
							},
							data: ${pcsonecount },
							color:"#3696D2"
						},
						{
							name: '二级',
							type: 'bar',
							stack: 'Ad',
							emphasis: {
								focus: 'series'
							},
							data: ${pcstwocount },
							color:"#FFAD00"
						},
						{
							name: '三级',
							type: 'bar',
							stack: 'Ad',
							emphasis: {
								focus: 'series'
							},
							data: ${pcsthreecount },
							color:"#86CC2B"
						}
					]
				};
				
				option2 = {
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
						name: '管控涉稳人数',
						type: 'pie',
						radius: ['25%', '75%'], //两个表示环：内半径,外半径
						center: ['53%', '48%'], //左右，上下
						avoidLabelOverlap: false,
						data: ${piemodelList},
						emphasis: {
							itemStyle: {
								shadowBlur: 10,
								shadowOffsetX: 0,
						 	shadowColor: 'rgba(0, 0, 0, 0.5)'
							}
						}
			
					}]
				};
				
				if (option1 && typeof option1 === 'object') {
					myChart1.setOption(option1);
				}
				if (option2 && typeof option2 === 'object') {
					myChart2.setOption(option2);
				}
			});
			
			layui.use(['form'], function(){
				
			});
			
			function showPersonInfo(id){
				console.log(id);
				var index = layui.layer.open({
					title : "风险人员-涉稳详情",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content : "<c:url value='/getWenGradeUpdate.do'/>?id="+id+'&menuid='+${menuid}+'&page=showinfo',
					area: ['800', '750px'],
					maxmin: true,
					success : function(layero, index){
						setTimeout(function(){
							layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
								tips: 3
							});
						},500)
					}
				})			
				layui.layer.full(index);
			}
		</script>
	</head>
  
	<body class="childrenBody" style="background-color: #EEEEEE;">
		<div class="h100">
			<div class="layui-row h40 layui-col-space10">
				<div class="layui-col-lg12 h100">
					<div class="layui-card top-panel h100">
						<div class="layui-card-header my-font-blue">风险人员联控实况</div>
						<div class="layui-card-body "style="display: flex;justify-content: space-around;">
							<div class="border-blue" style="width: 32%;">
								<div class="bg-blue text-align-c swiper-title">
									在京人员
								</div>
								<div class="swiper-box">
									<div #swiperRef="" class="swiper mySwiper1">
										<div class="swiper-wrapper">
											<c:forEach items="${zjpersonelList}" var="row" varStatus="num">
												<div class="swiper-slide text-align-c">
													<span style="cursor: pointer;" onclick="showPersonInfo('${row.id }')"><font color='blue'>${row.personname }</font></span>
												</div>
											</c:forEach>
										</div>
										<!-- <div class="swiper-pagination1"></div> -->
									</div>
									<div class="my-swiper-button-next swiper-button-next1"></div>
									<div class="my-swiper-button-prev swiper-button-prev1"></div>
								</div>
							</div>
							<div class="border-green" style="width: 32%;">
								<div class="bg-green text-align-c swiper-title">
									在宁人员
								</div>
								<div class="swiper-box">
									<div #swiperRef="" class="swiper mySwiper2">
										<div class="swiper-wrapper">
										<!-- 
											<c:forEach items="${znpersonelList}" var="row" varStatus="num">
												<div class="swiper-slide text-align-c">
													<c:if test="${not empty row.id}">
														<img src="/../uploadFiles/pictures/${row.fileallName }" height="130px" width="70px">
														<span style="cursor: pointer;" onclick="showPersonInfo('${row.id }')">${row.personname }</span>
													</c:if>
													<c:if test="${empty row.id}">
														<img src="<c:url value='/images/nophoto.png'/>" height="130px" width="70px">
														<span style="cursor: pointer;" onclick="showPersonInfo('${row.id }')">${row.personname }</span>
													</c:if>
												</div>
											</c:forEach>
										-->
											<c:forEach items="${znpersonelList}" var="row" varStatus="num">
												<div class="swiper-slide text-align-c">
													<span style="cursor: pointer;" onclick="showPersonInfo('${row.id }')"><font color='blue'>${row.personname }</font></span>
												</div>
											</c:forEach>
										</div>
										<!-- <div class="swiper-pagination2"></div> -->
									</div>
									<div class="my-swiper-button-next swiper-button-next2"></div>
									<div class="my-swiper-button-prev swiper-button-prev2"></div>
								</div>
							</div>
							<div class="border-purple" style="width: 32%;">
								<div class="bg-purple text-align-c swiper-title">
									下落不明人员
								</div>
								<div class="swiper-box">
									<div #swiperRef="" class="swiper mySwiper3">
										<div class="swiper-wrapper">
										<!-- 
											<c:forEach items="${xlbmpersonelList}" var="row" varStatus="num">
												<div class="swiper-slide text-align-c">
													<c:if test="${not empty row.id}">
														<img src="/../uploadFiles/pictures/${row.fileallName }" height="130px" width="70px">
														<span style="cursor: pointer;" onclick="showPersonInfo('${row.id }')">${row.personname }</span>
													</c:if>
													<c:if test="${empty row.id}">
														<img src="<c:url value='/images/nophoto.png'/>" height="130px" width="70px">
														<span style="cursor: pointer;" onclick="showPersonInfo('${row.id }')">${row.personname }</span>
													</c:if>
												</div>
											</c:forEach>
										 -->	
										<c:forEach items="${xlbmpersonelList}" var="row" varStatus="num">
											<div class="swiper-slide text-align-c">
												<span style="cursor: pointer;" onclick="showPersonInfo('${row.id }')"><font color='blue'>${row.personname }</font></span>
											</div>
										</c:forEach>
										</div>
										<!-- <div class="swiper-pagination3"></div> -->
									</div>
									<div class="my-swiper-button-next swiper-button-next3"></div>
									<div class="my-swiper-button-prev swiper-button-prev3"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="layui-row h30 layui-col-space10">
				<div class="layui-col-lg12">
					<div class="layui-card top-panel">
						<div class="layui-card-header my-font-blue">风险人员实时底数</div>
						<div class="layui-card-body">
							 <div class="">
							 	经滚动排摸，目前我市在控涉稳人员
							 </div>
							 <div class="btn-box">
							 	<div class="shewen-btn bg-green">
									<span>总计</span>
									<span>${totalcount}</span>
							 	</div>
								<div class="shewen-btn bg-blue">
									<span>一级</span>
									<span>${onecount}</span>
								</div>
								<div class="shewen-btn bg-pink">
									<span>二级</span>
									<span>${twocount}</span>
								</div>
								<div class="shewen-btn bg-yello">
									<span>三级</span>
									<span>${threecount}</span>
								</div>
								<div class="shewen-btn bg-purple" style="width: 250px;">
									<span>警种、派出所先行自控</span>
									<span>${selfcount}</span>
								</div>
							 </div>
						</div>
					</div>
				</div>
			</div>
			<div class="layui-row layui-col-space10">
				<div class="layui-col-lg6">
					<div class="layui-card top-panel">
						<div class="layui-card-header my-font-blue">派出所分级管控统计</div>
						<div class="layui-card-body" style="height: 400px;">
							<div id="container1" class="h90"></div> 
						</div>
					</div>
				</div>
				<div class="layui-col-lg6">
					<div class="layui-card top-panel">
						<div class="layui-card-header my-font-blue">责任警种分类管控统计</div>
						<div class="layui-card-body" style="height: 400px;">
							<div id="container2" class="h90"></div> 
						</div>
					</div>
				</div>
			</div>
		</div>
  	</body>
</html>