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
    
    <title>添加化学品种类页面</title>
    <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/js/jquery.form.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/cardnumber.js"/>"></script>
  	
</head>
<body>
<form class="layui-form" method="post" id="form_chemical">

	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 5px;">
		<legend>添加化学品种类</legend>
	</fieldset>
	
	<input type="hidden" name="companyid" id="companyid" value="${param.companyid }" />
	<input type="hidden" name="menuid" id="menuid" value="${param.menuid }" />
	
	<div class="layui-form-item">
		<div class="layui-inline">
			<label class="layui-form-label"><font color="red" size=2>*</font>化学品名称</label>
			<div class="layui-input-inline" style="width:670px;" id="CHENAME">
				<select name="chemicalname" id="chemicalname" lay-filter="chemicalname" 
					lay-verify="required" lay-reqtext="请选择化学品" lay-reqdiv="CHENAME"></select>
			</div>
		</div>
	</div>
	
	<div class="layui-form-item">
		<div class="layui-inline">
			<label class="layui-form-label">化学品用途</label>
			<div class="layui-input-inline">
				<select id="purpose" name="purpose">
					<option value='经营'>经营</option>
					<option value='运输'>运输</option>
					<option value='使用'>使用</option>
				</select>
			</div>
		</div>
		<div class="layui-inline">
			<label class="layui-form-label">化学品所属类别</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" id="belongtype_show" readonly="true"/>
				<input type="hidden" name="belongtype" id="belongtype"/>
			</div>
		</div>
	</div>
	
	<div class="layui-form-item">
		<div class="layui-inline">
			<label class="layui-form-label">化学品类别</label>
			<div class="layui-input-inline" style="width:670px;">
				<input type="checkbox" name="chemicaltype" lay-skin="primary" value="试剂" title="试剂" />
				<input type="checkbox" name="chemicaltype" lay-skin="primary" value="工业" title="工业" />
			</div>
		</div>
	</div>
	
	<div class="layui-form-item">
		<div class="layui-inline">
	    	<label class="layui-form-label">包装类型</label>
	    	<div class="layui-input-inline">
	    		<input type="checkbox" name="packingtype" lay-skin="primary" value="散装" title="散装" />
	    		<input type="checkbox" name="packingtype" lay-skin="primary" value="桶装" title="桶装" />
	    		<input type="checkbox" name="packingtype" lay-skin="primary" value="瓶装" title="瓶装" />
	    	</div>
		</div>
	</div>
	
	<div class="layui-form-item layui-form-text">
		<label class="layui-form-label">备注信息</label>
	 	<div class="layui-input-inline" style="width:670px;">
	 		<textarea name="memo" id="memo" class="layui-textarea"></textarea>
	 	</div>
	</div>

	<div class="layui-form-item">
	    <div class="layui-input-block">
	      <button type="submit" class="layui-btn" lay-submit="" lay-filter="ADDChemical">立即提交</button>
	      <button type="reset" class="layui-btn layui-btn-primary" id="ADDChemicalReset">重置</button>
	    </div>
  	</div>
	  	
</form>

<script type="text/javascript">

function getChemical(){
	$.ajax({
		type:		'POST',
		url:		'<c:url value="/selectChemicalName.do"/>?id=${param.companyid }',
		dataType:	'json',
		async:		false,
		success:	function(data){
			var options = fillOption(data);
			options = '<option value="" selected>---请选择---</option>'+options;
			$("select[name^=chemicalname]").html(options);
		}
	});
}

$(document).ready(function(){
	getChemical();
});

layui.use(['form'],function(){
	var form = layui.form;
	var layer = layui.layer;
	
	form.on('select(chemicalname)',function(data){
		if(data.value!=""){
			$.ajax({
				type:	'POST',
				url:	'<c:url value="/getBMById.do"/>?id='+data.value,
				dataType:'json',
				async:	false,
				success: function(data){
					var obj = eval('('+data+')');
					$("#belongtype_show").val(obj.msg);
					$("#belongtype").val(obj.flag);
				}
			});
		}
	});
	
	
	form.render();
	
	form.on('submit(ADDChemical)',function(data){
		setTimeout(function(){
			$("#form_chemical").ajaxSubmit({
				url:		'<c:url value="/addChemical.do"/>',
				dataType:	'json',
				async:		false,
				success:	function(data) {
					var obj = eval('(' + data + ')');
	              	if(obj.flag>0){
	              	   //弹出loading
			            var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
		                setTimeout(function(){         
			                top.layer.msg(obj.msg);
			                top.layer.close(index);
					        layer.closeAll("iframe");
					        parent.layer.closeAll("iframe");
			 		        //刷新父页面
			 		        //parent.location.reload();
			 		        parent.$("#searchChemical").click();
		               },500);
	              	}else{
	              		top.layer.msg(obj.msg);
	              	}
				},error:function(){
					top.layer.alert("请求失败");
				}
			});
	   	},800);
	  	return false;
	});
	
});
		
</script>

</body>
</html>
