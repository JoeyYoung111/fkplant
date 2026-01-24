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
    <title>交办信息</title>
    <link rel="stylesheet" href="<c:url value="/css/viewer.css"/>"/>
	<link rel="stylesheet" href="<c:url value="/layui/lay/modules/formSelects/formSelects-v4.css"/>" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/js/jquery.form.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/cardnumber.js"/>"></script>
  	<link rel="stylesheet" href="<c:url value='/layui/css/layui1.css'/>"/>
  	<link rel="stylesheet" href="<c:url value='/css/public.css'/>" media="all" />
  	<script type="text/javascript" src="<c:url value="/js/viewer.js"/>"></script>
  	
</head>
<%
UserSession userSession = (UserSession) session.getAttribute("userSession");
%>   
<body class="childrenBody layui-fluid">
<div class="layui-tab my-tab layui-tab-brief" lay-filter="docDemoTabBrief">
	<input type="hidden" id="menuid" value="${param.menuid}"/>
	<ul class="layui-tab-title my-tab-title2">
		<li class="layui-this" onclick="GetjbTable1();"><font size="4">上级交办信息</font></li>
		<li onclick="GetjbTable2();"><font size="4">对下交办信息</font></li>
	</ul>

	<div class="layui-tab-content" style="height: 100px;">
		
		<div class="layui-tab-item layui-show">
			<blockquote class="layui-elem-quote news_search">
				<div class="demoTable">
					<form class="layui-form layui-form-pane" onsubmit="return false;">
						<input type="hidden" id="limit1" name="limit" value="10"/>
						<input type="hidden" id="pageNumber1" name="pageNumber" value="1"/>
						<input type="hidden" id="maxCount1" name="maxCount" value=""/>
						<input type="hidden" id="receiveid1" name="receiveid" value="<%=userSession.getLoginUserDepartmentid()%>"/>
						
						<div class="layui-inline">
							<input class="layui-input" type="text" name="assigntitle1" id="assigntitle1" placeholder=" 情报标题：" autocomplete="off"   style="width:250px;" >
						</div>
						<div class="layui-inline">
				            <select id="urgentflag1" name="urgentflag1" lay-filter="urgentflag1">
								<option value="" selected>紧急程度：全部</option>
								<option value="红色">红色</option>
								<option value="橙色">橙色</option>
								<option value="蓝色">蓝色</option>
							</select>
						</div>
						<div class="layui-inline">
							<input type="text" name="starttime1" class="layui-input" id="starttime1" placeholder="开始时间：" autocomplete="off"/>
						</div>
						<br>
						<div class="layui-inline">
							<input class="layui-input" type="text" id="infocontent1" name="infocontent1" placeholder=" 情报内容：" autocomplete="off"  style="width:250px;" >
						</div>
						<div class="layui-inline">
				            <select id="category1" name="category1" lay-filter="category1">
								<option value="" selected>类别：全部</option>
								<option value="核查性">核查性</option>
								<option value="指令性">指令性</option>
								<option value="指导性">指导性</option>
								<option value="督办性">督办性</option>
							</select>
						</div>
						<div class="layui-inline">
							<input type="text" name="endtime1" class="layui-input" id="endtime1" placeholder="结束时间：" autocomplete="off"/>
						</div>
						<button type="submit" id="searchAssignSignfor" style="margin-top: 10px;" class="layui-btn layui-btn-sm layui-bg-green bg-query" lay-submit="" lay-filter="data-search-btn">搜索</button>
					</form>
				</div>
			</blockquote>
			<div class="layui-row">
				<table class="layui-table my-table" id="InformationTable" lay-filter="InformationTable" lay-skin="nob" style="max-height:500px;">
					<colgroup>
						<col width="120">
						<col width="100">
						<col width="100">
						<col width="100">
						<col width="100">
						<col width="100">
						<col width="100">
						<col width="100">
						<col width="100">
						<col width="100">
						<col width="100">
						<col width="100">
					</colgroup>
					<tbody id="tbody-result1"></tbody>
				</table>
				<div class="layui-table-page">
					<div id="layui-table-page1">
						<div class="layui-box layui-laypage layui-laypage-default" id="layui-laypage-2">
							<a href="javascript:;" class="layui-laypage-prev1"><i class="layui-icon">&#xe603;</i></a>
							<span class="layui-laypage-count" id="pNumshow1"></span>
							<a href="javascript:;" class="layui-laypage-next1"><i class="layui-icon">&#xe602;</i></a>
							<span class="layui-laypage-count" id="sumNum1"></span>
							<span class="layui-laypage-skip">到第<input type="text" id="toPnum1" min="1" value="" class="layui-input">页
							<button type="button" class="layui-laypage-btn" onclick="choosePage1()">确定</button></span>
							<span class="layui-laypage-count" id="allcount1"></span>
							<span class="layui-laypage-limits">
								<select id="pagenumchoose1" name="pagechoose1">
									<option value="10" selected>10 条/页</option>
									<option value="15">15 条/页</option>
									<option value="20">20 条/页</option>
									<option value="25">25 条/页</option>
									<option value="50">50 条/页</option>
									<option value="100">100 条/页</option>
									<option value="1">1 条/页</option>
									<option value="2">2 条/页</option>
								</select>
							</span>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="layui-tab-item">
			<blockquote class="layui-elem-quote news_search">
				<div class="demoTable">
					<form class="layui-form layui-form-pane" onsubmit="return false;">
						<input type="hidden" id="limit2" name="limit" value="10"/>
						<input type="hidden" id="pageNumber2" name="pageNumber" value="1"/>
						<input type="hidden" id="maxCount2" name="maxCount" value=""/>
						<input type="hidden" id="departmentid2" name="departmentid" value="<%=userSession.getLoginUserDepartmentid()%>"/>
					
						<div class="layui-inline">
							<input class="layui-input" type="text" name="assigntitle2" id="assigntitle2" placeholder=" 情报标题：" autocomplete="off" style="width:250px;" >
						</div>
						<div class="layui-inline">
				            <select id="urgentflag2" name="urgentflag2" lay-filter="urgentflag2">
								<option value="" selected>紧急程度：全部</option>
								<option value="红色">红色</option>
								<option value="橙色">橙色</option>
								<option value="蓝色">蓝色</option>
							</select>
						</div>
						<div class="layui-inline">
							<input type="text" name="starttime2" class="layui-input" id="starttime2" placeholder="开始时间：" autocomplete="off"/>
						</div>
						<br>
						<div class="layui-inline">
							<input class="layui-input" type="text" id="infocontent2" name="infocontent2" placeholder=" 情报内容：" autocomplete="off"  style="width:250px;" >
						</div>
						<div class="layui-inline">
				            <select id="category1" name="category2" lay-filter="category2">
								<option value="" selected>类别：全部</option>
								<option value="核查性">核查性</option>
								<option value="指令性">指令性</option>
								<option value="指导性">指导性</option>
								<option value="督办性">督办性</option>
							</select>
						</div>
						<div class="layui-inline">
							<input type="text" name="endtime2" class="layui-input" id="endtime2" placeholder="结束时间：" autocomplete="off"/>
						</div>
						<button type="submit" id="searchInfoAssign" style="margin-top: 10px;" class="layui-btn layui-btn-sm layui-bg-green bg-query" lay-submit="" lay-filter="data-search-btn">搜索</button>
					</form>
				</div>
			</blockquote>
			<div class="layui-row">
				<table class="layui-table my-table" id="InformationTable" lay-filter="InformationTable" lay-skin="nob" style="max-height:500px;">
					<colgroup>
						<col width="120">
						<col width="100">
						<col width="100">
						<col width="100">
						<col width="100">
						<col width="100">
						<col width="100">
						<col width="100">
						<col width="100">
						<col width="100">
						<col width="100">
						<col width="100">
					</colgroup>
					<tbody id="tbody-result2"></tbody>
				</table>
				<div class="layui-table-page">
					<div id="layui-table-page2">
						<div class="layui-box layui-laypage layui-laypage-default" id="layui-laypage-2">
							<a href="javascript:;" class="layui-laypage-prev2"><i class="layui-icon">&#xe603;</i></a>
							<span class="layui-laypage-count" id="pNumshow2"></span>
							<a href="javascript:;" class="layui-laypage-next2"><i class="layui-icon">&#xe602;</i></a>
							<span class="layui-laypage-count" id="sumNum2"></span>
							<span class="layui-laypage-skip">到第<input type="text" id="toPnum2" min="1" value="" class="layui-input">页
							<button type="button" class="layui-laypage-btn" onclick="choosePage2()">确定</button></span>
							<span class="layui-laypage-count" id="allcount2"></span>
							<span class="layui-laypage-limits">
								<select id="pagenumchoose2" name="pagechoose2">
									<option value="10" selected>10 条/页</option>
									<option value="15">15 条/页</option>
									<option value="20">20 条/页</option>
									<option value="25">25 条/页</option>
									<option value="50">50 条/页</option>
									<option value="100">100 条/页</option>
									<option value="1">1 条/页</option>
									<option value="2">2 条/页</option>
								</select>
							</span>
						</div>
					</div>
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

