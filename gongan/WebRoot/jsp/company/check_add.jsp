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
    
    <title>添加单位核查页面</title>
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/js/jquery.form.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  	
</head>
<body>
<form class="layui-form" method="post" id="form_check">

	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 5px;">
		<legend>添加单位核查信息</legend>
	</fieldset>
	
	<input type="hidden" name="companyid" id="companyid" value="${param.companyid }" />
	<input type="hidden" name="menuid" id="menuid" value="${param.menuid }" />
	
	<div class="layui-form-item">
      	<div class="layui-inline">
			<label class="layui-form-label"><font color="red" size=2>*</font>核查日期</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" style="width:670px;" name="checkdate" id="checkdate" lay-verify="required" lay-reqtext="请输入日期" autocomplete="off" />
			</div>
		</div>
	</div>
    
	<div class="layui-form-item">
		<div class="layui-inline">
			<label class="layui-form-label">检查结果概述</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" id="resultsummary" name="resultsummary" style="width:670px;" />
			</div>
		</div>
	</div>
	
	<div class="layui-form-item">
	<label class="layui-form-label"><font color="red" size=2>*</font>核查单附件</label>
	    <div class="layui-input-block" style="width:50%">
		    <button type="button" style="display:none" id="upload_files">文件上传(hidden)</button>
		    <button type="button" class="layui-btn" id="files">选择多文件</button>
	    	
	    	<div class="layui-upload-list" style="margin-top:10px;">
		    	<table class="layui-table">
		    		<thead>
		    			<tr>
							<th>文件名</th>
							<th>状态</th>
							<th>操作</th>
						</tr>
		    		</thead>
		    		<tbody id="filelist"></tbody>
		    	</table>
		    </div>
	    </div>
	    <input type="hidden" name="attachments" id="attachments" value=""/>
	</div>
	
	<div class="layui-form-item layui-form-text">
		<label class="layui-form-label">备注信息</label>
	 	<div class="layui-input-inline" style="width:670px;">
	 		<textarea name="memo" id="memo" class="layui-textarea"></textarea>
	 	</div>
	</div>

	<div class="layui-form-item">
	    <div class="layui-input-block">
	      <button type="submit" class="layui-btn" lay-submit="" lay-filter="ADDCheck">立即提交</button>
	      <button type="reset" class="layui-btn layui-btn-primary" id="ADDCheckReset">重置</button>
	    </div>
  	</div>
	  	
</form>

<script type="text/javascript">

function Today(){
	var now = new Date();
	return now.getFullYear() + "-" + (now.getMonth() + 1) + "-" + now.getDate();
}

var recordingFileid = "";

$(document).ready(function(){
	
});
	
layui.use(['form','upload','laydate'],function(){
	var form = layui.form;
	var upload = layui.upload;
	var layer = layui.layer;
	var laydate = layui.laydate;
	
	laydate.render({
		elem:	'#checkdate',
		max:	Today(),
		trigger:'click'
	});
	
	var choose_files = 0;
	//文件上传
	var listview = $("#filelist");
	var fileidstr = "";
	var uploadListIns = upload.render({
		elem: '#files' //绑定元素
	    ,url: '<c:url value="/newuploadfile1.do"/>' //上传接口
	    ,accept:'file'
	    ,multiple: true
	    ,auto: false
	    ,bindAction:'#upload_files'
	    ,choose: function(obj){
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
	    }
	    ,allDone: function(obj){
	   		$("#attachments").val(fileidstr.substring(0,fileidstr.length-1));
	   		addCheck();
	    }
	    ,error: function(){
	      var tr = listview.find('tr#upload-'+index),
	      tds = tr.children();
	      tds.eq(2).html('<span style="color:#FF5722;">上传失败</span>');
	      tds.eq(3).html('.demo-reload').removeClass('layui-hide');//清空操作
	    }
	});
	
	form.render();
	
	form.on('submit(ADDCheck)',function(data){
		if(choose_files < 1){
			$("#attachments").val("");
			layer.alert("请上传文件");
			return false;
		}else{
			$("#upload_files").click();
		}
		var index1 = top.layer.msg('数据提交中...',{icon:16,time:false,shade:0.8});
		setTimeout(function(){
	   		top.layer.close(index1);
	   	},800);
	  	return false;
	});
	
	function addCheck(){
		$("#form_check").ajaxSubmit({
			url:		'<c:url value="/addCheck.do"/>',
			dataType:	'json',
			async:		false,
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
		 		        //刷新父页面
		 		        //parent.location.reload();
		 		        parent.$("#searchCheck").click();
	               },500);
              	}else{
              		top.layer.msg(obj.msg);
              	}
			},error:function(){
				top.layer.alert("请求失败");
			}
		});
	}
	
});
		
</script>

</body>
</html>
