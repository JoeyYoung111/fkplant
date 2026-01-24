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
    <title>情报线索信息</title>
    <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  </head>
 <body>
<script type="text/html" id="toolbarDemo">
	<button type="button" class="layui-btn layui-btn-sm" lay-event="add"><i class="layui-icon layui-icon-add-1"></i>添 加</button>
	<button type="button" class="layui-btn layui-btn-sm" lay-event="update"><i class="layui-icon  layui-icon-edit"></i>修 改</button>
	<button type="button" class="layui-btn layui-btn-sm" lay-event="canel"><i class="layui-icon layui-icon-delete"></i>删 除</button>
</script>
<table class="layui-hide" id="followTable" lay-filter="followTable"></table> 
<script>
layui.use(['table'], function(){
	var layer = layui.layer,
	table = layui.table;
	//初始化情报线索信息
	table.render({
		elem: '#followTable',
		url: '<c:url value="/searchLeadsInfo.do"/>',
		where:{cdtid:${param.cdtid },workinfoid:${param.workinfoid }},
	    toolbar: true,
	    defaultToolbar: ['filter', 'exports', 'print'],
	    method:'post',
	    toolbar: '#toolbarDemo',
	    cols: [[
	    	{field:'id',type:'radio',fixed:'left'},
	    	{field:'ldate', title: '预计发生时间', width:200,align:"center"},
	    	{field:'ltitle', title: '线索标题', width:200,align:"center"},
	    	{field:'lpointto', title: '线索指向', width:200,align:"center"},
	    	{field:'xscz', title: '线索处置',align:"center"}
	    ]],
	    page: true,
	    limit: 10
	});
	
	//监听行工具事件
	table.on('toolbar(followTable)', function(obj){
		var  checkStatus =table.checkStatus(obj.config.id);
		switch(obj.event){
			case 'add':
				   var content='<c:url value="/jsp/event/contradictionInfo/leadsInfo/add.jsp"/>?menuid=${param.menuid }&cdtid=${param.cdtid}&workinfoid=${param.workinfoid}&page=${param.page}&fxdj=${param.fxdj }';
				   var index = layui.layer.open({
						title : "添加情报线索信息",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content : [content,'yes'],
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
			   var id=datas[0].id;
			    var index = layui.layer.open({
							title : "修改情报线索信息",
							type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
							content : '<c:url value="getLeadsInfo.do"/>?id='+id+'&menuid=${param.menuid }&page=${param.page}',
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
					var id=datas[0].id;
				    layer.confirm('确定删除此信息？', function(index){
						layer.close(index);
				        $.getJSON('<c:url value="cancelLeadsInfo.do"/>?id='+id+'&menuid='+${param.menuid },{
							},function(data) {
								var str = eval('(' + data + ')');
								if (str.flag ==1) {		                          
							     	top.layer.msg("数据删除成功！"); 	
							     	formSubmit();
							     	if("${param.page}"=="feedback"){
							     		parent.parent.formSubmit('qbxs','<c:url value="searchLeadsInfo.do"/>');
							     	}
								}else{
									top.layer.msg("删除失败!");
								}
				        	});      
						});
				}else{
					layer.alert("请先选择删除哪条数据！");
				}
			 break;
		}
	});
 });
	
	function formSubmit(){
		layui.table.reload('followTable', {
			page: {
				curr: 1
				// 重新从第 1 页开始
			},done: function(res, curr, count){
				parent.$('#qbxsbutton').text("情报线索信息("+count+")");
				parent.layui.form.render();
			}
		});
	}
</script>
</body>

</html>