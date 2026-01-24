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
    
    <title>菜单列表</title>
    <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  </head>
  
 <body>
<blockquote class="layui-elem-quote news_search">	
<div class="demoTable">
 <div class="layui-inline">
    <input class="layui-input" name="id" id="demoReload" autocomplete="off" value=" 菜单名称：" onfocus="if(this.value == ' 菜单名称：'){ this.value = '';}" onblur="if(this.value =='') {this.value = ' 菜单名称：'}">
 </div>
  
  <button class="layui-btn" id="search" data-type="reload"><i class="layui-icon">&#xe615;</i>搜索</button> 
   <script type="text/html" id="toolbarDemo">
   <button type="button" class="layui-btn layui-btn-sm" lay-event="add"><i class="layui-icon layui-icon-add-1"></i>添 加</button>
   <button type="button" class="layui-btn layui-btn-sm" lay-event="update"><i class="layui-icon  layui-icon-edit"></i>修 改</button>
   <button type="button" class="layui-btn layui-btn-sm" lay-event="canel"><i class="layui-icon layui-icon-delete"></i>删 除</button>
   </script>
  </div>
 </blockquote>
<table class="layui-hide" id="followTable" lay-filter="followTable"></table> 
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>

</script>

 


<script>
var locat = (window.location+'').split('/'); 
$(function(){if('main'== locat[3]){locat =  locat[0]+'//'+locat[2];}else{locat =  locat[0]+'//'+locat[2]+'/'+locat[3];};});
layui.use('table', function(){
  var table = layui.table;
  
  //方法级渲染
  table.render({
    elem: '#followTable',
    toolbar: true,
    defaultToolbar: ['filter', 'exports', 'print'],
    url: '<c:url value="/getMenu.do"/>',
    method:'post',
    toolbar: '#toolbarDemo',
    cols: [[
      {field:'id',type:'radio',fixed:'left'},
      {field:'parentname', title: '主菜单名称', width:200, sort: true,align:"center"},
      {field:'menuname', title: '子菜单名称', width:250,align:"center"} ,    
      {field: 'url', title: 'URL', width:400,align:"center"} ,
      {field: 'orderno', title: '显示顺序', width: 100,align:"center"} ,
      {field: 'menutype', title: '菜单类型', width: 100, sort: true,align:"center",templet: function (item) {
          if (item.menutype == '1') {
                     return "<span style='color:green;'>主菜单</span>";
           } else if (item.menutype == '2') {
                     return "<span style='color:red;'>子菜单</span>";
            }  else {
                     return "";
             }
           }},
      
        {field: 'buttons', title: '按钮管理', width: 300,align:"center"} ,
        {field: 'memo', title: '备注', width: 100,align:"center"} ,
      {field: 'right', title: '操作', toolbar: '#barDemo',width: 115},
    ]],
    page: true,
    limit: 10
    });
    //搜索查询
  $("#search").click(function () {
			table.reload('followTable', {
				where: { // 设定异步数据接口的额外参数，任意设
					demoReload: $("#demoReload").val()			
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
   case 'add':
   var index = layui.layer.open({
				title : "添加菜单",
				type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
				content : "<c:url value="/jsp/basic/menu/add.jsp?menuid=${param.menuid }"/>",
				area: ['800', '800px'],
				maxmin: true,
				success : function(layero, index){
					setTimeout(function(){
						layui.layer.tips('点击此处返回文章列表', '.layui-layer-setwin .layui-layer-close', {
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
   var id=datas[0].parentid;
    var index = layui.layer.open({
				title : "修改主菜单",
				type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
				content : locat+'/getMenuupdate.do?id='+id+"&page=updateZhu&menuid="+${param.menuid },
				area: ['800', '800px'],
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
    
case 'canel':
   var data=JSON.stringify(checkStatus.data);
   var datas=JSON.parse(data);
    if(datas!=""){
   var id=datas[0].parentid;
    layer.confirm('确定删除此信息？', function(index){
        layer.close(index);
        $.getJSON(locat+"/cancelMenu.do?id="+id+"&menuid="+${param.menuid },{
			},function(data) {
			var str = eval('(' + data + ')');
        	 if (str.flag ==1) {		                          
		     top.layer.msg("数据删除成功！"); 	
		     table.reload('followTable', {    
		        });                 
		       }else{
			top.layer.msg("删除失败!");
		      }			      	    		
        	});      
		});
		}else{
			layer.alert("请先选择删除哪条数据！");
			}
    break;
   };
   
 });	
   //监听行工具事件
  table.on('tool(followTable)', function(obj){
    var id = obj.data.id;
    if(obj.event === 'del'){
      layer.confirm('确定删除此信息？', function(index){
        layer.close(index);
        $.getJSON(locat+"/cancelMenu.do?id="+id+"&menuid="+${param.menuid },{
			},function(data) {
			var str = eval('(' + data + ')');
        	 if (str.flag ==1) {		                          
		     top.layer.msg("数据删除成功！"); 	
		     table.reload('followTable', {    
		        });                 
		       }else{
			top.layer.msg("删除失败!");
		      }			      	    		
        	});      
		});
    } else if(obj.event === 'edit'){
     var index = layui.layer.open({
				title : "修改子菜单",
				type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
				content : locat+'/getMenuupdate.do?id='+id+"&page=update&menuid="+${param.menuid },
				area: ['800', '800px'],
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
