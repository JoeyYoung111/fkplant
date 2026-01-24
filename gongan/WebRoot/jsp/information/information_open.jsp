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
	<ul class="layui-tab-title my-tab-title">
		<li class="layui-this" onclick="GetInforTable();"><font size="4">接收情报</font></li>
		<li onclick="GetTuiHui();"><font size="4">退回信息</font></li>
		<li onclick="GetGuanZhu();"><font size="4">我的关注</font></li>
	</ul>
	
	<div class="layui-tab-content" style="height: 100px;">
	
		<div class="layui-tab-item layui-show">
		
			<blockquote class="layui-elem-quote news_search">	
				<div class="demoTable">
					<form class="layui-form layui-form-pane" onsubmit="return false;">
						<input type="hidden" id="limit" name="limit" value="10"/>
						<input type="hidden" id="pageNumber" name="pageNumber" value="1"/>
						<input type="hidden" id="maxCount" name="maxCount" value=""/>
						<input type="hidden" id="receiveid" name="receiveid" value="<%=userSession.getLoginUserDepartmentid()%>"/>
				
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
							<select id="specialid" name="specialid" lay-filter="specialid"></select>
						</div>
						<div class="layui-inline">
							<input type="text" name="starttime" class="layui-input" id="starttime" placeholder="上报时间段:上报时间" autocomplete="off"/>
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
							<input type="text" class="layui-input" name="departmentid" id="departmentid" lay-filter="departmentid" value="0" autocomplete="off" placeholder="上报单位：" />
						</div>
						<div class="layui-inline">
							<input type="text" name="endtime" class="layui-input" id="endtime" placeholder="上报时间段:截止时间" autocomplete="off"/>
						</div>
						<button class="layui-btn" id="searchInformation" data-type="reload"><i class="layui-icon">&#xe615;</i>搜 索</button>
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
								</select>
							</span>
						</div>
					</div>
				</div>
			</div>
			
		</div>

		
		<div class="layui-tab-item">
		
			<blockquote class="layui-elem-quote news_search">	
				<form class="layui-form layui-form-pane" onsubmit="return false;">
					<input type="hidden" id="tuihuilimit" name="tuihuilimit" value="10"/>
					<input type="hidden" id="tuihuipageNumber" name="tuihuipageNumber" value="1"/>
					<input type="hidden" id="tuihuimaxCount" name="tuihuimaxCount" value=""/>
					<input type="hidden" id="tuihuidepartmentid" name="tuihuidepartmentid" value="<%=userSession.getLoginUserDepartmentid()%>"/>
					<div class="layui-inline">
						<input class="layui-input" type="text" id="tuihuiinfotitle" placeholder=" 情报标题：" autocomplete="off" style="width:250px;" />
					</div>
					<div class="layui-inline">
						<select id="tuihuiinfostate" style="width:170px;">
							<option value=""> 情报状态: 全部</option>
			                <option value="已发生">已发生</option>
						    <option value="正发生">正发生</option>
							<option value="未发生">未发生</option>
						</select>
					</div>
					<div class="layui-inline">
			             <select id="tuihuiurgentflag" name="tuihuiurgentflag" lay-filter="tuihuiurgentflag">
							<option value="" selected>紧急程度：全部</option>
							<option value="一般">一般</option>
							<option value="紧急">紧急</option>
							<option value="重要">重要</option>
						</select>
					</div>
					<div class="layui-inline">
						<input type="text" class="layui-input" name="tuihuireceiveid" id="tuihuireceiveid" lay-filter="tuihuireceiveid" value="0" autocomplete="off" />
					</div>
					<div class="layui-inline">
						<input type="text" name="tuihuistarttime" class="layui-input" id="tuihuistarttime" placeholder="开始时间：" autocomplete="off"/>
					</div>
					<br>
					<div class="layui-inline">
						<input class="layui-input" type="text" id="tuihuiinfocontent" placeholder=" 情报内容：" autocomplete="off"  style="width:250px;" >
					</div>
					<div class="layui-inline">
						<select id="tuihuiinfosource" name="tuihuiinfosource" lay-filter="tuihuiinfosource"></select>
					</div>
					<div class="layui-inline">
						<select id="tuihuiinfotype" name="tuihuiinfotype" lay-filter="tuihuiinfotype"></select>
					</div>
					<div class="layui-inline">
				        <select id="tuihuivalidflag" name="tuihuivalidflag" lay-filter="tuihuivalidflag">
							<option value="2" selected>情报状态：退回</option>
							<option value="3">未签收</option>
							<option value="4">已签收</option>
							<option value="5">未反馈</option>
							<option value="6">已反馈</option>
						</select>
					</div>
					<div class="layui-inline">
						<input type="text" name="tuihuiendtime" class="layui-input" id="tuihuiendtime" placeholder="退回时间：" autocomplete="off"/>
					</div>
					<button class="layui-btn" id="tuihuisearchInformation" data-type="reload"><i class="layui-icon">&#xe615;</i>搜 索</button>	
				</form>
			</blockquote>
					
			<div class="layui-row">
				<table class="layui-table my-table" id="tuihuiInformationTable" lay-filter="tuihuiInformationTable" lay-skin="nob" style="max-height:500px;">
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
					<tbody id="tbody-tuihui">
					</tbody>
				</table>
				<div class="layui-table-page">
					<div id="layui-table-page1">
						<div class="layui-box layui-laypage layui-laypage-default" id="layui-laypage-2">
							<a href="javascript:;" class="tuihuilayui-laypage-prev"><i class="layui-icon">&#xe603;</i></a>
							<span class="layui-laypage-count" id="tuihuiNumshow"></span>
							<a href="javascript:;" class="tuihuilayui-laypage-next"><i class="layui-icon">&#xe602;</i></a>
							<span class="layui-laypage-count" id="tuihuisumNum"></span>
							<span class="layui-laypage-skip">到第<input type="text" id="tuihuitoPnum" min="1" value="" class="layui-input">页
							<button type="button" class="layui-laypage-btn" onclick="tuihuichoosePage()">确定</button></span>
							<span class="layui-laypage-count" id="tuihuiallcount"></span>
							<span class="layui-laypage-limits">
								<select id="tuihuipagenum1" name="tuihuipagenum1">
									<option value="10" selected>10 条/页</option>
									<option value="15">15 条/页</option>
									<option value="20">20 条/页</option>
									<option value="25">25 条/页</option>
									<option value="50">50 条/页</option>
									<option value="100">100 条/页</option>
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
						<input type="hidden" id="guanzhulimit" name="guanzhulimit" value="10"/>
						<input type="hidden" id="guanzhupageNumber" name="guanzhupageNumber" value="1"/>
						<input type="hidden" id="guanzhumaxCount" name="guanzhumaxCount" value=""/>
						<input type="hidden" id="guanzhureceiveid" name="guanzhureceiveid" value="<%=userSession.getLoginUserDepartmentid()%>"/>
				
						<div class="layui-inline">
							<input class="layui-input" type="text" id="guanzhuinfotitle" placeholder=" 情报标题：" autocomplete="off"   style="width:250px;" >
						</div>
						<div class="layui-inline">
							<select id="guanzhuinfostate" style="width:170px;">
								<option value=""> 情报状态: 全部</option>
								<option value="已发生">已发生</option>
								<option value="正发生">正发生</option>
								<option value="未发生">未发生</option>
							</select>
						</div>
						<div class="layui-inline">
							 <select id="guanzhuurgentflag" name="guanzhuurgentflag" lay-filter="guanzhuurgentflag">
								<option value="" selected>紧急程度：全部</option>
								<option value="一般">一般</option>
								<option value="紧急">紧急</option>
								<option value="重要">重要</option>
							</select>
						</div>
						<div class="layui-inline">
							<select id="guanzhuspecialid" name="guanzhuspecialid" lay-filter="guanzhuspecialid"></select>
						</div>
						<div class="layui-inline">
							<input type="text" name="guanzhustarttime" class="layui-input" id="guanzhustarttime" placeholder="开始时间：" autocomplete="off"/>
						</div>
						<br>
						<div class="layui-inline">
							<input class="layui-input" type="text" id="guanzhuinfocontent" placeholder=" 情报内容：" autocomplete="off"  style="width:250px;" >
						</div>
						<div class="layui-inline">
							<select id="guanzhuinfosource" name="guanzhuinfosource" lay-filter="infosource"></select>
						</div>
						
						<div class="layui-inline">
							<select id="guanzhuinfotype" name="guanzhuinfotype" lay-filter="guanzhuinfotype"></select>
						</div>
						<div class="layui-inline">
							<input type="text" class="layui-input" name="guanzhudepartmentid" id="guanzhudepartmentid" lay-filter="guanzhudepartmentid" value="0" autocomplete="off" placeholder="上报单位：" />
						</div>
						<div class="layui-inline">
							<input type="text" name="guanzhuendtime" class="layui-input" id="guanzhuendtime" placeholder="结束时间：" autocomplete="off"/>
						</div>
						<button class="layui-btn" id="searchguanzhuInformation" data-type="reload"><i class="layui-icon">&#xe615;</i>搜 索</button>
					</form>
				</div>
			</blockquote>			
		
			<div class="layui-row">
				<table class="layui-table my-table" id="guanzhuInformationTable" lay-filter="guanzhuInformationTable" lay-skin="nob" style="max-height:500px;">
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
					<tbody id="tbody-guanzhu">
					</tbody>
				</table>
				<div class="layui-table-page">
					<div id="layui-table-page1">
						<div class="layui-box layui-laypage layui-laypage-default" id="layui-laypage-2">
							<a href="javascript:;" class="guanzhulayui-laypage-prev"><i class="layui-icon">&#xe603;</i></a>
							<span class="layui-laypage-count" id="guanzhupNumshow"></span>
							<a href="javascript:;" class="guanzhulayui-laypage-next"><i class="layui-icon">&#xe602;</i></a>
							<span class="layui-laypage-count" id="guanzhusumNum"></span>
							<span class="layui-laypage-skip">到第<input type="text" id="guanzhutoPnum" min="1" value="" class="layui-input">页
							<button type="button" class="layui-laypage-btn" onclick="guanzhuchoosePage()">确定</button></span>
							<span class="layui-laypage-count" id="guanzhuallcount"></span>
							<span class="layui-laypage-limits">
								<select id="guanzhupagenum1" name="guanzhupagenum1">
									<option value="10" selected>10 条/页</option>
									<option value="15">15 条/页</option>
									<option value="20">20 条/页</option>
									<option value="25">25 条/页</option>
									<option value="50">50 条/页</option>
									<option value="100">100 条/页</option>
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

