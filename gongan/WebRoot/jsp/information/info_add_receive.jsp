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

	<title>转阅情报</title>
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
	<script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/js/jquery.form.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/js/cardnumber.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/js/viewer.js"/>"></script>
	
	</head>
<body class="childrenBody layui-fluid">
<form class="layui-form" method="post" id="add_receive" onsubmit="return false;">

	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 15px;">
		<legend>转阅情报信息</legend>
	</fieldset>
	<div class="layui-row">
	
		<input type="hidden" id="informationid" name="informationid" value="${informationsend.informationid}"/>
		<input type="hidden" id="informationsendid" name="informationsendid" value="${informationsend.id}"/>
		<input type="hidden" id="receiveidlist"/>
		
		<div class="layui-form-item">
			<div class="layui-col-md1">
		   		<div class="layui-col-md6 layui-col-md-offset6">
			    	<label class="layui-form-label">转阅单位：</label>
			    </div>
			</div>
			<div class="layui-col-md11">
		    	<div class="layui-col-md10 layui-input-block">	
		    		<input type="text" class="layui-input" id="otherunit" name="otherunit" lay-verify="required" lay-reqtext="请选择转阅部门" readonly="true" autocomplete="off"/>
	      			<input type="hidden" id="otherunitids" name="otherunitids"/>
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
			    		<input type="text" class="layui-input" value="${informationsend.infosource}" readonly="true" />
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
			    		<input type="text" class="layui-input" value="${informationsend.infostate}" readonly="true" />
			    	</div>
		    	</div>
			</div>
			<div class="layui-col-md6">
		   		<div class="layui-col-md1 layui-col-md-offset1">
			    	<label class="layui-form-label">紧急程度：</label>
			    </div>
		    	<div class="layui-col-md9">	
			    	<div class="layui-input-block">
			    		<input type="text" class="layui-input" value="${informationsend.urgentflag}" readonly="true" />
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
			    		<input type="text" class="layui-input" value="${informationsend.isclear}" readonly="true" />
			    	</div>
		    	</div>
			</div>
			<div class="layui-col-md6">
		    	<div class="layui-col-md1 layui-col-md-offset1">
			    	<label class="layui-form-label">情报类型：</label>
		    	</div>
		    	<div class="layui-col-md9">	
			    	<div class="layui-input-block">
				    	<input type="text" class="layui-input" value="${informationsend.infotype}" readonly="true" />
			    	</div>
		    	</div>
			</div>
		</div>
		
		<div class="layui-form-item">
			<div class="layui-col-md6">
		   		<div class="layui-col-md1 layui-col-md-offset1">
			    	<label class="layui-form-label">指向地址1：</label>
			    </div>
			    <div class="layui-col-md9">
			    	<div class="layui-input-block">
		    			<input type="text" class="layui-input" value="${informationsend.pointaddress1}" readonly="true" />
		    		</div>
		    	</div>
			</div>
			<div class="layui-col-md6">
		   		<div class="layui-col-md1 layui-col-md-offset1">
			    	<label class="layui-form-label">指向地址2：</label>
			    </div>
			    <div class="layui-col-md9">
			    	<div class="layui-input-block">
		    			<input type="text" class="layui-input" value="${informationsend.pointaddress2}" readonly="true" />
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
						<input type="text" value="${informationsend.reviewer}" class="layui-input" readonly="true"/>
					</div>
				</div>
			</div>
			<div class="layui-col-md6">
				<div class="layui-col-md1 layui-col-md-offset1">
					<label class="layui-form-label">签发人：</label>
				</div>
				<div class="layui-col-md9">
					<div class="layui-input-block">
						<input type="text" value="${informationsend.issuer}" class="layui-input" readonly="true"/>
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
						<input type="text" value="${informationsend.infotitle}" class="layui-input" readonly="true"/>
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
					    				<tr>
					    					<td id="showfiles"><a>${row.fileName }</a></td>
					    					<td>上传完成</td>
					    					<td>
					    						<a href="<c:url value="/downUpfile.do" />?fileid=${row.id }">
					    							<button class="layui-btn layui-btn-xs" type="button">点击下载</button>
					    						</a>
					    					</td>
					    				</tr>
					    			</c:forEach>
					    		</tbody>
					    	</table>
					    </div>
		    		</div>
		    	</div>
	    	</div>
	    </div>
	    
	    <div class="layui-form-item">
	    	<div class="layui-col-md1">
	    		<div class="layui-col-md6 layui-col-md-offset6">
	    			<label class="layui-form-label">涉及人员：</label>
	    		</div>
	    	</div>
	    	<div class="layui-col-md11">
	    		<div class="layui-col-md11">
	    			
		    		<div class="layui-input-block">
						<!-- 需要使用数据表格 -->
						<table class="layui-table" lay-size="sm" lay-filter="demoEvent">
							<colgroup>
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
										<input type="text" value="${row.jointCardNumber}" class="layui-input" readonly="true" />
									</td>
									<td>
										<input type="text" value="${row.jointTelephone}" class="layui-input" readonly="true" />
									</td>
									<td>
										<input type="text" value="${row.jointName}" class="layui-input" readonly="true" />
									</td>
									<td>
										<input type="text" value="${row.jointHousePlace}" class="layui-input" readonly="true" />
									</td>
									<td>
										<input type="text" value="${row.jointNickName}" class="layui-input" readonly="true" />
									</td>
									<td>
										<input type="text" value="${row.jointWechat}" class="layui-input" readonly="true" />
									</td>
									<td>
										<input type="text" value="${row.jointQQ}" class="layui-input" readonly="true" />
									</td>
									<td>
										<input type="text" value="${row.jointHomePlace}" class="layui-input" readonly="true" />
									</td>
								</tr>
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
		</div>
	</div>
	  	
</form>

<script type="text/javascript">

var locat = (window.location+'').split('/'); 
$(function(){if('main'== locat[3]){locat =  locat[0]+'//'+locat[2];}else{locat =  locat[0]+'//'+locat[2]+'/'+locat[3];};});

function openUnits(){
	var index = layui.layer.open({
		title:	"转阅部门",
		type:	2,
		content:'<c:url value="/jsp/information/units.jsp"/>?idlist1=${idlist}&idlist2='+$("#otherunitids").val(),
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
	 
});

layui.use(['form','layer','layedit'],function(){
	var form = layui.form;
	var layer = layui.layer;
	
	var layedit = layui.layedit;
	
	var index = layedit.build('infocontent',{
		tool: [ 'strong','italic','underline','del' ,'|','left','center','right','link','unlink','image','face'],
	});
	$("#LAY_layedit_1").contents().find("body[contenteditable]").prop("contenteditable", false);
	
	form.render();
	
	form.on('submit(demoInformation)',function(data){
		var newid = $("#otherunitids").val();
		if(newid==null||newid.length==0){
			layui.layer.alert("未选择转阅部门");
			return;
		}
		var index1 = top.layer.msg('数据提交中...',{icon:16,time:false,shade:0.8});
			setTimeout(function(){
				addReceiveInformation();
		   		top.layer.close(index1);
		   	},800);
	  	return false;
	});
	
	function addReceiveInformation(){
		$("#add_receive").ajaxSubmit({
			url:		'<c:url value="/addInformationReceive.do"/>',
			dataType:	'json',
			data:		{
							receiveidlist : $("#otherunitids").val(),
							zylist:$("#otherunit").val()
						},
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


		
</script>

</body>
</html>