var tbody1=window.document.getElementById("tbody-result1");
var tbody2=window.document.getElementById("tbody-result2");
var menuid = $("#menuid").val();

$("#searchAssignSignfor").click(function(){
	GetjbTable1();
});

$("#searchInfoAssign").click(function(){
	GetjbTable2();
});

function choosePage1(){
	var toPnum = $("#toPnum1").val();
	$("#pageNumber1").val(toPnum);
	$("#searchAssignSignfor").click();
}

$("select[name='pagenumchoose1']").change(function(){
	$("#limit1").val($(this).val());
	$("#pageNumber1").val("1");
	$("#toPnum1").val("");
	$("#searchAssignSignfor").click();
});

$("a.layui-laypage-prev1").click(function(){
	var nowpage = $("#pageNumber1").val();
	var maxy = $("#maxCount1").val();
	if(nowpage > 1 && nowpage <=maxy){
		$("#pageNumber1").val(nowpage-1);
		$("#searchAssignSignfor").click();
	}
});

$("a.layui-laypage-next1").click(function(){
	var nowpage = parseInt($("#pageNumber1").val());
	var maxy = parseInt($("#maxCount1").val());
	if(nowpage >= 1 && nowpage < maxy){
		$("#pageNumber1").val(nowpage+1);
		$("#searchAssignSignfor").click();
	}
});

