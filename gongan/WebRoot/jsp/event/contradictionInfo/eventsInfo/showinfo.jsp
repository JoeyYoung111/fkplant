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
  <div class="showinfo">
	<table width="100%" border="1" cellspacing="0" cellpadding="0">
		<tr height="40" bgcolor="#3598DC">
    		<td colspan="4"><span class="showinfo_title">引发涉稳事件详情</span></td>
  		</tr>
		<tr>
	    	<td width="15%">事件标题</td>
	    	<td width="85%" colspan="3">${eventsInfo.etitle }</td>
	    </tr>
	    <tr>
	    	<td width="15%">风险等级</td>
	    	<td width="35%">${eventsInfo.fxdj }</td>
	    	<td width="15%">事发部位</td>
	    	<td width="35%">${eventsInfo.sfbwd }</td>
	    </tr>
	    <tr>
			<td width="15%">发生时间</td>
			<td width="35%">${eventsInfo.fssj }</td>
			<td width="15%">涉事人数</td>
			<td width="35%">${eventsInfo.ssrs }</td>
	    </tr>
	    <tr>
			<td width="15%">是否过激</td>
			<td width="35%">${eventsInfo.sfgm }</td>
			<td width="15%">行为方式</td>
			<td width="35%">${eventsInfo.xwfs }</td>
	    </tr>
	    <tr>
			<td width="15%">事件概况</td>
			<td width="80%" colspan="3">${eventsInfo.sjgk }</td>
		</tr>
	    <tr>
			<td width="15%">备注信息</td>
			<td width="80%" colspan="3">${eventsInfo.memo }</td>
	    </tr>
	    <tr>
	    	<td width="15%">附件信息</td>
	    	<td width="80%" colspan="3">
	    		<c:if test="${not empty eventsInfo.filenames}">
    				<c:set value="${fn:split(eventsInfo.filenames,',') }" var="filenames"></c:set>
    				<c:set value="${fn:split(eventsInfo.fileids,',') }" var="fileids"></c:set>
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
