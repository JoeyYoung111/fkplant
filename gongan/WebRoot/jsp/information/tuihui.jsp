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
    
    <title>退回原因</title>
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/js/jquery.form.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  	
</head>
<body>
<form class="layui-form" method="post" id="form_tuihui" onsubmit="return false;">
<input type="hidden" id="informationid" name="informationid" value="${param.informationid}"/>
<input type="hidden" id="id" name="id" value="${param.id}"/>
<input type="hidden" id="validflag" name="validflag" value="2"/>
<input type="hidden" name="signoperid" value="0"/>
<input type="hidden" name="feedbackoperid" value="0"/>
<div class="layui-form-item">
	<div class="layui-inline">
		<label class="layui-form-label">退回原因</label>
		<div class="layui-input-inline">
			<textarea id="tuihuireason" name="tuihuireason" class="layui-textarea" style="width:600px;" lay-verify="required" autocomplete="off"></textarea>
		</div>
	</div>
</div>

<div class="layui-form-item">
	<div class="layui-input-block">
		<button type="submit" class="layui-btn" lay-submit="" lay-filter="tuihui">确定</button>
	</div>
</div>

</form>

<script type="text/javascript">

layui.use(['form'],function(){
	var form = layui.form;
	var layer = layui.layer;
	
	form.render();
	
	form.on('submit(tuihui)',function(data){
		tuihuiTrue();
		var index1 = top.layer.msg('数据提交中...',{icon:16,time:false,shade:0.8});
		setTimeout(function(){
	   		top.layer.close(index1);
	   	},800);
	  	return false;
	});
});

function tuihuiTrue(){
	$("#form_tuihui").ajaxSubmit({
		url:		'<c:url value="/updateinfosendflag.do"/>?page=tuihui',
		dataType:	'json',
		async:		false,
		success:	function(data){
			var obj = eval('(' + data + ')');
			if(obj.flag>0){
				var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
				setTimeout(function(){
					top.layer.msg(obj.msg);
					top.layer.close(index);
					layer.closeAll("iframe");
					parent.layer.closeAll("iframe");
					//刷新父页面
					//parent.location.reload();
					parent.$("#searchInformation").click();
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
