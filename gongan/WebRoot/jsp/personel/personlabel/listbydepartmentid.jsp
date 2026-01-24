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
    
    <title>人员类型配置</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" href="<c:url value="layui/css/layui.css"/>"/>
	<link rel="stylesheet" href="<c:url value="css/system.css"/>"/>
    <script type="text/javascript" src="<c:url value="js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="layui/layui.js"/>"></script>
    <style>
      .layui-tree-entry{position:relative;padding:3px 0;height:28px;white-space:nowrap}
       .juese {
	    width: 13%;
	    float: left;
	    border-right: solid 3px #EEEEEE;
	    margin-top: 10px;
     }
     .jsqx_cz {
		width: 86%;
		float: right;
		margin-top: 10px;
     }
    </style>
	</head>
  
  <body>
   <div class="juese jsqx">
	<div class="juese_title">人员一级标签</div>
<%--	<ul>--%>
<%--		<li><a href="javascript:editRole(1)"><i class="layui-icon" style="color:green;">&#xe654;</i>新增</a></li>--%>
<%--		<li><a href="javascript:editRole(2)"><i class="layui-icon" style="color:blue;">&#xe642;</i>修改</a></li>--%>
<%--		<li><a href="javascript:editRole(3)"><i class="layui-icon" style="color:red;">&#xe640;</i>删除</a></li>--%>
<%--	</ul>--%>
	<br><br>
	<div id="personlabel_tree" ></div>	
	<input type="hidden" class="layui-input" id="nodeid" value="0" autocomplete="off">
	<br>
</div>


<div class="jsqx_cz jsqx">
	<form class="layui-form" method="post" id="menuForm" >
		<div class="caozuoqx" style="width:74%;height:98%;">
			<div class="juese_title" id="menuList">人员二级标签</div>
			    <table class="layui-hide" id="followTable" lay-filter="followTable"></table> 
		    </div>
<%--		<div class="jueseyh"  style="width:25%;height:98%;border-left:solid 3px #EEEEEE;">	--%>
<%--			<div class="juese_title">--%>
<%--			<span id="userList">自定义工作标签</span>--%>
<%--			   <button type="button" onclick="addAttributelabels()" class="layui-btn layui-btn-normal" style="line-height:40px;float:right;margin-right:20px; background:none;">添加属性标签【+】</button>--%>
<%--			</div>--%>
<%--			<div class="qx_title" style="width:100%;height:86%;overflow:auto;" id="userShow">--%>
<%--				 <table class="layui-hide" id="followTable1" lay-filter="followTable1"></table>--%>
<%--			</div>--%>
<%--		</div>--%>
	</form>
