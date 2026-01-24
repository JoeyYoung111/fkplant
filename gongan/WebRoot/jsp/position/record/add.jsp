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
	 <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  
  
  <body>
   <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  		<legend>添加民警工作记载</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
		<input type="hidden"  name="recordtype" id="recordtype"  value="${param.recordtype}"></input>
		<input type="hidden"  name="recordid" id="recordid"  value="${param.recordid}"></input>
		<input type="hidden"  name="menuid" id="menuid"  value=${param.menuid}></input>
		<div class="layui-form-item">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>工作方式</label>
	    	<div class="layui-input-inline">
	    		<select id="worktype" name="worktype" lay-verify="required" lay-reqtext="请选择工作方式" autocomplete="off" lay-verType="tips">
					<option value=""> --- 请选择工作方式 --- </option>
				</select>
	    	</div>
	    	<label class="layui-form-label"><font color="red" size=2>*</font>时间</label>
	    	<div class="layui-input-inline">
	      		<input type="text" name="worktime" id="worktime" readonly lay-verify="required" lay-reqtext="请选择工作时间" autocomplete="off" placeholder="年-月-日" class="layui-input">
	    	</div>
	  	</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>地点</label>
	    	<div class="layui-input-inline">
	      		<input type="text" name="workplace" lay-verify="required" autocomplete="off" lay-reqtext="请填写工作地点" class="layui-input" style="width:660px;">
	    	</div>
	  	</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>工作记录</label>
	    	<div class="layui-input-inline">
	      		<textarea placeholder="何时、何地以何种方式做出的工作记录详情。" lay-reqtext="请填写工作记录" lay-verify="required" class="layui-textarea" name="workrecord" style="width:660px;"></textarea>
	    	</div>
	  	</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label">文件附件</label>
	    	<div class="layui-input-inline">
	      		<button type="button" class="layui-btn layui-btn-sm" id="upload-fileList"><i class="layui-icon"></i>上传多文件</button>
				<button type="button" class="layui-btn layui-hide" id="upload-fileListAction">开始上传</button>
				<input type="hidden" name="fileattachments" id="fileattachments" value=""/>
	    	</div>
	  	</div>
		<div class="layui-form-item">
			<label class="layui-form-label"></label>
			<div class="layui-input-inline">
				<div class="layui-upload">
					<div class="layui-upload-list">
						<table class="layui-table" style="border: 1px solid #eee; width:660px;">
							<thead>
								<tr>
									<th width="30%">文件名</th>
									<th width="20%">状态</th>
									<th width="25%">上传时间</th>
									<th width="25%">操作</th>
								</tr>
							</thead>
							<tbody id="view-fileList"></tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		    <div class="layui-input-block">
		      <button type="submit" class="layui-btn" lay-submit="" lay-filter="roleSub">立即提交</button>
		      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
		    </div>
	  	</div>
	</form>
	<script type="text/javascript">
		function getworktype(){
			$.ajax({
				type:		'POST',
				url:		'<c:url value="/getBMByTypeToJSON.do?basicType="/>'+105,
				dataType:	'json',
				async:      false,
				success:	function(data){
					var options="";
					$.each(data.list, function(i, item) {
						$.each(item, function(i) {
							options += '<option value="' + this.text + '">' + this.text + '</option>';
						});
					});
					$("#worktype").append(options);
				}
			});
		}
		$(document).ready(function(){
			getworktype();
       	});
		
		layui.use(['form', 'laydate', 'upload'], function(){
		         var form = layui.form,
		         layer = layui.layer,
		         laydate = layui.laydate,
		         upload = layui.upload;
		   laydate.render({
		   	elem:'#worktime'
		   	,format:  'yyyy-MM-dd'
		  });
		  form.render();
		  
		  // 文件上传功能
		  var filesListView = $("#view-fileList"),
				files='',
				filesChoose=0,
				filesBool=false,
				filesUploadListIns = upload.render({
					elem: '#upload-fileList',
					url: '<c:url value="/newuploadfile1.do"/>',
					accept: 'file',
					multiple: true,
					auto: false,
					bindAction: '#upload-fileListAction',
					choose: function(obj) {
						var files = this.files = obj.pushFile(); //将每次选择的文件追加到文件队列
						//读取本地文件
						obj.preview(function(index, file, result) {
							var tr = $(['<tr id="file-upload-' + index + '">', '<td>' + file.name +
								'</td>',
								'<td>等待上传</td>', '<td></td>', '<td>',
								'<button class="layui-btn layui-btn-sm upload-file-reload layui-hide">重传</button>',
								'<button class="layui-btn layui-btn-sm layui-btn-danger upload-file-delete">删除</button>',
								'</td>', '</tr>'
							].join(''));
		
							//单个重传
							tr.find('.upload-file-reload').on('click', function() {
								obj.upload(index, file);
							});
		
							//删除
							tr.find('.upload-file-delete').on('click', function() {
								delete files[index]; //删除对应的文件
								tr.remove();
								filesChoose--;
								filesUploadListIns.config.elem.next()[0].value =
								''; //清空 input file 值，以免删除后出现同名文件不可选
							});
							
							filesChoose++;
							filesListView.append(tr);
						});
					},
					done: function(res, index, upload) {
						if (res.success>0) { //上传成功
							var tr = filesListView.find('tr#file-upload-' + index),
								tds = tr.children();
							tds.eq(1).html('<span style="color: #5FB878;">上传成功</span>');
							var now = new Date();
							var time = now.getFullYear() + '-' + (now.getMonth()+1) + '-' + now.getDate() + ' ' + 
									now.getHours() + ':' + now.getMinutes() + ':' + now.getSeconds();
							tds.eq(2).html(time); //显示上传时间
							tds.eq(3).html(''); //清空操作
							if(files!="")files+=",";
							files+=res.success;
							$("#fileattachments").val(files);
							filesChoose--;
							return delete this.files[index]; //删除文件队列已经上传成功的文件
						}
						this.error(index, upload);
					},
					allDone: function(obj){ //当文件全部被提交后，才触发
						filesBool=true;
					},
					error: function(index, upload) {
						var tr = filesListView.find('tr#file-upload-' + index),
							tds = tr.children();
						tds.eq(1).html('<span style="color: #FF5722;">上传失败</span>');
						tds.eq(3).find('.upload-file-reload').removeClass('layui-hide'); //显示重传
					}
				});
		   form.on('submit(roleSub)', function(data){
		     // 检查是否有文件需要上传
		     if(filesChoose > 0){
		         // 触发上传
		         $("#upload-fileListAction").click();
		         layer.msg('正在上传文件，请稍候...', {icon: 16, time: false, shade: 0.2});
		         
		         // 使用定时器检查文件是否全部上传完成
		         var checkUploadStatus = function() {
		             if(filesBool) {
		                 // 所有文件已上传完成
		                 filesBool = false; // 重置状态
		                 submitForm();
		             } else {
		                 // 继续等待
		                 setTimeout(checkUploadStatus, 200);
		             }
		         };
		         
		         // 开始检查上传状态
		         setTimeout(checkUploadStatus, 200);
		         return false;
		     }
		     submitForm();
		     return false;
		 });
		 
		 // 表单提交函数
		 function submitForm(){
		     $("#form1").ajaxSubmit({
		      	url:		'<c:url value="/addWorkRecord.do"/>',
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
		         		if("${param.recordtype}"=="personel")parent.$("#tabWorkRecord").click();
		         		else parent.$("#recordbutton").click();
		         		parent.layer.closeAll("iframe");
		           	},2000);
		         	}else{
		          	 	top.layer.msg(obj.msg);
		        	}
		     	},
		      	error:function() {
		          	top.layer.alert("请求失败！");
		      	}
		  	});
		 }
	           	return false;
			
		});
	</script>
  </body>
</html>
