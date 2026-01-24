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
	<link rel="stylesheet" href="<c:url value="/layui/lay/modules/formSelects/formSelects-v4.css"/>" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/cardnumber.js"/>"></script>
  <body>
   <fieldset class="layui-elem-field layui-field-title">
  		<legend>新增联控记录</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
		<input type="hidden"  name="personnelid" id="personnelid"  value=${param.personnelid}></input>
		<input type="hidden"  name="menuid" id="menuid"  value=${param.menuid}></input>
		<div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label" style="width: 140px;"><font color="red" size=2>*</font>情报内容来源</label>
	    		<div class="layui-input-inline">
	      			<select id="jointorigin"  name="jointorigin" style="width:170px;" lay-verify="required" lay-verType="tips"></select>
	      		</div>
	       	</div>
	      <div class="layui-inline">
	    		<label class="layui-form-label"><font color="red" size=2>*</font>情报发生时间</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="infodate" id="infodate"  autocomplete="off" placeholder="请输入情报发生时间" class="layui-input" lay-verify="required">
	      		</div>
	       	</div>
	     </div>
	     <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label" style="width: 140px;"><font color="red" size=2>*</font>情报内容类别</label>
	    		<div class="layui-input-inline">
	      			<select id="infotype"  name="infotype" style="width:170px;" lay-verify="required" lay-verType="tips"></select>
	      		</div>
	       	</div>
	       	<div class="layui-inline">
	    		<div class="layui-input-inline">
	      			<input type="text" name="infomemo" id="infomemo"  autocomplete="off" placeholder="请输入备注说明" class="layui-input"  style="width:400px;">
	      		</div>
	       	</div>
	     </div> 
	    <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label" style="width: 140px;"><font color="red" size=2>*</font>情报内容</label>
	    		<div class="layui-input-inline">
	      			  <textarea placeholder="请输入内容" class="layui-textarea" name="information"  style="width:700px;" lay-verify="required"></textarea>
	      		</div>
	       	</div>
	     </div> 
	     <div id="table-body">
	      <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label"  style="width: 140px;"><a href="javascript:;"  onclick="addRows();" >【+】</a>同行人身份证号</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="cardnumber" id="cardnumber1"   autocomplete="off" placeholder="请输入身份证号" class="layui-input" onblur="getpersonelname(1);">
	      		</div>
	       	</div>
	       <div class="layui-inline">
	    		<label class="layui-form-label">同行人姓名</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="togethername" id="togethername1"   autocomplete="off" placeholder="请输入姓名" class="layui-input" >
	      		</div>
	       	</div>
	     </div>
	     </div> 
	     <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label" style="width: 140px;">群类型</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="grouptype"  autocomplete="off" placeholder="请输入群类型" class="layui-input" >
	      		</div>
	       	</div>
	       <div class="layui-inline">
	    		<label class="layui-form-label">群名称</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="groupname"  autocomplete="off" placeholder="请输入群名称" class="layui-input" >
	      		</div>
	       	</div>
	     </div> 
	     <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label" style="width: 140px;">群ID</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="groupid"  autocomplete="off" placeholder="请输入群ID" class="layui-input" >
	      		</div>
	       	</div>
	       <div class="layui-inline">
	    		<label class="layui-form-label" >交通工具类型</label>
	    		<div class="layui-input-inline">
	      			<select id="vehicletype"  name="vehicletype" style="width:170px;"  lay-verType="tips"></select>
	      		</div>
	       	</div>
	     </div> 
	     <div class="layui-form-item">
	       	<div class="layui-inline">
	    		<label class="layui-form-label" style="width: 140px;">交通工具信息</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="vehicleinfo"  autocomplete="off" placeholder="请输入交通工具信息" class="layui-input" style="width:700px;">
	      		</div>
	       	</div>
	     </div>
	     <div class="layui-form-item">
	    	<label class="layui-form-label">附件</label>
	    	<div class="layui-input-inline">
				<button type="button" class="layui-btn" id="attachments"><i class="layui-icon">&#xe681;</i>上 传</button>
	    		<button type="button" class="layui-btn layui-hide" id="attachmentsAction">开始上传</button>
	    	</div>
    	</div>
	  	<div class="layui-form-item">
	    	<label class="layui-form-label">上传文件</label>
	    	<div class="layui-input-inline" style="width:700px;">
	    		<div class="layui-upload">
					<div class="layui-upload-list">
						<table class="layui-table" style="border: 1px solid #eee;">
							<thead>
								<tr>
									<th width="20%">文件名</th>
									<th width="40%">类别</th>
									<th width="20%">状态</th>
									<th width="20%">操作</th>
								</tr>
							</thead>
							<tbody id="upload-filesList"></tbody>
						</table>
					</div>
				</div>
	    	</div>
	  	</div> 
	     <br>
		<div class="layui-form-item">
		    <div class="layui-input-block">
		      <button type="submit" class="layui-btn" lay-submit="" lay-filter="roleSub">立即提交</button>
		      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
		    </div>
	  	</div>
	  	<div style="height:150px;"></div>
	</form>
	<script type="text/javascript">
