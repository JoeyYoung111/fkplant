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
    
    <title>修改页面</title>
    
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  </head>
  
  <body>
  	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  		<legend>修改涉及物品</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
		<input type="hidden"  name="menuid" value="${menuid}">
		<input type="hidden"  name="id" value="${zbEventInfo.id}" />
		<input type="hidden"  name="cdtid" value=${zbEventInfo.cdtid }>
	  	<div class="layui-form-item">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>物品名称</label>
	    	<div class="layui-input-inline">
	      		<input type="text" name="name" value="${zbEventInfo.name }" lay-verify="required" autocomplete="off" placeholder="请输入物品名称" class="layui-input"  lay-reqtext="物品名称不能为空">
	    	</div>
	    	<label class="layui-form-label"><font color="red" size=2>*</font>物品类型</label>
	    	<div class="layui-input-inline">
<%--	      		<input type="text" name="type" value="${zbEventInfo.type }" lay-verify="required" autocomplete="off" placeholder="请输入物品类型" class="layui-input"  lay-reqtext="物品类型不能为空">--%>
	    		<select name="type" autocomplete="off" lay-verify="required" lay-verType="tips" lay-reqtext="请选择物品类型">
					<option value="" selected> --- 请选择物品类型 --- </option>
					<option value="作案工具" <c:if test="${zbEventInfo.type eq '作案工具'}">selected</c:if>>作案工具</option>
					<option value="资金资产" <c:if test="${zbEventInfo.type eq '资金资产'}">selected</c:if>>资金资产</option>
					<option value="反宣品" <c:if test="${zbEventInfo.type eq '反宣品'}">selected</c:if>>反宣品</option>
					<option value="其他物品" <c:if test="${zbEventInfo.type eq '其他物品'}">selected</c:if>>其他物品</option>
				</select>
	    	</div>
	  	</div>
	  	<div class="layui-form-item">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>处理结果</label>
	    	<div class="layui-input-inline">
<%--	    		<input type="text" name="result" value="${zbEventInfo.result }" lay-verify="required" autocomplete="off" placeholder="请输入处理结果" class="layui-input"  lay-reqtext="处理结果不能为空">--%>
	    		<select name="result" autocomplete="off" lay-verify="required" lay-verType="tips" lay-reqtext="请选择处理结果">
					<option value="" selected> --- 请选择处理结果 --- </option>
					<option value="收缴" <c:if test="${zbEventInfo.result eq '收缴'}">selected</c:if>>收缴</option>
					<option value="没收" <c:if test="${zbEventInfo.result eq '没收'}">selected</c:if>>没收</option>
					<option value="扣押" <c:if test="${zbEventInfo.result eq '扣押'}">selected</c:if>>扣押</option>
				</select>
	    	</div>
	  	</div>
		<div class="layui-form-item">
		    <div class="layui-input-block">
		      <button type="submit" class="layui-btn" lay-submit="" lay-filter="msgSub">立即提交</button>
		      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
		    </div>
	  	</div>
	</form>
	<script type="text/javascript">
		layui.use(['form'], function(){
			var form = layui.form,
			layer = layui.layer;
			
		  form.on('submit(msgSub)', function(data){
	         $("#form1").ajaxSubmit({
	              	url:		'<c:url value="/updateZbEventInfo.do"/>',
	              	dataType:	'json',
	              	async:  false,
	              	success:	function(data) {
	                  	if(data.flag>0){
	                  	    //弹出loading
	 		            	var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
	                     	setTimeout(function(){         
	                     		top.layer.msg(data.msg);
	                     		top.layer.close(index);
				        		layer.closeAll("iframe");
		 		        		//刷新父页面
		 		         		parent.$("#sjwpbutton").click();
		 		         		parent.layer.closeAll("iframe");
	                   		},2000);
	                 	}else{
	                  	 	layer.msg(data.msg);
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
