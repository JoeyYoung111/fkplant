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
    <title>政法委矛盾风险信息审核</title>
    <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  </head>
 <body>
<blockquote class="layui-elem-quote news_search">	
<form class="layui-form" onsubmit="return false;">
		<div class="layui-inline">
			<input class="layui-input" type="text" name="cdtname" id="cdtname" autocomplete="off" placeholder=" 标题关键词：">
		</div>
		<div class="layui-inline" >
			<div id="rkdept" name="rkdept"  style="width:400px;"></div>
		</div>
		<div class="layui-inline">
			<div id="zbdept" name="zbdept" style="width:429px;"></div>
		</div>
		<br>
		<div class="layui-inline">
			<input class="layui-input" type="text" name="cdtcontent" id="cdtcontent" autocomplete="off" placeholder=" 内容关键词：">
		</div>
		<div class="layui-inline" >
			<div id="cdttype" name="cdttype"  style="width:400px;"></div>
		</div>
		<div class="layui-inline">
			<select name="cdtresult" id="cdtresult"  style="width:200px;">
		        <option value="">处置结果：</option>
		        <option value="已钝化">已钝化</option>
		        <option value="已化解">已化解</option>
		        <option value="处置中">处置中</option>
		    </select>
		</div>
		<div class="layui-inline" >
			<select name="cdtlevel" id="cdtlevel" lay-verify="required" style="width:200px;">
		        <option value="">风险等级：</option>
		        <option value="高风险">高风险</option>
		        <option value="中风险">中风险</option>
		        <option value="低风险">低风险</option>
		        <option value="无风险">无风险</option>
		    </select>
		</div>
		<button class="layui-btn" id="search" data-type="reload"><i class="layui-icon">&#xe615;</i>搜 索</button>
		<script type="text/html" id="toolbarDemo">
			<c:if test='${fn:contains(param.buttons,"审核")}'>
				<button type="button" class="layui-btn layui-btn-sm" lay-event="check"><i class="layui-icon layui-icon-survey"></i>审核</button>
			</c:if>
			<c:if test='${fn:contains(param.buttons,"修改")}'>
				<button type="button" class="layui-btn layui-btn-sm" lay-event="update"><i class="layui-icon  layui-icon-edit"></i>修 改</button>
			</c:if>
			<c:if test='${fn:contains(param.buttons,"删除")}'>
   				<button type="button" class="layui-btn layui-btn-sm" lay-event="canel"><i class="layui-icon layui-icon-delete"></i>删 除</button>
			</c:if>
   		</script>
</form>
</blockquote>
<table class="layui-hide" id="followTable" lay-filter="followTable"></table> 
<script>
	var locat = (window.location+'').split('/'); 
	$(function(){if('main'== locat[3]){locat =  locat[0]+'//'+locat[2];}else{locat =  locat[0]+'//'+locat[2]+'/'+locat[3];};});
	layui.config({
	    base: "<c:url value="/layui/lay/modules/"/>"
	}).extend({
	    zTreeSelectM: "zTreeSelectM/zTreeSelectM"
	});
