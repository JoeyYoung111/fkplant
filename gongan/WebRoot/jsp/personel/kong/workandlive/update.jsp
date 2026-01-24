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
	<link rel="stylesheet" href="<c:url value="/layui/lay/modules/formSelects/formSelects-v4.css"/>" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/cardnumber.js"/>"></script>
  
  <body>
   <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  		<legend>修改工作地、居住地</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
		<input type="hidden"  name="id" id="id"  value="${kongbackground.id}" ></input>
		<input type="hidden"  name="menuid" id="menuid"  value=0></input>
		<div class="layui-form-item">
		<div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>地点类型</label>
	    		<div class="layui-input-inline">
	      				<select id="checktype"  name="checktype" style="width:170px;" lay-verify="required">
					 		<option value="">--请选择审查方式--</option>
					        <option value="居住地"  <c:if test="${kongbackground.checktype eq '居住地'}"> selected</c:if>>居住地</option>
					        <option value="工作地"  <c:if test="${kongbackground.checktype eq '工作地'}"> selected</c:if>>工作地</option>
					        <option value="活动地"  <c:if test="${kongbackground.checktype eq '活动地'}"> selected</c:if>>活动地</option>
			 	</select>
	      		</div>
	      		<div class="layui-inline">
	    		<label class="layui-form-label">时间</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="checktime"  id="checktime"    autocomplete="off"  class="layui-input">
	      		</div>
	       	</div>
	       	</div>
	       	<div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>地点名称</label>
	    		<div class="layui-input-inline"  style="width:680px;">
	      			<input type="text" name="checkresume"  id="checkresume"   lay-verify="required" autocomplete="off" placeholder="请输入地点名称" class="layui-input"  lay-reqtext="请输入地点名称"   value="${kongbackground.checkresume}">
	      		</div>
	       	</div>
	     </div>
	     </div>
	     <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label">地点描述</label>
	    		<div class="layui-input-inline"  style="width:680px;">
	      			 <textarea placeholder="请输入地点描述" class="layui-textarea" name="memo"  style="width:700px;" >${kongbackground.memo}</textarea>
	      		</div>
	       	</div>
	     </div>
	   
	   
	     <br>
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
		         
		         laydate.render({
				  elem: '#checktime',
				  value: '${kongbackground.checktime}'
				});
		        
		   form.on('submit(roleSub)', function(data){
		   
             $("#form1").ajaxSubmit({
	              	url:		'<c:url value="/updateKongBackground.do"/>',
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
				        		parent.layui.layer.closeAll("iframe");
		 		        	    parent.layui.table.reload('workandliveTable', {});     
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
