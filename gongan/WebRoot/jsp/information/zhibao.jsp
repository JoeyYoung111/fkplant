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

	<title>直报</title>
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
	<script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/js/jquery.form.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/js/cardnumber.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/js/viewer.js"/>"></script>
	
	<style type="text/css">
		.my-tag-close2 {
			background-image: url(./images/query/close.png);
			background-position: center; 
			background-size: 100% 100%;
			position: absolute;
			top: -8px;
			right: -8px;
			width: 16px;
			height: 16px;
			cursor: pointer;
		}
		
		.bg-ctrl1::before {
			content: '';
			vertical-align: middle;
			display: inline-block;
		    width: 20px; height: 20px;
		    background: url('./images/index/nav_item.png') -147px -98px;
		}
		
		.bg-ctrl2::before {
			content: '';
			vertical-align: middle;
			display: inline-block;
		    width: 20px; height: 20px;
		    background: url('./images/index/nav_item.png') -10px -147px;
		}
	</style>
  	
	</head>
<body class="childrenBody layui-fluid">
<form class="layui-form" method="post" id="form_zhibao" onsubmit="return false;">
	
	<input type="hidden" name="menuid" id="menuid" value="${menuid}"/>
	<input type="hidden" name="infoid" id="infoid" value="0"/>
	<input type="hidden" name="infooperate" id="infooperate" value="1"/>
	
	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 15px;">
		<legend>添加直报信息</legend>
	</fieldset>
	<div class="layui-row">
	
		<div class="layui-form-item">
			<div class="layui-col-md1">
		    	<div class="layui-col-md6 layui-col-md-offset6">
			    	<label class="layui-form-label">主报送单位：</label>
		    	</div>
		    </div>
		    <div class="layui-col-md11">
		    	<div class="layui-col-md11">
			    	<div class="layui-input-block">
		      			<input type="text" name="submitunitid" id="submitunitid" class="layui-input" lay-verify="required" lay-reqtext="请选择主报送单位" autocomplete="off"/>
		      			<input type="hidden" name="submitunit" id="submitunit" />
		      		</div>
		    	</div>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-col-md1">
		   		<div class="layui-col-md6 layui-col-md-offset6">
			    	<label class="layui-form-label">其他报送单位：</label>
			    </div>
			</div>
			<div class="layui-col-md11">
		    	<div class="layui-col-md9 layui-input-block">	
	      			<input type="text" class="layui-input" readonly="true" id="otherunit" name="otherunit" autocomplete="off" readonly="true" />
	      			<input type="hidden" class="layui-input" id="otherunitids" name="otherunitids" autocomplete="off" />
	      		</div>
		    	<div class="layui-col-md1">	
		    		<button type="button" class="layui-btn " onclick="openUnits();"><i class="layui-icon layui-icon-add-1"></i>选 择 单 位</button>
		    	</div>
		    </div>
		</div>
		
		<div class="layui-form-item">
			<div class="layui-col-md1">
		    	<div class="layui-col-md6 layui-col-md-offset6">
			    	<label class="layui-form-label">情报来源：</label>
		    	</div>
		    </div>
	    	<div class="layui-col-md11">
		    	<div class="layui-col-md11">
			    	<div class="layui-input-block">
			    		<select name="infosource" id="infosource" lay-filter="infosource"></select>
			    	</div>
			    </div>
			</div>
		</div>
	
		<div class="layui-form-item">
			<div class="layui-col-md6">
		   		<div class="layui-col-md1 layui-col-md-offset1">
			    	<label class="layui-form-label">情报状态：</label>
			    </div>
		    	<div class="layui-col-md9">	
			    	<div class="layui-input-block">
				    	<select name="infostate" lay-filter="infostate">
							<option value="已发生"<c:if test="${informationsend.infostate eq '已发生'}"> selected</c:if>>已发生</option>
							<option value="正发生"<c:if test="${informationsend.infostate eq '正发生'}"> selected</c:if>>正发生</option>
							<option value="未发生"<c:if test="${informationsend.infostate eq '未发生'}"> selected</c:if>>未发生</option>
						</select>
			    	</div>
		    	</div>
			</div>
			<div class="layui-col-md6">
		   		<div class="layui-col-md1 layui-col-md-offset1">
			    	<label class="layui-form-label">紧急程度：</label>
			    </div>
		    	<div class="layui-col-md9">	
			    	<div class="layui-input-block">
				    	<select name="urgentflag" lay-filter="urgentflag">
							<option value="一般"<c:if test="${informationsend.urgentflag eq '一般'}"> selected</c:if>>一般</option>
							<option value="紧急"<c:if test="${informationsend.urgentflag eq '紧急'}"> selected</c:if>>紧急</option>
							<option value="重要"<c:if test="${informationsend.urgentflag eq '重要'}"> selected</c:if>>重要</option>
						</select>
			    	</div>
		    	</div>
			</div>
		</div>
		
		<div class="layui-form-item">
			<div class="layui-col-md6">
		   		<div class="layui-col-md1 layui-col-md-offset1">
			    	<label class="layui-form-label">是否明确：</label>
			    </div>
		    	<div class="layui-col-md9">	
			    	<div class="layui-input-block">
				    	<select name="isclear" lay-filter="isclear">
							<option value="是"<c:if test="${informationsend.infostate eq '是'}"> selected</c:if>>是</option>
							<option value="否"<c:if test="${informationsend.infostate eq '否'}"> selected</c:if>>否</option>
						</select>
			    	</div>
		    	</div>
			</div>
			<div class="layui-col-md6">
		    	<div class="layui-col-md1 layui-col-md-offset1">
			    	<label class="layui-form-label">情报类型：</label>
		    	</div>
		    	<div class="layui-col-md9">	
			    	<div class="layui-input-block">
				    	<select id="infotype" name="infotype" lay-filter="infotype">
							<option value="维稳类信息"<c:if test="${informationsend.infotype eq '维稳类信息'}"> selected</c:if>>维稳类信息</option>
							<option value="治安类信息"<c:if test="${informationsend.infotype eq '治安类信息'}"> selected</c:if>>治安类信息</option>
							<option value="事故类信息"<c:if test="${informationsend.infotype eq '事故类信息'}"> selected</c:if>>事故类信息</option>
							<option value="工作类信息"<c:if test="${informationsend.infotype eq '工作类信息'}"> selected</c:if>>工作类信息</option>
							<option value="民生关注类信息"<c:if test="${informationsend.infotype eq '民生关注类信息'}"> selected</c:if>>民生关注类信息</option>
							<option value="公共安全信息"<c:if test="${informationsend.infotype eq '公共安全信息'}"> selected</c:if>>公共安全信息</option>
							<option value="研判类信息"<c:if test="${informationsend.infotype eq '研判类信息'}"> selected</c:if>>研判类信息</option>
							<option value="互联网警情"<c:if test="${informationsend.infotype eq '互联网警情'}"> selected</c:if>>互联网警情</option>
							<option value="警情涉稳"<c:if test="${informationsend.infotype eq '警情涉稳'}"> selected</c:if>>警情涉稳</option>
							<option value="报部类信息"<c:if test="${informationsend.infotype eq '报部类信息'}"> selected</c:if>>报部类信息</option>
						</select>
			    	</div>
		    	</div>
			</div>
		</div>
		
		<div class="layui-form-item">
			<div class="layui-col-md6">
		   		<div class="layui-col-md1 layui-col-md-offset1">
			    	<label class="layui-form-label">指向地址：</label>
			    </div>
			    <div class="layui-col-md4">
		    		<div class="layui-input-block">
			    		<select id="pointaddress1" name="pointaddress1" lay-filter="pointaddress1">
			    			<option value="">---若明确则选择---</option>
			    			<option value="本市"<c:if test="${informationsend.pointaddress1 eq '本市'}"> selected</c:if>>本市</option>
			    			<option value="省内市外"<c:if test="${informationsend.pointaddress1 eq '省内市外'}"> selected</c:if>>省内市外</option>
			    			<option value="重点城市"<c:if test="${informationsend.pointaddress1 eq '重点城市'}"> selected</c:if>>重点城市</option>
			    		</select>
			    	</div>
		    	</div>
		    	<div class="layui-col-md5">
		    		<div class="layui-input-block">
			    		<select id="pointaddress2" name="pointaddress2" lay-filter="pointaddress2"></select>
			    	</div>
		    	</div>
			</div>
			<div class="layui-col-md6">
		   		<div class="layui-col-md1 layui-col-md-offset1">
			    	<label class="layui-form-label">地址描述：</label>
			    </div>
			    <div class="layui-col-md9">
			    	<div class="layui-input-block">
			    	<input type="text" name="pointaddress3" id="pointaddress3" class="layui-input" value="${informationsend.pointaddress3}" lay-reqtext="请输入地址描述" autocomplete="off"/>
		    		</div>
		    	</div>
			</div>
		</div>
		
		<div class="layui-form-item">
			<div class="layui-col-md6">
				<div class="layui-col-md1 layui-col-md-offset1">
					<label class="layui-form-label">核稿人：</label>
				</div>
				<div class="layui-col-md9">
					<div class="layui-input-block">
						<input type="text" name="reviewer" class="layui-input" value="${informationsend.reviewer}" lay-verify="required" lay-reqtext="请输入核稿人" autocomplete="off"/>
					</div>
				</div>
			</div>
			<div class="layui-col-md6">
				<div class="layui-col-md1 layui-col-md-offset1">
					<label class="layui-form-label">签发人：</label>
				</div>
				<div class="layui-col-md9">
					<div class="layui-input-block">
						<input type="text" name="issuer" class="layui-input" value="${informationsend.issuer}" lay-verify="required" lay-reqtext="请输入签发人" autocomplete="off"/>
					</div>
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
						<input type="text" name="infotitle" class="layui-input" value="${informationsend.infotitle}" lay-verify="required" lay-reqtext="请输入标题" autocomplete="off"/>
					</div>
				</div>
			</div>
		</div>
		
		<div class="layui-form-item">
			<div class="layui-col-md3">
				<div class="layui-col-md6 layui-col-md-offset6 layui-form-mid layui-word-aux">备注：人员填写规范</div>
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
						<textarea id="infocontent" class="layui-textarea">${informationsend.infocontent}</textarea>
					</div>
				</div>
			</div>
		</div>
		
		<div class="layui-form-item">
			<div class="layui-col-md2"><span>&nbsp;</span></div>
			<div class="layui-col-md3">
				<button type="button" style="display:none" id="upload_files">附件上传(hidden)</button>
				<button type="button" class="layui-btn" id="files"><i class="layui-icon">&#xe67c;</i>选择附件</button>
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
					    				<tr id="upload">
					    					<td id="showfiles"><a>${row.fileName }</a></td>
					    					<td>上传完成</td>
					    					<td>
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
		    <input type="hidden" name="attachments" id="attachments" value=""/>
		    <input type="hidden" name="remainStateid" id="remainStateid" />
		    <input type="hidden" name="delidstr" id="delidstr" value="" />
	    </div>
	    
	    <div class="layui-form-item">
	    	<div class="layui-col-md1">
	    		<div class="layui-col-md6 layui-col-md-offset6">
	    			<label class="layui-form-label">涉及人员：</label>
	    		</div>
	    	</div>
	    	<input type="hidden" id="dataCount" value="${dataCount}"/>
	    	<div class="layui-col-md11">
	    		<div class="layui-col-md11">
	    			
		    		<div class="layui-input-block">
						<!-- 需要使用数据表格 -->
						<table class="layui-table" lay-size="sm" lay-filter="demoEvent">
							<colgroup>
								<col width="10">
								<col width="250">
								<col width="250">
								<col width="150">
								<col width="280">
								<col width="170">
								<col width="170">
								<col width="170">
								<col width="280">
							</colgroup>
							<thead>
								<tr>
									<th colspan="9">
										<button class="layui-btn layui-bg-green layui-btn-sm layui-icon my-btn-more"
											lay-event="daoru">&#xe624; 导入</button>
									</th>
								</tr>
								<tr>
									<th><a href="javascript:;" class="bg-ctrl1 js_table_edit_customer_add"></a></th>
									<th>身份证号</th>
									<th>联系方式</th>
									<th>姓名</th>
									<th>户籍</th>
									<th>昵称</th>
									<th>微信</th>
									<th>QQ</th>
									<th>现居地</th>
								</tr>
							</thead>
							<tbody id="table-body">
								<c:forEach items="${infoJointList}" var="row" varStatus="num">
									<tr>
										<td>
										<a href="javascript:;" class="bg-ctrl2 my-btn-a js_table_edit_customer_reduce" ></a>
										</td>
										<td>
											<input type="text" id="jointCardNumber${num.index}" value="${row.jointCardNumber}" class="layui-input" readonly="true" />
										</td>
										<td>
											<input type="text" id="jointTelephone${num.index}" value="${row.jointTelephone}" class="layui-input" readonly="true" />
										</td>
										<td>
											<input type="text" id="jointName${num.index}" value="${row.jointName}" class="layui-input" readonly="true" />
										</td>
										<td>
											<input type="text" id="jointHousePlace${num.index}" value="${row.jointHousePlace}" class="layui-input" readonly="true" />
										</td>
										<td>
											<input type="text" id="jointNickName${num.index}" value="${row.jointNickName}" class="layui-input" readonly="true" />
										</td>
										<td>
											<input type="text" id="jointWechat${num.index}" value="${row.jointWechat}" class="layui-input" readonly="true" />
										</td>
										<td>
											<input type="text" id="jointQQ${num.index}" value="${row.jointQQ}" class="layui-input" readonly="true" />
										</td>
										<td>
											<input type="text" id="jointHomePlace${num.index}" value="${row.jointHomePlace}" class="layui-input" readonly="true" />
										</td>
									</tr>
									<input type="hidden" id="isAdd${num.index}" value="2"/>
								</c:forEach>
							</tbody>
						</table>
					</div>
	    		
	    		</div>
	    	</div>
	    </div>
		
	</div>
	
    <div class="layui-form-item layui-col-md3 layui-col-lg-offset5">
		<div class="layui-input-block">
			<button class="layui-btn layui-btn-sm" lay-submit="" lay-filter="demoInformation">立即提交</button>
			<button type="reset" class="layui-btn layui-btn-primary layui-btn-sm">重置</button>
		</div>
	</div>
	  	