var tbody=window.document.getElementById("tbody-result");
var tuihuibody=window.document.getElementById("tbody-tuihui");
var guanzhubody=window.document.getElementById("tbody-guanzhu");

var jiebao = "jiebao";
var tuihui = "tuihui";

layui.config({
    base: "<c:url value="/layui/lay/modules/"/>"
}).extend({
	zTreeSelectM: "zTreeSelectM/zTreeSelectM",
    treeSelect: "treeSelect"
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
			$("select[name^=infosource]").html(options);
			$("select[name^=tuihuiinfosource]").html(options);
		}
	});
}

function specialid(){
	$.ajax({
		type:		'post',
		url:		'<c:url value="/getSpecialidToJSON.do"/>?departmentid='+$("#receiveid").val(),
		dataType:	'json',
		async:		false,
		success:	function(data){
			var options = fillOption(data);
			options = '<option value="0" > 专项标签：全部</option>'+options;
			$("select[name^=specialid]").html(options);
			$("select[name^=guanzhuspecialid]").html(options);
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
			$("select[name^=infotype]").html(options);
			$("select[name^=tuihuiinfotype]").html(options);
			$("select[name^=guanzhuinfotype]").html(options);
		}
	});
}

$("#searchInformation").click(function(){
	GetInforTable();
});

