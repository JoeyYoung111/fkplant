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
    <base href="<%=basePath%>">
    
    <title>审查页面</title>
    
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  </head>
  
  <body>
  	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  		<legend>审查矛盾风险信息</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
		<input type="hidden"  name="menuid" value="${param.menuid}">
		<input type="hidden"  name="id" value="${contradictionInfo.id}">
		<div class="layui-form-item">
			<label class="layui-form-label">风险名称</label>
			<div class="layui-input-inline" style="width:20%;">
	      		<input type="text" class="layui-input" readonly="readonly" value="${contradictionInfo.cdtname}">
	    	</div>
	    	<label class="layui-form-label" style="width:10%;">风险等级</label>
	    	<div class="layui-input-inline" style="width:20%;">
	      		<input type="text" class="layui-input" readonly="readonly" value="${contradictionInfo.cdtlevel}">
	    	</div>
		</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label">风险类别</label>
	    	<div class="layui-input-inline" style="width:20%;">
				<input type="text" class="layui-input" readonly="readonly" value="${contradictionInfo.typename}">
			</div>
	    	<label class="layui-form-label" style="width:10%;">处置结果</label>
	    	<div class="layui-input-inline" style="width:20%;">
	    		<input type="text" class="layui-input" readonly="readonly" value="${contradictionInfo.cdtresult}">
	    	</div>
	  	</div>
	  	<div  class="layui-form-item">
			<label class="layui-form-label">事发地址</label>
			<div class=layui-input-inline style="width:52.5%;">
				<input type="text" class="layui-input" readonly="readonly" value="${contradictionInfo.sfdz}">
			</div>
		</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label">涉事人数</label>
	    	<div class="layui-input-inline" style="width:20%;">
	    		<input type="text" class="layui-input" readonly="readonly" value="${contradictionInfo.ssrs}">
			</div>
	    	<label class="layui-form-label" style="width:10%;">涉及金额</label>
	    	<div class="layui-input-inline" style="width:20%;">
	    		<input type="text" class="layui-input" readonly="readonly" value="${contradictionInfo.sjje}">
      		</div>
	  	</div>
	  	<div class="layui-form-item">
	    	<label class="layui-form-label">主办部门</label>
	    	<div class="layui-input-inline" style="width:20%;">
	    		<input type="text" class="layui-input" readonly="readonly" value="${contradictionInfo.sponsorname}">
			</div>
	    	<label class="layui-form-label" style="width:10%;">协办部门</label>
	    	<div class="layui-input-inline" style="width:20%;">
	    		<input type="text" class="layui-input" readonly="readonly" value="${contradictionInfo.assistdept}">
			</div>
	  	</div>
	  	<div class="layui-form-item layui-form-text">
		    <label class="layui-form-label">风险矛盾概况</label>
		    <div class="layui-input-inline" style="width:52.5%;">
		      <textarea class="layui-textarea" readonly="readonly">${contradictionInfo.cdtcontent}</textarea>
		    </div>
		</div>
		<div class="layui-form-item layui-form-text">
		    <label class="layui-form-label">备注信息</label>
		    <div class="layui-input-inline"  style="width:52.5%;">
		      <textarea class="layui-textarea" readonly="readonly">${contradictionInfo.memo}</textarea>
		    </div>
		</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label">审核结果</label>
	    	<div class="layui-input-block">
		    	<input type="radio" name="nowstate" value="2" title="通过" checked>
		    	<input type="radio" name="nowstate" value="3" title="不通过">
	    	</div>
	  	</div>
		<div class="layui-form-item layui-form-text">
		    <label class="layui-form-label">反馈意见</label>
		    <div class="layui-input-inline" style="width:52.5%;">
		      <textarea placeholder="请输入内容" class="layui-textarea" name="examineopinion"></textarea>
		    </div>
		</div>
		<div class="layui-form-item">
		    <div class="layui-input-block">
		      <button type="submit" class="layui-btn" lay-submit="" lay-filter="userSub">立即提交</button>
		      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
		    </div>
	  	</div>
	</form>
	<script type="text/javascript">
		layui.use(['form'], function(){
		  var form = layui.form;
		  form.on('submit(userSub)', function(data){
		     $("#form1").ajaxSubmit({
	              	url:		'<c:url value="/checkContradictionInfo.do"/>',
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
