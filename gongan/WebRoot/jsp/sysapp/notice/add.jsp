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
    <base href="<%=basePath%>">
    
    <title>添加通知公告页面</title>
    
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/layui/lay/modules/form.js"/>"></script>
  </head>
  
  <body>
  	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  		<legend id="typeName">添加通知公告</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
		<input type="hidden"  name="menuid" value=${param.menuid }>
		<div class="layui-row">
			<div class="layui-form-item">
				<div class="layui-col-md6">
					<div class="layui-col-md1 layui-col-md-offset1">
			    		<label class="layui-form-label"><font color="red" size=2>*</font>类型</label>
			    	</div>
			    	<div class="layui-col-md10">
				    	<div class="layui-input-block">
				      		<select id="noticetype"  name="noticetype" style="width:170px;" lay-verify="required" lay-verType="tips">
						 		<option value="">--请选择类型--</option>
						        <option value="通知">通知</option>
						        <option value="公告">公告</option>
						        <option value="知识">知识</option>
						 	</select>
				    	</div>
			    	</div>
		    	</div>
		    	<div class="layui-col-md6">
		    		<div class="layui-col-md1 layui-col-md-offset1">
			    		<label class="layui-form-label"><font color="red" size=2>*</font>标题</label>
			    	</div>
			    	<div class="layui-col-md10">
			    		<div class="layui-input-block">
				    		<input type="text" name="noticetitle" lay-verify="required" autocomplete="off" placeholder="请输入标题" class="layui-input"  lay-reqtext="标题不能为空">
				    	</div>
			    	</div>
		    	</div>
		  	</div>
		  	<div class="layui-form-item">
		  		<div class="layui-col-md12">
		  			<div class="layui-col-md1">
		  				<div class="layui-col-md6 layui-col-md-offset6">
		  					<label class="layui-form-label">通知内容</label>
		  				</div>
		  			</div>
		  			<div class="layui-col-md11">
					    <div class="layui-input-block">
					      <textarea placeholder="请输入内容" class="layui-textarea" name="noticetext" id="noticetext"></textarea>
					    </div>
				    </div>
		  		</div>
		  	</div>
		  	<div class="layui-form-item">
				<div class="layui-col-md12">
		  			<div class="layui-col-md1">
		  				<div class="layui-col-md6 layui-col-md-offset6">
		  					<label class="layui-form-label">发送部门</label>
		  				</div>
		  			</div>
		  			<div class="layui-col-md11">
					    <div class="layui-input-block">
					    	<div id="departids"></div>
					    </div>
				    </div>
		  		</div>
			</div>
			<div class="layui-form-item">
				<div class="layui-col-md12">
		  			<div class="layui-col-md1">
		  				<div class="layui-col-md6 layui-col-md-offset6">
							<label class="layui-form-label">文件</label>
						</div>
		  			</div>
		  			<div class="layui-col-md11">
		  				<div class="layui-input-block">
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
		  			</div>
		  			<input type="hidden" name="attachments" id="attachments" value="" class="layui-input" />
		  		</div>
			</div>
		</div>
		<div class="layui-form-item layui-col-md3 layui-col-lg-offset5">
			<div class="layui-input-block">
				<button type="submit" class="layui-btn" lay-submit="" lay-filter="msgSub">立即提交</button>
		      	<button type="reset" class="layui-btn layui-btn-primary">重置</button>
			</div>
		</div>
	</form>
    
	<script type="text/javascript">
		layui.config({
		    base: "<c:url value="/layui/lay/modules/"/>"
		}).extend({
		    zTreeSelectM: "zTreeSelectM/zTreeSelectM"
		});
		
		layui.use(['form','layedit','zTreeSelectM','upload'], function(){
			var form = layui.form;
			var layedit = layui.layedit;
			var layer = layui.layer;
			var zTreeSelectM = layui.zTreeSelectM;
			var upload = layui.upload;
			
			var index = layedit.build('noticetext',{
				tool: [ 'strong','italic','underline','del' ,'|','left','center','right','link','unlink','image','face'],
			});
			
			//初始化发送部门
			var _zTreeSelectM = zTreeSelectM({
			    elem: '#departids',//元素容器【必填】          
			    data: '<c:url value="/getDepartmentTree.do"/>',
			    type: 'get',  //设置了长度    
			    selected: [],//默认值            
			    max: 5,//最多选中个数，默认5            
			    name: 'departids',//input的name 不设置与选择器相同(去#.)
			    delimiter: ',',//值的分隔符           
			    field: { idName: 'id', titleName: 'name' },//候选项数据的键名
			    zTreeSetting: { //zTree设置
			        check: {
			            enable: true,
			            chkboxType: { "Y": "", "N": "" }
			        },
			        data: {
			            simpleData: {
			                enable: false
			            },
			            key: {
			                name: 'name',
			                children: 'children'
			            }
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
			
			function add(){
				$("#form1").ajaxSubmit({
	              	url:		'<c:url value="/addNotice.do"/>',
	              	dataType:	'json',
	              	data:		{noticetext:layedit.getContent(index)},
	              	async:  	false,
	              	success:	function(data) {
	              		var obj = eval('(' + data + ')');
                  		if(obj.flag>0){
                  			top.layer.msg(obj.msg);
                  			layer.closeAll("iframe");
                  			parent.layer.closeAll("iframe");
                  			parent.formSubmit();
                  		}else{
                  	 		layer.msg(obj.msg);
                		}
	                }
	          	});
          	}
		});
	</script>
  </body>
</html>
