<%@ page contentType='text/html;charset=UTF-8' language='java'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<!DOCTYPE HTML>
<html>
  <head>
    <title>涉恐人员统计</title>
		<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
     	<link rel="stylesheet" href="<c:url value="/css/public.css"/>"  media="all" />
		<link rel="stylesheet" href="<c:url value="/css/qingbao.css"/>"/>
		<script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/js/echarts.min.js"/>"></script>
		<script type="text/javascript">
			$(document).ready(function(){
				$("#mainbody").load("<c:url value='/getKongStatistics.do'/>");
			});
		</script>
	</head>
  
	<body>
		<div id="mainbody"></div>
  </body>
</html>