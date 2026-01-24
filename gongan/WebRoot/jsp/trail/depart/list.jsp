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
    <title>全国民航离港信息</title>
    <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  </head>
  <style>
     /*layui-table 表格内容允许换行*/
     .layui-table-main .layui-table div{
         height: auto;
         overflow:visible;
         text-overflow:inherit;
         white-space:normal;
     }
     .layui-table-cell .layui-form-checkbox[lay-skin=primary] {
	    top: 3px;
	 }
     .layui-table-fixed .layui-table-body{
      display:none;
     }
   </style>
 <body>
<blockquote class="layui-elem-quote news_search">	
<div class="demoTable">
<form class="layui-form" onsubmit="return false;" style="display:inline;">
	
		<div class="layui-inline">
			<input class="layui-input" type="text" id="cardnumber" placeholder=" 身份证号：" autocomplete="off" >
		</div>
		<div class="layui-inline">
			<input class="layui-input" type="text" id="personname" placeholder=" 姓名：" autocomplete="off" >
		</div>
		<button class="layui-btn" id="search" data-type="reload"><i class="layui-icon">&#xe615;</i>搜 索</button>
		<script type="text/html" id="toolbarDemo">
   			<c:if test='${fn:contains(param.buttons,"删除")}'>
   			<button type="button" class="layui-btn layui-btn-sm" lay-event="cancel"><i class="layui-icon layui-icon-delete"></i>删 除</button>
		</c:if>
		<c:if test='${fn:contains(param.buttons,"导入")}'>
            <button type="button" class="layui-btn layui-btn-sm" lay-event="import"><i class="layui-icon">&#xe601;</i>导 入</button>   
		</c:if>
		<c:if test='${fn:contains(param.buttons,"导出")}'>
            <button type="button" class="layui-btn layui-btn-sm" lay-event="export"><i class="layui-icon layui-icon-export"></i>导 出</button>
		</c:if>
   		</script>
</form>
</div>
</blockquote>
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
	//初始化
  
  //方法级渲染
  table.render({
    elem: '#followTable',
    toolbar: true,
   	defaultToolbar: ['filter', 'print'],
    url: '<c:url value="/searchTrailInformation.do"/>',
    where: { 
				cardnumber: $("#cardnumber").val(),
				personname: $("#personname").val(),
				trailtype:	3
			},
    method:'post',
    toolbar: '#toolbarDemo',
    cols: [[
    	{type:'checkbox'},//sort: true 排序
    	{field:'personname', title: '姓名', width:80},
        {field:'sexes', title: '性别', width:65} , 
        {field:'cardnumber', title: '年龄', width:65,templet: function (item) {
          		var age=now.getFullYear();
				var cardnumber=item.cardnumber.toString();
				var length=cardnumber.length;
				if(length==15){
					age-=parseInt(cardnumber.substring(6,8))+1900;
					age++;
				}else if(length==18){
					age-=parseInt(cardnumber.substring(6,10));
					age++;
				}else{
				   age=''; 
				}
				return "<span>"+age+"</span>";
           }},
        
    	{field:'cardnumber', title: '身份证号码', width:180} ,
        {field:'parameter1', title: '民族', width:100} ,
        {field:'parameter2', title: '航空公司编号', width:120} ,
        {field:'parameter3', title: '航班号', width:100} ,
        {field:'parameter4', title: '航班日期', width:120} ,
        {field:'parameter5', title: '证件类型', width:120} ,
        {field:'parameter6', title: '起飞港站', width:150} ,
        {field:'parameter7', title: '到达港站', width:150} ,
        {field:'parameter8', title: '座位号', width:80} ,
        {field:'parameter9', title: '离港时间', width:120} ,
        {field:'parameter10', title: '航空公司', width:120} ,
        {field:'parameter11', title: '证件号码', width:180} ,
        {field:'parameter12', title: '英文名字', width:120} ,
        {field:'parameter13', title: '旅客姓', width:100} ,
        {field:'parameter14', title: '旅客名', width:100} ,
        {field:'addoperator', title: '导入人', width:90} ,
        {field:'addtime', title: '导入时间', width:170} 
    ]],
    page: true,
    limit: 10
  });
  
  //监听行工具事件
  table.on('toolbar(followTable)', function(obj){
    var  checkStatus =table.checkStatus(obj.config.id);
   switch(obj.event){
	case 'cancel':
	   var data=JSON.stringify(checkStatus.data);
	   var datas=JSON.parse(data);
	   if(datas.length>0){
		   layer.confirm('确定删除勾选信息？', function(index){
		       layer.close(index);
			   var ids=[];
			   for(var i=0;i<datas.length;i++){
			   		ids.push(datas[i].id)
			   }
		       $.getJSON(locat+"/cancelTrailInformation.do?ids="+ids.join(",")+"&trailtype=3&menuid="+${param.menuid },{},function(data) {
					var str = eval('(' + data + ')');
		        	 if (str.flag ==1) {		                          
				          top.layer.msg("数据删除成功！"); 	
				          table.reload('followTable', { });                 
				       }else{
					       top.layer.msg("删除失败!");
				      }			      	    		
	        	});      
			});
		}else{
			layer.alert("请先勾选需要删除的数据！");
		}
	    break;
<%--	   case 'export':--%>
<%--	   	var index = layui.layer.open({--%>
<%--			title : "全国银行信息导出",--%>
<%--			type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）--%>
<%--			content : '<c:url value="/jsp/trail/bank/export.jsp?menuid='+${param.menuid}+'"/>',--%>
<%--			area: ['1000px', '600px'],--%>
<%--			maxmin: true,--%>
<%--			success : function(layero, index){--%>
<%--				setTimeout(function(){--%>
<%--					layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {--%>
<%--						tips: 3--%>
<%--					});--%>
<%--				},500)--%>
<%--			}--%>
<%--		});--%>
<%--	   	break;--%>
	   	case 'import':
		   var index = layui.layer.open({
				 title : "导入全国民航离港信息",
				 type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
				 content : '<c:url value="/jsp/trail/import.jsp?trailtype=3"/>',
				  area: ['600', '650'],
				 maxmin: true,
				 offset:['30'], 
				 btn:['导入','关闭'],
				 yes:function(index,layero){   //通过回调得到iframe的值
				  var body = layer.getChildFrame('body',index);//建立父子联系
			                 var iframeWin = window[layero.find('iframe')[0]['name']];              
			                 body.find("#btns").click();
				 },
				end: function () {
					$("#search").click(); 
				}
			 });	
		    break;
   };
   
 });	
    	//搜索查询
  		$("#search").click(function () {
  			table.reload('followTable', {
				where: { 
					cardnumber: $("#cardnumber").val(),
					personname: $("#personname").val(),
					trailtype:	3
				},
				page: {
					curr: 1
					// 重新从第 1 页开始
				}
			});
		});
 });
 
 
</script>
</body>

</html>