function choosePage2(){
	var toPnum = $("#toPnum2").val();
	$("#pageNumber2").val(toPnum);
	$("#searchInfoAssign").click();
}

$("select[name='pagenumchoose2']").change(function(){
	$("#limit2").val($(this).val());
	$("#pageNumber2").val("1");
	$("#toPnum2").val("");
	$("#searchInfoAssign").click();
});

$("a.layui-laypage-prev2").click(function(){
	var nowpage = $("#pageNumber2").val();
	var maxy = $("#maxCount2").val();
	if(nowpage > 1 && nowpage <=maxy){
		$("#pageNumber2").val(nowpage-1);
		$("#searchInfoAssign").click();
	}
});

$("a.layui-laypage-next2").click(function(){
	var nowpage = parseInt($("#pageNumber2").val());
	var maxy = parseInt($("#maxCount2").val());
	if(nowpage >= 1 && nowpage < maxy){
		$("#pageNumber2").val(nowpage+1);
		$("#searchInfoAssign").click();
	}
});


$(document).ready(function(){
	GetjbTable1();
});

function GetjbTable1(){
	$.ajax({
		url:		'<c:url value="/searchAssignSignfor.do"/>',
		type:		'post',
		data:		{	
						assigntitle:$("#assigntitle1").val(),
						urgentflag:$("#urgentflag1").val(),
						infocontent:$("#infocontent1").val(),
						category:$("#category1").val(),
						starttime:$("#starttime1").val(),
						endtime:$("#endtime1").val(),
						limit:$("#limit1").val(),
						pageNumber:$("#pageNumber1").val(),
						receiveid:$("#receiveid1").val(),
						validflag:0,
						assignid:0
					},
		dataType:	'json',
		success:	function(result){
			var total = result.total;
			$("#allcount1").html("共 "+total+" 条");
			var yema = $("#pageNumber1").val();
			$("#pNumshow1").html("&nbsp;&nbsp;&nbsp;第 "+yema+" 页");
			var sumyema = result.allpagenum;
			$("#sumNum1").html("&nbsp;&nbsp;&nbsp;共 "+sumyema+" 页");
			$("#maxCount1").val(sumyema);
			var str = "";
			var data = result.data;
			for( var i=0;i<data.length;i++){
				var qianshoucolor = data[i].validflag==1?'layui-bg-green':'layui-bg-gray';
				var qs = "<span class='my-font-blue'>【已签收】</span>";
				var qianshouinfo = data[i].validflag==1?"":qs+data[i].signoper+" "+data[i].signtime;
				var fankuicolor = data[i].validflag==3?'layui-bg-gray':'layui-bg-green';
				var fk = "<span class='my-font-blue'>【已反馈】</span>";
				var fankuiinfo = data[i].validflag==3?fk+data[i].feedbackoper+" "+data[i].feedbacktime+" "+data[i].feedbackcontent:"";
				
				str += "<tr class='my-border-b'>" +
						"<td colspan='12'>" +
						"<div class='layui-row news-table-item'>" +
						"<div class='layui-col-md4 my-font-bold my-font18 my-font-blue' style='cursor:pointer' onclick='xiangqing("+data[i].assignid+");'>"+data[i].assigntitle+"</div>"+
						"<div class='layui-col-md3 my-font16'><span class='my-font-blue'>交办单位：</span>"+ data[i].departmentname +"</div>" +
						"<div class='layui-col-md2 my-font16'><span class='my-font-blue'>交办时间：</span>"+ data[i].addtime +"</div>" +
						"<div class='layui-col-md3'>" +
						"<button class='layui-btn "+ qianshoucolor + " layui-btn-sm layui-icon my-btn-more news-table-btn' onclick='qianshou("+data[i].id+","+data[i].validflag+")'>签收</button>" +
						"<button class='layui-btn "+ fankuicolor +" layui-btn-sm layui-icon my-btn-more news-table-btn' onclick='fankui("+data[i].id+","+data[i].validflag+")'>反馈</button>" + 
						"</div>" +
						"</div>" +
						"<div class='layui-row news-table-item'>" +
						"<div class='layui-col-md9'>" +
						"<span class='my-tag-item3 red'>"+ data[i].urgentflag +"</span>" +
						"<span class='my-tag-item3 red'>"+ data[i].signlimit +"</span>" +
						"<span>"+qianshouinfo+"</span>&nbsp;"+
						"<span>"+fankuiinfo+"</span>"+
						"</div>" +
						"</div>" +
						"</td>" +
						"</tr>";
			}
			tbody1.innerHTML = str;
		}
	});
}

