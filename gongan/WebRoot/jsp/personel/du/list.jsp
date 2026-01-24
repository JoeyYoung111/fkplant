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
    <title>涉毒人员查询</title>
    <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
     <link rel="stylesheet" href="<c:url value="/css/public.css"/>"  media="all" />
     <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
     <script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
     <script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/jsp/personel/DepartmentTree.js"/>"></script>
  </head>
  
 <body class="childrenBody layui-fluid">
		<div class="layui-tab my-tab layui-tab-brief" lay-filter="docDemoTabBrief">
			<ul class="layui-tab-title my-tab-title">
				<li class="layui-this"><font size="4">社会吸毒人员</font></li>
				<li  id="zhidu"  onclick="openZhiDu();"><font size="4">制贩毒风险人员</font></li>
				<li  onclick="openChemistry();"><font size="4">懂化学技术人员</font></li>
			</ul>
			<div class="layui-tab-content" style="height: 100px;">
				<div class="layui-tab-item layui-show">
				   <blockquote class="layui-elem-quote news_search">	
						<div class="demoTable">
						 <form class="layui-form" method="post" style="display:inline;">
						 
							<div class="layui-inline">
						    	<input class="layui-input" name="personname" id="personname1" autocomplete="off" placeholder="姓名："  style="width:170px;">
						 	</div>
						     <div class="layui-inline" >
								<input class="layui-input" name="cardnumber" id="cardnumber1" style="width:170px;" autocomplete="off" placeholder="身份证号：">
							</div>
							<div class="layui-inline" style="width:170px;">
								<select id="sexes1"  name="sexes" >
							 		<option value="">性别：全部</option>
							 		<option value='女'>女</option>
							 		<option value='男'>男</option>
								</select>
							</div>
							<input type="hidden" id="narcoticstype1" value="">
<%--							<div class="layui-inline" style="width:170px;">--%>
<%--								<select id="narcoticstype1"  name="narcoticstype"></select>--%>
<%--							</div>--%>
						 	<div class="layui-inline" style="width:170px;">
								<select id="ptype1"  name="ptype">
								     <option  value="">人员类别：全部</option>
				      			     <option  value="本地在册">本地在册</option>
				      			     <option  value="外来前科">外来前科</option>
								</select>
							</div>
							
							<br>
						 	
						 	<div class="layui-inline" style="width:170px;">
						    	<select name="unitname1" id="unitname1_1" lay-filter="unitname1_1"></select>
						 	</div>
						 	<div class="layui-inline" style="width:170px;">
						    	<select name="controlstatus" id="controlstatus_1" lay-filter="controlstatus_1"></select>
						 	</div>
						    <div class="layui-inline" style="width:170px;">
								<select id="jointcontrollevel1"  name="jointcontrollevel"></select>
							</div>
							<div class="layui-inline" style="width:170px;">
								<select id="incontrollevel1" name="incontrollevel"></select>
							</div>
							<input type="hidden" id="casename1" value="">
<%--							<div class="layui-inline" style="width:170px;">--%>
<%--								<select id="casename1"  name="casename"></select>--%>
<%--							</div>--%>
							
							<br>
							
							<div class="layui-inline" style="width:170px;">
								<select id="checkRecord"  name="checkRecord">
								     <option value="">检测记录：全部</option>
<%--				      			     <option value=">0">有记录</option>--%>
<%--				      			     <option value="=0">无记录</option>--%>
								</select>
							</div>
							<input type="hidden" id="startTime" value="">
							<input type="hidden" id="endTime" value="">
