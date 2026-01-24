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
    
    <title>修改部门页面</title>
    
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  </head>
  
  <body>
  	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  		<legend id="typeName">添加系统部门</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
		<input type="hidden"  name="menuid" value=${menuid }>
   		<input type="hidden"  name="id" value=${department.id }>
   		<div class="layui-form-item">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>部门上级</label>
	    	<div class="layui-input-inline"  style="width:660px;">
	      		<input type="text" id="parentid" name="parentid" value="${department.parentid}" lay-filter="parentid" lay-verify="parentid" class="layui-input">
	    	</div>
	    </div>
		<div class="layui-form-item">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>部门名称</label>
	    	<div class="layui-input-inline">
	      		<input type="text" name="departname" lay-verify="required" autocomplete="off" placeholder="请输入部门名称" class="layui-input"  lay-reqtext="部门名称不能为空"  value="${department.departname}" >
	    	</div>
	    	<label class="layui-form-label"><font color="red" size=2>*</font>部门类型</label>
	    	<div class="layui-input-inline">
	      		<select id="departtype"  name="departtype" style="width:170px;" lay-verify="required">
			 		<option value=''>--请选择部门类别--</option>
			 		<option value='1'  <c:if test="${department.departtype  eq '1'}"> selected</c:if>>总局</option>
			 		<option value='2' <c:if test="${department.departtype  eq '2'}"> selected</c:if>>分局</option>
			 		<option value='3' <c:if test="${department.departtype  eq '3'}"> selected</c:if>>警种部门</option>
			 		<option value='4' <c:if test="${department.departtype  eq '4'}"> selected</c:if>>派出所</option>
			 		<option value='5' <c:if test="${department.departtype  eq '5'}"> selected</c:if>>政府部门</option>
			 		<option value='0' <c:if test="${department.departtype  eq '0'}"> selected</c:if>>部门节点</option>
			 		<option value='6' <c:if test="${department.departtype  eq '6'}"> selected</c:if>>其他</option>
			 	</select>
	    	</div>
	  	</div>
	   <div class="layui-form-item layui-form-text">
		    <label class="layui-form-label">部门ID（领悟）</label>
		    <div class="layui-input-inline"  style="width:660px;">
		     <input type="text" name="lingwuid"  autocomplete="off" placeholder="请输入部门ID（领悟接口）" class="layui-input"  value="${department.lingwuid}">
		    </div>
		</div>
	  	<div class="layui-form-item layui-form-text">
		    <label class="layui-form-label">备注信息</label>
		    <div class="layui-input-inline"  style="width:660px;">
		      <textarea placeholder="请输入内容" class="layui-textarea" name="memo"></textarea>
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
		$(document).ready(function(){
		});
		layui.config({
		    base: "<c:url value="/layui/lay/modules/"/>"
		}).extend({
		    treeSelect: "treeSelect"
		});
		layui.use(['form', 'layedit', 'laydate','treeSelect'], function(){
		  var form = layui.form,
		  layer = layui.layer,
		  layedit = layui.layedit,
		  treeSelect = layui.treeSelect,
		  laydate = layui.laydate;
		
		  form.render();
		   treeSelect.render({
		        elem: '#parentid', // 选择器
		        data: '<c:url value="/getDepartmentTree.do"/>',// 数据
		        type: 'get', // 异步加载方式：get/post，默认get
		        placeholder: '请选择部门父节点', // 占位符
		        search: true, // 是否开启搜索功能：true/false，默认false
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
		            //console.log($('#externalid').val());
		        },
		        // 加载完成后的回调函数
		        success: function (d) {
		           //console.log($('#externalid').val());
		        }
		    });
		  form.on('submit(msgSub)', function(data){
	         $("#form1").ajaxSubmit({
	              	url:		'<c:url value="/updateDepartment.do"/>',
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
