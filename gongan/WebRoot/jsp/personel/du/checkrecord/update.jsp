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
    
    <title>修改吸毒人员-联控记录</title>
    
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
	<link rel="stylesheet" href="<c:url value="/layui/lay/modules/formSelects/formSelects-v4.css"/>" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  
  
  <body>
  	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  		<legend>修改吸毒人员-联控记录</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
	<input type="hidden"  name="menuid" value="0">
	<input type="hidden"  name="id" id="id"  value=${ducheckrecord.id}></input>
	<input type="hidden"  name="personnelid" id="personnelid"  value=${ducheckrecord.personnelid}></input>
	<div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>检查类型</label>
	    		<div class="layui-input-inline">
	      			<select   name="checktype"  id="checktype"  style="width:170px;" lay-verify="required" lay-verType="tips"></select>
	      		</div>
	       	</div>
	       	<div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>检查时间</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="checktime" id="checktime"  lay-verify="required" autocomplete="off" placeholder="请输入检查时间" 
	      			class="layui-input"  lay-reqtext="请输入检查时间" lay-verType="tips"  value="${ducheckrecord.checktime}">
	      		</div>
	       	</div>
	  </div>
	<div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label">检查单位</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="checkunit" id="checkunit"   autocomplete="off" placeholder="请输入检查单位" class="layui-input"  value="${ducheckrecord.checkunit}">
	      		</div>
	       	</div>
	       	<div class="layui-inline">
	    		<label class="layui-form-label">采集人</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="checkman" id="checkman" autocomplete="off" placeholder="请输入采集人" class="layui-input"  value="${ducheckrecord.checkman}">
	      		</div>
	       	</div>
	  </div>
	   <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label">内容</label>
	    		<div class="layui-input-inline">
                      <textarea placeholder="请输入内容" class="layui-textarea" name="checkcontent"  style="width:680px;">${ducheckrecord.checkcontent}</textarea>
                </div>
	         </div> 
	     </div> 
	   
		<div class="layui-form-item">
		    <div class="layui-input-block">
		      <button type="submit" class="layui-btn" lay-submit="" lay-filter="roleSub">立即提交</button>
		      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
		    </div>
	  	</div>
	</form>
	<script type="text/javascript">
	
	$(document).ready(function(){
	    $.ajax({
				type:		'POST',
				 url:		'<c:url value="/getBMByTypeToJSON1.do" />?basicType='+84, //
				 dataType:	'json',
				 async :      false,
				 success:	function(data){					  
				      var options = '<option value="">检查类型：请选择</option>' + fillOption(data);
				      $("select[name^=checktype]").html(options);
				        $("#checktype").val("${ducheckrecord.checktype}");
				   }
			});
		
       });
		layui.config({
		    base: "<c:url value="/layui/lay/modules/"/>"
		}).extend({
		     treeSelect: "treeSelect",
		     formSelects: 'formSelects/formSelects-v4'
		}).use(['form', 'laydate','layedit','formSelects','treeSelect'], function(){
		         var form = layui.form,
		         layer = layui.layer,
		         formSelects = layui.formSelects,
		         treeSelect = layui.treeSelect,
		         laydate = layui.laydate,
		         layedit = layui.layedit;
		         laydate.render({
					elem: '#checktime',
					type: 'date'
				});
		    
		  form.on('submit(roleSub)', function(data){
		   
		  $("#form1").ajaxSubmit({
	              	url:		'<c:url value="/updateducheckrecord.do"/>',
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
		 		        		 parent.layui.table.reload('jointcontrolrecordTable', {});   
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
