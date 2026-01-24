<%@ page contentType='text/html;charset=UTF-8' language='java'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ page import="com.aladdin.model.UserSession"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	<base href="<%=basePath%>">

	<title>情报详情</title>
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
	<link rel="stylesheet" href="<c:url value='/css/public.css'/>" media="all" />
	<link rel="stylesheet" href="<c:url value='/css/qingbao.css'/>"/>
	<link rel="stylesheet" href="<c:url value='/css/timeaxis/css/style2.css'/>"/>
	<script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/js/jquery.form.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/js/cardnumber.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/js/viewer.js"/>"></script>
	<style type="text/css">
		.font17{
			font-size:17px;
		}
		.font15{
			font-size:15px;
		}
		.font-blue-lh{
			font-size:20px;
			color: #4ab0fd;
		    font-weight: 400;
		}
	</style>
	
	</head>
	<%
	UserSession userSession = (UserSession) session.getAttribute("userSession");
	%> 
<body class="childrenBody">
	<input type="hidden" id="id" value="${id}"/>
	<input type="hidden" id="informationid" value="${informationid}"/>
	<input type="hidden" id="specialid" value="${specialid}"/>
	<input type="hidden" id="validflag" value="${validflag}"/>
	<input type="hidden" id="receiveid" name="receiveid" value="<%=userSession.getLoginUserDepartmentid()%>"/>
	<button type="button" style="display:none" id="searchInformation" onclick="shuaxin();"></button>
	<button type="button" style="display:none" id="searchInformationReport" onclick="shuaxin();"></button>
	
	<div class="layui-row layui-col-space15 qingbao">
		<div class="layui-col-lg3 layui-col-md3">
			<div class="layui-card top-panel border-blue">
				<div class="layui-card-header bg-blue">情报时光轴</div>
				<div class="layui-card-body " style="overflow-y: scroll;height: 700px;">
					<div class="content">
						<div class="wrapper">
							<div class="main">
								<h1 class="title">情报日志</h1>
								<div class="year">
									<h2><i></i></h2>
									<div class="list">
										<ul>
											<c:forEach items="${infoTimeLineList}" var="row" varStatus="num">
												<li class="cls">
													<p class="date">${row.addtime}</p>
													<p class="intro" style='cursor:pointer' onclick="rizhi('${row.informationreceiveid}','${row.title}','${row.infoAnnotationid}','${row.informationsendid}','${row.infoid}');">${row.title}</p>
													
													<div class="more">
														<p>${row.content}</p>
													</div>
												</li>
											</c:forEach>
										<ul>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="layui-col-lg6 layui-col-md6">
			<div class="layui-card top-panel border-green">
				<div class="layui-card-header bg-green">情报内容</div>
				<div class="layui-card-body layui-row" style="position: relative;height: 700px;">
					<div class="qingbao-title my-border-b font-blue-lh">${info.infotitle}</div>
					<div class="qingbao-cont my-border-b font17">
						<div class="qingbao-cont-top">
							上报时间:${info.addtime} 采集人:${info.addoperator}
						</div>
						<br>
						<div class="qingbao-cont-center">
							${info.infocontent}
						</div>
						<div class="qingbao-cont-bottom">
							<div class="">
								承办人:${info.addoperator}
							</div>
							<div class="">
								核稿人:${info.reviewer}
							</div>
							<div class="">
								签收人:${info.issuer}
							</div>
						</div>
					</div>
					<div class="qingbao-bnt">
						<c:if test="${page eq 'jiebao'}">
							<c:if test="${validflag==1}">
								<button class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more news-table-btn" onclick="tuihui();">退</button>
								<button class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more news-table-btn" onclick="zhuanyue();">转</button>
								<button class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more news-table-btn" onclick="pizhu();">批</button>
								<button class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more news-table-btn" onclick="zhiding();">顶</button>
								<button class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more news-table-btn" onclick="zhuanxiang();">专</button>
								<button class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more news-table-btn" onclick="zhibao();">直</button>
								<button class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more news-table-btn" onclick="daochu();">导</button>
								<button class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more news-table-btn" onclick="guanzhu();">关</button>
							</c:if>
							<c:if test="${validflag>1}">
								<button class="layui-btn layui-bg-gray layui-btn-sm layui-icon my-btn-more news-table-btn" onclick="tuihui();">退</button>
								<button class="layui-btn layui-bg-gray layui-btn-sm layui-icon my-btn-more news-table-btn" onclick="zhuanyue();">转</button>
								<button class="layui-btn layui-bg-gray layui-btn-sm layui-icon my-btn-more news-table-btn" onclick="pizhu();">批</button>
								<button class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more news-table-btn" onclick="zhiding();">顶</button>
								<button class="layui-btn layui-bg-gray layui-btn-sm layui-icon my-btn-more news-table-btn" onclick="zhuanxiang();">专</button>
								<button class="layui-btn layui-bg-gray layui-btn-sm layui-icon my-btn-more news-table-btn" onclick="zhibao();">直</button>
								<button class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more news-table-btn" onclick="daochu();">导</button>
								<button class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more news-table-btn" onclick="guanzhu();">关</button>
							</c:if>
						</c:if>
						<c:if test="${page eq 'tuihui'}">
							<button class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more news-table-btn" onclick="daochu();">导</button>
						</c:if>
					</div>
				</div>
			</div>
		</div>
		
		<div class="layui-col-lg3 layui-col-md3">
			<div class="layui-card top-panel border-purple">
				<div class="layui-card-header bg-purple">其他信息</div>
				<div class="layui-card-body font15" style="height: 700px;">
					
					<div class="h50 text-box1">
						<div class="text-title1">
							<span>主报送单位 :</span>
							<span>${info.submitunit}</span>
						</div>
						<div class="text-title1">
							<span>其他报送单位 :</span>
							<span>${info.otherunit}</span>
						</div>
						<div>
							${info.infosource}|${info.urgentflag}|${info.infostate}|${info.infotype}
						</div>
						<div>
							<span>指向地址1:</span>
							<span>${info.pointaddress1}</span>
						</div>
						<div>
							<span>指向地址2:</span>
							<span>${info.pointaddress2}</span>
						</div>
						<div>
						<span>地址描述:</span>
							<span>${info.pointaddress3}</span>
						</div>
						<div>
							<span>涉及人员:</span>
							<c:forEach items="${infoJointList}" var="row" varStatus="num">
								<span>${row.jointName}(${row.jointCardNumber})、</span>
							</c:forEach>
						</div>
						<div>
							<span>附件:</span>
							<c:forEach items="${files}" var="row" varStatus="num">
								<a href="<c:url value="/downUpfile.do" />?fileid=${row.id }">${row.fileName}</a>&nbsp;&nbsp;&nbsp;&nbsp;
							</c:forEach>
						</div>
					</div>
					
					<div class=" my-border-b-purple my-font-purple my-font18">过程处理信息</div>
					<div class="h50 text-box1" style="padding: 20px;">
						<div class="font17" id="guocheng"></div>
					</div>
					
				</div>
			</div>
		</div>
		
	</div>

