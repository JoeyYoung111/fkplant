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
    
    <title>修改页面</title>
    
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/cardnumber.js"/>"></script>
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
					<input type="hidden"  name="menuid" value="${menuid}">
					<input type="hidden"  name="id" value="${contradictionInfo.id}" />
					<div class="layui-inline layui-col-md12">
						<label class="layui-form-label layui-font-blue">基本信息：</label>
					</div>
					<div class="layui-col-md6">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label"><font color="red" size=2>*</font>事件类别</label>
							<div class="layui-input-block">
<%--								<input type="text" name="cdttype" value='${contradictionInfo.cdttype }' autocomplete="off" class="layui-input" placeholder="请输入事件类别"/>--%>
								<select id="cdttype" name="cdttype" autocomplete="off" lay-verify="required" lay-verType="tips" lay-reqtext="请选择事件类别">
									<option value="" selected> --- 请选择事件类别 --- </option>
								</select>
							</div>
						</div>
					</div>
					<div class="layui-col-md6">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label"><font color="red" size=2>*</font>事件级别</label>
							<div class="layui-input-block">
								<select id="cdtlevel" name="cdtlevel" autocomplete="off" lay-verify="required" lay-verType="tips" lay-reqtext="请选择事件级别">
									<option value="" selected> --- 请选择事件级别 --- </option>
								</select>
							</div>
						</div>
					</div>
					<div class="layui-col-md12">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label"><font color="red" size=2>*</font>事件名称</label>
							<div class="layui-input-block">
								<input type="text" name="cdtname" value='${contradictionInfo.cdtname }' lay-verify="required" lay-reqtext="请输入事件名称" autocomplete="off" class="layui-input" placeholder="请输入事件名称"/>
							</div>
						</div>
					</div>
					<div class="layui-col-md6">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">主要活动方式</label>
							<div class="layui-input-block">
<%--								<input type="text" name="cdtresult" value='${contradictionInfo.cdtresult }' autocomplete="off" class="layui-input" placeholder="请输入主要活动方式"/>--%>
								<select name="cdtresult" autocomplete="off">
									<option value="" selected> --- 请选择主要活动方式 --- </option>
									<option value="网上活动" <c:if test="${contradictionInfo.cdtresult eq '网上活动'}">selected</c:if>>网上活动</option>
									<option value="落地活动" <c:if test="${contradictionInfo.cdtresult eq '落地活动'}">selected</c:if>>落地活动</option>
									<option value="网上+落地活动" <c:if test="${contradictionInfo.cdtresult eq '网上+落地活动'}">selected</c:if>>网上+落地活动</option>
								</select>
							</div>
						</div>
					</div>
					<div class="layui-col-md6">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">涉及人数</label>
							<div class="layui-input-block">
								<input type="text" name="ssrs" value='${contradictionInfo.ssrs }' autocomplete="off" class="layui-input" placeholder="请输入涉及人数"/>
							</div>
						</div>
					</div>
					<div class="layui-col-md12">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label"><font color="red" size=2>*</font>责任单位</label>
					    	<div class="layui-input-block">
					      		<input type="text" id="sponsor" name="sponsor" value="0" lay-filter="sponsor" class="layui-input" autocomplete="off">
					    	</div>
						</div>
					</div>
					<div class="layui-col-md6">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label"><font color="red" size=2>*</font>责任民警</label>
					    	<div class="layui-input-inline" lay-verify="iswjxxy">
					    		<select id="iswjxxy" name="iswjxxy" lay-filter="iswjxxy">
					    		</select>
					    	</div>
						</div>
					</div>
					<div class="layui-col-md6">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">联系电话(长号)</label>
					    	<div class="layui-input-inline">
					      		<input type="text" id="xxyxx" name="xxyxx" value="${contradictionInfo.xxyxx }" autocomplete="off" class="layui-input">
					    	</div>
						</div>
					</div>
					<div class="layui-col-md12">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">发生地点</label>
							<div class="layui-input-block">
								<input type="text" name="sfdz" value='${contradictionInfo.sfdz }'  autocomplete="off" class="layui-input" maxlength="50" placeholder="请输入发生地点"/>
							</div>
						</div>
					</div>
					<div class="layui-col-md12">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">发生时间</label>
							<div class="layui-input-block">
								<input type="text" class="layui-input" id="memo" name="memo">
							</div>
						</div>
					</div>
					<div class="layui-col-md6">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">处置时间</label>
							<div class="layui-input-block">
								<input type="text" class="layui-input" id="examinetime" name="examinetime">
							</div>
						</div>
					</div>
					<div class="layui-col-md6">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">处置状态</label>
							<div class="layui-input-block">
