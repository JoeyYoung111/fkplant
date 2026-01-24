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
     <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
     <link rel="stylesheet" href="<c:url value="/css/public.css"/>"  media="all" />
	 <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  
  
  <body>
   <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  		<legend>联控级别调整记录</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
		<input type="hidden"  name="id" id="id"  value="${jointcontrollevel.id}"></input>
		<input type="hidden"  name="personnelid" id="personnelid"  value="${jointcontrollevel.personnelid}"></input>
		<div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label">联控级别(申请前)</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="jointcontrollevel_old"  readonly  class="layui-input" value="${jointcontrollevel.jointcontrollevel_old}">   
	      		</div>
	       	</div>
	      <div class="layui-inline">
	    		<label class="layui-form-label">联控级别(申请后)</label>
	    		<div class="layui-input-inline">
	    		<input type="text" name="jointcontrollevel_new"  readonly  class="layui-input" value="${jointcontrollevel.jointcontrollevel_new}">  
	      		</div>
	       	</div> 	
	  </div>
	 <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label">申请人</label>
	    	 <div class="layui-input-inline">
	    		<input type="text" name="applicant"  readonly  class="layui-input" value="${jointcontrollevel.applicant}">  
	    	 </div>
	       	</div>
	  	  <div class="layui-inline">
	    		<label class="layui-form-label">申请时间</label>
	    		<div class="layui-input-inline">
	      		 <input type="text" name="applicanttime"  readonly  class="layui-input" value="${jointcontrollevel.applicanttime}">  
	      		</div>
	       	</div>
	  </div>
	   <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label">申请理由</label>
	    		<div class="layui-input-inline">
	      			  <textarea placeholder="请输入不通过理由" class="layui-textarea" name="memo"  style="width:700px;"  readonly>${jointcontrollevel.applicantreason}</textarea>
	      		</div>
	       	</div>
	     </div>   
	      <c:choose>
              <c:when test="<%=userSession.getLoginUserRoleid()==32%>">
              	  <c:choose>
	              	  <c:when test="${jointcontrollevel.jointcontrollevel_old eq '一级'||jointcontrollevel.jointcontrollevel_old eq '二级'||jointcontrollevel.jointcontrollevel_old eq '三级'||jointcontrollevel.jointcontrollevel_new eq '一级'||jointcontrollevel.jointcontrollevel_new eq '二级'||jointcontrollevel.jointcontrollevel_new eq '三级'}">
	               	  	<div class="layui-form-item">
				    		<div class="layui-input-block">
		                	  		<span class="my-tag-item3" style="background-color:red;color:white;">您无审核权限，请联系相关警种！！</span>
		               	  	 </div>
				  		</div>
	              	  </c:when>
	              	  <c:otherwise>
	              	  		<div class="layui-inline">
					    		<label class="layui-form-label"><font color="red" size=2>*</font>审核结果</label>
					    		<div class="layui-input-inline">
					      			<input type="radio" name="examineresult" value="1" title="通过" checked=""/>
				      		       <input type="radio" name="examineresult" value="2" title="不通过"  />
					      		</div>
					       	</div> 	
					      <div class="layui-form-item">
						       	<div class="layui-inline">
						    		<label class="layui-form-label">不通过理由</label>
						    		<div class="layui-input-inline">
						      			  <textarea placeholder="请输入不通过理由" class="layui-textarea" name="memo"  style="width:700px;"></textarea>
						      		</div>
						       	</div>
						     </div> 
						   <br><br>   
							<div class="layui-form-item">
							    <div class="layui-input-block">
								      <button type="submit" class="layui-btn" lay-submit="" lay-filter="roleSub">立即提交</button>
								      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
							    </div>
						  	</div>
	              	  </c:otherwise>
              	  </c:choose>
              </c:when>
              <c:otherwise>
			      <div class="layui-inline">
			    		<label class="layui-form-label"><font color="red" size=2>*</font>审核结果</label>
			    		<div class="layui-input-inline">
			      			<input type="radio" name="examineresult" value="1" title="通过" checked=""/>
		      		       <input type="radio" name="examineresult" value="2" title="不通过"  />
			      		</div>
			       	</div> 	
			      <div class="layui-form-item">
				       	<div class="layui-inline">
				    		<label class="layui-form-label">不通过理由</label>
				    		<div class="layui-input-inline">
				      			  <textarea placeholder="请输入不通过理由" class="layui-textarea" name="memo"  style="width:700px;"></textarea>
				      		</div>
				       	</div>
				     </div> 
				   <br><br>   
					<div class="layui-form-item">
					    <div class="layui-input-block">
						      <button type="submit" class="layui-btn" lay-submit="" lay-filter="roleSub">立即提交</button>
						      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
					    </div>
				  	</div>
              </c:otherwise>
          </c:choose>
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
	              	url:		'<c:url value="/examinejointcontrolleve.do"/>',
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