<script type="text/javascript">

var locat = (window.location+'').split("/");
$(function(){
	if('main'==locat[3]){locat = locat[0]+'//'+locat[2];}else{locat = locat[0]+'//'+locat[2]+'/'+locat[3];};
});

function shuaxin(){
	location.reload();
}

var id = $("#id").val();
var informationid = $("#informationid").val();
var specialid = $("#specialid").val();
var validflag = $("#validflag").val();

var tbody = window.document.getElementById("guocheng");

var zy = "【转阅】";
var gzpz = "【工作批注】";
var ytpz = "【源头批注】";
var th = "【退回情报】";
var xzqb = "【新增情报】";

function rizhi(i,j,k,l,m){
	var informationreceiveid = i;
	var title = j;
	var infoAnnotationid = k;
	var informationsendid = l;
	if(zy==title){
		$.ajax({
			url:		'<c:url value="/rizhizhuanyue.do"/>',
			type:		'post',
			data:		{informationreceiveid:informationreceiveid},
			dataType:	'json',
			success:	function(result){
				var str = "<h4 class='my-font-blue'>|转阅:</h4>";
				var data = result.data;
				for(var i=0;i<data.length;i++){
					var validflag = data[i].validflag==1?"未签收":"已签收";
					var feedbackflag = data[i].feedbackflag==1?"未反馈":"已反馈";
					
					str += "<p>"+data[i].receivename+
							"&nbsp;&nbsp;&nbsp;&nbsp;"+
							validflag+
							"&nbsp;&nbsp;&nbsp;&nbsp;"+
							feedbackflag+"</p>";
				}
				tbody.innerHTML = str;
			}
		});
	}else if(gzpz==title){
		$.ajax({
			url:		'<c:url value="/getAnnotationById.do"/>',
			type:		'post',
			data:		{id:infoAnnotationid},
			dataType:	'json',
			success:	function(result){
				var str = "<h4 class='my-font-blue'>|批注:</h4>";
				var data = result.data;
				str += "<p>[工作批注]&nbsp;&nbsp;&nbsp;&nbsp;"+data.content+"</p>";
				tbody.innerHTML = str;
			}
		});
	}else if(ytpz==title){
		$.ajax({
			url:		'<c:url value="/getAnnotationById.do"/>',
			type:		'post',
			data:		{id:infoAnnotationid},
			dataType:	'json',
			success:	function(result){
				var str = "<h4 class='my-font-blue'>|批注:</h4>";
				var data = result.data;
				var receivename = data.receivename;
				var validflag = data.validflag==1?"未签收":"已签收";
				str += "<p>[源头批注]&nbsp;&nbsp;"+
						receivename+"&nbsp;"+validflag+
						"&nbsp;&nbsp;&nbsp;&nbsp;"+
						data.content+"</p>";
				tbody.innerHTML = str;
			}
		});
	}else if(th==title){
		$.ajax({
			url:		'<c:url value="/rizhith.do"/>',
			type:		'post',
			data:		{informationsendid:informationsendid},
			dataType:	'json',
			success:	function(result){
				var str = "";
				var data = result.data;
				str += "<p>退回原因:&nbsp;&nbsp;"+data+"</p>";
				tbody.innerHTML = str;
			}
		});
	}else if(xzqb==title){
		$.ajax({
			url:		'<c:url value="/sgzxzqb.do"/>',
			type:		'post',
			data:		{infoid:m},
			dataType:	'json',
			success:	function(result){
				var str = "<h4 class='my-font-blue'>|报送单位:</h4>";
				var data = result.data;
				for(var i=0;i<data.length;i++){
					str += "&nbsp;&nbsp;<p>"+data[i].receivename+"</p>";
				}
				tbody.innerHTML = str;
			}
		});
	}
}

