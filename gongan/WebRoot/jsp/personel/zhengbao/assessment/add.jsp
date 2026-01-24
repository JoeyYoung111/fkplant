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
  		<legend>新增主要活动情况</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
		<input type="hidden"  name="personnelid" id="personnelid"  value=${param.personnelid}></input>
		<input type="hidden"  name="menuid" id="menuid"  value=0></input>
		<input type="hidden"  name="controltype" id="controltype"  value=${param.controltype}></input>
		<div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>活动时间</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="controltime" id="controltime" lay-verify="required" autocomplete="off" style="width:500px;"
	      			placeholder="请选择管活动时间" class="layui-input"  lay-reqtext="请选择活动时间"  >
	      		</div>
	       	</div>
	  </div>
	  <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label">活动简况</label>
	    		<div class="layui-input-inline">
	      			 <textarea placeholder="请输入活动简况" class="layui-textarea" name="controlcontent" style="width:500px;height:200px;"></textarea>
	      		</div>
	       	</div>
	     </div> 
	    
	     <br><br>   
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
		layui.use(['form', 'laydate','upload'], function(){
		         var form = layui.form,
		         layer = layui.layer,
		         upload = layui.upload,
		         laydate = layui.laydate;
		         laydate.render({
					    elem: '#controltime'//指定元素
				 });  	
          
		   form.on('submit(roleSub)', function(data){
		    $("#form1").ajaxSubmit({
	              	url:		'<c:url value="/addkongdailycontrol.do"/>',
	              	dataType:	'json',
	              	async:  false,
	              	success:	function(data) {
	                  	var obj = eval('(' + data + ')');
	                  	if(obj.flag>0){
			                  	top.layer.msg(obj.msg);
	                     		parent.layui.layer.closeAll("iframe");
		 		        	    parent.layui.table.reload('hdjlTable', {});  
	                  	}else{
	                  	 	layer.msg(obj.msg);
	                	}
	             	},
	              	error:function() {
	                  	layer.alert("请求失败！");
	              	}
	          	});
		});
});		
	</script>
  </body>
</html>