function choosePage(){
	var toPnum = $("#toPnum").val();
	$("#pageNumber").val(toPnum);
	$("#searchInformation").click();
}

$("select[name='pagenum1']").change(function(){
	$("#limit").val($(this).val());
	$("#pageNumber").val("1");
	$("#toPnum").val("");
	$("#searchInformation").click();
});

$("a.layui-laypage-prev").click(function(){
	var nowpage = $("#pageNumber").val();
	var maxy = $("#maxCount").val();
	if(nowpage > 1 && nowpage <=maxy){
		$("#pageNumber").val(nowpage-1);
		$("#searchInformation").click();
	}
});

$("a.layui-laypage-next").click(function(){
	var nowpage = parseInt($("#pageNumber").val());
	var maxy = parseInt($("#maxCount").val());
	if(nowpage >= 1 && nowpage < maxy){
		$("#pageNumber").val(nowpage+1);
		$("#searchInformation").click();
	}
});

function GetInforTable(){
	$.ajax({
		url:		'<c:url value="/searchInformationSend.do"/>',
		type:		'post',
		data:		{	
						receiveid:$("#receiveid").val(),
						infotitle:$("#infotitle").val(),
						infocontent:$("#infocontent").val(),
						departmentid:$("#departmentid").val(),
						infostate:$("#infostate option:selected").val(),
						urgentflag:$("#urgentflag option:selected").val(),
						infosource:$("#infosource").val(),
						infotype:$("#infotype option:selected").val(),
						specialid:$("#specialid option:selected").val(),
						gatherid:$("#gatherid").val()==null?0:$("#gatherid").val(),
						annotationid:$("#annotationid option:selected").val(),
						starttime:$("#starttime").val(),
						endtime:$("#endtime").val(),
						limit:$("#limit").val(),
						pageNumber:$("#pageNumber").val(),
						followflag:0
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
				var color = 'layui-bg-green';
				var zhidingcolor = data[i].topflag==1?'layui-bg-red':'layui-bg-green';
				var specialid = data[i].specialid==0?"<span class='layui-btn layui-btn-normal layui-btn-sm'>无</span>":"<span class='layui-btn layui-btn-normal layui-btn-sm'>"+ data[i].specialName +"</span>";
				var guanzhucolor = data[i].followflag==1?'layui-bg-red':'layui-bg-green';
				if(data[i].validflag>=2){
					color = 'layui-bg-gray';
				}
				
				var pz = null==data[i].gongzuopizhu?'无':data[i].gongzuopizhu;
				
				str += "<tr class='my-border-b'>" +
						"<td colspan='12'>" +
						"<div class='layui-row news-table-item'>" +
						"<div class='layui-col-md4 my-font-bold my-font18 my-font-blue' style='cursor:pointer' onclick='showinfo("+data[i].id+","+data[i].informationid+","+data[i].validflag+","+data[i].specialid+","+jiebao+");'>"+data[i].infotitle+"</div>"+
						"<div class='layui-col-md3 my-font16'><span class='my-font-blue'>上报单位：</span>"+ data[i].departname +"</div>" +
						"<div class='layui-col-md2 my-font16'><span class='my-font-blue'>上报时间：</span>"+ data[i].addtime +"</div>" +
						"<div class='layui-col-md3'>" +
						"<button class='layui-btn "+ color +" layui-btn-sm layui-icon my-btn-more news-table-btn' onclick='tuihuiqb("+data[i].id+","+data[i].validflag+","+data[i].informationid+");'>退</button>" +
						"<button class='layui-btn "+ color +" layui-btn-sm layui-icon my-btn-more news-table-btn' onclick='zhuanyue("+data[i].id+","+data[i].validflag+");'>转</button>" +
						"<button class='layui-btn "+ color +" layui-btn-sm layui-icon my-btn-more news-table-btn' onclick='pizhu("+data[i].id+","+data[i].validflag+","+data[i].informationid+","+data[i].departmentid+");'>批</button>" +
						"<button class='layui-btn "+ color +" layui-btn-sm layui-icon my-btn-more news-table-btn' onclick='jiaoban("+data[i].id+","+data[i].validflag+");'>交</button>"+
						"<button class='layui-btn "+ zhidingcolor +" layui-btn-sm layui-icon my-btn-more news-table-btn' onclick='zhiding("+data[i].id+","+data[i].topflag+");'>顶</button>" +
						"</div>" +
						"</div>" +
						"<div class='layui-row news-table-item'>" +
						"<div class='layui-col-md9'>" +
						"<span class='my-tag-item3 green'>"+ data[i].infotype +"</span>" +
						"<span class='my-tag-item3 green'>"+ data[i].infosource +"</span>" +
						"<span class='my-tag-item3 red'>"+ data[i].urgentflag +"</span>" +
						"<span class='my-tag-item3 red'>"+ data[i].infostate +"</span>" +
						specialid +
						"<span class='my-font16'><span class='my-font-blue'>【工作批注】：</span>"+ pz +"</span>"+
						"</div>" +
						"<div class='layui-col-md3'>" +
						"<button class='layui-btn "+ color +" layui-btn-sm layui-icon my-btn-more news-table-btn' onclick='zhuanxiang("+data[i].id+","+data[i].validflag+","+data[i].specialid+","+data[i].informationid+");'>专</button>" +
						"<button class='layui-btn "+ color +" layui-btn-sm layui-icon my-btn-more news-table-btn' onclick='zhibao("+data[i].id+","+data[i].validflag+");'>直</button>" +
						"<button class='layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more news-table-btn' onclick='daochu("+data[i].id+");'>导</button>" +
						"<button class='layui-btn "+ guanzhucolor +" layui-btn-sm layui-icon my-btn-more news-table-btn' onclick='guanzhu("+data[i].id+","+data[i].followflag+","+"1"+");'>关</button>" +
						"</div>" +
						"</div>" +
						"</td>" +
						"</tr>";
			}
			
			tbody.innerHTML = str;
			
		}
	});
}

