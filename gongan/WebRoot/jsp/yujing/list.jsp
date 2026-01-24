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
     <title>预警信息</title>
    <base href="<%=basePath%>">
    
    <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
   <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  </head>
  
 <body>
<blockquote class="layui-elem-quote news_search">	
<div class="demoTable">
 <form class="layui-form" method="post" style="display:inline;">
 	<div class="layui-inline">
 		<input class="layui-input" type="text" id="result" placeholder=" 关键词查询：" autocomplete="off" >
 	</div>
     <div class="layui-inline" >
			 	<select id="result_status" style="width:170px;">
			 		<option value=''>结果状态：全部</option>
			 		<option value='0'>已接收</option>
			 		<option value='1'>已签收</option>
			 		<option value='2'>已反馈</option>
			 	</select>
			</div>
	</form>
     <button class="layui-btn" id="search" data-type="reload"><i class="layui-icon">&#xe615;</i>搜索</button> 
 </div>
</blockquote>

<table id="followTable" class="layui-hide" lay-filter="followTable"></table> 


<script>
var locat = (window.location+'').split('/'); 
$(function(){if('main'== locat[3]){locat =  locat[0]+'//'+locat[2];}else{locat =  locat[0]+'//'+locat[2]+'/'+locat[3];};});
layui.use(['layer', 'table'], function () {
        var $ = layui.jquery;
        var table = layui.table;
        var layer = layui.layer;
//方法级渲染
  table.render({
    elem: '#followTable',
    toolbar: true,
   	defaultToolbar: ['filter', 'print'],
    url: '<c:url value="/searchYujing.do"/>',
    method:'post',
    cols: [[
<%--    	{field:'id',type:'radio',fixed:'left'},//sort: true 排序--%>
    	{field:'model_title', title: '推送标题', width:320,align:"center",templet: function (item) {
    			var color="black";
    			switch(item.result_status){
    				case '0':color="black";break;
    				case '1':color="red";break;
    				case '2':color="green";break;
    			}
		   		return "<span style='font-weight:500;cursor:pointer;text-decoration: underline;' onclick='showinfoYujing("+item.id+");'><font color='"+color+"'>"+item.model_title+"</font></span>";
           }},
    	{field:'result_status', title: '结果状态', width:120,align:"center",templet: function (item) {
    			var result_status=item.result_status;
    			var color="black";
    			switch(result_status){
    				case '0':
    					result_status="已接收";
    					color="black";
    					break;
    				case '1':
    					result_status="已签收";
    					color="red";
    					break;
    				case '2':
    					result_status="已反馈";
    					color="green";
    					break;
    			}
		   		return "<span><font color='"+color+"'>"+result_status+"</font></span>";
           }} ,
        {field:'create_time', title: '感知时间',align:"center", width:170},
        {field:'addtime', title: '接收时间',align:"center", width:170},
        {field:'updatetime', title: '反馈时间',align:"center", width:170}, 
        {field:'result_feedback', title: '反馈结果',align:"center", width:250}, 
    ]],
    page: true,
    limit: 10
  });
	//搜索查询
  		$("#search").click(function () {
  		  table.reload('followTable', {
				where: { 
					result_status: $("#result_status").val(),
					result: $("#result").val()
				},
				page: {
					curr: 1
					// 重新从第 1 页开始
				}
			});
		});
  });	
   
function showinfoYujing(id){
 	var index = layui.layer.open({
		title : "预警信息详情",
		type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
		content : locat+'/getShowinfoYujing.do?id='+id,
		area: ['800', '600px'],
		maxmin: true,
		success : function(layero, index){
			setTimeout(function(){
				layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
					tips: 3
				});
			},500)
		}
	})			
 }
</script>
</body>

</html>
