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
    <title>转阅信息</title>
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
	<ul class="layui-tab-title my-tab-title2">
		<li class="layui-this" onclick="GetInforTable1();"><font size="4">上级转阅信息</font></li>
		<li onclick="GetInforTable2();"><font size="4">对下转阅信息</font></li>
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
						<input class="layui-input" type="text" name="infotitle1" id="infotitle1" placeholder=" 情报标题：" autocomplete="off"   style="width:250px;" >
					</div>
					<div class="layui-inline">
						<select id="infostate1" style="width:170px;">
							<option value=""> 情报状态: 全部</option>
			                <option value="已发生">已发生</option>
						    <option value="正发生">正发生</option>
							<option value="未发生">未发生</option>
						</select>
					</div>
					<div class="layui-inline">
			             <select id="urgentflag1" name="urgentflag1" lay-filter="urgentflag1">
							<option value="" selected>紧急程度：全部</option>
							<option value="一般">一般</option>
							<option value="紧急">紧急</option>
							<option value="重要">重要</option>
						</select>
					</div>
					<div class="layui-inline">
						<select id="validflag1" lay-filter="validflag1">
							<option value="0" selected>签收状态：全部</option>
							<option value="1">未签收</option>
							<option value="2">已签收</option>
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
						<select id="infosource1" name="infosource1" lay-filter="infosource1"></select>
					</div>
					
					<div class="layui-inline">
						<select id="infotype1" name="infotype1" lay-filter="infotype1"></select>
					</div>
					<div class="layui-inline">
						<select id="feedbackflag1" lay-filter="feedbackflag1">
							<option value="0" selected>反馈状态：全部</option>
							<option value="1">未反馈</option>
							<option value="2">已反馈</option>
						</select>
					</div>
					<div class="layui-inline">
						<input type="text" name="endtime1" class="layui-input" id="endtime1" placeholder="结束时间：" autocomplete="off"/>
					</div>
					<button type="submit" id="searchInformationReceive1" style="margin-top: 10px;" class="layui-btn layui-btn-sm layui-bg-green bg-query" lay-submit="" lay-filter="data-search-btn">搜索</button>
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
					<input type="hidden" id="transferdepid2" name="transferdepid" value="<%=userSession.getLoginUserDepartmentid()%>"/>
					
					<div class="layui-inline">
						<input class="layui-input" type="text" name="infotitle2" id="infotitle2" placeholder=" 情报标题：" autocomplete="off"   style="width:250px;" >
					</div>
					<div class="layui-inline">
						<select id="infostate2" style="width:170px;">
							<option value=""> 情报状态: 全部</option>
			                <option value="已发生">已发生</option>
						    <option value="正发生">正发生</option>
							<option value="未发生">未发生</option>
						</select>
					</div>
					<div class="layui-inline">
			             <select id="urgentflag2" name="urgentflag2" lay-filter="urgentflag2">
							<option value="" selected>紧急程度：全部</option>
							<option value="一般">一般</option>
							<option value="紧急">紧急</option>
							<option value="重要">重要</option>
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
						<select id="infosource" name="infosource2" lay-filter="infosource2"></select>
					</div>
					<div class="layui-inline">
						<select id="infotype" name="infotype2" lay-filter="infotype2"></select>
					</div>
					<div class="layui-inline">
						<input type="text" name="endtime2" class="layui-input" id="endtime2" placeholder="结束时间：" autocomplete="off"/>
					</div>
					<button type="submit" id="searchInformationReceive2" style="margin-top: 10px;" class="layui-btn layui-btn-sm layui-bg-green bg-query" lay-submit="" lay-filter="data-search-btn">搜索</button>
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
					<div id="layui-table-page1">
						<div class="layui-box layui-laypage layui-laypage-default" id="layui-laypage-2">
							<a href="javascript:;" class="layui-laypage-prev2"><i class="layui-icon">&#xe603;</i></a>
							<span class="layui-laypage-count" id="pNumshow2"></span>
							<a href="javascript:;" class="layui-laypage-next2"><i class="layui-icon">&#xe602;</i></a>
							<span class="layui-laypage-count" id="sumNum2"></span>
							<span class="layui-laypage-skip">到第<input type="text" id="toPnum2" min="1" value="" class="layui-input">页
							<button type="button" class="layui-laypage-btn" onclick="choosePage2()">确定</button></span>
							<span class="layui-laypage-count" id="allcount2"></span>
							<span class="layui-laypage-limits">
								<select id="pagenumchoose2" name="pagenumchoose2">
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

layui.config({
    base: "<c:url value="/layui/lay/modules/"/>"
}).extend({
	zTreeSelectM: "zTreeSelectM/zTreeSelectM",
    treeSelect: "treeSelect"
});

$("#searchInformationReceive1").click(function(){
	GetInforTable1();
});

