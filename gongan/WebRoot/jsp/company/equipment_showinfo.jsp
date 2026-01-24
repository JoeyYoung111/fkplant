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
    
    <title>设备详情页面</title>
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
		  	<td colspan="4"><span class="showinfo_title">设备基本信息详情</span></td>
		</tr>
		
		<tr>
			<td width="25%">
				<strong>企业名称：</strong>
			</td>
			<td colspan="3" width="75%">
				${companyname }
			</td>
		</tr>
		
		<tr>
			<td width="25%">
				<strong>设备名称：</strong>
			</td>
			<td width="25%">
				${equipment.emsg }
			</td>
			<td width="25%">
				<strong>设备用途：</strong>
			</td>
			<td width="25%">
				${equipment.purpose }
			</td>
		</tr>
		
		<tr>
			<td width="25%">
				<strong>制造厂商：</strong>
			</td>
			<td width="25%">
				${equipment.makecompany }
			</td>
			<td width="25%">
				<strong>品牌：</strong>
			</td>
			<td width="25%">
				${equipment.equipmentbrand }
			</td>
		</tr>

		<tr>
			<td width="25%">
				<strong>型号：</strong>
			</td>
			<td width="25%">
				${equipment.equipmenttype }
			</td>
			<td width="25%">
				<strong>功率：</strong>
			</td>
			<td width="25%">
				${equipment.equipmentpower }
			</td>
		</tr>
		
		<tr>
			<td width="25%">
				<strong>购买日期：</strong>
			</td>
			<td width="25%">
				${equipment.buydate }
			</td>
			<td width="25%">
				<strong>使用年限：</strong>
			</td>
			<td width="25%">
				${equipment.useyear }
			</td>
		</tr>
		
		<tr>
			<td width="25%">
				<strong>使用情况：</strong>
			</td>
			<td width="25%">
				${equipment.usestatus }
			</td>
			<td width="25%">
				<strong>使用状态：</strong>
			</td>
			<td width="25%">
				${equipment.usestate }
			</td>
		</tr>
		
		<tr>
			<td width="25%">
				<strong>出租企业：</strong>
			</td>
			<td width="25%">
				${equipment.leasecompany }
			</td>
			<td width="25%">
				<strong>承租企业：</strong>
			</td>
			<td width="25%">
				${equipment.lesseecompany }
			</td>
		</tr>
	
		<tr>
			<td width="25%">
				<strong>出售企业：</strong>
			</td>
			<td width="25%">
				${equipment.sellcompany }
			</td>
			<td width="25%">
				<strong>购买企业：</strong>
			</td>
			<td width="25%">
				${equipment.buycompany }
			</td>
		</tr>
	
		<tr>
			<td width="25%">
				<strong>备注信息：</strong>
			</td>
			<td colspan="3" width="75%">
				${equipment.memo }
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