function GetjbTable2(){
	$.ajax({
		url:		'<c:url value="/searchInfoAssign.do"/>',
		type:		'post',
		data:		{	
						assigntitle:$("#assigntitle1").val(),
						urgentflag:$("#urgentflag1").val(),
						infocontent:$("#infocontent1").val(),
						category:$("#category1").val(),
						starttime:$("#starttime1").val(),
						endtime:$("#endtime1").val(),
						limit:$("#limit1").val(),
						pageNumber:$("#pageNumber1").val(),
						departmentid:$("#departmentid2").val(),
						informationid:0
					},
		dataType:	'json',
		success:	function(result){
			var total = result.total;
			$("#allcount2").html("共 "+total+" 条");
			var yema = $("#pageNumber2").val();
			$("#pNumshow2").html("&nbsp;&nbsp;&nbsp;第 "+yema+" 页");
			var sumyema = result.allpagenum;
			$("#sumNum2").html("&nbsp;&nbsp;&nbsp;共 "+sumyema+" 页");
			$("#maxCount2").val(sumyema);
			var str = "";
			var data = result.data;
			for( var i=0;i<data.length;i++){
				str += "<tr class='my-border-b'>" +
						"<td colspan='12'>" +
						"<div class='layui-row news-table-item'>" +
						"<div class='layui-col-md4 my-font-bold my-font18 my-font-blue' style='cursor:pointer' onclick='xiangqing("+data[i].id+");'>"+data[i].assigntitle+"</div>"+
						"<div class='layui-col-md3 my-font16'><span class='my-font-blue'>交办单位：</span>"+ data[i].departmentname +"</div>" +
						"<div class='layui-col-md2 my-font16'><span class='my-font-blue'>交办时间：</span>"+ data[i].addtime +"</div>" +
						"<div class='layui-col-md3'>" +
						"<button class='layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more news-table-btn' onclick='xiugai("+data[i].id+")'>修改</button>" +
						"<button class='layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more news-table-btn' onclick='shanchu("+data[i].id+")'>删除</button>" +
						"</div>" +
						"</div>" +
						"<div class='layui-row news-table-item'>" +
						"<div class='layui-col-md9'>" +
						"<span class='my-tag-item3 red'>"+ data[i].urgentflag +"</span>" +
						"<span class='my-tag-item3 red'>"+ data[i].signlimit +"</span>" +
						"</div>" +
						"</div>" +
						"</td>" +
						"</tr>";
			}
			tbody2.innerHTML = str;
		}
	});
}

