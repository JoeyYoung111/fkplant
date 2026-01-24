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
    
    <title>运输车辆信息详情页面</title>
    <link rel="stylesheet" href="<c:url value="/css/viewer.css"/>"/>
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
	<link rel="stylesheet" href="<c:url value="/css/system.css"/>" type="text/css"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/js/jquery.form.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/viewer.js"/>"></script>
  	
</head>

<body style="background-color:#FFFFFF;">
<div class="showinfo">
	<table width="100%" border="1" cellspacing="0" cellpadding="0">
		<tr height="40" bgcolor="#3598DC">
		  	<td colspan="4"><span class="showinfo_title">${vehicle.cnameSearch}  运输车辆信息详情</span></td>
		</tr>

		<tr>
			<td width="25%">
				<strong>牌照：</strong>
			</td>
			<td width="25%">
				${vehicle.vehicleno }
			</td>
			<td width="25%">
				<strong>车辆大类：</strong>
			</td>
			<td width="25%">
				${vehicle.vehiclecategoryMsg }
			</td>
		</tr>
		
		<tr>
			<td width="25%">
				<strong>车辆颜色：</strong>
			</td>
			<td width="25%">
				${vehicle.vehiclecolor }
			</td>
			<td width="25%">
				<strong>车辆类型：</strong>
			</td>
			<td width="25%">
				${vehicle.vehicletype }
			</td>
		</tr>
		
		<tr>
			<td width="25%">
				<strong>使用性质：</strong>
			</td>
			<td width="25%">
				${vehicle.useNature }
			</td>
			<td width="25%">
				<strong>道路运输编号：</strong>
			</td>
			<td width="25%">
				${vehicle.transportNo }
			</td>
		</tr>

		<tr>
			<td width="25%">
				<strong>许可范围：</strong>
			</td>
			<td width="25%">
				${vehicle.allowrange }
			</td>
			<td width="25%">
				<strong>涉及品种：</strong>
			</td>
			<td width="25%">
				${vehicle.relatedtypeMsg }
			</td>
		</tr>
		
		<tr>
			<td width="25%">
				<strong>许可范围：</strong>
			</td>
			<td colspan="3" width="75%">
				${vehicle.allowrange }
			</td>
		</tr>
		
		<tr>
			<td width="25%">
				<strong>附件：</strong>
			</td>
			<td colspan="3" width="75%">
				<div class="layui-input-block" style="width:80%">
			    	<div class="layui-upload-list" style="margin-top:10px;">
				    	<blockquote>
							<div class="layui-upload-list" id="vehicle_att_list" style="overflow:hodden"></div>
						</blockquote>
				    </div>
			    </div>
			</td>
		</tr>
		<tr>
			<td width="25%">
				<strong>备注信息：</strong>
			</td>
			<td colspan="3" width="75%">
				${vehicle.memo }
			</td>
		</tr>
	</table>
<script type="text/javascript">

function showPic(){
	var fileMap = "${fileName }".split(",");
	var pictureurl = "${pictureurl}"+"/";
	pictureurl = pictureurl.substring(pictureurl.indexOf("upload")-1);
	if("${vehicle.attachments }" != ""){
		for(var i in fileMap){
			$('#vehicle_att_list').append('<image class="layui-upload-img" style="height:100px;width:100px;" src="'+pictureurl+fileMap[i]+'" /><span>&nbsp;&nbsp;</span>');
		}
	}else{
		$("#vehicle_att_list").text("无图片");
	}
}

$(document).ready(function(){
	showPic();
	var viewer = new Viewer(document.getElementById("vehicle_att_list"),{
		url:	'data-original',
		navbar:	false
	});
});

</script>

</body>
</html>
