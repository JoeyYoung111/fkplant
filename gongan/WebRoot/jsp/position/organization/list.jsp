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
    <title>风险地址——政保组织</title>
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
	
		<div class="layui-inline" style="width:212px;">
			<input class="layui-input" type="text" id="orgName" placeholder=" 组织名称：" autocomplete="off" >
		</div>
		<div class="layui-inline" style="width:212px;">
			<select id="orgType" autocomplete="off">
				<option value="">组织级别：全部</option>
			</select>
		</div>
		<div class="layui-inline" style="width:212px;">
			<select id="orgClass" autocomplete="off">
				<option value="">组织类别：全部</option>
			</select>
		</div>
		<button class="layui-btn" id="search" data-type="reload"><i class="layui-icon">&#xe615;</i>搜 索</button>
		<button type="reset" id="reset" class="layui-btn"><i class="layui-icon">&#xe702;</i>重置</button>
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
            <c:if test='${fn:contains(param.buttons,"打印")}'>
				<button id="dayinBtn" class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more" lay-event="dy">&#xe66d; 打 印</button>
             </c:if>
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
function getpositiontype(){
	$.ajax({
		type:		'POST',
		url:		'<c:url value="/getBMByTypeToJSON.do?basicType="/>'+96,
		dataType:	'json',
		async:      false,
		success:	function(data){
			var options="";
			$.each(data.list, function(i, item) {
				$.each(item, function(i) {
					options += '<option value="' + this.text + '">' + this.text + '</option>';
				});
			});
			$("#orgType").append(options);
		}
	});
}
function getorgClass(){
	$.ajax({
		type:		'POST',
		url:		'<c:url value="/getBMByTypeToJSON.do?basicType="/>'+104,
		dataType:	'json',
		async:      false,
		success:	function(data){
			var options="";
			$.each(data.list, function(i, item) {
				$.each(item, function(i) {
					options += '<option value="' + this.text + '">' + this.text + '</option>';
				});
			});
			$("#orgClass").append(options);
		}
	});
}
layui.use(['table','form'], function(){
  var table = layui.table,
  form = layui.form;
	
  //方法级渲染
  table.render({
    elem: '#followTable',
    toolbar: true,
   	defaultToolbar: ['filter', 'print'],
    url: '<c:url value="/searchOrganization.do"/>',
    method:'post',
    toolbar: '#toolbarDemo',
    cols: [[
    	{field:'id',type:'radio',fixed:'left'},//sort: true 排序
    	{field:'orgName', title: '名称',align:"center",templet: function (item) {
		   		return "<span style='font-weight:500;cursor:pointer;' onclick='showinfoOrganization("+item.id+");'><font color='blue'>"+item.orgName+"</font></span>";
           }},
    	{field:'orgType', title: '组织级别',align:"center"} ,
    	{field:'orgClass', title: '组织类别',align:"center"} ,
    	{field:'inProvince', title: '是否省内组织',align:"center"} ,
    	{field:'isRegister', title: '是否登记注册',align:"center"} ,
    	{field:'orgForeignName', title: '外文名称',align:"center"},
        {field:'createTime', title: '成立时间',align:"center"} ,
        {field:'createAddress', title: '成立地点',align:"center"} ,
        {field:'activeLevel', title: '活跃程度',align:"center"} ,
        {field:'activeRange', title: '活动范围',align:"center"} ,
        {field:'isForeignConnections', title: '是否与境外存在勾连',align:"center"} ,
        {field:'activeWay', title: '活动方式',align:"center"} ,
        {field:'controlTime', title: '管控时间',align:"center"} ,
        {field:'unitname', title: '管控单位',align:"center"} ,
        {field:'policename', title: '管控民警',align:"center"} ,
        {field:'controlPhone', title: '联系电话(长号)',align:"center"} ,
        {field:'addoperator', title: '建档人',align:"center"} ,
        {field:'addtime', title: '建档时间',align:"center"},
        {field:'updateoperator', title: '最新修改人',align:"center"},
		{field:'updatetime', title: '最新修改时间',align:"center"} 
        //{field: 'right', title: '操作', toolbar: '#barButton',width:65,align:"center"} 
    ]],
    page: true,
    limit: 10
  });
  getpositiontype();
  getorgClass();
  form.render();
  //监听行工具事件
  table.on('toolbar(followTable)', function(obj){
    var  checkStatus =table.checkStatus(obj.config.id);
   switch(obj.event){
   case 'add':
   		var index = layui.layer.open({
				title : "添加政保组织信息",
				type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
				content : '<c:url value="/jsp/position/organization/add.jsp?menuid=${param.menuid }"/>',
				area: ['1000', '700px'],
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
					title : "修改政保组织信息",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content : locat+'/getOrganizationUpdate.do?id='+id+'&buttons='+'${param.buttons }&page=update&menuid='+${param.menuid },
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
	    layer.confirm('确定删除此政保组织信息？', function(index){
	        layer.close(index);
	        $.getJSON(locat+"/cancelOrganization.do?id="+id+"&menuid="+${param.menuid },{},function(data) {
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
	 case 'personnel':
	   var data=JSON.stringify(checkStatus.data);
	   var datas=JSON.parse(data);
	   if(datas!=""){
	   var id=datas[0].id;
	    var index = layui.layer.open({
					title : "人员情况信息("+datas[0].positionname+")",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content : locat+'/getOrganizationUpdate.do?id='+id+'&page=personnel&menuid='+${param.menuid },
					area: ['800', '700px'],
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
					layer.alert("请先选择查看哪条数据！");
				}
	    break;
	    
	  case 'dy':
	  	var data = JSON.stringify(checkStatus.data);
	  	var datas = JSON.parse(data);
	  	if(datas!=""){
	  		var id = datas[0].id;
	  		window.location.href='<c:url value="/dayinOrganization.do"/>?id='+id;
			return false;
	  	}else{
			layer.alert("请先选择数据！");
		}
	  break;
	    
   };
   
 });	
    	//搜索查询
  		$("#search").click(function () {
  		  table.reload('followTable', {
				where: { 
					orgName: $("#orgName").val(),
					orgType: $("#orgType").val(),
					orgClass: $("#orgClass").val()
				},
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
 
 function showinfoOrganization(id){
 	var index = layui.layer.open({
		title : "政保组织详情",
		type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
		content : locat+'/getOrganizationUpdate.do?id='+id+'&menuid='+${param.menuid}+'&page=showinfo',
		area: ['800', '700px'],
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
</script>
</body>

</html>