<%--							<div class="layui-inline">--%>
<%--								<input type="text" name="startTime" class="layui-input" id="startTime" style="width:170px;" placeholder="发检时间段:起始时间" autocomplete="off"/>--%>
<%--							</div>--%>
<%--							<div class="layui-inline">--%>
<%--								<input type="text" name="endTime" class="layui-input" id="endTime" style="width:170px;" placeholder="发检时间段:截止时间" autocomplete="off"/>--%>
<%--							</div>--%>
							<div class="layui-inline" style="width:170px;">
								<select id="caredperson"  name="caredperson">
								     <option value="0">关爱对象：全部</option>
				      			     <option value="2">关爱对象</option>
				      			     <option value="1">非关爱对象</option>
								</select>
							</div>
							<div class="layui-inline" style="width:170px;">
								<select id="yesorno"  name="yesorno">
								     <option value="">人员现状：全部</option>
				      			     <option value="-1">人户分离（否）</option>
				      			     <option value="1">人户分离（是）</option>
				      			     <option value="-2">双向管控（否）</option>
				      			     <option value="2">双向管控（是）</option>
				      			     <option value="-3">精神疾病患者（否）</option>
				      			     <option value="3">精神疾病患者（是）</option>
				      			     <option value="-4">病残人员（否）</option>
				      			     <option value="4">病残人员（是）</option>
				      			     <option value="-5">三年内处罚人员（否）</option>
				      			     <option value="5">三年内处罚人员（是）</option>
								</select>
							</div>
							<input type="hidden" id="addtime1" value="">
<%--							<div class="layui-inline" style="width:170px;">--%>
<%--								<input type="text" name="addtime" class="layui-input" id="addtime1" style="width:170px;" placeholder="建档时间" autocomplete="off"/>--%>
<%--							</div>--%>
							
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
						    	<input class="layui-input" name="personname" id="personname2" autocomplete="off" placeholder="姓名：" style="width:170px;">
						 	</div>
						     <div class="layui-inline" >
								<input class="layui-input" name="cardnumber" id="cardnumber2" style="width:170px;" autocomplete="off" placeholder="身份证号：">
							</div>
							 <div class="layui-inline" style="width:170px;">
								<select id="sexes2"  name="sexes">
							 		<option value=''>性别：全部</option>
							 		<option value='女'>女</option>
							 		<option value='男'>男</option>
								</select>
							</div>
							<div class="layui-inline" style="width:170px;">
								<select id="narcoticstype2"  name="narcoticstype"></select>
							</div>
	                         
							<br>

	                         <div class="layui-inline" style="width:170px;">
								<select id="ptype2"  name="ptype">
								     <option  value="">人员类别：全部</option>
				      			     <option  value="本地在册">本地在册</option>
				      			     <option  value="外来前科">外来前科</option>
								</select>
							</div>
						 	<div class="layui-inline" style="width:170px;">
						 		<select name="unitname1" id="unitname1_2" lay-filter="unitname1_2"></select>
						 	</div>
						 	<div class="layui-inline" style="width:170px;">
						    	<select name="controlstatus" id="controlstatus_2" lay-filter="controlstatus_2"></select>
						 	</div>
						     <div class="layui-inline" style="width:170px;">
								<select id="jointcontrollevel2"  name="jointcontrollevel"></select>
							</div>
							
							<br>
							
							<div class="layui-inline" style="width:170px;">
								<select id="incontrollevel2"  name="incontrollevel"></select>
							</div>
							<div class="layui-inline" style="width:170px;">
								<select id="casename2"  name="casename"></select>
							</div>
							<div class="layui-inline" style="width:170px;">
								<input type="text" name="addtime" class="layui-input" id="addtime2" style="width:170px;" placeholder="建档时间" autocomplete="off"/>
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
						<form class="layui-form" method="post" style="display:inline;" id="Chemistryform" action="<c:url value="/exportChemistryPersonel.do"/>">
							<div class="layui-inline">
						    	<input class="layui-input" name="companyname" id="companyname" autocomplete="off" placeholder="所属企业："  style="width:170px;">
						 	</div>
							<div class="layui-inline">
								<input type="text" class="layui-input" style="width:187px;" name="Chpersonname" id="Chpersonname" placeholder="姓名："/>
							</div>
							<div class="layui-inline" style="width:187px;">
								<select id="Chsexes" name="Chsexes">
									<option value="" selected>性别:全部</option>
									<option value="男">男</option>
									<option value="女">女</option>
								</select>
							</div>
							<div class="layui-inline">
								<input type="text" class="layui-input" style="width:187px;" name="Chcardnumber" id="Chcardnumber" placeholder="身份证号码："/>
							</div>
							<div class="layui-inline">
								<input type="text" class="layui-input" style="width:187px;" name="Chtelephone" id="Chtelephone" placeholder="联系电话："/>
							</div>
						</form>
						<button class="layui-btn" id="searchChemistry" data-type="reload"><i class="layui-icon">&#xe615;</i>搜索</button>
						<button type="reset" id="reset3" class="layui-btn"><i class="layui-icon">&#xe702;</i>重置</button>
					</div>
					</blockquote>
					    <table class="layui-hide" id="ChemistryTable" lay-filter="ChemistryTable"></table>
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
				<c:if test='${fn:contains(param.buttons,"导入")}'>
	               <button type="button" class="layui-btn layui-btn-sm" lay-event="import"><i class="layui-icon">&#xe601;</i>导 入</button>   
				</c:if>
				<c:if test='${fn:contains(param.buttons,"导出")}'>
		           <button type="button" class="layui-btn layui-btn-sm" lay-event="export"><i class="layui-icon layui-icon-export"></i>导出</button>
				</c:if>
				<c:if test='${fn:contains(param.buttons,"打印")}'>
				   <button id="dayinBtn" class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more" lay-event="dy">&#xe66d; 打印</button>
				</c:if>
        </script> 
		<script type="text/html" id="barButton">
               <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="showinfo">详情</a>  
        </script>			
		</div>	
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
function xiduguanxiaTree(){
	$.ajax({
		type:	'post',
		url:	'<c:url value="/xiduguanxiaTree.do"/>?departtype='+4,
		dataType:	'json',
		async:		false,
		success:	function(data){
			var options = fillOption(data);
			options = '<option value="">管辖单位：全部</option>'+options;
			$("#unitname1_1").html(options);
			$("#unitname1_2").html(options);
		}
	});
}

