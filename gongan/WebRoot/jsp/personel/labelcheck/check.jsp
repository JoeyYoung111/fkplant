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
    
    <title>审查页面</title>
    
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  </head>
  
  <body>
  	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  		<legend>审查人员标签信息</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
		<input type="hidden"  name="menuid" value="${param.menuid}">
		<input type="hidden"  name="id" value="${param.id}">
		<input type="hidden"  name="personnelid" value="${param.personnelid}">
		<input type="hidden"  name="applylabel1" value="${param.applylabel1}">
		<input type="hidden"  name="applylabel2" value="${param.applylabel2}">
		<input type="hidden"  name="cardnumber" value="${param.cardnumber}">
		<div class="layui-form-item">
			<label class="layui-form-label">标签所属人姓名</label>
			<div class="layui-input-inline" style="width:20%;">
	      		<input type="text" class="layui-input" readonly="readonly" value="${param.personname}">
	    	</div>
	    	<label class="layui-form-label" style="width:10%;">身份证号</label>
	    	<div class="layui-input-inline" style="width:20%;">
	      		<input type="text" class="layui-input" readonly="readonly" value="${param.cardnumber}">
	    	</div>
		</div>
		<div  class="layui-form-item">
			<label class="layui-form-label">申请标签1级</label>
			<div class=layui-input-inline style="width:52.5%;">
				<input type="text" class="layui-input" readonly="readonly" value="${param.applylabel1name}">
			</div>
		</div>
		<div  class="layui-form-item">
			<label class="layui-form-label">申请标签子级</label>
			<div class=layui-input-inline style="width:52.5%;">
				<input type="text" class="layui-input" readonly="readonly" value="${param.applylabel2name}">
			</div>
		</div>
		<div  class="layui-form-item" id="SDLB">
			<label class="layui-form-label">涉毒人员类别</label>
			<div class=layui-input-inline style="width:52.5%;">
				<input type="radio" name="personneltype" value="1" title="吸毒人员" checked />
	  			<input type="radio" name="personneltype" value="2" title="制贩毒人员" />
	  			<input type="radio" name="personneltype" value="3" title="既吸毒也制贩毒人员" />
			</div>
		</div>
		<div  class="layui-form-item">
			<label class="layui-form-label">申请理由</label>
			<div class=layui-input-inline style="width:52.5%;">
				<input type="text" class="layui-input" readonly="readonly" value="${param.applyreason}">
			</div>
		</div>
	  	<div class="layui-form-item">
			<label class="layui-form-label">申请人</label>
			<div class="layui-input-inline" style="width:20%;">
	      		<input type="text" class="layui-input" readonly="readonly" value="${param.addoperator}">
	    	</div>
	    	<label class="layui-form-label" style="width:10%;">申请时间</label>
	    	<div class="layui-input-inline" style="width:20%;">
	      		<input type="text" class="layui-input" readonly="readonly" value="${param.addtime}">
	    	</div>
		</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label">审核结果</label>
	    	<div class="layui-input-block">
		    	<input type="radio" name="examineflag" value="1" title="通过" checked>
		    	<input type="radio" name="examineflag" value="2" title="不通过">
	    	</div>
	  	</div>
		<div class="layui-form-item layui-form-text">
		    <label class="layui-form-label">审核理由</label>
		    <div class="layui-input-inline" style="width:52.5%;">
		      <textarea placeholder="请输入内容" class="layui-textarea" name="failreason"></textarea>
		    </div>
		</div>
		<div class="layui-form-item">
		    <div class="layui-input-block">
		      <button type="submit" class="layui-btn" lay-submit="" lay-filter="userSub">立即提交</button>
		      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
		    </div>
	  	</div>
	</form>
	<script type="text/javascript">
	
		$(document).ready(function(){
			var lb = "${param.applylabel1name}";
			if(lb == '涉毒标签'){
				$("#SDLB").show();
			}else{
				$("#SDLB").hide();
			}
		});
	
		layui.use(['form'], function(){
		  var form = layui.form;
		  form.on('submit(userSub)', function(data){
		     $("#form1").ajaxSubmit({
	              	url:		'<c:url value="/checkApplylabel.do"/>',
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