</form>

<script type="text/javascript">

var locat = (window.location+'').split('/'); 
$(function(){if('main'== locat[3]){locat =  locat[0]+'//'+locat[2];}else{locat =  locat[0]+'//'+locat[2]+'/'+locat[3];};});

var page = "zhibao";

layui.config({
    base: "<c:url value="/layui/lay/modules/"/>"
}).extend({
	zTreeSelectM: "zTreeSelectM/zTreeSelectM",
    treeSelect: "treeSelect"
});

function cancelfiles(id,obj){
	var tempstr = $("#delidstr").val()+id+",";
	$("#delidstr").val(tempstr);
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

function getinfosource(){
	$.ajax({
		type:		'post',
		url:		'<c:url value="/getBMByTypeToJSON1.do"/>?basicType='+71,
		dataType:	'json',
		async:		false,
		success:	function(data){
			var options = fillOption(data);
			$("select[name^=infosource]").html(options);
		}
	});
}

function getPointAddress(id){
	$.ajax({
		type:'post',
		url:'<c:url value="/getBMByTypeToJSON1.do"/>?basicType='+id,
		dataType:'json',
		async:false,
		success:function(data){
			var options = fillOption(data);
			$("select[name^=pointaddress2]").html(options);
			$("#pointaddress2").val("${informationsend.pointaddress2}");
		}
	});
}

function openUnits(){
	var index = layui.layer.open({
		title :	"其他报送部门",
		type:	2,
		content:'<c:url value="/jsp/information/units.jsp"/>?idlist1='+$("#submitunitid").val()+"&idlist2="+$("#otherunitids").val(),
		area:	['1000px','780px'],
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
	getinfosource();
	$("#infosource").val("${informationsend.infosource}");
	
	var pa = "${informationsend.pointaddress1}";
	if(pa == '本市'){
		getPointAddress(45);
	}else if(pa == '省内市外'){
		getPointAddress(46);
	}else if(pa == '重点城市'){
		getPointAddress(47);
	}
	
});

var i = $("#dataCount").val();

layui.use(['form','upload','zTreeSelectM','layedit','treeSelect','zTreeSelectM'],function(){
	var form = layui.form;
	var upload = layui.upload;//得到upload对象
	var layer = layui.layer;
	var zTreeSelectM = layui.zTreeSelectM;
	var treeSelect = layui.treeSelect;
	
	var layedit = layui.layedit;
	
	layedit.set({
		uploadImage: {
			url: '<c:url value="/leuploadFile.do"/>', //接口url
			type: 'post' //默认post
		}
	});
	
	var index = layedit.build('infocontent',{
		tool: [ 'strong','italic','underline','del' ,'|','left','center','right','link','unlink','image','face'],
	});
	
	//增加涉及人员
	$(".js_table_edit_customer_add").click(function (){
		i++;
		var str = '<tr><td><a href="javascript:;" class="bg-ctrl2 my-btn-a js_table_edit_customer_reduce" ></a></td>'
			+ '<td><input type="text" id="jointCardNumber'+i+'" class="layui-input" onblur="getpersonelname('+i+');"></td>'
			+ '<td><input type="text" id="jointTelephone'+i+'" class="layui-input"></td>'
			+ '<td><input type="text" id="jointName'+i+'" class="layui-input"></td>'
			+ '<td><input type="text" id="jointHousePlace'+i+'" class="layui-input"></td>'
			+ '<td><input type="text" id="jointNickName'+i+'" class="layui-input"></td>'
			+ '<td><input type="text" id="jointWechat'+i+'" class="layui-input"></td>'
			+ '<td><input type="text" id="jointQQ'+i+'" class="layui-input"></td>'
			+ '<td><input type="text" id="jointHomePlace'+i+'" class="layui-input"></td>'
			+ '</tr>'
			+ '<input type="hidden" id="isAdd'+i+'" value="1"/>';
		$('#table-body').append(str);
	});
	//删除涉及人员
	$(document).on("click",".js_table_edit_customer_reduce",function(){
		$(this).parents('tr').remove();
	});
	
	treeSelect.render({
		elem:	'#submitunitid',
		data:	'<c:url value="/getDepartmentTree.do"/>',
		type:	'get',
		placeholder:	'主报送单位',
		search:	false,
		style:	{
			folder:	{enable: false},
			line:	{enable: true}
		},
		click: function(d){
			$("#submitunit").val(d.current.title);
		}
	});
	
	//监听提交 创建一个上传组件
	var choose_files = 0;
	var listview = $("#filelist");
	var fileidstr = "";
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
	   		addzhibao();
	    }
	    ,error: function(){
	      var tr = listview.find('tr#upload-'+index),
	      tds = tr.children();
	      tds.eq(2).html('<span style="color:#FF5722;">上传失败</span>');
	      tds.eq(3).html('.demo-reload').removeClass('layui-hide');//清空操作
	    }
	});
	
	form.on('select(pointaddress1)',function(data){
		var id = 0;
		if(data.value == '本市'){
			id=45;
		}else if(data.value == '省内市外'){
			id=46;
		}else if(data.value == '重点城市'){
			id=47;
		}else{
			id=0;
		}
		getPointAddress(id);
		form.render('select');
	});
	
	form.render();
	
	form.on('submit(demoInformation)',function(data){
		var zhuid = $("#submitunitid").val();
		var qitaid = $("#otherunitids").val();
		var qilist = qitaid.split(",");
		if(qilist.indexOf(zhuid)>=0){
			layui.layer.alert("报送单位重复");
			return;
		}
		if(choose_files < 1){
			addzhibao();
		}else{
			$("#upload_files").click();
		}
		var index1 = top.layer.msg('数据提交中...',{icon:16,time:false,shade:0.8});
		setTimeout(function(){
	   		top.layer.close(index1);
	   	},800);
	  	return false;
	});
	
	function addzhibao(){
		
		$("#form_zhibao").ajaxSubmit({
			url:		'<c:url value="/addInformation.do"/>',
			dataType:	'json',
			data:		{
				infocontent:	layedit.getContent(index),
				page:			page
			},
			async:		false,
			success:	function(data) {
				var obj = eval('(' + data + ')');
              	if(obj.flag>0){
              		var id = obj.flag;
              		
              		for(var j=0;j<=i;j++){
              			var num = $("#jointCardNumber"+j).val();
              			if(num!=null && num.length>0){
              				$.ajax({
              					url:	'<c:url value="/addInfoJointPerson.do"/>',
              					type:	'post',
              					data:	{
              						jointCardNumber:	$("#jointCardNumber"+j).val(),
              						jointTelephone:		$("#jointTelephone"+j).val(),
              						jointName:			$("#jointName"+j).val(),
              						jointNickName:		$("#jointNickName"+j).val(),
              						jointWechat:		$("#jointWechat"+j).val(),
              						jointQQ:			$("#jointQQ"+j).val(),
              						jointHousePlace:	$("#jointHousePlace"+j).val(),
              						jointHomePlace:		$("#jointHomePlace"+j).val(),
              						isAdd:				$("#isAdd"+j).val(),
              						infoTId:			id
              					},
              					dataType:'json',
              					success:	function(result){
              					}
              				});
              			}
              		}
              		
              		var unitids = $("#submitunitid").val();
              		if($("#otherunitids").val()!=""){
              			unitids += ","+$("#otherunitids").val();
              		}
              		if(unitids!=""){
              				$.ajax({
              					url:	'<c:url value="/addInformationSend.do"/>',
              					type:	'post',
              					data:	{
              						informationid:	id,
              						receiveidList:	unitids,
              						topflag:		0,
              						hideflag:		0,
              						followflag:		0,
              						page:			page
              					},
              					dataType:'json',
              					success:	function(result){
              					}
              				});
              			
              		}
              		
              	   //弹出loading
		            var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
	                setTimeout(function(){         
		                top.layer.msg(obj.msg);
		                top.layer.close(index);
				        layer.closeAll("iframe");
				        parent.layer.closeAll("iframe");
		 		        parent.$("#searchInformationReport").click();
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

function getpersonelname(i){
	var cardnumber = $("#jointCardNumber"+i).val();
	if(cardnumber!=''){
		$("#jointName"+i).attr("lay-verify","required");
		$.getJSON(locat+"/infoJointpersonelname.do?cardnumber="+cardnumber,{},function(data){
			var str = eval('('+data+')');
			if(str.flag>0){
				$("#jointTelephone"+i).val(str.jointTelephone);
				$("#jointName"+i).val(str.jointName);
				$("#jointNickName"+i).val(str.jointNickName);
				$("#jointHousePlace"+i).val(str.jointHousePlace);
				$("#jointHomePlace"+i).val(str.jointHomePlace);
				$("#isAdd"+i).val("2");
			}
		});
	}
}
		
</script>

</body>
</html>
