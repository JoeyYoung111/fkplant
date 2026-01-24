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
    
    <title>添加政保事件页面</title>
    
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  </head>
  
  <body>
  	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  		<legend id="typeName">添加政保事件信息</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
		<input type="hidden"  name="menuid" value=${param.menuid }>
		<div class="layui-form-item">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>事件名称</label>
	    	<div class="layui-input-inline" style="width:52.5%;">
				<input type="text" name="cdtname" lay-verify="required" lay-reqtext="请输入事件名称" autocomplete="off" class="layui-input" placeholder="请输入事件名称"/>
	    	</div>
	  	</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>事件级别</label>
	    	<div class="layui-input-inline" style="width:20%;">
				<select id="cdtlevel" name="cdtlevel" autocomplete="off" lay-verify="required" lay-verType="tips" lay-reqtext="请选择事件级别">
					<option value="" selected> --- 请选择事件级别 --- </option>
				</select>
	    	</div>
	    	<label class="layui-form-label" style="width:10%;"><font color="red" size=2>*</font>事件类别</label>
	    	<div class="layui-input-inline" style="width:20%;">
<%--				<input type="text" name="cdttype"  autocomplete="off" class="layui-input" placeholder="请输入事件类别"/>--%>
				<select id="cdttype" name="cdttype" autocomplete="off" lay-verify="required" lay-verType="tips" lay-reqtext="请选择事件类别">
					<option value="" selected> --- 请选择事件类别 --- </option>
				</select>
	    	</div>
	  	</div>
	  	<div class="layui-form-item">
	    	<label class="layui-form-label">主要活动方式</label>
	    	<div class="layui-input-inline" style="width:20%;">
<%--        		<input type="text" name="cdtresult"  autocomplete="off" class="layui-input" placeholder="请输入主要活动方式"/>--%>
        		<select name="cdtresult" autocomplete="off">
					<option value="" selected> --- 请选择主要活动方式 --- </option>
					<option value="网上活动">网上活动</option>
					<option value="落地活动">落地活动</option>
					<option value="网上+落地活动">网上+落地活动</option>
				</select>
      		</div>
	    	<label class="layui-form-label" style="width:10%;">涉及人数</label>
	    	<div class="layui-input-inline" style="width:20%;">
				<select id="ssrs"  name="ssrs" style="width:170px;">
			 		<option value="">--请选择涉及人数--</option>
			 	</select>
			</div>
	  	</div>
	  	<div class="layui-form-item">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>责任单位</label>
	    	<div class="layui-input-inline"  style="width:660px;">
	      		<input type="text" id="sponsor" name="sponsor" value="0" lay-filter="sponsor" class="layui-input" autocomplete="off">
	    	</div>
	  	</div>
	  	<div class="layui-form-item">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>责任民警</label>
	    	<div class="layui-input-inline" lay-verify="iswjxxy">
	    		<select id="iswjxxy" name="iswjxxy" lay-filter="iswjxxy">
	    		</select>
	    	</div>
	    	<label class="layui-form-label">联系电话(长号)</label>
	    	<div class="layui-input-inline">
	      		<input type="text" id="xxyxx" name="xxyxx" autocomplete="off" class="layui-input">
	    	</div>
	  	</div>
		<div  class="layui-form-item">
			<label class="layui-form-label"><font color="red" size=2>*</font>发生地点</label>
			<div class=layui-input-inline style="width:52.5%;">
				<input type="text" name="sfdz"  autocomplete="off" class="layui-input" maxlength="50" placeholder="请输入发生地点"  lay-verify="required" lay-reqtext="请输入发生地点"/>
			</div>
		</div>
		<div  class="layui-form-item">
			<label class="layui-form-label">发生时间</label>
			<div class=layui-input-inline style="width:52.5%;">
				<input type="text" class="layui-input" id="memo" name="memo">
			</div>
		</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label">处置时间</label>
	    	<div class="layui-input-inline" style="width:20%;">
	    		<input type="text" class="layui-input" id="examinetime" name="examinetime">
	    	</div>
	    	<label class="layui-form-label" style="width:10%;">处置状态</label>
	    	<div class="layui-input-inline" style="width:20%;">
<%--				<input type="text" name="examineopinion"  autocomplete="off" class="layui-input" placeholder="请输入处置状态"/>--%>
				<select name="examineopinion" autocomplete="off">
					<option value="" selected> --- 请选择 --- </option>
					<option value="事前化解">事前化解</option>
					<option value="事中阻止">事中阻止</option>
					<option value="事后查处">事后查处</option>
					<option value="掌控动态">掌控动态</option>
				</select>
	    	</div>
	  	</div>
	  	<div class="layui-form-item layui-form-text">
		    <label class="layui-form-label">情况经过</label>
		    <div class="layui-input-block">
		      <textarea placeholder="请输入情况经过" class="layui-textarea" name="cdtcontent"></textarea>
		    </div>
		</div>
		<div class="layui-form-item">
		    <div class="layui-input-block">
		      <button type="submit" class="layui-btn" lay-submit="" lay-filter="msgSub">立即提交</button>
		      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
		    </div>
	  	</div>
	</form>
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
					$("#iswjxxy").html(options);
					layui.form.render();
					$("#iswjxxy").next().find("dd:first").click();
					$("#iswjxxy option[value=<%=userSession.getLoginUserID()%>]").select();;
				}
			});
		}
		layui.config({
		    base: "<c:url value="/layui/lay/modules/"/>"
		}).extend({
		    zTreeSelectM: "zTreeSelectM/zTreeSelectM",
		    treeSelect: "treeSelect",
			selectInput:"selectInput/selectInput"
		});
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
				}
			});
		}
		layui.use(['form', 'laydate','treeSelect'], function(){
			var form = layui.form,
			layer = layui.layer,
			treeSelect = layui.treeSelect,
			laydate = layui.laydate;
			
			laydate.render({
			  elem: '#memo' //指定元素
			});
			
			laydate.render({
			  elem: '#examinetime' //指定元素
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
		        	treeSelect.checkNode('sponsor', "<%=userSession.getLoginUserDepartmentid()%>");
		        	treeSelect.refresh('sponsor');
		        	getUsers($('#sponsor').val());
		        	form.render();
		        }
		    });
			form.verify({
			  	sponsor: function(value,item){
		    		if(!$("#sponsor").val()||$("#sponsor").val()=="0"){
			  			return "请选择责任单位";
		    		}
		    	},
			  	iswjxxy: function(value,item){
		    		if(!$("#iswjxxy").val()||$("#iswjxxy").val()==""){
		    			$("#iswjxxy").next().find("input").focus();
			  			return "请选择责任民警";
		    		}
		    	}
			  });
			form.on('select(iswjxxy)', function(data){
			  	$('#xxyxx').val(users[data.value]);
			  	form.render();
			});
			//初始化涉事人数
			$.ajax({
				type:		'POST',
				url:		'<c:url value="/getbasicMsgJSON.do"/>?basicType=43',
				dataType:	'json',
				success:	function(data){
           			$.each(data, function(num, item) {
           				$('#ssrs').append('<option value="' + item.name + '">' + item.name + '</option>');
          			});
      				form.render("select");
				}
			});
			
			getcdtlevel();
			getcdttype();
			form.render();
			
		  form.on('submit(msgSub)', function(data){
	         $("#form1").ajaxSubmit({
	              	url:		'<c:url value="/addZbEvent.do"/>',
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
		 		         		parent.$("#search").click();
		 		         		parent.layer.closeAll("iframe");
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
	</script>
  </body>
</html>
