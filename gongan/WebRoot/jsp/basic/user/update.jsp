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
    
    <title>添加页面</title>
    
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  </head>
  
  <body>
  	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  		<legend>修改系统账号</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
		<input type="hidden"  name="menuid" value=${menuid}>
		<input type="hidden"  name="dpName" id="dpName" value="${user.dpName}">
		<input type="hidden"  name="id" value=${user.id}>
		<div class="layui-form-item">
	           <div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>用户姓名</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="staffName" id="staffName" lay-verify="required" autocomplete="off" value="${user.staffName}"
	      			placeholder="请输入人员姓名" class="layui-input"  lay-reqtext="用户姓名不能为空">
	      		</div>
	       	</div>
	       	<div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>登录账号</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="usercode" lay-verify="required" autocomplete="off" placeholder="请设置账号" class="layui-input"  lay-reqtext="系统账号不能为空" value="${user.usercode}">
	      		</div>
	       	</div>	  	    	     
	    </div>
		<div class="layui-form-item">
		<div class="layui-inline">
	       		<label class="layui-form-label">身份证号</label>
	    		<div class="layui-input-inline">
	    			<input type="text" name="cardnumber" id="cardnumber"  autocomplete="off"  class="layui-input" placeholder="请输入身份证号" value="${user.cardnumber}">
	      		</div>
	       	</div>
	       	<div class="layui-inline">
	    		<label class="layui-form-label">警号</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="alarmsignal" id="alarmsignal"  autocomplete="off" placeholder="请输入警号" class="layui-input"  value="${user.alarmsignal}">
	      		</div>
	       	</div>	    	       	
	 	</div>
	 	<div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label">性别</label>
	    		<div class="layui-input-inline">
	      			<input type="radio" name="sexes" value="男" title="男" checked="" lay-filter="sexes" />
      		       <input type="radio" name="sexes" value="女" title="女" lay-filter="sexes" />
	      		</div>
	       	</div>
	       	<div class="layui-inline">
	       		<label class="layui-form-label">联系电话</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="contactnumber"  autocomplete="off" placeholder="请输入联系电话" class="layui-input"  value="${user.contactnumber}">
	      		</div>
	       	</div>
	 	</div>
	 	<div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label">所属角色</label>
	    		<div class="layui-input-inline">
	               <select name="roleid" id="roleid" lay-filter="roleid" lay-verify="required" lay-reqtext="所属角色不能为空"></select>
	      			
	      		</div>
	       	</div>
	       	<div class="layui-inline">
	       		<label class="layui-form-label">所属部门</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="departmentid" lay-filter="departmentid"  id="departmentid" lay-verify="required" autocomplete="off"  class="layui-input"  lay-reqtext="所属部门不能为空">
	      		</div>
	       	</div>
	 	</div>
		
	 
	 	<div class="layui-form-item layui-form-text">
		    <label class="layui-form-label">备注信息</label>
		    <div class="layui-input-block">
		      <textarea placeholder="请输入内容" class="layui-textarea" name="memo"></textarea>
		    </div>
		</div>
		<div class="layui-form-item">
		    <div class="layui-input-block">
		      <button type="submit" class="layui-btn" lay-submit="" lay-filter="userSub">立即提交</button>
		      <button type="reset" class="layui-btn layui-btn-primary" id="userReset">重置</button>
		    </div>
	  	</div>
	</form>
	<script type="text/javascript">
	  function getRoleJSON(){
				$.ajax({
					type:		'POST',
					url:		'<c:url value="/getRoleJSON.do" />',
					dataType:	'json',
					async:   false,
					success:	function(data){					  
						var options = '<option value="" >请选择所属角色</option>'+fillOption(data);
						$("select[name^=roleid]").html(options);
					}
				});
			}
			
		$(document).ready(function(){	
		     getRoleJSON();		
		     $("#roleid").val("${user.roleid}");
		});
		layui.config({
		    base: "<c:url value="/layui/lay/modules/"/>"
		}).extend({
		    treeSelect: "treeSelect"
		});
		layui.use(['form', 'layedit','treeSelect'], function(){
		  var form = layui.form,
		  layer = layui.layer,
		  treeSelect = layui.treeSelect,
		  layedit = layui.layedit;
		 treeSelect.render({
		        elem: '#departmentid', // 选择器
		        data: '<c:url value="/getDepartmentTree.do"/>',// 数据
		        type: 'get', // 异步加载方式：get/post，默认get
		        placeholder: '所属部门', // 占位符
		        search: true, // 是否开启搜索功能：true/false，默认false
		        // 一些可定制的样式
		        style: {
		            folder: { enable: false },
		            line: {  enable: true}
		        },
		        click: function(d){   // 点击回调
		           $("#dpName").val(d.current.title);
		            console.log(d.current.title);
		        },
		        // 加载完成后的回调函数
		        success: function (d) {
		          treeSelect.checkNode('departmentid', ${user.departmentid});
				   //获取zTree对象，可以调用zTree方法
               	   var treeObj = treeSelect.zTree('departmentid');
				   //刷新树结构
                   treeSelect.refresh('departmentid');
		        }
		    });
		  form.on('submit(userSub)', function(data){
		
	         $("#form1").ajaxSubmit({
	              	url:		'<c:url value="/updateUser.do"/>',
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
		});
	</script>
  </body>
</html>
