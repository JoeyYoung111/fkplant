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
  		<legend id="typeName">用户审核</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
	<input type="hidden"  name="id" value=${param.id}>
		<input type="hidden"  name="menuid" value=${param.menuid}>		
		<div class="layui-form-item">
   <div class="layui-inline">
    <label class="layui-form-label"><font color="red" size=2>*</font>审核结果</label>
    <div class="layui-input-inline">
      <input type="radio" name="examineid" value="2" title="通过" checked="" lay-filter="types" />
      <input type="radio" name="examineid" value="3" title="不通过" lay-filter="typess" />
      </div>
       </div>
 </div>
	  
		<div class="layui-form-item layui-form-text" style="display:none;" id="shows">
		    <label class="layui-form-label">不通过理由</label>
		    <div class="layui-input-block">
		      <textarea placeholder="请输入内容" class="layui-textarea" name="reason" style="width:670px;"></textarea>
		    </div>
		</div>	  	
		<div class="layui-form-item">
		    <div class="layui-input-block">
		      <button type="submit" class="layui-btn jjbz-btn-submit" lay-submit="" lay-filter="msgSub">立即提交</button>
		      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
		    </div>
	  	</div>
	</form>
	<script type="text/javascript">
	
		layui.use(['form', 'layedit', 'laydate'], function(){
		  var form = layui.form,
		  layer = layui.layer,
		  layedit = layui.layedit,
		  laydate = layui.laydate;
		  form.render();	
		  form.on('radio(types)', function(data){
          $("#shows").hide();  
          });  
		 form.on('radio(typess)', function(data){
		   $("#shows").show();
		  });  	 
		  form.on('submit(msgSub)', function(data){
		  // 单击之后提交按钮不可选,防止重复提交
			 var DISABLED = 'layui-btn-disabled';
			 // 增加样式
			 $('.jjbz-btn-submit').addClass(DISABLED);
			 // 增加属性
			 $('.jjbz-btn-submit').attr('disabled', 'disabled');
	         $("#form1").ajaxSubmit({
	              	url:		'<c:url value="/shenheUser.do"/>',
	              	
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
