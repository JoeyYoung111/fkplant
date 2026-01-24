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
    
    <title>添加页面</title>
    
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  </head>
  
  <body>
  	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  		<legend id="typeName">${basicType.basicTypeName}</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
		<input type="hidden"  name="menuid" value=${menuid }>
		<input type="hidden" name="basicType" value=${basicType.id }>
		<div class="layui-form-item">
	       	<div class="layui-inline" <c:if test="${basicType.isexternal eq 0}">style="display:none"</c:if>>
	    		<label class="layui-form-label"><font color="red" size=2>*</font>${externalname}</label>
	    		<div class="layui-input-inline">
	    			<select name="parentid" lay-verify="required" placeholder="请选择一个${externalname}">
        				<c:choose>
						    <c:when test="${basicType.isexternal eq 0}">
						        <option value="0" selected></option>
						    </c:when>
						    <c:when test="${basicType.isexternal eq 1}">
						        <option value="">请选择一个${externalname}</option>
						        <c:forEach items="${msglist}" var="row" varStatus="num">
						        	<option value="${row.id}">${row.basicName}</option>
						        </c:forEach>
						    </c:when>
						</c:choose>
      				</select>
	      		</div>
	       	</div>
	 	</div>
	 	<div class="layui-form-item">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>数据名称</label>
	    	<div class="layui-input-inline">
	      		<input type="text" name="basicName" lay-verify="required" autocomplete="off" placeholder="请输入数据名称" class="layui-input"  lay-reqtext="数据名称不能为空">
	    	</div>
	  	</div>
	  	<div class="layui-form-item layui-form-text">
		    <label class="layui-form-label">备注信息</label>
		    <div class="layui-input-block">
		      <textarea placeholder="请输入内容" class="layui-textarea" name="memo"></textarea>
		    </div>
		</div>
		<div class="layui-form-item">
		    <div class="layui-input-block">
		      <button type="submit" class="layui-btn" lay-submit="" lay-filter="msgSub">立即提交</button>
		      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
		    </div>
	  	</div>
	</form>
	<script type="text/javascript">
		$(document).ready(function(){
		});
		
		layui.use(['form', 'layedit', 'laydate'], function(){
		  var form = layui.form,
		  layer = layui.layer,
		  layedit = layui.layedit,
		  laydate = layui.laydate;
		  form.render();
		  form.on('submit(msgSub)', function(data){
	         $("#form1").ajaxSubmit({
	              	url:		'<c:url value="/addBasicMsg.do"/>',
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
		 		         		parent.searchMsg();
		 		         		parent.layer.closeAll("iframe");
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
