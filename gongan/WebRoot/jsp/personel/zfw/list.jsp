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
    <title>涉稳人员信息</title>
    <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  </head>
 <body>
<blockquote class="layui-elem-quote news_search">	
<div class="demoTable">
<form class="layui-form" onsubmit="return false;" style="display:inline;">
	
		<div class="layui-inline" style="width:212px;">
			<input class="layui-input" type="text" id="cardnumber" placeholder=" 身份证号：" autocomplete="off" >
		</div>
		<div class="layui-inline" style="width:212px;">
			<input class="layui-input" type="text" id="personname" placeholder=" 姓名：" autocomplete="off" >
		</div>
		<div class="layui-inline">
			<div id="jdunit1" style="width:320px;"></div>
		</div>
		<br>
		<div class="layui-inline" style="width:212px;">
			<select id="persontype">
				<option value=""> 户籍类别: 全部</option>
			</select>
		</div>
		<div class="layui-inline" style="width:297px;">
			<input class="layui-input" type="text" id="homeplace" placeholder=" 现居住地详址：" autocomplete="off" >
		</div>
		<button class="layui-btn" id="search" data-type="reload"><i class="layui-icon">&#xe615;</i>搜 索</button>
		<button type="reset" id="reset" class="layui-btn"><i class="layui-icon">&#xe702;</i>重置</button>
		<script type="text/html" id="toolbarDemo">
            <c:if test='${fn:contains(param.buttons,"审核")}'>
				<button type="button" class="layui-btn layui-btn-sm" lay-event="check"><i class="layui-icon layui-icon-survey"></i>审核</button>
			</c:if>
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
function getpersontype(){
	$.ajax({
		type:		'POST',
		url:		'<c:url value="/getBMByTypeToJSON.do?basicType="/>'+20,
		dataType:	'json',
		async:      false,
		success:	function(data){
			var options = fillOption(data);
			$("#persontype").append(options);
		}
	});
}

$(document).ready(function(){
	getpersontype();
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
	    elem: '#jdunit1',//元素容器【必填】          
	    //data: '<c:url value="/getDepartmentTree.do"/>',
	    data: '<c:url value="/getDepartmentTreeBytype.do"/>?departtype=4',
	    type: 'get',  //设置了长度    
	    selected: [],//默认值            
	    max: 100,//最多选中个数，默认5            
	    name: 'jdunit1',//input的name 不设置与选择器相同(去#.)
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
    url: '<c:url value="/searchZfwPersonnel.do"/>',
    method:'post',
    toolbar: '#toolbarDemo',
    autoSort: false,
    cols: [[
    	{field:'id',type:'radio',fixed:'left'},//sort: true 排序
    	{field:'personname', title: '姓名', width:100},
    	{field:'cardnumber', title: '身份证号码', width:200} ,
        {field:'sexes', title: '性别', width:65} , 
        {field:'officeName', title: '年龄', width:65,templet: function (item) {
          		var age=now.getFullYear();
				var cardnumber=item.cardnumber.toString();
				var length=cardnumber.length;
				if(length==15){
					age-=parseInt(cardnumber.substring(6,8))+1900;
					if(parseInt(cardnumber.substring(8,12))>parseInt(new Date().Format("MMdd")))age--;
				}else if(length==18){
					age-=parseInt(cardnumber.substring(6,10));
					if(parseInt(cardnumber.substring(10,14))>parseInt(new Date().Format("MMdd")))age--;
				}else{
				   age=''; 
				}
				return "<span>"+age+"</span>";
           }},
        {field:'persontype', title: '户籍类别', width:90} ,
        {field:'homeplace', title: '现居住地详址'} ,
        {field:'jurisdictunit', title: '管辖责任单位', width:120} ,
        {field:'addoperator', title: '建档人', width:90} ,
        {field:'addtime', title: '建档时间', width:170} 
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
    	if(sortfield!=""&&sortdiv!=""){
    		$("#followTable").next().find("table>thead>tr>th[data-field="+sortfield+"]").find("div").append(sortdiv);
    	}
    	$("#followTable").next().find("table>thead>tr>th").css("cursor","pointer");
    	$("#followTable").next().find("table>thead>tr>th").click(function () {
	 			var field=$(this).attr("data-field");
	 			if(field!=0&&field!=sortfield&&(field=="addtime")){
		  			sortfield=field;
		  			if(sortdiv!="")sortdiv.remove();
		  			sortdiv=$('<span class="layui-table-sort layui-inline" lay-sort="asc"><i class="layui-edge layui-table-sort-asc" title="升序"></i><i class="layui-edge layui-table-sort-desc" title="降序"></i></span>');
		  			$(this).find("div").append(sortdiv);
		  			$(this).click();
	 			}
		});
    }
  });
  	
  	//触发排序事件 
	table.on('sort(followTable)', function(obj){ //注：sort 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
  	  if(obj.type!=null)sortsql="ORDER BY "+obj.field+" "+obj.type;
  	  else sortsql="ORDER BY "+obj.field+" asc";
	  sortdiv.attr("lay-sort",obj.type!=null?obj.type:"asc");
	  index_search= layer.msg('数据查询中，请稍候',{icon: 16,time:false,shade:0.8});
 		table.reload('followTable', {
			initSort: obj,
			where: { 
				cardnumber: $("#cardnumber").val(),
				personname: $("#personname").val(),
				jdunit1: $("input[name='jdunit1']").val(),
				persontype: $("#persontype").val(),
				homeplace: $("#homeplace").val(),
				sortsql:	sortsql
			},
			page: {
				curr: 1
				// 重新从第 1 页开始
			}
		});
	});
	
  //监听行工具事件
  table.on('toolbar(followTable)', function(obj){
	var  checkStatus =table.checkStatus(obj.config.id);
	switch(obj.event){
		case 'check':
			var data=JSON.stringify(checkStatus.data);
			var datas=JSON.parse(data);
	   		if(datas!=""){
	   			var id=datas[0].id;
	    		var index = layui.layer.open({
					title : "审查政法委涉稳人员",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content : locat+'/getZfwPersonById.do?id='+id+'&menuid='+${param.menuid},
					area: ['800', '750px'],
					maxmin: true,
					success : function(layero, index){
						setTimeout(function(){
							layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
								tips: 3
							});
						},500)
					},
					cancel:function(){
						//$("#search").click(); 
					}
				});			
				layui.layer.full(index);
			}else{
				top.layer.alert("请先选择修改哪条数据！");
			}
		break;
	};
 });	
    	//搜索查询
  		$("#search").click(function () {
  			index_search= layer.msg('数据查询中，请稍候',{icon: 16,time:false,shade:0.8});
  			table.reload('followTable', {
				where: { 
					cardnumber: $("#cardnumber").val(),
					personname: $("#personname").val(),
					jdunit1: $("input[name='jdunit1']").val(),
					persontype: $("#persontype").val(),
					homeplace: $("#homeplace").val()
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