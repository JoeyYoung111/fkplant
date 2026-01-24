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
	<link rel="stylesheet" href="<c:url value="/layui/lay/modules/formSelects/formSelects-v4.css"/>" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/cardnumber.js"/>"></script>
  
  <body>
   <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  		<legend>新增三天一走访</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
		<input type="hidden"  name="personnelid" id="personnelid"  value=${param.personnelid}></input>
		<input type="hidden"  name="menuid" id="menuid"  value=0></input>
		<input type="hidden"  name="controltype" id="controltype"  value=${param.controltype}></input>
		<div class="layui-form-item">
	       	<div class="layui-inline" <c:if test="<%=userSession.getLoginUserRoleid()==31||userSession.getLoginUserRoleid()==32%>">style="pointer-events:none;"</c:if>>
	    		<label class="layui-form-label"><font color="red" size=2>*</font>管控时间：</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="controltime" id="controltime" lay-verify="required" autocomplete="off" placeholder="请选择管控时间" class="layui-input"  lay-reqtext="请选择管控时间"  >
	      		</div>
	       	</div>
	       	<div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>管控类型：</label>
	    		<div class="layui-input-inline">
	      			<select id="controlmode"  name="controlmode" style="width:170px;" lay-verify="required" lay-verType="tips"></select>
	      		</div>
	       	</div>
	  </div>
	  <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label">内容反馈：</label>
	    		<div class="layui-input-inline">
	      			 <textarea placeholder="请输入内容" class="layui-textarea" name="controlcontent" style="width:700px;"></textarea>
	      		</div>
	       	</div>
	     </div> 
	    <div class="layui-form-item">
			<label class="layui-form-label">图片上传：</label>
		    <div class="layui-input-block" style="width:50%">
		    	<button type="button" class="layui-btn" id="files">选择图片</button>
		    	<font color="red" size="4">*注意仅支持图片格式文件上传</font>
		    	<button type="button" style="display:none" id="upload_files">文件上传</button>
		    	<div class="layui-upload-list">
		    		<table class="layui-table">
		    			<thead><tr>
		    				<th>文件名</th>
		    				<th>状态</th>
		    				<th>操作</th>
		    			</tr></thead>
		    			<tbody id="filelist"></tbody>
		    		</table>
		    	</div>
		    </div>
		    <input type="hidden" name="fileattachments" id="fileattachments" value="" class="layui-input" />
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
	function Today(){
	var now = new Date();
	return now.getFullYear() + "-" +((now.getMonth()<10)?"0":"") +(now.getMonth() + 1) + "-" + now.getDate();
}
	$(document).ready(function(){
	    $.ajax({
				type:		'POST',
				 url:		'<c:url value="/getBMByTypeToJSON1.do" />?basicType='+81, 
				 dataType:	'json',
				 async :      false,
				 success:	function(data){					  
				      var options = '<option value="">--请选择---</option>' + fillOption(data);
				      $("select[name^=controlmode]").html(options);
				   }
			});
		
       });
		layui.use(['form', 'laydate','upload'], function(){
		         var form = layui.form,
		         layer = layui.layer,
		         upload = layui.upload,
		         now=new Date(),
		         laydate = layui.laydate;
		         laydate.render({
					    elem: '#controltime'//指定元素
					  	,min: now.toLocaleDateString()
                  }); 
                  $('#controltime').val(Today());
                  form.render()
            //文件上传
			var listview = $("#filelist");
			var fileidstr = "";
			var choose_files = 0;
			var uploadListIns = upload.render({
				elem: '#files', //绑定元素,
				url: '<c:url value="/newuploadfile.do"/>', //上传图片接口
				accept:		'images', //file video audio images 允许的文件类型
			    acceptMine:	'image/*',//规定打开文件选择框时，筛选出的文件类型 acceptMime:'image/*'（只显示图片文件）
				multiple: true,
				auto: false,
				bindAction:'#upload_files',
				choose: function(obj){
			  		var files = this.files = obj.pushFile();
			  		choose_files++;
			  		obj.preview(function(index,file,result){
				  		var tr = $(['<tr id="upload-'+index+'">'
				  					,'<td>'+file.name+'</td>'
				  					,'<td>等待上传</td>'
				  					,'<td>'
				  						,'<button class="layui-btn layui-btn-xs layui-btn-danger demo-delete">删除</button>'
				  					,'</td>'
				  					,'</tr>'].join(''));
				  					
				  		tr.find('.demo-delete').on('click',function(){
				  			delete files[index];
				  			choose_files--;
				  			tr.remove();
				  			uploadListIns.config.elem.next()[0].value = '';//清空input file值，以免后序同名文件不可选
				  		});
				  		listview.append(tr);
			  		});
			  }
			  ,done: function(res){
			    var recordingFileid = res.success;
			    fileidstr += recordingFileid + ",";
			    console.log("文件上传成功");
			  }
			  ,allDone: function(obj){
			 		$("#fileattachments").val(fileidstr.substring(0,fileidstr.length-1));
			 		add();
			  }
			  ,error: function(){
			    var tr = listview.find('tr#upload-'+index),
			    tds = tr.children();
			    tds.eq(2).html('<span style="color:#FF5722;">上传失败</span>');
			    tds.eq(3).html('.demo-reload').removeClass('layui-hide');//清空操作
			   
			  }
			});
			
		   form.on('submit(roleSub)', function(data){
		      var index1 = top.layer.msg('信息上传中，请稍后',{icon:16,time:false,shade:0.8});
				if(choose_files < 1){
					$("#fileattachments").val("");
					add();
				}else{
					$("#upload_files").click();
				}
				setTimeout(function(){
					top.layer.close(index1);
				},800);	
			    $("#fileattachments").val("");
          
	           	return false;
			 });
		});
			function add(){
			     $("#form1").ajaxSubmit({
	              	url:		'<c:url value="/addkongdailycontrol.do"/>',
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
				        		parent.layer.closeAll("iframe");
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
		    }
	</script>
  </body>
</html>
