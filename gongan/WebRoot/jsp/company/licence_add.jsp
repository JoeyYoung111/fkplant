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

	<title>添加许可证页面</title>
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
	<script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/js/jquery.form.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/js/cardnumber.js"/>"></script>
	<link rel="stylesheet" href="<c:url value='/css/public.css'/>" media="all" />
	<script type="text/javascript" src="<c:url value="/js/viewer.js"/>"></script>
  	
	</head>
<body>
<form class="layui-form" method="post" id="form_licence" onsubmit="return false;">

	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 5px;">
		<legend>添加许可证信息</legend>
	</fieldset>
	
	<input type="hidden" name="companyid" id="companyid" value="${param.companyid }" />
	<input type="hidden" name="menuid" id="menuid" value="${param.menuid }" />
	<input type="hidden" name="companyname" id="companyname" value="${param.companyname}" />
	<div class="layui-form-item">
		<div class="layui-inline">
	      	<label class="layui-form-label"><font color="red" size=2>*</font>负责人</label>
	    	<div class="layui-input-inline">
	      		<input type="text" class="layui-input" style="width:670px;" name="chargeperson" id="chargeperson" lay-verify="required" autocomplete="off" lay-reqtext="请输入负责人姓名" />
	    	</div>
		</div>
	</div>
    
	<div class="layui-form-item">
		<div class="layui-inline">
			<label class="layui-form-label"><font color="red" size=2>*</font>许可证编号</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" name="licenceno" id="licenceno" lay-verify="required" lay-reqtext="请输入许可证编号" autocomplete="off" />
			</div>
		</div>
		<div class="layui-inline">
			<label class="layui-form-label"><font color="red" size=2>*</font>证件类型</label>
			<div class="layui-input-inline">
		  		<select id="credentialstype" name="credentialstype" lay-filter="credentialstype" style="width:170px;"></select>
			</div>
		</div>
	</div>

	<div class="layui-form-item">
		<div class="layui-inline">
			<label class="layui-form-label"><font color="red" size=2>*</font>许可范围</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" style="width:670px;" name="allowrange" id="allowrange" lay-verify="required" lay-reqtext="请输入许可范围" autocomplete="off" />
			</div>
		</div>
	</div>
	<div class="layui-form-item">
		<div class="layui-inline">
			<label class="layui-form-label">许可品种</label>
			<div class="layui-input-inline">
				<input type="hidden" name="allowtype" id="allowtype" value="${param.xkpz}"/>
				<input type="text" class="layui-input" style="width:670px;" value="${param.xkpzMsg}" readonly="true"/>
			</div>
		</div>
	</div>
	<div class="layui-form-item">
		<div class="layui-inline">
			<label class="layui-form-label"><font color="red" size=2>*</font>经营方式</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" style="width:670px;" name="jyfs" id="jyfs" lay-verify="required" lay-reqtext="请输入经营方式" autocomplete="off" />
			</div>
		</div>
	</div>
	
	<div class="layui-form-item" id="LX">
		<div class="layui-inline">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>主要流向</label>
	    	<div class="layui-input-inline">
	      		<input type="text" class="layui-input" name="direction" id="direction" autocomplete="off" />
	    	</div>
		</div>
		<div class="layui-inline">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>品种产类</label>
	    	<div class="layui-input-inline">
	      		<input type="text" class="layui-input" name="varietyyield" id="varietyyield" autocomplete="off"/>
	    	</div>
		</div>
	</div>
	
	<div class="layui-form-item">
		<div class="layui-inline">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>有效期开始</label>
	    	<div class="layui-input-inline">
	    		<input type="text" class="layui-input" name="validitystart" id="validitystart" lay-verify="required" lay-reqtext="请选择有效期开始时间" autocomplete="off" />
	    	</div>
		</div>
		<div class="layui-inline">
			<label class="layui-form-label"><font color="red" size=2>*</font>有效期结束</label>
	    	<div class="layui-input-inline">
	      		<input type="text" class="layui-input" name="validityend" id="validityend" lay-verify="required" lay-reqtext="请选择有效期结束时间" autocomplete="off" />
	      	</div>
		</div>
	</div>

    <div class="layui-form-item">
    	<div class="layui-inline">
		<label class="layui-form-label"><font color="red" size=2>*</font>发证机关</label>
			<div class="layui-input-inline">
		  		<input type="text" class="layui-input" name="allowunit" id="allowunit" lay-verify="required" lay-reqtext="请输入发证机关" autocomplete="off" />
			</div>
		</div>
    	<div class="layui-inline">
    		<label class="layui-form-label"><font color="red" size=2>*</font>发证日期</label>
	    	<div class="layui-input-inline">
	      		<input type="text" class="layui-input" name="allowdate" id="allowdate" lay-verify="required" lay-reqtext="请选择发证日期" autocomplete="off" />
	    	</div>
    	</div>
    </div>
    
    <div class="layui-form-item">
	    <div class="layui-input-block" style="width:70%">
		    <button type="button" style="display:none" id="upload_files">附件上传(hidden)</button>
		    <button type="button" class="layui-btn" id="files"><i class="layui-icon">&#xe67c;</i>选择附件</button>
		    <button type="button" class="layui-btn" onclick="repic();"><i class="layui-icon">&#xe67c;</i>清空附件</button>
		    <div class="layui-upload" style="margin-top:10px;">
	    		<blockquote class="layui-elem-quote layui-quote-nm">
	    			<div id="licence_att_list" style="overflow:hodden;height:120px;" ></div>
	    		</blockquote>
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
	      <button type="submit" class="layui-btn" lay-submit="" lay-filter="demoLicence">立即提交</button>
	      <button type="reset" class="layui-btn layui-btn-primary" id="LicenceReset">重置</button>
	    </div>
  	</div>
	  	
