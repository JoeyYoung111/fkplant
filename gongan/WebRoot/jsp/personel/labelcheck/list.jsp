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
    <title>人员标签审核</title>
    <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
    <link rel="stylesheet" href="<c:url value="/css/public.css"/>"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  </head>
 <body>
<blockquote class="layui-elem-quote news_search">	
<form class="layui-form" onsubmit="return false;">
		<div class="layui-inline">
			<input class="layui-input" type="text" name="addoperator" id="addoperator" autocomplete="off" placeholder=" 申请人：">
		</div>
		<div class="layui-inline">
			<select name="examineflag" id="examineflag"  style="width:200px;">
		        <option value="0">未审核</option>
		        <option value="1">审核通过</option>
		        <option value="2">审核不通过</option>
		    </select>
		</div>
		<button class="layui-btn" id="search" data-type="reload"><i class="layui-icon">&#xe615;</i>搜 索</button>
		<script type="text/html" id="toolbarDemo">
			<button type="button" class="layui-btn layui-btn-sm" lay-event="check"><i class="layui-icon layui-icon-survey"></i>审核</button>
   		</script>
</form>
</blockquote>
<table class="layui-hide" id="followTable" lay-filter="followTable"></table> 
<script>
	var locat = (window.location+'').split('/'); 
	$(function(){if('main'== locat[3]){locat =  locat[0]+'//'+locat[2];}else{locat =  locat[0]+'//'+locat[2]+'/'+locat[3];};});
	layui.config({
	    base: "<c:url value="/layui/lay/modules/"/>"
	}).extend({
	    zTreeSelectM: "zTreeSelectM/zTreeSelectM"
	});
layui.use(['table','form','zTreeSelectM'], function(){
	var table = layui.table,
	zTreeSelectM = layui.zTreeSelectM,
	form = layui.form;
  
  //方法级渲染
  table.render({
    elem: '#followTable',
    toolbar: true,
    defaultToolbar: ['filter', 'exports', 'print'],
    url: '<c:url value="/searchApplylabel.do"/>',
    where:{departmentid:'<%=userSession.getLoginUserDepartmentid() %>'},
    method:'post',
    toolbar: '#toolbarDemo',
    cols: [[
    	{field:'id',type:'radio',fixed:'left'},
    	{field:'personname', title: '风险人员姓名', width:120,align:"center",templet: function (item) {
    		return '<a onclick="showinfoPersonnelExtend('+item.personnelid+')" class="my-font-blue" style="cursor:pointer;">'+item.personname+'</a>';
    	}} ,
    	{field:'cardnumber', title: '人员身份证', width:200,align:"center",templet: function (item) {
    		return '<a onclick="showinfoPersonnelExtend('+item.personnelid+')" class="my-font-blue" style="cursor:pointer;">'+item.cardnumber+'</a>';
    	}} ,
    	{field:'applylabel1name', title: '申请标签一级', width:120,align:"center"} ,
    	{field:'applylabel2name', title: '申请标签二级', align:"center"} ,
    	{field:'applyreason', title: '申请理由', align:"center"} ,
    	{field:'addoperator', title: '申请人', width:100,align:"center"} ,
    	{field:'addtime', title: '申请时间', width:170,align:"center"} ,
    	{field:'examineflag', title: '审核结果', width:150,align:"center",templet: function (item) {
    		if(item.examineflag==0){
    			return "未审核";
    		}else if(item.examineflag==1){
    			return "审核通过";
    		}else if(item.examineflag==2){
    			return "审核不通过";
    		}
    	}},
    	{field:'examineman', title: '审核人', width:100,align:"center"},
    	{field:'examinetime', title: '审核时间', width:170,align:"center"},
    	{field:'failreason', title: '审核理由',width:200,align:"center"} 
    ]],
    page: true,
    limit: 10
  });
    
	//监听行工具事件
	table.on('toolbar(followTable)', function(obj){
		var  checkStatus =table.checkStatus(obj.config.id);
		switch(obj.event){
			case 'check':
				var data=JSON.stringify(checkStatus.data);
				var datas=JSON.parse(data); 
				if(datas!=""){
					var id=datas[0].id;
					if(datas[0].examineflag==0){
						var content ='<c:url value="/jsp/personel/labelcheck/check.jsp"/>?id='+id+'&menuid=${param.menuid }&personnelid='+
						datas[0].personnelid+"&applylabel2="+datas[0].applylabel2+"&applylabel1="+datas[0].applylabel1+"&applyreason="+datas[0].applyreason+
						"&cardnumber="+datas[0].cardnumber+"&personname="+datas[0].personname+"&applylabel1name="+datas[0].applylabel1name+
						"&applylabel2name="+datas[0].applylabel2name+"&addoperator="+datas[0].addoperator+"&addtime="+datas[0].addtime;
						var index = layui.layer.open({
							title : "审查人员标签信息",
							type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
							content : content,
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
						layer.alert("该数据已审核！");
					}
				}else{
					layer.alert("请先选择审查哪条数据！");
				}
			break;
		}
	});
    
    	//搜索查询
  		$("#search").click(function () {
  			console.log($("#examineflag").val());
  			table.reload('followTable', {
				where: { // 设定异步数据接口的额外参数，任意设
					addoperator: $("#addoperator").val(),
					examineflag:$("#examineflag").val()
				},
				page: {
					curr: 1
					// 重新从第 1 页开始
				}
			});
		});
 });
 
 function showinfoPersonnelExtend(personnelid){
 	var index = layui.layer.open({
		title : "人员详情",
		type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
		content : locat+'/getPersonnelExtendUpdate.do?personnelid='+personnelid+'&menuid='+${param.menuid}+'&page=showinfoWhole',
		area: ['800', '650px'],
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