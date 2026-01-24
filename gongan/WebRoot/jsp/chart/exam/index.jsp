<%@ page contentType='text/html;charset=UTF-8' language='java'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ page import='java.util.Date'%>
<%@ page import='java.util.Calendar'%>
<%@ page import='java.text.SimpleDateFormat'%>
<%
Date now = new Date();
SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
String endtime = format.format(now);
Calendar c1 = Calendar.getInstance();
c1.add(Calendar.DATE,-30);
String starttime = format.format(c1.getTime());
%>
<!DOCTYPE HTML>
<html>
  <head>
    <title>统计考核</title>
		<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
     	<link rel="stylesheet" href="<c:url value="/css/public.css"/>"  media="all" />
		<link rel="stylesheet" href="<c:url value="/css/qingbao.css"/>"/>
		<script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/js/echarts.min.js"/>"></script>
   		<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
		<script type="text/javascript">
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
				 },
				 value:"<%=starttime%>"
			  });
			  var endTime=laydate.render({
			   	elem:'#endTime',
				done: function(value, date){
				     startTime.config.max={    	    		
			   	    	year:date.year,
			   	    	month:date.month-1,//关键
			            date:date.date
			   	    };
				 },
				 value:"<%=endtime%>"
			  });
				$("#search").click();
			 });
			$(document).ready(function(){
				$("#search").click(function () {
					$("#mainbody").load("<c:url value='/getInfoStatistics.do'/>?starttime="+$("#startTime").val()+"&endtime="+$("#endTime").val());
				});
			});
			
			
		</script>
	</head>
  
	<body>
		<blockquote class="layui-elem-quote news_search">	
		<div class="demoTable">
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
		<div id="mainbody"></div>
	</body>
</html>