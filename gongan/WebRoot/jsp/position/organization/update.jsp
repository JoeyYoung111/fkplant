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
					<input type="hidden"  name="id" value="${organization.id}" />
					<div class="layui-inline layui-col-md12">
						<label class="layui-form-label layui-font-blue">基本信息：</label>
					</div>
					
					<div class="layui-form-item">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>名称</label>
	    	<div class="layui-input-inline" style="width:660px;">
	      		<input type="text" name="orgName" lay-verify="required" autocomplete="off" placeholder="请输入名称" class="layui-input"  lay-reqtext="名称不能为空" value="${organization.orgName }">
	    	</div>
	  	</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label">组织类别</label>
	    	<div class="layui-input-inline">
	    		<select id="orgType" name="orgType" autocomplete="off">
					<option value=""> --- 请选择 --- </option>
				</select>
	    	</div>
	    	<label class="layui-form-label">组织类别</label>
	    	<div class="layui-input-inline">
	    		<select id="orgClass" name="orgClass" autocomplete="off">
					<option value=""> --- 请选择 --- </option>
				</select>
	    	</div>
	  	</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label">省内组织</label>
	    	<div class="layui-input-inline">
	    		<select name="inProvince" autocomplete="off">
					<option value="是"<c:if test="${organization.inProvince eq '是'}"> selected</c:if>>是</option>
					<option value="否"<c:if test="${organization.inProvince eq '否'}"> selected</c:if>>否</option>
				</select>
	    	</div>
	    	<label class="layui-form-label">登记注册</label>
	    	<div class="layui-input-inline">
	    		<select name="isRegister" autocomplete="off">
					<option value="是"<c:if test="${organization.isRegister eq '是'}"> selected</c:if>>是</option>
					<option value="否"<c:if test="${organization.isRegister eq '否'}"> selected</c:if>>否</option>
				</select>
	    	</div>
	  	</div>
	  	<div class="layui-form-item">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>管控单位</label>
	    	<div class="layui-input-inline"  style="width:500px;">
	      		<input type="text" id="controlUnit" name="controlUnit" value="${organization.controlUnit }" lay-filter="controlUnit" class="layui-input" autocomplete="off">
	    	</div>
	  	</div>
	  	<div class="layui-form-item">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>管控民警</label>
	    	<div class="layui-input-inline" lay-verify="controlPolice">
	    		<select id="controlPolice" name="controlPolice" lay-filter="controlPolice">
	    		</select>
	    	</div>
	    	<label class="layui-form-label">联系电话(长号)</label>
	    	<div class="layui-input-inline">
	      		<input type="text" id="controlPhone" name="controlPhone" value="${organization.controlPhone }" autocomplete="off" class="layui-input">
	    	</div>
	  	</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label">管控时间</label>
	    	<div class="layui-input-inline">
	      		<input type="text" name="controlTime" id="controlTime" value="${organization.controlTime }" autocomplete="off" class="layui-input">
	    	</div>
	    	<label class="layui-form-label">外文名称</label>
	    	<div class="layui-input-inline">
	      		<input type="text" name="orgForeignName" value="${organization.orgForeignName }" autocomplete="off" class="layui-input">
	    	</div>
	  	</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label">成立日期</label>
	    	<div class="layui-input-inline">
	      		<input type="text" name="createTime" id="createTime" value="${organization.createTime }" readonly lay-verify="required" lay-reqtext="请选择成立日期" autocomplete="off" class="layui-input">
	    	</div>
	    	<label class="layui-form-label">成立地点</label>
	    	<div class="layui-input-inline">
	      		<input type="text" name="createAddress" value="${organization.createAddress }" autocomplete="off" class="layui-input">
	    	</div>
	  	</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label">详细地址</label>
	    	<div class="layui-input-inline">
	      		<input type="text" name="address" value="${organization.address }" autocomplete="off" class="layui-input" style="width:500px;">
	    	</div>
	  	</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label">活跃程度</label>
	    	<div class="layui-input-inline">
	    		<select name="activeLevel" autocomplete="off">
					<option value="非常活跃"<c:if test="${organization.activeLevel eq '非常活跃'}"> selected</c:if>>非常活跃</option>
					<option value="活动较少"<c:if test="${organization.activeLevel eq '活动较少'}"> selected</c:if>>活动较少</option>
					<option value="停止活动"<c:if test="${organization.activeLevel eq '停止活动'}"> selected</c:if>>停止活动</option>
				</select>
	    	</div>
	    	<label class="layui-form-label">活动范围</label>
	    	<div class="layui-input-inline">
	    		<select name="activeRange" autocomplete="off">
					<option value="省内"<c:if test="${organization.activeRange eq '省内'}"> selected</c:if>>省内</option>
					<option value="跨省"<c:if test="${organization.activeRange eq '跨省'}"> selected</c:if>>跨省</option>
					<option value="境外"<c:if test="${organization.activeRange eq '境外'}"> selected</c:if>>境外</option>
					<option value="跨境"<c:if test="${organization.activeRange eq '跨境'}"> selected</c:if>>跨境</option>
				</select>
	    	</div>
	  	</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label">是否与境外存在勾连</label>
	    	<div class="layui-input-inline">
	    		<select name="isForeignConnections" autocomplete="off">
					<option value="有"<c:if test="${organization.isForeignConnections eq '有'}"> selected</c:if>>有</option>
					<option value="无"<c:if test="${organization.isForeignConnections eq '无'}"> selected</c:if>>无</option>
					<option value="暂未发现"<c:if test="${organization.isForeignConnections eq '暂未发现'}"> selected</c:if>>暂未发现</option>
				</select>
	    	</div>
	    	<label class="layui-form-label">活动方式</label>
	    	<div class="layui-input-inline">
	    		<select name="activeWay" autocomplete="off">
					<option value="线下活动"<c:if test="${organization.activeWay eq '线下活动'}"> selected</c:if>>线下活动</option>
					<option value="网上活动"<c:if test="${organization.activeWay eq '网上活动'}"> selected</c:if>>网上活动</option>
					<option value="网上+线下活动"<c:if test="${organization.activeWay eq '网上+线下活动'}"> selected</c:if>>网上+线下活动</option>
				</select>
	    	</div>
	  	</div>
	  	<div class="layui-form-item">
	    	<label class="layui-form-label">活动方式简要描述</label>
	    	<div class="layui-input-inline">
	      		<input type="text" name="activeWayDetails" value="${organization.activeWayDetails }" autocomplete="off" class="layui-input" style="width:500px;">
	    	</div>
	  	</div>
		<div class="layui-form-item layui-form-text">
		    <label class="layui-form-label">组织概况</label>
		    <div class="layui-input-inline">
		      <textarea placeholder="请输入内容" class="layui-textarea" name="orgGeneral" style="width:500px;">${organization.orgGeneral }</textarea>
		    </div>
		</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label">政治主张及利益诉求</label>
	    	<div class="layui-input-inline">
	      		<input type="text" name="proposition" value="${organization.proposition }" autocomplete="off" class="layui-input" style="width:500px;">
	    	</div>
	  	</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label">财务状况</label>
	    	<div class="layui-input-inline">
	      		<input type="text" name="finance" value="${organization.finance }" autocomplete="off" class="layui-input" style="width:500px;">
	    	</div>
	  	</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label">接受资助请情况</label>
	    	<div class="layui-input-inline">
	      		<input type="text" name="subsidize" value="${organization.subsidize }" autocomplete="off" class="layui-input" style="width:500px;">
	    	</div>
	  	</div>
					
		<div class="layui-col-md12">
			<div class="layui-form-item my-form-item">
			    <div class="layui-input-block">
			      <button type="submit" class="layui-btn" lay-submit="" lay-filter="msgSub">立即提交</button>
			      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
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
					</div>
				</div>
			</div>
		</div>
		<script type="text/html" id="toolbarDemo">
		<div class="layui-btn-container">
			<button class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more" lay-event="add">&#xe624; 新增</button>
			<button class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more" lay-event="update">&#xe642;修改</button>
			<button class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more" lay-event="cancel">&#xe640;删除</button>
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
					$("#controlPolice").html(options);
					layui.form.render();
					$("#controlPolice").next().find("dd:first").click();
					$("#controlPolice").next().find("dd[lay-value=${organization.controlPolice}]").click();
				}
			});
		}
		function getorgType(){
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
					$("#orgType").append(options);
					$("#orgType option[value=${organization.orgType}]").select();
				}
			});
		}
		function getorgClass(){
			$.ajax({
				type:		'POST',
				url:		'<c:url value="/getBMByTypeToJSON.do?basicType="/>'+104,
				dataType:	'json',
				async:      false,
				success:	function(data){
					var options="";
					$.each(data.list, function(i, item) {
						$.each(item, function(i) {
							options += '<option value="' + this.text + '">' + this.text + '</option>';
						});
					});
					$("#orgClass").append(options);
					$("#orgClass option[value=${organization.orgClass}]").select();
				}
			});
		}
		$(document).ready(function(){
			getorgType();
			getorgClass();
       	});
		layui.config({
		    base: "<c:url value="/layui/lay/modules/"/>"
		}).extend({
		    treeSelect: "treeSelect"
		});
		
		layui.use(['form','treeSelect'], function(){
			var form = layui.form,
			layer = layui.layer,
		  	treeSelect = layui.treeSelect;
		  	
		  	treeSelect.render({
		        // 选择器
		        elem: '#controlUnit',
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
		        	getUsers($('#controlUnit').val());
		        	form.render();
		        },
		        // 加载完成后的回调函数
		        success: function (d) {
		        	treeSelect.checkNode('controlUnit', "${organization.controlUnit}");
		        	treeSelect.refresh('controlUnit');
		        	getUsers("${organization.controlUnit}");
		        	form.render();
		        }
		    });
		});
		
		layui.use(['form', 'laydate','table','element'], function(){
           var form = layui.form,
           layer = layui.layer,
           laydate = layui.laydate,
           element = layui.element,
           table = layui.table;
           laydate.render({
			   	elem:'#createTime'
			   	,format:  'yyyy-MM-dd'
			  });
			  laydate.render({
			   	elem:'#controlTime'
			   	,format:  'yyyy-MM-dd'
			  });
			  
			  table.render({
			    elem: '#recordtable',
			    toolbar: false,
			    defaultToolbar: ['filter', 'exports', 'print'],
			    url :   '<c:url value="/searchWorkRecord.do"/>?recordtype=organization&recordid=${organization.id}',
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
			    url: '<c:url value="searchOrganizationPerson.do"/>',
			    where: {orgid:${organization.id}},
			    defaultToolbar: [],
			    method:'post',
			    cols: [[
			    	{field:'id',type:'radio',fixed:'left'},
			    	{field:'cardnumber', title: '身份证号码', width:200} ,
			    	{field:'personName', title: '姓名', width:150,align:"center"},
			    	{field:'homeplace', title: '现住地', width:200,align:"center"},
			    	{field:'telnumber', title: '手机号码', width:150,align:"center"}
			    ]],
			    page: true,
			    limit: 10
			});
			
			element.on('tab(detailTabs)',function(data){
				switch(data.index){
					case 0:
						table.reload('recordtable', {
							url: '<c:url value="/searchWorkRecord.do"/>?recordtype=organization&recordid=${organization.id}',
							page: {
								curr: 1
								// 重新从第 1 页开始
							}
						});
					break;
					case 1:
					table.reload('sjry', {
						url: '<c:url value="searchOrganizationPerson.do"/>',
						page: {
							curr: 1
							// 重新从第 1 页开始
						}
					});
					break;
				}
			});
		   
		   //民警工作记载
			ListenTool("民警工作记载","recordtable","record","&recordtype=organization&recordid=${organization.id}","getWorkRecordUpdate.do","cancelWorkRecord.do","recordbutton");
		   
		   //监听行工具事件
			function ListenTool(title,toolname,addfolder,exparam,updateurl,cancelurl,buttonid){
				var content = '<c:url value="/jsp/position/'+addfolder+'/add.jsp"/>?menuid=${menuid }&positionid=${position.id}'+exparam;
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
			   			var id=datas[0].id;
					    var index = layui.layer.open({
									title : "修改"+title,
									type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
									content : '<c:url value="'+updateurl+'"/>?id='+id+'&menuid='+${param.menuid }+exparam+"&page=update",
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
						top.layer.alert("请先选择修改哪条数据！");
					}
				    break;
				    
				case 'cancel':
				   var data=JSON.stringify(checkStatus.data);
				   var datas=JSON.parse(data);
				    if(datas!=""){
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
						top.layer.alert("请先选择删除哪条数据！");
					}
				    break;
				   };
				 });
			}
		   
		   form.verify({
			  	controlPolice: function(value,item){
		    		if(!$("#controlPolice").val()||$("#controlPolice").val()==""){
		    			$("#controlPolice").next().find("input").focus();
			  			return "请选择管控民警";
		    		}
		    	},
			  	controlUnit: function(value,item){
		    		if(!$("#controlUnit").val()||$("#controlUnit").val()=="0"){
			  			return "请选择管控单位";
		    		}
		    	}
			  });
			form.on('select(controlPolice)', function(data){
			  	$('#controlPhone').val(users[data.value]);
			  	form.render();
			});
			
		  form.render();
		  
		  $("#cancelConnect").click(function () {
			var checkStatus =table.checkStatus('sjry');
			var data=JSON.stringify(checkStatus.data);
  			var datas=JSON.parse(data);
  			if(datas!=""){
			var id=datas[0].id;
		    top.layer.confirm('确定删除此信息？', function(index){
		        layer.close(index);
		        $.getJSON('<c:url value="cancelOrganizationPerson.do"/>?id='+id+'&menuid='+${menuid },{
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
		  
		  form.on('submit(msgSub)', function(data){
         	$("#form1").ajaxSubmit({
              	url:		'<c:url value="/updateOrganization.do"/>',
              	dataType:	'json',
              	async:  	false,
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
		 
		});
		
		$("#addConnect").click(function () {
			var index = layui.layer.open({
				title : "新增组织人员",
				type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
				content : '<c:url value="/jsp/position/organization/addPerson.jsp"/>?menuid=${menuid }&orgid=${organization.id}',
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