$("#tuihuisearchInformation").click(function(){
	GetTuiHui();
});

function tuihuichoosePage(){
	var toPnum = $("#tuihuitoPnum").val();
	$("#tuihuipageNumber").val(toPnum);
	$("#tuihuisearchInformation").click();
}

$("select[name='tuihuipagenum1']").change(function(){
	$("#tuihuilimit").val($(this).val());
	$("#tuihuipageNumber").val("1");
	$("#tuihuitoPnum").val("");
	$("#tuihuisearchInformation").click();
});

$("a.tuihuilayui-laypage-prev").click(function(){
	var nowpage = $("#tuihuipageNumber").val();
	var maxy = $("#tuihuimaxCount").val();
	if(nowpage > 1 && nowpage <=maxy){
		$("#tuihuipageNumber").val(nowpage-1);
		$("#tuihuisearchInformation").click();
	}
});

$("a.tuihuilayui-laypage-next").click(function(){
	var nowpage = parseInt($("#tuihuipageNumber").val());
	var maxy = parseInt($("#tuihuimaxCount").val());
	if(nowpage >= 1 && nowpage < maxy){
		$("#tuihuipageNumber").val(nowpage+1);
		$("#tuihuisearchInformation").click();
	}
});

function GetTuiHui(){
	var tuihuivalidflag = $("#tuihuivalidflag").val();
	var validflag = 2;
	var validflag2 = 0;
	if(tuihuivalidflag == 3){
		validflag = 2;
		validflag2 = 3;
	}else if(tuihuivalidflag == 4){
		validflag = 3;
		validflag2 = 4;
	}else if(tuihuivalidflag == 5){
		validflag = 2;
		validflag2 = 4;
	}else if(tuihuivalidflag == 6){
		validflag = 4;
		validflag2 = 5;
	}
	
	$.ajax({
		url:		'<c:url value="/searchInformationSend.do"/>',
		type:		'post',
		data:		{	
						validflag:validflag,
						validflag2:validflag2,
						infotitle:$("#tuihuiinfotitle").val(),
						infostate:$("#tuihuiinfostate option:selected").val(),
						urgentflag:$("#tuihuiurgentflag option:selected").val(),
						infocontent:$("#tuihuiinfocontent").val(),
						infosource:$("#tuihuiinfosource option:selected").val(),
						infotype:$("#tuihuiinfotype option:selected").val(),
						receiveid:$("#tuihuireceiveid").val(),
						tuihuistarttime:$("#tuihuistarttime").val(),
						tuihuiendtime:$("#tuihuiendtime").val(),
						departmentid:$("#tuihuidepartmentid").val(),
						limit:$("#tuihuilimit").val(),
						pageNumber:$("#tuihuipageNumber").val(),
						followflag:0
					},
		dataType:	'json',
		success:	function(result){
			var total = result.total;
			$("#tuihuiallcount").html("共 "+total+" 条");
			var yema = $("#tuihuipageNumber").val();
			$("#tuihuiNumshow").html("&nbsp;&nbsp;&nbsp;第 "+yema+" 页");
			var sumyema = result.allpagenum;
			$("#tuihuisumNum").html("&nbsp;&nbsp;&nbsp;共 "+sumyema+" 页");
			$("#tuihuimaxCount").val(sumyema);
			var str = "";
			var data = result.data;
			for( var i=0;i<data.length;i++){
				var qianshoucolor = data[i].validflag>=3?'layui-bg-gray':'layui-bg-green';
				var fankuicolor = data[i].validflag==4?'layui-bg-gray':'layui-bg-green';
				var pz = null==data[i].yuantoupizhu?'无':data[i].yuantoupizhu;
				var qs = "<span class='my-font-blue'>【已签收】</span>";
				var qianshouinfo = data[i].validflag>=3?qs+data[i].signoper+" "+data[i].signtime:"";
				var fk = "<span class='my-font-blue'>【已反馈】</span>";
				var fankuiinfo = data[i].validflag==4?fk+data[i].feedbackoper+" "+data[i].feedbacktime+" "+data[i].feedbackcontent:"";
				
				str += "<tr class='my-border-b'>" +
						"<td colspan='12'>" +
						"<div class='layui-row news-table-item'>" +
						"<div class='layui-col-md4 my-font-bold my-font18 my-font-blue' style='cursor:pointer' onclick='showinfo("+data[i].id+","+data[i].informationid+","+data[i].validflag+","+data[i].specialid+","+tuihui+");'>"+data[i].infotitle+"</div>"+
						"<div class='layui-col-md3 my-font16'><span class='my-font-blue'>退回单位：</span>"+ data[i].receivename +"</div>" +
						"<div class='layui-col-md2 my-font16'><span class='my-font-blue'>退回时间：</span>"+ data[i].tuihuitime +"</div>" +
						"<div class='layui-col-md3'>" +
						"<button class='layui-btn "+ qianshoucolor +" layui-btn-sm layui-icon my-btn-more news-table-btn' onclick='qianshou("+data[i].id+","+data[i].validflag+","+data[i].informationid+")'>签收</button>" +
						"<button class='layui-btn "+ fankuicolor +" layui-btn-sm layui-icon my-btn-more news-table-btn' onclick='fankui("+data[i].id+","+data[i].validflag+","+data[i].informationid+")'>反馈</button>" + 
						"</div>" +
						"</div>" +
						"<div class='layui-row news-table-item'>" +
						"<div class='layui-col-md9'>" +
						"<span class='my-tag-item3 green'>"+ data[i].infotype +"</span>" +
						"<span class='my-tag-item3 green'>"+ data[i].infosource +"</span>" +
						"<span class='my-tag-item3 red'>"+ data[i].urgentflag +"</span>" +
						"<span class='my-tag-item3 red'>"+ data[i].infostate +"</span>" +
						"<span class='my-font16'><span class='my-font-blue' style='cursor:pointer' onclick='qianshoupizhu("+ data[i].informationid + "," + data[i].id +");'>【源头批注】：</span>"+ pz +"</span>"+
						"<span class='my-font16'><span class='my-font-blue'>【退回原因】：</span>"+ data[i].tuihuireason +"</span>"+
						"<span>"+qianshouinfo+"</span>&nbsp;"+
						"<span>"+fankuiinfo+"</span>"+
						"</div>" +
						"</div>" +
						"</td>" +
						"</tr>";
			}
			
			tuihuibody.innerHTML = str;
			
		}
	});
}

