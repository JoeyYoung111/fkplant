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
    <title>上报信息</title>
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
<div class=" layui-tab-brief">
<div class="layui-tab-item layui-show">
	<blockquote class="layui-elem-quote news_search">	
       <div class="demoTable">
			<form class="layui-form layui-form-pane" onsubmit="return false;">
				<input type="hidden" id="limit" name="limit" value="10"/>
				<input type="hidden" id="pageNumber" name="pageNumber" value="1"/>
				<input type="hidden" id="maxCount" name="maxCount" value=""/>
				<input type="hidden" id="departmentid" name="departmentid" value="<%=userSession.getLoginUserDepartmentid()%>"/>
				
				<div class="layui-inline">
					<input class="layui-input" type="text" id="infotitle" placeholder=" 情报标题：" autocomplete="off"   style="width:250px;" >
				</div>
				<div class="layui-inline">
					<select id="infostate" style="width:170px;">
						<option value=""> 情报状态: 全部</option>
		                <option value="已发生">已发生</option>
					    <option value="正发生">正发生</option>
						<option value="未发生">未发生</option>
					</select>
				</div>
				<div class="layui-inline">
		             <select id="urgentflag" name="urgentflag" lay-filter="urgentflag">
						<option value="" selected>紧急程度：全部</option>
						<option value="一般">一般</option>
						<option value="紧急">紧急</option>
						<option value="重要">重要</option>
					</select>
				</div>
				
				<div class="layui-inline">
					<input type="text" name="starttime" class="layui-input" id="starttime" placeholder="上报开始时间：" autocomplete="off"/>
				</div>
				<br>
				<div class="layui-inline">
					<input class="layui-input" type="text" id="infocontent" placeholder=" 情报内容：" autocomplete="off"  style="width:250px;" >
				</div>
				<div class="layui-inline">
						<select id="infosource" name="infosource" lay-filter="infosource"></select>
				</div>
				
				<div class="layui-inline">
					<select id="infotype" name="infotype" lay-filter="infotype"></select>
				</div>
			
				<div class="layui-inline">
					<input type="text" name="endtime" class="layui-input" id="endtime" placeholder="上报结束时间：" autocomplete="off"/>
				</div>
				<button class="layui-btn" id="searchInformationReport" data-type="reload"><i class="layui-icon">&#xe615;</i>搜 索</button>
			</form>
		</div>
	</blockquote>			
			
	<div class="layui-row">
		<table class="layui-table my-table" id="InformationReportTable" lay-filter="InformationTable" lay-skin="nob" style="max-height:500px;">
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
			<thead>
				<tr>
					<td colspan="12">
						<c:if test='${fn:contains(param.buttons,"新增")}'>
						 <button class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more" lay-event="add"  onclick="add_information();">&#xe624; 新增</button>
						</c:if>
					</td>
				</tr>
			</thead>
			<tbody id="tbody-result">
			</tbody>
		</table>
		<div class="layui-table-page">
			<div id="layui-table-page1">
				<div class="layui-box layui-laypage layui-laypage-default" id="layui-laypage-2">
					<a href="javascript:;" class="layui-laypage-prev"><i class="layui-icon">&#xe603;</i></a>
					<span class="layui-laypage-count" id="pNumshow"></span>
					<a href="javascript:;" class="layui-laypage-next"><i class="layui-icon">&#xe602;</i></a>
					<span class="layui-laypage-count" id="sumNum"></span>
					<span class="layui-laypage-skip">到第<input type="text" id="toPnum" min="1" value="" class="layui-input">页
					<button type="button" class="layui-laypage-btn" onclick="choosePage()">确定</button></span>
					<span class="layui-laypage-count" id="allcount"></span>
					<span class="layui-laypage-limits">
						<select id="pagenum1" name="pagenum1">
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

<script type="text/javascript">
	
var locat = (window.location+'').split("/");
$(function(){
	if('main'==locat[3]){locat = locat[0]+'//'+locat[2];}else{locat = locat[0]+'//'+locat[2]+'/'+locat[3];};
});

var tbody=window.document.getElementById("tbody-result");

layui.config({
    base: "<c:url value="/layui/lay/modules/"/>"
}).extend({
	zTreeSelectM: "zTreeSelectM/zTreeSelectM",
    treeSelect: "treeSelect"
});

$("#searchInformationReport").click(function(){
	GetInforTable();
});

function choosePage(){
	var toPnum = $("#toPnum").val();
	$("#pageNumber").val(toPnum);
	$("#searchInformationReport").click();
}

$("select[name='pagenum1']").change(function(){
	$("#limit").val($(this).val());
	$("#pageNumber").val("1");
	$("#toPnum").val("");
	$("#searchInformationReport").click();
});

$("a.layui-laypage-prev").click(function(){
	var nowpage = $("#pageNumber").val();
	var maxy = $("#maxCount").val();
	if(nowpage > 1 && nowpage <=maxy){
		$("#pageNumber").val(nowpage-1);
		$("#searchInformationReport").click();
	}
});

