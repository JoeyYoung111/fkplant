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
  		<legend>新增社会关系</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1" onsubmit="return false;">
		<input type="hidden"  name="personnelid" id="personnelid"  value=${param.personnelid}></input>
		<input type="hidden"  name="menuid" id="menuid"  value=${param.menuid}></input>
		<div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>获取来源</label>
	    		<div class="layui-input-inline">
	      			<select id="gainorigin"  name="gainorigin" style="width:170px;" lay-verify="required" lay-verType="tips"></select>
	      		</div>
	       	</div>
	     </div>
	     <div class="layui-form-item">
	      <div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>关系类别</label>
	    		<div class="layui-input-inline">
	      			<select id="relationtype"  name="relationtype" style="width:170px;" lay-filter="relationtype" lay-verify="required" lay-verType="tips"></select>
	      		</div>
	       	</div>
	       	<div class="layui-inline">
	    		<div id="appellationshow" style="display:none;">
		    		<label class="layui-form-label"><font color="red" size=2>*</font>关系称谓</label>
		    		<div class="layui-input-inline">
		      			<select id="appellation"  name="appellation" style="width:170px;" lay-filter="appellation" lay-verify="required" lay-verType="tips"></select>
		      		</div>
		    		<div class="layui-input-inline" id="memoshow" style="display:none;">
		      			<input type="text" name="memo" id="memo" lay-verify="memo" autocomplete="off" placeholder="请输入关系描述" class="layui-input" >
		      		</div>
	      		</div>
	       	</div>
	     </div> 
	    <div class="layui-form-item">
	       <div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>身份证号</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="cardnumber" id="cardnumber"  autocomplete="off" placeholder="请输入身份证号" class="layui-input" lay-verify="required|Iscardnumber" onblur="getpersonelname();">
	      		</div>
	       	</div>
	       	<div class="layui-inline">
	    		<label class="layui-form-label">姓名</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="personname" id="personname"  autocomplete="off" placeholder="请输入姓名" class="layui-input" >
	      		</div>
	       	</div>
	     </div> 
	      <div class="layui-form-item">
	       <div class="layui-inline">
	    		<label class="layui-form-label">现居地</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="homeplace" id="homeplace"  autocomplete="off" placeholder="请输入现居地" class="layui-input" >
	      		</div>
	       	</div>
	       	<div class="layui-inline">
	    		<label class="layui-form-label">工作单位</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="workplace"  id="workplace" autocomplete="off" placeholder="请输入工作单位" class="layui-input" >
	      		</div>
	       	</div>
	     </div> 
	     <div class="layui-form-item">
	       <div class="layui-inline">
	    		<label class="layui-form-label">联系电话1</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="telnumber1"  autocomplete="off" placeholder="请输入联系电话1" class="layui-input" >
	      		</div>
	       	</div>
	       	<div class="layui-inline">
	    		<label class="layui-form-label">联系电话2</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="telnumber2"  autocomplete="off" placeholder="请输入联系电话2" class="layui-input" >
	      		</div>
	       	</div>
	     </div> 
	     <div class="layui-form-item">
	       <div class="layui-inline">
	    		<label class="layui-form-label">联系电话3</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="telnumber3"  autocomplete="off" placeholder="请输入联系电话3" class="layui-input" >
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
var locat = (window.location+'').split('/'); 
$(function(){if('main'== locat[3]){locat =  locat[0]+'//'+locat[2];}else{locat =  locat[0]+'//'+locat[2]+'/'+locat[3];};});
	$(document).ready(function(){
	    $.ajax({
				type:		'POST',
				 url:		'<c:url value="/getBMByTypeToJSON1.do" />?basicType='+63, 
				 dataType:	'json',
				 async :      false,
				 success:	function(data){					  
				      var options = '<option value="">--请选择---</option>' + fillOption(data);
				      $("select[name^=gainorigin]").html(options);
				   }
			});
		 $.ajax({
				type:		'POST',
				 url:		'<c:url value="/getBMByTypeToJSON.do" />?basicType='+68, 
				 dataType:	'json',
				 async :      false,
				 success:	function(data){					  
				      var options = '';
				      options += '<option value="">--请选择---</option>';
				      
						$.each(data.list, function(i, item) {
							$.each(item, function(i) {
								options += '<option value="' + this.text + '" relationtypeid="'+this.value+'">' + this.text + '</option>';
							});
						});
						
				      $("select[name^=relationtype]").html(options);
				   }
			});
			
			$("#cardnumber").blur(function(){
					    var value = this.value;
					    var node = this;
					    if(value!=''){
					      $.getJSON(locat+"/getsocialrelationscount.do?personnelid="+${param.personnelid}+'&cardnumber='+value,{},function(data) {
							 var str = eval('(' + data + ')');
					      	 if (str.flag >0) {		                          
							     layer.msg('身份证号：['+value+']已经存在该人社会关系中！',{icon: 0});//!,ok,wrong,question,lock,cry,smile
						            node.focus();            
						        }		      	    		
					      });      
					    }
				  })
       });
		layui.use(['form', 'laydate'], function(){
		         var form = layui.form,
		         layer = layui.layer,
		         laydate = layui.laydate;
		         laydate.render({
					    elem: '#opentime'//指定元素
				 });  
			form.verify({
		       //证件号码不同类型都要验证
			  Iscardnumber:function(value,item){
			  		var validator = new IDValidator();
		  			var msg="";
		  			$.ajax({
						type:	'post',
						url:	'<c:url value="/getsocialrelationscount.do"/>',
						data:	{
									personnelid :  ${param.personnelid},
									cardnumber: 	value
								},
						dataType:	'json',
						async:		false,
						success:	function(data){
							var str = eval('(' + data + ')');
					      	if(str.flag >0)msg='身份证号：['+value+']已经存在该人社会关系中！';
					      	else{
						      	if(value.length>14&&!validator.isValid(value))msg ="身份证号存在错误";
					      	}
						}
					});
					if(msg!="")return msg;
			 },
		  	memo: function(value,item){
		  		if($("#appellation").val()=="其他"&&value=="")return "请输入关系描述";
		  	},
		  });  	 
			
			form.on('select(relationtype)', function(data){
			  $('#memoshow').hide();
			  $('#memo').val("");
			  if(data.value!=""){
				$.ajax({
					type:		'POST',
					 url:		'<c:url value="/getBMByParentIdToJSON.do"/>?parentid='+$('#relationtype').find("option:selected").attr('relationtypeid'), 
					 dataType:	'json',
					 async :    false,
					 success:	function(data){					  
					      var options = '',other=false;
					      options += '<option value="">--请选择---</option>';
					      
							$.each(data.list, function(i, item) {
								$.each(item, function(i) {
									if(this.text=="其他")other=true;
									options += '<option value="' + this.text + '" relationtypeid="'+this.value+'">' + this.text + '</option>';
								});
							});
							if(!other)options += '<option value="其他">其他</option>';
							
							$('#appellationshow').show();
					      $("select[name^=appellation]").html(options);
					   }
				});
			  }else{
			  	$('#appellationshow').hide();
			  	$("select[name^=appellation]").html("");
			  }
			  form.render();
		  });	 
			form.on('select(appellation)', function(data){
			  if(data.value!="其他"){
			  	$('#memoshow').hide();
			  	$('#memo').val("");
			  }else{
			  	$('#memoshow').show();
			  }
			  form.render();
		  });	 
				 	
		   form.on('submit(roleSub)', function(data){
		   
             $("#form1").ajaxSubmit({
	              	url:		'<c:url value="/addsocialrelations.do"/>',
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
		 		        	    parent.layui.table.reload('socialrelationsTable', {});   
	                   		},2000);
	                   		layer.close(layer.index);
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
		
		function getpersonelname(){
		 var cardnumber=$("#cardnumber").val();
		 //alert(cardnumber);
		 if(cardnumber!=''){
		         $.getJSON(locat+"/getpersonelname.do?cardnumber="+cardnumber,{},function(data) {
							 var str = eval('(' + data + ')');
					      	 if (str.flag ==1) {	//风险人员	                          
							   $("#personname").val(str.msg); 
							   var persnnel = eval('(' + str.result + ')');
							   $("#homeplace").val(persnnel.homeplace); 
							   $("#workplace").val(persnnel.workplace);           
						 }else if(str.flag ==2){//其他社会关系人员
						       $("#personname").val(str.msg); 
							   var socialrelations = eval('(' + str.result + ')');
							   $("#homeplace").val(socialrelations.homeplace); 
							   $("#workplace").val(socialrelations.workplace);  
							   $("#telnumber1").val(socialrelations.telnumber1);    
							   $("#telnumber2").val(socialrelations.telnumber2);      
							   $("#telnumber3").val(socialrelations.telnumber3);        
						 }  	    		
				 });  
		  }
		}
	</script>
  </body>
</html>
