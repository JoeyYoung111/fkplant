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
 
    <title>风险人员-级别调整记录查询</title>
    <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
   <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  </head>
 <body>

<blockquote class="layui-elem-quote news_search">
	<div class="demoTable">
		<form class="layui-form layui-form-pane" id="shenheform" onsubmit="return false;" action="<c:url value='/exportWenJointcontrollevel.do'/>">
			<input type="hidden" id="personnelid" name="personnelid" value="${param.personnelid }"/>
			<div class="layui-inline" style="width:210px;">
		    	<select name="homepolice" id="homepolice" lay-filter="homepolice" placeholder="管辖单位："></select>
		 	</div>
			<div class="layui-inline" style="width:170px;">
				<input type="text" name="starttime" class="layui-input" id="starttime" placeholder="上报时间段:申请时间" autocomplete="off"/>
			</div>
			 	至
			<div class="layui-inline" style="width:170px;">
			   	<input type="text" name="endtime" class="layui-input" id="endtime" placeholder="上报时间段:截止时间" autocomplete="off"/>
			</div>
		<button class="layui-btn" id="search" data-type="reload"><i class="layui-icon">&#xe615;</i>搜 索</button> 
		</form>	
	</div>
</blockquote>
<script type="text/html" id="toolbarButton">
	<button type="button" class="layui-btn layui-btn-sm" lay-event="export"><i class="layui-icon layui-icon-export"></i>导出</button>
</script> 

<table class="layui-hide" id="followTable" lay-filter="followTable"></table>

<script>

$(document).ready(function(){
	  guanxia();
	  jiazai();
});
var locat = (window.location+'').split('/'); 
$(function(){
	if('main'== locat[3]){locat =  locat[0]+'//'+locat[2];}else{locat =  locat[0]+'//'+locat[2]+'/'+locat[3];};
});

layui.config({
    base: "<c:url value="/layui/lay/modules/"/>"
}).extend({
     treetable: 'treetable-lay/treetable',
     formSelects: 'formSelects/formSelects-v4'
});
		
function guanxia(){
	$.ajax({
		type:	'post',
		url:	'<c:url value="/xiduguanxiaTree2.do"/>?departtype='+4,
		dataType:	'json',
		async:		false,
		success:	function(data){
			var options = fillOption(data);
			options = '<option value="">管辖单位：全部</option>'+options;
			$("#homepolice").html(options);
		}
	});
}
		
function jiazai(){
	layui.use(['form','table','laydate'], function(){
	  var form = layui.form;
	  var layer = layui.layer;
	  var table = layui.table;
	  var laydate = layui.laydate;
	  
	laydate.render({
		elem:	'#starttime',
		type: 'datetime',
		trigger:'click'
	});
	
	laydate.render({
		elem:	'#endtime',
		type: 'datetime',
		trigger:'click'
	});
	  
  //方法级渲染
  table.render({
    elem: '#followTable',
    toolbar: '#toolbarButton',
    defaultToolbar: ['filter', 'exports', 'print'],
    url: '<c:url value="/searchjointcontrollevel.do?personnelid="/>'+${param.personnelid},
    method:'post',
    cols: [[
      	{field:'personname', title: '姓名', width:120,align:"center"},
        {field:'cardnumber', title: '身份证号', width:180,align:"center"},
        {field:'jointcontrollevel_old', title: '联控级别(申请前)', width:130,align:"center"},
        {field:'jointcontrollevel_new', title: '联控级别(申请后)', width:130,align:"center"},
        {field:'applicantreason', title: '调整理由',align:"center"} ,
        {field:'homepolice', title: '管辖单位',width:120,align:"center"} ,
        {field:'applicant', title: '申请人',width:120,align:"center"} ,
        {field:'applicanttime', title: '申请时间',width:150,align:"center"} ,
        {field:'reviewer', title: '审核人', width:120,align:"center"} ,
		{field:'reviewertime', title: '审核时间',width:150,align:"center"},		
		{field:'examineresult', title: '审核结果', width:300,align:"center",templet: function (item) {
		     if (item.examineresult=="1") {
		             return "<span style='font-weight:900'><font color='green'>通过</font></span>";
		      }else if(item.examineresult=="2"){
		           return "<span style='font-weight:900'><font color='red'>不通过(理由："+item.memo+")</font></span>";
		      }else if(item.examineresult=="0"){
		           return "";
		      }
        }}
	    ]],
	    page:true,
	    limit:10
   });
   
   $("#search").click(function (){
		table.reload('followTable',{
			where:{
				homepolice:$("#homepolice").val(),
				starttime: $("#starttime").val(),
				endtime: $("#endtime").val()
			},
			page:{
				//重新从第一页开始
				curr:1
			}
		});
	});
	
	//toolbar 监听头部工具条事件 followTable是lay-filter属性值
	table.on('toolbar(followTable)',function(obj){
		switch(obj.event){
			case 'export':
				document.getElementById("shenheform").submit();
				break;
		};
	});
		  
    form.render();
    
});

}	
		

</script> 
</body>

</html>