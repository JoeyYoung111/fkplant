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
  		<legend>添加民警工作记载</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
		<input type="hidden"  name="recordtype" id="recordtype"  value="${param.recordtype}"></input>
		<input type="hidden"  name="recordid" id="recordid"  value="${param.recordid}"></input>
		<input type="hidden"  name="menuid" id="menuid"  value=${param.menuid}></input>
		<div class="layui-form-item">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>工作方式</label>
	    	<div class="layui-input-inline">
	    		<select id="worktype" name="worktype" lay-verify="required" lay-reqtext="请选择工作方式" autocomplete="off" lay-verType="tips">
					<option value=""> --- 请选择工作方式 --- </option>
				</select>
	    	</div>
	    	<label class="layui-form-label"><font color="red" size=2>*</font>时间</label>
	    	<div class="layui-input-inline">
	      		<input type="text" name="worktime" id="worktime" readonly lay-verify="required" lay-reqtext="请选择工作时间" autocomplete="off" placeholder="年-月-日" class="layui-input">
	    	</div>
	  	</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>地点</label>
	    	<div class="layui-input-inline">
	      		<input type="text" name="workplace" lay-verify="required" autocomplete="off" lay-reqtext="请填写工作地点" class="layui-input" style="width:660px;">
	    	</div>
	  	</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>工作记录</label>
	    	<div class="layui-input-inline">
	      		<textarea placeholder="何时、何地以何种方式做出的工作记录详情。" lay-reqtext="请填写工作记录" lay-verify="required" class="layui-textarea" name="workrecord" style="width:660px;"></textarea>
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
		function getworktype(){
			$.ajax({
				type:		'POST',
				url:		'<c:url value="/getBMByTypeToJSON.do?basicType="/>'+105,
				dataType:	'json',
				async:      false,
				success:	function(data){
					var options="";
					$.each(data.list, function(i, item) {
						$.each(item, function(i) {
							options += '<option value="' + this.text + '">' + this.text + '</option>';
						});
					});
					$("#worktype").append(options);
				}
			});
		}
		$(document).ready(function(){
			getworktype();
       	});
		
		layui.use(['form', 'laydate'], function(){
		         var form = layui.form,
		         layer = layui.layer,
		         laydate = layui.laydate;
		   laydate.render({
			   	elem:'#worktime'
			   	,format:  'yyyy-MM-dd'
			  });
		  form.render();
		   form.on('submit(roleSub)', function(data){
             $("#form1").ajaxSubmit({
	              	url:		'<c:url value="/addWorkRecord.do"/>',
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
		 		         		if("${param.recordtype}"=="personel")parent.$("#tabWorkRecord").click();
		 		         		else parent.$("#recordbutton").click();
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
