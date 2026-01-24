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
			<input class="layui-input" type="text" id="cardnumber" placeholder=" 身份证号码：" autocomplete="off" >
		</div>
		<div class="layui-inline" style="width:180px;">
			<input class="layui-input" type="text" id="personname" placeholder=" 姓名：" autocomplete="off">
		</div>
		<div class="layui-inline" style="width:150px;">
			<select id="jointcontrollevel">
				<option value=""> 联控级别: 全部</option>
			</select>
		</div>
	
		<div class="layui-inline">
			<div id="personneltype" style="width:334px;"></div>
		</div>
	<br>
		
	<div class="layui-inline" style="width:212px;">
			<input class="layui-input" type="text" id="homeplace" placeholder=" 现居住地详址：" autocomplete="off" >
		</div>
			<div class="layui-inline" style="width:180px;">
			<select id="persontype">
				<option value=""> 户籍类别: 全部</option>
			</select>
		</div>
		<div class="layui-inline" style="width:150px;">
			<select id="awaywill">
				<option value=""> 上行意愿: 全部</option>
			</select>
		</div>
		<div class="layui-inline" style="width:150px;">
			<select id="incontrollevel">
				<option value=""> 在控状态: 全部</option>
			</select>
		</div>
		<div class="layui-inline" style="width:180px;">
			<select id="gjcolor">
				<option value=""> 轨迹预警: 全部</option>
				<option value="blue">蓝色(30天内无预警)</option>
				<option value="green">绿色（12小时内）</option>
				<option value="orange">橘色（12到24小时）</option>
				<option value="red">红色（24小时外）</option>
			</select>
		</div>
	<br>
		<div class="layui-inline" style="width:212px;">
			<input class="layui-input" type="text" id="telnumber" placeholder=" 关联手机号：" autocomplete="off"  style="width:212px;" >
		</div>
		<div class="layui-inline">
			<div id="responsiblepolice" style="width:180px;"></div>
		</div>
		<div class="layui-inline" style="width:150px;" >
			<input class="layui-input" type="text" id="jurisdictpolice1" placeholder=" 管辖责任民警：" autocomplete="off" >
		</div>
		<div class="layui-inline">
			<div id="jurisdictunit1" style="width:334px;"></div>
		</div>
		<button class="layui-btn" id="search" data-type="reload"><i class="layui-icon">&#xe615;</i>搜 索</button>
		<button type="reset" id="reset" class="layui-btn"><i class="layui-icon">&#xe702;</i>重置</button>
		<script type="text/html" id="toolbarDemo">
            <c:if test='${fn:contains(param.buttons,"新增")}'>
   				<button type="button" class="layui-btn layui-btn-sm" lay-event="add"><i class="layui-icon layui-icon-add-1"></i>添 加</button>
            </c:if>
            <c:if test='${fn:contains(param.buttons,"修改")}'>
   				<button type="button" class="layui-btn layui-btn-sm" lay-event="update"><i class="layui-icon  layui-icon-edit"></i>修 改</button>
            </c:if>
            <c:if test='${fn:contains(param.buttons,"删除")}'>
   			    <button type="button" class="layui-btn layui-btn-sm" lay-event="cancel"><i class="layui-icon layui-icon-delete"></i>删 除</button>
            </c:if>
            <c:if test='${fn:contains(param.buttons,"申请")}'>
            	<button type="button" class="layui-btn layui-btn-sm" lay-event="grade"><i class="layui-icon layui-icon-survey"></i>级别调整申请</button>
            </c:if>
            <c:if test='${fn:contains(param.buttons,",审核,")}'>
                <button type="button" class="layui-btn layui-btn-sm" lay-event="examine"><i class="layui-icon layui-icon-username"></i>级别调整审核</button>
            </c:if>
            <c:if test='${fn:contains(param.buttons,"导入")}'>
            	<button type="button" class="layui-btn layui-btn-sm" lay-event="import"><i class="layui-icon">&#xe601;</i>导 入</button>   
            </c:if>
            <c:if test='${fn:contains(param.buttons,"导出")}'>
            	<button type="button" class="layui-btn layui-btn-sm" lay-event="export"><i class="layui-icon layui-icon-export"></i>导 出</button>   
            </c:if>
			<button type="button" class="layui-btn layui-btn-sm" lay-event="relationchart"><i class="layui-icon layui-icon-chart-screen"></i>关系拓扑图</button>
            <c:if test='${fn:contains(param.buttons,"打印")}'>
				<button class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more" lay-event="dy">&#xe66d; 打 印</button>
            </c:if>
 			<c:if test='${fn:contains(param.buttons,"审核记录")}'>
            	<button type="button" class="layui-btn layui-btn-sm" lay-event="shjl"><i class="layui-icon layui-icon-export"></i>审核记录</button>   
            </c:if>
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
function getjointcontrollevel(){
	$.ajax({
		type:		'POST',
		url:		'<c:url value="/getBMByTypeToJSON.do?basicType="/>'+47,
		dataType:	'json',
		async:      true,
		success:	function(data){
			var options = fillOption(data);
			$("#jointcontrollevel").append(options);
		}
	});
}
function getincontrollevel(){
	$.ajax({
		type:		'POST',
		url:		'<c:url value="/getBMByTypeToJSON.do?basicType="/>'+22,
		dataType:	'json',
		async:      true,
		success:	function(data){
			var options = fillOption(data);
			$("#incontrollevel").append(options);
		}
	});
}
function getpersontype(){
	$.ajax({
		type:		'POST',
		url:		'<c:url value="/getBMByTypeToJSON.do?basicType="/>'+20,
		dataType:	'json',
		async:      true,
		success:	function(data){
			var options = fillOption(data);
			$("#persontype").append(options);
		}
	});
}
function getawaywill(){
	$.ajax({
		type:		'POST',
		url:		'<c:url value="/getBMByTypeToJSON.do?basicType="/>'+109,
		dataType:	'json',
		async:      true,
		success:	function(data){
			var options = fillOption(data);
			$("#awaywill").append(options);
		}
	});
}
layui.config({
    base: "<c:url value="/layui/lay/modules/"/>"
}).extend({
    zTreeSelectM: "zTreeSelectM/zTreeSelectM"
});
var index_search;
$(document).ready(function(){
	getjointcontrollevel();
	getincontrollevel();
	getpersontype();
	getawaywill();
});
var sortfield="",sortdiv="",sortsql="";
layui.use(['table','form','zTreeSelectM'], function(){
  var table = layui.table,
  zTreeSelectM = layui.zTreeSelectM,
  _zTreeSelectM2,_zTreeSelectM2flag=false,
  form = layui.form;
	index_search= layer.msg('数据查询中，请稍候',{icon: 16,time:false,shade:0.8});
	//初始化
	var _zTreeSelectM1 = zTreeSelectM({
	    elem: '#jurisdictunit1',//元素容器【必填】          
	    //data: '<c:url value="/getDepartmentTree.do"/>',
	    data: '<c:url value="/getDepartmentTreeBytype.do"/>?departtype=4',
	    async:      true,
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
	
	var _zTreeSelectM3 = zTreeSelectM({
	    elem: '#responsiblepolice',//元素容器【必填】          
		data: '<c:url value="/getbasicMsgJSON.do"/>?basicType=24',
		async: true,
	    type: 'get',  //设置了长度    
	    selected: [],//默认值            
	    max: 100,//最多选中个数，默认5            
	    name: 'responsiblepolice',//input的name 不设置与选择器相同(去#.)
	    delimiter: ',',//值的分隔符  
	    tips:' 责任警种：',         
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
  
  //方法级渲染
  table.render({
    elem: '#followTable',
    toolbar: true,
   defaultToolbar: ['filter', 'print'],
    url: '<c:url value="/searchWenGrade.do"/>',
    method:'post',
    toolbar: '#toolbarDemo',
    autoSort: false,
    cols: [[
    	{field:'id',type:'radio',fixed:'left'},//sort: true 排序
    	{field:'personname', title: '姓名', width:100,templet: function (item) {
    			var color="";
				$.ajax({
					type:		'POST',
					url:		'<c:url value="/getTrajectoryKKCount.do"/>',
					data:		{
									personcard_number: item.cardnumber
								},
					dataType:	'json',
					async:      false,
					success:	function(data){
						color=data.color;
					}
				});
		   		return "<span style='font-weight:500;cursor:pointer;' onclick='showinfoWenGrade("+item.id+");'><font color='"+color+"'>"+item.personname+"</font></span>";
           }},
    	{field:'cardnumber', title: '身份证号码', width:200,templet: function (item) {
		   		var color=0;
		   		var color="";
				$.ajax({
					type:		'POST',
					url:		'<c:url value="/getTrajectoryKKCount.do"/>',
					data:		{
									personcard_number: item.cardnumber
								},
					dataType:	'json',
					async:      false,
					success:	function(data){
						color=data.color;
					}
				});
		   		return "<span style='font-weight:500;cursor:pointer;' onclick='showinfoWenGrade("+item.id+");'><font color='"+color+"'>"+item.cardnumber+"</font></span>";
           }} ,
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
        {field:'homeplace', title: '现居住地详址', width:120} ,
        {field:'unitname1', title: '管辖责任单位', width:120} ,
        {field:'policename1', title: '管辖责任民警', width:120} ,
        {field:'policephone1', title: '民警电话', width:120} ,
        {field:'typename', title: '人员子标签', width:120,templet: function (item) {
          		var str="";
	               if(item.typename!=null&&item.typename!=""){
		               		var zslabel2s=item.typename.split(",");
		               		for(var i=0;i<zslabel2s.length;i++){
			               		if(zslabel2s[i]!=""){
				               		$.ajax({
										type:		'POST',
										url:		'<c:url value="/getAttributeLabelByLabelid.do"/>',
										data:		{
														id: zslabel2s[i]
													},
										dataType:	'json',
										async:      false,
										success:	function(data){
											if(data!=null&&data.attributelabel!="")str+="<span><font color='black'>"+data.attributelabel+"&nbsp;&nbsp;</font></span>";
										}
									});
			               		}
		               		}
		               }
                return str;
           }} ,
        {field:'policename', title: '责任警种', width:120} ,
        {field:'jointcontrollevel', title: '联控级别', width:90,templet: function (item) {
          		if(item.jointcontrollevel=='一级'){
					return item.jointcontrollevel+"<image style='padding-bottom:6px' src='"+locat+"/images/fivestar.png'></image>";
				}else if(item.jointcontrollevel=='二级'){
				    return item.jointcontrollevel+"<image style='padding-bottom:6px' src='"+locat+"/images/triangle.png'></image>";
				}else if(item.jointcontrollevel=='三级'){
				    return item.jointcontrollevel+"<image style='padding-bottom:6px' src='"+locat+"/images/circle.png'></image>";
				}else{
				   return item.jointcontrollevel!=null?item.jointcontrollevel:""; 
				}
				
           }},
        {field:'awaywill', title: '上行意愿', width:100,align:'center'} ,
        {field:'incontrollevel', title: '在控状态', width:90} ,
        {field:'maintainrate1', title: '维护率', width:80,templet: function (item) {
<%--				var maintainrate1="";--%>
<%--				$.ajax({--%>
<%--					type:		'POST',--%>
<%--					url:		'<c:url value="/getMaintainrateByPersonnelid.do"/>',--%>
<%--					data:		{--%>
<%--									personlabel: 1,--%>
<%--									personnelid: item.personnelid--%>
<%--								},--%>
<%--					dataType:	'json',--%>
<%--					async:      false,--%>
<%--					success:	function(data){--%>
<%--						maintainrate1=data.totalpoints;--%>
<%--					}--%>
<%--				});--%>
				return "<span>"+item.maintainrate1+"%</span>";
           }} ,
        {field:'jointcontrollevelapply', title: '级别调整', width:130,templet: function (item) {
			   if (item.jointcontrollevelapply=="0") {
		             return "";
		         }else if(item.jointcontrollevelapply=="1"){
		           return "<span style='font-weight:900;cursor:pointer;' onclick='openjointcontrollevel("+item.personnelid+");'><font color='red'>新申请(未审核)</font></span>";
		         }else if(item.jointcontrollevelapply=="2"){
		           return "<span style='font-weight:900;cursor:pointer;' onclick='openjointcontrollevel("+item.personnelid+");'><font color='green'>已审核(通过)</font></span>";
		         
		         }else if(item.jointcontrollevelapply=="3"){
		         return "<span style='font-weight:900;cursor:pointer;' onclick='openjointcontrollevel("+item.personnelid+");'><font color='blue'>已审核(不通过)</font></span>";
		           
		         }
           }} ,
        {field:'addoperator', title: '建档人', width:90} ,
        {field:'addtime', title: '建档时间', width:170} 
        //{field: 'right', title: '操作', toolbar: '#barButton',width:65,align:"center"} 
    ]],
    page: true,
    limit: 30,
    done:function(){
    	if(!_zTreeSelectM2flag){
			_zTreeSelectM2 = zTreeSelectM({
			    elem: '#personneltype',//元素容器【必填】          
				data: '<c:url value="/getChildrenLabelByParentid.do"/>?parentid='+1,
			    type: 'get',  //设置了长度    
				async: true,
			    selected: [],//默认值            
			    max: 100,//最多选中个数，默认5            
			    name: 'personneltype',//input的name 不设置与选择器相同(去#.)
			    delimiter: ',',//值的分隔符  
			    tips:' 人员子标签：',         
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
			_zTreeSelectM2flag=true;
		}
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
	 			if(field!=0&&field!=sortfield&&(field=="addtime"||field=="maintainrate1"||field=="awaywill")){
		  			sortfield=field;
		  			if(sortdiv!="")sortdiv.remove();
		  			sortdiv=$('<span class="layui-table-sort layui-inline" lay-sort="asc"><i class="layui-edge layui-table-sort-asc" title="升序"></i><i class="layui-edge layui-table-sort-desc" title="降序"></i></span>');
		  			$(this).find("div").append(sortdiv);
		  			$(this).click();
	 			}
		});
		form.render();
    }
  });
  //触发排序事件 
	table.on('sort(followTable)', function(obj){ //注：sort 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
  	  if(obj.type!=null){
  	  	if(obj.field=="awaywill")sortsql="ORDER BY FIELD(ifnull(gt.awaywill,''),'高','中','低','')";
  	  	else sortsql="ORDER BY "+obj.field+" "+obj.type;
  	  }
  	  else{
  	  	if(obj.field=="awaywill")sortsql="ORDER BY FIELD(ifnull(gt.awaywill,''),'低','中','高','')";
  	  	else sortsql="ORDER BY "+obj.field+" asc";
  	  } 
  	  
	  sortdiv.attr("lay-sort",obj.type!=null?obj.type:"asc");
	  index_search= layer.msg('数据查询中，请稍候',{icon: 16,time:false,shade:0.8});
 		table.reload('followTable', {
			initSort: obj,
			where: { 
				cardnumber: $("#cardnumber").val(),
				personname: $("#personname").val(),
				homeplace: $("#homeplace").val(),
				unitname1: $("input[name='jurisdictunit1']").val(),
				policename1: $("#jurisdictpolice1").val(),
				personneltype: $("input[name='personneltype']").val(),
				responsiblepolice: $("input[name='responsiblepolice']").val(),
				jointcontrollevel: $("#jointcontrollevel").val()==""?"1":$("#jointcontrollevel").val(),
				awaywill: $("#awaywill").val(),
				incontrollevel: $("#incontrollevel").val(),
				persontype: $("#persontype").val(),
				color: $("#gjcolor").val(),
				telnumber:	$("#telnumber").val(),
				sortsql:	sortsql
			},
			page: {
				curr: 1
				// 重新从第 1 页开始
			}
		});
	});
  table.on('event(followTable)',function(obj){
  		console.log(obj)
  });
  //监听行工具事件
  table.on('toolbar(followTable)', function(obj){
    var  checkStatus =table.checkStatus(obj.config.id);
   switch(obj.event){
   case 'add':
   		var index = layui.layer.open({
				title : "添加涉稳人员",
				type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
				content : locat+'/getWenGradeUpdate.do?id=0&page=add&menuid='+${param.menuid },
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
	   var data=JSON.stringify(checkStatus.data);
	   var datas=JSON.parse(data);
	   if(datas!=""){
	   var id=datas[0].id;
	    var index = layui.layer.open({
					title : "修改涉稳人员",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content : locat+'/getWenGradeUpdate.do?id='+id+'&buttons='+'${param.buttons }'+'&page=update&menuid='+${param.menuid },
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
						$("#search").click(); 
					}
				})			
				layui.layer.full(index);
				}else{
					top.layer.alert("请先选择修改哪条数据！");
				}
	    break;
	case 'cancel':
	   var data=JSON.stringify(checkStatus.data);
	   var datas=JSON.parse(data);
	    if(datas!=""){
	   var id=datas[0].id;
	   var personnelid=datas[0].personnelid;
	    layer.confirm('确定删除此涉稳人员信息？', function(index){
	        layer.close(index);
	        $.getJSON(locat+"/cancelWenGrade.do?id="+id+"&personnelid="+personnelid+"&menuid="+${param.menuid },{},function(data) {
				var str = eval('(' + data + ')');
	        	 if (str.flag ==1) {		                          
			          top.layer.msg("数据删除成功！"); 	
			          $("#search").click();               
			       }else{
				       top.layer.msg("删除失败!");
			      }			      	    		
	        	});      
			});
			}else{
				top.layer.alert("请先选择删除哪条数据！");
				}
	    break;
	   case 'grade':
	   var data=JSON.stringify(checkStatus.data);
	   var datas=JSON.parse(data);
	     if(datas!=""){
	       var personnelid=datas[0].personnelid;
	       var jointcontrollevel=datas[0].jointcontrollevel;
	       if(jointcontrollevel==null){
	            jointcontrollevel="";
	        }
	   $.getJSON(locat+"/getjointcontrollevelCount.do?personnelid="+personnelid,{},function(data) {
				var str = eval('(' + data + ')');
	        	 if (str.flag>0) {		                          
			               top.layer.msg("该人员存在未审核联控级别调整申请，不可重复申请......");
			      }else{
				    var index = layui.layer.open({
					title : "联控级别调整申请",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content : '<c:url value="/jsp/personel/wen/jointcontrollevel/add.jsp?menuid='+${param.menuid}+'&personnelid='+personnelid+'&jointcontrollevel_old='+jointcontrollevel+'"/>',
					area: ['800', '750px'],
					maxmin: true,
					success : function(layero, index){
						setTimeout(function(){
							layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
								tips: 3
							});
						},500)
					}
				})			
			      }			      	    		
	       });      
	   }else{
			  top.layer.alert("请先选择修改哪条数据！");
		  }
	    break;
	    case 'examine':
	   var data=JSON.stringify(checkStatus.data);
	   var datas=JSON.parse(data);
	     if(datas!=""){
	   var personnelid=datas[0].personnelid;
	   $.getJSON(locat+"/getjointcontrollevelCount.do?personnelid="+personnelid,{},function(data) {
				var str = eval('(' + data + ')');
	        	 if (str.flag>0) {		                          
			               var index = layui.layer.open({
							title : "联控级别调整审核",
							type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
							content : '<c:url value="/getjointcontrollevelNew.do?personnelid='+personnelid+'"/>',
							offset:['50'],
							area: ['1000px', '750px'],
							maxmin: true,
							success : function(layero, index){
								setTimeout(function(){
									layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
										tips: 3
									});
								},500)
							}
						})	
			      }else{
				       top.layer.msg("该人员暂无需要审核的联控级别调整申请!");
			      }
	        	});
	     }else{
			  top.layer.alert("请选择一条你要审核的数据！");
		  }
	    break;
	   case 'export':
	   	var index =	layui.layer.open({
			title : "涉稳人员信息导出",
			type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
			content : '<c:url value="/jsp/personel/wen/export.jsp?menuid='+${param.menuid}+'"/>',
			area: ['1000px', '600px'],
			maxmin: true,
			offset:['80'], 
			success : function(layero, index){
				setTimeout(function(){
					layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
						tips: 3
					});
				},500)
			}
		});
	   	break;
	   	case 'import':
		   var index = layui.layer.open({
				 title : "导入涉稳人员信息",
				 type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
				 content : "<c:url value="/jsp/personel/wen/import.jsp?menuid=${param.menuid }"/>",
				  area: ['600', '600'],
				 maxmin: true,
				 offset:['80'], 
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
		case 'relationchart':
			var data=JSON.stringify(checkStatus.data);
	   		var datas=JSON.parse(data);
	     	if(datas!=""){
	     		var personnelid=datas[0].personnelid;
	     		var index = layui.layer.open({
					title : "关系拓扑图",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content : '<c:url value="getRelationchart.do"/>?personnelid='+personnelid,
					area: ['800', '800px'],
					maxmin: true,
					success : function(layero, index){
						setTimeout(function(){
							layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
								tips: 3
							});
						},500)
					}
				});
				layui.layer.full(index);
	     	}else{
				top.layer.alert("请选择一条要生成拓扑图的数据！");
		  	}
		break;
		case 'dy':
			var data=JSON.stringify(checkStatus.data);
			var datas=JSON.parse(data);
			if(datas!=""){
				var id=datas[0].id;
				window.location.href='<c:url value="/printWenGrade.do"/>?id='+id;
				return false;
			}else{
				layer.alert("请先选择数据！");
			}
		break;
		case 'shjl':
			var index = layui.layer.open({
				title : "风险人员-级别调整记录",
				type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
				content :locat+"/jsp/personel/wen/jointcontrollevel/list.jsp?personnelid=0",
				area: ['1000px', '700px'],
				maxmin: true,
				success : function(layero, index){}
			});
			layui.layer.full(index);
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
					homeplace: $("#homeplace").val(),
					unitname1: $("input[name='jurisdictunit1']").val(),
					policename1: $("#jurisdictpolice1").val(),
					personneltype: $("input[name='personneltype']").val(),
					responsiblepolice: $("input[name='responsiblepolice']").val(),
					jointcontrollevel: $("#jointcontrollevel").val()==""?"1":$("#jointcontrollevel").val(),
					awaywill: $("#awaywill").val(),
					incontrollevel: $("#incontrollevel").val(),
					persontype: $("#persontype").val(),
					color: $("#gjcolor").val(),
					telnumber:	$("#telnumber").val()
				},
				page: {
					curr: 1
					// 重新从第 1 页开始
				}
			});
		});
		
		//重置按钮......
  	   $('form').find(':reset').click(function(){
		        //$('form')[0].reset();
				 //_zTreeSelectM2.set([0]);//默认值
				 //return false;
	});
		
		//监听行工具事件
	  table.on('tool(followTable)', function(obj){
		  var id = obj.data.id;
		  if(obj.event === 'showinfo'){
		   		var index = layui.layer.open({
					title : "风险人员-涉稳详情",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content : locat+'/getWenGradeUpdate.do?id='+id+'&menuid='+${param.menuid}+'&page=showinfo',
					area: ['800', '750px'],
					maxmin: true,
					success : function(layero, index){
						setTimeout(function(){
							layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
								tips: 3
							});
						},500)
					}
				})			
				layui.layer.full(index);
		    }
    	});	
		
 });
 
 function showinfoWenGrade(id){
 	var index = layui.layer.open({
		title : "风险人员-涉稳详情",
		type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
		content : locat+'/getWenGradeUpdate.do?id='+id+'&menuid='+${param.menuid}+'&page=showinfo',
		area: ['800', '650px'],
		maxmin: true,
		success : function(layero, index){
			setTimeout(function(){
				layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
					tips: 3
				});
			},500)
		}
	})			
	layui.layer.full(index);
 }
 
 function openjointcontrollevel(personnelid){
      var index = layui.layer.open({
		title : "风险人员-级别调整记录",
		type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
		content :locat+"/jsp/personel/wen/jointcontrollevel/list.jsp?personnelid="+personnelid,
		area: ['1000px', '800px'],
		maxmin: true,
		success : function(layero, index){}
  		});
		layui.layer.full(index);	      
  }
</script>
</body>

</html>