function guankongleibie(){
	$.ajax({
		type:		'POST',
		 url:		'<c:url value="/getBMByTypeToJSON1.do" />?basicType='+82, //
		 dataType:	'json',
		 async :      false,
		 success:	function(data){					  
		      var options = '<option value="">管控类别：全部</option>' + fillOption(data);
		      $("select[name^=jointcontrollevel]").html(options);
		   }
	});
}

function zaikongzhuangtai(){
	$.ajax({
			type:		'POST',
			url:		'<c:url value="/getBMByTypeToJSON1.do" />?basicType='+101, //在控级别
			dataType:	'json',
			async :      false,
			success:	function(data){					  
		        var options = '<option value="">在控状态：全部</option>' + fillOption(data);
		        $("select[name^=incontrollevel]").html(options);
		   }
	});
}

function guankong(){
	$.ajax({
			type:		'POST',
			url:		'<c:url value="/getBMByTypeToJSON1.do" />?basicType='+85, //管控
			dataType:	'json',
			async :      false,
			success:	function(data){					  
		        var options = '<option value="">管控状态：全部</option>' + fillOption(data);
		        $("select[name^=controlstatus]").html(options);
		   }
	});
}

/*
function minzu(){
  	$.ajax({
		type:		'POST',
		 url:		'<c:url value="/getBMByTypeToJSON.do" />?basicType='+15, //民族
		 dataType:	'json',
		 async :      false,
		 success:	function(data){					  
	      var options = '<option value="">民族：全部</option>' + fillOption(data);
	      $("select[name^=nation]").html(options);
           }
         });
}
*/

