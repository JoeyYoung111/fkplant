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
    		<td colspan="4"><span class="showinfo_title">情报线索信息详情</span></td>
  		</tr>
		<tr>
	    	<td width="15%">线索标题</td>
	    	<td width="85%" colspan="3">${leadsInfo.ltitle }</td>
	    </tr>
	    <tr>
	    	<td width="15%">线索指向</td>
	    	<td width="35%">${leadsInfo.lpointto }</td>
	    	<td width="15%">线索来源</td>
	    	<td width="35%">${leadsInfo.lsource }</td>
	    </tr>
	    <tr>
			<td width="15%">线索内容</td>
			<td width="80%" colspan="3">${leadsInfo.lcontent }</td>
		</tr>
	    <tr>
	    	<td width="15%">预计发生时间</td>
	    	<td width="35%">${leadsInfo.ldate }</td>
	    	<td width="15%">线索处置</td>
	    	<td width="35%">${leadsInfo.xscz }</td>
	    </tr>
	    <tr>
			<td width="15%">处置情况概述</td>
			<td width="80%" colspan="3">${leadsInfo.czqkgs }</td>
		</tr>
	    <tr>
			<td width="15%">关联事件名称</td>
			<td width="80%" colspan="3"><a href='#' onclick='showConnetevent(${leadsInfo.conneteventid });return false;'>${leadsInfo.conneteventname }</a></td>
	    </tr>
	    <tr>
	    	<td width="15%">附件信息</td>
	    	<td width="80%" colspan="3">
	    		<c:if test="${not empty leadsInfo.filenames}">
    				<c:set value="${fn:split(leadsInfo.filenames,',') }" var="filenames"></c:set>
    				<c:set value="${fn:split(leadsInfo.fileids,',') }" var="fileids"></c:set>
    				<c:forEach items="${filenames}" var="filename" varStatus="num">
	    				<div><a href="<c:url value='/downUpfile.do' />?fileid=${fileids[num.index] }" class="layui-table-link" style="color: blue;">${filename }</a></div>
	    			</c:forEach>
    			</c:if>
			</td>
	    </tr>
	</table>
  </div>
	<script type="text/javascript">
		layui.use(['form'], function() {
			form = layui.form;
		});
		function showConnetevent(id){
			var index = layui.layer.open({
				title : "引发涉稳事件详情",
				type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
				content : "<c:url value='showInfoEventsInfo.do'/>?id="+id,
				area: ['800', '600px'],
				maxmin: true,
				success : function(layero, index){
					setTimeout(function(){
						layui.layer.tips('点击此处返回文章列表', '.layui-layer-setwin .layui-layer-close', {
							tips: 3
						});
					},500)
				}
			});
			layui.layer.full(index);
		}
	</script>
  </body>
</html>
