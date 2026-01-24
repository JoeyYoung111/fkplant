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
    
    
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
	<link rel="stylesheet" href="<c:url value="/css/public.css"/>"  media="all" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/js/cardnumber.js"/>"></script>
  </head>
  
  <body>
  	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  		<legend id="typeName">添加其他风险</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1" onsubmit="return false;">
		<input type="hidden"  name="menuid" value=${menuid }>
		<div class="layui-form-item">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>风险名称</label>
	    	<div class="layui-input-inline">
	      		<input type="text" id="cardnumber" name="cardnumber" lay-verify="required|cardnumber" autocomplete="off" placeholder="请输入风险名称" class="layui-input"  lay-reqtext="风险名称不能为空" value="">
	    	</div>
	    	<label class="layui-form-label"><font color="red" size=2>*</font>风险类别</label>
	    	<div class="layui-input-inline">
	      		<input type="text" id="personname" name="personname" lay-verify="required" autocomplete="off" placeholder="请输入风险类别" class="layui-input"  lay-reqtext="风险类别不能为空">
	    	</div>
	  	</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>管辖责任单位</label>
	    	<div class="layui-input-inline" lay-verify="jurisdictunit1" id="unitdiv">
				<input type="text" id="jurisdictunit1" name="jurisdictunit1" value="0" lay-filter="jurisdictunit1" class="layui-input" autocomplete="off">
	    	</div>
	    	<label class="layui-form-label"><font color="red" size=2>*</font>管辖责任民警</label>
	    	<div class="layui-input-inline" lay-verify="jurisdictpolice1">
	    		<select id="jurisdictpolice1" name="jurisdictpolice1">
	    		</select>
	    	</div>
	  	</div>
		<div class="layui-form-item">
		    <div class="layui-input-block">
		      <button type="submit" class="layui-btn" lay-submit="" lay-filter="msgSub">立即提交</button>
		    </div>
	  	</div>
	</form>
	<script type="text/javascript">
		function getUsers(departmentid){
			$.ajax({
				type:		'POST',
				url:		'<c:url value="/getUsersByDepartmentid.do?departmentid="/>'+departmentid,
				dataType:	'json',
				async:      false,
				success:	function(data){
					var options = fillOption(data);
					$("#jurisdictpolice1").html(options);
					//$("#jurisdictpolice1 option[value=${jurisdictpolice1}]").select();
				}
			});
		}
		
		$(document).ready(function(){
			//getUsers(0);
		});
		layui.config({
		    base: "<c:url value="/layui/lay/modules/"/>"
		}).extend({
		    treeSelect: "treeSelect",
		    zTreeSelectM: "zTreeSelectM/zTreeSelectM"
		});
		
		layui.use(['form','treeSelect'], function(){
			var form = layui.form,
			layer = layui.layer,
		  	treeSelect = layui.treeSelect;
		  	treeSelect.render({
		        // 选择器
		        elem: '#jurisdictunit1',
		        // 数据
		        data: '<c:url value="/getDepartmentTree.do"/>',
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
		        	getUsers($('#jurisdictunit1').val());
		        	form.render();
		        },
		        // 加载完成后的回调函数
		        success: function (d) {
		        	treeSelect.checkNode('jurisdictunit1', "<%=userSession.getLoginUserDepartmentid()%>");
		        	treeSelect.refresh('jurisdictunit1');
		        	getUsers($('#jurisdictunit1').val());
		        	form.render();
		        	//$("#unitdiv").css("pointerEvents","none");
		        }
		    });
		});
		
		layui.use(['form','zTreeSelectM'], function(){
		  var form = layui.form,
		  zTreeSelectM = layui.zTreeSelectM,
		  layer = layui.layer;
		  
		  form.verify({
			  	jurisdictpolice1: function(value,item){
		    		if(!$("#jurisdictpolice1").val()||$("#jurisdictpolice1").val()==""){
		    			$("#jurisdictpolice1").next().find("input").focus();
			  			return "请选择管辖责任民警";
		    		}
		    	},
			  	jurisdictunit1: function(value,item){
		    		if(!$("#jurisdictunit1").val()||$("#jurisdictunit1").val()=="0"){
			  			return "请选择管辖责任单位";
		    		}
		    	}
			  });
		  form.render();
		  form.on('submit(msgSub)', function(data){
	           	return false;
			 });
		});
	</script>
  </body>
</html>