</div>

    <script type="text/html" id="toolbarDemo">
		<button type="button" class="layui-btn layui-btn-sm" lay-event="add"><i class="layui-icon">&#xe654;</i>添 加</button>
        <button type="button" class="layui-btn layui-btn-sm" lay-event="examine"><i class="layui-icon layui-icon-username"></i>审核</button>
   	</script>
   	<script type="text/html" id="toolbarDemo1">
		<button type="button" class="layui-btn layui-btn-sm" lay-event="add"><i class="layui-icon">&#xe654;</i>添 加</button>
    </script>
    <script type="text/html" id="auth-state">
        <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit">改</a>
        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删</a>
    </script>
    <script>
    var personlabelList=[];
	var firstTitle;
    var locat = (window.location+'').split('/'); 
	$(function(){if('main'== locat[3]){locat =  locat[0]+'//'+locat[2];}else{locat =  locat[0]+'//'+locat[2]+'/'+locat[3];};});
	
	
    //查询一级标签
    function searchPersonLabel(){
		$.ajax({
			type:		'POST',
			url:		'<c:url value="/getAttributeLabelByDepartmentid.do" />',
			dataType:	'json',
			async:		false,
			success:	function(data){
				personlabelList=[];
				for(i=0;i<data.length;i++){
					if(i==0){
						$('#nodeid').val(data[i].id);
						firstTitle=data[i].attributelabel;
					}
					var aRole={title:data[i].id+"-"+data[i].attributelabel,id:data[i].id};
					personlabelList.push(aRole);
				}
			}
		});
	}
	//查询二级标签
    function getCustomLabelList(){
        var nodeid=$('#nodeid').val();
		var div=$("div[data-id="+nodeid+"]"); 
		$('#personlabel_tree').find('.layui-tree-entry').css('background','none');
		div.find('.layui-tree-entry').eq(0).css('background-color','#348FE2');
	    layui.treetable.render({
            treeColIndex: 1,
            treeSpid: 0,             //最上级的父级id
            treeIdName: 'id',    //id字段的名称
            treePidName: 'parentid', //父级节点字段
            treeDefaultClose: false,	//是否默认折叠
            treeLinkage: false,		//父级展开时是否自动展开所有子级
            elem: '#followTable',  //指定原始表格元素选择器，也可以使用id选择器
            //toolbar: true,
            toolbar: '#toolbarDemo',   //监听头部工具栏事件
    		url: '<c:url value="/getAttributeLabelTreeByparentid1.do"/>?parentid='+$('#nodeid').val()+"&examineflag=-1&isfilter=1",
            page: false,
            cols: [
            [
                {type: 'radio'},
                {field: 'attributelabel', width: 300, title: '属性标签'},
               
                {field: 'addoperator',align: 'center', title: '建档信息',width:180,templet: function (item) {
		              return item.addoperator+" "+item.addtime;
                 }},
                {field: 'addoperator',align: 'center', title: '审核信息',width:180,templet: function (item) {
		              return item.examineman+" "+item.examinetime;
                 }},
                {field: 'right', title: '操作',align: 'center', toolbar: '#auth-state',width: 90}
            ]
            ],
            
            //数据渲染完的回调
            done: function (res, curr, count) {
           		layer.closeAll('loading');
           		$("tbody").find("span[lay-tpid="+$('#nodeid').val()+"]").find(".layui-icon-triangle-d").click();
            }
        });
        
     }
	//获得自定义工作标签
	function getAttributelabels(){
	  var personlabelid=$("#nodeid").val();
		 layui.treetable.render({
            treeColIndex: 1,
            treeSpid: 0,             //最上级的父级id
            treeIdName: 'id',    //id字段的名称
            treePidName: 'parentid', //父级节点字段
            treeDefaultClose: false,	//是否默认折叠
            treeLinkage: false,		//父级展开时是否自动展开所有子级
            elem: '#followTable1',  //指定原始表格元素选择器，也可以使用id选择器
            toolbar: '#toolbarDemo1',   //监听头部工具栏事件
    		 url: '<c:url value="/getCustomLabelTreeTable.do"/>?personlabel='+$('#nodeid').val(),
            page: false,
            cols: [
            [
                {type: 'radio'},
                {field: 'customlabel',width:180, title: '自定义标签'},
                {field: 'labledescription', title: '标签描述'},
                {field: 'right', title: '操作', toolbar: '#auth-state',width: 90}
                //{templet: '#auth-state', width: 120, align: 'center', title: '操作'}
            ]
            ],
             //数据渲染完的回调
            done: function (res, curr, count) {
           		layer.closeAll('loading');
            }
        });
	}
	function deleteAttributelabels(attributelabelid,personlabelid){
		layer.confirm('确定删除此人员属性标签？', function(index){
	      layer.close(index);
	      $.getJSON(locat+"/deleteAttributelabels.do?id="+personlabelid+'&attributelabelid='+attributelabelid+'&menuid='+${param.menuid},{},function(data) {
	      	 $("#ru"+attributelabelid).remove();
	      	 $("#userNum").text(Number($("#userNum").text())-1);
			 var str = eval('(' + data + ')');
	      	 if (str.flag ==1) {		                          
			     top.layer.msg("人员属性标签删除成功！"); 	               
	       	 }else{
				 top.layer.msg("人员属性标签删除失败!");
	      	 }			      	    		
	      });      
		});
	}
	
	function addAttributelabels(){
		if($('#nodeid').val()){
			var id=$('#nodeid').val();
			var index = layui.layer.open({
				title : "添加人员属性标签",
				type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
				content : '<c:url value="/getPersonLabelByid.do?page=attributelabels&id='+id+'&menuid='+${param.menuid}+'"/>',
				area: ['800px', '800px'],
				maxmin: true,
				success : function(layero, index){
					setTimeout(function(){
						layui.layer.tips('点击此处返回', '.layui-layer-setwin .layui-layer-close', {
							tips: 3
						});
					},500)
				}
			});	
			layui.layer.full(index);
		}else{
			layer.alert("请先选择警种类型！");
		}
	}
	
	
	
	$(document).ready(function(){
		searchPersonLabel();//查询左侧一级标签
		setTimeout(function(){         
 			 var nodeid=$('#nodeid').val();//设置默认
		     var div=$("div[data-id="+nodeid+"]"); 
		     $('#personlabel_tree').find('.layui-tree-entry').css('background','none');
		     div.find('.layui-tree-entry').eq(0).css('background-color','#348FE2');
       	},200);
      
	}); 
    
      
		layui.config({
        base: "<c:url value="/layui/lay/modules/"/>"
    }).extend({
        treetable: 'treetable-lay/treetable'
    }).use(['layer','tree', 'table', 'treetable'], function(){
		  var $ = layui.jquery;
          var table = layui.table;
          var layer = layui.layer;
          var treetable = layui.treetable;
          var tree=layui.tree,form=layui.form;
          tree.render({
			elem:'#personlabel_tree',
	 		onlyIconControl:true,
	 		data:personlabelList,
	 		id:"roleTree",
			click:function(obj){
				firstTitle=obj.data.title;
             	$('#nodeid').val(obj.data.id);
	 			setTimeout(function(){ 
	 				   getCustomLabelList();//工作标签
	 				   getAttributelabels();// 属性标签
             	},200);
	 		},
	 		
		});
		 //搜索查询
	  $("#search").click(function () {
			searchMsg();
		}); 
		
		var selectnodeid=$('#nodeid').val();//设置默认
			if(selectnodeid==0){
			   selectnodeid=-1;
			}
	    
		//原始加载  二级标签
         treetable.render({
            treeColIndex: 1,
            treeSpid: 0,             //最上级的父级id
            treeIdName: 'id',    //id字段的名称
            treePidName: 'parentid', //父级节点字段
            treeDefaultClose: false,	//是否默认折叠
            treeLinkage: false,		//父级展开时是否自动展开所有子级
            elem: '#followTable',  //指定原始表格元素选择器，也可以使用id选择器
            //toolbar: true,
            toolbar: '#toolbarDemo',   //监听头部工具栏事件
    		 url: '<c:url value="/getAttributeLabelTreeByparentid1.do"/>?parentid='+selectnodeid+"&examineflag=-1&isfilter=1",
            page: false,
            cols: [
            [
                {type: 'radio'},
                {field: 'attributelabel', title: '属性标签'},
               
                {field: 'addoperator',align: 'center', title: '建档信息',width:180,templet: function (item) {
		              return item.addoperator+" "+item.addtime;
                 }},
                {field: 'addoperator',align: 'center', title: '审核信息',width:180,templet: function (item) {
		              return item.examineman+" "+item.examinetime;
                 }},
                {field: 'right', title: '操作',align: 'center', toolbar: '#auth-state',width: 90}
                //{templet: '#auth-state', width: 120, align: 'center', title: '操作'}
            ]
            ],
            
            //数据渲染完的回调
            done: function (res, curr, count) {
           		layer.closeAll('loading');
           		$("tbody").find("span[lay-tpid="+$('#nodeid').val()+"]").find(".layui-icon-triangle-d").click();
            }
        });
        
        
        //初始加载  自定义工作标签
        treetable.render({
            treeColIndex: 1,
            treeSpid: 0,             //最上级的父级id
            treeIdName: 'id',    //id字段的名称
            treePidName: 'parentid', //父级节点字段
            treeDefaultClose: false,	//是否默认折叠
            treeLinkage: false,		//父级展开时是否自动展开所有子级
            elem: '#followTable1',  //指定原始表格元素选择器，也可以使用id选择器
            toolbar: '#toolbarDemo1',   //监听头部工具栏事件
    		url: '<c:url value="/getCustomLabelTreeTable.do"/>?personlabel='+$('#nodeid').val(),
            page: false,
            cols: [
            [
                {type: 'radio'},
                {field: 'customlabel',width:180, title: '自定义标签'},
                {field: 'labledescription', title: '标签描述'},
                {field: 'right', title: '操作', toolbar: '#auth-state',width: 90}
                //{templet: '#auth-state', width: 120, align: 'center', title: '操作'}
            ]
            ],
             //数据渲染完的回调
            done: function (res, curr, count) {
           		layer.closeAll('loading');
            }
        });
        
        
        //二级标签  工具列点击事件
        table.on('tool(followTable)', function (obj) {
         	var id = obj.data.id;
    		var event = obj.event;
            if (event == 'del') {
                layer.confirm('确定删除此信息？', function(index){
				        layer.close(index);
				      $.getJSON(locat+"/cancelattributelabel.do?id="+id+"&menuid="+${param.menuid },{
							},function(data) {
							var str = eval('(' + data + ')');
				        	 if (str.flag ==1) {		                          
						         top.layer.msg("数据删除成功！"); 	
						         searchMsg();             
						       }else{
							       top.layer.msg("删除失败!");
							       searchMsg();                      
						      }			      	    		
				        });      
		         });
		    } else if (event == 'edit') {
                 var index = layui.layer.open({
						title : "修改人员二级标签",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content : locat+'/getAttributeLabelByid.do?id='+id+"&menuid="+${param.menuid },
						area: ['900', '500px'],
						maxmin: true,
						success : function(layero, index){
							setTimeout(function(){
								layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
									tips: 3
								});
							},500)
						}
					})	
			   }
            
        });
        
        
         //自定义工作标签 工具列点击事件
        table.on('tool(followTable1)', function (obj) {
         	var id = obj.data.id;
    		var event = obj.event;
            if (event == 'del') {
                layer.confirm('确定删除此信息？', function(index){
				        layer.close(index);
				     $.getJSON(locat+"/cancelcustomlabel.do?id="+id+"&menuid="+${param.menuid },{
							},function(data) {
							var str = eval('(' + data + ')');
				        	 if (str.flag ==1) {		                          
						         top.layer.msg("数据删除成功！"); 	
						         customlabel();             
						       }else{
							       top.layer.msg("删除失败!");
							       customlabel();                      
						      }			      	    		
				        });      
		         });
		    } else if (event == 'edit') {
                 var index = layui.layer.open({
						title : "修改自定义标签",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content : locat+'/getCustomLabelByid.do?id='+id+"&menuid="+${param.menuid },
						area: ['1000px', '600px'],
						maxmin: true,
						success : function(layero, index){
							setTimeout(function(){
								layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
									tips: 3
								});
							},500)
						}
					})	
			   }
            
        });
        
        
        // 二级标签    头部工具栏点击事件
        table.on('toolbar(followTable)', function (obj) {
    		  var  checkStatus =table.checkStatus(obj.config.id);
    		  var data=JSON.stringify(checkStatus.data);
  			  var datas=JSON.parse(data);
  			  console.log(datas)
			 if(obj.event == 'add'){
			   var parentid = datas.length==0? 0 : datas[0].id;  //是否是一级菜单
			   var parentlabel =datas.length==0? '无' : datas[0].attributelabel;//父节点标签标签
			   var personlabel=$('#nodeid').val();//人员类型标签
			   if(datas!=""){
				   var index = layui.layer.open({
						title : "添加人员二级标签",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content : '<c:url value="/jsp/personel/attributelabel/add.jsp?examineflag=1&menuid='+${param.menuid }+'&parentlabel='+parentlabel+'&parentid='+parentid+'"/>',
					    area: ['900', '500px'],
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
					top.layer.alert("请先选择标签上级！");
				}
             }
             if(obj.event == 'examine'){
			      var index = layui.layer.open({
					title : "二级标签审核",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content : '<c:url value="/jsp/personel/personlabel/checklist.jsp?isfilter=1&examineflag=1&menuid='+${param.menuid }+'&parentid='+$('#nodeid').val()+'"/>',
				    area: ['900', '500px'],
					maxmin: true,
					success : function(layero, index){
						setTimeout(function(){
							layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
								tips: 3
							});
						},500)
					}
				})	
            }   
        });
        
        
         // 自定义工作标签    头部工具栏点击事件
        table.on('toolbar(followTable1)', function (obj) {
    		  var  checkStatus =table.checkStatus(obj.config.id);
    		  var data=JSON.stringify(checkStatus.data);
  			  var datas=JSON.parse(data);
  			  console.log(datas)
			  if(obj.event == 'add'){
			   var parentid = datas.length==0? 0 : datas[0].id;  //是否是一级菜单
			   var parentlabel =datas.length==0? '无' : datas[0].customlabel;//父节点自动以标签
			   var personlabel=$('#nodeid').val();//人员类型标签
				var index = layui.layer.open({
					title : "添加工作自定义标签",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content : '<c:url value="/jsp/personel/customlabel/add.jsp?menuid='+${param.menuid }+'&parentlabel='+parentlabel+'&personlabel='+personlabel+'&parentid='+parentid+'"/>',
				    area: ['1000px', '600px'],
					maxmin: true,
					success : function(layero, index){
						setTimeout(function(){
							layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
								tips: 3
							});
						},500)
					}
				})	
			
            }
        });
        
        
        
        
   });
    // 重新加载二级标签
    function searchMsg(){
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
            toolbar: '#toolbarDemo',   //监听头部工具栏事件
    		url: '<c:url value="/getAttributeLabelTreeByparentid1.do"/>?parentid='+$('#nodeid').val()+"&examineflag=-1&isfilter=1",
            page: false,
            cols: [
            [
                {type: 'radio'},
                {field: 'attributelabel', title: '属性标签'},
               
                {field: 'addoperator',align: 'center', title: '建档人',width:90},
                {field: 'addtime', width: 170, align: 'center', title: '建档时间'},
                {field: 'examineman', align: 'center',title: '审核人',width:90},
                {field: 'examinetime', width: 170, align: 'center', title: '审核时间'},
                {field: 'right', title: '操作',align: 'center', toolbar: '#auth-state',width: 90}
                //{templet: '#auth-state', width: 120, align: 'center', title: '操作'}
            ]
            ],
            
            //数据渲染完的回调
            done: function (res, curr, count) {
           		layer.closeAll('loading');
           		$("tbody").find("span[lay-tpid="+$('#nodeid').val()+"]").find(".layui-icon-triangle-d").click();
            }
        });
        
     }
    function customlabel(){
      var nodeid=$('#nodeid').val();
      layui.treetable.render({
            treeColIndex: 1,
            treeSpid: 0,             //最上级的父级id
            treeIdName: 'id',    //id字段的名称
            treePidName: 'parentid', //父级节点字段
            treeDefaultClose: false,	//是否默认折叠
            treeLinkage: false,		//父级展开时是否自动展开所有子级
            elem: '#followTable1',  //指定原始表格元素选择器，也可以使用id选择器
            toolbar: '#toolbarDemo',   //监听头部工具栏事件
    		url: '<c:url value="/getCustomLabelTreeTable.do"/>?personlabel='+$('#nodeid').val(),
            page: false,
            cols: [
            [
                {type: 'radio'},
                {field: 'customlabel',width:180, title: '自定义标签'},
                {field: 'labledescription', title: '标签描述'},
                {field: 'right', title: '操作', toolbar: '#auth-state',width: 90}
                //{templet: '#auth-state', width: 120, align: 'center', title: '操作'}
            ]
            ],
             //数据渲染完的回调
            done: function (res, curr, count) {
           		layer.closeAll('loading');
            }
        });
    
    
    }
		 
		//添加人员一级标签
		 function editRole(index){
		 	switch(index){
		 		case 1:
		 		 var parentid =0;  //是否是一级菜单
			     var parentlabel ='无';
		 			var index = layui.layer.open({
						title : "添加人员属性标签",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content : '<c:url value="/jsp/personel/attributelabel/add.jsp?examineflag=1&menuid='+${param.menuid }+'&parentlabel='+parentlabel+'&parentid='+parentid+'"/>',
					    area: ['900', '500px'],
						maxmin: true,
						success : function(layero, index){
							setTimeout(function(){
								layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
									tips: 3
								});
							},500)
						}
				    })	
					break;
		 		case 2:
				 	var id=$('#nodeid').val();
		 			if(id!=0){
				     	 var index = layui.layer.open({
						title : "修改人员一级标签",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content : locat+'/getAttributeLabelByid.do?id='+id+"&menuid="+${param.menuid },
						area: ['900', '500px'],
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
						layer.alert("请先选择修改人员一级标签！");
					}
		 			break;
		 		case 3:
		 			 var id=$('#nodeid').val();
					 if(id!=0){
					     layer.confirm('确定删除此人员一级标签吗？', function(index){
						      layer.close(index);
						      $.getJSON(locat+"/cancelattributelabel.do?id="+id+'&menuid='+${param.menuid},{},function(data) {
								 var str = eval('(' + data + ')');
						      	 if (str.flag ==1) {		                          
								     top.layer.msg("数据删除成功！"); 	
								     location.reload();     
						       	 }else{
									 top.layer.msg("删除失败!");
						      	 }			      	    		
						      });      
							});
						
					}else{
						layer.alert("请先选择删除哪条数据字典！");
					}
		 			break;
		 	}
		 }
		 
		 
		 
	
		 
		</script>
  </body>
</html>
