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
    
    <title>数据字典配置</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" href="<c:url value="layui/css/layui.css"/>"/>
	<link rel="stylesheet" href="<c:url value="css/system.css"/>"/>
    <script type="text/javascript" src="<c:url value="js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="layui/layui.js"/>"></script>
	</head>
  
  <body>
    <%--<div class="sjzd">
	    <div class="juese_title">基础数据类型</div>
	    <br>
	    <div id="st_tree"></div>	
    </div> --%>
    <div class="juese jsqx">
	<div class="juese_title">数据字典配置</div>
	<ul>
		<li><a href="javascript:editRole(1)"><i class="layui-icon" style="color:green;">&#xe654;</i>新增</a></li>
		<li><a href="javascript:editRole(2)"><i class="layui-icon" style="color:blue;">&#xe642;</i>修改</a></li>
		<li><a href="javascript:editRole(3)"><i class="layui-icon" style="color:red;">&#xe640;</i>删除</a></li>
	</ul>
	<br><br>
	<div id="st_tree"></div>	
	<input type="hidden" class="layui-input" id="nodeid" value="0" autocomplete="off">
	<input type="hidden" class="layui-input" id="nodetitle" value="无" autocomplete="off">
	<input type="hidden" class="layui-input" id="nodeistree" value="无" autocomplete="off" value="0">
	<br>
	
