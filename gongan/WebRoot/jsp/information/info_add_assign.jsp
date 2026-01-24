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

	<title>交办情报</title>
	
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
	<script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/js/jquery.form.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/js/cardnumber.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/js/viewer.js"/>"></script>
	
	</head>
<body class="childrenBody layui-fluid">
<form class="layui-form" method="post" id="add_assign" onsubmit="return false;">

	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 15px;">
		<legend>交办信息</legend>
	</fieldset>

	<input type="hidden" id="informationid" name="informationid" value="${informationsend.informationid}"/>
	<input type="hidden" id="informationsendid" name="informationsendid" value="${id}"/>
	
	<div class="layui-form-item">
		<div class="layui-col-md1">
	   		<div class="layui-col-md6 layui-col-md-offset6">
		    	<label class="layui-form-label">签收单位：</label>
		    </div>
		</div>
		<div class="layui-col-md11">
	    	<div class="layui-col-md10 layui-input-block">	
	    		<input type="text" class="layui-input" id="otherunit" name="signdepartment" lay-verify="required" lay-reqtext="请选择交办部门" readonly="true" autocomplete="off"/>
	  			<input type="hidden" id="otherunitids" name="signdepartids"/>
	  		</div>
	  		<div class="layui-col-md1">	
	  			<button type="button" class="layui-btn " onclick="openUnits();"><i class="layui-icon layui-icon-add-1"></i>选 择 单 位</button>
	    	</div>
	    </div>
	</div>
	
	<div class="layui-form-item">
		<div class="layui-col-md1">
			<div class="layui-col-md6 layui-col-md-offset6">
				<label class="layui-form-label">标题：</label>
			</div>
		</div>
		<div class="layui-col-md11">
			<div class="layui-col-md11">
				<div class="layui-input-block">
					<input type="text" class="layui-input" name="assigntitle" value="${informationsend.infotitle}" autocomplete="off" readonly="true"/>
				</div>
			</div>
		</div>
	</div>
	
	<div class="layui-form-item">
		<div class="layui-col-md1">
			<div class="layui-col-md6 layui-col-md-offset6">
				<label class="layui-form-label">情报内容：</label>
			</div>
		</div>
		<div class="layui-col-md11">
			<div class="layui-col-md11">
				<div class="layui-input-block">
					<textarea id="assigncontent" name="assigncontent" class="layui-textarea">${informationsend.infocontent}</textarea>
				</div>
			</div>
		</div>
	</div>
	
	<div class="layui-form-item">
		<div class="layui-col-md1">
	    	<div class="layui-col-md6 layui-col-md-offset6">
		    	<label class="layui-form-label">领导批示：</label>
	    	</div>
	    </div>
	    <div class="layui-col-md11">
	    	<div class="layui-col-md11">
		    	<div class="layui-input-block">
		    		<input type="text" class="layui-input" name="instructions" autocomplete="off"/>
	      		</div>
	    	</div>
		</div>
	</div>
	
	<div class="layui-form-item">
		<div class="layui-col-md1">
	    	<div class="layui-col-md6 layui-col-md-offset6">
		    	<label class="layui-form-label">研判意见：</label>
	    	</div>
	    </div>
	    <div class="layui-col-md11">
	    	<div class="layui-col-md11">
		    	<div class="layui-input-block">
		    		<input type="text" class="layui-input" name="judgeopinion" autocomplete="off"/>
	      		</div>
	    	</div>
		</div>
	</div>
	
	<div class="layui-form-item">
		<div class="layui-col-md6">
	   		<div class="layui-col-md1 layui-col-md-offset1">
		    	<label class="layui-form-label">工作要求：</label>
		    </div>
	    	<div class="layui-col-md9">	
		    	<div class="layui-input-block">
		    		<input type="text" class="layui-input" name="requirements" autocomplete="off"/>
		    	</div>
	    	</div>
		</div>
		<div class="layui-col-md6">
	   		<div class="layui-col-md1 layui-col-md-offset1">
		    	<label class="layui-form-label">签发人：</label>
		    </div>
	    	<div class="layui-col-md8">	
		    	<div class="layui-input-block">
		    		<input type="text" class="layui-input" name="issuer" autocomplete="off"/>
		    	</div>
	    	</div>
		</div>
	</div>
	
	<div class="layui-form-item">
		<div class="layui-col-md6">
	   		<div class="layui-col-md1 layui-col-md-offset1">
		    	<label class="layui-form-label">类别：</label>
		    </div>
	    	<div class="layui-col-md9">	
		    	<div class="layui-input-block">
		    		<select id="category" name="category" lay-filter="category">
			    		<option value="核查性" selected>核查性</option>
						<option value="指令性">指令性</option>
						<option value="指导性">指导性</option>
						<option value="督办性">督办性</option>
		    		</select>
		    	</div>
	    	</div>
		</div>
		<div class="layui-col-md6">
	   		<div class="layui-col-md1 layui-col-md-offset1">
		    	<label class="layui-form-label">紧急程度：</label>
		    </div>
	    	<div class="layui-col-md8">	
		    	<div class="layui-input-block">
			    	<select id="urgentflag" name="urgentflag" lay-filter="urgentflag">
			    		<option value="红色" selected>红色</option>
						<option value="橙色">橙色</option>
						<option value="蓝色">蓝色</option>
		    		</select>
		    	</div>
	    	</div>
		</div>
	</div>
	
	<div class="layui-form-item">
		<div class="layui-col-md6">
			<div class="layui-col-md1 layui-col-md-offset1">
	    		<label class="layui-form-label">签收时限：</label>
		    </div>
			<div class="layui-col-md9">	
		    	<div class="layui-input-block">
		    		<input type="text" class="layui-input" id="slimit" name="slimit" value="10分钟" readonly="true"/>
		    		<input type="hidden" id="signlimit" name="signlimit" value="10" />
		    	</div>
			</div>
		</div>
		<div class="layui-col-md6">
			<div class="layui-col-md1 layui-col-md-offset1">
		    	<label class="layui-form-label">反馈时限：</label>
		    </div>
			<div class="layui-col-md8">	
		    	<div class="layui-input-block">
		    		<input type="text" class="layui-input" id="flimit" name="flimit" value="20分钟" readonly="true"/>
		    		<input type="hidden" id="feedbacklimit" name="feedbacklimit" value="20" />
		    	</div>
			</div>
		</div>
	</div>
	
	<div class="layui-form-item">
		<div class="layui-col-md1">
			<div class="layui-col-md6 layui-col-md-offset6">
				<label class="layui-form-label">附件列表：</label>
			</div>
		</div>
		<div class="layui-col-md11">
		    <div class="layui-col-md11">
		    	<div class="layui-input-block">
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
				    		<tbody id="filelist">
					    		<c:forEach items="${files}" var="row" varStatus="num">
				    				<tr>
				    					<td id="showfiles"><a>${row.fileName }</a></td>
				    					<td>上传完成</td>
				    					<td>
				    						<a href="<c:url value="/downUpfile.do" />?fileid=${row.id }">
				    							<button class="layui-btn layui-btn-xs" type="button">点击下载</button>
				    						</a>
				    						&nbsp;
				    						<button class="layui-btn layui-btn-xs layui-btn-danger demo-deletes" type="button" onclick="cancelfiles(${row.id },this);">删除</button>
				    					</td>
				    				</tr>
				    			</c:forEach>
				    		</tbody>
				    	</table>
				    </div>
	    		</div>
	    	</div>
		</div>
		<input type="hidden" id="attachments" name="attachments" value=""/>
		<input type="hidden" name="remainStateid" id="remainStateid" />
	</div>
	
	<div class="layui-form-item">
		<div class="layui-col-md1">
	    	<div class="layui-col-md6 layui-col-md-offset6">
		    	<label class="layui-form-label">备注信息：</label>
	    	</div>
	    </div>
	    <div class="layui-col-md11">
	    	<div class="layui-col-md11">
		    	<div class="layui-input-block">
		    		<textarea name="memo" id="memo" class="layui-textarea"></textarea>
	      		</div>
	    	</div>
		</div>
	</div>
	
	<div class="layui-form-item layui-col-md3 layui-col-lg-offset5">
		<div class="layui-input-block">
			<button class="layui-btn layui-btn-sm" lay-submit="" lay-filter="demoassign">立即提交</button>
		</div>
	</div>
    
