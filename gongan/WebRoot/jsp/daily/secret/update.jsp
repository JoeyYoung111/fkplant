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
    
    <title></title>
    
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  </head>
  
  <body>
	<form class="layui-form" method="post" id="form1" submit="return false;">
		<input type="hidden" id="id"  name="id" value="">
		<input type="hidden"  name="menuid" value=${param.menuid }>
		<div class="layui-form layui-row layui-col-md12" style="padding-top:10px;">
			<div class="layui-col-md1">
  				<div class="layui-col-md6 layui-col-md-offset6">
  					<label class="layui-form-label">保密教育</label>
  				</div>
  			</div>
  			<div class="layui-col-md9">
			    <div class="layui-input-block">
			      <textarea placeholder="请输入内容" class="layui-textarea" id="secret_text"></textarea>
			    </div>
		    </div>
	  	</div>
		<div class="layui-col-md6 layui-col-md-offset4" style="padding-top:20px;">
			<div class="layui-form-item">
			    <div class="layui-input-block">
			      <button type="submit" class="layui-btn" lay-submit="" lay-filter="userSub">提交修改</button>
			    </div>
		  	</div>
	  	</div>
	  	<div style="height:150px;"></div>
	</form>
	<script type="text/javascript">
		var secret_index;
		function getSecret(){
			$(".layui-layedit").find("iframe").find(".login-main").removeClass("login-main");
			$.ajax({
				type:		'POST',
				url:		'<c:url value="/getSecret.do"/>',
				dataType:	'json',
				async:      false,
				success:	function(data){
					$("#id").val(data.id);
					layui.layedit.setContent(secret_index,data.secret_text,false)
					layui.form.render();
				}
			});
		}
		
		layui.use(['form', 'layedit'], function(){
		  var form = layui.form,
		  layer = layui.layer,
		  layedit = layui.layedit;
		  layedit.set({
		  		tool: [ 'undo','redo','strong','italic','underline','del','|','removeformat','fontFomatt','fontfamily','fontSize','fontBackColor','colorpicker','left','center','right','link','unlink'],
				height:600
		  });
		  secret_index = layedit.build('secret_text');
		  getSecret();
				
		  form.on('submit(userSub)', function(data){
	         var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
	         $("#form1").ajaxSubmit({
	              	url:		'<c:url value="/updateDailySecret.do"/>',
	              	data:		{secret_text:layedit.getContent(secret_index)},
	              	dataType:	'json',
	              	async:  false,
	              	success:	function(data) {
	                  	var obj = eval('(' + data + ')');
	                  	if(obj.flag>0){
                  			//弹出loading
	                     	setTimeout(function(){         
	                     		top.layer.msg(obj.msg);
	                     		top.layer.close(index);
				        		layer.closeAll("iframe");
		 		        		//刷新父页面
		 		         		parent.$("#refresh").click();
		 		         		parent.layer.closeAll("iframe");
	                   		},2000);
	                 	}else{
	                  	 	top.layer.msg(obj.msg);
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
