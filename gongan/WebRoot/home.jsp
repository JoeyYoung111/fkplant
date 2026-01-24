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
    <title>江阴市公安局社会安全要素管控平台</title>
    <link rel="stylesheet" href="<c:url value="/layui/css/layui1.css"/>"  media="all" />
     <link rel="stylesheet" href="<c:url value="/css/home.css"/>"  media="all" />
     <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
	
   </head>
  
<body class="layui-layout-body body-bg">
		<div class="layui-fluid warp">
			<a href="<c:url value="/toPageindex.do?flag=${param.flag} "/>">
				<div class="nav-btn btn1">
					<span>风险单位</span>
				</div>
			</a>
			<a href="<c:url value="/toPageindex.do?flag=${param.flag} "/>">
				<div class="nav-btn btn2">
					<span>风险人员</span>
				</div>
			</a>
			<a href="<c:url value="/toPageindex.do?flag=${param.flag} "/>">
				<div class="nav-btn btn3">
					<span>风险车辆</span>
				</div>
			</a>
			<a href="<c:url value="/toPageindex.do?flag=${param.flag} "/>">
				<div class="nav-btn btn4">
					<span>风险事件</span>
				</div>
			</a>
			<a href="<c:url value="/toPageindex.do?flag=${param.flag} "/>">
				<div class="nav-btn btn5">
					<span>风险物品</span>
				</div>
			</a>
			<div class="bottom-box">
<%--				<a href="<c:url value="/toPageindex.do"/>">--%>
<%--					<div class="bottom-btn">情报报送</div>--%>
<%--				</a>--%>
				<a href="<c:url value="/allperson.jsp"/>" target="_blank">
					<div class="bottom-btn" style="display:none"  id="demo">人员综合查询</div>
				</a>
			</div>
		</div>
	</body>
	<script type="text/javascript">
	
		$(document).ready(function(){
			if(${param.flag}==1){
			    document.getElementById("demo").style.display="";//显示
			}
		});
	
	</script>
</html>
