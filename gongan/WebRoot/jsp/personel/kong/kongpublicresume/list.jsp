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
 
    <title>公共管控力量-本人简历</title>
    <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
   <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  
  </head>
 <body>
<input type="hidden"  name="controlpowerid" id="controlpowerid"  value=${param.controlpowerid}></input>
    <script type="text/html" id="toolbarButton">
   	    <button type="button" class="layui-btn layui-btn-sm" lay-event="add"><i class="layui-icon">&#xe654;</i>添 加</button>
    </script>
	<script type="text/html" id="kongpublicresumebar">
          <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="update">修改</a>     
         <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="cancel">删除</a> 
     </script> 
    <table class="layui-hide" id="kongpublicresume" lay-filter="kongpublicresume"></table>

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
    elem: '#kongpublicresume',
    toolbar: true,
    defaultToolbar: ['filter', 'exports', 'print'],
    url: '<c:url value="/searchKongPublicResume.do?controlpowerid="/>'+${param.controlpowerid},
    method:'post',
    toolbar: '#toolbarButton',
    cols: [[
        {field:'starttime', title: '开始时间', width:120,align:"center"},
        {field:'endtime', title: '结束时间', width:120,align:"center"},
        {field:'workdetails', title: '在何地点、部门任何职务',align:"center"},
        {field: 'right', title: '操作', toolbar: '#kongpublicresumebar',width:120,align:"center"} 
    ]],
    page: true,
    limit: 10
    });
    
		
		//监听行工具事件
		table.on('toolbar(kongpublicresume)', function(obj){
			var checkStatus =table.checkStatus(obj.config.id);
			
			switch(obj.event){
				case 'add':
			  		var index = layui.layer.open({
						title : "新增公共管控力量-个人简历",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content : '<c:url value="/jsp/personel/kong/kongpublicresume/add.jsp?controlpowerid="/>'+${param.controlpowerid},
						area: ['600px', '500px'],
						maxmin: true,
						success : function(layero, index){
						}
					})		
				 break;
			 }
		});
		//监听公共管控力量   详情按钮
	  table.on('tool(kongpublicresume)', function(obj){
		  var id = obj.data.id;
		  if(obj.event == 'update'){
		   		var index = layui.layer.open({
					title : "修改公共管控力量-个人简历",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content : locat+'/getkongpublicresumebyid.do?id='+id+'&menuid=0&page=update',
					area: ['600px', '500px'],
					maxmin: true,
					success : function(layero, index){
					}
				})			
				
		    }else if(obj.event == 'cancel'){
		          layer.confirm('确定删除此信息？', function(index){
					      layer.close(index);
					      $.getJSON(locat+"/cancelKongPublicResume.do?id="+id+'&menuid=0',{},function(data) {
							 var str = eval('(' + data + ')');
					      	 if (str.flag ==1) {		                          
							     top.layer.msg("数据删除成功！"); 	
							     table.reload('kongpublicresume', {});                 
					       	 }else{
								 top.layer.msg("删除失败!");
					      	 }			      	    		
					      });      
					});
		     }
    	});	
	
 });
</script> 
</body>

</html>