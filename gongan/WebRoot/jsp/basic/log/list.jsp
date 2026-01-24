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
    <title>日志列表</title>
    <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  </head>
 <body>
<blockquote class="layui-elem-quote news_search">	
<div class="demoTable">
 <div class="layui-inline">
    <input class="layui-input" name="id" id="demoReload" autocomplete="off" value=" 操作菜单：" onfocus="if(this.value == ' 操作菜单：'){ this.value = '';}" onblur="if(this.value =='') {this.value = ' 操作菜单：'}">
 </div>
 <div class="layui-inline">
    <input class="layui-input" name="id" id="demoReload2" autocomplete="off" value=" 操作行为：" onfocus="if(this.value == ' 操作行为：'){ this.value = '';}" onblur="if(this.value =='') {this.value = ' 操作行为：'}">
 </div>
 <div class="layui-inline">
    <input class="layui-input" name="id" id="demoReload3" autocomplete="off" value=" 操作人：" onfocus="if(this.value == ' 操作人：'){ this.value = '';}" onblur="if(this.value =='') {this.value = ' 操作人：'}">
 </div>
 <div class="layui-inline" style="width:170px;">     
   <input class="layui-input" id="startTime" placeholder="操作时间：" style="width:170px;" autocomplete="off">     
 </div>
 	至
 <div class="layui-inline" style="width:170px;">
    <input class="layui-input" id="endTime" autocomplete="off" style="width:170px;">
 </div>
  <button class="layui-btn" id="search" data-type="reload"><i class="layui-icon">&#xe615;</i>搜 索</button> 
</div>
 </blockquote>
<table class="layui-hide" id="followTable" lay-filter="followTable"></table> 
<script>
var locat = (window.location+'').split('/'); 
$(function(){if('main'== locat[3]){locat =  locat[0]+'//'+locat[2];}else{locat =  locat[0]+'//'+locat[2]+'/'+locat[3];};});
layui.use(['table','laydate'], function(){
  var table = layui.table;
  var laydate = layui.laydate;
  var startTime=laydate.render({
   	elem:'#startTime',
	done: function(value, date){
	    endTime.config.min={    	    		
   	    	year:date.year,
   	    	month:date.month-1,//关键
            date:date.date
   	    };
	  }	
  });
  var endTime=laydate.render({
   	elem:'#endTime',
	done: function(value, date){
	     startTime.config.max={    	    		
   	    	year:date.year,
   	    	month:date.month-1,//关键
            date:date.date
   	    };
	  }
  });
  
  //方法级渲染
  table.render({
    elem: '#followTable',
    toolbar: true,
    defaultToolbar: ['filter', 'exports', 'print'],
    url: '<c:url value="/getLog.do"/>',
    method:'post',
    cols: [[
      {field:'operation', title: '操作行为', width:280,align:"center"} ,    
      {field: 'operationResult', title: '操作结果', width:200,align:"center"} ,
      {field:'operator', title: '操作人', width:160,align:"center"} ,
	  {field:'operationTime', title: '操作时间', width:240, sort: true},
      {field: 'memo', title: '备注', align:"center"} 
    ]],
    page: true,
    limit: 10
    });
    
    	//搜索查询
  		$("#search").click(function () {
  			var startTimes= new Date(Date.parse($("#startTime").val()));
  			var endTimes= new Date(Date.parse($("#endTime").val()));
  			if($("#startTime").val()!=""&&$("#endTime").val()!=""){
  				if(startTimes<=endTimes){
  					table.reload('followTable', {
						where: { // 设定异步数据接口的额外参数，任意设
							menuname: ($("#demoReload").val()==" 操作菜单：")?"":$("#demoReload").val(),
							operation: ($("#demoReload2").val()==" 操作行为：")?"":$("#demoReload2").val(),				
							operator: ($("#demoReload3").val()==" 操作人：")?"":$("#demoReload3").val(),
							startTime: $("#startTime").val(),
							endTime: $("#endTime").val(),
						},
						page: {
							curr: 1
							// 重新从第 1 页开始
						}
					});
  				}else{
  					top.layer.msg("结束时间不能在开始时间之前！");
  				}
  			}else{
  				table.reload('followTable', {
					where: { // 设定异步数据接口的额外参数，任意设
						menuname: ($("#demoReload").val()==" 操作菜单：")?"":$("#demoReload").val(),
						operation: ($("#demoReload2").val()==" 操作行为：")?"":$("#demoReload2").val(),				
						operator: ($("#demoReload3").val()==" 操作人：")?"":$("#demoReload3").val(),
						startTime: $("#startTime").val(),
						endTime: $("#endTime").val(),
					},
					page: {
						curr: 1
						// 重新从第 1 页开始
					}
				});
  			}
		});
 });
</script>
</body>

</html>