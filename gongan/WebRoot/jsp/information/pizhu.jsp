<%@ page contentType='text/html;charset=UTF-8' language='java'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ page import="com.aladdin.model.UserSession"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>批注页面</title>
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/js/jquery.form.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  	
</head>
<%
UserSession userSession = (UserSession) session.getAttribute("userSession");
%> 
<body class="childrenBody layui-fluid">
<div class="layui-tab my-tab layui-tab-brief" lay-filter="pizhudemo">
	<ul class="layui-tab-title my-tab-title">
		<li class="layui-this">工作批注</li>
		<li>源头批注</li>
	</ul>

	<div class="layui-tab-content" style="height: 100px;">
	
		<div class="layui-tab-item layui-show">
			<form class="layui-form" method="post" id="form_gzpz" onsubmit="return false;">
				<input type="hidden" name="sendid" value="${id}"/>
				<input type="hidden" name="informationid" value="${informationid}"/>
				<input type="hidden" name="annotationtype" value="2"/>
				<input type="hidden" name="receiveid" value="<%=userSession.getLoginUserDepartmentid()%>"/>
			
				<div class="layui-form-item">
					<div class="layui-input-inline">
						<textarea id="content" name="content" class="layui-textarea" style="width:760px;" lay-verify="required" autocomplete="off"></textarea>
					</div>
				</div>
				<div class="layui-form-item">
				    <div class="layui-col-md4 layui-col-md-offset4" style="margin-bottom: 20px;">
				    	<button type="submit" class="layui-btn" lay-submit="" lay-filter="gzpz"><i class="layui-icon">&#xe67d;</i>确 定</button>
				    </div>
				</div>
			</form>
		</div>
		
		<div class="layui-tab-item">
			<form class="layui-form" method="post" id="form_ytpz" onsubmit="return false;">
				<input type="hidden" name="sendid" value="${id}"/>
				<input type="hidden" name="informationid" value="${informationid}"/>
				<input type="hidden" name="annotationtype" value="1"/>
				<input type="hidden" name="receiveid" value="${receiveid}"/>
			
				<div class="layui-form-item">
					<div class="layui-inline">
						<div class="layui-input-inline">
							<textarea id="content" name="content" class="layui-textarea" style="width:760px;" lay-verify="required" autocomplete="off"></textarea>
						</div>
					</div>
				</div>
				<div class="layui-form-item">
				    <div class="layui-col-md4 layui-col-md-offset4" style="margin-bottom: 20px;">
				    	<button type="submit" class="layui-btn" lay-submit="" lay-filter="ytpz"><i class="layui-icon">&#xe67d;</i>确 定</button>
				    </div>
				</div>
			</form>
		</div>
		
	</div>

</div>

<script type="text/javascript">

layui.use(['form','element'],function(){
	var form = layui.form;
	var element = layui.element;
	
	form.render();
	
	form.on('submit(gzpz)',function(data){
		$("#form_gzpz").ajaxSubmit({
			url:		'<c:url value="/addInfoAnnotation.do"/>',
			dataType:	'json',
			async:		false,
			success:	function(data){
				var obj = eval('(' + data + ')');
	          	if(obj.flag>0){
	          	   //弹出loading
		            var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
	                setTimeout(function(){         
		                top.layer.msg(obj.msg);
		                top.layer.close(index);
				        layer.closeAll("iframe");
				        parent.layer.closeAll("iframe");
				        parent.$("#searchInformation").click();
	               },500);
	          	}else{
	          		layer.msg(obj.msg);
	          	}
			},
			error:		function(){
				layer.alert("请求失败");
			}
		});
	});
	
	form.on('submit(ytpz)',function(data){
		$("#form_ytpz").ajaxSubmit({
			url:		'<c:url value="/addInfoAnnotation.do"/>',
			dataType:	'json',
			async:		false,
			success:	function(data){
				var obj = eval('(' + data + ')');
	          	if(obj.flag>0){
	          	   //弹出loading
		            var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
	                setTimeout(function(){         
		                top.layer.msg(obj.msg);
		                top.layer.close(index);
				        layer.closeAll("iframe");
				        parent.layer.closeAll("iframe");
				        parent.$("#searchInformation").click();
	               },500);
	          	}else{
	          		layer.msg(obj.msg);
	          	}
			},
			error:		function(){
				layer.alert("请求失败");
			}
		});
	});
	
});

</script>

</body>
</html>