<%--								<input type="text" name="examineopinion" value='${contradictionInfo.examineopinion }' autocomplete="off" class="layui-input" placeholder="请输入处置状态"/>--%>
								<select name="examineopinion" autocomplete="off">
									<option value="" selected> --- 请选择 --- </option>
									<option value="事前化解" <c:if test="${contradictionInfo.examineopinion eq '事前化解'}">selected</c:if>>事前化解</option>
									<option value="事中阻止" <c:if test="${contradictionInfo.examineopinion eq '事中阻止'}">selected</c:if>>事中阻止</option>
									<option value="事后查处" <c:if test="${contradictionInfo.examineopinion eq '事后查处'}">selected</c:if>>事后查处</option>
									<option value="掌控动态" <c:if test="${contradictionInfo.examineopinion eq '掌控动态'}">selected</c:if>>掌控动态</option>
								</select>
							</div>
						</div>
					</div>
					<div class="layui-col-md12">
						<div class="layui-form-item my-form-item">
							<label class="layui-form-label">情况经过</label>
							<div class="layui-input-block">
								<textarea placeholder="请输入情况经过" class="layui-textarea" name="cdtcontent">${contradictionInfo.cdtcontent }</textarea>
							</div>
						</div>
					</div>
					<div class="layui-col-md12">
						<div class="layui-form-item my-form-item">
						    <div class="layui-input-block">
						      <button type="submit" class="layui-btn" lay-submit="" lay-filter="msgSub">立即提交</button>
