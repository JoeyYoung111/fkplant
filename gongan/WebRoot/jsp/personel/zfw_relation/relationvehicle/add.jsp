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
  		<legend>新增交通工具</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
		<input type="hidden"  name="personnelid" id="personnelid"  value=${param.personnelid}></input>
		<input type="hidden"  name="menuid" id="menuid"  value=0></input>
		<div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label">获取来源</label>
	    		<div class="layui-input-inline">
	      			<select id="gainorigin"  name="gainorigin"   style="width:170px;" lay-verify="required" lay-verType="tips"></select>
	      		</div>
	       	</div>
	  </div> 
		<div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>车辆类别</label>
	    		<div class="layui-input-inline">
	      			<select id="vehicletype"  name="vehicletype"   style="width:170px;" lay-verify="required" lay-verType="tips"></select>
	      		</div>
	       	</div>
	  </div>
	 <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label">车辆来源</label>
	    		<div class="layui-input-inline">
	      			<select id="vehicleorigin"  name="vehicleorigin"   style="width:170px;"></select>
	      		</div>
	       	</div>
	     </div>
	   <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label">车辆号牌</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="vehiclenum"  id="vehiclenum"  autocomplete="off" placeholder="请输入车辆号牌" class="layui-input" >
	      		</div>
	       	</div>
	     </div>
	     <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label">品牌型号</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="vehiclebrand"  id="vehiclebrand"  autocomplete="off" placeholder="请输入品牌型号" class="layui-input" >
	      		</div>
	       	</div>
	     </div>
	   <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label">车辆颜色</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="vehiclecolor"  id="vehiclecolor"  autocomplete="off" placeholder="请输入车辆颜色" class="layui-input" >
	      		</div>
	       	</div>
	     </div> 
	
	   <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label">是否停用</label>
	    		<div class="layui-input-inline">
	      			<select id="isactivate"  name="isactivate" style="width:170px;" lay-verify="required" lay-verType="tips">
	      			<option   value="0">否</option>
	      			<option   value="1">是</option>
	      			</select>
	      		</div>
	       	</div>
	     </div> 
	   <div class="layui-form-item">
	       	<div class="layui-inline">
			    <label class="layui-form-label">备注信息</label>
			    <div class="layui-input-inline"  style="width:250px;">
			      <textarea placeholder="请输入内容" class="layui-textarea" name="memo"></textarea>
			    </div>
		    </div>
		</div>
		<div class="layui-form-item">
		    <div class="layui-input-block">
		      <button type="submit" class="layui-btn" lay-submit="" lay-filter="roleSub">立即提交</button>
		      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
		    </div>
	  	</div>
	  	<div style="height:150px;"></div>
	</form>
	<script type="text/javascript">
	$(document).ready(function(){
	  $.ajax({
				type:		'POST',
				 url:		'<c:url value="/getBMByTypeToJSON1.do" />?basicType='+63, 
				 dataType:	'json',
				 async :      false,
				 success:	function(data){					  
				      var options = '<option value="">--请选择---</option>' + fillOption(data);
				      $("select[name^=gainorigin]").html(options);
				   }
			});
	    $.ajax({
				type:		'POST',
				 url:		'<c:url value="/getBMByTypeToJSON1.do" />?basicType='+64, 
				 dataType:	'json',
				 async :      false,
				 success:	function(data){					  
				      var options = '<option value="">--请选择---</option>' + fillOption(data);
				      $("select[name^=vehicletype]").html(options);
				   }
			});
	   $.ajax({
				type:		'POST',
				 url:		'<c:url value="/getBMByTypeToJSON1.do" />?basicType='+65, 
				 dataType:	'json',
				 async :      false,
				 success:	function(data){					  
				      var options = '<option value="">--请选择---</option>' + fillOption(data);
				      $("select[name^=vehicleorigin]").html(options);
				   }
			});
       });
		layui.use(['form', 'laydate'], function(){
		         var form = layui.form,
		         layer = layui.layer,
		         laydate = layui.laydate;
		      
		   form.on('submit(roleSub)', function(data){
		   
             $("#form1").ajaxSubmit({
	              	url:		'<c:url value="/addrelationvehicle.do"/>',
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
