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
    
    <link rel="stylesheet" href="<c:url value="/css/viewer.css"/>"/>
	<link rel="stylesheet" href="<c:url value="/layui/lay/modules/formSelects/formSelects-v4.css"/>" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/js/jquery.form.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/cardnumber.js"/>"></script>
  	<link rel="stylesheet" href="<c:url value='/layui/css/layui1.css'/>"/>
  	<link rel="stylesheet" href="<c:url value='/css/public.css'/>" media="all" />
  	<script type="text/javascript" src="<c:url value="/js/viewer.js"/>"></script>
  	
  </head>

<body class="childrenBody layui-fluid">
	<blockquote class="layui-elem-quote news_search">
		<div class="demoTable">
			<form class="layui-form" method="post" style="display:inline;" id="form1" >
				<input type="hidden" name="currentpage" id="currentpage"/>
				<input type="hidden" name="pagesize" id="pagesize"/>
				<input type="hidden" name="companytype" id="companytype" value='974'/>
				
				<div class="layui-inline">
					<input type="text" class="layui-input" style="width:187px;" name="companyname" id="companyname" placeholder="单位名称" autocomplete="off" />
				</div>
				<div class="layui-inline">
					<input type="text" class="layui-input" style="width:187px;" name="vehicleno" id="vehicleno" placeholder="牌照" autocomplete="off" />
				</div>
				<div class="layui-inline">
					<input type="text" class="layui-input" style="width:187px;" name="vehiclecolor" id="vehiclecolor" placeholder="车辆颜色" autocomplete="off" />
				</div>
				<div class="layui-inline">
					<input type="text" class="layui-input" style="width:187px;" name="transportNo" id="transportNo" placeholder="道路运输编号" autocomplete="off" />
				</div>
				<div class="layui-inline">
					<input type="text" class="layui-input" style="width:187px;" name="engineno" id="engineno" placeholder="发动机号" autocomplete="off" />
				</div>
				<div class="layui-inline">
					<input type="text" class="layui-input" style="width:187px;" name="identificationCode" id="identificationCode" placeholder="车辆识别代码" autocomplete="off" />
				</div>
			</form>		
				
			<button class="layui-btn" id="search" data-type="reload"><i class="layui-icon">&#xe615;</i>搜索</button>
		<script type="text/html" id="toolbarVehicle">
		 	<c:if test='${fn:contains(param.buttons,"新增")}'>
				<button type="button" class="layui-btn layui-btn-sm" lay-event="addVehicle"><i class="layui-icon">&#xe654;</i>添 加</button>
			</c:if>
			<c:if test='${fn:contains(param.buttons,"修改")}'>
   				<button type="button" class="layui-btn layui-btn-sm" lay-event="updateVehicle"><i class="layui-icon">&#xe642;</i>修 改</button>
			</c:if>
			<c:if test='${fn:contains(param.buttons,"删除")}'>
   				<button type="button" class="layui-btn layui-btn-sm" lay-event="cancelVehicle"><i class="layui-icon">&#xe640;</i>删 除</button>
			</c:if>
			<c:if test='${fn:contains(param.buttons,"导入")}'>
   				<button type="button" class="layui-btn layui-btn-sm" lay-event="importVehicle"><i class="layui-icon">&#xe601;</i>导 入</button>   
			</c:if>
		</script>
		
		</div>
	</blockquote>

	<table class="layui-hide" id="VehicleTable" lay-filter="VehicleTable"></table>
	<script type="text/html" id="Veh">
		<a class="layui-btn layui-btn-xs" lay-event="showinfo">详情</a>
	</script>

	
<script type="text/javascript">

var locat = (window.location+'').split("/");
$(function(){
	if('main'==locat[3]){locat = locat[0]+'//'+locat[2];}else{locat = locat[0]+'//'+locat[2]+'/'+locat[3];};
});

