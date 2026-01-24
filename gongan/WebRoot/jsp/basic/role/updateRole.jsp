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
  		<legend>修改角色</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
		<input type="hidden"  name="id" value=${role.id }>
		<input type="hidden"  name="menuid" value=${menuid }>
		<div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>角色名称</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="rolename" value="${role.rolename}" lay-verify="required" autocomplete="off" placeholder="请输入角色名称" class="layui-input"  lay-reqtext="请输入角色名称">
	      		</div>
	       	</div>
	       	<div class="layui-inline">
	       	</div>
	 	</div>
	 	<div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>人员数据过滤</label>
	    		<div class="layui-input-inline">
	      			<input type="radio" name="msgFilter" value="0" title="否" <c:if test="${role.msgFilter eq 0}">checked=""</c:if> lay-filter="msgFilter" />
      		       <input type="radio" name="msgFilter" value="1" title="是" <c:if test="${role.msgFilter eq 1}">checked=""</c:if> lay-filter="msgFilter" />
	      		</div>
	       	</div>
	     </div>
	     <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>过滤字段</label>
	    		<div class="layui-input-inline">
	      			<select id="fieldFilter" name="fieldFilter">
			 		<option value='0' <c:if test="${role.fieldFilter eq 0}">selected</c:if>>全部</option>
			 		<option value='1' <c:if test="${role.fieldFilter eq 1}">selected</c:if>>管辖派出所</option>
			 		<option value='2' <c:if test="${role.fieldFilter eq 2}">selected</c:if>>管辖民警</option>
			 		<option value='3' <c:if test="${role.fieldFilter eq 3}">selected</c:if>>责任警种</option>
			 		<option value='4' <c:if test="${role.fieldFilter eq 4}">selected</c:if>>中队</option>
			 	</select>
	      		</div>
	       	</div>
	     </div>
	    <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>事件数据过滤</label>
	    		<div class="layui-input-inline">
	      			<input type="radio" name="eventFilter" value="0" title="否" <c:if test="${role.eventFilter eq 0}">checked=""</c:if> lay-filter="eventFilter" />
      		       <input type="radio" name="eventFilter" value="1" title="是" <c:if test="${role.eventFilter eq 1}">checked=""</c:if> lay-filter="eventFilter" />
	      		</div>
	       	</div>
	     </div>
		<div class="layui-form-item">
		    <div class="layui-input-block">
		      <button type="submit" class="layui-btn" lay-submit="" lay-filter="roleSub">立即提交</button>
		      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
		    </div>
	  	</div>
	</form>
	<script type="text/javascript">
		layui.use(['form', 'layedit'], function(){
		  var form = layui.form,
		  layer = layui.layer,
		  layedit = layui.layedit;
		  form.on('submit(roleSub)', function(data){
	         $("#form1").ajaxSubmit({
	              	url:		'<c:url value="/updateRole.do"/>',
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
				        		layer.closeAll("iframe");
		 		        		//刷新父页面
		 		         		parent.location.reload();
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