function dupin(){
	$.ajax({
		 type:		'POST',
		 url:		'<c:url value="/getBMByTypeToJSON1.do" />?basicType='+36, //毒品
		 dataType:	'json',
		 async :      false,
		 success:	function(data){					  
	      	var options = '<option value="">毒品种类：全部</option>' + fillOption(data);
	      	$("select[name^=narcoticstype]").html(options);
         }
    });
}

function getcasename(){
	$.ajax({
		type:		'POST',
		url:		'<c:url value="/getBMByTypeToJSON.do"/>?basicType='+102, //其他案件类别
		dataType:	'json',
		async:		false,
		success:	function(data){
			var options = '<option value="">其他案件：全部</option>' + fillOption(data);
			$("select[name^=casename]").html(options);
		}
	});
}

function getcheckRecord(){
	for(var i=2022;i<=now.getFullYear();i++){
		$("#checkRecord").append('<option value="'+i+'">'+i+'年记录</option>');
	}
}

$(function(){if('main'== locat[3]){locat =  locat[0]+'//'+locat[2];}else{locat =  locat[0]+'//'+locat[2]+'/'+locat[3];};});

$(document).ready(function(){
	
	guankongleibie();
    zaikongzhuangtai()
	guankong();	
	dupin();			
	xiduguanxiaTree();
	getcasename();
	getcheckRecord();
	layui.form.render();
	
});

