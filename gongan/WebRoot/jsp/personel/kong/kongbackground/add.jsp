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
  		<legend>新增背景审查</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
		<input type="hidden"  name="personnelid" id="personnelid"  value=${param.personnelid}></input>
		<input type="hidden"  name="menuid" id="menuid"  value=${param.menuid}></input>
		<input type="hidden"  name="datatype" id="datatype"  value=${param.datatype}></input>
		<div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>审查时间</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="checktime"  id="checktime"   lay-verify="required" autocomplete="off" placeholder="请输入审查时间" class="layui-input"  lay-reqtext="请输入审查时间">
	      		</div>
	       	</div>
	       	<div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>审查方式</label>
	    		<div class="layui-input-inline">
	      				<select id="checktype"  name="checktype" style="width:170px;" lay-verify="required">
					 		<option value="">--请选择审查方式--</option>
					        <option value="点对点核查">点对点核查</option>
					        <option value="平台核查">平台核查</option>
					        <option value="电话联系">电话联系</option>
			 	</select>
	      		</div>
	       	</div>
	  </div>
	   <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>审查简述</label>
	    		<div class="layui-input-inline">
	      			 <textarea placeholder="请输入审查简述" class="layui-textarea" name="checkresume"  style="width:700px;"  lay-verify="required"></textarea>
	      		</div>
	       	</div>
	     </div>
<%--	   <div class="layui-form-item">--%>
<%--	    	<label class="layui-form-label"><font color="red" size=2>*</font>图片附件</label>--%>
<%--		    <div class="layui-input-block" style="width:50%">--%>
<%--			    <button type="button" style="display:none" id="upload_files">附件上传(hidden)</button>--%>
<%--			    <button type="button" class="layui-btn" id="files"><i class="layui-icon">&#xe67c;</i>选择附件</button>--%>
<%--			    <button type="button" class="layui-btn" onclick="repic();"><i class="layui-icon">&#xe640;</i>清空图片</button>--%>
<%--			    <div class="layui-upload" style="margin-top:10px;">--%>
<%--		    		<blockquote class="layui-elem-quote layui-quote-nm">--%>
<%--		    			<div class="layui-upload-list" id="licence_att_list" style="overflow:hodden"></div>--%>
<%--		    		</blockquote>--%>
<%--		    	</div>--%>
<%--		    </div>--%>
<%--		    <input type="hidden" name="attachments" id="attachments" value=""/>--%>
<%--        </div>--%>
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
		       laydate.render({
					    elem: '#checktime'//指定元素
				 });    
		   form.on('submit(roleSub)', function(data){
		   
             $("#form1").ajaxSubmit({
	              	url:		'<c:url value="/addKongBackground.do"/>',
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
		 		        	    parent.layui.table.reload('kongbackgroundTable', {});     
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
