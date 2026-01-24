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
     <title>Layui树形表格treetable</title>
    <base href="<%=basePath%>">
    
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
	 <button class="layui-btn layui-btn-sm" lay-event="add"><i class="layui-icon">&#xe654;</i>新增</button>
   </script>
 </div>
</blockquote>

<table id="authTreeTable" class="layui-hide" lay-filter="authTreeTable"></table> 
<script type="text/html" id="auth-state">
    <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>

</script>


<script>
var locat = (window.location+'').split('/'); 
$(function(){if('main'== locat[3]){locat =  locat[0]+'//'+locat[2];}else{locat =  locat[0]+'//'+locat[2]+'/'+locat[3];};});
layui.config({
       base: "<c:url value="/layui/lay/modules/"/>"
    }).extend({
        treetable: 'treetable-lay/treetable'
    }).use(['layer', 'table', 'treetable'], function () {
        var $ = layui.jquery;
        var table = layui.table;
        var layer = layui.layer;
        var treetable = layui.treetable;

        // 渲染表格
        layer.load(2);
        treetable.render({
            treeColIndex: 1,
            treeSpid: 0,             //最上级的父级id
            treeIdName: 'id',    //id字段的名称
            treePidName: 'parentid', //父级节点字段
            treeDefaultClose: false,	//是否默认折叠
            treeLinkage: false,		//父级展开时是否自动展开所有子级
            elem: '#authTreeTable',  //指定原始表格元素选择器，也可以使用id选择器
            //toolbar: true,
            toolbar: '#toolbarDemo',   //监听头部工具栏事件
    		defaultToolbar: ['filter', 'exports', 'print'],
            //url: 'json/menus.json',
             url: '<c:url value="/getMenuTreeTable.do"/>',
            page: false,
            cols: [
            [
                {type: 'radio'},
                {field: 'menuname', minWidth: 100, title: '菜单名称'},
                {field: 'url', title: '菜单url'},
                {field: 'buttons', title: '菜单按钮'},
                {field: 'orderno', width: 80, align: 'center', title: '排序号'},
                {field: 'right', title: '操作', toolbar: '#auth-state',width: 115}
                //{templet: '#auth-state', width: 120, align: 'center', title: '操作'}
            ]
            ],
            
            //数据渲染完的回调
            done: function (res, curr, count) {
           		layer.closeAll('loading');
           		$("tbody").find(".layui-icon-triangle-d").click();
            }
        });


	// 工具列点击事件
        table.on('tool(authTreeTable)', function (obj) {
         	var id = obj.data.id;
    		var event = obj.event;
            if (event === 'del') {
                top.layer.confirm('确定删除此信息？', function(index){
				        layer.close(index);
				     $.getJSON(locat+"/cancelMenu.do?id="+id+"&menuid="+${param.menuid },{
							},function(data) {
							var str = eval('(' + data + ')');
				        	 if (str.flag ==1) {		                          
						           top.layer.msg("数据删除成功！"); 	
						           location.reload();          
						       }else{
								    top.layer.msg("删除失败!");
								 
						      }			      	    		
				        });      
		         });
		         
		         		
            } else if (event === 'edit') {
                 var index = layui.layer.open({
						title : "修改菜单",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content : locat+'/getMenuUpdate.do?page=menutree&id='+id+"&menuid="+${param.menuid },
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

        // 头部工具栏点击事件
        table.on('toolbar(authTreeTable)', function (obj) {
    		//var checkStatus = table.checkStatus('authTreeTable');
    		  var  checkStatus =table.checkStatus(obj.config.id);
    		 // alert("obj.event  ="+obj.event);
    		   var data=JSON.stringify(checkStatus.data);
  			  var datas=JSON.parse(data);
  			  console.log(datas)
			 if(obj.event === 'add'){
			   var parentid = datas.length==0? 0 : datas[0].id;  //是否是一级菜单
			   var menuname =datas.length==0? '无' : datas[0].menuname;
			  
				var index = layui.layer.open({
					title : "添加菜单",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					//content : '<c:url value="/jsp/basic/menutree/add.jsp?menuid='+${param.menuid }+'&menuname='+menuname+'&parentid='+parentid+'"/>',
					content : '<c:url value="/getMenuAdd.do?menuid='+${param.menuid }+'&menuname='+menuname+'&parentid='+parentid+'"/>',
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
