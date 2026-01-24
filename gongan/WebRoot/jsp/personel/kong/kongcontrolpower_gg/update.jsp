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
  		<legend>修改公共管控力量</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
		<input type="hidden"  name="id" id="id"  value="${kongcontrolpower.id}" ></input>
		<input type="hidden"  name="menuid" id="menuid"  value=${menuid}></input>
		<input type="hidden"  name="forcetype" id="forcetype"  value="${kongcontrolpower.forcetype}" ></input>
		<div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>姓名</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="personname" lay-verify="required" autocomplete="off" placeholder="请输入姓名" class="layui-input"  lay-reqtext="请输入姓名" value="${kongcontrolpower.personname}" >
	      		</div>
	       	</div>
	        <div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>性别</label>
	    		<div class="layui-input-inline">
	      			<input type="radio" name="sexes" value="男" title="男" <c:if test="${kongcontrolpower.sexes eq '男'}">checked=""</c:if>/>
      		        <input type="radio" name="sexes" value="女" title="女"  <c:if test="${kongcontrolpower.sexes eq '女'}">checked=""</c:if> />
	      		</div>
	       	</div>
	     </div>
	  <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label">兴趣爱好</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="interesting"  autocomplete="off" placeholder="请输入兴趣爱好" class="layui-input"  value="${kongcontrolpower.interesting}" >
	      		</div>
	       	</div>
	        <div class="layui-inline">
	    		<label class="layui-form-label">特殊技能</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="speciality"  autocomplete="off" placeholder="请输入特殊技能" class="layui-input" value="${kongcontrolpower.speciality}" >
	      		</div>
	       	</div>
	     </div>
	   <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>党派职务</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="partyduty"  autocomplete="off" placeholder="请输入党派职务" class="layui-input" value="${kongcontrolpower.partyduty}" lay-verify="required">
	      		</div>
	       	</div>
	        <div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>职务</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="duty"  autocomplete="off" placeholder="请输入职务" class="layui-input" value="${kongcontrolpower.duty}" lay-verify="required">
	      		</div>
	       	</div>
	     </div>
	   <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label">别名绰号</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="nickname"  autocomplete="off" placeholder="请输入别名绰号" class="layui-input" value="${kongcontrolpower.nickname}" >
	      		</div>
	       	</div>
	        <div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>文化程度</label>
	    		<div class="layui-input-inline">
	      			<select id="education"  name="education" style="width:170px;"  lay-verType="tips" lay-verify="required"></select>
	      		</div>
	       	</div>
	     </div>
	     <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>出生年月</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="birthdate"  autocomplete="off" placeholder="请输入出生年月" class="layui-input" value="${kongcontrolpower.birthdate}" lay-verify="required">
	      		</div>
	       	</div>
	        <div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>电话</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="telephone"  autocomplete="off" placeholder="请输入电话" class="layui-input" value="${kongcontrolpower.telephone}" lay-verify="required">
	      		</div>
	       	</div>
	     </div>
	     <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>家庭住址</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="address"  autocomplete="off" placeholder="请输入家庭住址" class="layui-input"  style="width:700px" value="${kongcontrolpower.address}" lay-verify="required">
	      		</div>
	       	</div>
	      </div>
	     <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label">暂住住址</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="lifeplace"  autocomplete="off" placeholder="请输入暂住住址" class="layui-input"  style="width:700px" value="${kongcontrolpower.lifeplace}" >
	      		</div>
	       	</div>
	      </div>
	      <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>工作单位</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="workunit"  autocomplete="off" placeholder="请输入工作单位" class="layui-input"  style="width:700px" value="${kongcontrolpower.workunit}" lay-verify="required">
	      		</div>
	       	</div>
	      </div>
	      <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label">前科情况</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="records"  autocomplete="off" placeholder="请输入前科情况" class="layui-input"  style="width:700px" value="${kongcontrolpower.records}" >
	      		</div>
	       	</div>
	      </div>
	       <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label">现实表现</label>
	    		<div class="layui-input-inline">
	      			 <textarea placeholder="请输入现实表现" class="layui-textarea" name="actualstate"  style="width:700px;" >${kongcontrolpower.actualstate}</textarea>
	      		</div>
	       	</div>
	      </div>
	       <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label">建立的目的和任务</label>
	    		<div class="layui-input-inline">
	      			 <textarea placeholder="请输入建立的目的和任务" class="layui-textarea" name="purposetask"  style="width:700px;">${kongcontrolpower.purposetask}</textarea>
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
	</form>
	<script type="text/javascript">
	$(document).ready(function(){
	    $.ajax({
				type:		'POST',
				 url:		'<c:url value="/getBMByTypeToJSON1.do" />?basicType='+19, 
				 dataType:	'json',
				 async :      false,
				 success:	function(data){					  
				      var options = '<option value="">--请选择---</option>' + fillOption(data);
				      $("select[name^=education]").html(options);
				        $("#education").val("${kongcontrolpower.education}");
				   }
			});
		
       });
		layui.use(['form', 'laydate'], function(){
		         var form = layui.form,
		         layer = layui.layer,
		         laydate = layui.laydate;
		         laydate.render({
					    elem: '#birthdate'//指定元素
					  
                  });  	
		   form.on('submit(roleSub)', function(data){
		   
             $("#form1").ajaxSubmit({
	              	url:		'<c:url value="/updateKongControlPower.do"/>',
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
		 		        	    parent.layui.table.reload('kongcontrolpowerTable1', {});     
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
