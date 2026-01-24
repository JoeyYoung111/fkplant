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
 
    <title>日常管控-每月评估查询</title>
    <link rel="stylesheet" href="<c:url value="/css/viewer.css"/>"/>
    <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
   <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/js/viewer.js"/>"></script>
   <style>
 .layui-table td .layui-table-cell{
    height:90px;
   }
   .layui-form-radio {
	    padding-top:50px;
     }
      	/*layui-table 表格内容允许换行*/
	    .layui-table-main .layui-table td div:not(.laytable-cell-radio){
	        height: auto;
	        overflow:visible;
	        text-overflow:inherit;
	        white-space:normal;
	    }
	    .layui-table-fixed .layui-table-body{
	    	display:none;
	    }
</style>
 </head>
 <body>
<input type="hidden"  name="personnelid" id="personnelid"  value=${param.personnelid}></input>&nbsp;
 <script type="text/html" id="toolbarButton">
   	<button type="button" class="layui-btn layui-btn-sm" lay-event="add"><i class="layui-icon">&#xe654;</i>添 加</button>
   	<button type="button" class="layui-btn layui-btn-sm" lay-event="update"><i class="layui-icon">&#xe642;</i>修 改</button>
   	<button type="button" class="layui-btn layui-btn-sm" lay-event="cancel"><i class="layui-icon">&#xe640;</i>删 除</button>
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
		}).use(['table','flow','laydate','form','treeSelect'], function(){
			  var table = layui.table;
			  var laydate = layui.laydate;
			  var layer = layui.layer;
			  var form=layui.form;
			  var treeSelect = layui.treeSelect;
			  var flow = layui.flow;
			  form.render();
 
  //方法级渲染
  table.render({
    elem: '#followTable',
    toolbar: true,
    defaultToolbar: ['filter', 'exports', 'print'],
    url: '<c:url value="/searchKongDailyControl.do?controltype=2&personnelid="/>'+${param.personnelid},
    method:'post',
    toolbar: '#toolbarButton',
    cols: [[
        {field:'id',type:'radio',fixed:'true',width:"3%",align:"center"},
        {field:'controltime', title: '评估时间', width:"10%",align:"center"},
        {field:'controlcontent', title: '评估内容', align:"center",templet: function (item) {
				var controlcontent="";
				if(item.controlcontent!=null&&item.controlcontent!=""){
				  controlcontent= item.controlcontent.replace(/\n/g,"<br/>");
				}
				return "<div>"+controlcontent+"</div>";
           }},
        {field:'addoperatordepart', title: '派出所',width:"10%",align:"center"} ,
        {field:'addoperator', title: '评估民警',width:"8%",align:"center"} ,
        {field:'addtime', title: '填写时间',width:"10%",align:"center"}
      
    ]],
    page: true,
    limit: 10,
    done: function(res, curr, count){//数据渲染完的回调
     }
    });
    
		
		//监听行工具事件
		table.on('toolbar(followTable)', function(obj){
			var checkStatus =table.checkStatus(obj.config.id);
			switch(obj.event){
				case 'add':
			  		var index = layui.layer.open({
						title : "新增每月评估",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content : '<c:url value="/jsp/personel/kong/monthlyassessment/add.jsp?controltype=2&personnelid="/>'+${param.personnelid},
						area: ['800px', '600px'],
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
							title : "修改每月评估",
							type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
							content : locat+'/searchdailycontrolbyid.do?page=monthlyassessment&id='+id,
							area: ['800px', '600px'],
							maxmin: true,
							success : function(layero, index){
							}
						})			
						
					}else{
						layer.alert("请先选择一条修改数据！");
					}
					//layui.layer.full(index);	
			   		break;
			   	case 'cancel':
			  	var data=JSON.stringify(checkStatus.data);
				  var datas=JSON.parse(data);
				  if(datas!=""){
					  	var id=datas[0].id;
						layer.confirm('确定删除此信息？', function(index){
					      layer.close(index);
					      $.getJSON(locat+"/cancelkongdailycontrol.do?id="+id+'&menuid=0',{},function(data) {
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