layui.use(['table','form','zTreeSelectM'], function(){
	var table = layui.table,
	zTreeSelectM = layui.zTreeSelectM,
	form = layui.form;
  
	//初始化风险类别
	var _zTreeSelectM = zTreeSelectM({
	    elem: '#cdttype',//元素容器【必填】          
	    data: '<c:url value="/getbasicMsgJSON.do"/>?basicType=39',
	    type: 'get',  //设置了长度    
	    selected: [],//默认值            
	    max: 5,//最多选中个数，默认5            
	    name: 'cdttype',//input的name 不设置与选择器相同(去#.)
	    delimiter: ',',//值的分隔符           
	    field: { idName: 'id', titleName: 'name' },//候选项数据的键名 
	    tips: '风险类别：',
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
	        }
	    }
	});
	
	$.ajax({
		type:		'POST',
		url:		'<c:url value="/getDepartmentTree.do"/>',
		dataType:	'json',
		success:	function(data){
			//初始化入库单位
			var _zTreeSelectM = zTreeSelectM({
			    elem: '#rkdept',//元素容器【必填】          
			    data: data,
			    type: 'get',  //设置了长度    
			    selected: [],//默认值            
			    max: 5,//最多选中个数，默认5            
			    name: 'rkdept',//input的name 不设置与选择器相同(去#.)
			    delimiter: ',',//值的分隔符           
			    field: { idName: 'id', titleName: 'name' },//候选项数据的键名 
			    tips: '入库单位：',
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
			        }
			    }
			});
			
			//初始化主办部门
			var _zTreeSelectM = zTreeSelectM({
			    elem: '#zbdept',//元素容器【必填】          
			    data: data,
			    type: 'get',  //设置了长度    
			    selected: [],//默认值            
			    max: 5,//最多选中个数，默认5            
			    name: 'zbdept',//input的name 不设置与选择器相同(去#.)
			    delimiter: ',',//值的分隔符           
			    field: { idName: 'id', titleName: 'name' },//候选项数据的键名 
			    tips: '主管部门：',
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
			        }
			    }
			});
		}
	});
  
  //方法级渲染
  table.render({
    elem: '#followTable',
    toolbar: true,
    defaultToolbar: ['filter', 'exports', 'print'],
    url: '<c:url value="/searchContradictionInfo_zfw.do"/>?nowstate=1&isshield=-1',
    method:'post',
    toolbar: '#toolbarDemo',
    cols: [[
    	{field:'id',type:'radio',fixed:'left'},
    	{field:'cdtname', title: '风险名称',align:"center"},
    	{field:'cdtlevel', title: '风险等级', width:90,align:"center"},
    	{field:'typename', title: '风险类别', width:200,align:"center"},
    	{field:'cdtresult', title: '处置结果', width:90,align:"center"},
    	{field:'ssrs', title: '涉事人数', width:150,align:"center"},
    	{field:'sjje', title: '涉事金额', width:90,align:"center"},
    	{field:'sponsorname', title: '主办部门', width:150,align:"center"},
    	{field:'nowstate', title: '最新状态', width:150,align:"center",templet:
    		function(item){
    			return "<span style='color: red;'>新申请（未审核）</span>";
    		}}
    ]],
    page: true,
    limit: 10
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
						title : "审查政法委风险信息",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content : '<c:url value="getContradictionInfo_zfw.do"/>?id='+id+'&menuid='+${param.menuid },
						area: ['800', '800px'],
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
				}else{
					layer.alert("请先选择审查哪条数据！");
				}
			break;
			case 'update':
			   var data=JSON.stringify(checkStatus.data);
			   var datas=JSON.parse(data);
			   if(datas!=""){
			   		var id=datas[0].id;
		   			var index = layui.layer.open({
						title : "修改矛盾风险信息",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content : '<c:url value="getContradictionInfo.do"/>?id='+id+'&buttons='+'${param.buttons }'+'&menuid='+${param.menuid }+'&page=update',
						area: ['800', '800px'],
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
				}else{
					layer.alert("请先选择修改哪条数据！");
				}
			break;
			case 'canel':
			   var data=JSON.stringify(checkStatus.data);
			   var datas=JSON.parse(data);
			    if(datas!=""){
			   var id=datas[0].id;
			    layer.confirm('确定删除此信息？', function(index){
			        layer.close(index);
			        $.getJSON('<c:url value="cancelContradictionInfo.do"/>?id='+id+'&menuid='+${param.menuid },{
						},function(data) {
						var str = eval('(' + data + ')');
			        	 if (str.flag ==1) {		                          
					     	top.layer.msg("数据删除成功！"); 	
					     	table.reload('followTable', {    
					        });                 
					     }else{
							top.layer.msg("删除失败!");
					      }			      	    		
			        	});      
					});
					}else{
						layer.alert("请先选择删除哪条数据！");
					}
			 break;
		}
	});
    
    	//搜索查询
  		$("#search").click(function () {
  			table.reload('followTable', {
				where: { // 设定异步数据接口的额外参数，任意设
					cdtlevel: $("#cdtlevel").val(),
					cdttype: $("input[name='cdttype']").val(),			
					zbdept: $("input[name='zbdept']").val(),
					cdtresult: $("#cdtresult").val(),
					isshield: $("#isshield").val(),
					cdtname: $("#cdtname").val(),
					cdtcontent: $("#cdtcontent").val(),
					rkdept: $("input[name='rkdept']").val(),
				},
				page: {
					curr: 1
					// 重新从第 1 页开始
				}
			});
		});
 });
		function showInfo(id){
			var index = layui.layer.open({
				title : "矛盾风险详情",
				type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
				content : '<c:url value="showContradictionInfo.do"/>?id='+id+'&menuid=${param.menuid }',
				area: ['800', '750px'],
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
		}
</script>
</body>

</html>