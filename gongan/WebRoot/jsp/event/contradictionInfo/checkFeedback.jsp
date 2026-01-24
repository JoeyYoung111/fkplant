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
    
    <title>详情页面</title>
    
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
	<link rel="stylesheet" href="<c:url value="/css/system.css"/>" type="text/css"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  </head>
  
<body style="background-color:#FFFFFF;">
	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
 		<legend id="typeName">审核记录详情</legend>
	</fieldset>
	<table class="layui-hide" id="followTable" lay-filter="followTable"></table> 
	<script type="text/javascript">
		layui.use(['table'], function(){
			var table = layui.table;
			
			//方法级渲染
			table.render({
				elem: '#followTable',
				toolbar: false,
				defaultToolbar: ['filter', 'exports', 'print'],
				url: '<c:url value="/searchAuditRecord.do"/>?cdtid=${param.cdtid }',
				method:'post',
    			cols: [[
    				{field:'examineman', title: '审核人', width:150,align:"center"},
    				{field:'examinetime', title: '审核时间', width:200,align:"center"},
    				{field:'result', title: '审核结果', width:150,align:"center"},
    				{field:'examineopinion', title: '审核反馈意见',align:"center"}
    			]],
    			page: true,
    			limit: 10
  			});
		});
	</script>
</body>
</html>
