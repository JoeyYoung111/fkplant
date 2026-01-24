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
	<link rel="stylesheet" href="<c:url value="/layui/lay/modules/formSelects/formSelects-v4.css"/>" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/cardnumber.js"/>"></script>
  
  <body>
   <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  		<legend>新增公共管控力量-家庭关系/社会关系</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
		<input type="hidden"  name="controlpowerid" id="controlpowerid"  value=${kongpublicrelation.controlpowerid}></input>
		<input type="hidden"  name="id" id="id"  value=${kongpublicrelation.id}></input>
		<input type="hidden"  name="menuid" id="menuid"  value=0></input>
		<input type="hidden"  name="relationtype" id="relationtype"  value=1></input>
		<div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>称谓</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="appellation"  id="appellation"   lay-verify="required" autocomplete="off" placeholder="请输入称谓" class="layui-input"  lay-reqtext="请输入称谓"   value="${kongpublicrelation.appellation}">
	      		</div>
	       	</div>
	  </div>
	 <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>姓名</label>
	    		<div class="layui-input-inline">
	      				<input type="text"  id="relationname"  name="relationname"  lay-verify="required"   placeholder="请输入姓名" class="layui-input"  lay-reqtext="请输入姓名"  value="${kongpublicrelation.relationname}">
	      		</div>
	       	</div>
	     </div>
	     <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>政治表现</label>
	    		<div class="layui-input-inline">
	      				<input type="text"  id="politicalposition"  name="politicalposition"   placeholder="请输入政治表现" class="layui-input"  value="${kongpublicrelation.politicalposition}">
	      		</div>
	       	</div>
	     </div>
	     <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label">现在工作地点、部门及职务</label>
	    		<div class="layui-input-inline">
	      			 <textarea placeholder="请输入现在工作地点、部门及职务" class="layui-textarea" name="workdetails"  style="width:400px;">${kongpublicrelation.workdetails}</textarea>
	      		</div>
	       	</div>
	     </div> 
	   
	     <br>
		<div class="layui-form-item">
		    <div class="layui-input-block">
		      <button type="submit" class="layui-btn" lay-submit="" lay-filter="roleSub">立即提交</button>
		      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
		    </div>
	  	</div>
	</form>
	<script type="text/javascript">
	$(document).ready(function(){
	 
		
       });
		layui.use(['form', 'laydate'], function(){
		         var form = layui.form,
		         layer = layui.layer,
		         laydate = layui.laydate;
		       
		   form.on('submit(roleSub)', function(data){
		   
             $("#form1").ajaxSubmit({
	              	url:		'<c:url value="/updateKongPublicRelation.do"/>',
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
				        		parent.layui.layer.closeAll("iframe");
		 		        	    parent.layui.table.reload('kongpublicrelation', {});     
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
