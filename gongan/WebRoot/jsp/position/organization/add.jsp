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
     <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
	 <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  
  
  <body>
   <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  		<legend>添加政保组织信息</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
		<input type="hidden"  name="menuid" id="menuid"  value=${param.menuid}></input>
		<div class="layui-form-item">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>名称</label>
	    	<div class="layui-input-inline" style="width:660px;">
	      		<input type="text" name="orgName" lay-verify="required" autocomplete="off" placeholder="请输入名称" class="layui-input"  lay-reqtext="名称不能为空">
	    	</div>
	  	</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label">组织级别</label>
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
	    	<label class="layui-form-label">是否省内组织</label>
	    	<div class="layui-input-inline">
	    		<select name="inProvince" autocomplete="off">
					<option value="是" selected>是</option>
					<option value="否">否</option>
				</select>
	    	</div>
	    	<label class="layui-form-label">是否登记注册</label>
	    	<div class="layui-input-inline">
	    		<select name="isRegister" autocomplete="off">
					<option value="是" selected>是</option>
					<option value="否">否</option>
				</select>
	    	</div>
	  	</div>
	  	<div class="layui-form-item">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>管控单位</label>
	    	<div class="layui-input-inline"  style="width:660px;">
	      		<input type="text" id="controlUnit" name="controlUnit" value="0" lay-filter="controlUnit" class="layui-input" autocomplete="off">
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
	      		<input type="text" id="controlPhone" name="controlPhone" autocomplete="off" class="layui-input">
	    	</div>
	  	</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label">管控时间</label>
	    	<div class="layui-input-inline">
	      		<input type="text" name="controlTime" autocomplete="off" class="layui-input">
	    	</div>
	    	<label class="layui-form-label">外文名称</label>
	    	<div class="layui-input-inline">
	      		<input type="text" name="orgForeignName" autocomplete="off" class="layui-input">
	    	</div>
	  	</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label">成立日期</label>
	    	<div class="layui-input-inline">
	      		<input type="text" name="createTime" id="createTime" readonly lay-verify="required" lay-reqtext="请选择成立日期" autocomplete="off" placeholder="年-月-日" class="layui-input">
	    	</div>
	    	<label class="layui-form-label">成立地点</label>
	    	<div class="layui-input-inline">
	      		<input type="text" name="createAddress" autocomplete="off" class="layui-input">
	    	</div>
	  	</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label">详细地址</label>
	    	<div class="layui-input-inline">
	      		<input type="text" name="address" autocomplete="off" class="layui-input" style="width:660px;">
	    	</div>
	  	</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label">活跃程度</label>
	    	<div class="layui-input-inline">
	    		<select name="activeLevel" autocomplete="off">
					<option value="" selected> --- 请选择 --- </option>
					<option value="非常活跃">非常活跃</option>
					<option value="活动较少">活动较少</option>
					<option value="停止活动">停止活动</option>
				</select>
	    	</div>
	    	<label class="layui-form-label">活动范围</label>
	    	<div class="layui-input-inline">
	    		<select name="activeRange" autocomplete="off">
					<option value="" selected> --- 请选择 --- </option>
					<option value="省内">省内</option>
					<option value="跨省">跨省</option>
					<option value="境外">境外</option>
					<option value="跨境">跨境</option>
				</select>
	    	</div>
	  	</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label">是否与境外存在勾连</label>
	    	<div class="layui-input-inline">
	    		<select name="isForeignConnections" autocomplete="off">
					<option value="" selected> --- 请选择 --- </option>
					<option value="有">有</option>
					<option value="无">无</option>
					<option value="暂未发现">暂未发现</option>
				</select>
	    	</div>
	    	<label class="layui-form-label">活动方式</label>
	    	<div class="layui-input-inline">
	    		<select name="activeWay" autocomplete="off">
					<option value="" selected> --- 请选择 --- </option>
					<option value="线下活动">线下活动</option>
					<option value="网上活动">网上活动</option>
					<option value="网上+线下活动">网上+线下活动</option>
				</select>
	    	</div>
	  	</div>
	  	<div class="layui-form-item">
	    	<label class="layui-form-label">活动方式简要描述</label>
	    	<div class="layui-input-inline">
	      		<input type="text" name="activeWayDetails" autocomplete="off" class="layui-input" style="width:660px;">
	    	</div>
	  	</div>
		<div class="layui-form-item layui-form-text">
		    <label class="layui-form-label">组织概况</label>
		    <div class="layui-input-inline">
		      <textarea placeholder="请输入内容" class="layui-textarea" name="orgGeneral" style="width:660px;"></textarea>
		    </div>
		</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label">政治主张及利益诉求</label>
	    	<div class="layui-input-inline">
	      		<input type="text" name="proposition" autocomplete="off" class="layui-input" style="width:660px;">
	    	</div>
	  	</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label">财务状况</label>
	    	<div class="layui-input-inline">
	      		<input type="text" name="finance" autocomplete="off" class="layui-input" style="width:660px;">
	    	</div>
	  	</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label">接受资助请情况</label>
	    	<div class="layui-input-inline">
	      		<input type="text" name="subsidize" autocomplete="off" class="layui-input" style="width:660px;">
	    	</div>
	  	</div>
		<div class="layui-form-item">
		    <div class="layui-input-block">
		      <button type="submit" class="layui-btn" lay-submit="" lay-filter="roleSub">立即提交</button>
		      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
		    </div>
	  	</div>
	  	<div style="height:150px;"></div>
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
					$("#controlPolice").html(options);
					layui.form.render();
					$("#controlPolice").next().find("dd:first").click();
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
		
		layui.use(['form','treeSelect','laydate'], function(){
			var form = layui.form,
			layer = layui.layer,
			laydate = layui.laydate,
		  	treeSelect = layui.treeSelect;
		  	laydate.render({
			   	elem:'#createTime'
			   	,format:  'yyyy-MM-dd'
			  });
			  laydate.render({
			   	elem:'#controlTime'
			   	,format:  'yyyy-MM-dd'
			  });
		  	
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
		        	//treeSelect.checkNode('controlUnit', "${controlUnit}");
		        	//treeSelect.refresh('controlUnit');
		        	//form.render();
		        }
		    });
		});
		
		layui.use(['form', 'laydate'], function(){
		         var form = layui.form,
		         layer = layui.layer,
		         laydate = layui.laydate;
		   
		   
		   
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
		  getorgType();
		  getorgClass();
		  form.render();
		   form.on('submit(roleSub)', function(data){
		   
             $("#form1").ajaxSubmit({
	              	url:		'<c:url value="/addOrganization.do"/>',
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
	</script>
  </body>
</html>
