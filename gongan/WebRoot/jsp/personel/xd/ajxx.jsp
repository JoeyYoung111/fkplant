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
	    		<td colspan="10"><span class="showinfo_title">涉案信息详情</span></td>
	  		</tr>
			<tr>
				<td width="20%" colspan="2">
					<strong>案件编号</strong>
				</td>
				<td width="30%" colspan="3" id="jjbh">
				</td>
				<td width="20%" colspan="2">
					<strong>受理时间</strong>
				</td>
				<td width="30%" colspan="3" id="slsj">
				</td>
			</tr>
			<tr>
				<td width="20%" colspan="2">
					<strong>案件类别</strong>
				</td>
				<td width="30%" colspan="3" id="ajlb">
				</td>
				<td width="20%" colspan="2">
					<strong>案件名称</strong>
				</td>
				<td width="30%" colspan="3" id="ajmc">
				</td>
			</tr>
			<tr>
				<td width="20%" colspan="2">
					<strong>受理单位</strong>
				</td>
				<td width="80%" colspan="8" id="sldwmc">
				</td>
			</tr>
			<tr>
				<td width="20%" colspan="2">
					<strong>简要案情</strong>
				</td>
				<td width="80%" colspan="8" id="jyaq">
				</td>
			</tr>
		</table>  
		<div style="height:150px;"></div>
    </div>
    <script>
    	$(document).ready(function(){
			$("#jjbh").text(parent.ajjson.jjbh);
			$("#slsj").text(parent.ajjson.slsj);
			$("#ajlb").text(parent.ajjson.ajlb);
			$("#ajmc").text(parent.ajjson.ajmc);
			$("#sldwmc").text(parent.ajjson.sldwmc);
			$("#jyaq").text(parent.ajjson.jyaq);
		});
    </script>
  </body>
</html>
