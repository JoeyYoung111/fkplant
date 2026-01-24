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
    
    <title>专项标签添加/修改页面</title>
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/js/jquery.form.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  	
</head>

<body>

<form class="layui-form" method="post" id="form_zhuanxiangbutton" onsubmit="return false;">
	<input type="hidden" name="departmentid" value="${param.departmentid}"/>
	<input type="hidden" name="id" value="${param.id}"/>
	<input type="hidden" id="page" value="${param.page}"/>
	<input type="hidden" id="informationid" name="informationsendid" value="${param.informationsendid}"/>
	<input type="hidden" id="informationid" name="informationid" value="${param.informationid}"/>
	<input type="hidden" id="special" value="${param.special}"/>
	
	<br>
	<div class="layui-form-item">
		<div class="layui-inline">
			<label class="layui-form-label">标签名称</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" style="width:500px;" name="specialName" value="${param.specialName}" lay-verify="required" autocomplete="off" />
			</div>
		</div>
	</div>
	
	<div class="layui-form-item">
		<div class="layui-input-block">
			<button type="submit" class="layui-btn" lay-submit="" lay-filter="BQ">确定</button>
		</div>
	</div>

</form>

<script type="text/javascript">

var locat = (window.location+'').split("/");
$(function(){
	if('main'==locat[3]){locat = locat[0]+'//'+locat[2];}else{locat = locat[0]+'//'+locat[2]+'/'+locat[3];};
});

layui.use(['form'],function(){
	var form = layui.form;
	var layer = layui.layer;
	
	form.render();
	
	form.on('submit(BQ)',function(data){
		zhuanxiangbutton();
	});
	
});


function zhuanxiangbutton(){
	var page = $("#page").val();
	var zxurl;
	if(page=="add"){
		zxurl = '<c:url value="/addInformationSpecial.do"/>';
	}else if(page=="update"){
		zxurl = '<c:url value="/updateInformationSpecial.do"/>';
	}
	
	$("#form_zhuanxiangbutton").ajaxSubmit({
		url:		zxurl,
		dataType:	'json',
		async:		false,
		success:	function(data){
			var obj = eval('(' + data + ')');
			if(obj.flag>0){
				var index = top.layer.msg('数据提交中...',{icon: 16,time:false,shade:0.8});
				setTimeout(function(){
					top.layer.msg(obj.msg);
	                top.layer.close(index);
			        layer.closeAll("iframe");
			        parent.parent.specialid();
			        parent.parent.layui.form.render();
	 		        //刷新父页面
	 		        parent.location.reload();
				},500);
			}else{
				layer.msg(obj.msg);
			}
		},error:function(){
			alert("请求失败");
		}
	});
	
}



</script>

</body>
</html>
