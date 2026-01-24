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
    
    <title>修改化学品种类页面</title>
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/js/jquery.form.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  	
</head>
<body>
<form class="layui-form" method="post" id="form_updatechemical">

	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 5px;">
		<legend>修改化学品种类</legend>
	</fieldset>
	
	<input type="hidden" name="id" id="id" value="${id}" />
	<input type="hidden" name="menuid" id="menuid" value="${menuid }" />
	<input type="hidden" id="chemicaltype" value="${chemical.chemicaltype}" />
	<input type="hidden" id="packingtype" value="${chemical.packingtype}" />
    
	<div class="layui-form-item">
		<div class="layui-inline">
			<label class="layui-form-label">化学品名称</label>
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
					<option value='经营'<c:if test='${chemical.purpose eq "经营"}'> selected</c:if>>经营</option>
					<option value='运输'<c:if test='${chemical.purpose eq "运输"}'> selected</c:if>>运输</option>
					<option value='使用'<c:if test='${chemical.purpose eq "使用"}'> selected</c:if>>使用</option>
				</select>
			</div>
		</div>
		<div class="layui-inline">
			<label class="layui-form-label">化学品所属类别</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" id="belongtype_show" readonly="true"/>
				<input type="hidden" name="belongtype" id="belongtype" value="${chemical.belongtype}"/>
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
	 		<textarea name="memo" id="memo" class="layui-textarea">${chemical.memo}</textarea>
	 	</div>
	</div>

	<div class="layui-form-item">
	    <div class="layui-input-block">
	      <button type="submit" class="layui-btn" lay-submit="" lay-filter="UPDATEChemical">立即提交</button>
	      <button type="reset" class="layui-btn layui-btn-primary" id="UPDATEChemicalReset">重置</button>
	    </div>
  	</div>
	  	
</form>

<script type="text/javascript">
	
layui.config({
    base: "<c:url value="/layui/lay/modules/"/>"
}).extend({
	zTreeSelectM: "zTreeSelectM/zTreeSelectM",
    treeSelect: "treeSelect"
});

function getChemical(){
	$.ajax({
		type:		'POST',
		url:		'<c:url value="/selectChemicalName.do"/>?id=${chemical.companyid }',
		dataType:	'json',
		async:		false,
		success:	function(data){
			var options = fillOption(data);
			$("select[name^=chemicalname]").html(options);
		}
	});
}

function parentName(value){
	$.ajax({
		type:	'POST',
		url:	'<c:url value="/getBMById.do"/>?id='+value,
		dataType:'json',
		async:	false,
		success: function(data){
			var obj = eval('('+data+')');
			$("#belongtype_show").val(obj.msg);
			$("#belongtype").val(obj.flag);
		}
	});
}

/*化学品类别按钮*/
function chemicaltypeCheckboxed(){
	var ctype = $("#chemicaltype").val();
	if(ctype!=""){
		var button1 = ctype.split(",");
		$('input:checkbox[name=chemicaltype]').each(function (i){
			for(i=0;i<button1.length;i++){
				if(button1[i]==$(this).val()){
					$(this).prop('checked','checked');
				}
			}
		});
	}
}
/*包装类型*/
function packingtypeCheckboxed(){
	var ptype = $("#packingtype").val();
	if(ptype!=""){
		var button2 = ptype.split(",");
		$('input:checkbox[name=packingtype]').each(function (j){
			for(j=0;j<button2.length;j++){
				if(button2[j]==$(this).val()){
					$(this).prop('checked','checked');
				}
			}
		});
	}
}

$(document).ready(function(){
	chemicaltypeCheckboxed();
	packingtypeCheckboxed();
	getChemical();
	
	var lh = '${chemical.chemicalname}';
	$("#chemicalname").val(lh);
	parentName(lh);
});


layui.use(['form'],function(){
	var form = layui.form;
	var layer = layui.layer;
	
	form.render();
	
	form.on('select(chemicalname)',function(data){
		if(data.value!=""){
			parentName(data.value);
		}
	});
	
	form.on('submit(UPDATEChemical)',function(data){
		var index1 = top.layer.msg('数据提交中...',{icon:16,time:false,shade:0.8});
		setTimeout(function(){
			$("#form_updatechemical").ajaxSubmit({
				url:		'<c:url value="/updateChemical.do"/>',
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
	   		top.layer.close(index1);
	   	},800);
	  	return false;
	});
	
});
		
</script>

</body>
</html>
