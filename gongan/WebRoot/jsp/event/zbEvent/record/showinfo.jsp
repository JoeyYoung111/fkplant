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
	    		<td colspan="10"><span class="showinfo_title">民警工作记载详情</span></td>
	  		</tr>
			<tr>
				<td width="20%" colspan="2">
					<strong>工作方式</strong>
				</td>
				<td width="30%" colspan="3">
					${workRecord.worktype}
				</td>
				<td width="20%" colspan="2">
					<strong>时间</strong>
				</td>
				<td width="30%" colspan="3">
					${workRecord.worktime}
				</td>
			</tr>
			<tr>
				<td width="20%" colspan="2">
					<strong>地点</strong>
				</td>
				<td width="80%" colspan="8">
					${workRecord.workplace}
				</td>
			</tr>
			<tr>
				<td width="20%" colspan="2">
					<strong>工作记录</strong>
				</td>
				<td width="80%" colspan="8">
					${workRecord.workrecord}
				</td>
			</tr>
			<tr>
				<td width="20%" colspan="2">
					<strong>建档时间</strong>
				</td>
				<td width="30%" colspan="3">
					${workRecord.addtime}
				</td>
				<td width="20%" colspan="2">
					<strong>建档民警</strong>
				</td>
				<td width="30%" colspan="3">
					${workRecord.addoperator}
				</td>
			</tr>
			<tr>
				<td width="20%" colspan="2">
					<strong>修改时间</strong>
				</td>
				<td width="30%" colspan="3">
					${workRecord.updatetime}
				</td>
				<td width="20%" colspan="2">
					<strong>修改民警</strong>
				</td>
				<td width="30%" colspan="3">
					${workRecord.updateoperator}
				</td>
			</tr>
		</table>  
		<div style="height:150px;"></div>
    </div>
  </body>
</html>