</form>

<script type="text/javascript">

layui.config({
    base: "<c:url value="/layui/lay/modules/"/>"
}).extend({
	zTreeSelectM: "zTreeSelectM/zTreeSelectM",
    treeSelect: "treeSelect"
});

//图片String型id值
var recordingFileid = "";
var choose_pic = 0;
//设置清空图片按钮点击事件
function repic(){
<%--	$(".layui-upload-img").remove();--%>
<%--	$(".demo-delete").remove();--%>
<%--	recordingFileid = "";--%>
<%--	choose_pic = 0;--%>
<%--	$("#attachments").val(recordingFileid);--%>
	$(".demo-delete").click();
}
/*
//字符串转int
function turnNums(nums){
	for(let i=0;i<nums.length;i++){
		nums[i] = parseInt(nums[i]);
	}
	return nums;
}*/

//获取证件类型
function getcredentialstype(){
	$.ajax({
		type:		'POST',
		url:		'<c:url value="/getBMByParentBasicNameToJSON.do"/>?parentBasicName=${param.affecttype }',
		dataType:	'json',
		async:		false,
		success:	function(data){
			var options = fillOption(data);
			$("select[name^=credentialstype]").html(options);
		}
	});
}

function Today(){
	var now = new Date();
	return now.getFullYear() + "-" + (now.getMonth() + 1) + "-" + now.getDate();
}

$(document).ready(function(){
	getcredentialstype();
	$("#LX").hide();
});

