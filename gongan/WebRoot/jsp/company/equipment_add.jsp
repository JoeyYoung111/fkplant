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
    
    <title>添加设备页面</title>
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/js/jquery.form.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  	
</head>
<body>
<form class="layui-form" method="post" id="form_equipment">

	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 5px;">
		<legend>添加设备信息</legend>
	</fieldset>
	
	<input type="hidden" name="companyid" id="companyid" value="${param.companyid }" />
	<input type="hidden" name="menuid" id="menuid" value="${param.menuid }" />
	
	<div class="layui-form-item">
		<div class="layui-inline">
			<label class="layui-form-label">设备名称</label>
			<div class="layui-input-inline">
				<select id="equipmentname" name="equipmentname" style="width:170px;"></select>
			</div>
		</div>
		<div class="layui-inline">
			<label class="layui-form-label">用途</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" name="purpose" id="purpose" autocomplete="off" />
			</div>
		</div>
	</div>
	
	<div class="layui-form-item">
		<div class="layui-inline">
			<label class="layui-form-label">制造厂商</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" name="makecompany" id="makecompany" autocomplete="off" />
			</div>
		</div>
		<div class="layui-inline">
			<label class="layui-form-label">品牌</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" name="equipmentbrand" id="equipmentbrand" autocomplete="off" />
			</div>
		</div>
	</div>
	
	<div class="layui-form-item">
		<div class="layui-inline">
			<label class="layui-form-label">型号</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" name="equipmenttype" id="equipmenttype" autocomplete="off" />
			</div>
		</div>
		<div class="layui-inline">
			<label class="layui-form-label">功率</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" name="equipmentpower" id="equipmentpower" autocomplete="off" />
			</div>
		</div>
	</div>
	
	<div class="layui-form-item">
		<div class="layui-inline">
			<label class="layui-form-label">购买日期</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" name="buydate" id="buydate" autocomplete="off" />
			</div>
		</div>
		<div class="layui-inline">
			<label class="layui-form-label">使用年限</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" name="useyear" id="useyear" autocomplete="off" />
			</div>
		</div>
	</div>
	
	<div class="layui-form-item">
		<div class="layui-inline">
			<label class="layui-form-label">使用情况</label>
			<div class="layui-input-inline">
				<select id="usestatus" name="usestatus" lay-filter="usestatus">
					<option value="自用" selected>自用</option>
					<option value="租借">租借</option>
					<option value="购销">购销</option>
				</select>
			</div>
		</div>
		<div class="layui-inline">
			<label class="layui-form-label">使用状态</label>
			<div class="layui-input-inline">
				<select id="usestate" name="usestate">
					<option value="正常" selected>正常</option>
					<option value="停用">停用</option>
					<option value="报废">报废</option>
				</select>
			</div>
		</div>
	</div>
	
	<div class="layui-form-item">
		<div class="layui-inline">
			<label class="layui-form-label"><font id="cz1" color="red" size=2>*</font>出租企业</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" name="leasecompany" id="leasecompany" autocomplete="off" />
			</div>
		</div>
		<div class="layui-inline">
			<label class="layui-form-label"><font id="cz2" color="red" size=2>*</font>承租企业</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" name="lesseecompany" id="lesseecompany" autocomplete="off" />
			</div>
		</div>
	</div>
	
	<div class="layui-form-item">
		<div class="layui-inline">
			<label class="layui-form-label"><font id="cs1" color="red" size=2>*</font>出售企业</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" name="sellcompany" id="sellcompany" autocomplete="off" />
			</div>
		</div>
		<div class="layui-inline">
			<label class="layui-form-label"><font id="cs2" color="red" size=2>*</font>购买企业</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" name="buycompany" id="buycompany" autocomplete="off" />
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
	      <button type="submit" class="layui-btn" lay-submit="" lay-filter="ADDEquip">立即提交</button>
	      <button type="reset" class="layui-btn layui-btn-primary" id="ADDEquipReset">重置</button>
	    </div>
  	</div>
	  	
</form>

<script type="text/javascript">
	
function Today(){
	var now = new Date();
	return now.getFullYear() + "-" + (now.getMonth() + 1) + "-" + now.getDate();
}

//获取设备数据字典
function getEquipmentName(){
	$.ajax({
		type:		'POST',
		url:		'<c:url value="/getBMByTypeToJSON.do"/>?basicType='+76,
		dataType:	'json',
		async:		false,
		success:	function(data){
			var options = fillOption(data);
			$("select[name^=equipmentname]").html(options);
		}
	});
}

$(document).ready(function(){
	$("#cz1").hide();
	$("#cz2").hide();
	$("#cs1").hide();
	$("#cs2").hide();
	getEquipmentName();
});
	

layui.use(['form','laydate'],function(){
	var form = layui.form;
	
	form.on('select(usestatus)',function(data){
		if(data.value == '租借'){
			$("#leasecompany").attr("lay-verify","required");
			$("#lesseecompany").attr("lay-verify","required");
			$("#sellcompany").removeAttr("lay-verify","required");
			$("#buycompany").removeAttr("lay-verify","required");
			$("#cz1").show();
			$("#cz2").show();
			$("#cs1").hide();
			$("#cs2").hide();
			form.render('select');
		}else if(data.value == '购销'){
			$("#sellcompany").attr("lay-verify","required");
			$("#buycompany").attr("lay-verify","required");
			$("#leasecompany").removeAttr("lay-verify","required");
			$("#lesseecompany").removeAttr("lay-verify","required");
			$("#cz1").hide();
			$("#cz2").hide();
			$("#cs1").show();
			$("#cs2").show();
			form.render('select');
		}else{
			$("#leasecompany").removeAttr("lay-verify","required");
			$("#lesseecompany").removeAttr("lay-verify","required");
			$("#sellcompany").removeAttr("lay-verify","required");
			$("#buycompany").removeAttr("lay-verify","required");
			$("#cz1").hide();
			$("#cz2").hide();
			$("#cs1").hide();
			$("#cs2").hide();
			form.render('select');
		}
	});
	
	var laydate = layui.laydate;
	
	laydate.render({
		elem:	'#buydate',
		max:	Today(),
		trigger:'click'
	});
	
	form.render();
	
	form.on('submit(ADDEquip)',function(data){
		var index1 = top.layer.msg('数据提交中...',{icon:16,time:false,shade:0.8});
		setTimeout(function(){
			$("#form_equipment").ajaxSubmit({
				url:		'<c:url value="/addEquipment.do"/>',
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
			 		        parent.$("#searchEquipment").click();
		               },500);
	              	}else{
	              		layer.msg(obj.msg);
	              	}
				},error:function(){
					alert("请求失败");
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
