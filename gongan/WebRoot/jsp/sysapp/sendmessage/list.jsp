<%@ page contentType='text/html;charset=UTF-8' language='java'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>短信发送</title>
    <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
   	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
    <link rel="stylesheet" href="<c:url value="/css/public.css"/>"  media="all" />
  </head>
  <style>
   
     .my-tab-title li {
     width:45%
     }
   </style>
<body>
<div class="layui-row">
	<div class="layui-tab my-tab layui-tab-brief" lay-filter="mailTab">
		<ul class="layui-tab-title my-tab-title">
			<li class="layui-this">短信发送</li>
			<li>短信发送日志</li>
		</ul>
		<div class="layui-tab-content" style="min-height: 100px;">
			<div class="layui-tab-item layui-show">
				<blockquote class="layui-elem-quote news_search">	
				<form class="layui-form" onsubmit="return false;">
					<div class="layui-inline" style="width:20%;">
						<select name="smstype" id="smstype">
					        <option value="">短信发送类型：</option>
					        <option value="1">模板发送</option>
					        <option value="2">自定义发送</option>
					    </select>
					</div>
					<div class="layui-inline" style="width:20%;">
						<input class="layui-input" type="text" name="smstext" id="smstext" autocomplete="off" placeholder=" 内容关键词：">
					</div>
					<button class="layui-btn" id="search" data-type="reload"><i class="layui-icon">&#xe615;</i>搜 索</button>
					<script type="text/html" id="toolbarDemo">
						<c:if test='${fn:contains(param.buttons,"新增")}'>
   							<button type="button" class="layui-btn layui-btn-sm" lay-event="add"><i class="layui-icon layui-icon-cellphone"></i>发 送 短 信</button>
						</c:if>
   					</script>
				   	<script type="text/html" id="barButton">
           				<a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="showinfo">详情</a>       
					</script>
				</form>
				</blockquote>
				<table class="layui-hide" id="followTable" lay-filter="followTable"></table>
			</div>
			<div class="layui-tab-item">
				<table class="layui-hide" id="mailLog" lay-filter="mailLog"></table>
			</div>
		</div>
	</div>
</div>

<script>
layui.use(['table','form','element'], function(){
	var table = layui.table,
	element = layui.element,
	form = layui.form;
	
	element.on('tab(mailTab)', function(data){
		switch(data.index){
			case 0:
				formSubmit();
			break;
			case 1:
				maillogformSubmit();
			break;
		}
	});
	
	//方法级渲染
	table.render({
    	elem: '#followTable',
    	toolbar: true,
    	defaultToolbar: ['filter', 'exports', 'print'],
    	url: '<c:url value="/searchSendMessage.do"/>',
    	method:'post',
    	toolbar: '#toolbarDemo',
    	cols: [[
    		{field:'smstype', title: '短信发送类型', width:150,align:"center",templet:
    		function(item){
    			if(item.smstype==1){
    				return "模板发送";
    			}else if(item.smstype==2){
    				return "自定义发送";
    			}
    		}},
    		{field:'smstext', title: '短信内容',align:"center"},
    		{field:'sendFlag', title: '接收人', width:300,align:"center",templet:
    		function(item){
    			if(item.sendFlag==1){
    				return item.departnames;
    			}else if(item.sendFlag==2){
    				return item.usernames;
    			}
    		}},
    		{field:'sendtime', title: '发送时间', width:200,align:"center"},
    		{field:'sendoperator', title: '发送人', width:150,align:"center"}
    	]],
    	page: true,
    	limit: 10
	});
	
	//方法级渲染
	table.render({
    	elem: '#mailLog',
    	toolbar: true,
    	defaultToolbar: ['filter', 'exports', 'print'],
    	method:'post',
    	cols: [[
    		{field:'smstype', title: '短信发送类型', width:200,align:"center"},
    		{field:'smstext', title: '短信内容',align:"center"},
    		{field:'sendtime', title: '发送时间', width:200,align:"center"},
    		{field:'sendperson', title: '发送人', width:150,align:"center"},
    		{field:'sendflag', title: '发送状态', width:150,align:"center",templet:
    		function(item){
    			if(item.sendflag==0){
    				return "未发送";
    			}else if(item.sendflag==1){
    				return "已发送";
    			}
    		}},
    	]],
    	page: true,
    	limit: 10
	});
	
	//监听行工具事件
	table.on('toolbar(followTable)', function(obj){
    	var  checkStatus =table.checkStatus(obj.config.id);
   		switch(obj.event){
   		case 'add':
   			var index = layui.layer.open({
				title : "发送短信",
				type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
				content : '<c:url value="/jsp/sysapp/sendmessage/send.jsp"/>?menuid=${param.menuid }',
				area: ['800', '800px'],
				maxmin: true,
				success : function(layero, index){
					setTimeout(function(){
						layui.layer.tips('点击此处返回文章列表', '.layui-layer-setwin .layui-layer-close', {
							tips: 3
						});
					},500)
				}
			})			
			layui.layer.full(index);
		break;
		}
	});
	
	//搜索查询
 	$("#search").click(function () {
 		formSubmit();
	});
});
	function formSubmit(){
		var smstype;
		if($("#smstype").val()!=""){
			smstype=$("#smstype").val();
		}else{
			smstype=0;
		}
		layui.table.reload('followTable', {
			where: { // 设定异步数据接口的额外参数，任意设
				smstext: $("#smstext").val(),
				smstype:smstype
			},
			page: {
				curr: 1
				// 重新从第 1 页开始
			}
		});
	}
	
	function maillogformSubmit(){
		layui.table.reload('mailLog', {
			url: '<c:url value="/searchSendMessageLog.do"/>',
			where: { 
				// 设定异步数据接口的额外参数，任意设
			},
			page: {
				curr: 1
				// 重新从第 1 页开始
			}
		});
	}
</script>
</body>

</html>