$("a.layui-laypage-next").click(function(){
	var nowpage = parseInt($("#pageNumber").val());
	var maxy = parseInt($("#maxCount").val());
	if(nowpage >= 1 && nowpage < maxy){
		$("#pageNumber").val(nowpage+1);
		$("#searchInformationReport").click();
	}
});

function xiangqing(i){
	var index = layui.layer.open({
		title :	"详情页面",
		type:	2,
		content:'<c:url value="/showinfoInformation.do"/>?id='+i+"&menuid=${param.menuid}",
		area: ['1200px', '800px'],
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

function getinfosource(){
	$.ajax({
		type:		'post',
		url:		'<c:url value="/getBMByTypeToJSON1.do"/>?basicType='+71,
		dataType:	'json',
		async:		false,
		success:	function(data){
			var options = fillOption(data);
			options = '<option value=""> 情报来源：全部</option>'+options;
			$("select[name^=infosource]").html(options);
		}
	});
}

function GetInforTable(){
	$.ajax({
		url:		'<c:url value="/searchInformation.do"/>',
		type:		'post',
		data:		{	
			departmentid:$("#departmentid").val(),
			infotitle:$("#infotitle").val(),
			infocontent:$("#infocontent").val(),
			infostate:$("#infostate option:selected").val(),
			urgentflag:$("#urgentflag option:selected").val(),
			infosource:$("#infosource").val(),
			infotype:$("#infotype option:selected").val(),
			starttime:$("#starttime").val(),
			endtime:$("#endtime").val(),
			limit:$("#limit").val(),
			pageNumber:$("#pageNumber").val()
		},
		dataType:	'json',
		success:	function(result){
			var total = result.total;
			$("#allcount").html("共 "+total+" 条");
			var yema = $("#pageNumber").val();
			$("#pNumshow").html("&nbsp;&nbsp;&nbsp;第 "+yema+" 页");
			var sumyema = result.allpagenum;
			$("#sumNum").html("&nbsp;&nbsp;&nbsp;共 "+sumyema+" 页");
			$("#maxCount").val(sumyema);
			var str = "";
			var data = result.data;
			for( var i=0;i<data.length;i++){
				
				var pz = null==data[i].yuantoupizhu?'无':data[i].yuantoupizhu;
				
				str += "<tr class='my-border-b'>" +
						"<td colspan='12'>" +
						"<div class='layui-row news-table-item'>" +
						"<div class='layui-col-md4 my-font-bold my-font18 my-font-blue' style='cursor:pointer' onclick='xiangqing("+data[i].id+");'>"+data[i].infotitle+"</div>"+
						"<div class='layui-col-md3 my-font16'><span class='my-font-blue'>主报送单位：</span>"+ data[i].submitunit +"</div>" +
						"<div class='layui-col-md3 my-font16'><span class='my-font-blue'>上报时间：</span>"+ data[i].addtime +"</div>" +
						"</div>" +
						"<div class='layui-row news-table-item'>" +
						"<div class='layui-col-md9'>" +
						"<span class='my-tag-item3 green'>"+ data[i].infotype +"</span>" +
						"<span class='my-tag-item3 green'>"+ data[i].infosource +"</span>" +
						"<span class='my-tag-item3 red'>"+ data[i].urgentflag +"</span>" +
						"<span class='my-tag-item3 red'>"+ data[i].infostate +"</span>" +
						"<span class='my-font16'><span class='my-font-blue' style='cursor:pointer' onclick='qianshoupizhu("+ data[i].id +");'>【源头批注】：</span>"+ pz +"</span>"+
						"</div>" +
						"</div>" +
						"</td>" +
						"</tr>";
			}
			
			tbody.innerHTML = str;
			
		}
	});
}

$(document).ready(function(){
	GetInforTable();
	getinfosource();
	$.ajax({
		type:		'post',
		url:		'<c:url value="/getBMByTypeToJSON1.do"/>?basicType='+88,
		dataType:	'json',
		async:		false,
		success:	function(data){
			var options = fillOption(data);
			options = '<option value="" >情报类型：全部</option>'+options;
			$("select[name^=infotype]").html(options);
		}
	});
});

function add_information(){
	var index = layui.layer.open({
		title:	"新增上报信息",
		type:	2,
		content:locat+"/jsp/information/information_add.jsp?menuid=${param.menuid}",
		area:	['800','800px'],
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

function qianshoupizhu(i){
	var index = layui.layer.open({
		title :	"源头批注列表",
		type:	2,
		content:locat+"/jsp/information/pizhuqianshou.jsp?informationid="+i+"&id=0",
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

layui.use(['form','table','laydate','element'],function(){
	var form = layui.form;
	var table = layui.table;
	var laydate = layui.laydate;
	var element = layui.element;
	
	laydate.render({
		elem:	'#starttime',
		type: 'datetime',
		trigger:'click'
	});
	
	laydate.render({
		elem:	'#endtime',
		type: 'datetime',
		trigger:'click'
	});
	
	form.render();
	
	
	
});

</script>

</body>
</html>