</form>    
    
<script type="text/javascript">

var locat = (window.location+'').split('/'); 
$(function(){if('main'== locat[3]){locat =  locat[0]+'//'+locat[2];}else{locat =  locat[0]+'//'+locat[2]+'/'+locat[3];};});

function cancelfiles(id,obj){
	var re = $("#remainStateid").val().split(",");
	var newre = "";
	for(var i=0;i<re.length;i++){
		if(re[i]!=id){
			newre += re[i]+",";
		}
	}
	$("#remainStateid").val(newre.substring(0,newre.length-1));
	var dom = obj.parentNode.parentNode;
	dom.remove();
}

var idlist1 = "";

function openUnits(){
	var index = layui.layer.open({
		title:	"交办部门",
		type:	2,
		content:'<c:url value="/jsp/information/units.jsp"/>?idlist1='+idlist1+'&idlist2='+$("#otherunitids").val(),
		area:	['1200px','700px'],
		maxmin:	true,
		success: function(layero,index){
			setTimeout(function(){
				layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close',{
					tips:3
				});
			},500)
		}
	});
	layui.layer.full(index);
}

$(document).ready(function(){
	var t = "${informationsend.attachments}";
	$("#remainStateid").val(t);
});

layui.use(['form','layer','layedit','upload'],function(){
	var form = layui.form;
	var layer = layui.layer;
	var layedit = layui.layedit;
	var upload = layui.upload;
	var tempid = "${menuid}";
	tempid = tempid.substring(tempid.indexOf("=")+1);
	
	var index = layedit.build('assigncontent',{
		tool: [ 'strong','italic','underline','del' ,'|','left','center','right','link','unlink','image','face'],
	});
	$("#LAY_layedit_1").contents().find("body[contenteditable]").prop("contenteditable", false);
	
	form.on('select(urgentflag)',function(data){
		if(data.value == '红色'){
			$("#slimit").val("10分钟");
			$("#signlimit").val("10");
			$("#flimit").val("20分钟");
			$("#feedbacklimit").val("20");
			form.render('select');
		}else if(data.value == '橙色'){
			$("#slimit").val("20分钟");
			$("#signlimit").val("20");
			$("#flimit").val("35分钟");
			$("#feedbacklimit").val("35");
			form.render('select');
		}else{
			$("#slimit").val("60分钟");
			$("#signlimit").val("60");
			$("#flimit").val("80分钟");
			$("#feedbacklimit").val("80");
			form.render('select');
		}
	});
	
	//文件上传
	var listview = $("#filelist");
	var fileidstr = "";
	var choose_files = 0;
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
	    	var remainStateidstr = $("#remainStateid").val();
			if(remainStateidstr != ""){
				$("#attachments").val(remainStateidstr+","+fileidstr.substring(0,fileidstr.length-1));
			}else{
				$("#attachments").val(fileidstr.substring(0,fileidstr.length-1));
			}
			addAssign();
	    }
	    ,error: function(){
	      var tr = listview.find('tr#upload-'+index),
	      tds = tr.children();
	      tds.eq(2).html('<span style="color:#FF5722;">上传失败</span>');
	      tds.eq(3).html('.demo-reload').removeClass('layui-hide');//清空操作
	    }
	});
	
	form.render();
	
	form.on('submit(demoassign)',function(data){
		var remainStateidstr = $("#remainStateid").val();
		if(choose_files<1){
			$("#attachments").val(remainStateidstr);
			addAssign();
		}else{
			$("#upload_files").click();
		}
		return false;
	});
	
	function addAssign(){
		$("#add_assign").ajaxSubmit({
			url:		'<c:url value="/addInfoAssign.do"/>?menuid='+tempid,
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
		 		        //parent.$("#searchlicence").click();
	               },500);
              	}else{
              		layer.msg(obj.msg);
              	}
			},error:function(){
				layer.alert("请求失败");
			}
		});
	}
	
});


</script>

</body>
</html>