<%--						      <button type="reset" class="layui-btn layui-btn-primary">重置</button>--%>
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
							<button class="layui-btn" id="addConnect"><i class="layui-icon">&#xe64c;</i>新增人员</button>
							<button class="layui-btn" id="cancelConnect"><i class="layui-icon">&#xe64d;</i>删除人员</button>
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
		<script type="text/html" id="toolbarDemo">
			<div class="layui-btn-container">
				<button class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more" lay-event="add">&#xe624; 新增</button>
				<button class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more" lay-event="update">&#xe642;修改</button>
                <c:if test='${fn:contains(buttons,"删除")}'>
				      <button class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more" lay-event="canel">&#xe640;删除</button>
                </c:if>
			</div>
		</script>
		<script>
			var users={};
			function getUsers(departmentid){
				$.ajax({
					type:		'POST',
					url:		'<c:url value="/getUsersByDepartmentid.do?departmentid="/>'+departmentid,
					dataType:	'json',
					async:      false,
					success:	function(data){
						var options = fillOption(data);
						users={};
						$.each(data.list, function(i, item) {
							$.each(item, function(i) {
								users[this.value]=this.memo;
							});
						});
						$("#iswjxxy").html(options);
						layui.form.render();
						$("#iswjxxy").next().find("dd:first").click();
						$("#iswjxxy").next().find("dd[lay-value=${contradictionInfo.iswjxxy}]").click();
					}
				});
			}
			function getcdtlevel(){
				$.ajax({
					type:		'POST',
					url:		'<c:url value="/getBMByTypeToJSON.do?basicType="/>'+96,
					dataType:	'json',
					async:      false,
					success:	function(data){
						var options="";
						$.each(data.list, function(i, item) {
							$.each(item, function(i) {
								options += '<option value="' + this.text + '">' + this.text + '</option>';
							});
						});
						$("#cdtlevel").append(options);
						$("#cdtlevel option[value=${contradictionInfo.cdtlevel}]").select();
					}
				});
			}
			function getcdttype(){
				$.ajax({
					type:		'POST',
					url:		'<c:url value="/getBMByTypeToJSON.do?basicType="/>'+103,
					dataType:	'json',
					async:      false,
					success:	function(data){
						var options ="";
						$.each(data.list, function(i, item) {
							$.each(item, function(i) {
								options += '<option value="' + this.text + '">' + this.text + '</option>';
							});
						});
						$("#cdttype").append(options);
						$("#cdttype option[value=${contradictionInfo.cdttype}]").select();
					}
				});
			}
			layui.config({
			    base: "<c:url value="/layui/lay/modules/"/>"
			}).extend({
			    treeSelect: "treeSelect"
			});
			layui.use(['table','form','element','laydate','treeSelect'], function() {
				var form = layui.form,
				element = layui.element,
				table = layui.table,
				treeSelect = layui.treeSelect,
				laydate = layui.laydate;
				
				laydate.render({
				  elem: '#memo', //指定元素
				  value: '${contradictionInfo.memo }'
				});
				
				laydate.render({
				  elem: '#examinetime', //指定元素
				  value: '${contradictionInfo.examinetime }'
				});
				
				treeSelect.render({
			        // 选择器
			        elem: '#sponsor',
			        // 数据
			        //data: '<c:url value="/getDepartmentTree.do"/>',
			        data: '<c:url value="/getDepartmentTreeBytype.do"/>?departtype=4',
			        // 异步加载方式：get/post，默认get
			        type: 'get',
			        // 占位符
			        placeholder: '管辖责任单位',
			        // 是否开启搜索功能：true/false，默认false
			        search: false,
			        // 一些可定制的样式
			        style: {
			            folder: {
			                enable: false
			            },
			            line: {
			                enable: true
			            }
			        },
			        // 点击回调
			        click: function(d){
			        	getUsers($('#sponsor').val());
			        	form.render();
			        },
			        // 加载完成后的回调函数
			        success: function (d) {
			        	treeSelect.checkNode('sponsor', "${contradictionInfo.sponsor}");
			        	treeSelect.refresh('sponsor');
			        	getUsers("${contradictionInfo.sponsor}");
			        	form.render();
			        }
			    });
				form.verify({
				  	iswjxxy: function(value,item){
			    		if(!$("#iswjxxy").val()||$("#iswjxxy").val()==""){
			    			$("#iswjxxy").next().find("input").focus();
				  			return "请选择责任民警";
			    		}
			    	},
				  	sponsor: function(value,item){
			    		if(!$("#sponsor").val()||$("#sponsor").val()=="0"){
				  			return "请选择责任单位";
			    		}
			    	}
				  });
				form.on('select(iswjxxy)', function(data){
				  	$('#xxyxx').val(users[data.value]);
				  	form.render();
				});
				
				getcdtlevel();
				getcdttype();
				form.render();
				form.on('submit(msgSub)', function(data){
		         	$("#form1").ajaxSubmit({
		              	url:		'<c:url value="/updateContradictionInfo.do"/>',
		              	dataType:	'json',
		              	async:  false,
		              	success:	function(data) {
		                  	var obj = eval('(' + data + ')');
		                  	if(obj.flag>0){
		                  	    //弹出loading
		 		            	var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
		                     	setTimeout(function(){         
		                     		top.layer.msg(obj.msg);
		                     		top.layer.close(index);
					        		layer.closeAll("iframe");
			 		        		//刷新父页面
			 		         		parent.location.reload();
		                   		},2000);
		                 	}else{
		                  	 	layer.msg(obj.msg);
		                	}
		             	},
		              	error:function() {
		                  	layer.alert("请求失败！");
		              	}
		          	});
		           	return false;
				 });
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
				    	{field:'id',type:'radio',fixed:'left'},
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
				    defaultToolbar: ['filter', 'exports', 'print'],
				    method:'post',
				    toolbar: '#toolbarDemo',
				    cols: [[
				    	{field:'id',type:'radio',fixed:'left'},
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
				    defaultToolbar: ['filter', 'exports', 'print'],
				    method:'post',
				    toolbar: '#toolbarDemo',
				    cols: [[
				    	{field:'id',type:'radio',fixed:'left'},
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
				    defaultToolbar: ['filter', 'exports', 'print'],
				    method:'post',
				    toolbar: '#toolbarDemo',
				    cols: [[
				    	{field:'id',type:'radio',fixed:'left'},
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
				    defaultToolbar: ['filter', 'exports', 'print'],
				    method:'post',
				    toolbar: '#toolbarDemo',
				    cols: [[
				    	{field:'id',type:'radio',fixed:'left'},
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
				
				$("#cancelConnect").click(function () {
					var checkStatus =table.checkStatus('sjry');
					var data=JSON.stringify(checkStatus.data);
	   				var datas=JSON.parse(data);
	   				if(datas!=""){
					   var id=datas[0].id;
					    top.layer.confirm('确定删除此信息？', function(index){
					        layer.close(index);
					        $.getJSON('<c:url value="cancelKeypersonnel.do"/>?id='+id+'&menuid='+${menuid },{
								},function(data) {
									var obj = eval('(' + data + ')');
			                  		if(obj.flag>0){
			                  			top.layer.msg("数据删除成功！");
			                  			//刷新
				 		        		$("#sjrybutton").click();
			                  		}else{
			                  			layer.msg("删除失败!");
			                  		}
					        	});      
							});
					}else{
						layer.alert("请先选择删除哪条数据！");
					}
				});
				
				//民警工作记载
				ListenTool("民警工作记载","recordtable","record","&recordtype=event&recordid=${contradictionInfo.id}","getWorkRecordUpdate.do","cancelWorkRecord.do","recordbutton");
				//涉及组织
				ListenTool("涉及组织","sjzz","sjzz","","getZbEventInfo.do","cancelZbEventInfo.do","sjzzbutton");
				//涉及网络群组
				ListenTool("涉及网络群组","wlqz","wlqz","","getZbEventInfo.do","cancelZbEventInfo.do","wlqzbutton");
				//涉及场所
				ListenTool("涉及场所","sjcs","sjcs","","getZbEventInfo.do","cancelZbEventInfo.do","sjcsbutton");
				//涉及物品
				ListenTool("涉及物品","sjwp","sjwp","","getZbEventInfo.do","cancelZbEventInfo.do","sjwpbutton");
				
				//监听行工具事件
				function ListenTool(title,toolname,addfolder,exparam,updateurl,cancelurl,buttonid){
					var content = '<c:url value="/jsp/event/zbEvent/'+addfolder+'/add.jsp"/>?menuid=${menuid }&cdtid=${contradictionInfo.id}'+exparam;
					table.on('toolbar('+toolname+')', function(obj){
					   var  checkStatus =table.checkStatus(obj.config.id);
					   switch(obj.event){
					   case 'add':
					   var index = layui.layer.open({
									title : "添加"+title,
									type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
									content : [content,'yes'],
									area: ['800', '800px'],
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
					   		if(addfolder=="record"||<%=userSession.getLoginUserID() %>==datas[0].addoperatorid){
					   			var pagetext="";
					   			if(addfolder=="record")pagetext="update";
					   			else pagetext=addfolder;
					   			var id=datas[0].id;
							    var index = layui.layer.open({
											title : "修改"+title,
											type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
											content : '<c:url value="'+updateurl+'"/>?id='+id+'&menuid='+${param.menuid }+exparam+"&page="+pagetext,
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
					   			top.layer.alert("只有添加人才可以修改数据！");
					   		}
						}else{
							top.layer.alert("请先选择修改哪条数据！");
						}
					    break;
					    
					case 'canel':
					   var data=JSON.stringify(checkStatus.data);
					   var datas=JSON.parse(data);
					    if(datas!=""){
					    	if(<%=userSession.getLoginUserID() %>==datas[0].addoperatorid){
					    		var id=datas[0].id;
							    top.layer.confirm('确定删除此信息？', function(index){
							        layer.close(index);
							        $.getJSON('<c:url value="'+cancelurl+'"/>?id='+id+'&menuid='+${param.menuid },{
										},function(data) {
										var str = eval('(' + data + ')');
							        	 if (str.flag ==1) {		                          
									     	top.layer.msg("数据删除成功！"); 	
									     	//刷新
									     	$("#"+buttonid).click();
									     }else{
											top.layer.msg("删除失败!");
									      }			      	    		
							        	});      
									});
					    	}else{
					   			top.layer.alert("只有添加人才可以删除数据！");
					   		}
						}else{
							top.layer.alert("请先选择删除哪条数据！");
						}
					    break;
					   };
					   
					 });
				}
			});
			
			$("#addConnect").click(function () {
				var index = layui.layer.open({
					title : "新增涉及人员",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content : '<c:url value="/jsp/event/zbEvent/addPerson.jsp"/>?menuid=${menuid }&cdtid=${contradictionInfo.id}',
					area: ['800', '800px'],
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
