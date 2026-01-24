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
    url :   locat+"/searchZaChang.do?personnelid="+${param.personnelid},
    method:'post',
    cols: [[
        {field:'validflag', title: '类别', width:"80",align:"center",templet: function (item) {
        		var content="";
        		if(item.validflag==1)content+="历史";
        		else if(item.validflag==2)content+="当前";
				return "<span>"+content+"</span>";
           }},
        {field:'personAttribute', title: '人员属性', width:"100",align:"center"},
        {field:'changMethod', title: '涉黄方式', width:"100",align:"center"},
        {field:'changType', title: '涉黄类型', width:"100",align:"center"},
        {field:'chang_scbw', title: '涉娼部位', width:"100",align:"center"},
        {field:'collectSource', title: '采集来源', width:"100",align:"center"},
        {field:'hasSechangRecord', title: '涉黄前科', width:"80",align:"center",templet: function (item) {
        		if(item.hasSechangRecord==1){
					return "<span style='color:red;'>有</span>";
				}else{
					return "<span>无</span>";
				}
           }},
        {field:'isMinorCase', title: '未成年案件', width:"90",align:"center",templet: function (item) {
        		if(item.isMinorCase==1){
					return "<span style='color:red;'>是</span>";
				}else{
					return "<span>否</span>";
				}
           }},
        {field:'phone', title: '手机号码', width:"120",align:"center"},
        {field:'homeDetail', title: '现住地址', width:"15%",align:"center",templet: function (item) {
				var addr = "";
				if(item.homeProvince) addr += item.homeProvince;
				if(item.homeCity) addr += item.homeCity;
				if(item.homeCounty) addr += item.homeCounty;
				if(item.homeTown) addr += item.homeTown;
				if(item.homeDetail) addr += item.homeDetail;
				return "<div>"+addr+"</div>";
           }},
        {field:'homePoliceStationName', title: '所属派出所', width:"100",align:"center"},
        {field:'chang_lsscqk', title: '历史涉嫖情况综述', width:"15%",align:"center",templet: function (item) {
				var chang_lsscqk = item.chang_lsscqk ? item.chang_lsscqk.replace(/\n/g,"<br/>") : "";
				return "<div>"+chang_lsscqk+"</div>";
           }},
        {field:'chang_chsj', title: '查获时间', width:"100",align:"center"},
        {field:'punishDate', title: '处罚日期', width:"100",align:"center"},
        {field:'chang_chjg', title: '查获经过', width:"15%",align:"center",templet: function (item) {
				var chang_chjg = item.chang_chjg ? item.chang_chjg.replace(/\n/g,"<br/>") : "";
				return "<div>"+chang_chjg+"</div>";
           }},
        {field:'chang_cfjg', title: '处罚结果', width:"100",align:"center"},
        {field:'chang_clxq', title: '处理详情', width:"15%",align:"center",templet: function (item) {
				var chang_clxq = item.chang_clxq ? item.chang_clxq.replace(/\n/g,"<br/>") : "";
				return "<div>"+chang_clxq+"</div>";
           }},
        {field:'caseName', title: '关联案件', width:"120",align:"center"},
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