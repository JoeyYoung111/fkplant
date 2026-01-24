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
    
    <title>反馈内容</title>
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/js/jquery.form.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  	
</head>
<body>

<form class="layui-form" method="post" id="form_fankui" onsubmit="return false;">
<input type="hidden" id="id" name="id" value="${param.id}"/>
<input type="hidden" id="menuid" name="menuid" value="${param.menuid}"/>
<input type="hidden" id="page" name="page" value="${param.page}"/>

<div class="layui-form-item">
	<div class="layui-inline">
		<label class="layui-form-label">反馈内容</label>
		<div class="layui-input-inline">
			<textarea id="feedbackcontent" name="feedbackcontent" class="layui-textarea" style="width:600px;" lay-verify="required" autocomplete="off"></textarea>
		</div>
	</div>
</div>

<div class="layui-form-item">
	<div class="layui-input-block">
		<button type="submit" class="layui-btn" lay-submit="" lay-filter="fankui">确定</button>
	</div>
</div>

</form>

<script type="text/javascript">

layui.use(['form'],function(){
	var form = layui.form;
	var layer = layui.layer;
	
	form.render();
	
	form.on('submit(fankui)',function(data){
		$("#form_fankui").ajaxSubmit({
			url:		'<c:url value="/updateAssignSignfor.do"/>',
			dataType:	'json',
			async:		false,
			success:	function(data){
				var obj = eval('('+data+')');
				if(obj.flag>0){
					top.layer.msg(obj.msg);
					layer.closeAll("iframe");
					parent.layer.closeAll("iframe");
					parent.$("#searchAssignSignfor").click();
				}else{
					layer.msg(obj.msg);
				}
			},error:function(){
				alert("请求失败");
			}
		});
		return false;
	});
});


</script>

</body>
</html>
