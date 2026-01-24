<%@ page contentType='text/html;charset=UTF-8' language='java'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<!DOCTYPE HTML>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="<c:url value="/security-dist/layui/css/layui.css"/>"/>
	<link rel="stylesheet" type="text/css" href="<c:url value="/security-dist/css/root.css"/>"/>
	<link rel="stylesheet" type="text/css" href="<c:url value="/security-dist/css/fengxian.css"/>"/>
	<script src="<c:url value="/security-dist/js/jquery-1.9.1.min.js"/>" type="text/javascript"></script>
	<script src="<c:url value="/security-dist/js/global.js"/>" type="text/javascript"></script>
	<script src="<c:url value="/security-dist/js/echarts.min.js"/>"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			$("#mainbody").load("<c:url value='/getFengxianSecurityDist.post'/>?menuid=${param.menuid}");
		});
	</script>
</head>
<body class="body">
	<div id="mainbody"></div>
</body>
</html>