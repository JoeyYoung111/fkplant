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
     <link rel="stylesheet" href="<c:url value="/layui/css/layui1.css"/>"  media="all" />
    <link rel="stylesheet" href="<c:url value="/css/public.css"/>"  media="all" />
	 <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  
  
  <body>
	<div class="layui-form layui-row" style="border-bottom: 1px solid #eee;">
		<div class="layui-col-md6" style="border-right: 1px solid #eee;padding-right: 15px;padding-bottom: 15px;">
			<form class="layui-form" method="post" id="form1">
				<input type="hidden"  name="id" id="id"  value=${position.id}></input>
				<input type="hidden"  name="menuid" id="menuid"  value=${menuid}></input>
				<div class="layui-inline layui-col-md12">
					<label class="layui-form-label layui-font-blue">基本信息：</label>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label"><font color="red" size=2>*</font>名称</label>
					<div class="layui-input-inline">
						<input type="text" name="positionname" value="${position.positionname}" lay-verify="required" autocomplete="off" placeholder="请输入名称" class="layui-input"  lay-reqtext="名称不能为空">
					</div>
					<label class="layui-form-label">外文名称</label>
					<div class="layui-input-inline">
						<input type="text" name="foreignname" value="${position.foreignname}" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label"><font color="red" size=2>*</font>阵地级别</label>
					<div class="layui-input-inline">
						<select id="positiontype" name="positiontype" autocomplete="off">
							<option value=""> --- 请选择 --- </option>
						</select>
					</div>
			    	<label class="layui-form-label"><font color="red" size=2>*</font>阵地类别</label>
			    	<div class="layui-input-inline">
			    		<select id="positioncharacter" name="positioncharacter" autocomplete="off">
							<option value=""> --- 请选择 --- </option>
						</select>
			    	</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label"><font color="red" size=2>*</font>管控单位</label>
					<div class="layui-input-inline" style="width:660px;">
						<input type="text" id="jdunit" name="jdunit" value="0" lay-filter="jdunit" class="layui-input" autocomplete="off">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label"><font color="red" size=2>*</font>管控民警</label>
					<div class="layui-input-inline" lay-verify="jdpolice">
						<select id="jdpolice" name="jdpolice" lay-filter="jdpolice">
						</select>
					</div>
					<label class="layui-form-label">联系电话(长号)</label>
					<div class="layui-input-inline">
						<input type="text" id="jdphone" name="jdphone" value="${position.jdphone}" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">成立时间</label>
					<div class="layui-input-inline">
						<input type="text" name="setuptime" value="${position.setuptime}" id="setuptime" readonly lay-verify="required" lay-reqtext="请选择成立时间" autocomplete="off" placeholder="年-月-日" class="layui-input">
					</div>
					<label class="layui-form-label">成立地点</label>
					<div class="layui-input-inline">
						<input type="text" name="setupplace" value="${position.setupplace}" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">详细地址</label>
					<div class="layui-input-inline">
						<input type="text" name="address" value="${position.address}" autocomplete="off" class="layui-input" style="width:660px;">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">占地面积</label>
					<div class="layui-input-inline">
						<input type="text" name="placearea" value="${position.placearea}" autocomplete="off" class="layui-input">
					</div>
					<label class="layui-form-label">涉及人数</label>
					<div class="layui-input-inline">
						<input type="text" name="personnum" value="${position.personnum}" autocomplete="off" class="layui-input">
					</div>
				</div>
				
				<div class="layui-form-item">
					<label class="layui-form-label">主管政府部门或单位</label>
					<div class="layui-input-inline">
						<input type="text" name="chargeunit" value="${position.chargeunit}" autocomplete="off" class="layui-input" style="width:660px;">
					</div>
				</div>
				<div class="layui-form-item layui-form-text">
					<label class="layui-form-label">阵地概况</label>
					<div class="layui-input-inline">
					  <textarea placeholder="请输入内容" class="layui-textarea" name="positionsurvey" style="width:660px;">${position.positionsurvey}</textarea>
					</div>
				</div>
				<div class="layui-form-item">
					<div class="layui-input-block">
					  <button type="submit" class="layui-btn" lay-submit="" lay-filter="roleSub">立即提交</button>
					</div>
				</div>
			</form>
		</div>
		<!-- 右边表单 -->
		<div class="layui-col-md6" style="border-left: 1px solid #EEEEEE;">
			<div class="layui-tab"  lay-filter="detailTabs">
				<ul class="layui-tab-title btn-list">
					<li class="btn btn_15 layui-this" id="recordbutton">民警工作记载</li>
					<li class="btn btn_11" id="cardbutton">阵地证书</li>
					<li class="btn btn_3" id="personnelbutton">人员情况</li>
					<li class="btn btn_6" id="eventbutton">主要活动情况</li>
					<li class="btn btn_7" id="workbutton">工作记录</li>
				</ul>
				<div class="layui-tab-content " style="padding: 15px;">
					<div class="right-child-content layui-tab-item layui-show"><!--民警工作记载 -->
			           <table class="layui-hide" id="recordtable" lay-filter="recordtable"></table>
				    </div>
					<div class="right-child-content layui-tab-item">
						<table class="layui-hide" id="cardtable" lay-filter="cardtable"></table>
					</div>
					<div class="right-child-content layui-tab-item">
						<table class="layui-hide" id="personneltable" lay-filter="personneltable"></table>
					</div>
					<div class="right-child-content layui-tab-item">
						<table class="layui-hide" id="eventtable" lay-filter="eventtable"></table>
					</div>
					<div class="right-child-content layui-tab-item">
						<table class="layui-hide" id="worktable" lay-filter="worktable"></table>
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
	<script type="text/html" id="toolbarPersonnel">
		<div class="layui-btn-container">
			<button class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more" lay-event="add">&#xe624; 新增人员</button>
			<button class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more" lay-event="cancel">&#xe640; 删除人员</button>
		</div>
	</script>
	<script type="text/javascript">
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
					$("#jdpolice").html(options);
					layui.form.render();
					$("#jdpolice").next().find("dd:first").click();
					$("#jdpolice").next().find("dd[lay-value=${position.jdpolice}]").click();
				}
			});
		}
		function getpositiontype(){
			$.ajax({
				type:		'POST',
				url:		'<c:url value="/getBMByTypeToJSON.do?basicType="/>'+96,
				dataType:	'json',
				async:      false,
				success:	function(data){
					var options = "";
					$.each(data.list, function(i, item) {
						$.each(item, function(i) {
							options += '<option value="' + this.text + '">' + this.text + '</option>';
						});
					});
					$("#positiontype").append(options);
					$("#positiontype option[value=${position.positiontype}]").select();
				}
			});
		}
		function getpositioncharacter(){
			$.ajax({
				type:		'POST',
				url:		'<c:url value="/getBMByTypeToJSON.do?basicType="/>'+99,
				dataType:	'json',
				async:      false,
				success:	function(data){
					var options ="";
					$.each(data.list, function(i, item) {
						$.each(item, function(i) {
							options += '<option value="' + this.text + '">' + this.text + '</option>';
						});
					});
					$("#positioncharacter").append(options);
					$("#positioncharacter option[value=${position.positioncharacter}]").select();
				}
			});
		}
		$(document).ready(function(){
       	});
       	layui.config({
		    base: "<c:url value="/layui/lay/modules/"/>"
		}).extend({
		    treeSelect: "treeSelect"
		});
		
		layui.use(['table','form','treeSelect','laydate','element'], function(){
			var form = layui.form,
			layer = layui.layer,
			table = layui.table,
			element = layui.element,
			laydate = layui.laydate,
		  	treeSelect = layui.treeSelect;
		  	laydate.render({
			   	elem:'#setuptime'
			   	,format:  'yyyy-MM-dd'
			  });
		  	treeSelect.render({
		        // 选择器
		        elem: '#jdunit',
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
		        	getUsers($('#jdunit').val());
		        	form.render();
		        },
		        // 加载完成后的回调函数
		        success: function (d) {
		        	treeSelect.checkNode('jdunit', "${position.jdunit}");
		        	treeSelect.refresh('jdunit');
		        	getUsers("${position.jdunit}");
		        	form.render();
		        }
		    });
		    table.render({
			    elem: '#recordtable',
			    toolbar: false,
			    defaultToolbar: ['filter', 'exports', 'print'],
			    url :   '<c:url value="/searchWorkRecord.do"/>?recordtype=position&recordid=${position.id}',
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
		    table.render({
			    elem: '#cardtable',
			    toolbar: false,
			    //url: '<c:url value="/searchPositionCard.do"/>?positionid=${position.id}',
				defaultToolbar: ['filter', 'exports', 'print'],
			    method:'post',
			    toolbar: '#toolbarDemo',
			    cols: [[
			    	{field:'id',type:'radio',fixed:'left'},//sort: true 排序
			    	{field:'cardname', title: '登记证书名称', width:200,align:"center"},
			    	{field:'cardno', title: '编号', width:150,align:"center"} ,
			        {field:'validdate', title: '有效期', width:150,align:"center"} , 
			    	{field:'cardunit', title: '发证单位', width:200,align:"center"},
			    ]],
			    page: true,
			    limit: 10
			  });
		    
		    table.render({
			    elem: '#personneltable',
			    toolbar: false,
				defaultToolbar: ['filter', 'exports', 'print'],
			    method:'post',
			    toolbar: '#toolbarPersonnel',
			    cols: [[
			    	{field:'id',type:'radio',fixed:'left'},//sort: true 排序
			    	{field:'identity', title: '身份', width:150,align:"center"},
			    	{field:'personname', title: '姓名', width:200,align:"center"},
			    	{field:'cardnumber', title: '证件号码', width:200,align:"center"} ,
			        {field:'homeplace', title: '现住地', width:300,align:"center"} , 
			    	{field:'telnumber', title: '手机号码', width:200,align:"center"},
			    ]],
			    page: true,
			    limit: 10
			  });
		    table.render({
			    elem: '#eventtable',
			    toolbar: false,
				defaultToolbar: ['filter', 'exports', 'print'],
			    method:'post',
			    toolbar: '#toolbarDemo',
			    cols: [[
			    	{field:'id',type:'radio',fixed:'left'},//sort: true 排序
			    	{field:'eventTime', title: '活动时间', width:200,align:"center"},
			        {field:'eventInfo', title: '活动简况', width:400,align:"center"} , 
			    ]],
			    page: true,
			    limit: 10
			  });
		    table.render({
			    elem: '#worktable',
			    toolbar: false,
				defaultToolbar: ['filter', 'exports', 'print'],
			    method:'post',
			    toolbar: '#toolbarDemo',
			    cols: [[
			    	{field:'id',type:'radio',fixed:'left'},//sort: true 排序
			    	{field:'workTime', title: '时间', width:200,align:"center"},
			        {field:'workInfo', title: '活动简况', width:400,align:"center"} , 
			    ]],
			    page: true,
			    limit: 10
			  });
		    
		    element.on('tab(detailTabs)', function(data){
				switch(data.index){
					case 0:
						table.reload('recordtable', {
							url: '<c:url value="/searchWorkRecord.do"/>?recordtype=position&recordid=${position.id}',
							page: {
								curr: 1
								// 重新从第 1 页开始
							}
						});
					break;
					case 1:
						table.reload('cardtable', {
							url: '<c:url value="/searchPositionCard.do"/>?positionid=${position.id}',
							page: {
								curr: 1
								// 重新从第 1 页开始
							}
						});
					break;
					case 2:
						table.reload('personneltable', {
							url: '<c:url value="/searchPositionPersonnel.do"/>?positionid=${position.id}',
							page: {
								curr: 1
								// 重新从第 1 页开始
							}
						});
					break;
					case 3:
						table.reload('eventtable', {
							url: '<c:url value="/searchPositionEvent.do"/>?positionid=${position.id}',
							page: {
								curr: 1
								// 重新从第 1 页开始
							}
						});
					break;
					case 4:
						table.reload('worktable', {
							url: '<c:url value="/searchPositionWorkRecord.do"/>?positionid=${position.id}',
							page: {
								curr: 1
								// 重新从第 1 页开始
							}
						});
					break;
				}
			});
			
			//民警工作记载
			ListenTool("民警工作记载","recordtable","record","&recordtype=position&recordid=${position.id}","getWorkRecordUpdate.do","cancelWorkRecord.do","recordbutton");
			//阵地证书
			ListenTool("阵地证书","cardtable","card","","getPositionCardUpdate.do","cancelPositionCard.do","cardbutton");
			//人员情况
			ListenTool("人员情况","personneltable","personnel","","getPositionPersonnelUpdate.do","cancelPositionPersonnel.do","personnelbutton");
			//主要活动情况
			ListenTool("主要活动情况","eventtable","event","","getPositionEventUpdate.do","cancelPositionEvent.do","eventbutton");
			//工作记录
			ListenTool("工作记录","worktable","work","","getPositionWorkRecordUpdate.do","cancelPositionWorkRecord.do","workbutton");
			
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
		});
		
		layui.use(['form', 'laydate'], function(){
		         var form = layui.form,
		         layer = layui.layer,
		         laydate = layui.laydate;
		   
		   
		   
		   form.verify({
			  	jdpolice: function(value,item){
		    		if(!$("#jdpolice").val()||$("#jdpolice").val()==""){
		    			$("#jdpolice").next().find("input").focus();
			  			return "请选择管控民警";
		    		}
		    	},
			  	jdunit: function(value,item){
		    		if(!$("#jdunit").val()||$("#jdunit").val()=="0"){
			  			return "请选择管控单位";
		    		}
		    	}
			  });
			form.on('select(jdpolice)', function(data){
				  	$('#jdphone').val(users[data.value]);
				  	form.render();
				});
		  getpositiontype();
		  getpositioncharacter();
		  form.render();
		   form.on('submit(roleSub)', function(data){
		   
             $("#form1").ajaxSubmit({
	              	url:		'<c:url value="/updatePosition.do"/>',
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
	                  	 	top.layer.msg(obj.msg);
	                	}
	             	},
	              	error:function() {
	                  	top.layer.alert("请求失败！");
	              	}
	          	});
	           	return false;
			 });
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
