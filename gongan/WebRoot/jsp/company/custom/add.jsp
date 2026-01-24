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
    
    <title>添加单位页面</title>
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/js/jquery.form.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/cardnumber.js"/>"></script>
  	<link rel="stylesheet" href="<c:url value='/css/public.css'/>" media="all" />
  	
</head>
<body>
<form class="layui-form" method="post" id="form1" onsubmit="return false;">

	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 5px;">
		<legend>添加单位基本信息</legend>
	</fieldset>
	
	<input type="hidden" name="menuid" id="menuid" value=${param.menuid } />
	<input type="hidden" name="companytype" id="companytype" value='${param.companytype}' />
	
	<div class="layui-form-item">
		<div class="layui-inline">
	      	<label class="layui-form-label"><font color="red" size=2>*</font>社会统一征信代码</label>
	    	<div class="layui-input-inline">
	      		<input type="text" class="layui-input" name="companycode" id="companycode" lay-verify="required|checkcode" autocomplete="off" lay-reqtext="请输入征信代码"/>
	    	</div>
		</div>
		<div class="layui-inline">
			<label class="layui-form-label"><font color="red" size=2>*</font>单位名称</label>
			<div class="layui-input-inline">
	      		<input type="text" class="layui-input" name="companyname" id="companyname" lay-verify="required" autocomplete="off" lay-reqtext="请输入单位名称"/>
	      	</div>
      	</div>
	</div>
    <div class="layui-form-item">
    	<div id="labels">
    	</div>
  	</div>
	<div class="layui-form-item">
		<div class="layui-inline">
			<label class="layui-form-label">单位大类</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" value="${param.companytypename}" readonly="true" />
			</div>
		</div>
	</div>
	<div id="details">
	<div class="layui-form-item">
		<div class="layui-block">
			<label class="layui-form-label">单位类型</label>
	    	<div class="layui-input-block">
	      		<input type="checkbox" class="parent" name="affecttype" lay-skin="primary" value="生产" title="生产" />
	      		<input type="checkbox" class="parent" name="affecttype" lay-skin="primary" value="经营" title="经营" />
	      		<input type="checkbox" class="parent" name="affecttype" lay-skin="primary" value="使用" title="使用" />
	      		<input type="checkbox" class="parent" name="affecttype" lay-skin="primary" value="运输" title="运输" />
	      		<input type="checkbox" class="parent" name="affecttype" lay-skin="primary" value="仓储" title="仓储" />
	    	</div>
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">涉及品种</label>
		<div class="layui-input-inline" style="width:670px;">
	  		<div id="managetype"></div>
		</div>
	</div>
	
	<div class="layui-form-item">
		<div class="layui-inline">
	    	<label class="layui-form-label">企业状态</label>
	    	<div class="layui-input-inline">
	    		<select id="companystatus" name="companystatus">
	    			<option value="正常" selected>正常</option>
	    			<option value="停用">停用</option>
	    		</select>
	    	</div>
		</div>
		<div class="layui-inline">
			<label class="layui-form-label">停用原因</label>
	    	<div class="layui-input-inline">
	      		<select id="unusedreason" name="unusedreason">
	      			<option disabled  value="" selected>未停用可不选</option>
	      			<option value="工艺改进">工艺改进</option>
	      			<option value="政策关停">政策关停</option>
	      			<option value="其他">其他</option>
	      		</select>
	      	</div>
		</div>
	</div>

    <div class="layui-form-item">
    	<div class="layui-inline">
		<label class="layui-form-label">是否入网</label>
			<div class="layui-input-inline">
		  		<select id="innet" name="innet" style="width:170px;" lay-verify="required">
			 		<option value="1" selected>是</option>
			 		<option value="2">否</option>
			 	</select>
			</div>
		</div>
    	<div class="layui-inline">
    		<label class="layui-form-label">联系电话</label>
	    	<div class="layui-input-inline">
	      		<input type="text" class="layui-input" name="telephone" id="telephone" autocomplete="off" />
	    	</div>
    	</div>
    </div>
    
	<div class="layui-form-item">
    	<div class="layui-inline">
	    	<label class="layui-form-label">经营范围</label>
	    	<div class="layui-input-inline">
	      		<input type="text" class="layui-input" name="managerange" id="managerange" style="width:670px;" autocomplete="off" />
	    	</div>
    	</div>
    </div>
	
    <div class="layui-form-item">
	    <div class="layui-inline">
			<label class="layui-form-label">注册地所属辖区</label>
			<div class="layui-input-inline" id="ZCDXQ">
		  		<input type="text" class="layui-input" name="registerowner" id="registerowner" lay-filter="registerowner" autocomplete="off"/>
			</div>
		</div>
	    <div class="layui-inline">
			<label class="layui-form-label">办公地所属辖区</label>
			<div class="layui-input-inline" id="BGDXQ">
		  		<input type="text" class="layui-input" name="realworkowner" id="realworkowner" lay-filter="realworkowner" autocomplete="off"/>
			</div>
		</div>
	</div>

    <div class="layui-form-item">
		<div class="layui-inline">
	    	<label class="layui-form-label">注册地详址</label>
	    	<div class="layui-input-inline">
	      		<input type="text" class="layui-input" name="registerplace" id="registerplace" style="width:670px;" autocomplete="off"/>
	    	</div>
		</div>
	</div>
	<div class="layui-form-item">
		<div class="layui-inline">
	    	<label class="layui-form-label">实际办公地详址</label>
	    	<div class="layui-input-inline">
	      		<input type="text" class="layui-input" name="realworkplace" id="realworkplace" onclick="openPGis();" readonly style="background:#efefef;cursor:pointer;width:670px;" autocomplete="off"/>
	    	</div>
		</div>
	</div>

	<div class="layui-form-item">
		<div class="layui-inline">
	    	<label class="layui-form-label">经度</label>
	    	<div class="layui-input-inline">
	      		<input type="text" class="layui-input" name="longitude" id="longitude" onclick="openPGis();" readonly style="background:#efefef;cursor:pointer;" autocomplete="off"/>
	    	</div>
	    </div>
	    <div class="layui-inline">
	    	<label class="layui-form-label">纬度</label>
	    	<div class="layui-input-inline">
	      		<input type="text" class="layui-input" name="latitude" id="latitude" onclick="openPGis();" readonly style="background:#efefef;cursor:pointer;" autocomplete="off" />
	    	</div>
		</div>
	</div>
	
    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
		<legend>添加法人信息</legend>
	</fieldset>
    
    <div class="layui-form-item">
    	<div class="layui-inline">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>姓名</label>
	    	<div class="layui-input-inline">
	      		<input type="text" class="layui-input" name="legalname" id="legalname" lay-verify="required" autocomplete="off" lay-reqtext="请输入姓名"/>
	    	</div>
    	</div>
    	<div class="layui-inline">
	    	<label class="layui-form-label">性别</label>
	    	<div class="layui-input-inline">
	    		<input type="radio" name="sexes" value="男" title="男" checked />
	    		<input type="radio" name="sexes" value="女" title="女" />
	    	</div>
    	</div>
    </div>
    
    <div class="layui-form-item">
	    <div class="layui-inline">
			<label class="layui-form-label"><font color="red" size=2>*</font>证件类型</label>
			<div class="layui-input-inline">
				<select id="zjlx" name="zjlx" style="width:170px;"></select>
			</div>
		</div>
    	<div class="layui-inline">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>证件号码</label>
	    	<div class="layui-input-inline">
	      		<input type="text" class="layui-input" name="cardnumber" id="cardnumber" lay-verify="required" autocomplete="off" lay-reqtext="证件号码不能为空"/>
	    	</div>
    	</div>
    </div>
    
    <div class="layui-form-item">
	    <div class="layui-inline">
			<label class="layui-form-label">民族</label>
			<div class="layui-input-inline">
		  		<select name="nation" id="nation"></select>
			</div>
		</div>
    	<div class="layui-inline">
	    	<label class="layui-form-label">文化程度</label>
	    	<div class="layui-input-inline">
	    		<select name="education" id="education"></select>
	    	</div>
    	</div>
    </div>
    
    <div class="layui-form-item">
	    <div class="layui-inline">
			<label class="layui-form-label">政治面貌</label>
			<div class="layui-input-inline">
		  		<select name="politicalposition" id="politicalposition"></select>
			</div>
		</div>
    	<div class="layui-inline">
	    	<label class="layui-form-label">联系电话</label>
	    	<div class="layui-input-inline">
	      		<input type="text" class="layui-input" name="legalphone" id="legalphone" autocomplete="off"/>
	    	</div>
    	</div>
    </div>
   
    <div class="layui-form-item">
	    <div class="layui-inline">
			<label class="layui-form-label">户籍地详址</label>
			<div class="layui-input-inline">
		  		<input type="text" class="layui-input" name="homeplace" id="homeplace" style="width:670px;" autocomplete="off"/>
			</div>
		</div>
    </div>
	
    <div class="layui-form-item">
    	<div class="layui-inline">
	    	<label class="layui-form-label">现住地详址</label>
	    	<div class="layui-input-inline">
	      		<input type="text" class="layui-input" name="lifeplace" id="lifeplace" style="width:670px;" autocomplete="off"/>
	    	</div>
    	</div>
    </div>
    
    <div class="layui-form-item">
    	<div class="layui-input-block" style="width:70%">
    		<button type="button" style="display:none" id="upload_pic">图片提交按钮(不显示 js中设置触发)</button>
    		<button type="button" class="layui-btn" id="picture"><i class="layui-icon">&#xe67c;</i>上传营业执照</button>
    		<button type="button" class="layui-btn" onclick="repic();"><i class="layui-icon">&#xe67c;</i>清空营业执照</button>
    		<div class="layui-upload" style="margin-top:10px;">
	    		<blockquote class="layui-elem-quote layui-quote-nm">
	    			<div class="layui-upload-list" id="showlist" style="overflow:hodden;height:120px;" ></div>
	    		</blockquote>
	    	</div>
	    </div>
	    <input type="hidden" name="codephoto" id="codephoto" value=""/>
    </div>
    
  	<div class="layui-form-item layui-form-text">
  		<label class="layui-form-label">备注信息</label>
     	<div class="layui-input-inline" style="width:670px;">
     		<textarea name="memo" id="memo" class="layui-textarea"></textarea>
     	</div>
    </div>
    </div>
  	
	<div class="layui-form-item">
	    <div class="layui-input-block">
	      <button type="submit" class="layui-btn" lay-submit="" lay-filter="companySub">立即提交</button>
	      <button type="reset" class="layui-btn layui-btn-primary" id="companyReset">重置</button>
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
		$(".demo-delete").click();
		recordingFileid = "";
		choose_pic = 0;
		$("#codephoto").val(recordingFileid);
	}
	//获取民族数据字典
	function getNation(){
		$.ajax({
			type:		'POST',
			url:		'<c:url value="/getBMByTypeToJSON1.do"/>?basicType='+15,
			dataType:	'json',
			async:		false,
			success:	function(data){
				var options = fillOption(data);
				options = '<option value="" selected>---请选择---</option>'+options;
				$("select[name^=nation]").html(options);
			}
		});
	}
	//获取政治面貌数据字典
	function getPoliticalPosition(){
		$.ajax({
			type:		'POST',
			url:		'<c:url value="/getBMByTypeToJSON1.do"/>?basicType='+17,
			dataType:	'json',
			async:		false,
			success:	function(data){
				var options = fillOption(data);
				options = '<option value="" selected>---请选择---</option>'+options;
				$("select[name^=politicalposition]").html(options);
			}
		});
	}
	//获取文化程度数据字典
	function getEducation(){
		$.ajax({
			type:		'POST',
			url:		'<c:url value="/getBMByTypeToJSON1.do"/>?basicType='+19,
			dataType:	'json',
			async:		false,
			success:	function(data){
				var options = fillOption(data);
				options = '<option value="" selected>---请选择---</option>'+options;
				$("select[name^=education]").html(options);
			}
		});
	}
	//获取证件类型字典
	function getZjlx(){
		$.ajax({
			type:		'POST',
			url:		'<c:url value="/getBMByTypeToJSON1.do"/>?basicType='+61,
			dataType:	'json',
			async:		false,
			success:	function(data){
				var options = fillOption(data);
				options = '<option value="身份证" selected>身份证</option>'+options;
				$("select[name^=zjlx]").html(options);
			}
		});
	}
	
	$(document).ready(function(){
		getNation();
		getPoliticalPosition();
		getEducation();
		getZjlx();
	});
	
	layui.use(['form','upload','treeSelect','zTreeSelectM'],function(){
		var form = layui.form;
		var upload = layui.upload;//得到upload对象
		var layer = layui.layer;
		var zTreeSelectM = layui.zTreeSelectM;
		var treeSelect = layui.treeSelect;
		
		//初始化风险类别
		var _zTreeSelectM = zTreeSelectM({
		    elem: '#managetype',//元素容器【必填】          
		    data: '<c:url value="/getbasicMsgJSON.do"/>?basicType='+50,
		    type: 'get',  //设置了长度    
		    selected: [],//默认值            
		    max: 20,//最多选中个数，默认5            
		    name: 'managetype',//input的name 不设置与选择器相同(去#.)
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
		
		treeSelect.render({
			elem:	'#registerowner',	//选择器
			data:	'<c:url value="/getDepartmentTree.do"/>',
			type:	'get',	//异步加载
			placeholder:	'所属辖区',
			search:	false,
			style:	{
				folder:	{enable: false},
				line:	{enable: true}
			},
			click: function(d){
			}
		});
		
		treeSelect.render({
			elem:	'#realworkowner',
			data:	'<c:url value="/getDepartmentTree.do"/>',
			type:	'get',	//异步加载
			placeholder:	'所属辖区',
			search:	false,
			style:	{
				folder:	{enable: false},
				line:	{enable: true}
			},
			click: function(d){
			}
		});
		
		//监听提交 创建一个上传组件
		var listview = $("#showlist");
		var uploadInst = upload.render({
			elem:		'#picture', //绑定元素(按钮)
			url:		'<c:url value="/newuploadfile.do"/>', //上传接口
			accept:		'images', //file video audio images 允许的文件类型
			acceptMine:	'image/*',//规定打开文件选择框时，筛选出的文件类型 acceptMime:'image/*'（只显示图片文件）
			multiple:	true,	//多文件上传
			auto:		false,	//自动上传,默认是打开的
			bindAction:	'#upload_pic',	//auto为false时，点击触发上传
			choose:	function(obj){
				var files = this.files = obj.pushFile();
				choose_pic++;
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
				$("#codephoto").val(recordingFileid);
				console.log("图片上传成功");
				addCompany();
			}
			,error: function(){
				//执行上传请求出现异常的回调
				console.log("图片上传失败");
			}
		});
		
		form.render();
		
		form.on('submit(companySub)',function(data){
			if(choose_pic > 0){
				$("#upload_pic").click();
			}else{
				addCompany();
			}
			var index1 = top.layer.msg('数据提交中...',{icon:16,time:false,shade:0.8});
			setTimeout(function(){
		   		top.layer.close(index1);
		   	},800);
		  	return false;
		});
		
		var details=false;
		$("#companycode").blur(function(){
			$("#labels").empty();
			$("#companyname").val("");
			$("#legalname").val("");
			$("#cardnumber").val("");
			details=false;
			if(this.value!=""){
				$.ajax({
					type:	'post',
					url:	'<c:url value="/checkComCode.do"/>',
					data:	{companycode :  $("#companycode").val()},
					dataType:	'json',
					async:		false,
					success:	function(data){
						if(data.flag){
							$("#companyname").val(data.company.companyname);
							$("#legalname").val(data.company.legalname);
							$("#cardnumber").val(data.company.cardnumber);
							var companytype=data.company.companytype;
							if(companytype&&data.company.companytype!=""){
								companytype=","+companytype+",";
								if(companytype.indexOf(","+$("#companytype").val()+",")!=-1){
									top.layer.alert("该单位已存在${param.companytypename}!!");
								}
								var str1='<label class="layui-form-label">已存在单位大类</label><div class="layui-input-inline" style="padding-left:5px;padding-top:6px;">';
								$.each(data.companyList,function(i,item){
									if(companytype.indexOf(","+item.id+",")!=-1){
										str1+='<span class="my-tag-item3" style="background-color:#1E9FFF;color:white;">'+item.basicName+'</span>';
										details=true;
									}
								});
								str1+="</div>";
			               		$("#labels").html(str1);
							}
						}
						
					}
				});
			}
			if(details){
				$("#details").hide();
			}else{
				$("#details").show();
			}
		});
		
		form.verify({
			checkcode:function(value,item){
				var msg;
				$.ajax({
					type:	'post',
					url:	'<c:url value="/checkComCode.do"/>',
					data:	{companycode :  $("#companycode").val()},
					dataType:	'json',
					async:		false,
					success:	function(data){
						if(data.flag){
							var companytype=data.company.companytype;
							if(companytype&&data.company.companytype!=""){
								companytype=","+companytype+",";
								if(companytype.indexOf(","+$("#companytype").val()+",")!=-1){
									msg = "代码重复";
								}
							}
						}
					}
				});
				return msg;
			}
		});
		
		function addCompany(){
			$("#form1").ajaxSubmit({
				url:		'<c:url value="/addCompany.do"/>',
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
			 		        //刷新父页面
			 		        parent.location.reload();
		               },500);
	              	}else{
	              		layer.msg(obj.msg);
	              	}
				},error:function(){
					alert("请求失败");
				}
			});
		}
		
	});
		
</script>
<script type="text/javascript">
	function openPGis(){
		var place=$("#realworkplace").val().trim();
		var x=$("#longitude").val().trim();
		var y=$("#latitude").val().trim();
		var f1=function(event){
			place=event.data.mc;
			x=event.data.lx;
			y=event.data.ly;
			$("#realworkplace").val(place);
			$("#longitude").val(x);
			$("#latitude").val(y);
			layer.close(index);
			window.removeEventListener('message',f1,false);
		};
		var index = layui.layer.open({
			title : "标准地址",
			type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
			content : 'http://50.64.128.70:8080/ldpt/#/dtMapPoint?dzmc='+place+'&lx='+x+'&ly='+y,
		    area: ['800', '600px'],
			maxmin: true,
			success : function(layero, index){
				setTimeout(function(){
					layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
						tips: 3
					});
				},500)
			},
			cancel:function(){
				window.removeEventListener('message',f1,false);
			}
		})
		layui.layer.full(index);
		window.addEventListener('message',f1);
	}
</script>
</body>
</html>
