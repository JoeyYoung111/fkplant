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
    <title>涉恐人员查询</title>
    <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
     <link rel="stylesheet" href="<c:url value="/css/public.css"/>"  media="all" />
      <link rel="stylesheet" href="<c:url value="/css/viewer.css"/>"/>
     <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
     <script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
     <script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
     <script type="text/javascript" src="<c:url value="/js/viewer.js"/>"></script>
      <style>
		 .layui-table td .layui-table-cell{
		    height:60px;
		    }
		  .laytable-cell-radio {
			    padding-top:20px;
		     }
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
  </head>
 
 <body class="childrenBody layui-fluid">
		<div class="layui-tab my-tab layui-tab-brief" lay-filter="docDemoTabBrief">
			<ul class="layui-tab-title my-tab-title4">
				<li class="layui-this"><font size="4">关注人员</font></li>
				<c:if test="<%=userSession.getLoginRoleMsgFilter()==0 %>">
					<li  onclick="openGdPerson();"><font size="4">归档人员</font></li>
				</c:if>
				<c:if test="<%=userSession.getLoginRoleMsgFilter()==1 %>">
					<li  onclick="openGdPerson();" style="display:none;"><font size="4">归档人员</font></li>
				</c:if>
				<li  onclick="openKongDailyControl1();"><font size="4">三日一走访</font></li>
				<li  onclick="openKongDailyControl2();"><font size="4">每月评估</font></li>
			</ul>
			<div class="layui-tab-content" style="height: 100px;">
				<div class="layui-tab-item layui-show">
				   <blockquote class="layui-elem-quote news_search">	
					<div class="demoTable">
					 <form class="layui-form" method="post" style="display:inline;">
					 	<input type="hidden" id="incontrollevel" value="在控">
					 	<div class="layui-inline">
					    	<input class="layui-input" name="personname" id="personname1" autocomplete="off" placeholder="姓名："  style="width:170px;">
					 	</div>
					 	<div class="layui-inline" >
							<select id="sexes"  name="sexes" style="width:170px;">
								 		<option value=''>性别：全部</option>
								 		<option value='女'>女</option>
								 		<option value='男'>男</option>
							</select>
						</div>
						<div class="layui-inline" >
							<select id="jointtype"  name="jointtype" style="width:170px;">
								 		<option value='0'>联控级别：全部</option>
								 		<option value='1'>红色</option>
								 		<option value='2'>橙色</option>
								 		<option value='3'>黄色</option>
								 		<option value='4'>蓝色</option>
							</select>
						</div>
						<div class="layui-inline">
					    	<input class="layui-input" name="homeplace" id="homeplace" autocomplete="off" placeholder="现居住地：" style="width:213px;">
					 	</div>
					 	<br>
					 	<div class="layui-inline" >
							<input class="layui-input" name="cardnumber" id="cardnumber1" style="width:170px;" autocomplete="off" placeholder="身份证号：">
						</div>
						<div class="layui-inline" >
							<select id="nativeplace"  name="nativeplace" style="width:170px;"></select>
						</div>
					     <div class="layui-inline" >
							<select id="jurisdictunit1"  name="jurisdictunit1" style="width:170px;">
								<option value=''>----请选择管辖单位----</option>
							</select>
						</div>
						<div class="layui-inline" >
							<select id="isassign"  name="isassign" style="width:170px;">
								 		<option value='0'>是否指派：全部</option>
								 		<option value='1'>未分配</option>
								 		<option value='2'>已分配</option>
							</select>
						</div>
						</form>
					<button class="layui-btn" id="search1" data-type="reload"><i class="layui-icon">&#xe615;</i>搜 索</button>
					<button type="reset" id="reset1" class="layui-btn"><i class="layui-icon">&#xe702;</i>重置</button>
					 </div>
					 </blockquote>
                   <table class="layui-hide" id="followTable1" lay-filter="followTable1"></table>
				</div>
				<div class="layui-tab-item">
				   <blockquote class="layui-elem-quote news_search">	
					<div class="demoTable">
					 <form class="layui-form" method="post" style="display:inline;">
					 	<div class="layui-inline">
					    	<input class="layui-input" id="GDpersonname" autocomplete="off" placeholder="姓名："  style="width:170px;">
					 	</div>
					 	<div class="layui-inline" >
							<select id="GDsexes"  style="width:170px;">
								 		<option value=''>性别：全部</option>
								 		<option value='女'>女</option>
								 		<option value='男'>男</option>
							</select>
						</div>
						<div class="layui-inline" >
							<select id="GDjointtype" style="width:170px;">
								 		<option value='0'>联控级别：全部</option>
								 		<option value='1'>红色</option>
								 		<option value='2'>橙色</option>
								 		<option value='3'>黄色</option>
								 		<option value='4'>蓝色</option>
							</select>
						</div>
						<div class="layui-inline">
					    	<input class="layui-input" id="GDhomeplace" autocomplete="off" placeholder="现居住地：" style="width:213px;">
					 	</div>
					 	<br>
					 	<div class="layui-inline" >
							<input class="layui-input" id="GDcardnumber" style="width:170px;" autocomplete="off" placeholder="身份证号：">
						</div>
						<div class="layui-inline" >
							<select id="GDnativeplace" name="GDnativeplace" style="width:170px;"></select>
						</div>
					    <div class="layui-inline" >
							<select id="GDjurisdictunit1"  style="width:170px;">
								<option value=''>----请选择管辖单位----</option>
							</select>
						</div>
						<div class="layui-inline" >
							<select id="GDisassign" style="width:170px;">
								 		<option value='0'>是否指派：全部</option>
								 		<option value='1'>未分配</option>
								 		<option value='2'>已分配</option>
							</select>
						</div>
						</form>
					<button class="layui-btn" id="GDsearch" data-type="reload"><i class="layui-icon">&#xe615;</i>搜 索</button>
					<button type="reset" id="GDreset" class="layui-btn"><i class="layui-icon">&#xe702;</i>重置</button>
					 </div>
					 </blockquote>
                   <table class="layui-hide" id="GDfollowTable" lay-filter="GDfollowTable"></table>
				</div>
				<div class="layui-tab-item"><!--  三日一走访 -->
				  <blockquote class="layui-elem-quote news_search">	
					<div class="demoTable">
					 <form class="layui-form" method="post" style="display:inline;">
					 	<div class="layui-inline">
					    	<input class="layui-input"  id="personname2" name="personname" autocomplete="off" placeholder="姓名："  style="width:170px;">
					 	</div>
					 	<div class="layui-inline">
					    	<input class="layui-input"  id="cardnumber2" name="cardnumber"  autocomplete="off" placeholder="身份证号：" style="width:210px;">
					 	</div>
					 	<div class="layui-inline">
					    	<input class="layui-input" name="starttime2" id="starttime2" autocomplete="off" placeholder="管控时间(开始)："  style="width:170px;">
					 	</div>
					 	<div class="layui-inline">
					    	<input class="layui-input" name="endtime2" id="endtime2" autocomplete="off" placeholder="管控时间(结束)：" style="width:210px;">
					 	</div>
					    <div class="layui-inline" >
						     <select id="controlmode"  name="controlmode" style="width:170px;" lay-verify="required" lay-verType="tips"></select>
						</div>
						</form>
					<button class="layui-btn" id="search2" data-type="reload"><i class="layui-icon">&#xe615;</i>搜 索</button>
					<button type="reset" id="reset2" class="layui-btn"><i class="layui-icon">&#xe702;</i>重置</button>
					 </div>
					 </blockquote>
                   <table class="layui-hide" id="followTable2" lay-filter="followTable2"></table>
				</div>
				<div class="layui-tab-item">
				     <blockquote class="layui-elem-quote news_search">	
					<div class="demoTable">
					 <form class="layui-form" method="post" style="display:inline;">
					 	<div class="layui-inline">
					    	<input class="layui-input"  id="personname3" name="personname"  autocomplete="off" placeholder="姓名："  style="width:170px;">
					 	</div>
					 	<div class="layui-inline">
					    	<input class="layui-input"  id="cardnumber3"  name="cardnumber"  autocomplete="off" placeholder="身份证号：" style="width:210px;">
					 	</div>
					 	<div class="layui-inline">
					    	<input class="layui-input" name="starttime3" id="starttime3" autocomplete="off" placeholder="评估时间(开始)："  style="width:170px;">
					 	</div>
					 	<div class="layui-inline">
					    	<input class="layui-input" name="endtime3" id="endtime3" autocomplete="off" placeholder="评估时间(结束)：" style="width:210px;">
					 	</div>
					   
						</form>
					<button class="layui-btn" id="search3" data-type="reload"><i class="layui-icon">&#xe615;</i>搜 索</button>
					<button type="reset" id="reset3" class="layui-btn"><i class="layui-icon">&#xe702;</i>重置</button>
					 </div>
					 </blockquote>
                   <table class="layui-hide" id="followTable3" lay-filter="followTable3"></table>
				</div>
			</div>
		   <script type="text/html" id="toolbarButton">
               <c:if test='${fn:contains(param.buttons,"新增")}'>
   	          	<button type="button" class="layui-btn layui-btn-sm" lay-event="add"><i class="layui-icon">&#xe654;</i>添 加</button>
               </c:if>
               <c:if test='${fn:contains(param.buttons,"修改")}'>
           	   	<button type="button" class="layui-btn layui-btn-sm" lay-event="update"><i class="layui-icon">&#xe642;</i>修 改</button>
               </c:if>
               <c:if test='${fn:contains(param.buttons,"删除")}'>
   	                  <button type="button" class="layui-btn layui-btn-sm" lay-event="cancel"><i class="layui-icon">&#xe640;</i>删 除</button>
               </c:if>
                <c:if test='${fn:contains(param.buttons,"指派")}'>
	                    <button type="button" class="layui-btn layui-btn-sm" lay-event="assign"><i class="layui-icon">&#xe612;</i>指 派</button>
                </c:if>
                <c:if test='${fn:contains(param.buttons,"时间管控")}'>
                       <button type="button" class="layui-btn layui-btn-sm" lay-event="controltime"><i class="layui-icon">&#xe60e;</i>管控时间</button>
                </c:if>
               <c:if test='${fn:contains(param.buttons,"归档")}'>
                  <button type="button" class="layui-btn layui-btn-sm" lay-event="incontrollevel"><i class="layui-icon">&#xe630;</i>归档</button>
               </c:if>
			   <c:if test='${fn:contains(param.buttons,"导入")}'>
               		<button type="button" class="layui-btn layui-btn-sm" lay-event="import"><i class="layui-icon">&#xe601;</i>导 入</button>   
			   </c:if>
			   <c:if test='${fn:contains(param.buttons,"导出")}'>
               		<button type="button" class="layui-btn layui-btn-sm" lay-event="export"><i class="layui-icon layui-icon-export"></i>导出</button> 
			   </c:if>
			   <c:if test='${fn:contains(param.buttons,"台账")}'>
			   		<button type="button" class="layui-btn layui-btn-sm" lay-event="tz"><i class="layui-icon layui-icon-template-1"></i>台账</button>
			   </c:if>
        </script> 
        <script type="text/html" id="GDtoolbarButton">
   	          	<button type="button" class="layui-btn layui-btn-sm" lay-event="add"><i class="layui-icon">&#xe654;</i>添 加</button>
           	   <button type="button" class="layui-btn layui-btn-sm" lay-event="update"><i class="layui-icon">&#xe642;</i>修 改</button>
               <c:if test='${fn:contains(param.buttons,"删除")}'>
   	                  <button type="button" class="layui-btn layui-btn-sm" lay-event="cancel"><i class="layui-icon">&#xe640;</i>删 除</button>
               </c:if>
                <c:if test='${fn:contains(param.buttons,"指派")}'>
	                    <button type="button" class="layui-btn layui-btn-sm" lay-event="assign"><i class="layui-icon">&#xe612;</i>指 派</button>
                </c:if>
                <c:if test='${fn:contains(param.buttons,"时间管控")}'>
                       <button type="button" class="layui-btn layui-btn-sm" lay-event="controltime"><i class="layui-icon">&#xe60e;</i>管控时间</button>
                </c:if>
               <c:if test='${fn:contains(param.buttons,"还原")}'>
                  <button type="button" class="layui-btn layui-btn-sm" lay-event="reduction"><i class="layui-icon">&#xe620;</i>还原</button>
               </c:if>
               <c:if test='${fn:contains(param.buttons,"导入")}'>
               		<button type="button" class="layui-btn layui-btn-sm" lay-event="import"><i class="layui-icon">&#xe601;</i>导 入</button>   
			   </c:if>
			   <c:if test='${fn:contains(param.buttons,"导出")}'>
               		<button type="button" class="layui-btn layui-btn-sm" lay-event="export"><i class="layui-icon layui-icon-export"></i>导出</button> 
			   </c:if>
			   <c:if test='${fn:contains(param.buttons,"台账")}'>
			   		<button type="button" class="layui-btn layui-btn-sm" lay-event="tz"><i class="layui-icon layui-icon-template-1"></i>台账</button>
			   </c:if>
        </script> 
        <script type="text/html" id="KDtoolbarButton">
             <button type="button" class="layui-btn layui-btn-sm" lay-event="export"><i class="layui-icon layui-icon-export"></i>导出</button> 
        </script> 
		<script type="text/html" id="barButton">
			 <a class="layui-btn layui-btn-warm layui-btn-xs" lay-event="styzf">三日一走访</a>  
			 {{#  if(d.jointtype !=4){  }}
             <a class="layui-btn layui-btn-xs" lay-event="mypg">每月评估</a>    
			 {{# }  }}   
        </script>			
		</div>	
<script>
var sortfield="",sortdiv="",sortsql="",GDsortfield="",GDsortdiv="",GDsortsql="";
var now=new Date();
$(document).ready(function(){
	    $.ajax({
				type:		'POST',
				 url:		'<c:url value="/getBMByTypeToJSON1.do" />?basicType='+51, //籍贯
				 dataType:	'json',
				 async :      false,
				 success:	function(data){					  
				      var options = '<option value="">籍贯：全部</option>' + fillOption(data);
				      $("select[name^=nativeplace]").html(options);
				      $("select[name^=GDnativeplace]").html(options);
				   }
			});
			  $.ajax({
				type:		'POST',
				 url:		'<c:url value="/getBMByTypeToJSON1.do" />?basicType='+81, 
				 dataType:	'json',
				 async :      false,
				 success:	function(data){					  
				      var options = '<option value="">管控类型：全部</option>' + fillOption(data);
				      $("select[name^=controlmode]").html(options);
				   }
			});
			
			//初始化管辖单位
			$.ajax({
				type:		'POST',
				url:		'<c:url value="/getDepartmentTreeBytype.do"/>?departtype=4',
				dataType:	'json',
				async:		false,
				success:	function(data){
           			$.each(data, function(num, item) {
           				$('#jurisdictunit1').append('<option value="' + item.id + '">' + item.name + '</option>');
           				$('#GDjurisdictunit1').append('<option value="' + item.id + '">' + item.name + '</option>');
           			});
				}
			});
});
var locat = (window.location+'').split('/'); 
$(function(){if('main'== locat[3]){locat =  locat[0]+'//'+locat[2];}else{locat =  locat[0]+'//'+locat[2]+'/'+locat[3];};});
       layui.config({
		    base: "<c:url value="/layui/lay/modules/"/>"
		}).extend({
		     treetable: 'treetable-lay/treetable',
		     formSelects: 'formSelects/formSelects-v4'
		}).use(['table','laydate','form','treeSelect','element'], function(){
			  var table = layui.table;
			  var laydate = layui.laydate;
			  var layer = layui.layer;
			  var form=layui.form;
			  var element = layui.element;
			  var treeSelect = layui.treeSelect;
			    laydate.render({
				     elem: '#starttime2'//指定元素
			    });  	
                laydate.render({
					elem: '#endtime2'//指定元素
				 });  
			 laydate.render({
				     elem: '#starttime3'//指定元素
			    });  	
                laydate.render({
					elem: '#endtime3'//指定元素
				 });  		
			  form.render();
 
  //方法级渲染
  table.render({
    elem: '#followTable1',
    toolbar: true,
    defaultToolbar: ['filter', 'exports', 'print'],
    url: '<c:url value="/getKongPersonnel.do"/>',
    where:{incontrollevel:'在控'},
    method:'post',
    toolbar: '#toolbarButton',
    autoSort: false,
    cols: [[
        {field:'id',type:'radio',fixed:'true',align:"center"},
        {field:'lay_table_index',type:'numbers',fixed:'true',align:"center", width:80},
        {field:'personname', title: '姓名', width:180,templet: function (item) {
        		if(item.tz==0){
        			return "<span style='font-weight:500;cursor:pointer;' onclick='showinfoPersonel("+item.id+");'><font color='blue'>"+item.personname+"</font></span>";
        		}else{
        			return "<span style='font-weight:500;cursor:pointer;' onclick='showinfoPersonel("+item.id+");'><font color='blue'>"+item.personname+"</font></span><image style='padding-bottom:6px' src='"+locat+"/images/fivestar.png'></image>";
        		}
           }},
    	{field:'cardnumber', title: '身份证号码', width:180,templet: function (item) {
		   		return "<span style='font-weight:500;cursor:pointer;' onclick='showinfoPersonel("+item.id+");'><font color='blue'>"+item.cardnumber+"</font></span>";
           }} ,
        {field:'sexes', title: '性别', width:80,align:"center"} ,
        {field:'nativeplace', title: '籍贯', width:120,align:"center"} ,
        {field:'jointtype', title: '联控级别', width:90,align:"center",templet: function (item) {
		          if (item.jointtype=="1") {
		             return "红色<image style='padding-bottom:6px' src='"+locat+"/images/fivestar.png'></image>";
		         }else if(item.jointtype=="2"){
		           return "橙色<image style='padding-bottom:6px' src='"+locat+"/images/circle.png'></image>";
		         }else if(item.jointtype=="3"){
		           return "黄色<image style='padding-bottom:6px' src='"+locat+"/images/triangle.png'></image>";
		         }else if(item.jointtype=="4"){
		           return "<span style='font-weight:900'><font color='blue'>蓝色</font></span>";
		         }else{
		             return "<span style='font-weight:900'></span>";
		         }
        }}, 
      {field:'controltime', title: '管控时间', width:100,align:"center"},
      {field:'homeplace', title: '现居住地详址',align:"center"} ,
	  {field:'isassign', title: '指派情况',width:250,align:"center",templet: function (item) {
		          if (item.isassign=="1") {
		             return "<span><font color='red'>未指派</font></span>";
		         }else if(item.isassign=="2"){
		           var str="";
		           if(item.isFilter!=null){
		             str+=item.isFilter+"("+item.qq+")";
		           }
		           if(item.filtervalue!=null){
		             str+="<br>"+item.filtervalue+"("+item.wechat+")";
		           }
		           return str;
		         }
        }},
       {field:'zptime', title: '指派时间', width:170} , 
      {field: 'right', title: '操作', toolbar: '#barButton',width:180,align:"center"} 
    ]],
    page: true,
    limit: 10,
    done: function(){
    	$("#incontrollevel").val("在控");
    	if(sortfield!=""&&sortdiv!=""){
    		$("#followTable1").next().find("table>thead>tr>th[data-field="+sortfield+"]").find("div").append(sortdiv);
    	}
    	$("#followTable1").next().find("table>thead>tr>th").css("cursor","pointer");
    	$("#followTable1").next().find("table>thead>tr>th").click(function () {
	 			var field=$(this).attr("data-field");
	 			if(field!=0&&field!=sortfield&&field!="right"){
		  			sortfield=field;
		  			if(sortdiv!="")sortdiv.remove();
		  			sortdiv=$('<span class="layui-table-sort layui-inline" lay-sort="asc"><i class="layui-edge layui-table-sort-asc" title="升序"></i><i class="layui-edge layui-table-sort-desc" title="降序"></i></span>');
		  			$(this).find("div").append(sortdiv);
		  			$(this).click();
	 			}
		});
    }
    });
    
    	//搜索查询
  		$("#search1").click(function () {
			table.reload('followTable1', {
				where: { // 设定异步数据接口的额外参数，任意设
					personname:$("#personname1").val(),					
					cardnumber:$("#cardnumber1").val(),
					sexes:$("#sexes").val(),
					nativeplace:$("#nativeplace").val(),
					homeplace:$("#homeplace").val(),
					jointtype:$("#jointtype").val(),
					isassign:$("#isassign").val(),
					jurisdictunit1:$("#jurisdictunit1").val()
				},
				page: {
					curr: 1
					// 重新从第 1 页开始
				}
			});
		});
		
		//归档人员查询
  		$("#GDsearch").click(function () {
			table.reload('GDfollowTable', {
				where: { // 设定异步数据接口的额外参数，任意设
					personname:$("#GDpersonname").val(),					
					cardnumber:$("#GDcardnumber").val(),
					sexes:$("#GDsexes").val(),
					nativeplace:$("#GDnativeplace").val(),
					homeplace:$("#GDhomeplace").val(),
					jointtype:$("#GDjointtype").val(),
					isassign:$("#GDisassign").val(),
					jurisdictunit1:$("#GDjurisdictunit1").val()
				},
				page: {
					curr: 1
					// 重新从第 1 页开始
				}
			});
		});
		
		$("#reset1").click(function () {
		   $('form')[0].reset();
		});
		
		$("#GDreset").click(function () {
		   $('form')[1].reset();
		});
		
		 //三日一走访   搜索查询
  		$("#search2").click(function () {
  			index_search= layer.msg('数据加载中，请稍候',{icon: 16,time:false,shade:0.3});
			table.reload('followTable2', {
				where: { // 设定异步数据接口的额外参数，任意设
					personname:$("#personname2").val(),					
					cardnumber:$("#cardnumber2").val(),
					controlmode:$("#controlmode").val(),
					starttime:$("#starttime2").val(),
					endtime:$("#endtime2").val()
				},
				page: {
					curr: 1
					// 重新从第 1 页开始
				}
			});
		});
		$("#reset2").click(function () {
		   $('form')[2].reset();
		});
		 //每月评估   搜索查询
  		$("#search3").click(function () {
			table.reload('followTable3', {
				where: { // 设定异步数据接口的额外参数，任意设
					personname:$("#personname3").val(),					
					cardnumber:$("#cardnumber3").val(),
					starttime:$("#starttime3").val(),
					endtime:$("#endtime3").val()
				},
				page: {
					curr: 1
					// 重新从第 1 页开始
				}
			});
		});
		$("#reset3").click(function () {
		   $('form')[3].reset();
		});
		//监听行工具事件
		table.on('toolbar(followTable1)', function(obj){
			var checkStatus =table.checkStatus(obj.config.id);
			switch(obj.event){
				case 'add':
			  		var index = layui.layer.open({
						title : "新增涉恐人员信息",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content : '<c:url value="/jsp/personel/kong/add.jsp?menuid='+${param.menuid}+'"/>',
						area: ['800', '700px'],
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
			   		break;
			   	case 'update':
			  		var data=JSON.stringify(checkStatus.data);
			  		var datas=JSON.parse(data);
					if(datas!=""){
					  	var id=datas[0].id;
					   	var index = layui.layer.open({
							title : "修改人员信息",
							type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
							content : locat+'/getKongPersonelUpdate.do?personnelid='+id+'&buttons='+'${param.buttons }'+'&menuid='+${param.menuid}+'&page=update',
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
								layui.table.reload('followTable1', { }); 
							}
						})			
						layui.layer.full(index);
					}else{
						layer.alert("请先选择修改哪条数据！");
					}
			   		break;
			   case 'cancel':
				  var data=JSON.stringify(checkStatus.data);
				  var datas=JSON.parse(data);
				  if(datas!=""){
					  	var id=datas[0].personlabel;//暂存涉恐扩展表id
					  	var personnelid=datas[0].id;//人员表id
						layer.confirm('确定删除此信息？', function(index){
					      layer.close(index);
					      $.getJSON(locat+"/cancelKongPersonel.do?id="+id+'&personnelid='+personnelid+'&menuid='+${param.menuid},{},function(data) {
							 var str = eval('(' + data + ')');
					      	 if (str.flag ==1) {		                          
							     top.layer.msg("数据删除成功！"); 	
							     table.reload('followTable1', {});                 
					       	 }else{
								 top.layer.msg("删除失败!");
					      	 }			      	    		
					      });      
						});
					}else{
						layer.alert("请先选择删除哪条数据！");
					}
					break;
				 case 'assign':
				var data=JSON.stringify(checkStatus.data);
			  		var datas=JSON.parse(data);
					if(datas!=""){
					  	var id=datas[0].id;
					   	var index = layui.layer.open({
							title : "指派人员信息",
							type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
							content : locat+'/getKongPersonelUpdate.do?personnelid='+id+'&menuid='+${param.menuid}+'&page=assign',
							area: ['1000px', '600px'],
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
						layer.alert("请先选择修改指派数据！");
					}
					break;
				 case 'controltime':
				var data=JSON.stringify(checkStatus.data);
			  		var datas=JSON.parse(data);
					if(datas!=""){
					  	var kongextendid=datas[0].kongextendid;
					   	layer.prompt({
							formType: 2,//这里依然指定类型是多行文本框，但是在下面content中也可绑定多行文本框
							title: '时间管控',
							area: ['300px', '100px'],
							btnAlign: 'c',
							content: `<div><input type="text" name="controltime" id="controltime"  placeholder="请输入管控时间" class="layui-input"></div>`,
							yes: function (index, layero) {
							     var controltime = $('#controltime').val();//获取多行文本框的值
							     //alert('您刚才输入了:' + controltime);
							     if(controltime!=""){
							        var reg = /^[+]{0,1}(\d+)$/g;
                                      if (!reg.test(controltime)) {
                                             layer.msg("管控时间请输入正整数！", { icon: 5, anim: 6 });
                                     }else{
                                      $.getJSON(locat+"/updatecontroltime.do?id="+kongextendid+'&controltime='+controltime+'&menuid='+${param.menuid},{},function(data) {
							         var str = eval('(' + data + ')');
					      	          if (str.flag ==1) {		                          
									     top.layer.msg("时间管控设置成功！"); 
									     layer.close(index);	
									     table.reload('followTable1', {});       		          
								       	 }else{
											 top.layer.msg("时间管控设置失败!");
								      	 }			      	    		
								      });  
								     }    
							     }else{
							           layer.msg("请输入要设置的管控时间！", { icon: 5, anim: 6 });
							     }
						       }
                         });
					}else{
						layer.confirm('确定要批量修改管控时间吗？', function(index){
							layer.close(index);
							layer.prompt({
								formType: 2,//这里依然指定类型是多行文本框，但是在下面content中也可绑定多行文本框
								title: '批量修改时间管控',
								area: ['300px', '100px'],
								btnAlign: 'c',
								content: `<div><input type="text" name="controltime" id="controltime"  placeholder="请输入管控时间" class="layui-input"></div>`,
								yes: function (index, layero) {
								     var controltime = $('#controltime').val();//获取多行文本框的值
								     //alert('您刚才输入了:' + controltime);
								     if(controltime!=""){
								        var reg = /^[+]{0,1}(\d+)$/g;
	                                      if (!reg.test(controltime)) {
	                                             layer.msg("管控时间请输入正整数！", { icon: 5, anim: 6 });
	                                     }else{
	                                      $.getJSON(locat+"/updatecontroltime.do?controltime="+controltime+'&menuid='+${param.menuid},{},function(data) {
								         var str = eval('(' + data + ')');
						      	          if (str.flag ==1) {		                          
										     top.layer.msg("时间管控设置成功！"); 
										     layer.close(index);	
										     table.reload('followTable1', {});       		          
									       	 }else{
												 top.layer.msg("时间管控设置失败!");
									      	 }			      	    		
									      });  
									     }    
								     }else{
								           layer.msg("请输入要设置的管控时间！", { icon: 5, anim: 6 });
								     }
							       }
                        	});
						});
					}
					break;
				  case 'incontrollevel':
				  var data=JSON.stringify(checkStatus.data);
				  var datas=JSON.parse(data);
				  if(datas!=""){
				  		var kongextendid=datas[0].kongextendid;
						layer.confirm('确定要归档该人员信息？', function(index){
					      layer.close(index);
					      layer.prompt({
								formType: 2,//这里依然指定类型是多行文本框，但是在下面content中也可绑定多行文本框
								title: '归档理由',
								area: ['300px', '300px'],
								btnAlign: 'c',
								content: `<div><p>请输入归档理由：</p><textarea name="gdreason" id="gdreason" style="height:200px;width:300px;"></textarea></div>`,
								yes: function (index, layero) {
								     $.getJSON(locat+"/updateincontrollevel.do?id="+kongextendid+'&menuid='+${param.menuid}+'&gdreason='+$('#gdreason').val(),{},function(data) {
										 var str = eval('(' + data + ')');
								      	 if (str.flag ==1) {		                          
										     top.layer.msg("风险人员归档成功！");
										     layer.close(index);
										     table.reload('followTable1', {});                 
								       	 }else{
											 top.layer.msg("风险人员归档失败!");
								      	 }			      	    		
								      });
							       }
                        	});
						});
					}else{
						layer.alert("请先选择归档哪条数据！");
					}
					break;
				case 'import':
		   var index = layui.layer.open({
				 title : "导入涉恐人员信息",
				 type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
				 content : "<c:url value="/jsp/personel/kong/import.jsp?menuid=${param.menuid }"/>",
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
					$("#search1").click(); 
				}
			 });	
		    break;
				  case 'export':
				   	var index = layui.layer.open({
						title : "涉恐人员信息导出",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content : '<c:url value="/jsp/personel/kong/export.jsp?menuid='+${param.menuid}+'"/>',
						area: ['1000px', '700px'],
						maxmin: true,
						success : function(layero, index){
							setTimeout(function(){
								layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
									tips: 3
								});
							},500)
						}
					});
				  break;
				  case 'tz':
					var data=JSON.stringify(checkStatus.data);
					var datas=JSON.parse(data);
					if(datas!=""){
						if(datas[0].tz==0){
							var kongextendid=datas[0].kongextendid;
							layer.confirm('确定该人员有台账？', function(index){
						    	layer.close(index);
						    	$.getJSON(locat+"/tzKongPersonel.do?tz=1&id="+kongextendid+"&menuid=${param.menuid}",{},function(data) {
									var str = eval('(' + data + ')');
						      	 	if (str.flag ==1) {		                          
								     	top.layer.msg("做台账成功！"); 	
								     	$("#search1").click();                
						       	 	}else{
										top.layer.msg("做台账失败!");
						      	 	}			      	    		
						      	});
						    });
						}else{
							var kongextendid=datas[0].kongextendid;
							layer.confirm('该人员已有台账，是否取消该人员台账？', function(index){
						    	layer.close(index);
						    	$.getJSON(locat+"/tzKongPersonel.do?tz=0&id="+kongextendid+"&menuid=${param.menuid}",{},function(data) {
									var str = eval('(' + data + ')');
						      	 	if (str.flag ==1) {		                          
								     	top.layer.msg("做台账成功！"); 	
								     	$("#search1").click();                
						       	 	}else{
										top.layer.msg("做台账失败!");
						      	 	}			      	    		
						      	});
						    });
						}
					}else{
						layer.alert("请先选择数据！");
					}
				  break;
	         }
		});
		
		//触发排序事件 
		table.on('sort(followTable1)', function(obj){ //注：sort 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
		  //console.log(obj.field); //当前排序的字段名
		  //console.log(obj.type); //当前排序类型：desc（降序）、asc（升序）、null（空对象，默认排序）
		  //console.log(this); //当前排序的 th 对象
	  	  if(obj.type!=null)sortsql="ORDER BY "+obj.field+" "+obj.type;
	  	  else sortsql="ORDER BY "+obj.field+" asc";
		  sortdiv.attr("lay-sort",obj.type!=null?obj.type:"asc");
		  table.reload('followTable1', {
		  		initSort: obj,
				where: { // 设定异步数据接口的额外参数，任意设
					personname:$("#personname1").val(),					
					cardnumber:$("#cardnumber1").val(),
					sexes:$("#sexes").val(),
					nativeplace:$("#nativeplace").val(),
					homeplace:$("#homeplace").val(),
					jointtype:$("#jointtype").val(),
					isassign:$("#isassign").val(),
					jurisdictunit1:$("#jurisdictunit1").val(),
					sortsql:	sortsql
				},
				page: {
					curr: 1
					// 重新从第 1 页开始
				}
			});
		});
		
		//监听行工具事件
		table.on('toolbar(GDfollowTable)', function(obj){
			var checkStatus =table.checkStatus(obj.config.id);
			switch(obj.event){
				case 'add':
			  		var index = layui.layer.open({
						title : "新增涉恐人员信息",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content : '<c:url value="/jsp/personel/kong/add.jsp?menuid='+${param.menuid}+'"/>',
						area: ['800', '700px'],
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
			   		break;
			   	case 'update':
			  		var data=JSON.stringify(checkStatus.data);
			  		var datas=JSON.parse(data);
					if(datas!=""){
					  	var id=datas[0].id;
					   	var index = layui.layer.open({
							title : "修改人员信息",
							type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
							content : locat+'/getKongPersonelUpdate.do?personnelid='+id+'&buttons='+'${param.buttons }'+'&menuid='+${param.menuid}+'&page=update',
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
								layui.table.reload('followTable1', { }); 
							}
						})			
						layui.layer.full(index);
					}else{
						layer.alert("请先选择修改哪条数据！");
					}
			   		break;
			   case 'cancel':
				  var data=JSON.stringify(checkStatus.data);
				  var datas=JSON.parse(data);
				  if(datas!=""){
					  	var id=datas[0].personlabel;//暂存涉恐扩展表id
					  	var personnelid=datas[0].id;//人员表id
						layer.confirm('确定删除此信息？', function(index){
					      layer.close(index);
					      $.getJSON(locat+"/cancelKongPersonel.do?id="+id+'&personnelid='+personnelid+'&menuid='+${param.menuid},{},function(data) {
							 var str = eval('(' + data + ')');
					      	 if (str.flag ==1) {		                          
							     top.layer.msg("数据删除成功！"); 	
							     table.reload('followTable1', {});                 
					       	 }else{
								 top.layer.msg("删除失败!");
					      	 }			      	    		
					      });      
						});
					}else{
						layer.alert("请先选择删除哪条数据！");
					}
					break;
				 case 'assign':
				var data=JSON.stringify(checkStatus.data);
			  		var datas=JSON.parse(data);
					if(datas!=""){
					  	var id=datas[0].id;
					   	var index = layui.layer.open({
							title : "指派人员信息",
							type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
							content : locat+'/getKongPersonelUpdate.do?personnelid='+id+'&menuid='+${param.menuid}+'&page=assign',
							area: ['1000px', '600px'],
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
						layer.alert("请先选择修改指派数据！");
					}
					break;
				 case 'controltime':
				var data=JSON.stringify(checkStatus.data);
			  		var datas=JSON.parse(data);
					if(datas!=""){
					  	var kongextendid=datas[0].kongextendid;
					   	layer.prompt({
							formType: 2,//这里依然指定类型是多行文本框，但是在下面content中也可绑定多行文本框
							title: '时间管控',
							area: ['300px', '100px'],
							btnAlign: 'c',
							content: `<div><input type="text" name="controltime" id="controltime"  placeholder="请输入管控时间" class="layui-input"></div>`,
							yes: function (index, layero) {
							     var controltime = $('#controltime').val();//获取多行文本框的值
							     //alert('您刚才输入了:' + controltime);
							     if(controltime!=""){
							        var reg = /^[+]{0,1}(\d+)$/g;
                                      if (!reg.test(controltime)) {
                                             layer.msg("管控时间请输入正整数！", { icon: 5, anim: 6 });
                                     }else{
                                      $.getJSON(locat+"/updatecontroltime.do?id="+kongextendid+'&controltime='+controltime+'&menuid='+${param.menuid},{},function(data) {
							         var str = eval('(' + data + ')');
					      	          if (str.flag ==1) {		                          
									     top.layer.msg("时间管控设置成功！"); 
									     layer.close(index);	
									     table.reload('followTable1', {});       		          
								       	 }else{
											 top.layer.msg("时间管控设置失败!");
								      	 }			      	    		
								      });  
								     }    
							     }else{
							           layer.msg("请输入要设置的管控时间！", { icon: 5, anim: 6 });
							     }
						       }
                         });
					}else{
						layer.alert("请先选择修改管控数据！");
					}
					break;
				  case 'reduction':
				  var data=JSON.stringify(checkStatus.data);
				  var datas=JSON.parse(data);
				  if(datas!=""){
					  var kongextendid=datas[0].kongextendid;
						layer.confirm('确定要还原该人员信息？', function(index){
					      layer.close(index);
					      $.getJSON(locat+"/updateincontrollevelhy.do?id="+kongextendid+'&menuid='+${param.menuid},{},function(data) {
							 var str = eval('(' + data + ')');
					      	 if (str.flag ==1) {		                          
							     top.layer.msg("风险人员归档成功！"); 	
							     table.reload('GDfollowTable', {});                 
					       	 }else{
								 top.layer.msg("风险人员还原失败!");
					      	 }			      	    		
					      });      
						});
					}else{
						layer.alert("请先选择删除还原数据！");
					}
					break;
				case 'import':
		   var index = layui.layer.open({
				 title : "导入涉恐人员信息",
				 type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
				 content : "<c:url value="/jsp/personel/kong/import.jsp?menuid=${param.menuid }"/>",
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
					$("#search1").click(); 
				}
			 });	
		    break;
				  case 'export':
				   	var index = layui.layer.open({
						title : "涉恐人员信息导出",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content : '<c:url value="/jsp/personel/kong/export.jsp?menuid='+${param.menuid}+'"/>',
						area: ['1000px', '700px'],
						maxmin: true,
						success : function(layero, index){
							setTimeout(function(){
								layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
									tips: 3
								});
							},500)
						}
					});
				  break;
				  case 'tz':
					var data=JSON.stringify(checkStatus.data);
					var datas=JSON.parse(data);
					if(datas!=""){
						if(datas[0].tz==0){
							var kongextendid=datas[0].kongextendid;
							layer.confirm('确定该人员有台账？', function(index){
						    	layer.close(index);
						    	$.getJSON(locat+"/tzKongPersonel.do?tz=1&id="+kongextendid+"&menuid=${param.menuid}",{},function(data) {
									var str = eval('(' + data + ')');
						      	 	if (str.flag ==1) {		                          
								     	top.layer.msg("做台账成功！"); 	
								     	$("#search1").click();                
						       	 	}else{
										top.layer.msg("做台账失败!");
						      	 	}			      	    		
						      	});
						    });
						}else{
							var kongextendid=datas[0].kongextendid;
							layer.confirm('该人员已有台账，是否取消该人员台账？', function(index){
						    	layer.close(index);
						    	$.getJSON(locat+"/tzKongPersonel.do?tz=0&id="+kongextendid+"&menuid=${param.menuid}",{},function(data) {
									var str = eval('(' + data + ')');
						      	 	if (str.flag ==1) {		                          
								     	top.layer.msg("做台账成功！"); 	
								     	$("#search1").click();                
						       	 	}else{
										top.layer.msg("做台账失败!");
						      	 	}			      	    		
						      	});
						    });
						}
					}else{
						layer.alert("请先选择数据！");
					}
				  break;
	         }
		});
		
		//触发排序事件 
		table.on('sort(GDfollowTable)', function(obj){ //注：sort 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
		  //console.log(obj.field); //当前排序的字段名
		  //console.log(obj.type); //当前排序类型：desc（降序）、asc（升序）、null（空对象，默认排序）
		  //console.log(this); //当前排序的 th 对象
	  	  if(obj.type!=null)GDsortsql="ORDER BY "+obj.field+" "+obj.type;
	  	  else GDsortsql="ORDER BY "+obj.field+" asc";
		  GDsortdiv.attr("lay-sort",obj.type!=null?obj.type:"asc");
		  table.reload('GDfollowTable', {
		  		initSort: obj,
				where: { // 设定异步数据接口的额外参数，任意设
					personname:$("#GDpersonname").val(),					
					cardnumber:$("#GDcardnumber").val(),
					sexes:$("#GDsexes").val(),
					nativeplace:$("#GDnativeplace").val(),
					homeplace:$("#GDhomeplace").val(),
					jointtype:$("#GDjointtype").val(),
					isassign:$("#GDisassign").val(),
					jurisdictunit1:$("#GDjurisdictunit1").val(),
					GDsortsql:	GDsortsql
				},
				page: {
					curr: 1
					// 重新从第 1 页开始
				}
			});
		});
	
		//监听行工具事件
	  table.on('tool(followTable1)', function(obj){
		  var id = obj.data.id;
		  if(obj.event == 'styzf'){
		       var index = layui.layer.open({
					title : "三日一走",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content :locat+"/toDailycontrolPage.do?personnelid="+id,
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
		    }else if(obj.event == 'mypg'){
		       var index = layui.layer.open({
					title : "每月评估",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content :locat+"/jsp/personel/kong/monthlyassessment/list.jsp?personnelid="+id,
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
    	
    	//监听行工具事件
	  table.on('tool(GDfollowTable)', function(obj){
		  var id = obj.data.id;
		  if(obj.event == 'styzf'){
		       var index = layui.layer.open({
					title : "三日一走",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content :locat+"/toDailycontrolPage.do?personnelid="+id,
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
		    }else if(obj.event == 'mypg'){
		       var index = layui.layer.open({
					title : "每月评估",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content :locat+"/jsp/personel/kong/monthlyassessment/list.jsp?personnelid="+id,
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
 
  function showinfoPersonel(id){
 	var index = layui.layer.open({
					title : "风险人员详情",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content : locat+'/getKongPersonelUpdate.do?personnelid='+id+'&menuid='+${param.menuid}+'&page=showinfo',
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
    //三日一走访查询
   function openKongDailyControl1(){
   		 var allcount=0;
   		 index_search= layer.msg('数据加载中，请稍候',{icon: 16,time:false,shade:0.3});
		  //方法级渲染
		  layui.table.render({
		    elem: '#followTable2',
		    toolbar: true,
		    defaultToolbar: ['filter', 'exports', 'print'],
		    url: '<c:url value="/getAllDailycontrol.do?controltype=1"/>',
		    toolbar: '#KDtoolbarButton',
		    method:'post',
		    cols: [[
		         {field:'personname', title: '姓名', width:150,templet: function (item) {
				   		return "<span style='font-weight:500;cursor:pointer;' onclick='showinfoPersonel("+item.personnelid+");'><font color='blue'>"+item.personname+"</font></span>";
		           }},
		    	{field:'cardnumber', title: '身份证号码', width:170,templet: function (item) {
				   		return "<span style='font-weight:500;cursor:pointer;' onclick='showinfoPersonel("+item.personnelid+");'><font color='blue'>"+item.cardnumber+"</font></span>";
		           }} ,
		        {field:'controltime', title: '管控时间', width:110,align:"center"},
		        {field:'controlmode', title: '管控方式', width:100,align:"center"},
		        {field:'controlcontent', title: '反馈内容', align:"center",templet: function (item) {
						var controlcontent="";
						if(item.controlcontent!=null&&item.controlcontent!=""){
						  controlcontent= item.controlcontent.replace(/\n/g,"<br/>");
						}
						return "<div>"+controlcontent+"</div>";
		           }},
		        {field:'addoperatordepart', title: '填写派出所',width:120,align:"center"} ,
		        {field:'addoperator', title: '填写民警',width:90,align:"center"} ,
		        {field:'addtime', title: '填写时间',width:110,align:"center"} ,
		        {field:'filesallname', title: '图片附件',align:"center",templet: function (item) {
				        var options="";
                if(item.fileattachments!=null&&item.fileattachments!=""){
	               $.ajax({
						type:		'POST',
						url:		'<c:url value="/getFileNames.do"/>',
						data:		{
										fileattachments: item.fileattachments
									},
						dataType:	'json',
						async:      false,
						success:	function(data){
						   var obj = eval('(' + data + ')');
						   var num=item.LAY_TABLE_INDEX+1;  //行号
					         console.log(num);
					        if(obj.msg==""){
					          options+='<div id="filelist'+num+'">';
					          options +='</div>';
						    }else{
						      var  riskFilesView=obj.msg.split(",");
					            if(riskFilesView.length>0){
										var viewname=obj.result.split(",");
										var viewname1=obj.msg.split(",");
										var mark=obj.mark.split(",");
										options+='<div id="filelist'+num+'">';
										$.each(riskFilesView,function(index,item){
										if(mark[index]==1){
										    options +='<img style="float:left;"  src="/../uploadFiles/pictures/'+viewname1[index]+'">';
										}else{
										    options +='<img style="float:left;"  src="/../uploadFiles/'+viewname1[index]+'">';
										}
										
								});
							   options +='</div>';
							}
						 }
					   }
					});
                 }
				    return options;
				}}
				
		    ]],
		    page: true,
		    limit: 10,
		    done: function(res, curr, count){//数据渲染完的回调
		      allcount=count;
		      for(var i=1;i<=count;i++){
		        var imgdiv=document.getElementById("filelist"+i);
		        if(imgdiv!=null){
			          new Viewer(imgdiv,{ 
			              navbar:	false //点击查看时不显示缩略图
				      });
                 }
		      }
		      layer.close(index_search);
		      }
		    });
		    
		    layui.table.on('toolbar(followTable2)', function(obj){
				switch(obj.event){
					  case 'export':
					   	top.layer.confirm('确定导出当前三日一走访信息？', function(index){
					        if(allcount>60000){
					        	top.layer.msg("导出数据超过6万条！！无法导出！！");
					        }else{
						        top.layer.close(index);
						        window.location.href='<c:url value="/exportAllDailycontrol.do"/>?controltype=1&personname='+$("#personname2").val()+'&cardnumber='+$("#cardnumber2").val()+'&controlmode='+$("#controlmode").val()+'&starttime='+$("#starttime2").val()+'&endtime='+$("#endtime2").val()+'&menuid='+${param.menuid};
					        	top.layer.msg("若导出数据超过6万条，则会导致导出表格为无数据！！！");
					        }
							return false;      
						});
					  break;
					  
		         }
			});
   }
 
  //每月评估查询
   function openKongDailyControl2(){
	   //方法级渲染
	  layui.table.render({
	    elem: '#followTable3',
	    toolbar: true,
	    defaultToolbar: ['filter', 'exports', 'print'],
	   url: '<c:url value="/getAllDailycontrol.do?controltype=2"/>',
	    method:'post',
	    cols: [[
	         {field:'personname', title: '姓名', width:150,templet: function (item) {
				   		return "<span style='font-weight:500;cursor:pointer;' onclick='showinfoPersonel("+item.personnelid+");'><font color='blue'>"+item.personname+"</font></span>";
		       }},
		    {field:'cardnumber', title: '身份证号码', width:170,templet: function (item) {
				   		return "<span style='font-weight:500;cursor:pointer;' onclick='showinfoPersonel("+item.personnelid+");'><font color='blue'>"+item.cardnumber+"</font></span>";
		      }} ,
	        {field:'controltime', title: '评估时间', width:110,align:"center"},
	        {field:'controlcontent', title: '评估内容', align:"center",templet: function (item) {
					var controlcontent="";
				if(item.controlcontent!=null&&item.controlcontent!=""){
				  controlcontent= item.controlcontent.replace(/\n/g,"<br/>");
				}
					return "<div>"+controlcontent+"</div>";
	           }},
	        {field:'addoperatordepart', title: '填写派出所',width:120,align:"center"} ,
	        {field:'addoperator', title: '填写民警',width:100,align:"center"} ,
	        {field:'addtime', title: '填写时间',width:110,align:"center"}
	      
	    ]],
	    page: true,
	    limit: 10,
	    done: function(res, curr, count){//数据渲染完的回调
	     }
	    });
   }
   
   //归档人员数据
   function openGdPerson(){
   	  //方法级渲染
	  layui.table.render({
	    elem: '#GDfollowTable',
	    toolbar: true,
	    defaultToolbar: ['filter', 'exports', 'print'],
	    url: '<c:url value="/getKongPersonnel.do"/>',
	    where:{incontrollevel:'归档'},
	    method:'post',
	    toolbar: '#GDtoolbarButton',
	    autoSort: false,
	    cols: [[
	        {field:'id',type:'radio',fixed:'true',align:"center"},
            {field:'lay_table_index',type:'numbers',fixed:'true',align:"center", width:80},
	        {field:'personname', title: '姓名', width:180,templet: function (item) {
			   		if(item.tz==0){
	        			return "<span style='font-weight:500;cursor:pointer;' onclick='showinfoPersonel("+item.id+");'><font color='blue'>"+item.personname+"</font></span>";
	        		}else{
	        			return "<span style='font-weight:500;cursor:pointer;' onclick='showinfoPersonel("+item.id+");'><font color='blue'>"+item.personname+"</font></span><image style='padding-bottom:6px' src='"+locat+"/images/fivestar.png'></image>";
	        		}
	           }},
	    	{field:'cardnumber', title: '身份证号码', width:180,templet: function (item) {
			   		return "<span style='font-weight:500;cursor:pointer;' onclick='showinfoPersonel("+item.id+");'><font color='blue'>"+item.cardnumber+"</font></span>";
	           }} ,
	        {field:'sexes', title: '性别', width:80,align:"center"} ,
	        {field:'nativeplace', title: '籍贯', width:120,align:"center"} ,
	        {field:'jointtype', title: '联控级别', width:90,align:"center",templet: function (item) {
			          if (item.jointtype=="1") {
			             return "<span style='font-weight:900'><font color='red'>红色</font></span>";
			         }else if(item.jointtype=="2"){
			           return "<span style='font-weight:900'><font color='orange'>橙色</font></span>";
			         }else if(item.jointtype=="3"){
			           return "<span style='font-weight:900'><font color='yellow'>黄色</font></span>";
			         }else if(item.jointtype=="4"){
			           return "<span style='font-weight:900'><font color='blue'>蓝色</font></span>";
			         }else{
			             return "<span style='font-weight:900'></span>";
			         }
	        }}, 
	      {field:'controltime', title: '管控时间', width:100,align:"center"},
	      {field:'isassign', title: '指派情况',width:250,align:"center",templet: function (item) {
		          if (item.isassign=="1") {
		             return "<span><font color='red'>未指派</font></span>";
		         }else if(item.isassign=="2"){
		           var str="";
		           if(item.isFilter!=null){
		             str+=item.isFilter+"("+item.qq+")";
		           }
		           if(item.filtervalue!=null){
		             str+="<br>"+item.filtervalue+"("+item.wechat+")";
		           }
		           return str;
		         }
        	}},
	       {field:'gdtime', title: '归档时间', width:170} , 
	       {field:'gdreason', title: '归档理由'} , 
	      {field: 'right', title: '操作', toolbar: '#barButton',width:180,align:"center"} 
	    ]],
	    page: true,
	    limit: 10,
	    done: function(){
	    	$("#incontrollevel").val("归档");
	    	if(GDsortfield!=""&&GDsortdiv!=""){
	    		$("#GDfollowTable").next().find("table>thead>tr>th[data-field="+GDsortfield+"]").find("div").append(GDsortdiv);
	    	}
	    	$("#GDfollowTable").next().find("table>thead>tr>th").css("cursor","pointer");
			$("#GDfollowTable").next().find("table>thead>tr>th").click(function () {
		 			var field=$(this).attr("data-field");
		 			if(field!=0&&field!=GDsortfield&&field!="right"){
			  			GDsortfield=field;
			  			if(GDsortdiv!="")GDsortdiv.remove();
			  			GDsortdiv=$('<span class="layui-table-sort layui-inline" lay-sort="asc"><i class="layui-edge layui-table-sort-asc" title="升序"></i><i class="layui-edge layui-table-sort-desc" title="降序"></i></span>');
			  			$(this).find("div").append(GDsortdiv);
			  			$(this).click();
		 			}
			});
			if(GDsortfield==""&&GDsortdiv==""){
	    		$("#GDfollowTable").next().find("table>thead>tr>th[data-field=updatetime]").click();;
	    	}
	    }
	    });
   }
</script> 
</body>

</html>