var locat = (window.location+'').split('/'); 
$(function(){if('main'== locat[3]){locat =  locat[0]+'//'+locat[2];}else{locat =  locat[0]+'//'+locat[2]+'/'+locat[3];};});
var i=2;
	$(document).ready(function(){
	    $.ajax({
				type:		'POST',
				 url:		'<c:url value="/getBMByTypeToJSON1.do" />?basicType='+71, 
				 dataType:	'json',
				 async :      false,
				 success:	function(data){					  
				      var options = '<option value="">--请选择---</option>' + fillOption(data);
				      $("select[name^=jointorigin]").html(options);
				   }
			});
		 $.ajax({
				type:		'POST',
				 url:		'<c:url value="/getBMByTypeToJSON1.do" />?basicType='+72, 
				 dataType:	'json',
				 async :      false,
				 success:	function(data){					  
				      var options = '<option value="">--请选择---</option>' + fillOption(data);
				      $("select[name^=infotype]").html(options);
				   }
			});
			 $.ajax({
				type:		'POST',
				 url:		'<c:url value="/getBMByTypeToJSON1.do" />?basicType='+73, 
				 dataType:	'json',
				 async :      false,
				 success:	function(data){					  
				      var options = '<option value="">--请选择---</option>' + fillOption(data);
				      $("select[name^=vehicletype]").html(options);
				   }
			});
			
		
       });
		layui.use(['form', 'laydate','upload'], function(){
		         var form = layui.form,
		         layer = layui.layer,
		         upload = layui.upload,
		         laydate = layui.laydate;
		         laydate.render({
					    elem: '#infodate',//指定元素
					    type:'datetime'
				 });
				 
			var attachmentsListView = $("#upload-filesList"),
				attachments='',
				attachmentsChoose=0,
				attachmentsBool=false,
				attachmentsUploadListIns = upload.render({
					elem: '#attachments',
		       		url: '<c:url value="/newuploadfile1.do"/>',
					accept: 'file',
					multiple: true,
					auto: false,
					bindAction: '#attachmentsAction',
					choose: function(obj) {
						var files = this.files = obj.pushFile(); //将每次选择的文件追加到文件队列
						//读取本地文件
						obj.preview(function(index, file, result) {
							var tr = $(['<tr id="attachments-upload-' + index + '">', '<td>' + file.name +
								'</td>',
								'<td>其它附件</td>',
								'<td>等待上传</td>', '<td>',
								'<button class="layui-btn layui-btn-sm attachments-reload layui-hide">重传</button>',
								'<button class="layui-btn layui-btn-sm layui-btn-danger attachments-delete">删除</button>',
								'</td>', '</tr>'
							].join(''));
		
							//单个重传
							tr.find('.attachments-reload').on('click', function() {
								obj.upload(index, file);
							});
		
							//删除
							tr.find('.attachments-delete').on('click', function() {
								delete files[index]; //删除对应的文件
								tr.remove();
								attachmentsChoose--;
								attachmentsUploadListIns.config.elem.next()[0].value =
								''; //清空 input file 值，以免删除后出现同名文件不可选
							});
							
							attachmentsChoose++;
							attachmentsListView.append(tr);
						});
					},
					done: function(res, index, upload) {
						if (res.success>0) { //上传成功
							var tr = attachmentsListView.find('tr#attachments-upload-' + index),
								tds = tr.children();
							tds.eq(2).html('<span style="color: #5FB878;">上传成功</span>');
							tds.eq(3).html(''); //清空操作
							if(attachments!="")attachments+=",";
							attachments+=res.success;
							attachmentsChoose--;
							return delete this.files[index]; //删除文件队列已经上传成功的文件
						}
						this.error(index, upload);
					},
					allDone: function(obj){ //当文件全部被提交后，才触发
					    attachmentsBool=true;
					},
					error: function(index, upload) {
						var tr = attachmentsListView.find('tr#attachments-upload-' + index),
							tds = tr.children();
						tds.eq(2).html('<span style="color: #FF5722;">上传失败</span>');
						tds.eq(3).find('.attachments-reload').removeClass('layui-hide'); //显示重传
					}
				});	 
				   
			form.verify({
		       //证件号码不同类型都要验证
			  Iscardnumber:function(vaule,item){
			  if(vaule!=""){
			      var Validator = new IDValidator();
			      var identity=Validator.isValid(vaule);
			      if(!identity){ 
			          return '身份证号格式不正确！';
			      }
			     }else if(vaule==""){
			       return '请填写身份证号信息！';
			  }
			 },
		  });  	 
			
		  form.on('submit(roleSub)', function(data){
		   	 if(attachmentsChoose>0)$('#attachmentsAction').click();
			 else attachmentsBool=true;
			 var clearVisit=setInterval(function(){
			 	if(attachmentsBool){
		             $("#form1").ajaxSubmit({
			              	url:		'<c:url value="/addjointcontrolrecord.do"/>',
			              	dataType:	'json',
			              	data:		{
			              					attachments:attachments
			              				},
			              	async:  false,
			              	success:	function(data) {
			                  	clearInterval(clearVisit);
			                  	var obj = eval('(' + data + ')');
			                  	if(obj.flag>0){
			                  	    //弹出loading
			 		            	var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
			                     	setTimeout(function(){         
			                     		top.layer.msg(obj.msg);
			                     		top.layer.close(index);
						        		parent.layui.layer.closeAll("iframe");
				 		        	    parent.layui.table.reload('jointcontrolrecordTable', {});     
				 		         		
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
			 
			 	// 删除行
				$(document).on("click",".del",function(){
				  $(this).parents('.parent').remove();
				});
		});
		//添加行
		function addRows(){
			  //alert(1);
			var cardnumber =document.getElementsByName('cardnumber');
			var size=cardnumber.length;
			if(size<5){
			  var str = '<div class="layui-form-item  parent"> <div class="layui-inline">'
	    		                +' <label class="layui-form-label" style="width: 140px;"><a href="javascript:;" class="del"  >【-】</a>同行人身份证号</label>'
	    		                +' <div class="layui-input-inline"><input type="text" name="cardnumber" id="cardnumber'+i+'"    lay-verify="required"   autocomplete="off" placeholder="请输入身份证号" class="layui-input" onblur="getpersonelname('+i+');">'
	      		                +'</div></div><div class="layui-inline"><label class="layui-form-label">同行人姓名</label>'
	    		                +'<div class="layui-input-inline">	<input type="text" name="togethername"  id="togethername'+i+'"   lay-verify="required" autocomplete="off" placeholder="请输入姓名" class="layui-input" ></div></div></div></div> '
					$('#table-body').append(str);
			    i++;  
			}else{
			   layer.msg("最多只添加5个同行人员！");
			}
					
		}
		function getpersonelname(i){
		 var cardnumber=$("#cardnumber"+i).val();
		 //alert(cardnumber);
		 if(cardnumber!=''){
		         $.getJSON(locat+"/getpersonelname.do?cardnumber="+cardnumber,{},function(data) {
							 var str = eval('(' + data + ')');
					      	 if (str.flag >0) {		                          
							  $("#togethername"+i).val(str.msg);           
						 }else{
						  // alert("没有查询到身份信息");
						  var addindex= layui.layer.open({
									title : "新增社会关系",
									type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
									content :locat+"/jsp/personel/jointcontrolrecord/addsocialrelations.jsp?menuid="+${param.menuid}+"&personnelid="+${param.personnelid}+"&cardnumber="+cardnumber+"&indexnum="+i,
									area: ['800', '600px'],
									maxmin: true,
									success : function(layero, index){
									}
					       })	
					       layui.layer.full(addindex);	
					   }		      	    		
				 });  
		  }
		}
		
		
		
		
		
		
	</script>
  </body>
</html>
