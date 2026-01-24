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
    
    <title>添加情报线索信息页面</title>
    
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  </head>
  
  <body>
  	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;overflow:auto">
  		<legend id="typeName">添加情报线索信息</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
		<input type="hidden"  name="menuid" value=${param.menuid }>
		<input type="hidden"  name="cdtid" value=${param.cdtid }>
		<input type="hidden"  id="workinfoid" name="workinfoid" value=0>
		<div class="layui-form-item">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>线索标题</label>
	    	<div class="layui-input-inline" style="width:52.5%;">
	      		<input type="text" name="ltitle" lay-verify="required" lay-verType="tips" autocomplete="off" placeholder="请输入线索标题" class="layui-input"  lay-reqtext="线索标题不能为空">
	    	</div>
	  	</div>
	  	<div class="layui-form-item">
			<label class="layui-form-label"><font color="red" size=2>*</font>线索指向</label>
	    	<div class="layui-input-inline" style="width:20%;">
				<select id="lpointto"  name="lpointto" lay-verify="required" lay-verType="tips">
			 		<option value="">--请选择--</option>
			 		<option value="来市">来市</option>
			 		<option value="去锡">去锡</option>
			 		<option value="赴省">赴省</option>
			 		<option value="进京">进京</option>
			 		<option value="其他">其他</option>
			 	</select>
			</div>
	    	<label class="layui-form-label" style="width:10%;"><font color="red" size=2>*</font>线索来源</label>
	    	<div class="layui-input-inline" style="width:20%;">
				<select id="lsource"  name="lsource" lay-verify="required" lay-verType="tips">
			 		<option value="">--请选择--</option>
			 		<option value="网上监测">网上监测</option>
			 		<option value="电话监控">电话监控</option>
			 		<option value="人力情报">人力情报</option>
			 		<option value="其他">其他</option>
			 	</select>
			</div>
	  	</div>
	  	<div class="layui-form-item layui-form-text">
		    <label class="layui-form-label"><font color="red" size=2>*</font>线索内容</label>
		    <div class="layui-input-inline" style="width:52.5%;">
		      <textarea placeholder="请输入内容" class="layui-textarea" name="lcontent" lay-verify="required" lay-verType="tips"></textarea>
		    </div>
		</div>
	  	<div class="layui-form-item">
			<label class="layui-form-label"><font color="red" size=2>*</font>预计发生时间</label>
	    	<div class="layui-input-inline" style="width:52.5%;">
				<input type="text" class="layui-input" id="ldate" name="ldate" lay-verify="required" lay-verType="tips" autocomplete="off">
			</div>
	  	</div>
	  	<div class="layui-form-item">
			<label class="layui-form-label"><font color="red" size=2>*</font>线索处置</label>
	    	<div class="layui-input-inline" style="width:52.5%;">
				<select id="xscz"  name="xscz" lay-verify="required" lay-verType="tips">
			 		<option value="">--请选择--</option>
			 		<option value="已发生">已发生</option>
			 		<option value="未发生">未发生</option>
			 	</select>
			</div>
	  	</div>
	  	<div class="layui-form-item layui-form-text">
		    <label class="layui-form-label"><font color="red" size=2>*</font>处置情况概述</label>
		    <div class="layui-input-inline" style="width:52.5%;">
		      <textarea placeholder="请输入内容" class="layui-textarea" name="czqkgs" lay-verify="required" lay-verType="tips"></textarea>
		    </div>
		</div>
		<div class="layui-form-item layui-form-text">
		    <label class="layui-form-label">关联事件名称</label>
		    <div class="layui-input-inline" style="width:52.5%;z-index:1;">
		    	<input type="hidden" name="conneteventid" id="conneteventid" value="0">
		    	<input type="text" id="conneteventname" name="conneteventname" autocomplete="off" placeholder="请添加关联事件" class="layui-input" readonly="readonly">
		    </div>
		    <span style="z-index:2;position:absolute;margin-left:-60px;margin-top:6px;">
		    	<i class="layui-icon" style="font-size: 20px; color: #1E9FFF;" onclick="addConnetevent();">&#xe64c;</i>
		    </span>
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
			  elem: '#ldate', //指定元素
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
		  			if($("#xscz").val()=="已发生"){
		    		if($("#conneteventid").val()>0){
		    			$("#form1").ajaxSubmit({
			              	url:		'<c:url value="/addLeadsInfo.do"/>',
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
				 		         		parent.layer.closeAll("iframe");
				 		         		if("${param.page}"=="feedback"){
				 		         			parent.formSubmit();
						        			parent.parent.parent.formSubmit('qbxs','<c:url value="searchLeadsInfo.do"/>');
				 		         		}else{
				 		         			parent.formSubmit('qbxs','<c:url value="searchLeadsInfo.do"/>');
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
		    		}else{
		    			layer.alert("已发生事件必须关联引发涉稳事件！");
		    		}
		    	}else{
		    		$("#form1").ajaxSubmit({
		              	url:		'<c:url value="/addLeadsInfo.do"/>',
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
			 		         		parent.layer.closeAll("iframe");
			 		         		if("${param.page}"=="feedback"){
			 		         			parent.formSubmit();
					        			parent.parent.parent.formSubmit('qbxs','<c:url value="searchLeadsInfo.do"/>');
			 		         		}else{
			 		         			parent.formSubmit('qbxs','<c:url value="searchLeadsInfo.do"/>');
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
		    	}
		        return false;
			  }
		  });
		  
		function addConnetevent(){
			if($("#conneteventid").val()==0){
				var index = layui.layer.open({
							title : "添加引发涉稳事件",
							type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
							content : '<c:url value="/jsp/event/contradictionInfo/eventsInfo/add.jsp"/>?menuid=${param.menuid }&cdtid=${param.cdtid}&fxdj=${param.fxdj }&page=qbxs&workinfoid='+$("#workinfoid").val(),
							area: ['800', '800px'],
							maxmin: true,
							success : function(layero, index){
								setTimeout(function(){
									layui.layer.tips('点击此处返回文章列表', '.layui-layer-setwin .layui-layer-close', {
										tips: 3
									});
								},500)
							}
						})			
						layui.layer.full(index);
			}else{
				var index = layui.layer.open({
								title : "修改引发涉稳事件",
								type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
								content : '<c:url value="getEventsInfo.do"/>?id='+$("#conneteventid").val()+'&menuid=${param.menuid }&page=qbxs',
								area: ['800', '800px'],
								maxmin: true,
								success : function(layero, index){
									setTimeout(function(){
										layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
											tips: 3
										});
									},500)
								}
							})			
							layui.layer.full(index);
			}
		}
	</script>
  </body>
</html>
