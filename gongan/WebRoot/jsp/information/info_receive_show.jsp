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
<title>转阅详情</title>
<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
<script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
<script type="text/javascript" src="<c:url value='/js/check.js'/> "></script>
<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>

<style>
.div-left{float:left;}
.div-none{float:left; position:relative; left:35%;}
.div-right{float:right}
</style>

</head>
  
<body>

<div style="margin-left: 10%;margin-right: 10%;overflow: auto;" id="printcontent">
	<div align="center">
		<font size="12" face="宋体" style="color:#FF0000;letter-spacing:2px;">信息快报</font>
	</div>

<br><br>

	<div class="div-left">
		<font style="font-size:20px">${info.departname}</font>
	</div>
	<div class="div-right">
		<font style="font-size:20px">${info.addtime}</font>
	</div>
	
	<div align="center">
		<hr style="border: 1px solid red;background-color:red;">
	</div>

	<br>

	<div align="center">
		<h1 style="letter-spacing:10px;font-size:25px">${info.infotitle}</h1>
	</div>

	<br><br>

	<div>
		<p style="text-indent:2em;font-size:30px;font-family:'楷体'">${info.infocontent}</p>
	</div>

	<br><br><br><br><br><br><br><br><br><br>

	<div align="center">
		<hr style="border: 1px solid red;background-color:red;">
	</div>
	<div class="div-left">
		<font style="font-size:20px">采集人:${info.addoperator}</font>
	</div>
	<div class="div-none">
		<font style="font-size:20px">核稿人:${info.reviewer}</font>
	</div>
	<div class="div-right">
		<font style="font-size:20px">签发人:${info.issuer}</font>
	</div>

	<br><br><br>

	<div>
		<font style="font-size:20px">【转阅签收反馈信息】</font>
	</div>
	<div>
		<table style="margin:10px auto;" border="1px;">
			<colgroup>
				<col width="120px">
				<col width="200px">
				<col width="200px">
				<col width="200px">
				<col width="200px">
				<col width="400px">
				<col width="200px">
			</colgroup>
			<thead>
				<tr>
					<th style="line-height:30px">序号</th>
					<th style="line-height:30px">转阅单位</th>
					<th style="line-height:30px">签收人</th>
					<th style="line-height:30px">签收时间</th>
					<th style="line-height:30px">反馈人</th>
					<th style="line-height:30px">反馈内容</th>
					<th style="line-height:30px">反馈时间</th>
				</tr>
			</thead>
			<tbody id="table-body">
				<c:forEach items="${infoReceiveList}" var="row" varStatus="num">
					<tr style="text-align:center">
						<td style="line-height:50px">${num.index+1}</td>
						<td style="line-height:50px">${row.receivename}</td>
						<td style="line-height:50px">${row.signoper}</td>
						<td style="line-height:50px">${row.signtime == ""?"未签收":row.signtime}</td>
						<td style="line-height:50px">${row.feedbackoper}</td>
						<td style="line-height:50px">${row.feedbackcontent}</td>
						<td style="line-height:50px">${row.feedbacktime == ""?"未反馈":row.feedbacktime}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
	<br><br>

</div>


<script type="text/javascript">

$(document).ready(function(){
	
});

</script>
    
</body>
</html>
