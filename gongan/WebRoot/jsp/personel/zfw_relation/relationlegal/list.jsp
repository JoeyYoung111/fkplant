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
 
    <title>法人组织查询</title>
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
    	<c:if test='${fn:contains(param.buttons,"审核")}'>
			<button type="button" class="layui-btn layui-btn-sm" lay-event="check"><i class="layui-icon layui-icon-survey"></i>审核</button>
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
    url: '<c:url value="/searchrelationlegal_zfw.do?personnelid="/>'+${param.personnelid},
    method:'post',
    toolbar: '#toolbarButton',
    cols: [[
        {field:'id',type:'radio',fixed:'true',align:"center"},
        {field:'legalname', title: '机构名称', width:100,align:"center"},
        {field:'legaladdress', title: '机构地址', width:100,align:"center"},
        {field:'businessscope', title: '经营范围',align:"center"} ,
        {field:'registerdate', title: '注册日期',align:"center"} ,
        {field:'voiddate', title: '作废日期',align:"center"} ,
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
				case 'check':
			  		var data=JSON.stringify(checkStatus.data);
					var datas=JSON.parse(data);
					if(datas!=""){
						if(datas[0].validflag==1){
							var id=datas[0].id;
							layer.confirm('确定是否将此信息加入公安库中？', function(index){
						    layer.close(index);
						      $.getJSON(locat+"/checkrelationlegal_zfw.do?id="+id+'&menuid=0',{},function(data) {
								 var str = eval('(' + data + ')');
						      	 if (str.flag ==1) {		                          
								     top.layer.msg("数据审查成功！"); 	
								     table.reload('followTable', {});
						       	 }else{
									 top.layer.msg("审查失败!");
						      	 }			      	    		
						      });      
							});
						}else{
							top.layer.alert("该信息已加入公安库中！");
						}
					}else{
						top.layer.alert("请先选择一条要审查的数据！");
					}
					break;
	         }
		});
	
	
 });
</script> 
</body>

</html>