$("#searchguanzhuInformation").click(function(){
	GetGuanZhu();
});

function guanzhuchoosePage(){
	var guanzhutoPnum = $("#guanzhutoPnum").val();
	$("#guanzhupageNumber").val(guanzhutoPnum);
	$("#searchguanzhuInformation").click();
}

$("select[name='guanzhupagenum1']").change(function(){
	$("#guanzhulimit").val($(this).val());
	$("#guanzhupageNumber").val("1");
	$("#guanzhutoPnum").val("");
	$("#searchguanzhuInformation").click();
});

$("a.guanzhulayui-laypage-prev").click(function(){
	var guanzhunowpage = $("#guanzhupageNumber").val();
	var guanzhumaxy = $("#guanzhumaxCount").val();
	if(guanzhunowpage > 1 && guanzhunowpage <=guanzhumaxy){
		$("#guanzhupageNumber").val(guanzhunowpage-1);
		$("#searchguanzhuInformation").click();
	}
});

$("a.guanzhulayui-laypage-next").click(function(){
	var guanzhunowpage = parseInt($("#guanzhupageNumber").val());
	var guanzhumaxy = parseInt($("#guanzhumaxCount").val());
	if(guanzhunowpage >= 1 && guanzhunowpage < guanzhumaxy){
		$("#guanzhupageNumber").val(guanzhunowpage+1);
		$("#searchguanzhuInformation").click();
	}
});

