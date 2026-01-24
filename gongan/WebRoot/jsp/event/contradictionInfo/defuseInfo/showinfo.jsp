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
    
    <title>稳控化解情况详情页面</title>
    
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
	<link rel="stylesheet" href="<c:url value="/css/system.css"/>" type="text/css"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  </head>
  
  <body style="background-color:#FFFFFF;">
  <div class="showinfo">
	<table width="100%" border="1" cellspacing="0" cellpadding="0">
		<tr height="40" bgcolor="#3598DC">
    		<td colspan="4"><span class="showinfo_title">稳控化解情况详情</span></td>
  		</tr>
		<tr>
	    	<td width="15%">预计落实时间</td>
	    	<td width="85%" colspan="3">${defuseInfo.lsdate }</td>
	    </tr>
	    <tr>
	    	<td width="15%">是否落实情况</td>
	    	<td width="85%" colspan="3">${defuseInfo.sflsqk }</td>
	    </tr>
	    <tr>
			<td width="15%">措施概述</td>
			<td width="80%" colspan="3">${defuseInfo.csgs }</td>
		</tr>
	    <tr>
			<td width="15%">落实情况概述</td>
			<td width="80%" colspan="3">${defuseInfo.lsqkks }</td>
		</tr>
		<tr>
	    	<td width="15%">附件信息</td>
	    	<td width="80%" colspan="3">
	    		<c:if test="${not empty defuseInfo.filenames}">
    				<c:set value="${fn:split(defuseInfo.filenames,',') }" var="filenames"></c:set>
    				<c:set value="${fn:split(defuseInfo.fileids,',') }" var="fileids"></c:set>
    				<c:forEach items="${filenames}" var="filename" varStatus="num">
	    				<div><a href="<c:url value='/downUpfile.do' />?fileid=${fileids[num.index] }" class="layui-table-link" style="color: blue;">${filename }</a></div>
	    			</c:forEach>
    			</c:if>
			</td>
	    </tr>
	</table>
  </div>
	<script type="text/javascript">
	</script>
  </body>
</html>
