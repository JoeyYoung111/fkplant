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
    
    <title>添加</title>
    
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
    <script type="text/javascript" src="<c:url value='/js/check.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  </head>
  
  <body>
  	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  		<c:if test="${param.htype  eq 1}">
  			<legend id="typeName">添加领导批示</legend>
  		</c:if>
  		<c:if test="${param.htype  eq 2}">
  			<legend id="typeName">添加涉稳专报</legend>
  		</c:if>
  		<c:if test="${param.htype  eq 3}">
  			<legend id="typeName">添加维稳专报</legend>
  		</c:if>
  		<c:if test="${param.htype  eq 4}">
  			<legend id="typeName">添加涉稳风险交办处置建议</legend>
  		</c:if>
  		<c:if test="${param.htype  eq 5}">
  			<legend id="typeName">添加专题会议纪要</legend>
  		</c:if>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
		<input type="hidden"  name="menuid" value=${param.menuid }>
		<input type="hidden"  name="cdtid" value=${param.cdtid }>
		<input type="hidden"  name="htype" value=${param.htype }>
		<div class="layui-form-item">
			<c:if test="${param.htype  eq 1}">
  				<label class="layui-form-label"><font color="red" size=2>*</font>批示标题</label>
  			</c:if>
  			<c:if test="${param.htype  eq 2}">
  				<label class="layui-form-label"><font color="red" size=2>*</font>标题</label>
  			</c:if>
  			<c:if test="${param.htype  eq 3}">
  				<label class="layui-form-label"><font color="red" size=2>*</font>专报标题</label>
  			</c:if>
  			<c:if test="${param.htype  eq 4}">
  				<label class="layui-form-label"><font color="red" size=2>*</font>建议标题</label>
  			</c:if>
  			<c:if test="${param.htype  eq 5}">
  				<label class="layui-form-label"><font color="red" size=2>*</font>会议标题</label>
  			</c:if>
	    	<div class="layui-input-inline" style="width:20%;">
				<input type="text" class="layui-input" id="htitle" name="htitle">
			</div>
			<c:if test="${param.htype  eq 1}">
  				<label class="layui-form-label" style="width:10%;">录入时间</label>
  			</c:if>
  			<c:if test="${param.htype  eq 2 or param.htype  eq 3}">
  				<label class="layui-form-label" style="width:10%;">编刊时间</label>
  			</c:if>
  			<c:if test="${param.htype  eq 4}">
  				<label class="layui-form-label" style="width:10%;">提交时间</label>
  			</c:if>
  			<c:if test="${param.htype  eq 5}">
  				<label class="layui-form-label" style="width:10%;">会议时间</label>
  			</c:if>
	    	<div class="layui-input-inline" style="width:20%;">
				<input type="text" class="layui-input" id="hdate" name="hdate">
			</div>
	  	</div>
	  	<div class="layui-form-item layui-form-text">
	  		<c:if test="${param.htype  eq 1}">
  				<label class="layui-form-label">批示内容</label>
  			</c:if>
  			<c:if test="${param.htype  eq 2}">
  				<label class="layui-form-label">内容</label>
  			</c:if>
  			<c:if test="${param.htype  eq 3}">
  				<label class="layui-form-label">专报内容</label>
  			</c:if>
  			<c:if test="${param.htype  eq 4}">
  				<label class="layui-form-label">建议内容</label>
  			</c:if>
  			<c:if test="${param.htype  eq 5}">
  				<label class="layui-form-label">会议内容</label>
  			</c:if>
		    <div class="layui-input-inline" style="width:52.5%;">
		      <textarea placeholder="请输入内容" class="layui-textarea" name="hcontent"></textarea>
		    </div>
		</div>
		<c:if test="${param.htype  eq 1}">
		  	<div class="layui-form-item">
		    	<label class="layui-form-label">领导级别</label>
		    	<div class="layui-input-inline" style="width:20%;">
					<select id="leaderlevel"  name="leaderlevel">
				 		<option value="">--请选择领导级别--</option>
				 	</select>
				</div>
				<label class="layui-form-label" style="width:10%;">批示人</label>
		    	<div class="layui-input-inline" style="width:20%;">
					<input type="text" class="layui-input" id="approveperson" name="approveperson">
				</div>
		  	</div>
  		</c:if>
		<c:if test="${param.htype  eq 4}">
			<div class="layui-form-item">
		    	<label class="layui-form-label">接收人</label>
		    	<div class="layui-input-inline" style="width:52.5%;">
		      		<input type="text" class="layui-input" id="receiver" name="receiver">
		    	</div>
		  	</div>
			<div class="layui-form-item layui-form-text">
			    <label class="layui-form-label">办理情况</label>
			    <div class="layui-input-inline" style="width:52.5%;">
			      <textarea placeholder="请输入内容" class="layui-textarea" name="hsituation"></textarea>
			    </div>
			</div>
			<div class="layui-form-item">
		    	<label class="layui-form-label">处置结果</label>
		    	<div class="layui-input-inline" style="width:52.5%;">
		      		<input type="text" class="layui-input" id="hresult" name="hresult">
		    	</div>
		  	</div>
		</c:if>
	  	<div class="layui-form-item">
			<label class="layui-form-label">附件上传</label>
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
	</form>
	<script type="text/javascript">
		layui.use(['form', 'laydate','upload'], function(){
			var form = layui.form,
			layer = layui.layer,
			upload = layui.upload,
			laydate = layui.laydate;
		  	
		  	laydate.render({
			  elem: '#hdate',
			  value: new Date()
			});
		    
		    if(${param.htype }==1){
		    	//初始化领导级别
			    $.ajax({
					type:		'POST',
					url:		'<c:url value="/getbasicMsgJSON.do"/>?basicType=70',
					dataType:	'json',
					success:	function(data){
		          			$.each(data, function(num, item) {
		          				$('#leaderlevel').append('<option value="' + item.name + '">' + item.name + '</option>');
		         			});
		     				form.render("select");
					}
				});
		    }
		    
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
					$("#attachments").val("0");
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
		  });
		  
		  function add(){
			$("#form1").ajaxSubmit({
              	url:		'<c:url value="/addHandleInfo.do"/>',
              	dataType:	'json',
              	async:  	false,
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
	 		        if(${param.htype  eq 1}){
	 		        	parent.formSubmit('ldps','<c:url value="searchHandleInfo.do"/>');
	 		        }else if(${param.htype  eq 2}){
	 		        	parent.formSubmit('yqkb','<c:url value="searchHandleInfo.do"/>?htype=2');
	 		        }else if(${param.htype  eq 3}){
	 		        	parent.formSubmit('wwzb','<c:url value="searchHandleInfo.do"/>?htype=3');
	 		        }else if(${param.htype  eq 4}){
	 		        	parent.formSubmit('jbcz','<c:url value="searchHandleInfo.do"/>?htype=4');
	 		        }else if(${param.htype  eq 5}){
	 		        	parent.formSubmit('hyjy','<c:url value="searchHandleInfo.do"/>?htype=5');
	 		        }
                   },500);
                 }else{
                  	 layer.msg(obj.msg);
                }
             },
              	error:function() {
                  	alert("请求失败！");
              	}
          	});
  		}
	</script>
  </body>
</html>
