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
  		<legend>修改每月评估</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
		<input type="hidden"  name="personnelid" id="personnelid"  value=${kongdailycontrol.personnelid}></input>
		<input type="hidden"  name="menuid" id="menuid"  value=0></input>
		<input type="hidden"  name="controltype" id="controltype"  value=${kongdailycontrol.controltype}></input>
		<input type="hidden"  name="id" id="id"  value=${kongdailycontrol.id}></input>
		<div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>评估时间</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="controltime" id="controltime" lay-verify="required" autocomplete="off" placeholder="请选择管控时间" style="width:500px;"
	      			class="layui-input"  lay-reqtext="请选择管控时间"  value="${kongdailycontrol.controltime}">
	      		</div>
	       	</div>
	       
	  </div>
	  <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label">评估内容</label>
	    		<div class="layui-input-inline">
	      			 <textarea placeholder="请输入内容" class="layui-textarea" name="controlcontent" style="width:500px;height:200px;">${kongdailycontrol.controlcontent}</textarea>
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
				              	url:		'<c:url value="/updatekongdailycontrol.do"/>',
				                dataType:	'json',
				              	async:  	false,
				              	success:	function(data) {
									var obj = eval('(' + data + ')');
				                  	if(obj.flag>0){
				                  	    //弹出loading
				 		            	var index = top.layer.msg('主要活动情况信息提交中，请稍候',{icon: 16,time:false,shade:0.8});
				                     	setTimeout(function(){         
				                     		top.layer.msg(obj.msg);
				                     		top.layer.close(index);
					 		        		
				                     		parent.layui.layer.closeAll("iframe");
					 		        	    parent.layui.table.reload('hdjlTable', {});  
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
