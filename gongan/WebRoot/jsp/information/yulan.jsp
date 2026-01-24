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
<title>预览</title>
<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
<script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
<script type="text/javascript" src="<c:url value='/js/check.js'/> "></script>
<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>

<style>
.div-left{float:left;}
.div-none{float:left; position:relative; left:28%;}
.div-right{float:right}
</style>

</head>
  
<body>
<!--startprint-->
<div style="margin-left: 10%;margin-right: 10%;overflow: auto;" id="printcontent">
	<div align="center">
		<font size="12" face="宋体" style="color:#FF0000;letter-spacing:2px;">信息快报</font>
	</div>
	
	<br><br>
	
	<div class="div-left">
		<font style="font-size:20px">${informationSend.departname}编</font>
	</div>
	<div class="div-right">
		<font style="font-size:20px">${informationSend.addtime}(报送时间)</font>
	</div>
	
	<div align="center">
		<hr style="border: 1px solid red;background-color:red;">
	</div>
    
    <br>
    
    <div align="center">
		<h1 style="letter-spacing:10px;font-size:25px">标题${informationSend.infotitle}</h1>
	</div>
	
	<br><br>
	
	<div>
		<p style="text-indent:2em;font-size:35px;font-family:'楷体'">${informationSend.infocontent}</p>
	</div>
	
	<br><br><br><br><br><br><br><br><br><br>
	
	<div align="center">
		<hr style="border: 1px solid red;background-color:red;">
	</div>
	<div class="div-left">
		<font style="font-size:20px">采集人:${informationSend.addoperator}</font>
	</div>
	<div class="div-none">
		<font style="font-size:20px">核稿人:${informationSend.reviewer}</font>
	</div>
	<div class="div-right">
		<font style="font-size:20px">签发人:${informationSend.issuer}</font>
	</div>
	
	<br><br><br><br>
</div>
<!--endprint-->

<div style="margin-top: 7%;text-align: center;">
	<button type="button" class="layui-btn" onclick="confirm();">导出</button>
	<button type="button" class="layui-btn" onclick="cancel();">返回</button>
</div>

<script type="text/javascript">

function confirm(){
	//获取整个打印前页面，作用是打印后恢复。
	bdhtml = window.document.body.innerHTML;
	sprnstr = "<!--startprint-->"; //标记打印区域开始
	eprnstr = "<!--endprint-->";//标记打印区域结束
	//获取要打印的区域, 从标记开始处向下获取。
	prnhtml = bdhtml.substr(bdhtml.indexOf(sprnstr) + 17);//17表示光标右移17个单位
	//删除结束标记后面的内容。
	prnhtml = prnhtml.substring(0, prnhtml.indexOf(eprnstr));
	//将页面显示要打印的内容。
	window.document.body.innerHTML = prnhtml;
	//打印整个页面
	window.print(prnhtml);
	//恢复打印前的页面
	window.document.body.innerHTML = bdhtml;
	parent.layer.closeAll("iframe");
}

function cancel(){
	parent.layer.closeAll("iframe");
}

$(document).ready(function(){
	
});

</script>
    
</body>
</html>
