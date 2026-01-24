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
  		<legend>添加政保阵地信息</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
		<input type="hidden"  name="menuid" id="menuid"  value=${param.menuid}></input>
		<div class="layui-form-item">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>名称</label>
	    	<div class="layui-input-inline">
	      		<input type="text" name="positionname" lay-verify="required" autocomplete="off" placeholder="请输入名称" class="layui-input"  lay-reqtext="名称不能为空">
	    	</div>
	    	<label class="layui-form-label">外文名称</label>
	    	<div class="layui-input-inline">
	      		<input type="text" name="foreignname" autocomplete="off" class="layui-input">
	    	</div>
	  	</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label">阵地级别</label>
	    	<div class="layui-input-inline">
	    		<select id="positiontype" name="positiontype" autocomplete="off">
					<option value=""> --- 请选择 --- </option>
				</select>
	    	</div>
	    	<label class="layui-form-label">阵地类别</label>
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
	      		<input type="text" id="jdphone" name="jdphone" autocomplete="off" class="layui-input">
	    	</div>
	  	</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label">成立时间</label>
	    	<div class="layui-input-inline">
	      		<input type="text" name="setuptime" id="setuptime" readonly lay-verify="required" lay-reqtext="请选择成立时间" autocomplete="off" placeholder="年-月-日" class="layui-input">
	    	</div>
	    	<label class="layui-form-label">成立地点</label>
	    	<div class="layui-input-inline">
	      		<input type="text" name="setupplace" autocomplete="off" class="layui-input">
	    	</div>
	  	</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label">详细地址</label>
	    	<div class="layui-input-inline">
	      		<input type="text" name="address" autocomplete="off" class="layui-input" style="width:660px;">
	    	</div>
	  	</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label">占地面积</label>
	    	<div class="layui-input-inline">
	      		<input type="text" name="placearea" autocomplete="off" class="layui-input">
	    	</div>
	    	<label class="layui-form-label">涉及人数</label>
	    	<div class="layui-input-inline">
	      		<input type="text" name="personnum" autocomplete="off" class="layui-input">
	    	</div>
	  	</div>
		
	  	<div class="layui-form-item">
	    	<label class="layui-form-label">主管政府部门或单位</label>
	    	<div class="layui-input-inline">
	      		<input type="text" name="chargeunit" autocomplete="off" class="layui-input" style="width:660px;">
	    	</div>
	  	</div>
		<div class="layui-form-item layui-form-text">
		    <label class="layui-form-label">阵地概况</label>
		    <div class="layui-input-inline">
		      <textarea placeholder="请输入内容" class="layui-textarea" name="positionsurvey" style="width:660px;"></textarea>
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
					$("#jdpolice").html(options);
					layui.form.render();
					$("#jdpolice").next().find("dd:first").click();
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
					var options ="";
					$.each(data.list, function(i, item) {
						$.each(item, function(i) {
							options += '<option value="' + this.text + '">' + this.text + '</option>';
						});
					});
					$("#positiontype").append(options);
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
		        	//treeSelect.checkNode('jdunit', "${jdunit}");
		        	//treeSelect.refresh('jdunit');
		        	//form.render();
		        }
		    });
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
	              	url:		'<c:url value="/addPosition.do"/>',
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
