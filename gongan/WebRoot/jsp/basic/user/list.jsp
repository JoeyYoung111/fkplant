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
   <style>
	    .layui-form-checkbox {
		    position: relative;
		    height: 30px;
		    line-height: 30px;
		    margin-right: 10px;
		    padding-right: 30px;
		    cursor: pointer;
		    font-size: 0;
		    -webkit-transition: .1s linear;
		    transition: .1s linear;
		    box-sizing: border-box;
		    margin-top:20px;
		}
   		.layui-form-checkbox i {
		    margin-top: 5px;
		}
		.layui-form-checked span, .layui-form-checked:hover span {
		    background-color: #5FB878;
		}
	</style>
  </head>
 <body>
<blockquote class="layui-elem-quote news_search">	
<div class="demoTable">
 <form class="layui-form" method="post" style="display:inline;">
 	<div class="layui-inline">
    	<input class="layui-input" name="staffName" id="staffName" autocomplete="off" placeholder="用户姓名：">
 	</div>
     <div class="layui-inline" >
		<input type="text" id="departmentid" name="departmentid" lay-filter="departmentid" lay-verify="departmentid" class="layui-input"  value="0">
	  </div>
	  <div class="layui-inline">
	       <select name="roleid" id="roleid" lay-filter="roleid"></select>
	    </div>
	</form>
<button class="layui-btn" id="search" data-type="reload"><i class="layui-icon">&#xe615;</i>搜 索</button>
  <script type="text/html" id="toolbarButton">
   	<button type="button" class="layui-btn layui-btn-sm" lay-event="add"><i class="layui-icon">&#xe654;</i>添 加</button>
   	<button type="button" class="layui-btn layui-btn-sm" lay-event="update"><i class="layui-icon">&#xe642;</i>修 改</button>
   	<button type="button" class="layui-btn layui-btn-sm" lay-event="cancel"><i class="layui-icon">&#xe640;</i>删 除</button>
	<button type="button" class="layui-btn layui-btn-sm" lay-event="reset"><i class="layui-icon">&#xe673;</i>重置密码</button>
	<button type="button" class="layui-btn layui-btn-sm" lay-event="setroles"><i class="layui-icon layui-icon-username"></i>批量修改角色</button>
   <%-- <button type="button" class="layui-btn layui-btn-sm" lay-event="revStop"><i class="layui-icon">&#xe642;</i>暂停/开启</button>--%>
  </script> 
</div>
 </blockquote>
<table class="layui-hide" id="followTable" lay-filter="followTable"></table>
<script type="text/html" id="barButton">
 <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="showinfo">详情</a>       
</script>
<script>

$(document).ready(function(){
		$.ajax({
					type:		'POST',
					url:		'<c:url value="/getRoleJSON.do" />',
					dataType:	'json',
					async:   false,
					success:	function(data){					  
						var options = '<option value="0" >所属角色：</option>'+fillOption(data);
						$("select[name^=roleid]").html(options);
					}
				});
});
var locat = (window.location+'').split('/'); 
$(function(){if('main'== locat[3]){locat =  locat[0]+'//'+locat[2];}else{locat =  locat[0]+'//'+locat[2]+'/'+locat[3];};});
layui.config({
		    base: "<c:url value="/layui/lay/modules/"/>"
		}).extend({
		    treeSelect: "treeSelect"
		});