/*var allowtype = '${param.xkpz}'.split(',');
allowtype=turnNums(allowtype);
*/
layui.use(['form','upload','zTreeSelectM','laydate'],function(){
	var form = layui.form;
	var upload = layui.upload;//得到upload对象
	var layer = layui.layer;
	var zTreeSelectM = layui.zTreeSelectM;
	var laydate = layui.laydate;
	
	laydate.render({
		elem:	'#allowdate',
		max:	Today()
		,trigger: 'click'
	});
	
	laydate.render({
		elem:	'#validitystart',
		max:	Today()
		,trigger: 'click'
	});
	
	laydate.render({
		elem:	'#validityend',
		min:	Today()
		,trigger: 'click'
	});
	

	form.on('select(credentialstype)',function(data){
		if(data.value == '1083' || data.value=='1091'){
			$("#LX").show();
			$("#direction").attr("lay-verify","required");
			$("#varietyyield").attr("lay-verify","required");
			form.render('select');
		}else{
			$("#LX").hide();
			$("#direction").removeAttr("lay-verify","required");
			$("#varietyyield").removeAttr("lay-verify","required");
			form.render('select');
		}
	});
	
	/*
	//许可品种
	var _zTreeSelectM = zTreeSelectM({
	    elem: '#allowtype',//元素容器【必填】          
	    data: '<c:url value="/getbasicMsgJSON.do"/>?basicType='+50,
	    type: 'get',  //设置了长度    
	    selected: allowtype,//默认值            
	    max: 5,//最多选中个数，默认5            
	    name: 'allowtype',//input的name 不设置与选择器相同(去#.)
	    delimiter: ',',//值的分隔符           
	    field: { idName: 'id', titleName: 'name' },//候选项数据的键名 
	    tips: '许可品种：',
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
	});*/
	
	//监听提交 创建一个上传组件
	var listview = $("#licence_att_list");
	var uploadInst = upload.render({
		elem:		'#files', //绑定元素(按钮)
		url:		'<c:url value="/newuploadfile.do"/>', //上传接口
		accept:		'images', //file video audio images 允许的文件类型
		acceptMine:	'image/*',//规定打开文件选择框时，筛选出的文件类型 acceptMime:'image/*'（只显示图片文件）
		multiple:	true,	//多文件上传
		auto:		false,	//自动上传,默认是打开的
		bindAction:	'#upload_files',	//auto为false时，点击触发上传
		choose:	function(obj){
			var files = this.files = obj.pushFile();
			//选择文件后的回调函数,返回一个object参数
			//预读本地文件，如果是多文件，则会遍历 index文件索引 file文件对象 result文件编码
			obj.preview(function(index,file,result){
				var tr = $(['<button class="layui-anim layui-anim-scale">'
				            ,'<image class="layui-upload-img" style="height:100px;width:100px;" src="'+result+'" />'
				            ,'<div class="my-tag-close demo-delete">'
				            ,'</div>'
				            ,'</button>'].join(''));

				tr.find('.demo-delete').on('click',function(){
	    			delete files[index];
	    			choose_pic--;
	    			tr.remove();
	    			uploadInst.config.elem.next()[0].value = '';//清空input file值，以免后序同名文件不可选
	    		});
	    		listview.append(tr);
	    		listview.append("&nbsp;&nbsp;");
				choose_pic++;
			});
		}
		,done: function(res){
			//执行上传请求后的回调
			if(recordingFileid.length > 0 ){
				recordingFileid += "," + res.success.toString();
			}else{
				recordingFileid = res.success.toString();
			}
		}
		,allDone: function(obj){
			$("#attachments").val(recordingFileid);
			addLicence();
		}
		,error: function(){
			//执行上传请求出现异常的回调
			console.log("图片上传失败");
		}
	});
	
	form.render();
	
	form.on('submit(demoLicence)',function(data){
		if(choose_pic > 0){
			$("#upload_files").click();
		}else{
			$("#attachments").val("");
			layer.alert("请上传文件");
			return false;
		}
		var index1 = top.layer.msg('数据提交中...',{icon:16,time:false,shade:0.8});
		setTimeout(function(){
	   		top.layer.close(index1);
	   	},800);
	  	return false;
	});
	
	function addLicence(){
		$("#form_licence").ajaxSubmit({
			url:		'<c:url value="/addLicence.do"/>',
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
		 		        parent.$("#searchlicence").click();
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
