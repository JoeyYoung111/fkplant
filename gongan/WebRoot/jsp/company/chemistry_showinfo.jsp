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
    
    <title>从业人员详情</title>
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
	<link rel="stylesheet" href="<c:url value="/css/system.css"/>" type="text/css"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/js/jquery.form.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	
</head>

<body style="background-color:#FFFFFF;">
<div class="showinfo">
	<table width="100%" border="1" cellspacing="0" cellpadding="0">
		<tr height="40" bgcolor="#3598DC">
		  	<td colspan="4"><span class="showinfo_title">从业人员详情</span></td>
		</tr>

		<tr>
			<td width="25%">
				<strong>姓名：</strong>
			</td>
			<td width="25%">
				${chemistry.personname }
			</td>
			<td width="25%">
				<strong>性别：</strong>
			</td>
			<td width="25%">
				${chemistry.sexes }
			</td>
		</tr>
		
		<tr>
			<td width="25%">
				<strong>身份证号码：</strong>
			</td>
			<td width="25%">
				${chemistry.cardnumber }
			</td>
			<td width="25%">
				<strong>文化程度：</strong>
			</td>
			<td width="25%">
				${chemistry.education }
			</td>
		</tr>

		<tr>
			<td width="25%">
				<strong>联系电话：</strong>
			</td>
			<td width="25%">
				${chemistry.telephone }
			</td>
			<td width="25%">
				<strong>岗位：</strong>
			</td>
			<td width="25%">
				${chemistry.station }
			</td>
		</tr>
		
		<tr>
			<td width="25%">
				<strong>民族：</strong>
			</td>
			<td width="25%">
				${chemistry.nation }
			</td>
			<td width="25%">
				<strong>政治面貌：</strong>
			</td>
			<td width="25%">
				${chemistry.politicalposition }
			</td>
		</tr>

		<tr>
			<td width="25%">
				<strong>毕业院校：</strong>
			</td>
			<td width="25%">
				${chemistry.school }
			</td>
			<td width="25%">
				<strong>专业：</strong>
			</td>
			<td width="25%">
				${chemistry.major }
			</td>
		</tr>
		
		<tr>
			<td width="25%">
				<strong>微信号：</strong>
			</td>
			<td width="25%">
				${chemistry.wechat }
			</td>
			<td width="25%">
				<strong>QQ：</strong>
			</td>
			<td width="25%">
				${chemistry.qq }
			</td>
		</tr>
		
		<tr>
			<td width="25%">
				<strong>户籍地详址：</strong>
			</td>
			<td colspan="3" width="75%">
				${chemistry.homeplace }
			</td>
		</tr>
		<tr>
			<td width="25%">
				<strong>现住地详址：</strong>
			</td>
			<td colspan="3" width="75%">
				${chemistry.lifeplace }
			</td>
		</tr>
		<tr>
			<td width="25%">
				<strong>备注信息：</strong>
			</td>
			<td colspan="3" width="75%">
				${chemistry.memo }
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
