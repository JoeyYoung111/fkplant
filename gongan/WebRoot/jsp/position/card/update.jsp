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
     <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
	 <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  
  
  <body>
   <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  		<legend>修改政保阵地登记证书</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
		<input type="hidden"  name="id" id="id"  value=${positionCard.id}></input>
		<input type="hidden"  name="positionid" id="positionid"  value=${positionCard.positionid}></input>
		<input type="hidden"  name="menuid" id="menuid"  value=${menuid}></input>
		<div class="layui-form-item">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>登记证书名称</label>
	    	<div class="layui-input-inline">
	      		<input type="text" name="cardname" value="${positionCard.cardname}" lay-verify="required" autocomplete="off" placeholder="请输入名称" class="layui-input"  lay-reqtext="名称不能为空">
	    	</div>
	    	<label class="layui-form-label">编号</label>
	    	<div class="layui-input-inline">
	      		<input type="text" name="cardno" value="${positionCard.cardno}" autocomplete="off" class="layui-input" >
	    	</div>
	  	</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label">有效期</label>
	    	<div class="layui-input-inline">
	      		<input type="text" name="validdate" value="${positionCard.validdate}" autocomplete="off" class="layui-input">
	    	</div>
	    	<label class="layui-form-label">发证单位</label>
	    	<div class="layui-input-inline">
	      		<input type="text" name="cardunit" value="${positionCard.cardunit}" autocomplete="off" class="layui-input">
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
		$(document).ready(function(){
       	});
		
		layui.use(['form', 'laydate'], function(){
		         var form = layui.form,
		         layer = layui.layer,
		         laydate = layui.laydate;
		   
		  form.render();
		   form.on('submit(roleSub)', function(data){
		   
             $("#form1").ajaxSubmit({
	              	url:		'<c:url value="/updatePositionCard.do"/>',
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
		 		         		parent.$("#cardbutton").click();
		 		         		parent.layer.closeAll("iframe");
	                   		},2000);
	                 	}else{
	                  	 	top.layer.msg(obj.msg);
	                	}
	             	},
	              	error:function() {
	                  	top.layer.alert("请求失败！");
	              	}
	          	});
	           	return false;
			 });
		});
	</script>
  </body>
</html>
