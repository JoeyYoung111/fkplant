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
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  </head>
 <body>
<blockquote class="layui-elem-quote news_search">	
<div class="demoTable">
<form class="layui-form" onsubmit="return false;" style="display:inline;">
		<div class="layui-inline" style="width:180px;" >
			<input class="layui-input" type="text" id="jurisdictpolice1" placeholder=" 管辖责任民警：" autocomplete="off" >
		</div>
		<div class="layui-inline">
			<div id="jurisdictunit1" style="width:320px;"></div>
		</div>
		<button class="layui-btn" id="search" data-type="reload"><i class="layui-icon">&#xe615;</i>搜 索</button>
		<button type="reset" id="reset" class="layui-btn"><i class="layui-icon">&#xe702;</i>重置</button>
		<script type="text/html" id="toolbarDemo">
   				<button type="button" class="layui-btn layui-btn-sm" lay-event="add"><i class="layui-icon layui-icon-add-1"></i>添 加</button>
   				<button type="button" class="layui-btn layui-btn-sm" lay-event="update"><i class="layui-icon  layui-icon-edit"></i>修 改</button>
   			    <button type="button" class="layui-btn layui-btn-sm" lay-event="cancel"><i class="layui-icon layui-icon-delete"></i>删 除</button>
   		</script>
	  <script type="text/html" id="barButton">
           <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="showinfo">详情</a>       
     </script>
</form>
</div>
</blockquote>
<table class="layui-hide" id="followTable" lay-filter="followTable"></table> 
<script>
var locat = (window.location+'').split('/'); 
var now=new Date();
Date.prototype.Format = function (fmt) { 
  var o = {
    "M+": this.getMonth() + 1, // 月份
    "d+": this.getDate(), // 日
    "h+": this.getHours(), // 小时
    "m+": this.getMinutes(), // 分
    "s+": this.getSeconds(), // 秒
    "q+": Math.floor((this.getMonth() + 3) / 3), // 季度
    "S": this.getMilliseconds() // 毫秒
  };
  if (/(y+)/.test(fmt))
    fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
  for (var k in o)
    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
      return fmt;
}
$(function(){if('main'== locat[3]){locat =  locat[0]+'//'+locat[2];}else{locat =  locat[0]+'//'+locat[2]+'/'+locat[3];};});
function fillOption(data) {
	var options = '';
	$.each(data.list, function(i, item) {
		$.each(item, function(i) {
			options += '<option value="' + this.text + '">' + this.text + '</option>';
		});
	});
	return options;
}

$(document).ready(function(){
});

layui.config({
    base: "<c:url value="/layui/lay/modules/"/>"
}).extend({
    zTreeSelectM: "zTreeSelectM/zTreeSelectM"
});
var index_search;
var sortfield="",sortdiv="",sortsql="";
layui.use(['table','form','zTreeSelectM'], function(){
  var table = layui.table,
  zTreeSelectM = layui.zTreeSelectM,
  form = layui.form;
	//初始化
	var _zTreeSelectM1 = zTreeSelectM({
	    elem: '#jurisdictunit1',//元素容器【必填】          
	    //data: '<c:url value="/getDepartmentTree.do"/>',
	    data: '<c:url value="/getDepartmentTreeBytype.do"/>?departtype=4',
	    type: 'get',  //设置了长度    
	    selected: [],//默认值            
	    max: 100,//最多选中个数，默认5            
	    name: 'jurisdictunit1',//input的name 不设置与选择器相同(去#.)
	    delimiter: ',',//值的分隔符  
	    tips:' 管辖责任单位：',         
	    field: { idName: 'id', titleName: 'name' },//候选项数据的键名 
	    zTreeSetting: { //zTree设置
	        check: {
	            enable: true,
	            chkboxType: { "Y": "", "N": "" }
	        },
	        data: {
	            simpleData: {
	                enable: false
	            },
	            key: {
	                name: 'name',
	                children: 'children'
	            }
	        },
	        view: {
	        	showIcon: false
			}
	    }
	});
  index_search= layer.msg('数据查询中，请稍候',{icon: 16,time:false,shade:0.8});
  //方法级渲染
  table.render({
    elem: '#followTable',
    toolbar: true,
   defaultToolbar: ['filter', 'print'],
    method:'post',
    data:[],
    toolbar: '#toolbarDemo',
    autoSort: false,
    cols: [[
    	{field:'id',type:'radio',fixed:'left'},//sort: true 排序
        {field:'fxname', title: '风险名称', width:120} ,
        {field:'fxtype', title: '风险类别', width:120} ,
        {field:'unitname1', title: '管辖责任单位', width:120} ,
        {field:'policename1', title: '管辖责任民警', width:120} ,
        {field:'policephone1', title: '民警电话', width:120} ,
        {field:'policename', title: '责任警种', width:120} ,
        {field:'addoperator', title: '建档人', width:90} ,
        {field:'addtime', title: '建档时间', width:170} 
        //{field: 'right', title: '操作', toolbar: '#barButton',width:65,align:"center"} 
    ]],
    page: true,
    limit: 30,
    done:function(){
    	$("#layui-table-page1").find("a").on("click",function(){
    		index_search= layer.msg('数据查询中，请稍候',{icon: 16,time:false,shade:0.8});
    	});
    	$("#layui-table-page1").find("button").on("click",function(){
    		index_search= layer.msg('数据查询中，请稍候',{icon: 16,time:false,shade:0.8});
    	});
    	$("#layui-table-page1").find("select").on("change",function(){
    		index_search= layer.msg('数据查询中，请稍候',{icon: 16,time:false,shade:0.8});
    	});
    	layer.close(index_search);
    }
  });
  //监听行工具事件
  table.on('toolbar(followTable)', function(obj){
    var  checkStatus =table.checkStatus(obj.config.id);
   switch(obj.event){
   case 'add':
   		var index = layui.layer.open({
				title : "添加涉稳人员",
				type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
				content : '<c:url value="/jsp/other/add.jsp?menuid='+${param.menuid}+'"/>',
				area: ['800', '700px'],
				maxmin: true,
				success : function(layero, index){
					setTimeout(function(){
						layui.layer.tips('点击此处返回文章列表', '.layui-layer-setwin .layui-layer-close', {
							tips: 3
						});
					},500)
				}
			})			
			layui.layer.full(index);
	    break;
   case 'update':
	    break;
	case 'cancel':
	    break;
   };
   
 });	
    	//搜索查询
  		$("#search").click(function () {
  			index_search= layer.msg('数据查询中，请稍候',{icon: 16,time:false,shade:0.8});
  			table.reload('followTable', {
				where: { 
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