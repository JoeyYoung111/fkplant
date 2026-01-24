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
    <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
    <style>
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
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  </head>
 <body>
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
    defaultToolbar: ['filter'],
    url :   locat+"/searchRealityShow.do?personnelid="+${param.personnelid}+"&datalabel="+${param.datalabel},
    method:'post',
    cols: [[
        {field:'conflictdetails', title: '类别', width:"100",align:"center",templet: function (item) {
        		var content="";
        		if(item.validflag==1)content+="历史";
        		else if(item.validflag==2)content+="当前";
				return "<span>"+content+"</span>";
           }},
        {field:'lifepattern', title: '日常生活规律', width:"18%",align:"center",templet: function (item) {
				var lifepattern=item.lifepattern.replace(/\n/g,"<br/>")
				return "<div>"+lifepattern+"</div>";
           }},
        {field:'healthstate', title: '健康状况', width:"18%",align:"center",templet: function (item) {
				var healthstate=item.healthstate.replace(/\n/g,"<br/>")
				return "<div>"+healthstate+"</div>";
           }},
        {field:'characteristic', title: '性格特点', width:"18%",align:"center",templet: function (item) {
				var characteristic=item.characteristic.replace(/\n/g,"<br/>")
				return "<div>"+characteristic+"</div>";
           }},
        {field:'lifehabit', title: '生活习惯', width:"18%",align:"center",templet: function (item) {
				var lifehabit=item.lifehabit.replace(/\n/g,"<br/>")
				return "<div>"+lifehabit+"</div>";
           }},
        {field:'addoperator', title: '修改人', width:100,align:"center"} ,
        {field:'addtime', title: '修改时间', width:160,align:"center"}
    ]],
    page: true,
    limit: 10
  });
 });
</script>
</body>

</html>