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
    
    <title>下发</title>
    
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
    <script type="text/javascript" src="<c:url value='/js/check.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  </head>
  
  <body>
  	
	<form class="layui-form" method="post" id="form1">
		<input type="hidden"  name="menuid" value=${param.menuid }>
		<input type="hidden"  name="cdtid" value=${param.cdtid }>
		<input type="hidden"  name="wtype" value=${param.wtype }>
		<input type="hidden"  name="receivername" id="receivername">
		<input type="hidden"  name="receivedept" id="receivedept">
		<div class="layui-form-item">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>标题</label>
	    	<div class="layui-input-inline" style="width:52.5%;">
	      		<input type="text" name="wtitle" lay-verify="required" autocomplete="off" placeholder="请输入标题" class="layui-input"  lay-reqtext="标题不能为空">
	    	</div>
	  	</div>
	  	<div class="layui-form-item layui-form-text">
		    <label class="layui-form-label"><font color="red" size=2>*</font>交办内容</label>
		    <div class="layui-input-inline" style="width:52.5%;">
		      <textarea placeholder="请输入内容" class="layui-textarea" name="wcontent"  lay-verify="required"></textarea>
		    </div>
		</div>
	  	<div class="layui-form-item layui-form-text">
	  		<label class="layui-form-label">接收单位</label>
	  		<div class="layui-input-inline" style="width:52.5%;">
				<input type="text" id="receivedeptid" name="receivedeptid" lay-filter="receivedeptid" class="layui-input">
			</div>
		</div>
		<div class="layui-form-item layui-form-text">
	  		<label class="layui-form-label"><font color="red" size=2>*</font>接收人</label>
	  		<div class="layui-input-inline" style="width:52.5%;">
				<select id="receiverid"  name="receiverid" lay-filter="receiverid" lay-verify="required" lay-verType="tips">
			 		<option value="">--请选择接收人--</option>
			 	</select>
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
		      <button type="reset" id="reset"  class="layui-btn layui-btn-primary">重置</button>
		    </div>
	  	</div>
	</form>
	<script type="text/javascript">
		layui.config({
		    base: "<c:url value="/layui/lay/modules/"/>"
		}).extend({
		    treeSelect: "treeSelect"
		});
		
		var layer;
		layui.use(['form','treeSelect','upload'], function(){
			var form = layui.form,
			layer = layui.layer,
			upload = layui.upload,
			treeSelect = layui.treeSelect;
		    
		    treeSelect.render({
		        elem: '#receivedeptid', // 选择器
		        data: '<c:url value="/getDepartmentTree.do"/>',// 数据
		        type: 'get', // 异步加载方式：get/post，默认get
		        placeholder: '请选择接收单位：', // 占位符
		        search: true, // 是否开启搜索功能：true/false，默认false
		        // 一些可定制的样式
		        style: {
		            folder: { enable: false },
		            line: {  enable: true}
		        },
		        click: function(d){   // 点击回调
		        	$('#receivedept').val(d.current.name);
		        	$.ajax({
						type:		'POST',
						url:		'<c:url value="/getUsersByDepartmentid.do"/>',
						data:		{departmentid:d.current.id},
						dataType:	'json',
						success:	function(data){
		           			var options = fillOption(data);
		           			$("#receiverid").empty();
		           			$('#receiverid').append(options);
		      				form.render("select");
						}
					});
		        },
		        // 加载完成后的回调函数
		        success: function (d) {
					//获取zTree对象，可以调用zTree方法
               		var treeObj = treeSelect.zTree('receivedeptid');
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
			
			form.on('select(receiverid)', function(data){
				$("#receivername").val(data.elem[data.elem.selectedIndex].text);
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
			
				$("#reset").click(function () {
				     $("#receiverid").empty();
				      $('form')[0].reset();
				     
				});	
		  });
		  
		function add(){
			$("#form1").ajaxSubmit({
              	url:		'<c:url value="/addWorkInfo.do"/>',
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
	 		        //刷新父页面
	 		        if(${param.wtype }==1){
	 		        	parent.formSubmit('tsd','<c:url value="searchWorkInfo.do"/>');
	 		        }else if(${param.wtype }==2){
	 		        	parent.formSubmit('jbd','<c:url value="searchWorkInfo.do"/>?wtype=${param.wtype }');
	 		        }else if(${param.wtype }==3){
	 		        	parent.formSubmit('dbd','<c:url value="searchWorkInfo.do"/>?wtype=${param.wtype }');
	 		        }else{
	 		        	parent.formSubmit('jyh','<c:url value="searchWorkInfo.do"/>?wtype=${param.wtype }');
	 		        }
	 		        parent.layer.closeAll("iframe");
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
