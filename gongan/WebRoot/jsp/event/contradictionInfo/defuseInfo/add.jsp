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
    
    <title>添加稳控化解情况页面</title>
    
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  </head>
  
  <body>
  	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;overflow:auto">
  		<legend id="typeName">添加稳控化解情况</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
		<input type="hidden"  name="menuid" value=${param.menuid }>
		<input type="hidden"  name="cdtid" value=${param.cdtid }>
		<input type="hidden"  id="workinfoid" name="workinfoid" value=0>
		<div class="layui-form-item">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>预计落实时间</label>
	    	<div class="layui-input-inline" style="width:52.5%;">
	      		<input type="text" class="layui-input" id="lsdate" name="lsdate" autocomplete="off">
	    	</div>
	  	</div>
	  	<div class="layui-form-item layui-form-text">
		    <label class="layui-form-label">措施概述</label>
		    <div class="layui-input-inline" style="width:52.5%;">
		      <textarea placeholder="请输入内容" class="layui-textarea" name="csgs"></textarea>
		    </div>
		</div>
	  	<div class="layui-form-item">
			<label class="layui-form-label">是否落实情况</label>
	    	<div class="layui-input-inline" style="width:52.5%;">
				<select id="sflsqk"  name="sflsqk">
			 		<option value="">--请选择--</option>
			 		<option value="已落实">已落实</option>
			 		<option value="未落实">未落实</option>
			 	</select>
			</div>
	  	</div>
	  	<div class="layui-form-item layui-form-text">
		    <label class="layui-form-label">落实情况概述</label>
		    <div class="layui-input-inline" style="width:52.5%;">
		      <textarea placeholder="请输入内容" class="layui-textarea" name="lsqkks"></textarea>
		    </div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">文件</label>
		    <div class="layui-input-block" style="width:50%">
		    	<button type="button" class="layui-btn" id="files">选择多文件</button>
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
		    <input type="hidden" name="attachments" id="attachments" value="" class="layui-input" />
		</div>
		<div class="layui-form-item">
		    <div class="layui-input-block">
		      <button type="submit" class="layui-btn" lay-submit="" lay-filter="msgSub">立即提交</button>
		      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
		    </div>
	  	</div>
	  	<div style="height:150px;"></div>
	</form>
	<script type="text/javascript">
		if("${param.workinfoid}"!=""){
			$("#workinfoid").val(${param.workinfoid});
		}
		var layer;
		layui.use(['form', 'laydate','upload'], function(){
			var form = layui.form,
			layer = layui.layer,
			laydate = layui.laydate,
			upload = layui.upload;
		  	
		  	laydate.render({
			  elem: '#lsdate',
			  type: 'datetime',
			  format: 'yyyy-MM-dd HH:mm:ss',
			  done: function(value){
				if(value.indexOf('00:00:00')>=0){
					top.layer.msg("<div>发生时间未选择具体时间<span style='color:red'>！</span></div>",{time:3000});
				}
			  }
			});
			
			var choose_files = 0;
  
			//文件上传
			var listview = $("#filelist");
			var fileidstr = "";
			var uploadListIns = upload.render({
				elem: '#files', //绑定元素,
				url: '<c:url value="/newuploadfile1.do"/>', //上传接口
				accept:'file',
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
			 		$("#attachments").val(fileidstr.substring(0,fileidstr.length-1));
			 		add();
			  }
			  ,error: function(){
			    var tr = listview.find('tr#upload-'+index),
			    tds = tr.children();
			    tds.eq(2).html('<span style="color:#FF5722;">上传失败</span>');
			    tds.eq(3).html('.demo-reload').removeClass('layui-hide');//清空操作
			   
			  }
			});
		    
		    form.on('submit(msgSub)', function(data){
		  		var index1 = top.layer.msg('信息上传中，请稍后',{icon:16,time:false,shade:0.8});
				if(choose_files < 1){
					$("#attachments").val("(0)");
					add();
				}else{
					$("#upload_files").click();
				}
				setTimeout(function(){
					top.layer.close(index1);
				},800);	
			    $("#attachments").val("0");
			    return false;
			});
			  
			  function add(){
			  	$("#form1").ajaxSubmit({
	              	url:		'<c:url value="/addDefuseInfo.do"/>',
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
		 		         		parent.layer.closeAll("iframe");
		 		         		if("${param.page}"=="feedback"){
	    							parent.formSubmit();
			        				parent.parent.parent.formSubmit('wkhj','<c:url value="searchDefuseInfo.do"/>');
	    						}else if("${param.page}"=="gzjbsearch"){
	    							parent.formSubmit();
	    						}else{
	    							parent.formSubmit('wkhj','<c:url value="searchDefuseInfo.do"/>');
	    						}
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
			  }
		  });
	</script>
  </body>
</html>