function GetGuanZhu(){
	$.ajax({
		url:		'<c:url value="/searchInformationSend.do"/>',
		type:		'post',
		data:		{	
						receiveid:$("#guanzhureceiveid").val(),
						infotitle:$("#guanzhuinfotitle").val(),
						infocontent:$("#guanzhuinfocontent").val(),
						departmentid:$("#guanzhudepartmentid").val(),
						infostate:$("#guanzhuinfostate option:selected").val(),
						urgentflag:$("#guanzhuurgentflag option:selected").val(),
						infosource:$("#guanzhuinfosource").val(),
						infotype:$("#guanzhuinfotype option:selected").val(),
						specialid:$("#guanzhuspecialid option:selected").val(),
						gatherid:$("#guanzhugatherid").val()==null?0:$("#gatherid").val(),
						annotationid:$("#guanzhuannotationid option:selected").val(),
						starttime:$("#guanzhustarttime").val(),
						endtime:$("#guanzhuendtime").val(),
						limit:$("#guanzhulimit").val(),
						pageNumber:$("#guanzhupageNumber").val(),
						followflag:1
					},
		dataType:	'json',
		success:	function(result){
			var total = result.total;
			$("#guanzhuallcount").html("共 "+total+" 条");
			var yema = $("#guanzhupageNumber").val();
			$("#guanzhupNumshow").html("&nbsp;&nbsp;&nbsp;第 "+yema+" 页");
			var sumyema = result.allpagenum;
			$("#guanzhusumNum").html("&nbsp;&nbsp;&nbsp;共 "+sumyema+" 页");
			$("#guanzhumaxCount").val(sumyema);
			var str = "";
			var data = result.data;
			for( var i=0;i<data.length;i++){
				var color = 'layui-bg-green';
				var zhidingcolor = data[i].topflag==1?'layui-bg-red':'layui-bg-green';
				var specialid = data[i].specialid==0?"<span class='layui-btn layui-btn-normal layui-btn-sm'>无</span>":"<span class='layui-btn layui-btn-normal layui-btn-sm'>"+ data[i].specialName +"</span>";
				var guanzhucolor = data[i].followflag==1?'layui-bg-red':'layui-bg-green';
				if(data[i].validflag>=2){
					color = 'layui-bg-gray';
				}
				
				var pz = null==data[i].gongzuopizhu?'无':data[i].gongzuopizhu;
				
				str += "<tr class='my-border-b'>" +
						"<td colspan='12'>" +
						"<div class='layui-row news-table-item'>" +
						"<div class='layui-col-md4 my-font-bold my-font18 my-font-blue' style='cursor:pointer' onclick='showinfo("+data[i].id+","+data[i].informationid+","+data[i].validflag+","+data[i].specialid+","+jiebao+");'>"+data[i].infotitle+"</div>"+
						"<div class='layui-col-md3 my-font16'><span class='my-font-blue'>上报单位：</span>"+ data[i].departname +"</div>" +
						"<div class='layui-col-md2 my-font16'><span class='my-font-blue'>上报时间：</span>"+ data[i].addtime +"</div>" +
						"<div class='layui-col-md3'>" +
						"<button class='layui-btn "+ color +" layui-btn-sm layui-icon my-btn-more news-table-btn' onclick='tuihuiqb("+data[i].id+","+data[i].validflag+","+data[i].informationid+");'>退</button>" +
						"<button class='layui-btn "+ color +" layui-btn-sm layui-icon my-btn-more news-table-btn' onclick='zhuanyue("+data[i].id+","+data[i].validflag+");'>转</button>" +
						"<button class='layui-btn "+ color +" layui-btn-sm layui-icon my-btn-more news-table-btn' onclick='pizhu("+data[i].id+","+data[i].validflag+","+data[i].informationid+","+data[i].departmentid+");'>批</button>" +
						"<button class='layui-btn "+ zhidingcolor +" layui-btn-sm layui-icon my-btn-more news-table-btn' onclick='zhiding("+data[i].id+","+data[i].topflag+");'>顶</button>" +
						"</div>" +
						"</div>" +
						"<div class='layui-row news-table-item'>" +
						"<div class='layui-col-md9'>" +
						"<span class='my-tag-item3 green'>"+ data[i].infotype +"</span>" +
						"<span class='my-tag-item3 green'>"+ data[i].infosource +"</span>" +
						"<span class='my-tag-item3 red'>"+ data[i].urgentflag +"</span>" +
						"<span class='my-tag-item3 red'>"+ data[i].infostate +"</span>" +
						specialid +
						"<span class='my-font16'><span class='my-font-blue'>【工作批注】：</span>"+ pz +"</span>"+
						"</div>" +
						"<div class='layui-col-md3'>" +
						"<button class='layui-btn "+ color +" layui-btn-sm layui-icon my-btn-more news-table-btn' onclick='zhuanxiang("+data[i].id+","+data[i].validflag+","+data[i].specialid+","+data[i].informationid+");'>专</button>" +
						"<button class='layui-btn "+ color +" layui-btn-sm layui-icon my-btn-more news-table-btn' onclick='zhibao("+data[i].id+","+data[i].validflag+");'>直</button>" +
						"<button class='layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more news-table-btn' onclick='daochu("+data[i].id+");'>导</button>" +
						"<button class='layui-btn "+ guanzhucolor +" layui-btn-sm layui-icon my-btn-more news-table-btn' onclick='guanzhu("+data[i].id+","+data[i].followflag+","+"2"+");'>关</button>" +
						"</div>" +
						"</div>" +
						"</td>" +
						"</tr>";
			}
			
			guanzhubody.innerHTML = str;
			
		}
	});
}

