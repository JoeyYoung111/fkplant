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
    
    <title>检查表详情页面</title>
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
	<link rel="stylesheet" href="<c:url value="/css/system.css"/>" type="text/css"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/js/jquery.form.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  	
</head>
<body style="background-color:#FFFFFF;">
<div class="showinfo">
	<table width="100%" border="1" cellspacing="0" cellpadding="0">
		<tr height="40" bgcolor="#3598DC">
		  	<td colspan="4"><span class="showinfo_title">单位核查详情</span></td>
		</tr>
	
		<tr>
			<td width="25%">
				<strong>企业名称：</strong>
			</td>
			<td width="75%">
				${check.companyname }
			</td>
		</tr>
		<tr>
			<td width="25%">
				<strong>核查日期：</strong>
			</td>
			<td width="75%">
				${check.checkdate }
			</td>
		</tr>
		<tr>
			<td width="25%">
				<strong>检查结果概述：</strong>
			</td>
			<td width="75%">
				${check.resultsummary }
			</td>
		</tr>
		<tr>
			<td width="25%">
				<strong>核查附件：</strong>
			</td>
			<td width="75%">
				<table class="layui-table">
		    		<thead>
		    			<tr>
							<th>文件名</th>
							<th>状态</th>
							<th>操作</th>
						</tr>
		    		</thead>
		    		<tbody id="filelist">
		    			<c:forEach items="${files}" var="row" varStatus="num">
		    				<tr>
		    					<td id="showfiles"><a>${row.fileName }</a></td>
		    					<td>上传完成</td>
		    					<td>
		    						<a href="<c:url value="/downUpfile.do" />?fileid=${row.id }">
		    							<button class="layui-btn layui-btn-xs" type="button">点击下载</button>
		    						</a>
		    					</td>
		    				</tr>
		    			</c:forEach>
		    		</tbody>
		    	</table>
			</td>
		</tr>
		
		<tr>
			<td width="25%">
				<strong>备注信息：</strong>
			</td>
			<td width="75%">
				${check.memo }
			</td>
		</tr>
	
	</table>
</div>

<script type="text/javascript">

$(document).ready(function(){
	
});
	
		
</script>

</body>
</html>
