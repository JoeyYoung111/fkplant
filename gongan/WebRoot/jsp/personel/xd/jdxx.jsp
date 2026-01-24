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
     <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
	<link rel="stylesheet" href="<c:url value="/css/system.css"/>" type="text/css"/>
	<link rel="stylesheet" href="<c:url value="/css/public.css"/>"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
   	<body style="background-color:#FFFFFF;">
  	<div class="showinfo">
  		<table width="100%" border="1" cellspacing="0" cellpadding="0">
	  		<tr height="40" bgcolor="#3598DC">
	    		<td colspan="10"><span class="showinfo_title">涉警信息详情</span></td>
	  		</tr>
			<tr>
				<td width="20%" colspan="2">
					<strong>接警时间</strong>
				</td>
				<td width="30%" colspan="3" id="jjrqsj">
				</td>
				<td width="20%" colspan="2">
					<strong>报警类型</strong>
				</td>
				<td width="30%" colspan="3" id="bjlx">
				</td>
			</tr>
			<tr>
				<td width="20%" colspan="2">
					<strong>报警内容</strong>
				</td>
				<td width="80%" colspan="8" id="bjnr">
				</td>
			</tr>
			<tr>
				<td width="20%" colspan="2">
					<strong>事发地点</strong>
				</td>
				<td width="80%" colspan="8" id="sfdd">
				</td>
			</tr>
			<tr>
				<td width="20%" colspan="2">
					<strong>处理结果内容</strong>
				</td>
				<td width="80%" colspan="8" id="cljgnr">
				</td>
			</tr>
			<tr>
				<td width="20%" colspan="2">
					<strong>处警单位名称</strong>
				</td>
				<td width="80%" colspan="8" id="cjdwmc">
				</td>
			</tr>
		</table>  
		<div style="height:150px;"></div>
    </div>
    <script>
    	$(document).ready(function(){
			$("#jjrqsj").text(parent.jqjson.jjrqsj);
			$("#bjnr").text(parent.jqjson.bjnr);
			$("#bjlx").text(parent.jqjson.bjlx);
			$("#sfdd").text(parent.jqjson.sfdd);
			$("#cljgnr").text(parent.jqjson.cljgnr);
			$("#cjdwmc").text(parent.jqjson.cjdwmc);
		});
    </script>
  </body>
</html>
