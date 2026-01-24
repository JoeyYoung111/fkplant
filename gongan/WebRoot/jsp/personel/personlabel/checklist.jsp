
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

<table id="followTable" class="layui-hide" lay-filter="followTable"></table> 
<script type="text/html" id="auth-state">
    
    {{#  if(d.examineflag ==0){  }}
		<a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="examine">审核</a>
	{{# }else{  }} {{# }  }}
</script>
<script type="text/html" id="toolbarDemo1">
   <button type="button" class="layui-btn layui-btn-sm" lay-event="add"><i class="layui-icon">&#xe654;</i>添 加</button>
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
    		 url: '<c:url value="/getAttributeLabelTreeByparentid1.do"/>?parentid='+${param.parentid }+"&examineflag=0&isfilter="+${param.isfilter },
            page: false,
            cols: [
            [
                {type: 'radio'},
                {field: 'attributelabel', title: '属性标签'},
                {field:'examineflag', title: '标签状态',width:100,align:"center",templet: function (item) {
		          if (item.examineflag=="0") {
		             return "<span><font color='red'>未审核</font></span>";
		         }else if(item.examineflag=="1"){
		             return "<span>已通过</span>";
		         }else if(item.examineflag=="2"){
		             return "<span><font color='blue'>审核不通过</font></span>";
		         }
                 }},
                {field: 'addoperator',align: 'center', title: '建档信息',width:220,templet: function (item) {
		              return item.addoperator+" "+item.addtime;
                 }},
                {templet: '#auth-state', width: 120, align: 'center', title: '操作'}
            ]
            ],
            
            //数据渲染完的回调
            done: function (res, curr, count) {
           		layer.closeAll('loading');
            }
        });
        


	// 工具列点击事件
        table.on('tool(followTable)', function (obj) {
         	var id = obj.data.id;
    		var event = obj.event;
            if (event == 'examine') {
               
               var id = obj.data.id;
               var examineflag=obj.data.examineflag;
		       if(examineflag==0){
					       var index = layui.layer.open({
								title : "人员标签审核",
								type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
								content : '<c:url value="/jsp/personel/attributelabel/examine.jsp?examineflag='+examineflag+'&id='+id+'"/>',
								area: ['600', '400px'],
								offset:['70'],
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
				          top.layer.alert("已审核的标签不可以重复审核！");
				   }    
		         		
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
				    offset:['70'],
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
