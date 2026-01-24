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
     <link rel="stylesheet" href="<c:url value="/css/public.css"/>"  media="all" />
	 <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  <script type="text/javascript" src="<c:url value="/js/cardnumber.js"/>"></script>
  
  <body>
   <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  		<legend>添加风险人员</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
		<input type="hidden"  name="positionid" id="positionid"  value=${param.positionid}></input>
		<input type="hidden"  name="personnelid" id="personnelid"  value=0></input>
		<input type="hidden"  name="menuid" id="menuid"  value=${param.menuid}></input>
		<div class="layui-form-item">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>身份</label>
	    	<div class="layui-input-inline">
	      		<input type="text" name="identity" lay-verify="required" autocomplete="off" placeholder="请输入名称" class="layui-input"  lay-reqtext="名称不能为空">
	    	</div>
	    	<label class="layui-form-label"><font color="red" size=2>*</font>证件号码</label>
	    	<div class="layui-input-inline">
	      		<input type="text" name="cardnumber" id="cardnumber" lay-verify="required|cardnumber" autocomplete="off" placeholder="请输入证件号码" class="layui-input"  lay-reqtext="证件号码不能为空">
	    	</div>
	  	</div>
	  	<div class="layui-form-item">
	    	<div id="labels">
	    	</div>
	  	</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label">姓名</label>
	    	<div class="layui-input-inline">
	      		<input type="text" name="personname" id="personname" readonly style="background:#efefef" autocomplete="off" class="layui-input">
	    	</div>
	    	<label class="layui-form-label">手机号码</label>
	    	<div class="layui-input-inline">
	      		<input type="text" name="telnumber" id="telnumber" autocomplete="off" class="layui-input">
	    	</div>
	  	</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label">现住地</label>
	    	<div class="layui-input-inline">
	      		<input type="text" name="homeplace" id="homeplace" autocomplete="off" class="layui-input" style="width:660px;">
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
		   $('#cardnumber').blur(function(){
					$("#labels").empty();
		  			$.ajax({
						type:		'POST',
						url:		'<c:url value="/checkPersonnelCardnumber.do"/>',
						data:		{cardnumber :  this.value},
						dataType:	'json',
						async:      false,
						success:	function(data){
							if(data.flag){
								$("#personname").val(data.personnel.personname);
								$("#homeplace").val(data.personnel.homeplace);
								$("#telnumber").val(data.personnel.telnumber);
								$("#personnelid").val(data.personnel.id);
								if(data.personnel.zslabel1!=null&&data.personnel.zslabel1!=""){
				               		var zslabel1s=data.personnel.zslabel1.split(",");
				               		var str1='<label class="layui-form-label">已存在标签</label><div class="layui-input-inline" style="padding-left:5px;padding-top:6px;">';
				               		for(var i=0;i<zslabel1s.length;i++){
					               		$.ajax({
											type:		'POST',
											url:		'<c:url value="/getAttributeLabelByLabelid.do"/>',
											data:		{
															id: zslabel1s[i]
														},
											dataType:	'json',
											async:      false,
											success:	function(data){
												str1+='<span class="my-tag-item3" style="background-color:#1E9FFF;color:white;">'+data.attributelabel+'</span>';
											}
										});
				               		}
				               		str1+="</div>";
				               		$("#labels").html(str1);
				               }
	        					form.render();								
							}
						}
					});
			  });
			  
			  
			form.verify({
			  	cardnumber:function(value,item){
		  			var msg="";
		  			$.ajax({
						type:	'post',
						url:	'<c:url value="/checkPersonnelCardnumber.do"/>',
						data:	{cardnumber :  value},
						dataType:	'json',
						async:		false,
						success:	function(data){
							if(!data.flag)msg = "该证件号码不存在风险人员!!";
						}
					});
					if(msg!="")return msg;
			  	}
			  });
			
		  form.render();
		   form.on('submit(roleSub)', function(data){
		   
             $("#form1").ajaxSubmit({
	              	url:		'<c:url value="/addPositionPersonnel.do"/>',
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
		 		         		parent.$("#personnelbutton").click();
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
