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
    <title>数字证书登录</title>
    <link rel="stylesheet" href="<c:url value="/layui/css/layui1.css"/>"  media="all" />
     <link rel="stylesheet" href="<c:url value="/css/login.css"/>"  media="all" />
     <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
	
	<%--<link rel="stylesheet" href="<c:url value="/layui/lay/modules/formSelects/formSelects-v4.css"/>" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui1/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/cardnumber.js"/>"></script>
 --%>
   </head>
  
  
 <body>
		<script>
			layui.use('form', function(){
				var layer=layui.layer;
		    	$.ajax({
	              	url:		'<c:url value="/loginUser.do"/>?cardnumber=${param.cardnumber}',
	              	dataType:	'json',
	              	async:  false,
	              	success:	function(data) {
	              	   if(data.msg.flag>0){
	                  	  // window.location.href="<c:url value="/toPageindex.do"/>";
	                  	   //window.location.href="<c:url value="/home.jsp"/>?flag="+data.msg.flag;
	                  	   window.location.href="<c:url value='/toPageindex.do'/>";
	                 	}else{
	                  	 	layer.msg(data.msg.msg,{time:5000},function(){
		                  	 	window.location.href="<c:url value='/login.jsp'/>";
	                  	 	});
	                	}
	             	},
	              	error:function() {
	                  	layer.alert("请求失败！");
	              	}
	          	});
          	});
		</script>
	</body>
</html>
