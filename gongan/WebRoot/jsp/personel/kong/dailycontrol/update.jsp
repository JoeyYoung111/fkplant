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
  		<legend>修改三天一走访</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
		<input type="hidden"  name="personnelid" id="personnelid"  value=${kongdailycontrol.personnelid}></input>
		<input type="hidden"  name="menuid" id="menuid"  value=0></input>
		<input type="hidden"  name="controltype" id="controltype"  value=${kongdailycontrol.controltype}></input>
		<input type="hidden"  name="id" id="id"  value=${kongdailycontrol.id}></input>
		<div class="layui-form-item">
	       	<div class="layui-inline" <c:if test="<%=userSession.getLoginUserRoleid()==1||userSession.getLoginUserRoleid()==32%>">style="pointer-events:none;"</c:if>>
	    		<label class="layui-form-label"><font color="red" size=2>*</font>管控时间：</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="controltime" id="controltime" lay-verify="required" autocomplete="off" placeholder="请选择管控时间" 
	      			class="layui-input"  lay-reqtext="请选择管控时间"  value="${kongdailycontrol.controltime}">
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
	      			 <textarea placeholder="请输入内容" class="layui-textarea" name="controlcontent" style="width:700px;">${kongdailycontrol.controlcontent}</textarea>
	      		</div>
	       	</div>
	     </div>
	      <div class="layui-form-item"> 
	        <label class="layui-form-label">图片上传：</label>
			<div class="layui-input-block" style="width:50%">
           <button type="button" class="layui-btn layui-btn-sm"	id="risk-upload-fileList"><i class="layui-icon"></i>上传多文件</button>
			<font color="red" size="4">*注意仅支持图片格式文件上传</font>
			<button type="button" class="layui-btn layui-hide"	id="risk-upload-fileListAction">开始上传</button>
					<div class="layui-upload">
							<div class="layui-upload-list">
									<table class="layui-table" style="border: 1px solid #eee;">
											<thead>
												<tr>
													<th width="50%">文件名</th>
													<th width="20%">状态</th>
													<th width="30%">操作</th>
														</tr>
												</thead>
											<tbody id="risk-view-fileList"></tbody>
									     </table>
								</div>
						</div>
				</div>
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
	   var riskFilesView=[];	
	$(document).ready(function(){
	    $.ajax({
				type:		'POST',
				 url:		'<c:url value="/getBMByTypeToJSON1.do" />?basicType='+81, 
				 dataType:	'json',
				 async :      false,
				 success:	function(data){					  
				      var options = '<option value="">--请选择---</option>' + fillOption(data);
				      $("select[name^=controlmode]").html(options);
				         $("#controlmode").val("${kongdailycontrol.controlmode}");
				   }
			});
		 
			var filesview=$("#risk-view-fileList");
				filesview.html('');
				var filesname="${kongdailycontrol.filesname}";
				//console.log("filesname="+filesname);
				var filesallname="${kongdailycontrol.filesallname}";
				//console.log("filesallname="+filesallname);
				var fileattachments="${kongdailycontrol.fileattachments}";
				//console.log("fileattachments="+fileattachments);
					    if(filesname !=""){
								riskFilesView=fileattachments.split(",");
								if(riskFilesView.length>0){
									var viewname=filesallname.split(",");
									$.each(riskFilesView,function(index,item){
										var tr = $(['<tr>', '<td>' + viewname[index] +
											'</td>',
											'<td>上传完成</td>', '<td>',
											'<button class="layui-btn layui-btn-sm risk-upload-file-download" onclick="return false;">下载</button>',
											'<button class="layui-btn layui-btn-sm layui-btn-danger risk-upload-file-delete" onclick="return false;">删除</button>',
											'</td>', '</tr>'
										].join(''));
										//删除
										tr.find('.risk-upload-file-delete').on('click', function() {
										    top.layer.confirm('确定删除此文件附件？', function(firm){
												top.layer.close(firm);
												delete riskFilesView[index]; //删除对应的文件
												tr.remove();
											});
										});
										tr.find('.risk-upload-file-download').on('click', function() {
							          		window.location.href='<c:url value="/downUpfile.do"/>?fileid='+item;
										});
										filesview.append(tr);
								});
							}
					}
			
		 });
		layui.use(['form', 'laydate','upload'], function(){
		         var form = layui.form,
		         layer = layui.layer,
		         upload = layui.upload,
		         laydate = layui.laydate;
		         laydate.render({
					    elem: '#controltime'//指定元素
                  });  	
            //多文件列表示例
				var riskFilesListView = $("#risk-view-fileList"),
					riskFiles='',
					riskFilesChoose=0,
					riskFilesBool=false,
					riskFilesUploadListIns = upload.render({
						elem: '#risk-upload-fileList',
		        		url: '<c:url value="/newuploadfile.do"/>',//上传图片地址
					    accept:		'images', //file video audio images 允许的文件类型
		                acceptMine:	'image/*',//规定打开文件选择框时，筛选出的文件类型 acceptMime:'image/*'（只显示图片文件）
						multiple: true,
						auto: false,
						bindAction: '#risk-upload-fileListAction',
						choose: function(obj) {
							var files = this.files = obj.pushFile(); //将每次选择的文件追加到文件队列
							//读取本地文件
							obj.preview(function(index, file, result) {
								var tr = $(['<tr id="risk-file-upload-' + index + '">', '<td>' + file.name +
									'</td>',
									'<td>等待上传</td>', '<td>',
									'<button class="layui-btn layui-btn-sm risk-upload-file-reload layui-hide">重传</button>',
									'<button class="layui-btn layui-btn-sm layui-btn-danger risk-upload-file-delete">删除</button>',
									'</td>', '</tr>'
								].join(''));

								//单个重传
								tr.find('.risk-upload-file-reload').on('click', function() {
									obj.upload(index, file);
								});

								//删除
								tr.find('.risk-upload-file-delete').on('click', function() {
									delete files[index]; //删除对应的文件
									tr.remove();
									riskFilesChoose--;
									riskFilesUploadListIns.config.elem.next()[0].value =
									''; //清空 input file 值，以免删除后出现同名文件不可选
								});
								
								riskFilesChoose++;
								riskFilesListView.append(tr);
							});
						},
						done: function(res, index, upload) {
							if (res.success>0) { //上传成功
								var tr = riskFilesListView.find('tr#risk-file-upload-' + index),
									tds = tr.children();
								tds.eq(1).html('<span style="color: #5FB878;">上传成功</span>');
								tds.eq(2).html(''); //清空操作
								if(riskFiles!="")riskFiles+=",";
								riskFiles+=res.success;
								riskFilesChoose--;
								return delete this.files[index]; //删除文件队列已经上传成功的文件
							}
							this.error(index, upload);
						},
						allDone: function(obj){ //当文件全部被提交后，才触发
						    riskFilesBool=true;
						    //console.log(obj.total); //得到总文件数
						    //console.log(obj.successful); //请求成功的文件数
						    //console.log(obj.aborted); //请求失败的文件数
						},
						error: function(index, upload) {
							var tr = riskFilesListView.find('tr#risk-file-upload-' + index),
								tds = tr.children();
							tds.eq(1).html('<span style="color: #FF5722;">上传失败</span>');
							tds.eq(2).find('.risk-upload-file-reload').removeClass('layui-hide'); //显示重传
						}
					});
		   form.on('submit(roleSub)', function(data){
		           if(riskFilesChoose>0)$('#risk-upload-fileListAction').click();
					else riskFilesBool=true;
					var clearRisk=setInterval(function(){
						if(riskFilesBool){
							var fileattachments=(riskFilesView.length>0?(bouncer(riskFilesView).join(',')+(riskFiles!=""?",":"")):"")+riskFiles;
							//console.log("fileattachments="+fileattachments);
						    $("#form1").ajaxSubmit({
				              	url:		'<c:url value="/updatekongdailycontrol.do"/>',
				              	data:		{
				              					fileattachments:fileattachments
				              				},
				              	dataType:	'json',
				              	async:  	false,
				              	success:	function(data) {
									riskFiles='';
									riskFilesChoose=0;
									riskFilesBool=false;
								   clearInterval(clearRisk);
				                  	var obj = eval('(' + data + ')');
				                  	if(obj.flag>0){
				                  	    //弹出loading
				 		            	var index = top.layer.msg('三日一走访信息提交中，请稍候',{icon: 16,time:false,shade:0.8});
				                     	setTimeout(function(){         
				                     		top.layer.msg(obj.msg);
				                     		top.layer.close(index);
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
					},200);
					return false;
			 });
		});
        function bouncer(array){
          		return array.filter(function(val){
          			return !(!val||val=="");
          		})
          }			
	</script>
  </body>
</html>
