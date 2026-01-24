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
    
    <title>修改页面</title>
    
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/cardnumber.js"/>"></script>
  </head>
  
  <body>
  	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  		<legend>修改风险物品</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
		<input type="hidden"  name="menuid" value="${menuid}">
		<input type="hidden"  name="id" value="${dangerousItem.id}" />
		<div class="layui-form-item">
			<label class="layui-form-label"><font color="red" size=2>*</font>物品品种</label>
	    	<div class="layui-input-inline" style="width:20%;">
				<select id="itemtype" name="itemtype" lay-filter="itemtype" autocomplete="off" lay-verify="required" lay-verType="tips" lay-reqtext="请选择物品品种">
					<option value="" selected> --- 请选择物品品种 --- </option>
				</select>
	    	</div>
	    	<label class="layui-form-label"  style="width:10%;"><font color="red" size=2>*</font>物品型号</label>
	    	<div class="layui-input-inline" style="width:20%;" lay-verify="goodscode">
	    		<input type="text" id="goodscode" name="goodscode" lay-filter="goodscode" class="layui-input" autocomplete="off">
			</div>
	  	</div>
	  	<div class="layui-form-item">
			<label class="layui-form-label">案件名称</label>
	    	<div class="layui-input-inline" style="width:20%;">
	      		<input type="text" id="casename" name="casename" autocomplete="off" class="layui-input" value="${dangerousItem.casename}">
	    	</div>
	    	<label class="layui-form-label" style="width:10%;">唯一标识码</label>
	    	<div class="layui-input-inline" style="width:20%;">
				<input type="text" id="codenum" name="codenum" autocomplete="off" class="layui-input" readonly="readonly;" value="${dangerousItem.codenum}">
			</div>
	  	</div>
	  	<div class="layui-form-item layui-form-text">
		    <label class="layui-form-label">收缴日期</label>
	    	<div class="layui-input-inline" style="width:20%;">
	    		<input type="text" class="layui-input" id="sjdate" name="sjdate" lay-verify="required" lay-verType="tips" autocomplete="off">
	    	</div>
	    	<label class="layui-form-label" style="width:10%;">收缴单位</label>
	    	<div class="layui-input-inline" style="width:20%;">
				<input type="text" id="sjgov" name="sjgov" autocomplete="off" class="layui-input" value="${dangerousItem.sjgov}">
			</div>
		</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label">收缴民警</label>
	    	<div class="layui-input-inline" style="width:20%;">
	    		<input type="text" class="layui-input" id="sjmj" name="sjmj" value="${dangerousItem.sjmj}">
	    	</div>
	    	<label class="layui-form-label" style="width:10%;">收缴方式</label>
	    	<div class="layui-input-inline" style="width:20%;">
				<select id="sjfs"  name="sjfs" lay-verify="required" lay-verType="tips">
			 		<option value="">--请选择收缴方式--</option>
			 	</select>
			</div>
	  	</div>
	  	<div class="layui-form-item">
			<label class="layui-form-label">物品数量</label>
	    	<div class="layui-input-inline" style="width:20%;">
	      		<input type="text" id="sl" name="sl" autocomplete="off" class="layui-input" value="${dangerousItem.sl}">
	    	</div>
	    	<label class="layui-form-label" style="width:10%;">物品存放位置</label>
	    	<div class="layui-input-inline" style="width:20%;">
				<input type="text" id="position" name="position" autocomplete="off" class="layui-input" value="${dangerousItem.position}">
			</div>
	  	</div>
	  	<div class="layui-form-item">
			<label class="layui-form-label">收缴对象</label>
	    	<div class="layui-input-inline" style="width:20%;">
	      		<input type="text" id="sjdx" name="sjdx" autocomplete="off" class="layui-input" value="${dangerousItem.sjdx}">
	    	</div>
	    	<label class="layui-form-label" style="width:10%;">身份证号</label>
	    	<div class="layui-input-inline" style="width:20%;">
				<input type="text" id="dxsfz" name="dxsfz" autocomplete="off" class="layui-input" lay-verify="cardnumber" lay-verType="tips" value="${dangerousItem.dxsfz}">
			</div>
	  	</div>
		<div class="layui-form-item layui-form-text">
		    <label class="layui-form-label">处置结果</label>
		    <div class="layui-input-block">
		      <textarea placeholder="请输入处置结果" class="layui-textarea" name="result">${dangerousItem.result}</textarea>
		    </div>
		</div>
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
		    			<tbody id="filelist">
		    				<c:if test="${not empty dangerousItem.filenames}">
			    				<c:set value="${fn:split(dangerousItem.filenames,',') }" var="filenames"></c:set>
			    				<c:set value="${fn:split(dangerousItem.fileids,',') }" var="fileids"></c:set>
			    				<c:forEach items="${filenames}" var="filename" varStatus="num">
				    				<tr id="upload">
				    					<td id="showfiles"><a href="<c:url value='/downUpfile.do' />?fileid=${fileids[num.index] }" class="layui-table-link">${filename }</a></td>
				    					<td>上传完成</td>
				    					<td>
				    						<button class="layui-btn layui-btn-xs layui-btn-danger demo-deletes" type="button" onclick="cancelfiles(${fileids[num.index] },this);">删除</button>
				    					</td>
				    				</tr>
				    			</c:forEach>
			    			</c:if>
		    			</tbody>
		    		</table>
		    	</div>
		    </div>
		    <input type="hidden" name="attachments" id="attachments" class="layui-input" value="${dangerousItem.attachments }"/>
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
		layui.config({
		    base: "<c:url value="/layui/lay/modules/"/>"
		}).extend({
		    treeSelect: "treeSelect"
		});
		
		var fileidstr = "${dangerousItem.attachments }";
		var delidstr = "";
		$("input[name='sjdx']")[0].readOnly=true;
		layui.use(['form', 'laydate','upload','treeSelect'], function(){
			var form = layui.form,
			layer = layui.layer,
			upload = layui.upload,
			treeSelect = layui.treeSelect,
			laydate = layui.laydate;
		  	
		  	laydate.render({
			  elem: '#sjdate', //指定元素
			  value: '${dangerousItem.sjdate }'
			});
			
			form.verify({
					 cardnumber:function(value,item){
					  		var validator = new IDValidator();
					  		if(value!=""&&!validator.isValid(value)){
					  			return "身份证号存在错误";
					  		}
					 },
					 goodscode:function(value,item){
					  		if(!$("#goodscode").val()||$("#goodscode").val()=="0"){
					  			return "请选择物品型号";
				    		}
					 }
		  	});
		
			//初始化收缴方式
			$.ajax({
				type:		'POST',
				url:		'<c:url value="/getbasicMsgJSON.do"/>?basicType=108',
				dataType:	'json',
				success:	function(data){
	          			$.each(data, function(num, item) {
	          				if(item.name=="${dangerousItem.sjfs}"){
	          					$('#sjfs').append('<option value="' + item.name + '" selected>' + item.name + '</option>');
	          				}else{
	          					$('#sjfs').append('<option value="' + item.name + '">' + item.name + '</option>');
	          				}
	         			});
	     				form.render("select");
				}
			});
			
			var choose_files = 0;
  
			//文件上传
			var listview = $("#filelist");
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
			    if(fileidstr==""){
			    	fileidstr += recordingFileid;
			    }else{
			    	fileidstr += "," + recordingFileid;
			    }
			    console.log("文件上传成功");
			  }
			  ,allDone: function(obj){
			 		$("#attachments").val(fileidstr);
			 		add();
			  }
			  ,error: function(){
			    var tr = listview.find('tr#upload-'+index),
			    tds = tr.children();
			    tds.eq(2).html('<span style="color:#FF5722;">上传失败</span>');
			    tds.eq(3).html('.demo-reload').removeClass('layui-hide');//清空操作
			   
			  }
			});
			
			form.on('select(itemtype)', function(data){
			  	var parentid = $('#itemtype').find("option:selected").attr("typeid");
			  	if($('#goodscode').next().length!=0){
			  		treeSelect.destroy("goodscode");
			  		$("#goodscode").val("0");
			  		/*控件有问题，只调一遍下拉事件会锁死*/
			  		treeSelect.render({
						        elem: '#goodscode',
						        data: '<c:url value="/getMsgByid.do" />?parentid='+parentid,
						        type: 'get',
						        placeholder: '请选择物品型号：',				//修改默认提示信息
						        search: true,								// 是否开启搜索功能：true/false，默认false
						        style: {
						            folder: {enable: true},
						            line: {enable: true}
						        },
						        click: function(d){
						       		// 点击回调
						        },
						        success: function (d) {
						  			treeSelect.destroy("goodscode");
						   			form.render();
						   			treeSelect.render({
								        elem: '#goodscode',
								        data: '<c:url value="/getMsgByid.do" />?parentid='+parentid,
								        type: 'get',
								        placeholder: '请选择物品型号：',				//修改默认提示信息
								        search: true,								// 是否开启搜索功能：true/false，默认false
								        style: {
								            folder: {enable: true},
								            line: {enable: true}
								        },
								        click: function(d){
								       		// 点击回调
								        },
								        success: function (d) {
								  			form.render();
								        }
								    });
						        }
						    });
			  		form.render();
			  	}else{
			  		treeSelect.render({
				        elem: '#goodscode',
				        data: '<c:url value="/getMsgByid.do" />?parentid='+parentid,
				        type: 'get',
				        placeholder: '请选择物品型号：',				//修改默认提示信息
				        search: true,								// 是否开启搜索功能：true/false，默认false
				        style: {
				            folder: {enable: true},
				            line: {enable: true}
				        },
				        click: function(d){
				       		// 点击回调
				        },
				        success: function (d) {
				  			form.render();
				        }
				    });
			  	}
			});
		    
		    form.on('submit(msgSub)', function(data){
		  		var index1 = top.layer.msg('信息上传中，请稍后',{icon:16,time:false,shade:0.8});
				if(choose_files < 1){
					$("#attachments").val(fileidstr);
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
	              	url:		'<c:url value="/updateDangerousItem.do"/>',
	              	dataType:	'json',
	              	async:  false,
	              	success:	function(data) {
	                  	if(data.flag>0){
	                  	    //弹出loading
	 		            	var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
	                     	setTimeout(function(){         
	                     		top.layer.msg(data.msg);
	                     		top.layer.close(index);
				        		layer.closeAll("iframe");
		 		        		//刷新父页面
		 		         		parent.location.reload();
	                   		},2000);
	                 	}else{
	                  	 	layer.msg(data.msg);
	                	}
	             	},
	              	error:function() {
	                  	layer.alert("请求失败！");
	              	}
	          	});
		        return false;
			  }
			  
			  $('#dxsfz').blur(function(){
			  	var validator = new IDValidator();
			  	if(this.value.length>14&&!validator.isValid(this.value)){
			  		//身份证号存在错误
			  		top.layer.alert("身份证号存在错误！");
			  	}else{
			  		$.ajax({
						type:		'POST',
						url:		'<c:url value="/checkPersonnelCardnumber.do"/>',
						data:		{cardnumber :  this.value},
						dataType:	'json',
						async:      false,
						success:	function(data){
							if(data.flag){
								//数据库中存在，填入名字并改为不能写入
								$('#sjdx').val(data.personnel.personname);
								$("input[name='sjdx']")[0].readOnly=true;
							}else{
								//查询一标三实
								$.ajax({
									type:		'POST',
									url:		'<c:url value="/findYbssRkByCardnumber.do"/>',
									data:		{cardnumber :  $('#dxsfz').val()},
									dataType:	'json',
									async:      false,
									success:	function(tbssflag){
										if(tbssflag.flag){
											//数据库中存在，填入名字并改为不能写入
											$('#sjdx').val(tbssflag.ybssPersonnel.personname);
											$("input[name='sjdx']")[0].readOnly=true;
											$('#ybssid').val(tbssflag.ID);
										}else{
											//数据库里没有
											$("input[name='sjdx']")[0].readOnly=false;
											$('#sjdx').val("");
											if($('#sjdx').val()==""){
												top.layer.alert("该人员不存在于数据库中，请输入治安人员姓名！");
											}
										}
									}
								});
							}
						}
					});
			  	}
			  });
			  
			  function getitemtype(){
				$.ajax({
					type:		'POST',
					url:		'<c:url value="/getBMByparenttype.do"/>?basicType=106&parentid=0',
					dataType:	'json',
					async:      false,
					success:	function(data){
						var options="";
						$.each(data, function(i, item) {
							$.each(item, function(i1,item1) {
								$.each(item1, function(i2,item2) {
									if(item2.text=="${dangerousItem.itemtype}"){
										options += '<option value="' + item2.text + '" typeid="' + item2.value + '" selected>' + item2.text + '</option>';
									}else{
										options += '<option value="' + item2.text + '" typeid="' + item2.value + '">' + item2.text + '</option>';
									}
								});
							});
						});
						$("#itemtype").append(options);
						var parentid = $('#itemtype').find("option:selected").attr("typeid");
						treeSelect.render({
					        elem: '#goodscode',
					        data: 'getMsgByid.do?parentid='+parentid,
					        type: 'get',
					        placeholder: '请选择物品型号：',				//修改默认提示信息
					        search: true,								// 是否开启搜索功能：true/false，默认false
					        style: {
					            folder: {enable: true},
					            line: {enable: true}
					        },
					        click: function(d){
					       		// 点击回调
					        },
					        success: function (d) {
			               		if(${dangerousItem.goodscode}>0){
					        		treeSelect.checkNode('goodscode', ${dangerousItem.goodscode});
									//获取zTree对象，可以调用zTree方法
				               		var treeObj = treeSelect.zTree('goodscode');
									//刷新树结构
				                	treeSelect.refresh('goodscode');
					        	}
					        }
					    });
					  	form.render();
					}
				});
			}
			getitemtype();
		  });

		function cancelfiles(id,obj){
				var fileids = fileidstr.split(",");
				delidstr += id + ",";
				var newfileids = "";
				for(var i=0;i<fileids.length;i++){
					if(fileids[i]!=id){
						newfileids += fileids[i]+",";
					}
				}
				fileidstr = newfileids.substring(0,newfileids.length-1);
				var dom = obj.parentNode.parentNode;
				dom.remove();
			}
	</script>
  </body>
</html>
