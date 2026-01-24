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
	<link rel="stylesheet" href="<c:url value="/css/system.css"/>" type="text/css"/>
	<script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
	<script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
 </head>
  
<body style="background-color:#FFFFFF;">
<form class="layui-form" method="post" id="form1" onsubmit="return false;">
<input type="hidden" id="idlist1" value="${param.idlist1}"/>
<input type="hidden" id="idlist2" value="${param.idlist2}"/>
<table width="95%" border="0" cellspacing="0" cellpadding="0" style="margin-left: 2.5%;margin-top: 2.5%;margin-bottom: 30px;">
	
	<tr>
		<td width="60%" colspan="3">
			<fieldset class="layui-elem-field layui-field-title" style="margin-top: 5px;">
		  		<legend>总局</legend>
			</fieldset>
		</td>
		<td width="20%" style="padding-left:25px;">
			<input type="checkbox" lay-filter="zjall" title="全选" lay-skin="primary">
		</td>
	</tr>
	<tbody id="zjlist"></tbody>
	
	<tr>
		<td width="60%" colspan="3">
			<fieldset class="layui-elem-field layui-field-title" style="margin-top: 5px;">
		  		<legend>分局</legend>
			</fieldset>
		</td>
		<td width="20%" style="padding-left:25px;">
			<input type="checkbox" lay-filter="fjall" title="全选" lay-skin="primary">
		</td>
	</tr>
	<tbody id="fjlist"></tbody>
	
	<tr>
		<td width="60%" colspan="3">
			<fieldset class="layui-elem-field layui-field-title" style="margin-top: 5px;">
		  		<legend>警种部门</legend>
			</fieldset>
		</td>
		<td width="20%" style="padding-left:25px;">
			<input type="checkbox" lay-filter="jzbmall" title="全选" lay-skin="primary">
		</td>
	</tr>
	<tbody id="jzbmlist"></tbody>
	
	<tr>
		<td width="60%" colspan="3">
			<fieldset class="layui-elem-field layui-field-title" style="margin-top: 5px;">
		  		<legend>派出所</legend>
			</fieldset>
		</td>
		<td width="20%" style="padding-left:25px;">
			<input type="checkbox" lay-filter="pcsall" title="全选" lay-skin="primary">
		</td>
	</tr>
	<tbody id="pcslist"></tbody>
	
	<tr>
		<td width="60%" colspan="3">
			<fieldset class="layui-elem-field layui-field-title" style="margin-top: 5px;">
		  		<legend>政府部门</legend>
			</fieldset>
		</td>
		<td width="20%" style="padding-left:25px;">
			<input type="checkbox" lay-filter="zfbmall" title="全选" lay-skin="primary">
		</td>
	</tr>
	<tbody id="zfbmlist"></tbody>
	
	<tr>
		<td width="60%" colspan="3">
			<fieldset class="layui-elem-field layui-field-title" style="margin-top: 5px;">
		  		<legend>其他</legend>
			</fieldset>
		</td>
		<td width="20%" style="padding-left:25px;">
			<input type="checkbox" lay-filter="qtall" title="全选" lay-skin="primary">
		</td>
	</tr>
	<tbody id="qtlist"></tbody>
	
</table>
<div class="layui-form-item">
    <div class="layui-col-md4 layui-col-md-offset4" style="margin-bottom: 20px;">
    	<button type="submit" class="layui-btn" lay-submit="" lay-filter="sure"><i class="layui-icon">&#xe67d;</i>确 定</button>
    </div>
</div>
</form>

<script type="text/javascript">

var zjbody = window.document.getElementById("zjlist");
var fjbody = window.document.getElementById("fjlist");
var jzbmbody = window.document.getElementById("jzbmlist");
var pcsbody = window.document.getElementById("pcslist");
var zfbmbody = window.document.getElementById("zfbmlist");
var qtbody = window.document.getElementById("qtlist");

var otherunitidstr = [];
var otherunitstr = [];
var list1 = $("#idlist1").val();
list1 = list1.split(",");
var list2 = $("#idlist2").val();
list2 = list2.split(",");

$(document).ready(function(){
	ZJ();
	FJ();
	JZBM();
	PCS();
	ZFBM();
	QT();
});
    
