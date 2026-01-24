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
  		<legend>新增使用手机</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
		<input type="hidden"  name="personnelid" id="personnelid"  value=${param.personnelid}></input>
		<input type="hidden"  name="menuid" id="menuid"  value=0></input>
		<div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>品牌型号</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="telbrand"  id="telbrand"  autocomplete="off" placeholder="请输入品牌型号" class="layui-input" lay-verify="required">
	      		</div>
	       	</div>
	  </div>
	 <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label">IMEI</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="imei"  id="imei"  autocomplete="off" placeholder="请输入IMEI" class="layui-input" >
	      		</div>
	       	</div>
	     </div>
	   <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label">设备MAC</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="mac"  id="mac"  autocomplete="off" placeholder="请输入设备MAC" class="layui-input" >
	      		</div>
	       	</div>
	     </div>
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
	    		<label class="layui-form-label">手机落实标签</label>
	    		<div class="layui-input-inline">
	      			<input type="checkbox" class="parent" name="knownlabel" lay-skin="primary" value="YJ" title="YJ">	
		            <input type="checkbox" class="parent" name="knownlabel" lay-skin="primary" value="WW" title="WW">
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
	
       });
		layui.use(['form', 'laydate'], function(){
		         var form = layui.form,
		         layer = layui.layer,
		         laydate = layui.laydate;
		      
		   form.on('submit(roleSub)', function(data){
		   
             $("#form1").ajaxSubmit({
	              	url:		'<c:url value="/addrelationphone.do"/>',
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
