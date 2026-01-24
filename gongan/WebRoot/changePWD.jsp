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
    
    <title></title>
    
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  </head>
  
  <body>
  	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  		<legend>重置密码</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
		<div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label">原始密码</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="old_userpassword" id="old_userpassword" lay-verify="required" autocomplete="off" placeholder="请输入原始密码" class="layui-input"  lay-reqtext="请输入原始密码">
	      		</div>
	       	</div>
	 	</div>
		<div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label">输入新密码</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="userpassword" id="userpassword" lay-verify="required|userpassword" autocomplete="off" placeholder="输入新密码" class="layui-input"  lay-reqtext="输入新密码">
	      		</div>
	       	</div>
	 	</div>
		<div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label">确认新密码</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="userpassword2" id="userpassword2" lay-verify="required|userpassword2" autocomplete="off" placeholder="请输入确认新密码" class="layui-input"  lay-reqtext="请输入确认新密码">
	      		</div>
	       	</div>
	 	</div>
		<div class="layui-form-item">
		    <div class="layui-input-block">
		      <button type="submit" class="layui-btn" lay-submit="" lay-filter="userSub">提交</button>
		      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
		    </div>
	  	</div>
	</form>
	<script type="text/javascript">
		layui.use(['form', 'layedit'], function(){
		  var form = layui.form,
		  layer = layui.layer,
		  layedit = layui.layedit;
		  form.verify({
		  	userpassword:function(value){
		  		if(value==$('#old_userpassword').val())return "新密码不能和原始密码相同";
		  	},
		  	userpassword2:function(value){
		  		if(value!=$('#userpassword').val())return "两次密码不一致";
		  	}
		  });
		  form.on('submit(userSub)', function(data){
	         $("#form1").ajaxSubmit({
	              	url:		'<c:url value="/changeUserPWD.do"/>',
	              	dataType:	'json',
	              	async:  false,
	              	success:	function(data) {
	                  	if(data.msg.flag>0){
	                  	    //弹出loading
	 		            	var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
	                     	setTimeout(function(){         
	                     		top.layer.msg(data.msg.msg);
	                     		top.layer.close(index);
				        		parent.layer.closeAll("iframe");
		 		        		parent.location.href = "<c:url value='/login.jsp'/> ";
	                   		},2000);
	                 	}else{
	                  	 	layer.msg(data.msg.msg);
	                	}
	             	},
	              	error:function() {
	                  	layer.alert("请求失败！");
	              	}
	          	});
	           	return false;
			 });
		});
	</script>
  </body>
</html>