</div>
    <div class="sjzdlist">
    	<div class="demoTable" style="margin-bottom:8px;">
		  <div class="layui-inline">
		    <input class="layui-input" name="id" id="demoReload" autocomplete="off" placeholder="名称：">
		  </div>
		  <button class="layui-btn" id="search" data-type="reload"><i class="layui-icon">&#xe615;</i>搜 索</button>
		</div>
		<script type="text/html" id="sjzdpz">
			<button type="button" class="layui-btn layui-btn-sm" lay-event="add"><i class="layui-icon">&#xe654;</i>添 加</button>
   		
		</script>
		<table class="layui-hide" id="followTable" lay-filter="followTable"></table> 
		<script type="text/html" id="auth-state">
           <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit">编辑</a>
          <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
      </script>
    </div>
    <div class="clear"></div>
    <script>
		var locat = (window.location+'').split('/'); 
		$(function(){if('main'== locat[3]){locat =  locat[0]+'//'+locat[2];}else{locat =  locat[0]+'//'+locat[2]+'/'+locat[3];};});
		layui.config({
        base: "<c:url value="/layui/lay/modules/"/>"
    }).extend({
        treetable: 'treetable-lay/treetable'
    }).use(['layer', 'table', 'treetable'], function(){
		  var $ = layui.jquery;
          var table = layui.table;
          var layer = layui.layer;
          var treetable = layui.treetable;
		  
		  //方法级渲染
		  table.render({
		    elem: '#followTable',
		    toolbar: true,
		    defaultToolbar: ['filter', 'exports', 'print'],
		    url: '<c:url value="/getBasicMsg.do"/>'+'?basicType=0',
		    method:'post',
		    toolbar: '#sjzdpz',
		    cols: [[
		      {field:'id',type:'radio',fixed:'true'},
		      {field:'basicName', title: '数据名称', width:250,templet: function (item) {
		         	var  pstr="";
				 	if (item.parentid !=0)pstr+="（"+item.parentName+"）";
					return "<span>"+item.basicName+pstr+"</span>";
		           }} ,		      
		       {field:'addoperator', title: '添加人', width:160} ,
		       {field:'addtime', title: '添加时间', width:240, sort: true} ,
		        {field:'memo', title: '备注', width:200} ,
		        {field:'sort', title: '排序', width:80,align:'center'} ,
                {field: 'right', title: '操作', toolbar: '#auth-state'}
		    ]],
		    page: true,
		    limit: 10
		   });
			    //搜索查询
			  $("#search").click(function () {
					var nodeistree=$("#nodeistree").val();
					if(nodeistree=="0"){
					   searchMsg();
					}else{
					  searchMsg1();
					}
				});
				
			   //监听行工具事件
			  table.on('toolbar(followTable)', function(obj){
				    var checkStatus =table.checkStatus(obj.config.id);
				    if(obj.event === 'add'){
				    	var id=$('#nodeid').val();
				    	if(id==0){
				    		layer.alert("请先在目录树中选择字典类型！");
				    	}else{
				    	  var istree=$('#nodeistree').val();
				    	  if(istree==0){
				    	  	var index = layui.layer.open({
								title : "添加数据",
								type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
								content : locat+'/getBasicMsgUpdate.do?page=add&id='+id+'&menuid='+${param.menuid},
								area: ['800', '800px'],
								maxmin: true,
								success : function(layero, index){
									setTimeout(function(){
										layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
											tips: 3
										});
									},500)
								}
							});	
							  layui.layer.full(index);		
				    	  }else{
				    	     var  checkStatus =table.checkStatus(obj.config.id);  
				    	     var data=JSON.stringify(checkStatus.data);
  			                 var datas=JSON.parse(data);
  			                 console.log(datas) 
				    	     var parentid = datas.length==0? 0 : datas[0].id;  //是否是一级菜单
				    	     var basicType=$("#nodeid").val();
				    	 	 var index = layui.layer.open({
								title : "添加数据",
								type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
								//content : locat+'/getBasicMsgUpdate.do?page=add&id='+id+'&menuid='+${param.menuid},
								content : locat+'/jsp/basic/msg/addMsgNode.jsp?basicType='+basicType+'&menuid='+${param.menuid}+"&parentid="+parentid,
								area: ['800', '800px'],
								maxmin: true,
								success : function(layero, index){
									setTimeout(function(){
										layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
											tips: 3
										});
									},500)
								}
							});	
							  layui.layer.full(index);		
				    	  }
				    	
				    	}
				    } 
			  }); 
			  	// 工具列点击事件---树状结构操作按钮
         table.on('tool(followTable)', function (obj) {
         	var id = obj.data.id;
    		var event = obj.event;
            if (event === 'del') {
                layer.confirm('确定删除此信息？', function(index){
				        layer.close(index);
				        $.getJSON(locat+"/cancelBasicMsg.do?id="+id+'&menuid='+${param.menuid},{},function(data) {
							},function(data) {
							var str = eval('(' + data + ')');
				        	 if (str.flag ==1) {		                          
						        top.layer.msg("数据删除成功！"); 	
						        //searchMsg1();
						       }else{
							    top.layer.msg("删除失败!");
							   //searchMsg1();         
						      }			      	    		
				        });      
		         });
		         		
            } else if (event === 'edit') {
               var url="";
                var nodeistree=$("#nodeistree").val();
               if(nodeistree=="0"){
					 url=locat+'/getBasicMsgUpdate.do?page=update&id='+id+'&menuid='+${param.menuid};
					}else{
					  url=locat+'/getBasicMsgUpdate.do?page=updateMsgNode&id='+id+'&menuid='+${param.menuid};
					}
                 var index = layui.layer.open({
						title : "修改数据",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content : url,
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
		 
		 $(document).ready(function(){
		      getTypeTree();
		 });
		 var nodedata;
		 function getTypeTree(){
		 	$.ajax({
				type:		'POST',
				url:		'<c:url value="/getBasicTypeTree1.do"/>',
				dataType:	'json',
				async:      false,
				success:	function(data){
					 layui.use(['tree'], function(){
					 	var tree=layui.tree;
					 	tree.render({
					 		elem:'#st_tree',
					 		onlyIconControl:true,
					 		data:data,
					 		type: 'get',
					 		click:function(obj){
					 			$(this.elem).find('.layui-tree-entry').css('background','none');
					 			obj.elem.find('.layui-tree-entry').eq(0).css('background-color','#348FE2');
					 			$('#nodeid').val(obj.data.id);
					 			$('#nodetitle').val(obj.data.title);
					 			$('#nodeistree').val(obj.data.istree);
					 			nodedata=obj.data;
					 		 if(obj.data.istree=="0"){
					 		     searchMsg();//表格查询
					 		  }else{
					 		    searchMsg1();//树状查询
					 		  }
					 			
					 		},
					 		id:'typeTree'
					 	});
					 });
				}
			});
		 }
		 //添加节点
		 function editRole(index){
		 	switch(index){
		 		case 1:
		 			var index = layui.layer.open({
						title : "添加数据字典",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content : '<c:url value="/jsp/basic/msg/addNode.jsp"/>?menuid='+${param.menuid},
						area: ['800', '800px'],
						maxmin: true,
						success : function(layero, index){
							setTimeout(function(){
								layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
									tips: 3
								});
							},500)
						}
					});	
					layui.layer.full(index);
		 			break;
		 		case 2:
				 	var id=$('#nodeid').val();
		 			if(id!=0){
				     	var index = layui.layer.open({
							title : "修改数据",
							type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
							content : locat+'/getBasicTypeUpdate.do?id='+id+'&menuid='+${param.menuid},
							area: ['800', '800px'],
							maxmin: true,
							success : function(layero, index){
								setTimeout(function(){
									layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
										tips: 3
									});
								},500)
							}
						});			
						layui.layer.full(index);
					}else{
						layer.alert("请先选择修改哪条数据字典！");
					}
		 			break;
		 		case 3:
		 			 var id=$('#nodeid').val();
					 if(id!=0){
						if(nodedata.children){
							layer.alert("请先删除子节点数据字典！");
						}else{
							layer.confirm('确定删除此数据字典及其数据？', function(index){
						      layer.close(index);
						      $.getJSON(locat+"/cancelBasicType.do?id="+id+'&menuid='+${param.menuid},{},function(data) {
								 var str = eval('(' + data + ')');
						      	 if (str.flag ==1) {		                          
								     top.layer.msg("数据删除成功！"); 	
								     getTypeTree();
		 		         			 searchMsg();              
						       	 }else{
									 top.layer.msg("删除失败!");
						      	 }			      	    		
						      });      
							});
						}
					}else{
						layer.alert("请先选择删除哪条数据字典！");
					}
		 			break;
		 	}
		 }
		 
		 
		 
		 function searchMsg(){
		 	var nodeid=$('#nodeid').val();
		 	 //方法级渲染
		  layui.table.render({
		    elem: '#followTable',
		    toolbar: true,
		    defaultToolbar: ['filter', 'exports', 'print'],
		    url: '<c:url value="/getBasicMsg.do"/>'+'?basicType='+nodeid+"&basicName="+$("#demoReload").val(),
		    method:'post',
		    toolbar: '#sjzdpz',
		    cols: [[
		      {field:'id',type:'radio',fixed:'true'},
		      {field:'basicName', title: '数据名称', width:250,templet: function (item) {
		         	var  pstr="";
				 	if (item.parentid !=0)pstr+="（"+item.parentName+"）";
					return "<span>"+item.basicName+pstr+"</span>";
		           }} ,		      
		      
		       {field:'addoperator', title: '添加人', width:160} ,
		       {field:'addtime', title: '添加时间', width:240, sort: true} ,
		        {field:'memo', title: '备注', width:200} ,
		        {field:'sort', title: '排序', width:80,align:'center'} ,
                {field: 'right', title: '操作', toolbar: '#auth-state'}
		    ]],
		    page: true,
		    limit: 10
		   });
		 }
		 
		 function searchMsg1(){
		 	var nodeid=$('#nodeid').val();
		 	 layui.treetable.render({
            treeColIndex: 1,
            treeSpid: 0,             //最上级的父级id
            treeIdName: 'id',    //id字段的名称
            treePidName: 'parentid', //父级节点字段
            treeDefaultClose: false,	//是否默认折叠
            treeLinkage: false,		//父级展开时是否自动展开所有子级
            elem: '#followTable',  //指定原始表格元素选择器，也可以使用id选择器
            //toolbar: true,
            toolbar: '#sjzdpz',   //监听头部工具栏事件
    		defaultToolbar: ['filter', 'exports', 'print'],
            //url: 'json/menus.json',
             url: '<c:url value="/getBasicMsgTreeTable.do"/>?basicType='+nodeid,
            page: false,
            cols: [
            [
                 {type: 'radio'},
                 {field: 'basicName', minWidth: 100, title: '数据名称'},
                 {field: 'addoperator', title: '添加人'},
                 {field: 'addtime', title: '添加时间'},
                 {field: 'memo', title: '备注'},
                 {field:'sort', title: '排序', width:80,align:'center'} ,
                 {field: 'right', title: '操作', toolbar: '#auth-state'}
            ]
            ],
            //数据渲染完的回调
            done: function (res, curr, count) {
           		layer.closeAll('loading');
            }
        });
     }
		 
		 
		</script>
  </body>
</html>
