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
    
    <title>详情页面</title>
	<link rel="stylesheet" href="<c:url value="/css/system.css"/>" type="text/css"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<link rel="stylesheet" href="<c:url value="/layui/css/layui1.css"/>"  media="all" />
  	<link rel="stylesheet" href="<c:url value="/css/public.css"/>"  media="all" />
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
   </style>
  
   <body class="childrenBody layui-fluid">
	
		<div class="layui-form layui-row" style="border-bottom: 1px solid #eee;">
			<div class="layui-col-md6" style="border-right: 1px solid #eee;padding-right: 15px;padding-bottom: 15px;">
				<form method="post" id="form1">
					<div class="layui-inline layui-col-md12">
						<label class="layui-form-label layui-font-blue">基本信息：</label>
					</div>
					<div class="layui-col-md6">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label"><font color="red" size=2>*</font>事件类别</label>
							<div class="layui-input-block">
								<input type="text" name="cdttype" value='${contradictionInfo.cdttype }' autocomplete="off" class="layui-input" placeholder="请输入事件类别" readonly="readonly"/>
							</div>
						</div>
					</div>
					<div class="layui-col-md6">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">主要活动方式</label>
							<div class="layui-input-block">
								<input type="text" name="cdtresult" value='${contradictionInfo.cdtresult }' autocomplete="off" class="layui-input" placeholder="请输入主要活动方式" readonly="readonly"/>
							</div>
						</div>
					</div>
					<div class="layui-col-md12">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label"><font color="red" size=2>*</font>事件名称</label>
							<div class="layui-input-block">
								<input type="text" name="cdtname" value='${contradictionInfo.cdtname }' autocomplete="off" class="layui-input" placeholder="请输入事件名称" readonly="readonly"/>
							</div>
						</div>
					</div>
					<div class="layui-col-md6">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">涉及人数</label>
							<div class="layui-input-block">
								<input type="text" name="ssrs" value='${contradictionInfo.ssrs }' autocomplete="off" class="layui-input" readonly="readonly"/>
							</div>
						</div>
					</div>
					<div class="layui-col-md6">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">发生时间</label>
							<div class="layui-input-block">
								<input type="text" class="layui-input" value="${contradictionInfo.memo }" readonly="readonly">
							</div>
						</div>
					</div>
					<div class="layui-col-md12">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label"><font color="red" size=2>*</font>责任单位</label>
							<div class="layui-input-block">
								<input type="text" name="sfdz" value='${contradictionInfo.sponsorname }'  autocomplete="off" class="layui-input" maxlength="50" placeholder="请输入责任单位" readonly="readonly"/>
							</div>
						</div>
					</div>
					<div class="layui-col-md6">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label"><font color="red" size=2>*</font>责任民警</label>
							<div class="layui-input-block">
								<input type="text" id="iswjxxy" autocomplete="off" class="layui-input" placeholder="请输入责任民警" readonly="readonly"/>
							</div>
						</div>
					</div>
					<div class="layui-col-md6">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">联系电话(长号)</label>
							<div class="layui-input-block">
								<input type="text" class="layui-input" value="${contradictionInfo.xxyxx }" readonly="readonly">
							</div>
						</div>
					</div>
					<div class="layui-col-md12">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">发生地点</label>
							<div class="layui-input-block">
								<input type="text" name="sfdz" value='${contradictionInfo.sfdz }'  autocomplete="off" class="layui-input" maxlength="50" placeholder="请输入发生地点" readonly="readonly"/>
							</div>
						</div>
					</div>
					<div class="layui-col-md6">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">处置时间</label>
							<div class="layui-input-block">
								<input type="text" class="layui-input" value="${contradictionInfo.examinetime }" readonly="readonly">
							</div>
						</div>
					</div>
					<div class="layui-col-md6">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">处置状态</label>
							<div class="layui-input-block">
								<input type="text" name="examineopinion" value='${contradictionInfo.examineopinion }' autocomplete="off" class="layui-input" readonly="readonly"/>
							</div>
						</div>
					</div>
					<div class="layui-col-md12">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">情况经过</label>
							<div class="layui-input-block">
								<textarea placeholder="请输入情况经过" class="layui-textarea" name="cdtcontent" readonly="readonly">${contradictionInfo.cdtcontent }</textarea>
							</div>
						</div>
					</div>
				</form>
			</div>
			<!-- 右边表单 -->
			<div class="layui-col-md6" style="border-left: 1px solid #EEEEEE;">
				<div class="layui-tab"  lay-filter="detailTabs">
					<ul class="layui-tab-title btn-list">
						<li class="btn btn_15 layui-this" id="recordbutton">民警工作记载</li>
						<li class="btn btn_3" id="sjrybutton">涉及人员</li>
						<li class="btn btn_6" id="sjzzbutton">涉及组织</li>
						<li class="btn btn_1" id="wlqzbutton">涉及网络群组</li>
						<li class="btn btn_2" id="sjcsbutton">涉及场所</li>
						<li class="btn btn_7" id="sjwpbutton">涉及物品</li>
					</ul>
					<div class="layui-tab-content " style="padding: 15px;">
						<div class="right-child-content layui-tab-item layui-show"><!--民警工作记载 -->
				           <table class="layui-hide" id="recordtable" lay-filter="recordtable"></table>
					    </div>
						<div class="right-child-content layui-tab-item">
							<table class="layui-hide" id="sjry" lay-filter="sjry"></table>
						</div>
						<div class="right-child-content layui-tab-item">
							<table class="layui-hide" id="sjzz" lay-filter="sjzz"></table>
						</div>
						<div class="right-child-content layui-tab-item">
							<table class="layui-hide" id="wlqz" lay-filter="wlqz"></table>
						</div>
						<div class="right-child-content layui-tab-item">
							<table class="layui-hide" id="sjcs" lay-filter="sjcs"></table>
						</div>
						<div class="right-child-content layui-tab-item">
							<table class="layui-hide" id="sjwp" lay-filter="sjwp"></table>
						</div>
					</div>
				</div>
			</div>
		</div>
		<script>
			function getUsers(){
				$.ajax({
					type:		'POST',
					url:		'<c:url value="/getUsersByDepartmentid.do?departmentid="/>${contradictionInfo.sponsor}',
					dataType:	'json',
					async:      false,
					success:	function(data){
						$.each(data.list, function(i, item) {
							$.each(item, function(i) {
								if(this.value=="${contradictionInfo.iswjxxy}")$("#iswjxxy").val(this.text);
							});
						});
					}
				});
			}
			layui.use(['table','form','element'], function() {
				var form = layui.form,
				element = layui.element,
				table = layui.table;
				getUsers();
				//初始化民警工作记载
				table.render({
				    elem: '#recordtable',
				    toolbar: false,
				    defaultToolbar: ['filter', 'exports', 'print'],
				    url :   '<c:url value="/searchWorkRecord.do"/>?recordtype=event&recordid=${contradictionInfo.id}',
				    method:'post',
				    toolbar: '#toolbarDemo',
				    cols: [[
				        {field:'id',type:'radio',fixed:'true',align:"center"},
				        {field:'worktime', title: '时间', width:150,align:"center",templet: function (item) {
						   		return "<span style='font-weight:500;cursor:pointer;' onclick='showinfoWorkRecord("+item.id+");'><font color='blue'>"+item.worktime+"</font></span>";
				           }},
				        {field:'worktype', title: '工作方式', width:120,align:"center"},
				        {field:'workplace', title: '地点',width:120,align:"center"}, 
	                    {field:'workrecord', title: '工作记录',align:"center"},
	                    {field:'addoperator', title: '记录民警',align:"center"}
				    ]],
				    page: true,
				    limit: 10
			    }); 
				//初始化涉及人员
				table.render({
					elem: '#sjry',
				    toolbar: false,
				    //url: '<c:url value="searchKeypersonnel_ZbEvent.do"/>',
				    where: {cdtid:${contradictionInfo.id}},
				    defaultToolbar: [],
				    method:'post',
				    cols: [[
				    	{field:'cardnumber', title: '身份证号码', width:200,templet: function (item) {
							return "<span style='font-weight:200;cursor:pointer;' onclick='showinfoPersonnelExtend("+item.personnelid+");'><font color='blue'>"+item.cardnumber+"</font></span>";
						}} ,
				    	{field:'personname', title: '姓名', width:150,align:"center"},
				    	{field:'homeplace', title: '现住地', width:200,align:"center"},
				    	{field:'telnumber', title: '手机号码', width:150,align:"center"},
				    	{field:'deal', title: '处理措施',align:"center"}
				    ]],
				    page: true,
				    limit: 10
				});
				
				//初始化涉及组织
				table.render({
					elem: '#sjzz',
				    toolbar: false,
				    defaultToolbar: [],
				    method:'post',
				    cols: [[
				    	{field:'name', title: '组织名称', width:250,align:"center"},
				    	{field:'memo', title: '备注',align:"center"}
				    ]],
				    page: true,
				    limit: 10
				});
				
				//初始化涉及网络群组
				table.render({
					elem: '#wlqz',
				    toolbar: false,
				    defaultToolbar: [],
				    method:'post',
				    cols: [[
				    	{field:'type', title: '群组类型', width:200,align:"center"},
				    	{field:'name', title: '群组名称', width:200,align:"center"},
				    	{field:'memo', title: '群组ID',align:"center"}
				    ]],
				    page: true,
				    limit: 10
				});
				
				//初始化涉及场所
				table.render({
					elem: '#sjcs',
				    toolbar: false,
				    defaultToolbar: [],
				    method:'post',
				    cols: [[
				    	{field:'name', title: '场所名称', width:200,align:"center"},
				    	{field:'memo', title: '场所地址', width:200,align:"center"},
				    	{field:'result', title: '处理结果',align:"center"}
				    ]],
				    page: true,
				    limit: 10
				});
				
				//初始化涉及物品
				table.render({
					elem: '#sjwp',
				    toolbar: false,
				    defaultToolbar: [],
				    method:'post',
				    cols: [[
				    	{field:'type', title: '物品类型', width:200,align:"center"},
				    	{field:'name', title: '物品名称', width:200,align:"center"},
				    	{field:'result', title: '处理结果',align:"center"}
				    ]],
				    page: true,
				    limit: 10
				});
				
				element.on('tab(detailTabs)', function(data){
					switch(data.index){
						case 0:
							table.reload('recordtable', {
								url: '<c:url value="/searchWorkRecord.do"/>?recordtype=event&recordid=${contradictionInfo.id}',
								page: {
									curr: 1
									// 重新从第 1 页开始
								}
							});
							break;
						case 1:
							table.reload('sjry', {
								url: '<c:url value="searchKeypersonnel_ZbEvent.do"/>',
								page: {
									curr: 1
									// 重新从第 1 页开始
								}
							});
						break;
						case 2:
							table.reload('sjzz', {
								url: '<c:url value="searchZbEventInfo.do"/>',
								where: {cdtid:${contradictionInfo.id},datatype:1},
								page: {
									curr: 1
									// 重新从第 1 页开始
								}
							});
						break;
						case 3:
							table.reload('wlqz', {
								url: '<c:url value="searchZbEventInfo.do"/>',
								where: {cdtid:${contradictionInfo.id},datatype:2},
								page: {
									curr: 1
									// 重新从第 1 页开始
								}
							});
						break;
						case 4:
							table.reload('sjcs', {
								url: '<c:url value="searchZbEventInfo.do"/>',
								where: {cdtid:${contradictionInfo.id},datatype:3},
								page: {
									curr: 1
									// 重新从第 1 页开始
								}
							});
						break;
						case 5:
							table.reload('sjwp', {
								url: '<c:url value="searchZbEventInfo.do"/>',
								where: {cdtid:${contradictionInfo.id},datatype:4},
								page: {
									curr: 1
									// 重新从第 1 页开始
								}
							});
						break;
					}
				});
			});
			 
			 function showinfoPersonnelExtend(personnelid){
			 	var index = layui.layer.open({
					title : "风险人员详情",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content : '<c:url value="/getPersonnelExtendUpdate.do"/>?personnelid='+personnelid+'&memo=风险人员&menuid='+${param.menuid}+'&page=showinfoWhole',
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
			 function showinfoWorkRecord(id){
			 	var index = layui.layer.open({
					title : "民警工作记载详情",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content : '<c:url value="/getWorkRecordUpdate.do"/>'+'?id='+id+'&menuid='+${param.menuid}+'&page=showinfo',
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
			 }
		</script>
	</body>
</html>