function xiangqing(i){
	var index = layui.layer.open({
		title :	"详情页面",
		type:	2,
		content:'<c:url value="/getInfoAssignById.do"/>?id='+i+"&page=xiangqing",
		area: ['800px', '750px'],
		maxmin: false,
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

function qianshou(i,j){
	if(j==1){
		$.ajax({
			url:		'<c:url value="/updateAssignSignfor.do"/>?page=qianshou',
			type:		'post',
			data:		{id:i,menuid:menuid},
			dataType:	'json',
			async:		false,
			success:	function(data){
				layui.layer.msg("签收成功");
				$("#searchAssignSignfor").click();
			}
		});
	}
}

function fankui(i,j){
	if(j==1){
		layui.layer.msg("需先签收再反馈");
	}else{
		if(j==2){
			var index = layui.layer.open({
				title :	"交办信息反馈",
				type:	2,
				content:locat+"/jsp/information/info_assign_fankui.jsp?id="+i+"&menuid="+menuid+"&page=fankui",
				area:['850','250px'],
				maxmin:true,
				success:function(layero,index){
					setTimeout(function(){
						layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
							tips: 3
						});
					},500)
				}
			});
		}
	}
}

function xiugai(i){
	var index = layui.layer.open({
		title :	"详情页面",
		type:	2,
		content:'<c:url value="/getInfoAssignById.do"/>?id='+i+"&page=update&menuid="+menuid,
		area: ['800px', '750px'],
		maxmin: false,
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

function shanchu(i){
	layer.confirm("确定删除此信息吗?",function(index){
		layer.close(index);
		$.getJSON(locat+"/cancelInfoAssign.do?id="+i+'&menuid='+menuid,{},function(data){
			var str = eval('('+data+')');
			if(str.flag ==1){
				top.layer.msg("数据删除成功");
				$("#searchInfoAssign").click();
			}else{
				top.layer.msg("数据删除失败");
			}
		});
	});
}

layui.use(['form','table','laydate','element']),function(){
	var form = layui.form;
	var table = layui.table;
	var laydate = layui.laydate;
	var element = layui.element;
	
	laydate.render({
		elem:	'#starttime1',
		type:	'datetime',
		trigger:'click'
	});
	
	laydate.render({
		elem:	'#starttime2',
		type:	'datetime',
		trigger:'click'
	});
	
	laydate.render({
		elem:	'#endtime1',
		type:	'datetime',
		trigger:'click'
	});
	
	laydate.render({
		elem:	'#endtime2',
		type:	'datetime',
		trigger:'click'
	});
	
	form.render();
	
}


</script>

</body>
</html>
