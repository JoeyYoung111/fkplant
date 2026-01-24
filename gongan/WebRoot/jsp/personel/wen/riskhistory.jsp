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
    url :   locat+"/searchWenRisk.do?personnelid="+${param.personnelid},
    method:'post',
    cols: [[
        {field:'conflictdetails', title: '类别', width:"100",align:"center",templet: function (item) {
        		var content="";
        		if(item.validflag==1)content+="历史";
        		else if(item.validflag==2)content+="当前";
				return "<span>"+content+"</span>";
           }},
        {field:'conflictdetails', title: '矛盾风险产生的经过、详情', width:"30%",align:"center",templet: function (item) {
				var conflictdetails=item.conflictdetails.replace(/\n/g,"<br/>")
				return "<div>"+conflictdetails+"</div>";
           }},
        {field:'riskappeal', title: '目前风险状态及人员诉求', width:"15%",align:"center",templet: function (item) {
				var riskappeal=item.riskappeal.replace(/\n/g,"<br/>")
				return "<div>"+riskappeal+"</div>";
           }},
        {field:'fileattachments', title: '文件附件', width:"15%",align:"center",templet: function (item) {
        		var risk=item,content="";
        		if(risk.fileattachments!=""){
					var riskFilesView=risk.fileattachments.split(",");
					if(riskFilesView.length>0){
						var viewname=risk.filesname.split(",");
						$.each(riskFilesView,function(index,item){
							if(index>0)content+="<br/>";
							content+='<a href="<c:url value="/downUpfile.do" />?fileid='+item+'" class="layui-table-link">'+viewname[index]+'</a>'
						});
					}
				}
				return "<div>"+content+"</div>";
           }},
        {field:'videoattachments', title: '视频附件', width:"15%",align:"center",templet: function (item) {
        		var risk=item,content="";
        		if(risk.videoattachments!=""){
        			var riskVideosView=risk.videoattachments.split(",");
					if(riskVideosView.length>0){
						var viewname=risk.videosname.split(",");
						var viewallname=risk.videosallname.split(",");
						$.each(riskVideosView,function(index,item){
							if(index>0)content+="<br/>";
							content+='<a href="javascript:void(0)" onclick="openVideo(\'/../uploadFiles/audio/'+viewallname[index]+'\')" class="layui-table-link">'+viewname[index]+'</a>';
						});
					}
				}
				return "<div>"+content+"</div>";
           }},
        {field:'addoperator', title: '修改人', width:100,align:"center"} ,
        {field:'addtime', title: '修改时间', width:160,align:"center"}
    ]],
    page: true,
    limit: 10
  });
 });
 
 function openVideo(url){
  		var html='<div><video id="video" controls preload="auto" width="100%" height="100%"><source src="'
  		+url
  		+'" type="video/mp4"></video></div>';
  		var index=layui.layer.open({
  			type:1,
  			skin:'layui-layer-rim',
  			title:"视频预览",
  			content:html,
  			area: ['600', '600px'],
  		});
  		layui.layer.full(index);
    }
</script>
</body>

</html>