layui.use(['form', 'table', 'laydate','element'], function() {
		var $ = layui.jquery,
		    element = layui.element,
			form = layui.form,
			table = layui.table,
			laydate = layui.laydate;
			
			laydate.render({
				elem:	'#startTime',
				trigger:'click'
			});
			
			laydate.render({
				elem:	'#endTime',
				trigger:'click'
			});
			
			laydate.render({
				elem:	'#addtime1',
				type:	'year',
				trigger:'click'
			});
			
			laydate.render({
				elem:	'#addtime2',
				type:	'year',
				trigger:'click'
			});
		
	    //吸毒人员-方法级渲染
	   table.render({
	    	elem: '#followTable1',
	    	toolbar: true,
	    	defaultToolbar: ['filter', 'exports', 'print'],
	    	url: '<c:url value="/searchDuPersonnel.do"/>?personneltype=1',
	    	method:'post',
	    	toolbar: '#toolbarButton',
	    	cols: [[
		        {field:'id',type:'radio',fixed:'true',align:"center"},
		        {field:'personname', title: '姓名', width:100,templet: function (item) {
			   		return "<span style='font-weight:500;cursor:pointer;' onclick='showinfoPersonel_Xi("+item.personnelid+");'><font color='blue'>"+item.personname+"</font></span>";
	             }},
	    	     {field:'cardnumber', title: '身份证号码', width:200,templet: function (item) {
			   		return "<span style='font-weight:500;cursor:pointer;' onclick='showinfoPersonel_Xi("+item.personnelid+");'><font color='blue'>"+item.cardnumber+"</font></span>";
	             }} ,
		        {field:'sexes', title: '性别', width:60,align:"center"} ,
		         {field:'officeName', title: '年龄', width:60,templet: function (item) {
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
		        {field:'ptype', title: '人员类别', width:150,align:"center"} ,
		        {field:'homeplace', title: '现居住地详址', width:120} ,
		        {field:'jointcontrollevel', title: '管控类别', width:90,align:"center"}, 
		        {field:'incontrollevel', title: '在控级别', width:90,align:"center"},
		        {field:'narcoticstype', title: '滥用毒品种类', align:"center"},
		        {field:'firsttime', title: '初次吸毒时间', width:120,align:"center"} ,
		        {field:'lasttime', title: '末次处罚时间', width:120,align:"center"},
		        {field:'unitname1', title: '管辖责任单位', width:150} ,
		        {field:'policename1', title: '管辖责任民警', width:100},
		        {field:'addtime', title: '建档时间', width:180,align:"center"}
	    ]],
    	page: true,
    	limit: 10
    });
    
    	//搜索查询 narcoticstype:$("#narcoticstype1").val(),homeplace:$("#homeplace1").val(),
  		$("#search1").click(function () {
			table.reload('followTable1', {
				where: { // 设定异步数据接口的额外参数，任意设
					personname:$("#personname1").val(),
					cardnumber:$("#cardnumber1").val(),
					sexes:$("#sexes1").val(),
					narcoticstype:$("#narcoticstype1").val(),
					ptype:$("#ptype1").val(),
					unitname1:$("#unitname1_1").val(),
					controlstatus:$("#controlstatus_1").val(),
					jointcontrollevel:$("#jointcontrollevel1").val(),
					incontrollevel:$("#incontrollevel1").val(),
					checkRecord:$("#checkRecord").val(),
					startTime:$("#startTime").val(),
					endTime:$("#endTime").val(),
					addtime:$("#addtime1").val(),
					caredperson:$("#caredperson").val(),
					yesorno:$("#yesorno").val(),
					casename:$("#casename1").val()
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
		//吸毒人员-监听行工具事件
		table.on('toolbar(followTable1)', function(obj){
			var checkStatus =table.checkStatus(obj.config.id);
			switch(obj.event){
				case 'add':
			  		var index = layui.layer.open({
						title : "新增社会吸毒人员信息",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content : '<c:url value="/jsp/personel/du/xidu/add.jsp?menuid='+${param.menuid}+'"/>',
						area: ['800px', '750px'],
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
					  	var personnelid=datas[0].personnelid;
					   	var index = layui.layer.open({
							title : "修改社会吸毒人员信息",
							type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
							content : locat+'/getDuPersonelUpdate.do?personnelid='+personnelid+'&buttons='+'${param.buttons }'+'&menuid='+${param.menuid}+'&page=xidu_update',
							area: ['800px', '750px'],
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
						top.layer.alert("请先选择修改哪条数据！");
					}
			   		break;
			   case 'cancel':
				  var data=JSON.stringify(checkStatus.data);
				  var datas=JSON.parse(data);
				  if(datas!=""){
					  	var id=datas[0].id;
					  	var personnelid=datas[0].personnelid;
						layer.confirm('确定删除此信息？', function(index){
					      layer.close(index);
					      $.getJSON(locat+"/cancelDuPersonel.do?id="+id+'&personnelid='+personnelid+'&menuid='+${param.menuid},{},function(data) {
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
				  case 'import':
					   var index = layui.layer.open({
							 title : "导入社会吸毒人员信息",
							 type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
							 content : "<c:url value="/jsp/personel/du/import.jsp?personneltype=1"/>",
							 area: ['600', '650'],
							 maxmin: true,
							 end: function () {
								$("#search1").click(); 
							}
						 });	
					    break;
					 case 'export':
				   	var index = layui.layer.open({
						title : "涉毒人员信息导出",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content : '<c:url value="/jsp/personel/du/xidu/export.jsp?personneltype=1&menuid='+${param.menuid}+'"/>',
						area: ['1000px', '700px'],
						offset:['60'],
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
			  case 'dy':
			  	var data = JSON.stringify(checkStatus.data);
			  	var datas = JSON.parse(data);
			  	if(datas!=""){
			  		var id = datas[0].id;
			  		window.location.href='<c:url value="/exportxidurenyuan.do"/>?id='+id;
					return false;
			  	}else{
					layer.alert("请先选择数据！");
				}
			  break;
	         }
		});
		
    
    	//制贩毒风险人员-搜索查询
  		$("#search2").click(function () {
			table.reload('followTable2', {
				where: { // 设定异步数据接口的额外参数，任意设
					personname:$("#personname2").val(),	
					cardnumber:$("#cardnumber2").val(),
					sexes:$("#sexes2").val(),
					//nation:$("#nation1").val(),
					ptype:$("#ptype2").val(),
					narcoticstype:$("#narcoticstype2").val(),
					controlstatus:$("#controlstatus_1").val(),
					//homeplace:$("#homeplace2").val(),
					unitname1:$("#unitname1_2").val(),
					jointcontrollevel:$("#jointcontrollevel2").val(),
					incontrollevel:$("#incontrollevel2").val(),
					addtime:$("#addtime2").val(),
					casename:$("#casename2").val()
				},
				page: {
					curr: 1
					// 重新从第 1 页开始
				}
			});
		});
		$("#reset2").click(function () {
		   $('form')[1].reset();
		});
		//制贩毒风险人员-监听行工具事件
		table.on('toolbar(followTable2)', function(obj){
			var checkStatus =table.checkStatus(obj.config.id);
			switch(obj.event){
				case 'add':
			  		var index = layui.layer.open({
						title : "新增制贩毒风险人员信息",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content : '<c:url value="/jsp/personel/du/zhidu/add.jsp?menuid='+${param.menuid}+'"/>',
						area: ['800px', '750px'],
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
					  	var personnelid=datas[0].personnelid;
					   	var index = layui.layer.open({
							title : "修改制贩毒风险人员信息",
							type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
							content : locat+'/getDuPersonelUpdate.do?personnelid='+personnelid+'&buttons='+'${param.buttons }'+'&menuid='+${param.menuid}+'&page=zhidu_update',
							//area: ['800px', '750px'],
							area: [document.body.scrollWidth-50, document.body.scrollHeight-50],
							maxmin: true,
							success : function(layero, index){
								setTimeout(function(){
									layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
										tips: 3
									});
								},500)
							},
							cancel:function(){
								layui.table.reload('followTable2', { }); 
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
						layer.confirm('确定删除此信息？', function(index){
					      layer.close(index);
					      $.getJSON(locat+"/cancelDuPersonel.do?id="+id+'&personnelid='+personnelid+'&menuid='+${param.menuid},{},function(data) {
							 var str = eval('(' + data + ')');
					      	 if (str.flag ==1) {		                          
							     top.layer.msg("数据删除成功！"); 	
							     table.reload('followTable2', {});                 
					       	 }else{
								 top.layer.msg("删除失败!");
					      	 }			      	    		
					      });      
						});
					}else{
						top.layer.alert("请先选择删除哪条数据！");
					}
					break;
				 case 'import':
					   var index = layui.layer.open({
							 title : "导入制贩毒风险人员信息",
							 type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
							 content : "<c:url value="/jsp/personel/du/import.jsp?personneltype=2"/>",
							 area: ['600', '650'],
							 maxmin: true,
							 end: function () {
								$("#search2").click(); 
							}
						 });	
					    break;
				 case 'export':
				   	var index = layui.layer.open({
						title : "涉毒人员信息导出",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content : '<c:url value="/jsp/personel/du/export.jsp?personneltype=2&menuid='+${param.menuid}+'"/>',
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
	         }
		});
		


	table.on('tool(ChemistryTable)',function(obj){
		var id = obj.data.id;
		if(obj.event == 'showinfo'){
			var index = layui.layer.open({
				title:		'懂化学技术人员详情',
				type:		2,
				content:locat+'/getChemistryById.do?id='+id+"&page=showinfo&menuid="+${param.menuid},
				area:		['800','700px'],
				maxmin:		true,
				success:function(layero,index){
					setTimeout(function(){
						layui.layer.tips('点击此处返回列表','layui-layer-setwin .layui-layer-close',{
							tips:	3
						});
					},500);
				}
			});
			layui.layer.full(index);
		}
	});
	
	$("#searchChemistry").click(function (){
		table.reload('ChemistryTable',{
			where:{
				personname: $("#Chpersonname").val(),
				sexes: $("#Chsexes option:selected").val(),
				cardnumber: $("#Chcardnumber").val(),
				companyname: $("#companyname").val(),
				telephone: $("#Chtelephone").val()
			},
			page:{
				//重新从第一页开始
				curr:1
			}
		});
	});
    $("#reset3").click(function () {
		   $('form')[2].reset();
	});	
    table.on('toolbar(ChemistryTable)',function(obj){
		var checkStatus = table.checkStatus(obj.config.id);
		
		switch(obj.event){
			case 'add':
				var index = layui.layer.open({
					title:	"添加懂化学技术人员",
					type:	2,
					content:locat+"/jsp/personel/du/chemistry/chemistry_add.jsp?companyid=0&menuid="+${param.menuid},
					area:	['800','700px'],
					maxmin:	true,
					success:function(layero,index){
						setTimeout(function(){
							layui.layer.tips('点击此处返回列表','.layui-layer-setwin .layui-layer-close',{
								tips: 3
							});
						},500);
					}
				});
				layui.layer.full(index);
			break;
			case 'update':
				var data = JSON.stringify(checkStatus.data);
				var datas = JSON.parse(data);
				if(datas!=""){
					var id = datas[0].id;
					var index = layui.layer.open({
						title:	"修改懂化学技术人员",
						type:	2,
						content:locat+"/getChemistryById.do?id="+id+"&page=du&menuid="+${param.menuid},
						area:	['800','700px'],
						maxmin:	true,
						success:function(layero,index){
							setTimeout(function(){
								layui.layer.tips('点击此处返回列表','.layui-layer-setwin .layui-layer-close',{
									tips: 3
								});
							},500);
						}
					});
					layui.layer.full(index);
				}else{
					top.layer.alert("请先选择要修改的数据");
				}
			break;
			case 'cancel':
				var data = JSON.stringify(checkStatus.data);
				var datas = JSON.parse(data);
				if(datas!=""){
					var id = datas[0].id;
					layer.confirm("确定删除此信息吗?",function(index){
						layer.close(index);
						$.getJSON(locat+"/cancelChemistry.do?id="+id+'&menuid='+${param.menuid},{},function(data){
							var str = eval('('+data+')');
							if(str.flag ==1){
								top.layer.msg("数据删除成功");
								table.reload('ChemistryTable',{});
							}else{
								top.layer.msg("数据删除失败");
							}
						});
					});
				}else{
					top.layer.alert("请先选择要删除的数据");
				}
			break;
				 case 'import':
					   var index = layui.layer.open({
							 title : "导入懂化学技术人员信息",
							 type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
							 content : "<c:url value="/jsp/personel/du/import.jsp?personneltype=4"/>",
							 area: ['600', '650'],
							 maxmin: true,
							 end: function () {
								$("#searchChemistry").click(); 
							}
						 });	
					    break;
				case 'export':
					    document.getElementById("Chemistryform").submit();
					    break;
		}
	});	
  });
  
   function showinfoPersonel_Xi(personnelid){
        var index = layui.layer.open({
			title : "社会吸毒人员详情",
			type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
			content : locat+'/getDuPersonelUpdate.do?personnelid='+personnelid+'&menuid='+${param.menuid}+'&page=xidu_showinfo',
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
      function showinfoPersonel_Zhi(personnelid){
      	var index = layui.layer.open({
					title : "制贩毒风险人员详情",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content : locat+'/getDuPersonelUpdate.do?personnelid='+personnelid+'&menuid='+${param.menuid}+'&page=zhidu_showinfo',
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
      function showinfoPersonel_Dong(id){
         var index = layui.layer.open({
				title:		'懂化学技术人员详情',
				type:		2,
				content:locat+'/getChemistryById.do?id='+id+"&page=showinfo&menuid="+${param.menuid},
				area:		['800','700px'],
				maxmin:		true,
				success:function(layero,index){
					setTimeout(function(){
						layui.layer.tips('点击此处返回列表','layui-layer-setwin .layui-layer-close',{
							tips:	3
						});
					},500);
				}
			});
				layui.layer.full(index);
      }
      
	function openZhiDu(){
			        //制贩毒风险人员-方法级渲染
				  layui.table.render({
				    elem: '#followTable2',
				    toolbar: true,
				    defaultToolbar: ['filter', 'exports', 'print'],
				    url: '<c:url value="/searchDuPersonnel.do"/>?personneltype=2',
				    method:'post',
				    toolbar: '#toolbarButton',
				    cols: [[
				        {field:'id',type:'radio',fixed:'true',align:"center"},
				        {field:'personname', title: '姓名', width:100,templet: function (item) {
					   		return "<span style='font-weight:500;cursor:pointer;' onclick='showinfoPersonel_Zhi("+item.personnelid+");'><font color='blue'>"+item.personname+"</font></span>";
			            }},
			    	   {field:'cardnumber', title: '身份证号码', width:200,templet: function (item) {
					   		return "<span style='font-weight:500;cursor:pointer;' onclick='showinfoPersonel_Zhi("+item.personnelid+");'><font color='blue'>"+item.cardnumber+"</font></span>";
			             }} ,
				        {field:'sexes', title: '性别', width:60,align:"center"} ,
				         {field:'officeName', title: '年龄', width:60,templet: function (item) {
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
				        {field:'ptype', title: '人员类别', width:150,align:"center"} ,
				        {field:'homeplace', title: '现居住地详址', width:120} ,
				        {field:'jointcontrollevel', title: '管控类别', width:90,align:"center"}, 
				        {field:'incontrollevel', title: '在控级别', width:90,align:"center"},
				        {field:'narcoticstype', title: '涉毒种类', align:"center"},
				        {field:'lasttime', title: '末次处罚时间', width:120,align:"center"},
				         {field:'unitname1', title: '管辖责任单位', width:150} ,
				        {field:'policename1', title: '管辖责任民警', width:100},
	                    {field:'addtime', title: '建档时间', width:180,align:"center"}
			    ]],
			    page: true,
			    limit: 10
			    });
     }
     
      function    openChemistry(){
		        layui.table.render({
				elem:'#ChemistryTable',
				toolbar:true,
				defaultToolbar:['filter','exports','print'],
				url:'<c:url value="searchChemistry1.do"/>',
				method:'post',
			    toolbar: '#toolbarButton',
				cols:	[[
				     {field:'id',type:'radio',fixed:'true',align:"center"},
				     {field:'companyname',title:'所属企业',width:200,align:"center",
				     	templet: function(d){
				     		if(d.companyname == null){
				     			return '企业已删除';
				     		}else{
				     			return d.companyname;
				     		}
				     	}
				     },
				     {field:'personname', title: '姓名', width:100,templet: function (item) {
				   		return "<span style='font-weight:500;cursor:pointer;' onclick='showinfoPersonel_Dong("+item.id+");'><font color='blue'>"+item.personname+"</font></span>";
		              }},
		    	      {field:'cardnumber', title: '身份证号码', width:200,templet: function (item) {
				   		return "<span style='font-weight:500;cursor:pointer;' onclick='showinfoPersonel_Dong("+item.id+");'><font color='blue'>"+item.cardnumber+"</font></span>";
		              }} ,
				     {field:'sexes',title:'性别',width:70,align:"center"},
				     {field:'education',title:'文化程度',width:100,align:"center"},
				     {field:'politicalposition',title:'政治面貌',width:120,align:"center"},
				     {field:'telephone',title:'联系电话',width:150,align:"center"},
				     {field:'station',title:'岗位',width:100,align:"center"},
				     {field:'lifeplace',title:'现住地详址',align:"center"},
				     {field:'addoperator',title:'添加人',width:100,align:"center"},
				     {field:'addtime',title:'添加时间',width:180,align:"center"}
				]],
				page:true,
				limit:10
			});
	  }
	  
	  
	  
		</script>	
  </body>
</html>
