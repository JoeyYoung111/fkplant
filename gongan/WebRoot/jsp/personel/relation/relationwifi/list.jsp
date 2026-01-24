<%@ page contentType='text/html;charset=UTF-8' language='java'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 
    <title>关联WIFI查询</title>
    <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
   <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  <style>
    .layui-form-radio {
	    padding-top:14px;
     }
</style>
  </head>
 <body>

 <input type="hidden"  name="personnelid" id="personnelid"  value=${param.personnelid}></input>
 <script type="text/html" id="toolbarButton">
    <c:if test='${param.buttons==1}'>
     	<button type="button" class="layui-btn layui-btn-sm" lay-event="add"><i class="layui-icon">&#xe654;</i>添 加</button>
   	    <button type="button" class="layui-btn layui-btn-sm" lay-event="update"><i class="layui-icon">&#xe642;</i>修 改</button>
     	<button type="button" class="layui-btn layui-btn-sm" lay-event="cancel"><i class="layui-icon">&#xe640;</i>删 除</button>
    </c:if>
	</script> 
    <table class="layui-hide" id="followTable" lay-filter="followTable"></table>

<script>

$(document).ready(function(){
	  
});
var locat = (window.location+'').split('/'); 
$(function(){if('main'== locat[3]){locat =  locat[0]+'//'+locat[2];}else{locat =  locat[0]+'//'+locat[2]+'/'+locat[3];};});
       layui.config({
		    base: "<c:url value="/layui/lay/modules/"/>"
		}).extend({
		     treetable: 'treetable-lay/treetable',
		     formSelects: 'formSelects/formSelects-v4'
		}).use(['table','laydate','form','treeSelect'], function(){
			  var table = layui.table;
			  var laydate = layui.laydate;
			  var layer = layui.layer;
			  var form=layui.form;
			  var treeSelect = layui.treeSelect;
			  form.render();
 
  //方法级渲染
  table.render({
    elem: '#followTable',
    toolbar: true,
    defaultToolbar: ['filter', 'exports', 'print'],
    url: '<c:url value="/searchrelationwifi.do?personnelid="/>'+${param.personnelid},
    method:'post',
    toolbar: '#toolbarButton',
    cols: [[
        {field:'id',type:'radio',fixed:'true',align:"center"},
        {field:'relatedtype', title: '地址类型', align:"center"},
        {field:'relateddetail', title: '地址详情', align:"center"},
        {field:'ssid', title: '路由SSID', align:"center"},
        {field:'mac', title: '路由MAC', align:"center"},
        {field:'longitude', title: '经度坐标', align:"center"},
        {field:'latitude', title: '纬度坐标', align:"center"},
        {field:'isactivate', title: '是否停用',align:"center",width:100,templet: function (item) {
            if (item.isactivate=="1") {
               return "<span>是</span>";
            }else if(item.isactivate=="0"){
                return "<span>否</span>";
            }
         }}, 
        {field:'addoperator', title: '创建人', width:100,align:"center"} ,
		{field:'addtime', title: '创建时间',align:"center"},		
		{field:'updateoperator', title: '最新修改人', width:100,align:"center"},
		{field:'updatetime', title: '最新修改时间',align:"center"}
    ]],
    page: true,
    limit: 10
    });
    
		
		//监听行工具事件
		table.on('toolbar(followTable)', function(obj){
			var checkStatus =table.checkStatus(obj.config.id);
			switch(obj.event){
				case 'add':
			  		var index = layui.layer.open({
						title : "新增关联WIFI",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content : '<c:url value="/jsp/personel/relation/relationwifi/add.jsp?personnelid="/>'+${param.personnelid},
						area: ['750px', '700px'],
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
				case 'update':
			  		var data=JSON.stringify(checkStatus.data);
			  		var datas=JSON.parse(data);
					if(datas!=""){
					  	var id=datas[0].id;
					   	var index = layui.layer.open({
							title : "修改关联WIFI",
							type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
							content : locat+'/getrelationwifibyid.do?id='+id,
							area: ['750px', '700px'],
							maxmin: true,
							success : function(layero, index){
							}
						})			
						
					}else{
						layer.alert("请先选择一条修改数据！");
					}
			   		break;
			   	case 'cancel':
			  	var data=JSON.stringify(checkStatus.data);
				  var datas=JSON.parse(data);
				  if(datas!=""){
					  	var id=datas[0].id;
						layer.confirm('确定删除此信息？', function(index){
					      layer.close(index);
					      $.getJSON(locat+"/cancelrelationwifi.do?id="+id+'&menuid=0',{},function(data) {
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
						layer.alert("请先选择一条要删除的数据！");
					}
					break;
			  
	         }
		});
	
	
 });
</script> 
</body>

</html>