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
    
    <title>添加风险车辆页面</title>
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
<form class="layui-form" method="post" id="form_vehicle" onsubmit="return false;">

	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 5px;">
		<legend>添加车辆信息</legend>
	</fieldset>
	
	<input type="hidden" name="menuid" id="menuid" value="${param.menuid }" />
	<input type="hidden" id="vehiclecategory" name="vehiclecategory" value="1039" />
	<input type="hidden" name="useNature" id="useNature" value="" />
	<input type="hidden" id="xkpz" value="" />
	
	<div class="layui-form-item">
		<div class="layui-inline">
			<label class="layui-form-label"><font color="red" size=2>*</font>所属单位(运输)</label>
			<div class="layui-input-inline">
				<select id="companyid" name="companyid" id="companyid" lay-filter="companyid" lay-verType="tips"></select>
			</div>
			<input type="hidden" name="companyname" id="companyname" lay-verify="required" lay-reqtext="请选择单位"/>
		</div>
	</div>
	
	<div class="layui-form-item">
		<div class="layui-inline">
			<label class="layui-form-label"><font color="red" size=2>*</font>牌照</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" name="vehicleno" id="vehicleno" lay-verify="required" lay-reqtext="请输入牌照" autocomplete="off" />
			</div>
		</div>
		<div class="layui-inline">
			<label class="layui-form-label"><font color="red" size=2>*</font>品牌型号</label>
	    	<div class="layui-input-inline">
	      		<input type="text" class="layui-input" name="vehiclebrand" id="vehiclebrand" lay-verify="required" lay-reqtext="请输入品牌型号" autocomplete="off" />
	    	</div>
		</div>
	</div>
	
	<div class="layui-form-item">
		<div class="layui-inline">
			<label class="layui-form-label"><font color="red" size=2>*</font>车辆颜色</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" name="vehiclecolor" id="vehiclecolor" lay-verify="required" lay-reqtext="请输入车辆颜色" autocomplete="off" />
			</div>
		</div>
		<div class="layui-inline">
			<label class="layui-form-label"><font color="red" size=2>*</font>车辆类型</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" id="vehicletype" name="vehicletype" lay-verify="required" lay-reqtext="请输入车辆类型" autocomplete="off" />
			</div>
		</div>
		
	</div>
	
	<div class="layui-form-item">
		<div class="layui-inline">
			<label class="layui-form-label">发动机号</label>
				<div class="layui-input-inline">
			  		<input type="text" class="layui-input" name="engineno" id="engineno" autocomplete="off" />
				</div>
		</div>
		<div class="layui-inline">
			<label class="layui-form-label">车辆识别代码</label>
				<div class="layui-input-inline">
			  		<input type="text" class="layui-input" name="identificationCode" id="identificationCode" autocomplete="off" />
				</div>
		</div>
	</div>
	
	<div class="layui-form-item">
		<div class="layui-inline">
			<label class="layui-form-label">道路运输编号</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" name="transportNo" id="transportNo" autocomplete="off" />
			</div>
		</div>
	</div>
	
	<div class="layui-form-item">
		<div class="layui-inline">
			<label class="layui-form-label">许可范围</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" style="width:670px;" name="allowrange" id="allowrange" autocomplete="off" />
			</div>
		</div>
	</div>
	
	<div class="layui-form-item">
		<div class="layui-inline">
			<label class="layui-form-label"><font color="red" size=2>*</font>涉及品种</label>
			<div class="layui-input-inline" style="width:670px;">
				<div id="relatedtype"></div>
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
	    			<div id="vehicle_att_list" style="overflow:hodden;height:120px;" ></div>
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
	      <button type="submit" class="layui-btn" lay-submit="" lay-filter="demoVehicle">立即提交</button>
	      <button type="reset" class="layui-btn layui-btn-primary" id="VehicleReset">重置</button>
	    </div>
  	</div>
	  	
</form>

<script type="text/javascript">

function getCompany(){
	$.ajax({
		type:		'POST',
		url:		'<c:url value="/getCompanyToJSON.do"/>?affecttype=1039',
		dataType:	'json',
		async:		false,
		success:	function(data){
			var options = fillOption(data);
			options = '<option value="" selected>---请选择---</option>'+options;
			$("select[name^=companyid]").html(options);
		}
	});
}

function getSjpz(cid){
	$.ajax({
		type:	'POST',
		url:	'<c:url value="/selectSJPZ.do"/>?id='+cid,
		dataType:'json',
		async:	false,
		success: function(data){
			var obj = eval('('+data+')');
			$("#xkpz").val(obj.msg);
		}
	});
}

//字符串转int
function turnNums(nums){
	for(let i=0;i<nums.length;i++){
		nums[i] = parseInt(nums[i]);
	}
	return nums;
}

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
	$(".demo-delete").click();
	recordingFileid = "";
	choose_pic = 0;
	$("#attachments").val(recordingFileid);
}

function Today(){
	var now = new Date();
	return now.getFullYear() + "-" + (now.getMonth() + 1) + "-" + now.getDate();
}
	
$(document).ready(function(){
	getCompany();
});

layui.use(['form','upload','zTreeSelectM'],function(){
	var form = layui.form;
	var upload = layui.upload;//得到upload对象
	var layer = layui.layer;
	var zTreeSelectM = layui.zTreeSelectM;

	
	 form.on('select(companyid)', function(data){
		 if(data.value!=""){
			 getSjpz(data.value);
			 var rt = $("#xkpz").val();
			 var relatedtype = rt.split(',');
			 relatedtype = turnNums(relatedtype);
			 
			 var _zTreeSelectM = zTreeSelectM({
				    elem: '#relatedtype',//元素容器【必填】          
				    data: '<c:url value="/getbasicMsgJSON.do"/>?basicType='+50,
				    type: 'get',  //设置了长度    
				    selected: relatedtype,//默认值            
				    max: 20,//最多选中个数，默认5            
				    name: 'relatedtype',//input的name 不设置与选择器相同(去#.)
				    delimiter: ',',//值的分隔符           
				    field: { idName: 'id', titleName: 'name' },//候选项数据的键名 
				    tips: '涉及品种：',
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
				
				var companyname = $("#companyid").find("option:selected").text();
				$("#companyname").val(companyname);
			 
			 form.render();
			 
		 }
	 });
	
	//监听提交 创建一个上传组件
	var listview = $("#vehicle_att_list");
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
			addVehicle();
		}
		,error: function(){
			//执行上传请求出现异常的回调
			console.log("图片上传失败");
		}
	});
	
	form.render();
	
	form.on('submit(demoVehicle)',function(data){
		if(choose_pic > 0){
			$("#upload_files").click();
		}else{
			addVehicle();
		}
		var index1 = top.layer.msg('数据提交中...',{icon:16,time:false,shade:0.8});
		setTimeout(function(){
	   		top.layer.close(index1);
	   	},800);
	  	return false;
	});
	
	function addVehicle(){
		
		
		$("#form_vehicle").ajaxSubmit({
			url:		'<c:url value="/addVehicle.do"/>',
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
		 		        parent.$("#search").click();
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
