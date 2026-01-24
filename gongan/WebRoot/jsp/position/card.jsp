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
    <title>政保阵地——登记证书</title>
   <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
	<link rel="stylesheet" href="<c:url value="/layui/lay/modules/formSelects/formSelects-v4.css"/>" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/cardnumber.js"/>"></script>
  </head>
 <body>
<blockquote class="layui-elem-quote news_search">	
<div class="demoTable">
<form class="layui-form" onsubmit="return false;" style="display:inline;" onsubmit="return false;">
		<input type="hidden"  name="positionid" id="positionid"  value=${position.id}></input>
		<input type="hidden"  name="menuid" id="menuid"  value=${menuid}></input>
		<script type="text/html" id="toolbarDemo">
   			<button type="button" class="layui-btn layui-btn-sm" lay-event="add"><i class="layui-icon layui-icon-add-1"></i>添 加</button>
   			<button type="button" class="layui-btn layui-btn-sm" lay-event="update"><i class="layui-icon  layui-icon-edit"></i>修 改</button>
   			<button type="button" class="layui-btn layui-btn-sm" lay-event="cancel"><i class="layui-icon layui-icon-delete"></i>删 除</button>
   		</script>
</form>
</div>
</blockquote>
<table class="layui-hide" id="followTable" lay-filter="followTable"></table> 
<script>
var locat = (window.location+'').split('/'); 
var now=new Date();
$(function(){if('main'== locat[3]){locat =  locat[0]+'//'+locat[2];}else{locat =  locat[0]+'//'+locat[2]+'/'+locat[3];};});
$(document).ready(function(){
});

layui.use(['table','form'], function(){
  var table = layui.table,
  form = layui.form;
	
  //方法级渲染
  table.render({
    elem: '#followTable',
    toolbar: true,
   	defaultToolbar: ['filter', 'print'],
    url: '<c:url value="/searchPositionCard.do"/>?positionid=${position.id}',
    method:'post',
    toolbar: '#toolbarDemo',
    cols: [[
    	{field:'id',type:'radio',fixed:'left'},//sort: true 排序
    	{field:'cardname', title: '登记证书名称', width:200},
    	{field:'cardno', title: '编号', width:150} ,
        {field:'validdate', title: '有效期', width:150} , 
    	{field:'cardunit', title: '发证单位', width:200},
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
				title : "添加登记证书",
				type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
				content : '<c:url value="/jsp/position/addcard.jsp?positionid=${position.id}&menuid=${menuid }"/>',
				area: ['1000', '600px'],
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
					title : "修改登记证书",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content : locat+'/getPositionCardUpdate.do?id='+id+'&buttons='+'${param.buttons }&page=update&menuid='+${param.menuid },
					area: ['800', '750px'],
					maxmin: true,
					success : function(layero, index){
						setTimeout(function(){
							layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
								tips: 3
							});
						},500)
					},
					cancel:function(){
						table.reload('followTable', { }); 
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
	    layer.confirm('确定删除此登记证书？', function(index){
	        layer.close(index);
	        $.getJSON(locat+"/cancelPositionCard.do?id="+id+"&menuid="+${param.menuid },{},function(data) {
				var str = eval('(' + data + ')');
	        	 if (str.flag ==1) {		                          
			          top.layer.msg("数据删除成功！"); 	
			          table.reload('followTable', { });                 
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
    	//搜索查询
  		$("#search").click(function () {
  		  table.reload('followTable', {
				page: {
					curr: 1
					// 重新从第 1 页开始
				}
			});
		});
		$("#reset").click(function () {
		   $('form')[0].reset();
		});
 });
</script>
</body>

</html>