function zhuanyue(){
	if(validflag<2){
		var index = layui.layer.open({
			title :	"新增转阅信息",
			type:	2,
			content:'<c:url value="/getInformationSendById.do"/>?menuid=${menuid}&page=addReceive&id='+id,
			area: ['800', '750px'],
			maxmin: true,
			success : function(layero, index){
				setTimeout(function(){
					layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
						tips: 3
					});
				},500)
			}
		});
		layui.layer.full(index);
	}
}

function tuihui(){
	if(validflag<2){
		var index = layui.layer.open({
			title :	"退回原因",
			type:	2,
			content:locat+"/jsp/information/tuihui.jsp?id="+id+"&informationid="+informationid,
			area: ['800', '250px'],
			maxmin: true,
			success : function(layero, index){
				setTimeout(function(){
					layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
						tips: 3
					});
				},500)
			}
		});
	}
}

function pizhu(){
	if(validflag<2){
		var index = layui.layer.open({
			title :	"新增批注",
			type:	2,
			content:'<c:url value="/searchInfoAnnotation.do"/>?id='+id+"&informationid="+informationid+"&receiveid=${info.departmentid}",
			area: ['800', '350px'],
			maxmin: true,
			success : function(layero, index){
			}
		});
	}
}

function zhiding(){
	var j = ${info.topflag};
	if(j==0){
		j=1;
	}else{
		j=0;
	}
	$.ajax({
		url:		'<c:url value="/updateinfosendflag.do"/>?page=topflag',
		type:		'post',
		data:		{id:id,topflag:j},
		dataType:	'json',
		async:		false,
		success:	function(data){
			location.reload();
		}
	});
}

function zhuanxiang(){
	if(validflag<2){
		var index = layui.layer.open({
			title :	"专项标签",
			type:	2,
			content:locat+"/jsp/information/zhuanxiang.jsp?departmentid="+$("#receiveid").val()+"&informationsendid="+id+"&special="+specialid+"&informationid="+informationid,
			area: ['950', '700px'],
			maxmin: true,
			success : function(layero, index){
				setTimeout(function(){
					layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
						tips: 3
					});
				},500)
			}
			
		});
	}
}

function zhibao(){
	if(validflag<2){
		var index = layui.layer.open({
			title:	"新增直报信息",
			type:	2,
			content:'<c:url value="/getInformationSendById.do"/>?menuid=${menuid}&page=addzhibao&id='+id,
			area:	['800','750px'],
			maxmin:	true,
			success:	function(layero, index){
				setTimeout(function(){
					layui.layer.tips('点击此处返回列表','.layui-layer-setwin .layui-layer-close',{
						tips: 3
					});
				},500)
			}
		});
		layui.layer.full(index);
	}
}

function daochu(){
	var index = layui.layer.open({
		title:		"导出情报",
		type:		2,
		content:	'<c:url value="/daochuinformation_send.do"/>?id='+id,
		area:		['800','750px'],
		maxmin:		true,
		success:	function(layero,index){
			setTimeout(function(){
				layui.layer.tips('点击此处返回', '.layui-layer-setwin .layui-layer-close', {
					tips: 3
				});
			},500)
		}
	});
	layui.layer.full(index);
}

function guanzhu(){
	var j = ${info.followflag};
	if(j==0){
		j=1;
	}else{
		j=0;
	}
	$.ajax({
		url:		'<c:url value="/updateinfosendflag.do"/>?page=followflag',
		type:		'post',
		data:		{id:id,followflag:j},
		dataType:	'json',
		async:		false,
		success:	function(data){
			$("#searchInformation").click();
		}
	});
}

layui.use(['element','layer'],function(){
	var element = layui.element;
	var layer = layui.layer;
});

</script>
	
</body>
</html>
