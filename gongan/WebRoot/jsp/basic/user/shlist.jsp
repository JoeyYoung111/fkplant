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
    <title>系统账号管理</title>
    <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  </head>
 <body>
<blockquote class="layui-elem-quote news_search">	
<div class="demoTable">
<form class="layui-form" method="post" style="display:inline;">
	<div class="layui-inline">
		<select name="typeid" id="typeid" lay-filter="test">   
      <option value="0">全部</option>
      <option value="1">融资企业</option>
      <option value="2">政府</option>
	  <option value="3">乡镇</option>  
	  <option value="4">金融机构</option> 
	  <option value="5">上市企业</option>  
	  <option value="6">券商</option>     
      </select> 
	</div>
	<div class="layui-inline">
	   <input class="layui-input" name="id" id="demoReload2" autocomplete="off" value=" 人员姓名：" onfocus="if(this.value == ' 人员姓名：'){ this.value = '';}" onblur="if(this.value =='') {this.value = ' 人员姓名：'}">
	</div>
</form>
  <button class="layui-btn" id="search" data-type="reload"><i class="layui-icon">&#xe615;</i>搜 索</button>
  <script type="text/html" id="toolbarButton">
   <button type="button" class="layui-btn layui-btn-sm" lay-event="shenhe"><i class="layui-icon">&#xe672;</i>审 核</button>
   </script>
</div>
 </blockquote>
<table class="layui-hide" id="followTable" lay-filter="followTable"></table>
<script type="text/html" id="barButton">
 <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="showinfo">详情</a>       
</script>
<script>
function getDepartmentList(){
	$.ajax({
		type:		'POST',
		url:		'<c:url value="/getBMByTypeToJSON.do?basicType=1" />',
		dataType:	'json',
		async:      false,
		success:	function(data){
			var options = '<option value="0">全部部门</option>'+fillOption(data);
			$("#departmentList").html(options);
		}
	});
}
function getTownshipList(){
	$.ajax({
		type:		'POST',
		url:		'<c:url value="/getBMByTypeToJSON.do?basicType=6" />',
		dataType:	'json',
		async:      false,
		success:	function(data){
			var options = '<option value="0">全部乡镇</option>'+fillOption(data);
			$("#townshipList").html(options);
		}
	});
}
$(document).ready(function(){
	getDepartmentList();
	getTownshipList()
});
var locat = (window.location+'').split('/'); 
$(function(){if('main'== locat[3]){locat =  locat[0]+'//'+locat[2];}else{locat =  locat[0]+'//'+locat[2]+'/'+locat[3];};});
layui.use(['table','laydate','form'], function(){
  var table = layui.table;
  var laydate = layui.laydate;
  var layer = layui.layer;
  var form=layui.form;
  form.render();
  //方法级渲染
  table.render({
    elem: '#followTable',
    toolbar: true,
    defaultToolbar: ['filter', 'exports', 'print'],
    url: '<c:url value="/getUser.do"/>?examineid='+1,
    method:'post',
    toolbar: '#toolbarButton',
    cols: [[
        {field:'id',type:'radio',fixed:'true'},
        {field:'staffName', title: '用户姓名', width:200},
        {field:'usercode', title: '登录账号', width:150} ,
        {field: 'typeid', title: '用户类型', width: 100,templet: function (item) {
		          if (item.typeid == '1') {
	                     return "<span>融资企业</span>";
		           } else if (item.typeid == '2') {
	                     return "<span>政府</span>";
		           }else if (item.typeid == '3') {
	                     return "<span>乡镇</span>";
		           }else if (item.typeid == '4') {
	                     return "<span>金融机构</span>";
		           }else if (item.typeid == '5') {
	                     return "<span>上市企业</span>";
		           }else if (item.typeid == '6') {
	                     return "<span>券商</span>";
		           }
		           }},	
		{field:'dpName', title: '部门名称', width:200},		
		{field: 'examineid', title: '审核状态', width: 130, sort: true,templet: function (item) {
		          if (item.examineid == '1') {
	                     return "<span style='color:blue;'>未审核</span>";
		           } else if (item.examineid == '2') {
	                     return "<span style='color:green;'>审核通过</span>";
		           }else if (item.examineid == '3') {
	                     return "<span style='color:red;'>不通过</span>";
		           }
		           }},
		{field:'addoperator', title: '添加人', width:100},
		{field:'addtime', title: '添加时间', width:180},
		{field:'reason', title: '不通过理由', width:200},
		{field:'memo', title: '备注信息', width:200},
		{field: 'right', title: '操作', toolbar: '#barButton',width:65} 
    ]],
    page: true,
    limit: 10
    });
    
    	//搜索查询
  		$("#search").click(function () {
			table.reload('followTable', {
				where: { // 设定异步数据接口的额外参数，任意设
					typeid:$("#typeid").val(),					
					staffName:($("#demoReload2").val()==" 人员姓名：")?"":$("#demoReload2").val()
				},
				page: {
					curr: 1
					// 重新从第 1 页开始
				}
			});
		});
		
		
		 //监听行工具事件
  table.on('toolbar(followTable)', function(obj){
    var  checkStatus =table.checkStatus(obj.config.id);
   switch(obj.event){
    case 'shenhe':
   var data=JSON.stringify(checkStatus.data);
   var datas=JSON.parse(data);  
   if(datas!=""){
   var id=datas[0].id;
    var index = layui.layer.open({
				title : "用户审核",
				type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
				content : "<c:url value="/jsp/basic/user/shenhe.jsp"/>?menuid="+${param.menuid }+"&id="+id,
				area: ['800', '500px'],
				maxmin: true,
				success : function(layero, index){
					setTimeout(function(){
						layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
							tips: 3
						});
					},500)
				}
			})				
			}else{
			layer.alert("请先选择审核哪个产品！");
			}
    break;
   };
   
 });	
	
		//监听行工具事件
	  table.on('tool(followTable)', function(obj){
		  var id = obj.data.id;
		  var url="";
		  if(obj.data.typeid==1){
		     url=locat+'/getUserUpdate.do?id='+id+'&menuid=0&unitid=0&page=showBusinessMsg';
		  }else if(obj.data.typeid==8){
		     url= locat+'/getSSBusinessById.do?id='+obj.data.departmentid+"&page=showinfo&menuid=0";
		  }
		  if(obj.event === 'showinfo'){
		   		var index = layui.layer.open({
					title : "注册企业详情",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content : url,
					area: ['800', '600px'],
					maxmin: true,
					success : function(layero, index){
						setTimeout(function(){
							layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
								tips: 3
							});
						},500)
					}
				})			
				layui.layer.full(index);
		    }
    	});
 });
</script> 
</body>

</html>