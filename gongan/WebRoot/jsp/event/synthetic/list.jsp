<%@ page contentType='text/html;charset=UTF-8' language='java'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ page import="com.aladdin.model.UserSession"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
UserSession userSession = (UserSession) session.getAttribute("userSession");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>工作交办信息管理</title>
    <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
     <link rel="stylesheet" href="<c:url value="/css/public.css"/>"  media="all" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
   <script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  </head>
  <style>
     /*layui-table 表格内容允许换行*/
     .layui-table-main .layui-table td[data-field="filenames"] div:not(.laytable-cell-radio){
         height: auto;
         overflow:visible;
         text-overflow:inherit;
         white-space:normal;
     }
     .layui-table-fixed .layui-table-body{
      display:none;
     }
     .my-tab-title li {
     width:15%
     }
   </style>
 <body class="childrenBody layui-fluid">
<div class="layui-tab my-tab layui-tab-brief" lay-filter="syntheticTabs">
  <ul class="layui-tab-title my-tab-title">
    <li class="layui-this"><font size="4">引发涉稳事件</font></li>
    <li><font size="4">情报线索信息</font></li>
    <li><font size="4">稳控化解情况</font></li>
    <li><font size="4">工作交办信息</font></li>
    <li><font size="4">推动化解处置</font></li>
    <li><font size="4">矛盾主要组织人员</font></li>
  </ul>

  
  <div class="layui-tab-content" style="height: 90%;">
    <div class="layui-tab-item layui-show">
    	<blockquote class="layui-elem-quote news_search">	
			<form class="layui-form" onsubmit="return false;">
				
				<div class="layui-inline" style="width:200px;">
					<input class="layui-input" type="text" id="cdtname" autocomplete="off" placeholder=" 风险名称：">
				</div>
				<div class="layui-inline" style="width:405px;">
					<div id="cdttype" name="cdttype"></div>
				</div>
				<div class="layui-inline" style="width:200px;">
					<input class="layui-input" type="text" id="sfbw" name="sfbw" lay-filter="sfbw">
				</div>
				<br>
				<div class="layui-inline" style="width:200px;">
					<select id="cdtlevel">
				 		<option value="">风险等级：</option>
				        <option value="高风险">高风险</option>
				        <option value="中风险">中风险</option>
				        <option value="低风险">低风险</option>
				        <option value="无风险">无风险</option>
				 	</select>
				</div>
				<div class="layui-inline" style="width:200px;">
					<input class="layui-input" type="text" id="etitle" autocomplete="off" placeholder=" 事件标题：">
				</div>
				<div class="layui-inline" style="width:200px;">
					<input class="layui-input" type="text" id="sjgk" autocomplete="off" placeholder=" 事件概况：">
				</div>
			   <div class="layui-inline" style="width:200px;">
					<select id="xwfs"  name="xwfs">
				 		<option value="">行为方式：</option>
				 	</select>
				</div>
				
				<button class="layui-btn" id="search" data-type="reload"><i class="layui-icon">&#xe615;</i>搜 索</button>
			</form>
		</blockquote>
    	<table class="layui-hide" id="swsj" lay-filter="swsj"></table>
	</div>
    <div class="layui-tab-item">
    	<blockquote class="layui-elem-quote news_search">	
			<form class="layui-form" onsubmit="return false;">
				<div class="layui-inline" style="width:200px;">
					<input class="layui-input" type="text" id="qbxscdtname" autocomplete="off" placeholder=" 风险名称：">
				</div>
				<div class="layui-inline" style="width:405px;">
					<div id="qbxscdttype" name="qbxscdttype"></div>
				</div>
				<div class="layui-inline" style="width:200px;">
					<select id="qbxslpointto">
				 		<option value="">线索指向：</option>
				 		<option value="来市">来市</option>
				 		<option value="赴省">赴省</option>
				 		<option value="进京">进京</option>
				 		<option value="其他">其他</option>
				 	</select>
				</div>
			
				<br>
				<div class="layui-inline" style="width:200px;">
					<select id="qbxscdtlevel">
				 		<option value="">风险等级：</option>
				        <option value="高风险">高风险</option>
				        <option value="中风险">中风险</option>
				        <option value="低风险">低风险</option>
				        <option value="无风险">无风险</option>
				 	</select>
				</div>
				<div class="layui-inline" style="width:200px;">
					<input class="layui-input" type="text" id="qbxsltitle" autocomplete="off" placeholder=" 线索标题：">
				</div>
				<div class="layui-inline" style="width:200px;">
					<input class="layui-input" type="text" id="qbxslcontent" autocomplete="off" placeholder=" 线索内容：">
				</div>
				<div class="layui-inline" style="width:200px;">
					<select id="qbxslsource">
				 		<option value="">线索来源：</option>
				 		<option value="网上监测">网上监测</option>
				 		<option value="电话监控">电话监控</option>
				 		<option value="人力情报">人力情报</option>
				 		<option value="其他">其他</option>
				 	</select>
				</div>
				
				<button class="layui-btn" id="qbxssearch" data-type="reload"><i class="layui-icon">&#xe615;</i>搜 索</button>
			</form>
		</blockquote>
    	<table class="layui-hide" id="qbxs" lay-filter="qbxs"></table>
	</div>
    <div class="layui-tab-item">
    	<blockquote class="layui-elem-quote news_search">	
			<form class="layui-form" onsubmit="return false;">
				<div class="layui-inline" style="width:200px;">
					<input class="layui-input" type="text" id="wkhjcdtname" autocomplete="off" placeholder=" 风险名称：">
				</div>
				<div class="layui-inline" style="width:200px;">
					<input class="layui-input" type="text" id="wkhjcsgs" autocomplete="off" placeholder=" 措施概述：">
				</div>
				<div class="layui-inline" style="width:200px;">
					<input class="layui-input" type="text" id="wkhjlsqkks" autocomplete="off" placeholder=" 落实情况概述：">
				</div>
				<button class="layui-btn" id="wkhjsearch" data-type="reload"><i class="layui-icon">&#xe615;</i>搜 索</button>
			</form>
		</blockquote>
    	<table class="layui-hide" id="wkhj" lay-filter="wkhj"></table>
	</div>
    <div class="layui-tab-item">
    	<blockquote class="layui-elem-quote news_search">	
			<form class="layui-form" onsubmit="return false;">
				<div class="layui-inline" style="width:200px;">
					<input class="layui-input" type="text" id="gzjbcdtname" autocomplete="off" placeholder=" 风险名称：">
				</div>
				
				<div class="layui-inline" style="width:200px;">
					<select id="gzjbwtype">
				        <option value="">工作单类别：</option>
				        <option value="1">工作提示单</option>
				        <option value="2">工作交办单</option>
				        <option value="3">工作督办单</option>
				        <option value="4">责任追究建议函</option>
				    </select>
				</div>
				<div class="layui-inline" style="width:200px;">
					<select id="gzjbnowstates">
				        <option value="">状态：</option>
				        <option value="1">已下发</option>
				        <option value="2">已签收</option>
				        <option value="3">已反馈</option>
				    </select>
				</div>
				<div class="layui-inline" style="width:200px;">     
					<input class="layui-input" id="gzjbstartTime" placeholder="下发时间(开始)：" autocomplete="off" readonly="readonly">     
				</div>
				至
				<div class="layui-inline" style="width:200px;">
					<input class="layui-input" id="gzjbendTime" placeholder="下发时间(结束)：" autocomplete="off"  readonly="readonly">
				</div>
				<button class="layui-btn" id="gzjbsearch" data-type="reload"><i class="layui-icon">&#xe615;</i>搜 索</button>
			</form>
		</blockquote>
		<table class="layui-hide" id="gzjb" lay-filter="gzjb"></table>
	</div>
    <div class="layui-tab-item">
    	<blockquote class="layui-elem-quote news_search">	
			<form class="layui-form" onsubmit="return false;">
				<div class="layui-inline" style="width:200px;">
					<input class="layui-input" type="text" id="tdhjcdtname" autocomplete="off" placeholder=" 风险名称：">
				</div>
				
				<div class="layui-inline" style="width:200px;">
					<select id="hjczhtype">
				        <option value="">类型：</option>
				        <option value="1">领导批示</option>
				        <option value="2">涉稳专报</option>
				        <option value="5">专题会议纪要</option>
				    </select>
				</div>
				<div class="layui-inline" style="width:200px;">
					<input class="layui-input" type="text" id="hjczhtitle" autocomplete="off" placeholder=" 标题：">
				</div>
				<div class="layui-inline" style="width:200px;">
					<input class="layui-input" type="text" id="hjczhcontent" autocomplete="off" placeholder=" 内容：">
				</div>
				<button class="layui-btn" id="hjczsearch" data-type="reload"><i class="layui-icon">&#xe615;</i>搜 索</button>
			</form>
		</blockquote>
		<table class="layui-hide" id="hjcz" lay-filter="hjcz"></table>
	</div>
	<div class="layui-tab-item">
		<blockquote class="layui-elem-quote news_search">	
			<form class="layui-form" onsubmit="return false;">
				<div class="layui-inline" style="width:20%;">
					<input class="layui-input" type="text" id="zzrycardnumber" autocomplete="off" placeholder=" 身份证号：">
				</div>
				<div class="layui-inline" style="width:20%;">
					<input class="layui-input" type="text" id="zzrypersonname" autocomplete="off" placeholder=" 姓名：">
				</div>
				<div class="layui-inline" style="width:20%;">
					<input class="layui-input" type="text" id="zzryhouseplace" autocomplete="off" placeholder=" 户籍地：">
				</div>
				<div class="layui-inline" style="width:20%;">
					<input class="layui-input" type="text" id="zzryhomeplace" autocomplete="off" placeholder=" 现住地：">
				</div>
				<button class="layui-btn" id="zzrysearch" data-type="reload"><i class="layui-icon">&#xe615;</i>搜 索</button>
			</form>
		</blockquote>
    	<table class="layui-hide" id="zzry" lay-filter="zzry"></table>
	</div>
  </div>