layui.use(['table','laydate','form','treeSelect'], function(){
  var table = layui.table;
  var laydate = layui.laydate;
  var layer = layui.layer;
  var form=layui.form;
  var treeSelect = layui.treeSelect;
  
   treeSelect.render({
		        elem: '#departmentid', // 选择器
		        data: '<c:url value="/getDepartmentTree.do"/>',// 数据
		        type: 'get', // 异步加载方式：get/post，默认get
		        placeholder: '所属部门：', // 占位符
		        search: true, // 是否开启搜索功能：true/false，默认false
		        // 一些可定制的样式
		        style: {
		            folder: {
		                enable: false
		            },
		            line: {
		                enable: true
		            }
		        },
		        // 点击回调
		        click: function(d){
		            //console.log($('#externalid').val());
		        },
		        // 加载完成后的回调函数
		        success: function (d) {
		          	var treeObj = treeSelect.zTree('departmentid');
		          	var newNode = {name:"全部部门",id:0};
			        treeObj.addNodes(null,0,newNode);
			        treeSelect.refresh('departmentid');
		        }
		    });
  
  
  //方法级渲染
  table.render({
    elem: '#followTable',
    toolbar: true,
    defaultToolbar: ['filter', 'exports', 'print'],
    url: '<c:url value="/getUser.do"/>',
    method:'post',
    toolbar: '#toolbarButton',
    cols: [[
        {field:'id',type:'checkbox',fixed:'true'},
        {field:'staffName', title: '用户姓名', width:150},
        {field:'usercode', title: '登录账号', width:150} ,
        {field:'sexes', title: '性别', width:150},
        {field:'contactnumber', title: '联系电话', width:150} ,
        {field:'alarmsignal', title: '警号', width:150} ,
		{field:'departname', title: '部门名称', width:200},		
		{field:'rolename', title: '角色名称', width:200},
	    {field:'addoperator', title: '添加人', width:100},
		{field:'addtime', title: '添加时间', width:180},
		{field:'memo', title: '备注信息', width:200}
		//{field: 'right', title: '操作', toolbar: '#barButton',width:65} 
    ]],
    page: true,
    limit: 10
    });
    form.render();
    	//搜索查询
  		$("#search").click(function () {
			table.reload('followTable', {
				where: { // 设定异步数据接口的额外参数，任意设
					departmentid:$("#departmentid").val(),	
					roleid:$("#roleid").val(),					
					staffName:$("#staffName").val()
				},
				page: {
					curr: 1
					// 重新从第 1 页开始
				}
			});
		});
		
		
		//监听行工具事件
		table.on('toolbar(followTable)', function(obj){
			var checkStatus =table.checkStatus(obj.config.id);
			switch(obj.event){
				case 'add':
			  		var index = layui.layer.open({
						title : "新增系统账号",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content : '<c:url value="/jsp/basic/user/add.jsp?menuid='+${param.menuid}+'"/>',
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
			   		break;
			   	case 'update':
			  		var data=JSON.stringify(checkStatus.data);
			  		var datas=JSON.parse(data);
					if(datas!=""){
					  	var id=datas[0].id;
					   	var index = layui.layer.open({
							title : "修改系统账号",
							type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
							content : locat+'/getUserUpdate.do?id='+id+'&menuid='+${param.menuid}+'&page=update',
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
					}else{
						layer.alert("请先选择修改哪条数据！");
					}
			   		break;
			   case 'cancel':
				  var data=JSON.stringify(checkStatus.data);
				  var datas=JSON.parse(data);
				  if(datas!=""){
					  	var id=datas[0].id;
						layer.confirm('确定删除此信息？', function(index){
					      layer.close(index);
					      $.getJSON(locat+"/cancelUser.do?id="+id+'&menuid='+${param.menuid},{},function(data) {
							 var str = eval('(' + data + ')');
					      	 if (str.flag ==1) {		                          
							     top.layer.msg("数据删除成功！"); 	
							     table.reload('followTable', {});                 
					       	 }else{
								 top.layer.msg("删除失败!");
					      	 }			      	    		
					      });      
						});
					}else{
						layer.alert("请先选择删除哪条数据！");
					}
					break;
		case 'revStop':
				  var data=JSON.stringify(checkStatus.data);
				  var datas=JSON.parse(data);
				  var flag=0;				
				  if(datas[0].validflag==1){
				  flag=1;
				   flags="暂停";
				  }else if(datas[0].validflag==2){
				  flag=2;
				   flags="启用";
				  }
				  if(datas!=""){
					  	var id=datas[0].id;
						layer.confirm('确定'+flags+'此信息？', function(index){
					      layer.close(index);
					      $.getJSON(locat+"/revStop.do?id="+id+'&menuid='+${param.menuid}+'&flag='+flag,{},function(data) {
							 var str = eval('(' + data + ')');
					      	 if (str.flag ==1) {		                          
							     top.layer.msg('数据'+flags+'成功！'); 	
							     table.reload('followTable', {});                 
					       	 }else{
								 top.layer.msg(flags+'失败!');
					      	 }			      	    		
					      });      
						});
					}else{
						layer.alert("请先选择操作哪条数据！");
					}			
			   		break;
			   	case 'reset':
			   		var data=JSON.stringify(checkStatus.data);
			  		var datas=JSON.parse(data);
					if(datas!=""){
					  	var id=datas[0].id;
					   	var index = layui.layer.open({
							title : "重置密码",
							type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
							content : '<c:url value="/jsp/basic/user/resetPWD.jsp?id='+id+'&menuid='+${param.menuid}+'"/>',
							area: ['600', '300'],
							maxmin: false,
							success : function(layero, index){
								setTimeout(function(){
									layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
										tips: 3
									});
								},500)
							}
						})			
						//layui.layer.full(index);
					}else{
						layer.alert("请先选择重置哪个账号的密码！");
					}
			   		break;	
			   	case 'setroles':
			   		var data=JSON.stringify(checkStatus.data);
			  		var datas=JSON.parse(data);
					if(datas!=""){
						var ids="";
			               for(var i=0;i<datas.length;i++){
			               		if(ids!="")ids+=",";
			               		ids+=datas[i].id;
			               }
						var index = layui.layer.open({
							 title : "选择目标角色",
							 type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
							 content : "<c:url value="/jsp/basic/user/setroles.jsp?menuid=${param.menuid }"/>&ids="+ids,
							  area: ['600', '600'],
							 maxmin: true,
							 offset:['100'], 
							cancel:function(){
								$("#search").click(); 
							}
						 });	
					}else{
						layer.alert("请先选择修改哪个账号的角色！");
					}
			   		break;	
			}
		});
	
		//监听行工具事件
	  table.on('tool(followTable)', function(obj){
		  var id = obj.data.id;
		  if(obj.event === 'showinfo'){
		   		var index = layui.layer.open({
					title : "系统账号详情",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content : locat+'/getUserUpdate.do?id='+id+'&menuid='+${param.menuid}+'&page=showinfo',
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