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
  		<legend>选择目标角色</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
		<input type="hidden"  name="menuid" value=${param.menuid }>
		<input type="hidden"  name="ids" value="${param.ids }">
		<div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label">目标角色</label>
	    		<div class="layui-input-inline">
	               <select name="roleid" id="roleid" lay-filter="roleid" lay-verify="required" lay-reqtext="目标角色不能为空"></select>
	      		</div>
	       	</div>
	 	</div>
	 	<div class="layui-form-item">
		    <div class="layui-input-block">
		      <button type="submit" class="layui-btn" lay-submit="" lay-filter="userSub">立即提交</button>
		    </div>
	  	</div>
	</form>
	<script type="text/javascript">
		function getRoleJSON(){
			$.ajax({
				type:		'POST',
				url:		'<c:url value="/getRoleJSON.do" />',
				dataType:	'json',
				async:   false,
				success:	function(data){					  
					var options = '<option value="">请选择所属角色</option>'+fillOption(data);
					$("select[name^=roleid]").html(options);
					layui.form.render();
				}
			});
		}
		layui.use(['form', 'layedit'], function(){
		  var form = layui.form,
		  layer = layui.layer,
		  layedit = layui.layedit;
		  getRoleJSON();
		  form.on('submit(userSub)', function(data){
	         $("#form1").ajaxSubmit({
	              	url:		'<c:url value="/setUserRoles.do"/>',
	              	dataType:	'json',
	              	async:  false,
	              	success:	function(data) {
	                  	var obj = eval('(' + data + ')');
	                  	if(obj.flag>0){
	                  	    //弹出loading
	 		            	var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
	                     	setTimeout(function(){         
	                     		top.layer.msg(obj.msg);
	                     		top.layer.close(index);
		 		        		//刷新父页面
				        		parent.layer.closeAll("iframe");
		 		         		parent.$("#search").click();
	                   		},2000);
	                 	}else{
	                  	 	layer.msg(obj.msg);
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
