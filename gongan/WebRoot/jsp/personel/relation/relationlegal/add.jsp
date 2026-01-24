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
  		<legend>新增法人组织</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
		<input type="hidden"  name="personnelid" id="personnelid"  value=${param.personnelid}></input>
		<input type="hidden"  name="menuid" id="menuid"  value=0></input>
		<div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>机构名称</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="legalname"  autocomplete="off" placeholder="请输入机构名称" class="layui-input" lay-verify="required">
	      		</div>
	       	</div>
	       	<div class="layui-inline">
	    		<label class="layui-form-label">机构地址</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="legaladdress"  autocomplete="off" placeholder="请输入机构地址" class="layui-input" >
	      		</div>
	       	</div>
	  </div>
	 <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label">注册日期</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="registerdate" id="registerdate"  autocomplete="off" placeholder="请输入注册日期" class="layui-input" >
	      		</div>
	       	</div>
	       	<div class="layui-inline">
	    		<label class="layui-form-label">作废日期</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="voiddate" id="voiddate"  autocomplete="off" placeholder="请输入作废日期" class="layui-input" >
	      		</div>
	       	</div>
	     </div>  
	     <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label">经营范围</label>
	    		<div class="layui-input-inline"  style="width:670px;">
	      			<textarea name="businessscope" id="businessscope" class="layui-textarea"  placeholder="请输入经营范围" ></textarea>
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
		layui.use(['form', 'laydate'], function(){
		         var form = layui.form,
		         layer = layui.layer,
		         laydate = layui.laydate;
		         laydate.render({
					     elem: '#registerdate',//指定元素
					     type: 'date'  //date:年月日  datetime 年月日 时分秒
				 });  
				  laydate.render({
					     elem: '#voiddate',//指定元素
					     type: 'date'  //date:年月日  datetime 年月日 时分秒
				 });  	  
		   form.on('submit(roleSub)', function(data){
		   
             $("#form1").ajaxSubmit({
	              	url:		'<c:url value="/addrelationlegal.do"/>',
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
