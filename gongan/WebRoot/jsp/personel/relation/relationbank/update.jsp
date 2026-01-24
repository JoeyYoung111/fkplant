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
  		<legend>修改银行账号</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
	    <input type="hidden"  name="menuid" id="menuid"  value=0></input>
		<input type="hidden"  name="id" id="id"  value=${relationbank.id}></input>
		<input type="hidden"  name="personnelid" id="personnelid"  value=${relationbank.personnelid}></input>
		 <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label">开户时间</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="opentime" id="opentime"  autocomplete="off" placeholder="请输入开户时间" class="layui-input" value="${relationbank.opentime}">
	       	</div>
	     </div>
	     </div>
		<div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>银行账号</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="bankaccount" lay-verify="required" autocomplete="off" placeholder="请输入银行账号" class="layui-input"  lay-reqtext="请输入银行账号" value="${relationbank.bankaccount}">
	      		</div>
	       	</div>
	  </div>
	 <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>账号类型</label>
	    		<div class="layui-input-inline">
	      			<select id="accounttype"  name="accounttype" style="width:170px;" lay-verify="required" lay-verType="tips"></select>
	      		</div>
	       	</div>
	     </div>
	     <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label">开户行</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="openbank"  autocomplete="off" placeholder="请输入开户行" class="layui-input"  value="${relationbank.openbank}">
	      		</div>
	       	</div>
	     </div> 
	   <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label">开户地址</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="openaddress"  autocomplete="off" placeholder="请输入开户地址" class="layui-input" value="${relationbank.openaddress}">
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
				 url:		'<c:url value="/getBMByTypeToJSON1.do" />?basicType='+56, //关联信息-银行账号-账户类型
				 dataType:	'json',
				 async :      false,
				 success:	function(data){					  
				      var options = '<option value="">--请选择---</option>' + fillOption(data);
				      $("select[name^=accounttype]").html(options);
				      $("#accounttype").val("${relationbank.accounttype}");
				   }
			});
		
       });
		layui.use(['form', 'laydate'], function(){
		         var form = layui.form,
		         layer = layui.layer,
		         laydate = layui.laydate;
		         laydate.render({
					    elem: '#opentime'//指定元素
					  
                  });  	
		   form.on('submit(roleSub)', function(data){
		   
             $("#form1").ajaxSubmit({
	              	url:		'<c:url value="/updaterelationbank.do"/>',
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
