<%@ page contentType='text/html;charset=UTF-8' language='java'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ page import="com.aladdin.model.UserSession"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
UserSession userSession = (UserSession) session.getAttribute("userSession");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>政保事件</title>
    <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  </head>
 <body>
<blockquote class="layui-elem-quote news_search">	
<form class="layui-form" onsubmit="return false;">
		<div class="layui-inline" >
			<input class="layui-input" type="text" name="cdtname" id="cdtname" autocomplete="off" placeholder=" 标题关键词：">
		</div>
		<div class="layui-inline" >
			<select id="cdttype" name="cdttype" autocomplete="off">
				<option value="" selected> --- 事件类别:全部 --- </option>
			</select>
		</div>
		<div class="layui-inline">
		   <div id="zbdept" style="width:360px;"></div>
		</div>
		<button class="layui-btn" id="search" data-type="reload"><i class="layui-icon">&#xe615;</i>搜 索</button>
		<button type="reset" id="reset" class="layui-btn"><i class="layui-icon">&#xe702;</i>重 置</button>
		<script type="text/html" id="toolbarDemo">
			<c:if test='${fn:contains(param.buttons,"新增")}'>
   				<button type="button" class="layui-btn layui-btn-sm" lay-event="add"><i class="layui-icon layui-icon-add-1"></i>添 加</button>
             </c:if>
            <c:if test='${fn:contains(param.buttons,"修改")}'>
	   			<button type="button" class="layui-btn layui-btn-sm" lay-event="update"><i class="layui-icon  layui-icon-edit"></i>修 改</button>
             </c:if>
            <c:if test='${fn:contains(param.buttons,"删除")}'>
   			      <button type="button" class="layui-btn layui-btn-sm" lay-event="cancel"><i class="layui-icon layui-icon-delete"></i>删 除</button>
             </c:if>
   		</script>
</form>
</blockquote>
<table class="layui-hide" id="followTable" lay-filter="followTable"></table> 
<script>
function getcdttype(){
	$.ajax({
		type:		'POST',
		url:		'<c:url value="/getBMByTypeToJSON.do?basicType="/>'+103,
		dataType:	'json',
		async:      false,
		success:	function(data){
			var options ="";
			$.each(data.list, function(i, item) {
				$.each(item, function(i) {
					options += '<option value="' + this.text + '">' + this.text + '</option>';
				});
			});
			$("#cdttype").append(options);
		}
	});
}
layui.config({
    base: "<c:url value="/layui/lay/modules/"/>"
}).extend({
    zTreeSelectM: "zTreeSelectM/zTreeSelectM"
});
layui.use(['table','form','zTreeSelectM'], function(){
	var table = layui.table,
	zTreeSelectM = layui.zTreeSelectM,
	form = layui.form;
	//初始化
	var _zTreeSelectM1 = zTreeSelectM({
	    elem: '#zbdept',//元素容器【必填】          
	    data: '<c:url value="/getDepartmentTreeBytype.do"/>?departtype=4',
	    type: 'get',  //设置了长度    
	    selected: [],//默认值            
	    max: 100,//最多选中个数，默认5            
	    name: 'zbdept',//input的name 不设置与选择器相同(去#.)
	    delimiter: ',',//值的分隔符  
	    tips:' 责任单位：',         
	    field: { idName: 'id', titleName: 'name' },//候选项数据的键名 
	    zTreeSetting: { //zTree设置
	        check: {
	            enable: true,
	            chkboxType: { "Y": "", "N": "" }
	        },
	        data: {
	            simpleData: {
	                enable: false
	            },
	            key: {
	                name: 'name',
	                children: 'children'
	            }
	        },
	        view: {
	        	showIcon: false
			}
	    }
	});
  var type = "${param.type }";
  //方法级渲染
  table.render({
    elem: '#followTable',
    toolbar: true,
    defaultToolbar: ['filter', 'exports', 'print'],
    url: '<c:url value="/searchContradictionInfo.do"/>',
    where: {type:type},
    method:'post',
    toolbar: '#toolbarDemo',
    cols: [[
    	{field:'id',type:'radio',fixed:'left'},
    	{field:'cdtname', title: '事件名称', width:200,align:"center",templet: function(d){
    		return "<a href='#' style='text-decoration: underline;' onclick='showInfo(&quot;"+d.id+"&quot;);return false;'>"+d.cdtname+"</a>";
    	}},
    	{field:'cdtlevel', title: '事件级别', width:120,align:"center"},
  		{field:'sponsorname', title: '责任单位', width:150,align:"center"},
    	{field:'cdttype', title: '事件类别', width:120,align:"center"},
    	{field:'cdtresult', title: '主要活动方式', width:200,align:"center"},
    	{field:'sfdz', title: '发生地点', width:200,align:"center"},
    	{field:'memo', title: '发生时间', width:200,align:"center"},
    	{field:'cdtcontent', title: '情况经过',align:"center"}
    ]],
    page: true,
    limit: 10
  });
    getcdttype();
    form.render();
  //监听行工具事件
  table.on('toolbar(followTable)', function(obj){
    var  checkStatus =table.checkStatus(obj.config.id);
   switch(obj.event){
   case 'add':
   var index = layui.layer.open({
				title : "添加政保事件",
				type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
				content : '<c:url value="/jsp/event/zbEvent/add.jsp"/>?menuid=${param.menuid }',
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
   var assistdept = ""+datas[0].assistdept;
   var loginUserDepartmentid = "<%=userSession.getLoginUserDepartmentid()%>";
   if("<%=userSession.getLoginRoleEventFilter()%>"==0||(datas[0].adddepartment==loginUserDepartmentid||datas[0].sponsor==loginUserDepartmentid||assistdept.indexOf(loginUserDepartmentid)>-1)){
	   var index = layui.layer.open({
			title : "修改政保事件",
			type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
			content : '<c:url value="getZbEvent.do"/>?id='+id+'&buttons=${param.buttons }&menuid=${param.menuid }',
			area: ['800', '800px'],
			maxmin: true,
			success : function(layero, index){
				setTimeout(function(){
					layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
						tips: 3
					});
				},500)
			},
			cancel : function(index,layero){
				$("#search").click();
			}
		});
		layui.layer.full(index);
   }else{
   		layer.alert("无修改权限！");
   }
    break;
case 'cancel':
   var data=JSON.stringify(checkStatus.data);
   var datas=JSON.parse(data);
    if(datas!=""){
   var id=datas[0].id;
    layer.confirm('确定删除此信息？', function(index){
        layer.close(index);
        $.getJSON('<c:url value="cancelContradictionInfo.do"/>?id='+id+'&menuid='+${param.menuid },{
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
   }
   
 });
    
    	//搜索查询
  		$("#search").click(function () {
  			table.reload('followTable', {
				where: { // 设定异步数据接口的额外参数，任意设
					cdtname: $("#cdtname").val(),
					zbdept: $("input[name='zbdept']").val(),
					cdttype: $("#cdttype").val()
				},
				page: {
					curr: 1
					// 重新从第 1 页开始
				}
			});
		});
		$("#reset").click(function () {
			_zTreeSelectM1.render([]);
			form.render();
			_zTreeSelectM1.render([]);
		});
 });
		
		function showInfo(id){
			var index = layui.layer.open({
				title : "政保事件详情",
				type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
				content : '<c:url value="showZbEvent.do"/>?id='+id+'&menuid=${param.menuid }',
				area: ['800', '750px'],
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
</script>
</body>

</html>