</div>
<script>
	layui.config({
	    base: "<c:url value="/layui/lay/modules/"/>"
	}).extend({
	    zTreeSelectM: "zTreeSelectM/zTreeSelectM",
	    treeSelect: "treeSelect"
	});
	layui.use(['treeSelect'], function() {
		var treeSelect = layui.treeSelect;
		//初始化事发部位
		treeSelect.render({
	        elem: '#sfbw',
	        data: '<c:url value="/getbasicMsgJSON.do"/>?basicType=41',
	        type: 'get',
	        placeholder: '事发部位：',				//修改默认提示信息
	        search: true,								// 是否开启搜索功能：true/false，默认false
	        style: {
	            folder: {enable: true},
	            line: {enable: true}
	        },
	        click: function(d){
	       		// 点击回调
	        },
	        success: function (d) {
	            //获取zTree对象，可以调用zTree方法
              	sfbwTree = treeSelect.zTree('sfbw');
              	var newNode = {name:"全部"};
			     sfbwTree.addNodes(null,0,newNode);
				//刷新树结构
               	treeSelect.refresh('sfbw');
               	$("#sfbw").next().find('input').attr("autocomplete","off");
	        }
	    });
	});
	layui.use(['table','form','element','zTreeSelectM','laydate'], function() {
		var table = layui.table,
		form = layui.form,
		layer = layui.layer,
		zTreeSelectM = layui.zTreeSelectM,
		laydate = layui.laydate,
		element = layui.element;
		
		var startTime=laydate.render({
			elem:'#gzjbstartTime',
			done: function(value, date){
				endTime.config.min={           
					year:date.year,
					month:date.month-1,//关键
	                date:date.date
	         	};
	    	}  
		});
		var endTime=laydate.render({
			elem:'#gzjbendTime',
			done: function(value, date){
				startTime.config.max={           
					year:date.year,
					month:date.month-1,//关键
					date:date.date
				};
			}
		});
			$.ajax({
				type:		'POST',
				url:		'<c:url value="/getbasicMsgJSON.do"/>?basicType=44',
				dataType:	'json',
				success:	function(data){
	          			$.each(data, function(num, item) {
	          				$('#xwfs').append('<option value="' + item.name + '">' + item.name + '</option>');
	         			});
	     				form.render("select");
				}
			});
		$.ajax({
			type:		'POST',
			url:		'<c:url value="/getbasicMsgJSON.do"/>?basicType=39',
			dataType:	'json',
			success:	function(data){
				//初始化风险类别
				var _zTreeSelectM = zTreeSelectM({
				    elem: '#cdttype',//元素容器【必填】          
				    data: data,
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
				
				var _zTreeSelectM = zTreeSelectM({
				    elem: '#qbxscdttype',//元素容器【必填】          
				    data: data,
				    type: 'get',  //设置了长度    
				    selected: [],//默认值            
				    max: 5,//最多选中个数，默认5            
				    name: 'qbxscdttype',//input的name 不设置与选择器相同(去#.)
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
			}
		});
		
		
		
		//初始化引发涉稳事件
		table.render({
			elem: '#swsj',
		    toolbar: true,
		    defaultToolbar: ['filter', 'exports', 'print'],
		    url: '<c:url value="/searchEventsInfoSynthetic.do"/>',
		    method:'post',
		    cols: [[
		    	{field:'cdttypename', title: '风险类别', width:200,align:"center"},
		    	{field:'cdtname', title: '风险名称', width:200,align:"center"},
		    	{field:'cdtlevel', title: '风险等级', width:150,align:"center"},
		    	{field:'etitle', title: '事件标题', align:"center",templet: function(d){
		    		return "<a href='#' style='text-decoration: underline;' onclick='showInfo(&quot;"+d.id+"&quot;,&quot;showInfoEventsInfo.do&quot;,&quot;引发涉稳事件详情&quot;);return false;'>"+d.etitle+"</a>";
		    	}},
		    	{field:'sfbwd', title: '事发部位',width:150,align:"center"},
		    	{field:'ssrs', title: '涉及人数',width:100,align:"center"},
		    	{field:'xwfs', title: '行为方式',width:100,align:"center"},
		    	{field:'fssj', title: '发生时间', width:150,align:"center"},
		    	{field:'addoperator', title: '建档人',width:150,align:"center"},
		    	{field:'addtime', title: '建档时间',width:200,align:"center"}
		    ]],
		    page: true,
		    limit: 10
		});
		
		//初始化情报线索信息
		table.render({
			elem: '#qbxs',
		    toolbar: true,
		    defaultToolbar: ['filter', 'exports', 'print'],
		    method:'post',
		    cols: [[
		    	{field:'cdttypename', title: '风险类别', width:200,align:"center"},
		    	{field:'cdtname', title: '风险名称', width:200,align:"center"},
		    	{field:'cdtlevel', title: '风险等级', width:200,align:"center"},
		    	{field:'ltitle', title: '线索标题', width:200,align:"center",templet: function(d){
		    		return "<a href='#' style='text-decoration: underline;' onclick='showInfo(&quot;"+d.id+"&quot;,&quot;showInfoLeadsInfo.do&quot;,&quot;情报线索信息详情&quot;);return false;'>"+d.ltitle+"</a>";
		    	}},
		    	{field:'lpointto', title: '线索指向', width:200,align:"center"},
		    	{field:'lsource', title: '线索来源', width:200,align:"center"},
		    	{field:'ldate', title: '预计发生时间',align:"center"},
		    	{field:'addoperator', title: '建档人',width:150,align:"center"},
		    	{field:'addtime', title: '建档时间',width:200,align:"center"}
		    ]],
		    page: true,
		    limit: 10
		});
		
		//初始化稳控化解情况
		table.render({
			elem: '#wkhj',
		    toolbar: true,
		    defaultToolbar: ['filter', 'exports', 'print'],
		    method:'post',
		    cols: [[
		        {field:'cdtname', title: '风险名称', width:200,align:"center"},
		    	{field:'cdtlevel', title: '风险等级', width:200,align:"center"},
		    	{field:'lsdate', title: '预计落实时间', width:130,align:"center"},
		    	{field:'csgs', title: '措施概述', width:400,align:"center"},
		    	{field:'sflsqk', title: '是否落实情况', width:130,align:"center"},
		    	{field:'lsqkks', title: '落实情况概述',align:"center"},
		    	{field:'addoperator', title: '建档人',width:150,align:"center"},
		    	{field:'addtime', title: '建档时间',width:200,align:"center"}
		    ]],
		    page: true,
		    limit: 10
		});
		
		//工作交办信息
		table.render({
		    elem: '#gzjb',
		    toolbar: true,
		    defaultToolbar: ['filter', 'exports', 'print'],
		    method:'post',
		    cols: [[
		    	{field:'wtype', title: '类型', width:130,align:"center",templet:
		    		function(item){
		    			if(item.wtype==1){
		    				return "<span>工作提示单</span>";
		    			}else if(item.wtype==2){
		    				return "<span>工作交办单</span>";
		    			}else if(item.wtype==3){
		    				return "<span>工作督办单</span>";
		    			}else if(item.wtype==4){
		    				return "<span>责任追究建议函</span>";
		    			}
		    		}
		    	},
		    	{field:'cdtname', title: '风险名称', width:200,align:"center"},
		    	{field:'cdtlevel', title: '风险等级', width:100,align:"center"},
		    	{field:'wtitle', title: '标题', width:150,align:"center",templet: function(d){
		    		return "<a href='#' style='text-decoration: underline;' onclick='showInfo(&quot;"+d.id+"&quot;,&quot;showWorkInfo.do&quot;,&quot;工作交办信息详情&quot;);return false;'>"+d.wtitle+"</a>";
		    	}},
		    	//{field:'wcontent', title: '内容', width:200,align:"center"},
		    	{field:'filenames', title: '附件',width:250,align:"center",templet: function(d){
		    		var content="";
		    		if(d.filenames!=null){
		    			var filenames = d.filenames.split(",");
			    		var fileids = d.fileids.split(",");
			    		if(filenames.length>0){
			    			content+='<div><a href="<c:url value="/downUpfile.do" />?fileid='+fileids[0]+'" class="layui-table-link">'+filenames[0]+'</a></div>';
			    		}
			    		for(var i=1;i<filenames.length;i++){
			    			content+='<div><a href="<c:url value="/downUpfile.do" />?fileid='+fileids[i]+'" class="layui-table-link">'+filenames[i]+'</a></div>'
			    		}
		    		}
		    		return content;
		    	}},
		    	{field:'receivedept', title: '接受单位',align:"center"},
		    	{field:'receivername', title: '接收人',align:"center"},
		    	{field:'xfpername', title: '下发人',align:"center"},
		    	//{field:'xfperdep', title: '下发人单位',align:"center"},
		    	//{field:'xftime', title: '下发时间',align:"center"},
		    	//{field:'qspername', title: '签收人',align:"center"},
		    	{field:'qstime', title: '签收时间',align:"center"},
		    	//{field:'fkname', title: '反馈人',align:"center"},
		    	{field:'fktime', title: '反馈时间',align:"center"},
		    	//{field:'fkcontent', title: '反馈内容',align:"center"},
		    	{field:'nowstates', title: '状态', width:90,align:"center",templet:
		    		function(item){
		    			if(item.nowstates==1){
		    				return "<span style='color: red;'>已下发</span>";
		    			}else if(item.nowstates==2){
		    				return "<span style='color: blue;'>已签收</span>";
		    			}else if(item.nowstates==3){
		    				return "<span style='color: green;'>已反馈</span>";
		    			}
		    		}
		    	}
		    ]],
		    page: true,
		    limit: 10
		});
		
		//领导交办处置情况
		table.render({
			elem: '#hjcz',
		    toolbar: true,
		    defaultToolbar: ['filter', 'exports', 'print'],
		    method:'post',
		    cols: [[
		        {field:'cdtname', title: '风险名称', width:200,align:"center"},
		    	{field:'cdtlevel', title: '风险等级', width:100,align:"center"},
		    	{field:'htype', title: '类型', width:180,align:"center",templet: 
					function(item){
		    			if(item.htype==1){
		    				return "<span>领导批示</span>";
		    			}else if(item.htype==2){
		    				return "<span>涉稳专报</span>";
		    			}else if(item.htype==3){
		    				return "<span>维稳专报</span>";
		    			}else if(item.htype==4){
		    				return "<span>涉稳风险交办处置建议</span>";
		    			}else if(item.htype==5){
		    				return "<span>专题会议纪要</span>";
		    			}
		    		}
				},
		    	{field:'htitle', title: '标题', width:180,align:"center"},
		    	
		    	{field:'hcontent', title: '内容',align:"center"},
		    	{field:'receiver', title: '接收人', width:120,align:"center"},
		    	{field:'hsituation', title: '办理情况',align:"center"},
		    	{field:'hresult', title: '处置结果',align:"center"},
		    	{field:'leaderlevel', title: '领导级别', width:150,align:"center"},
		    	{field:'approveperson', title: '批示人', width:120,align:"center"},
		    	{field:'addoperator', title: '录入人', width:120,align:"center"},
		    	{field:'hdate', title: '录入时间', width:120,align:"center"},
		    	{field:'filenames', title: '附件', width:250,align:"center",templet: function(d){
		    		var content="";
		    		if(d.filenames!=null){
		    			var filenames = d.filenames.split(",");
			    		var fileids = d.fileids.split(",");
			    		if(filenames.length>0){
			    			content+='<div><a href="<c:url value="/downUpfile.do" />?fileid='+fileids[0]+'" class="layui-table-link">'+filenames[0]+'</a></div>';
			    		}
			    		for(var i=1;i<filenames.length;i++){
			    			content+='<div><a href="<c:url value="/downUpfile.do" />?fileid='+fileids[i]+'" class="layui-table-link">'+filenames[i]+'</a></div>'
			    		}
		    		}
		    		return content;
		    	}}
		    ]],
		    page: true,
		    limit: 10
		});
		
		//初始化主要组织人员
		table.render({
			elem: '#zzry',
		    toolbar: true,
		    defaultToolbar: ['filter', 'exports', 'print'],
		    method:'post',
		    cols: [[
		    	{field:'cardnumber', title: '身份证号', width:200,align:"center"},
		    	{field:'personname', title: '姓名', width:100,align:"center"},
		    	{field:'sexes', title: '性别', width:80,align:"center"},
		    	{field:'persontype', title: '人员类别', width:100,align:"center"},
		    	{field:'nation', title: '民族', width:100,align:"center"},
		    	{field:'marrystatus', title: '婚姻状态', width:100,align:"center"},
		    	{field:'education', title: '文化程度', width:100,align:"center"},
		    	{field:'politicalposition', title: '政治面貌', width:100,align:"center"},
		    	{field:'faith', title: '宗教信仰', width:100,align:"center"},
		    	{field:'houseplace', title: '户籍地详址', width:200,align:"center"},
		    	{field:'homeplace', title: '现住地详址', width:200,align:"center"},
		    	{field:'workplace', title: '工作地详址',align:"center"}
		    	
		    
		    ]],
		    page: true,
		    limit: 10
		});
		
		//主要组织人员详情
		table.on('toolbar(zzry)', function(obj){
			var  checkStatus =table.checkStatus(obj.config.id);
			switch(obj.event){
		   		case 'showinfo':
		   		var data=JSON.stringify(checkStatus.data);
				var datas=JSON.parse(data);
			   	if(datas!=""){
			   		var index = layui.layer.open({
						title : '主要组织人员详情',
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content : '<c:url value="getsocialrelationsbycardnumber.do"/>?cardnumber='+datas[0].cardnumber+'&riskpersonnel=1&page=showinfo',
						area: ['800', '800px'],
						maxmin: true,
						success : function(layero, index){
							setTimeout(function(){
								layui.layer.tips('点击此处返回文章列表', '.layui-layer-setwin .layui-layer-close', {
									tips: 3
								});
							},500)
						}
					});
					layui.layer.full(index);
			   	}else{
			   		top.layer.alert("请先选择查看哪条数据详情！");
			   	}
		   		break;
		   	}
		});
		
		element.on('tab(syntheticTabs)', function(data){
			switch(data.index){
				case 0:
					swsjformSubmit();
				break;
				case 1:
					qbxsformSubmit();
				break;
				case 2:
					wkhjformSubmit();
				break;
				case 3:
					gzjbformSubmit();
				break;
				case 4:
					hjczformSubmit();
				break;
				case 5:
					zzryformSubmit();
				break;
			}
		});
				
		function swsjformSubmit(){
			var nodes = sfbwTree.getSelectedNodes();
		  	var name = "";
	  		if(nodes.length>0){
	  			name = nodes[0].name;
	  		}
	  		//引发涉稳事件
			table.reload('swsj', {
				url:'<c:url value="searchEventsInfoSynthetic.do"/>',
				where: { // 设定异步数据接口的额外参数，任意设
					cdtname: $("#cdtname").val(),
					cdtlevel: $("#cdtlevel").val(),
					cdttype: $("input[name='cdttype']").val(),
					etitle: $("#etitle").val(),
					xwfs: $("#xwfs").val(),
					sfbwd: name,
					sjgk: $("#sjgk").val()
				},
				page: {
					curr: 1
					// 重新从第 1 页开始
				}
			});
		}
		//情报线索信息
		function qbxsformSubmit(){
			table.reload('qbxs', {
				url:'<c:url value="searchLeadsInfoSynthetic.do"/>',
				where: { // 设定异步数据接口的额外参数，任意设
					cdtname: $("#qbxscdtname").val(),
					ltitle: $("#qbxsltitle").val(),
					cdttype: $("input[name='qbxscdttype']").val(),
					lpointto: $("#qbxslpointto").val(),
					lsource: $("#qbxslsource").val(),
					lcontent: $("#qbxslcontent").val(),
					cdtlevel: $("#qbxscdtlevel").val()
					
				},
				page: {
					curr: 1
					// 重新从第 1 页开始
				}
			});
		}
		
		function wkhjformSubmit(){
			table.reload('wkhj', {
				url:'<c:url value="searchDefuseInfo.do"/>',
				where: { // 设定异步数据接口的额外参数，任意设
					cdtname: $("#wkhjcdtname").val(),
					csgs:$("#wkhjcsgs").val(),
					lsqkks:$("#wkhjlsqkks").val()
				},
				page: {
					curr: 1
					// 重新从第 1 页开始
				}
			});
		}
		
		function gzjbformSubmit(){
			var wtype=0;
			var nowstates=0;
			if($("#gzjbnowstates").val()!=0){
				nowstates=$("#gzjbnowstates").val();
			}
			if($("#gzjbwtype").val()!=0){
				wtype=$("#gzjbwtype").val();
			}
			table.reload('gzjb', {
				url:'<c:url value="searchWorkInfo.do"/>',
				where: { // 设定异步数据接口的额外参数，任意设
					wtype: wtype,
					nowstates: nowstates,
					startTime: $("#gzjbstartTime").val(),
					endTime: $("#gzjbendTime").val(),
					cdtname: $("#gzjbcdtname").val()
					
				},
				page: {
					curr: 1
					// 重新从第 1 页开始
				}
			});
		}
		
		function hjczformSubmit(){
			var htype=0;
			if($("#hjczhtype").val()!=0){
				htype=$("#hjczhtype").val();
			}
			table.reload('hjcz', {
				url:'<c:url value="searchHandleInfoSynthetic.do"/>',
				where: { // 设定异步数据接口的额外参数，任意设
					htype: htype,
					htitle: $("#hjczhtitle").val(),
					hcontent: $("#hjczhcontent").val()
				},
				page: {
					curr: 1
					// 重新从第 1 页开始
				}
			});
		}
		
		function zzryformSubmit(){
			table.reload('zzry', {
				url:'<c:url value="searchKeypersonnel.do"/>',
				where: { // 设定异步数据接口的额外参数，任意设
					cardnumber: $("#zzrycardnumber").val(),
					personname: $("#zzrypersonname").val(),
					houseplace: $("#zzryhouseplace").val(),
					homeplace: $("#zzryhomeplace").val()
				},
				page: {
					curr: 1
					// 重新从第 1 页开始
				}
			});
		}
		
		//搜索查询
  		$("#search").click(function () {
  			swsjformSubmit();
		});
		
  		$("#qbxssearch").click(function () {
  			qbxsformSubmit();
		});
		
		$("#wkhjsearch").click(function () {
  			wkhjformSubmit();
		});
		
  		$("#gzjbsearch").click(function () {
  			gzjbformSubmit();
		});
		
		$("#hjczsearch").click(function () {
  			hjczformSubmit();
		});
		
		$("#zzrysearch").click(function () {
  			zzryformSubmit();
		});
	});
	
	function showInfo(id,url,title){
		var index = layui.layer.open({
			title : title,
			type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
			content : '<c:url value="'+url+'"/>?id='+id,
			area: ['800', '800px'],
			maxmin: true,
			success : function(layero, index){
				setTimeout(function(){
					layui.layer.tips('点击此处返回文章列表', '.layui-layer-setwin .layui-layer-close', {
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