$("#searchInformationReceive2").click(function(){
	GetInforTable2();
});

function choosePage1(){
	var toPnum = $("#toPnum1").val();
	$("#pageNumber1").val(toPnum);
	$("#searchInformationReceive1").click();
}

$("select[name='pagenumchoose1']").change(function(){
	$("#limit1").val($(this).val());
	$("#pageNumber1").val("1");
	$("#toPnum1").val("");
	$("#searchInformationReceive1").click();
});

$("a.layui-laypage-prev1").click(function(){
	var nowpage = $("#pageNumber1").val();
	var maxy = $("#maxCount1").val();
	if(nowpage > 1 && nowpage <=maxy){
		$("#pageNumber1").val(nowpage-1);
		$("#searchInformationReceive1").click();
	}
});

$("a.layui-laypage-next1").click(function(){
	var nowpage = parseInt($("#pageNumber1").val());
	var maxy = parseInt($("#maxCount1").val());
	if(nowpage >= 1 && nowpage < maxy){
		$("#pageNumber1").val(nowpage+1);
		$("#searchInformationReceive1").click();
	}
});

function choosePage2(){
	var toPnum = $("#toPnum2").val();
	$("#pageNumber2").val(toPnum);
	$("#searchInformationReceive2").click();
}

$("select[name='pagenumchoose2']").change(function(){
	$("#limit2").val($(this).val());
	$("#pageNumber2").val("1");
	$("#toPnum2").val("");
	$("#searchInformationReceive2").click();
});

$("a.layui-laypage-prev2").click(function(){
	var nowpage = $("#pageNumber2").val();
	var maxy = $("#maxCount2").val();
	if(nowpage > 1 && nowpage <=maxy){
		$("#pageNumber2").val(nowpage-1);
		$("#searchInformationReceive2").click();
	}
});

$("a.layui-laypage-next2").click(function(){
	var nowpage = parseInt($("#pageNumber2").val());
	var maxy = parseInt($("#maxCount2").val());
	if(nowpage >= 1 && nowpage < maxy){
		$("#pageNumber2").val(nowpage+1);
		$("#searchInformationReceive2").click();
	}
});

function getinfosource(){
	$.ajax({
		type:		'post',
		url:		'<c:url value="/getBMByTypeToJSON1.do"/>?basicType='+71,
		dataType:	'json',
		async:		false,
		success:	function(data){
			var options = fillOption(data);
			options = '<option value="" > 情报来源：全部</option>'+options;
			$("select[name^=infosource1]").html(options);
			$("select[name^=infosource2]").html(options);
		}
	});
}

function getinfotype(){
	$.ajax({
		type:		'post',
		url:		'<c:url value="/getBMByTypeToJSON1.do"/>?basicType='+88,
		dataType:	'json',
		async:		false,
		success:	function(data){
			var options = fillOption(data);
			options = '<option value="" >情报类型：全部</option>'+options;
			$("select[name^=infotype1]").html(options);
			$("select[name^=infotype2]").html(options);
		}
	});
}

