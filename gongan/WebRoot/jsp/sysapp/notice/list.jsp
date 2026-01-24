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
    <title>通知公告</title>
    <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  </head>
  <style>
     /*layui-table 表格内容允许换行*/
     .layui-table-main .layui-table td[data-field="filenames"] div:not(.laytable-cell-radio){
         height: auto;
         overflow:visible;
         text-overflow:inherit;
         white-space:normal;
     }
     .layui-table-fixed .layui-table-body{
      display:none;
     }
   </style>
 <body>
<blockquote class="layui-elem-quote news_search">	
<form class="layui-form" onsubmit="return false;">
		<div class="layui-inline" style="width:20%;">
			<select name="noticetype" id="noticetype">
		        <option value="">类型：</option>
		        <option value="通知">通知</option>
		        <option value="公告">公告</option>
		        <option value="知识">知识</option>
		    </select>
		</div>
		<div class="layui-inline" style="width:20%;">
			<input class="layui-input" type="text" name="noticetitle" id="noticetitle" autocomplete="off" placeholder=" 标题关键词：">
		</div>
		<div class="layui-inline" style="width:20%;">
			<input class="layui-input" type="text" name="noticetext" id="noticetext" autocomplete="off" placeholder=" 内容关键词：">
		</div>
		<button class="layui-btn" id="search" data-type="reload"><i class="layui-icon">&#xe615;</i>搜 索</button>
		<script type="text/html" id="toolbarDemo">
			<c:if test='${fn:contains(param.buttons,"新增")}'>
   				<button type="button" class="layui-btn layui-btn-sm" lay-event="add"><i class="layui-icon layui-icon-add-1"></i>添 加</button>
			</c:if>
			<c:if test='${fn:contains(param.buttons,"修改")}'>
   				<button type="button" class="layui-btn layui-btn-sm" lay-event="update"><i class="layui-icon  layui-icon-edit"></i>修 改</button>
			</c:if>
			<c:if test='${fn:contains(param.buttons,"删除")}'>
   				<button type="button" class="layui-btn layui-btn-sm" lay-event="canel"><i class="layui-icon layui-icon-delete"></i>删 除</button>
			</c:if>
   		</script>
   		<script type="text/html" id="barButton">
           <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="showinfo">详情</a>       
		</script>
</form>
</blockquote>
<table class="layui-hide" id="followTable" lay-filter="followTable"></table> 
<script>
layui.use(['table','form'], function(){
	var table = layui.table,
	form = layui.form;
	
	//方法级渲染
	table.render({
    	elem: '#followTable',
    	toolbar: true,
    	defaultToolbar: ['filter', 'exports', 'print'],
    	url: '<c:url value="/searchNotice.do"/>',
    	method:'post',
    	toolbar: '#toolbarDemo',
    	cols: [[
    		{field:'id',type:'radio',fixed:'left'},
    		{field:'noticetype', title: '类型', width:100,align:"center"},
    		{field:'noticetitle', title: '标题', width:200,align:"center"},
    		{field:'noticetext', title: '内容',align:"center"},
    		{field:'filenames', title: '通知附件',width:200,align:"center",templet: function(d){
	    		var content="";
	    		if(d.filenames!=null){
	    			var filenames = d.filenames.split(",");
		    		var fileids = d.fileids.split(",");
		    		if(filenames.length>0){
		    			content+='<div><a href="<c:url value="/downUpfile.do" />?fileid='+fileids[0]+'" class="layui-table-link">'+filenames[0]+'</a></div>';
		    		}
		    		for(var i=1;i<filenames.length;i++){
		    			content+='<div><a href="<c:url value="/downUpfile.do" />?fileid='+fileids[i]+'" class="layui-table-link">'+filenames[i]+'</a></div>'
		    		}
	    		}
	    		return content;
	    	}},
    		{field:'departnames', title: '发送部门', width:200,align:"center"},
    		{field:'addoperator', title: '添加人', width:200,align:"center"},
    		{field:'right', title: '操作', toolbar: '#barButton',width:65,align:"center"}
    	]],
    	page: true,
    	limit: 10
	});
	
	//监听行工具事件
	table.on('toolbar(followTable)', function(obj){
    	var  checkStatus =table.checkStatus(obj.config.id);
   		switch(obj.event){
   		case 'add':
   			var index = layui.layer.open({
				title : "添加通知公告",
				type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
				content : '<c:url value="/jsp/sysapp/notice/add.jsp"/>?menuid=${param.menuid }',
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
	   		var id=datas[0].id;
	   		if(datas!=""){
	   			var index = layui.layer.open({
					title : "修改通知公告",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content : '<c:url value="getNotice.do"/>?id='+id+'&menuid=${param.menuid }',
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
        			$.getJSON('<c:url value="cancelNotice.do"/>?id='+id+'&menuid='+${param.menuid },{},function(data) {
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
		}
	});
	
	//监听行工具事件
	table.on('tool(followTable)', function(obj){
		var id = obj.data.id;
		switch(obj.event){
			case 'showinfo':
				var index = layui.layer.open({
					title : "通知公告详情",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content : '<c:url value="showNotice.do"/>?id='+id+'&menuid=${param.menuid }',
					area: ['800', '750px'],
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
		}
	});
	
	//搜索查询
 	$("#search").click(function () {
 		formSubmit();
	});
});
	
	function formSubmit(){
 		layui.table.reload('followTable', {
			where: { // 设定异步数据接口的额外参数，任意设
				noticetype: $("#noticetype").val(),
				noticetitle: $("#noticetitle").val(),
				noticetext: $("#noticetext").val()
			},
			page: {
				curr: 1
				// 重新从第 1 页开始
			}
		});
	}
</script>
</body>

</html>