$(document).ready(function(){
	getinfosource();
	getinfotype();
	specialid();
	$("#searchInformation").click();
});

function showinfo(i,j,k,l,m){
	var index = layui.layer.open({
		title :	"查看情报详情",
		type:	2,
		content:'<c:url value="/showinfoInformationSend.do"/>?id='+i+"&informationid="+j+"&validflag="+k+"&specialid="+l+"&menuid=${param.menuid}&page="+m,
		area: ['800', '800px'],
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

function tuihuiqb(i,j,k){
	if(j<2){
		var index = layui.layer.open({
			title :	"退回原因",
			type:	2,
			content:locat+"/jsp/information/tuihui.jsp?id="+i+"&informationid="+k,
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

function zhuanyue(i,j){
	if(j<2){
		var index = layui.layer.open({
			title :	"新增转阅信息",
			type:	2,
			content:'<c:url value="/getInformationSendById.do"/>?menuid=${param.menuid}&page=addReceive&id='+i,
			area: ['800', '800px'],
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

function pizhu(i,j,k,l){
	if(j<2){
		var index = layui.layer.open({
			title :	"新增批注",
			type:	2,
			content:'<c:url value="/searchInfoAnnotation.do"/>?id='+i+"&informationid="+k+"&receiveid="+l,
			area: ['800', '350px'],
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

function zhiding(i,j){
	if(j==0){
		j=1;
	}else{
		j=0;
	}
	$.ajax({
		url:		'<c:url value="/updateinfosendflag.do"/>?page=topflag',
		type:		'post',
		data:		{id:i,topflag:j},
		dataType:	'json',
		async:		false,
		success:	function(data){
			$("#searchInformation").click();
		}
	});
}

function zhuanxiang(i,j,k,l){
	if(j<2){
		var index = layui.layer.open({
			title :	"专项标签",
			type:	2,
			content:locat+"/jsp/information/zhuanxiang.jsp?departmentid="+$("#receiveid").val()+"&informationsendid="+i+"&special="+k+"&informationid="+l,
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

function zhibao(i,j){
	if(j<2){
		var index = layui.layer.open({
			title:	"新增直报信息",
			type:	2,
			content:'<c:url value="/getInformationSendById.do"/>?menuid=${param.menuid}&page=addzhibao&id='+i,
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
}

function daochu(i){
	var index = layui.layer.open({
		title:		"导出情报",
		type:		2,
		content:	'<c:url value="/daochuinformation_send.do"/>?id='+i,
		area:		['800','800px'],
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

function guanzhu(i,j,k){
	if(j==0){
		j=1;
	}else{
		j=0;
	}
	$.ajax({
		url:		'<c:url value="/updateinfosendflag.do"/>?page=followflag',
		type:		'post',
		data:		{id:i,followflag:j},
		dataType:	'json',
		async:		false,
		success:	function(data){
			if(k==1){
				$("#searchInformation").click();
			}else{
				$("#searchguanzhuInformation").click();
			}
		}
	});
}

function jiaoban(i,j){
	if(j<2){
		var index = layui.layer.open({
			title :	"新增交办信息",
			type:	2,
			content:'<c:url value="/getInformationSendById.do"/>?menuid=${param.menuid}&page=addinfoAssign&id='+i,
			area: ['800', '800px'],
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

function yincang(i,j,k){
	if(k<2){
		if(j==0){
			j=1;
		}else{
			j=0;
		}
		$.ajax({
			url:		'<c:url value="/updateinfosendflag.do"/>?page=hideflag',
			type:		'post',
			data:		{id:i,hideflag:j},
			dataType:	'json',
			async:		false,
			success:	function(data){
				$("#searchInformation").click();
			}
		});
	}
}

function qianshou(i,j,k){
	if(j==2){
		$.ajax({
			url:		'<c:url value="/updateinfosendflag.do"/>?page=tuihuiqianshou',
			type:		'post',
			data:		{id:i,validflag:3,feedbackoperid:0,informationid:k},
			dataType:	'json',
			async:		false,
			success:	function(data){
				layui.layer.msg("签收成功");
				$("#tuihuisearchInformation").click();
			}
		});
	}
}

function fankui(i,j,k){
	if(j==3){
		var index = layui.layer.open({
			title :	"反馈内容",
			type:	2,
			content:locat+"/jsp/information/fankuiContent.jsp?id="+i+"&page=tuihuifankui&informationid="+k,
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
	}else if(j==2){
		layui.layer.msg("需先签收再反馈");
	}
}

function yujin(i,j){}
function caibian(i,j){}

function qianshoupizhu(j,k){
	var index = layui.layer.open({
		title :	"源头批注列表",
		type:	2,
		content:locat+"/jsp/information/pizhuqianshou.jsp?informationid="+j+"&id="+k,
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

layui.use(['form','table','laydate','treeSelect','element'],function(){
	var form = layui.form;
	var table = layui.table;
	var laydate = layui.laydate;
	var treeSelect = layui.treeSelect;
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
	
	laydate.render({
		elem:	'#tuihuistarttime',
		type: 'datetime',
		trigger:'click'
	});
	
	laydate.render({
		elem:	'#tuihuiendtime',
		type: 'datetime',
		trigger:'click'
	});
	
	laydate.render({
		elem:	'#guanzhustarttime',
		type: 'datetime',
		trigger:'click'
	});
	
	laydate.render({
		elem:	'#guanzhuendtime',
		type: 'datetime',
		trigger:'click'
	});
	
	var jiebaotree = treeSelect.render({
		elem:	'#departmentid',	//选择器
		data:	'<c:url value="/getDepartmentTree.do"/>',
		type:	'get',	//异步加载
		placeholder:	'上报单位:全部',
		search:	false,
		style:	{
			folder:	{enable: false},
			line:	{enable: true}
		},
		click: function(d){
		},
		success: function(d){
			var treeObj = treeSelect.zTree('departmentid');
			var newNode = {name:"上报单位:全部",id:0};
			treeObj.addNodes(null,0,newNode);
			treeSelect.refresh('departmentid');
			jiebaotree.hideIcon();
			form.render();
		}
	});
	
	treeSelect.render({
		elem:	'#tuihuireceiveid',	//选择器
		data:	'<c:url value="/getDepartmentTree.do"/>',
		type:	'get',	//异步加载
		placeholder:	'退回单位:全部',
		search:	false,
		style:	{
			folder:	{enable: false},
			line:	{enable: true}
		},
		click: function(d){
		},
		success: function(d){
			var treeObj = treeSelect.zTree('tuihuireceiveid');
			var newNode = {name:"退回单位:全部",id:0};
			treeObj.addNodes(null,0,newNode);
			treeSelect.refresh('tuihuireceiveid');
			jiebaotree.hideIcon();
			form.render();
		}
	});
	
	var guanzhutree = treeSelect.render({
		elem:	'#guanzhudepartmentid',	//选择器
		data:	'<c:url value="/getDepartmentTree.do"/>',
		type:	'get',	//异步加载
		placeholder:	'上报单位:全部',
		search:	false,
		style:	{
			folder:	{enable: false},
			line:	{enable: true}
		},
		click: function(d){
		},
		success: function(d){
			var treeObj = treeSelect.zTree('guanzhudepartmentid');
			var newNode = {name:"上报单位:全部",id:0};
			treeObj.addNodes(null,0,newNode);
			treeSelect.refresh('guanzhudepartmentid');
			jiebaotree.hideIcon();
			form.render();
		}
	});
	
	form.render();
	
});

</script>

</body>
</html>