layui.use(['form'],function(){
	var form=layui.form;
	
	form.on('checkbox(zjall)',function(data){
		if(data.elem.checked){
			$("input[name=zj]").prop("checked",true);
		}else{
			$("input[name=zj]").prop("checked",false);
		}
		form.render();
	});
	form.on('checkbox(fjall)',function(data){
		if(data.elem.checked){
			$("input[name=fj]").prop("checked",true);
		}else{
			$("input[name=fj]").prop("checked",false);
		}
		form.render();
	});
	form.on('checkbox(jzbmall)',function(data){
		if(data.elem.checked){
			$("input[name=jzbm]").prop("checked",true);
		}else{
			$("input[name=jzbm]").prop("checked",false);
		}
		form.render();
	});
	form.on('checkbox(pcsall)',function(data){
		if(data.elem.checked){
			$("input[name=pcs]").prop("checked",true);
		}else{
			$("input[name=pcs]").prop("checked",false);
		}
		form.render();
	});
	form.on('checkbox(zfbmall)',function(data){
		if(data.elem.checked){
			$("input[name=zfbm]").prop("checked",true);
		}else{
			$("input[name=zfbm]").prop("checked",false);
		}
		form.render();
	});
	form.on('checkbox(qtall)',function(data){
		if(data.elem.checked){
			$("input[name=qt]").prop("checked",true);
		}else{
			$("input[name=qt]").prop("checked",false);
		}
		form.render();
	});
	
	form.on('submit(sure)', function(data){
		$("input[name=zj]:checked").each(function(){
		 	var p=$(this);
		 	otherunitidstr.push(p.val());
		 	otherunitstr.push(p.attr("title"));
		});
		$("input[name=fj]:checked").each(function(){
		 	var p=$(this);
		 	otherunitidstr.push(p.val());
		 	otherunitstr.push(p.attr("title"));
		});
		$("input[name=jzbm]:checked").each(function(){
		 	var p=$(this);
		 	otherunitidstr.push(p.val());
		 	otherunitstr.push(p.attr("title"));
		});
		$("input[name=pcs]:checked").each(function(){
		 	var p=$(this);
		 	otherunitidstr.push(p.val());
		 	otherunitstr.push(p.attr("title"));
		});
		$("input[name=zfbm]:checked").each(function(){
		 	var p=$(this);
		 	otherunitidstr.push(p.val());
		 	otherunitstr.push(p.attr("title"));
		});
		$("input[name=qt]:checked").each(function(){
		 	var p=$(this);
		 	otherunitidstr.push(p.val());
		 	otherunitstr.push(p.attr("title"));
		});
		
		parent.$("#otherunitids").val(otherunitidstr.join(","));
		parent.$("#otherunit").val(otherunitstr.join(","));
		layui.layer.closeAll("iframe");
        parent.layui.layer.closeAll("iframe");
	});
	
});

function ZJ(){
	$.ajax({
		url:		'<c:url value="/getDepartmentTreeTable.do"/>?departtype=1',
		type:		'post',
		dataType:	'json',
		async:		false,
		success:	function(result){
			var str = "<tr>";
			var data = result.data;
			for(var i=0;i<data.length;i++){
				if( i>0 && i%4 == 0){
					str += "</tr><tr>";
				}
				if(list1.indexOf(data[i].id.toString())>=0){
					str += "<td width='20%' style='padding:5px;padding-left:20px;'><input type='checkbox' title='"+ data[i].departname +"' lay-skin='primary' disabled='disabled'/></td>";
				}else if(list2.indexOf(data[i].id.toString())>=0){
					str += "<td width='20%' style='padding:5px;padding-left:20px;'><input type='checkbox' name='zj' value='"+ data[i].id +"' title='"+ data[i].departname +"' lay-skin='primary' checked /></td>";
				}else{
					str += "<td width='20%' style='padding:5px;padding-left:20px;'><input type='checkbox' name='zj' value='"+ data[i].id +"' title='"+ data[i].departname +"' lay-skin='primary' /></td>";
				}
			}
			str += "</tr>";
			zjbody.innerHTML = str;
		}
	});
}

function FJ(){
	$.ajax({
		url:		'<c:url value="/getDepartmentTreeTable.do"/>?departtype=2',
		type:		'post',
		dataType:	'json',
		async:		false,
		success:	function(result){
			var str = "<tr>";
			var data = result.data;
			for(var i=0;i<data.length;i++){
				if( i>0 && i%4 == 0){
					str += "</tr><tr>";
				}
				if(list1.indexOf(data[i].id.toString())>=0){
					str += "<td width='20%' style='padding:5px;padding-left:20px;'><input type='checkbox' title='"+ data[i].departname +"' lay-skin='primary' disabled='disabled'/></td>";
				}else if(list2.indexOf(data[i].id.toString())>=0){
					str += "<td width='20%' style='padding:5px;padding-left:20px;'><input type='checkbox' name='fj' value='"+ data[i].id +"' title='"+ data[i].departname +"' lay-skin='primary' checked /></td>";
				}else{
					str += "<td width='20%' style='padding:5px;padding-left:20px;'><input type='checkbox' name='fj' value='"+ data[i].id +"' title='"+ data[i].departname +"' lay-skin='primary' /></td>";
				}
			}
			str += "</tr>";
			fjbody.innerHTML = str;
		}
	});
}

