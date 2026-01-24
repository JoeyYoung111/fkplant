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
    
    <title>添加页面1</title>
    
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  </head>
   <body>
		<div class="layui-row layui-col-space15">
			<div class="layui-col-md6">
				<div class="layui-card">
					<div class="layui-card-header">基本信息</div>
					<div class="layui-card-body">
						<div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>人员姓名</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="staffName" lay-verify="required" autocomplete="off" placeholder="请输入人员姓名" class="layui-input"  lay-reqtext="人员姓名不能为空">
	      		</div>
	       	</div>
	       	<div class="layui-inline">
	    		<label class="layui-form-label"> 性  别 </label>
	    		<div class="layui-input-inline">
	    			<input type="text" name="staffName" lay-verify="required" autocomplete="off" placeholder="请输入人员姓名" class="layui-input"  lay-reqtext="人员姓名不能为空">
	      		</div>
	       	</div>
	 	</div>
	       </div>
		</div>
			</div>
			<div class="layui-col-md6">
				<div class="layui-card">
					<div class="layui-card-header">
						卡片面板2
					</div>
					<div class="layui-card-body">
						卡片式面板面板通常用于非白色背景色的主体内
						<br>
						从而映衬出边框投影
					</div>
				</div>
			</div>
		</div>
	</body>
</html>