function GetInforTable1(){
	$.ajax({
		url:		'<c:url value="/searchInformationReceive.do"/>',
		type:		'post',
		data:		{	
						infotitle:$("#infotitle1").val(),
						infocontent:$("#infocontent1").val(),
						receiveid:$("#receiveid1").val(),
						infostate:$("#infostate1 option:selected").val(),
						urgentflag:$("#urgentflag1 option:selected").val(),
						infosource:$("#infosource1 option:selected").val(),
						infotype:$("#infotype1 option:selected").val(),
						page:1,
						validflag:$("#validflag1 option:selected").val(),
						starttime:$("#starttime1").val(),
						endtime:$("#endtime1").val(),
						feedbackflag:$("#feedbackflag1 option:selected").val(),
						limit:$("#limit1").val(),
						pageNumber:$("#pageNumber1").val()
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
				var qianshoucolor = data[i].validflag==2?'layui-bg-gray':'layui-bg-green';
				var qs = "<span class='my-font-blue'>【已签收】</span>";
				var qianshouinfo = data[i].validflag==2?qs+data[i].signoper+" "+data[i].signtime:"";
				var fankuicolor = data[i].feedbackflag==2?'layui-bg-gray':'layui-bg-green';
				var fk = "<span class='my-font-blue'>【已反馈】</span>";
				var fankuiinfo = data[i].feedbackflag==2?fk+data[i].feedbackoper+" "+data[i].feedbacktime+" "+data[i].feedbackcontent:"";
				
				str += "<tr class='my-border-b'>" +
						"<td colspan='12'>" +
						"<div class='layui-row news-table-item'>" +
						"<div class='layui-col-md4 my-font-bold my-font18 my-font-blue' style='cursor:pointer' onclick='xiangqing("+data[i].informationid+");'>"+data[i].infotitle+"</div>"+
						"<div class='layui-col-md3 my-font16'><span class='my-font-blue'>报送单位：</span>"+ data[i].departname +"</div>" +
						"<div class='layui-col-md2 my-font16'><span class='my-font-blue'>转阅时间：</span>"+ data[i].transfertime +"</div>" +
						"<div class='layui-col-md3'>" +
						"<button class='layui-btn "+ qianshoucolor + " layui-btn-sm layui-icon my-btn-more news-table-btn' onclick='qianshou("+data[i].id+","+data[i].validflag+")'>签收</button>" +
						"<button class='layui-btn "+ fankuicolor +" layui-btn-sm layui-icon my-btn-more news-table-btn' onclick='fankui("+data[i].id+","+data[i].feedbackflag+","+data[i].validflag+")'>反馈</button>" + 
						"</div>" +
						"</div>" +
						"<div class='layui-row news-table-item'>" +
						"<div class='layui-col-md9'>" +
						"<span class='my-tag-item3 green'>"+ data[i].infotype +"</span>" +
						"<span class='my-tag-item3 green'>"+ data[i].infosource +"</span>" +
						"<span class='my-tag-item3 red'>"+ data[i].urgentflag +"</span>" +
						"<span class='my-tag-item3 red'>"+ data[i].infostate +"</span>" +
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

function GetInforTable2(){
	$.ajax({
		url:		'<c:url value="/searchInformationReceive.do"/>',
		type:		'post',
		data:		{	
						page:2,
						infotitle:$("#infotitle2").val(),
						infocontent:$("#infocontent2").val(),
						infostate:$("#infostate2 option:selected").val(),
						urgentflag:$("#urgentflag2 option:selected").val(),
						infosource:$("#infosource2 option:selected").val(),
						infotype:$("#infotype2 option:selected").val(),
						transferdepid:$("#transferdepid2").val(),
						starttime:$("#starttime2").val(),
						endtime:$("#endtime2").val(),
						limit:$("#limit2").val(),
						pageNumber:$("#pageNumber2").val()
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
						"<div class='layui-col-md4 my-font-bold my-font18 my-font-blue' style='cursor:pointer' onclick='xiangqing("+data[i].id+");'>"+data[i].infotitle+"</div>"+
						"<div class='layui-col-md3 my-font16'><span class='my-font-blue'>报送单位：</span>"+ data[i].departname +"</div>" +
						"<div class='layui-col-md2 my-font16'><span class='my-font-blue'>报送时间：</span>"+ data[i].addtime +"</div>" +
						"<div class='layui-col-md3'>" +
						"</div>" +
						"</div>" +
						"<div class='layui-row news-table-item'>" +
						"<div class='layui-col-md9'>" +
						"<span class='my-tag-item3 green'>"+ data[i].infotype +"</span>" +
						"<span class='my-tag-item3 green'>"+ data[i].infosource +"</span>" +
						"<span class='my-tag-item3 red'>"+ data[i].urgentflag +"</span>" +
						"<span class='my-tag-item3 red'>"+ data[i].infostate +"</span>" +
						"</div>" +
						"</div>" +
						"</td>" +
						"</tr>";
			}
			tbody2.innerHTML = str;
		}
	});
}

$(document).ready(function(){
	GetInforTable1();
	getinfosource();
	getinfotype();
});

function xiangqing(i){
	var index = layui.layer.open({
		title :	"详情页面",
		type:	2,
		content:'<c:url value="/zhuanyuexiangqing.do"/>?id='+i,
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
			url:		'<c:url value="/updateinforeceiveflag.do"/>?page=zhuanyueqianshou',
			type:		'post',
			data:		{id:i,validflag:2,feedbackoperid:0},
			dataType:	'json',
			async:		false,
			success:	function(data){
				layui.layer.msg("签收成功");
				$("#searchInformationReceive1").click();
			}
		});
	}
}

function fankui(i,j,k){
	if(k==1){
		layui.layer.msg("需先签收再反馈");
	}else{
		if(j==1){
			var index = layui.layer.open({
				title :	"反馈内容",
				type:	2,
				content:locat+"/jsp/information/fankuiContent.jsp?id="+i+"&page=zhuanyuefankui",
				area: ['850', '250px'],
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
}

layui.use(['form','table','laydate','treeSelect','element'],function(){
	var form = layui.form;
	var table = layui.table;
	var laydate = layui.laydate;
	var treeSelect = layui.treeSelect;
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
	
	treeSelect.render({
		elem:	'#departmentid2',	//选择器
		data:	'<c:url value="/getDepartmentTree.do"/>',
		type:	'get',	//异步加载
		placeholder:	'',
		search:	false,
		style:	{
			folder:	{enable: false},
			line:	{enable: true}
		},
		click: function(d){
		}
	});
	
	form.render();
	
	
	
});

</script>

</body>
</html>