layui.use(['form','table'], function(){
	var form = layui.form;
	var table = layui.table;
	var tempid = "${param.menuid }";
	tempid = tempid.substring(tempid.indexOf("=")+1);
	
	form.render();
	
	table.render({
		elem:'#VehicleTable',
		toolbar:true,
		defaultToolbar:['filter','exports','print'],
		url:'<c:url value="searchVehicle.do"/>',
		method:'post',
		toolbar: "#toolbarVehicle",
		cols:	[[
		    {field:'id',hide:true,title:'id'},
		    {field:'id',type:'radio',fixed:'left'},
		    {field:'companyname',title:'单位名称',width:250,align:"center"},
		    {field:'vehicleno',title:'车辆牌照',width:180,align:"center",
		    	templet:function(item){return "<span style='font-weight:500;cursor:pointer;' onclick='showInfoVehicle("+item.id+");'><font color='blue'>"+item.vehicleno+"</font></span>";}},
		    {field:'vehiclebrand',title:'品牌型号',width:180,align:"center"},
		    {field:'vehicletype',title:'车辆类型',width:180,align:"center"},
		    {field:'engineno',title:'发动机号',width:180,align:"center"},
		    {field:'identificationCode',title:'车辆识别代码',width:180,align:"center"},
		    {field:'relatedtypeMsg',title:'涉及品种',width:220,align:"center"},
		    {field:'addoperator',title:'添加人',width:120,align:"center"},
	        {field:'addtime',title:'添加时间',width:180,align:"center"}
//		    ,{field:'right',title:'操作',toolbar:"#Veh",width:150,align:"center"}
		]],
		page:true,
		limit:10
	});
	
	table.on('toolbar(VehicleTable)',function(obj){
		var checkStatus = table.checkStatus(obj.config.id);
		
		switch(obj.event){
			case 'addVehicle':
				var index = layui.layer.open({
					title:	"添加车辆信息",
					type:	2,
					content:locat+"/jsp/vehicle/vehicle_add.jsp?menuid="+tempid,
					area:	['800','700px'],
					maxmin:	true,
					success:function(layero,index){
						setTimeout(function(){
							layui.layer.tips('点击此处返回列表','.layui-layer-setwin .layui-layer-close',{
								tips: 3
							});
						},500);
					}
				});
				layui.layer.full(index);
			break;
			
			case 'updateVehicle':
				var data = JSON.stringify(checkStatus.data);
				var datas = JSON.parse(data);
				if(datas!=""){
					var id = datas[0].id;
					var index = layui.layer.open({
						title:	"修改车辆信息",
						type:	2,
						content:locat+"/getVehicleById.do?id="+id+"&page=update2&menuid="+tempid,
						area:	['800','700px'],
						maxmin:	true,
						success:function(layero,index){
							setTimeout(function(){
								layui.layer.tips('点击此处返回列表','.layui-layer-setwin .layui-layer-close',{
									tips: 3
								});
							},500);
						}
					});
					layui.layer.full(index);
				}else{
					top.layer.alert("请先选择数据");
				}
			break;
			
			case 'cancelVehicle':
				var data = JSON.stringify(checkStatus.data);
				var datas = JSON.parse(data);
				if(datas!=""){
					var id = datas[0].id;
					layer.confirm("确定删除此信息吗?",function(index){
						layer.close(index);
						$.getJSON(locat+"/cancelVehicle.do?id="+id+'&menuid='+tempid,{},function(data){
							var str = eval('('+data+')');
							if(str.flag ==1){
								top.layer.msg("数据删除成功");
								table.reload('VehicleTable',{});
							}else{
								top.layer.msg("数据删除失败");
							}
						});
					});
				}else{
					top.layer.alert("请先选择数据");
				}
			break;
			
			case 'importVehicle':
			   var index = layui.layer.open({
					 title : "导入风险车辆信息",
					 type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					 content : "<c:url value="/jsp/vehicle/vehicle_import.jsp?menuid=${param.menuid }"/>",
					  area: ['600', '650'],
					 maxmin: true,
					 offset:['30'], 
					end: function () {
						$("#search").click(); 
					}
				 });	
			    break;
			
		};
	});
	/*
	table.on('tool(VehicleTable)',function(obj){
		var id = obj.data.id;
		if(obj.event == 'showinfo'){
			var index = layui.layer.open({
				title:		'详情信息',
				type:		2,
				content:locat+'/getVehicleById.do?id='+id+"&page=showinfo&menuid="+tempid,
				area:		['800','700px'],
				maxmin:		true,
				success:function(layero,index){
					setTimeout(function(){
						layui.layer.tips('点击此处返回列表','layui-layer-setwin .layui-layer-close',{
							tips:	3
						});
					},500);
				}
			});
			layui.layer.full(index);
		}
	});
	*/
	$("#search").click(function (){
		table.reload('VehicleTable',{
			where:{
				companyname: $("#companyname").val(),
				vehicleno: $("#vehicleno").val(),
				vehiclecolor: $("#vehiclecolor").val(),
				transportNo: $("#transportNo").val(),
				engineno: $("#engineno").val(),
				identificationCode:$("#identificationCode").val()
			},
			page:{
				//重新从第一页开始
				curr:1
			}
		});
	});
	
	form.render();
	
});

function showInfoVehicle(id){
	var index = layui.layer.open({
		title	:'详情信息',
		type	:2,
		content	:locat+'/getVehicleById.do?id='+id+"&page=showinfo&menuid="+${param.menuid},
		area	:['800','650px'],
		maxmin	:true,
		success	:function(layero,index){
			setTimeout(function(){
				layui.layer.tips('点击此处返回列表','layui-layer-setwin .layui-layer-close',{
					tips:	3
				});
			},500);
		}
	});
	layui.layer.full(index);
}

</script>
</body>
</html>