function JZBM(){
	$.ajax({
		url:		'<c:url value="/getDepartmentTreeTable.do"/>?departtype=3',
		type:		'post',
		dataType:	'json',
		async:		false,
		success:	function(result){
			var str = "<tr>";
			var data = result.data;
			for(var i=0;i<data.length;i++){
				if( i>0 && i%4 == 0){
					str += "</tr><tr>";
				}
				if(list1.indexOf(data[i].id.toString())>=0){
					str += "<td width='20%' style='padding:5px;padding-left:20px;'><input type='checkbox' title='"+ data[i].departname +"' lay-skin='primary' disabled='disabled'/></td>";
				}else if(list2.indexOf(data[i].id.toString())>=0){
					str += "<td width='20%' style='padding:5px;padding-left:20px;'><input type='checkbox' name='jzbm' value='"+ data[i].id +"' title='"+ data[i].departname +"' lay-skin='primary' checked /></td>";
				}else{
					str += "<td width='20%' style='padding:5px;padding-left:20px;'><input type='checkbox' name='jzbm' value='"+ data[i].id +"' title='"+ data[i].departname +"' lay-skin='primary' /></td>";
				}
			}
			str += "</tr>";
			jzbmbody.innerHTML = str;
		}
	});
}

function PCS(){
	$.ajax({
		url:		'<c:url value="/getDepartmentTreeTable.do"/>?departtype=4',
		type:		'post',
		dataType:	'json',
		async:		false,
		success:	function(result){
			var str = "<tr>";
			var data = result.data;
			for(var i=0;i<data.length;i++){
				if( i>0 && i%4 == 0 ){
					str += "</tr><tr>";
				}
				if(list1.indexOf(data[i].id.toString())>=0){
					str += "<td width='20%' style='padding:5px;padding-left:20px;'><input type='checkbox' title='"+ data[i].departname +"' lay-skin='primary' disabled='disabled'/></td>";
				}else if(list2.indexOf(data[i].id.toString())>=0){
					str += "<td width='20%' style='padding:5px;padding-left:20px;'><input type='checkbox' name='pcs' value='"+ data[i].id +"' title='"+ data[i].departname +"' lay-skin='primary' checked /></td>";
				}else{
					str += "<td width='20%' style='padding:5px;padding-left:20px;'><input type='checkbox' name='pcs' value='"+ data[i].id +"' title='"+ data[i].departname +"' lay-skin='primary' /></td>";
				}
			}
			str += "</tr>";
			pcsbody.innerHTML = str;
		}
	});
}

function ZFBM(){
	$.ajax({
		url:		'<c:url value="/getDepartmentTreeTable.do"/>?departtype=5',
		type:		'post',
		dataType:	'json',
		async:		false,
		success:	function(result){
			var str = "<tr>";
			var data = result.data;
			for(var i=0;i<data.length;i++){
				if( i>0 && i%4 == 0){
					str += "</tr><tr>";
				}
				if(list1.indexOf(data[i].id.toString())>=0){
					str += "<td width='20%' style='padding:5px;padding-left:20px;'><input type='checkbox' title='"+ data[i].departname +"' lay-skin='primary' disabled='disabled'/></td>";
				}else if(list2.indexOf(data[i].id.toString())>=0){
					str += "<td width='20%' style='padding:5px;padding-left:20px;'><input type='checkbox' name='zfbm' value='"+ data[i].id +"' title='"+ data[i].departname +"' lay-skin='primary' checked /></td>";
				}else{
					str += "<td width='20%' style='padding:5px;padding-left:20px;'><input type='checkbox' name='zfbm' value='"+ data[i].id +"' title='"+ data[i].departname +"' lay-skin='primary' /></td>";
				}
			}
			str += "</tr>";
			zfbmbody.innerHTML = str;
		}
	});
}

function QT(){
	$.ajax({
		url:		'<c:url value="/getDepartmentTreeTable.do"/>?departtype=6',
		type:		'post',
		dataType:	'json',
		async:		false,
		success:	function(result){
			var str = "<tr>";
			var data = result.data;
			for(var i=0;i<data.length;i++){
				if( i>0 && i%4 == 0){
					str += "</tr><tr>";
				}
				if(list1.indexOf(data[i].id.toString())>=0){
					str += "<td width='20%' style='padding:5px;padding-left:20px;'><input type='checkbox' title='"+ data[i].departname +"' lay-skin='primary' disabled='disabled'/></td>";
				}else if(list2.indexOf(data[i].id.toString())>=0){
					str += "<td width='20%' style='padding:5px;padding-left:20px;'><input type='checkbox' name='qt' value='"+ data[i].id +"' title='"+ data[i].departname +"' lay-skin='primary' checked /></td>";
				}else{
					str += "<td width='20%' style='padding:5px;padding-left:20px;'><input type='checkbox' name='qt' value='"+ data[i].id +"' title='"+ data[i].departname +"' lay-skin='primary' /></td>";
				}
			}
			str += "</tr>";
			qtbody.innerHTML = str;
		}
	});
}



</script>
    
</body>
</html>
