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

	<title>批注签收页面</title>
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
	<script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/js/jquery.form.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
	
</head>
  
<body>
	<form class="layui-form" method="post" id="form_pzqs" onsubmit="return false;">
		<fieldset class="layui-elem-field layui-field-title" style="margin-top: 15px;">
			<legend>源头批注</legend>
		</fieldset>
		<button type="button" style="display:none" id="searchtable">(不显示)</button>
		<input type="hidden" id="sendid" name="sendid" value="${param.id}"/>
		<input type="hidden" id="informationid" name="informationid" value="${param.informationid}"/>

		<div class="layui-form-item">
			<table class="layui-hide" id="pzTable" lay-filter="pzTable"></table>
			<script type="text/html" id="PZ">
				{{#  if(d.validflag ==1){  }}
				<a class="layui-btn layui-btn-xs" lay-event="PZQS">签收</a>
				{{# }else{  }} {{# }  }}
			</script>
		</div>
	</form>
    
<script type="text/javascript">

var locat = (window.location+'').split("/");
$(function(){
	if('main'==locat[3]){locat = locat[0]+'//'+locat[2];}else{locat = locat[0]+'//'+locat[2]+'/'+locat[3];};
});

$(document).ready(function(){
	$("#searchtable").click();
});

layui.use(['form','table'],function(){
	var form = layui.form;
	var layer = layui.layer;
	var table = layui.table;
	
	table.render({
		elem:'#pzTable',
		toolbar:false,
		url:'<c:url value="/searchAnnotation.do"/>?annotationtype=1&sendid='+$("#sendid").val()+"&informationid="+$("#informationid").val(),
		method:'post',
		toolbar:'',
		cols: [[
		        {field:'id',hide:true,title:'id'},
		        {field:'zizeng',type:'numbers',fixed:'left'},
		        {field:'content',title:'批注内容',width:700,align:"center"},
		        {field:'validflag',title:'签收状态',width:100,align:"center",
		        	templet: function(d){
		        		if(d.validflag == 1){
		        			return '<span>未签收</span>';
		        		}
		        		if(d.validflag == 2){
		        			return '<span>已签收</span>';
		        		}
		        	}
		        },
		        {field:'right',title:'操作',toolbar:"#PZ",width:100,align:"center"}
		]],
		page:true,
		limit:10
	});
	
	table.on('tool(pzTable)',function(obj){
		var id = obj.data.id;
		var validflag = obj.data.validflag;
		
		if(obj.event == 'PZQS' && validflag == 1){
			$.getJSON(locat+"/qianshouInfoAnnotation.do?id="+id,{},function(data){
				var str = eval('('+data+')');
				if(str.flag ==1){
					top.layer.msg("签收成功");
					table.reload('pzTable',{});
				}else{
					top.layer.msg("签收失败");
				}
			});
		}
	});
	
	$("#searchtable").click(function(){
		table.reload('pzTable',{});
	});
	
	form.render();
	
});



    
</script>

</body>
</html>
