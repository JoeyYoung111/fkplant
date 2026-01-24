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
     <title>系统部门</title>
    <base href="<%=basePath%>">
    
    <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
   <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  </head>
  
 <body>
<blockquote class="layui-elem-quote news_search">	
<div class="demoTable">
 <form class="layui-form" method="post" style="display:inline;">
 	<div class="layui-inline">
    	<input class="layui-input" name="demoReload" id="demoReload" autocomplete="off" value=" 部门名称：" onfocus="if(this.value == ' 部门名称：'){ this.value = '';}" onblur="if(this.value =='') {this.value = ' 部门名称：'}">
 	</div>
     <div class="layui-inline" >
			 	<select id="departtype"  name="departtype" style="width:170px;">
			 		<option value='0'>全部部门类别</option>
			 		<option value='1'>部门类别:总局</option>
			 		<option value='2'>部门类别:分局</option>
			 		<option value='3'>警种部门</option>
			 		<option value='4'>派出所</option>
			 		<option value='5'>政府部门</option>
			 		<option value='6'>其他</option>
			 	</select>
			</div>
	</form>
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
var treedata=[];
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
            treeDefaultClose: true,	//是否默认折叠
            treeLinkage: false,		//父级展开时是否自动展开所有子级
            elem: '#authTreeTable',  //指定原始表格元素选择器，也可以使用id选择器
            //toolbar: true,
            toolbar: '#toolbarDemo',   //监听头部工具栏事件
    		defaultToolbar: ['filter', 'exports', 'print'],
            //url: 'json/menus.json',
             url: '<c:url value="/getDepartmentTreeTable.do"/>?departtype=0',
            page: false,
            cols: [
            [
                {type: 'radio'},
                {field: 'departname', title: '部门名称',width: 300},
                {field: 'departcode', width: 150,title: '部门编码',templet: function (item) {
                		var treenode={departname:item.departname,parentid:item.parentid,departtype:item.departtype};
                		treedata.push(treenode);
                		return "<span>"+(item.departcode!=null?item.departcode:"")+"</span>";
		           }},
                {field: 'lingwuid', width: 200,title: '部门ID（领悟接口）'},
                 {field: 'departtype', title: '部门类型', width: 130,templet: function (item) {
					if (item.departtype == '1') {
	                     return "<span>总局</span>";
		           } else if (item.departtype == '2') {
	                     return "<span>分局</span>";
		           }else if (item.departtype == '3') {
	                     return "<span>警种部门</span>";
		           }else if (item.departtype == '4') {
	                     return "<span>派出所</span>";
		           }else if (item.departtype == '5') {
	                     return "<span>政府部门</span>";
		           }else if (item.departtype == '0') {
	                     return "<span>部门节点</span>";
		           }else if (item.departtype == '6') {
	                     return "<span>其他</span>";
		           }
		           }},	
                {field: 'addoperator',width: 130, title: '添加人'},
                {field: 'addtime', align: 'center', width: 150,title: '添加时间'},
                 {field: 'memo', align: 'center', width: 130,title: '备注'},
                {field: 'right', title: '操作', toolbar: '#auth-state'}
                //{templet: '#auth-state', width: 120, align: 'center', title: '操作'}
            ]
            ],
            
            //数据渲染完的回调
            done: function (res, curr, count) {
           		layer.closeAll('loading');
            }
        });
	//搜索查询
  		$("#search").click(function () {
  			var departname=($("#demoReload").val()==" 部门名称：")?"":$("#demoReload").val();
  			var treeSpid=0;//后续需添加根据后台查询上级
  			var parentid=10000000;
			var departtype=$("#departtype").val();
			$.each(treedata,function(index,item){
				if(departtype!=0){
					if(item.departtype==departtype){
						if(departname!=""&&item.departname.indexOf(departname)>-1){
							if(item.parentid<parentid)parentid=item.parentid;
						}else parentid=item.parentid;
					}
				}else{
					if(departname!=""&&item.departname.indexOf(departname)>-1){
						if(item.parentid<parentid)parentid=item.parentid;
					}
				}
			});
			if(parentid!=10000000)treeSpid=parentid;
			 treetable.render({
            treeColIndex: 1,
            treeSpid: treeSpid,             //最上级的父级id
            treeIdName: 'id',    //id字段的名称
            treePidName: 'parentid', //父级节点字段
            treeDefaultClose: false,	//是否默认折叠
            treeLinkage: false,		//父级展开时是否自动展开所有子级
            elem: '#authTreeTable',  //指定原始表格元素选择器，也可以使用id选择器
            //toolbar: true,
            toolbar: '#toolbarDemo',   //监听头部工具栏事件
    		defaultToolbar: ['filter', 'exports', 'print'],
            //url: 'json/menus.json',
             url: '<c:url value="/getDepartmentTreeTable.do"/>?departtype='+$("#departtype").val()+"&departname="+departname,
            page: false,
            cols: [
            [
                {type: 'radio'},
                {field: 'departname', title: '部门名称',width: 300},
                {field: 'departcode', width: 130,title: '部门编码'},
                {field: 'lingwuid', width: 200,title: '部门ID（领悟接口）'},
                {field: 'departtype', title: '部门类型', width: 130,templet: function (item) {
		          if (item.departtype == '1') {
	                     return "<span>总局</span>";
		           } else if (item.departtype == '2') {
	                     return "<span>分局</span>";
		           }else if (item.departtype == '3') {
	                     return "<span>警种部门</span>";
		           }else if (item.departtype == '4') {
	                     return "<span>派出所</span>";
		           }else if (item.departtype == '5') {
	                     return "<span>政府部门</span>";
		           }else if (item.departtype == '0') {
	                     return "<span>政府节点</span>";
		           }else if (item.departtype == '6') {
	                     return "<span>其他</span>";
		           }
		           }},	
                {field: 'addoperator', width: 130,title: '添加人'},
                {field: 'addtime', align: 'center',width: 150, title: '添加时间'},
                {field: 'memo', align: 'center',width: 130, title: '备注'},
                {field: 'right', title: '操作', toolbar: '#auth-state'}
                //{templet: '#auth-state', width: 120, align: 'center', title: '操作'}
            ]
            ],
            
            //数据渲染完的回调
            done: function (res, curr, count) {
           		layer.closeAll('loading');
            }
        });
			
		});

	// 工具列点击事件
        table.on('tool(authTreeTable)', function (obj) {
         	var id = obj.data.id;
    		var event = obj.event;
            if (event === 'del') {
                layer.confirm('确定删除此信息？', function(index){
				        layer.close(index);
				     $.getJSON(locat+"/cancelDepartment.do?id="+id+"&menuid="+${param.menuid },{
							},function(data) {
							var str = eval('(' + data + ')');
				        	 if (str.flag ==1) {		                          
						        top.layer.msg("数据删除成功！"); 	
						         $("#search").click();             
						       }else{
							    top.layer.msg("删除失败!");
							     
						      }			      	    		
				        });      
		         });
		         
		         		
            } else if (event === 'edit') {
                 var index = layui.layer.open({
						title : "修改菜单",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content : locat+'/getDepartmentUpdate.do?page=update&id='+id+"&menuid="+${param.menuid },
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
			 if(obj.event === 'add'){
			   var parentid = datas.length==0? 0 : datas[0].id;  //是否是一级菜单
			 
			  
				var index = layui.layer.open({
					title : "添加菜单",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content : '<c:url value="/jsp/basic/department/add.jsp?menuid='+${param.menuid }+'&parentid='+parentid+'"/>',
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
