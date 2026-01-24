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

	<title>专项标签页面</title>
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
	<script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/js/jquery.form.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
	
</head>
  
<body>
	<form class="layui-form" method="post" id="form_zhuanxiang" onsubmit="return false;">
		<fieldset class="layui-elem-field layui-field-title" style="margin-top: 15px;">
			<legend id="bqname"></legend>
		</fieldset>
		<input type="hidden" id="departmentid" name="departmentid" value="${param.departmentid}"/>
		<input type="hidden" id="informationsendid" name="informationsendid" value="${param.informationsendid}"/>
		<input type="hidden" id="informationid" name="informationid" value="${param.informationid}"/>
		<input type="hidden" id="special" value="${param.special}"/>

		<div class="layui-form-item">
			<button type="button" style="display:none" id="searchzx">(专项标签查询 不显示)</button>
			<div class="demoTable">
				<script type="text/html" id="toolbarzx">
					<button type="button" class="layui-btn layui-btn-sm" lay-event="addzx"><i class="layui-icon layui-icon-add-1"></i>添 加 新 标 签</button>
					<button type="button" class="layui-btn layui-btn-sm" lay-event="updatezx"><i class="layui-icon layui-icon-edit"></i>修 改 标 签 名</button>
					<button type="button" class="layui-btn layui-btn-sm" lay-event="zhuanxiang"><i class="layui-icon"></i> 确   定 </button>
					
				</script>
			</div>
			<table class="layui-hide" id="zxTable" lay-filter="zxTable"></table>
			
		</div>
	</form>
    
<script type="text/javascript">

var locat = (window.location+'').split("/");
$(function(){
	if('main'==locat[3]){locat = locat[0]+'//'+locat[2];}else{locat = locat[0]+'//'+locat[2]+'/'+locat[3];};
});

$(document).ready(function(){
	$("#seachzx").click();
});

var informationid = $("#informationid").val();
var informationsendid = $("#informationsendid").val();

layui.use(['form','table'],function(){
	var form = layui.form;
	var layer = layui.layer;
	var table = layui.table;
	var departmentid = $("#departmentid").val();
	var specialid = $("#special").val();
	
	$("#seachzx").click(function(){
		table.reload('zxTable',{
			page:{
			//重新从第一页开始
			curr:1
			}
		});
	});
	
	table.render({
		elem:'#zxTable',
		toolbar:false,
		url:'<c:url value="/searchInformationSpecial.do"/>?departmentid='+$("#departmentid").val(),
		method:'post',
		toolbar:'#toolbarzx',
		cols: [[
		        {field:'id',hide:true,title:'id'},
		        {field:'id',type:'radio',fixed:'left'},
		        {field:'specialName',title:'标签名称',width:230,align:"center"},
		        {field:'addoperator',title:'归档人',width:230,align:"center"},
		        {field:'addtime',title:'归档时间',width:230,align:"center"},
		        {field:'count',title:'归档数量',width:230,align:"center"}
		]],
		page:true,
		limit:10,
		done: function (res, curr, count) {
	        //利用回调函数进行回显
	        var dataArr = res.data;
	        for (var i = 0; i < dataArr.length; i++) {
	            //如果符合条件那么点击选中
	          if (dataArr[i].id == specialid) {
	        	  $('div.layui-unselect.layui-form-radio')[i].click();
	        	  var namebody = window.document.getElementById("bqname");
	        	  var str = "当前标签:"+dataArr[i].specialName;
	        	  namebody.innerHTML = str;
	          }
	 
	        };
	        form.render();
	     }
	});
	
	table.on('toolbar(zxTable)',function(obj){
		var checkStatus = table.checkStatus(obj.config.id);
	
		switch(obj.event){
			case 'addzx':
				var specialName = "";
				var index = layui.layer.open({
					title:	"添加专项标签",
					type:	2,
					content:locat+"/jsp/information/zhuanxiangbutton.jsp?departmentid="+departmentid+"&page=add&specialName="+specialName+"&id=0&informationid="+informationid+"&informationsendid="+informationsendid,
					area:	['800','200px'],
					maxmin:	true,
					success:function(layero, index){
						setTimeout(function(){
							layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
								tips: 3
							});
						},500)
					}
				});
			break;
			
			case 'updatezx':
				var data = JSON.stringify(checkStatus.data);
				var datas = JSON.parse(data);//深拷贝
				if(datas!=""){
					var id = datas[0].id;
					var specialName = datas[0].specialName;
					var index = layui.layer.open({
						title:	"修改专项标签",
						type:	2,
						content:locat+"/jsp/information/zhuanxiangbutton.jsp?departmentid="+departmentid+"&id="+id+"&specialName="+specialName+"&page=update&informationid="+informationid+"&informationsendid="+informationsendid,
						area:	['800','200px'],
						maxmin:	true,
						success:function(layero, index){
							setTimeout(function(){
								layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
									tips: 3
								});
							},500)
						}
					});
				}else{
					layer.alert("请先选择数据");
				}
			break;
			
			case 'zhuanxiang':
				var data = JSON.stringify(checkStatus.data);
				var datas = JSON.parse(data);//深拷贝
				if(datas!=""){
					var specialid = datas[0].id;
					var specialName = datas[0].specialName;
					var oldspecialid = $("#special").val();
					if(specialid!=oldspecialid){
						$.ajax({
							url:		'<c:url value="/changeInformationSendSpecial.do"/>',
							type:		'post',
							data:		{informationid:informationid,informationsendid:informationsendid,specialid:specialid,specialName:specialName},
							dataType:	'json',
							async:		false,
							success:	function(data){
								var obj = eval('(' + data + ')');
								if(obj.flag>0){
									var index = top.layer.msg('数据提交中...',{icon: 16,time:false,shade:0.8});
									setTimeout(function(){
										top.layer.msg(obj.msg);
										top.layer.close(index);
										parent.layer.closeAll("iframe");
										//刷新父页面
										//parent.location.reload();
										parent.$("#searchInformation").click();
										
									},500);
								}
							},error:function(){
								alert("请求失败");
							}
						});
					}else{
						layer.msg("请选择新标签");
					}
				}else{
					layer.alert("请先选择数据");
				}
			break;
				
		}
	});
	
	form.render();
	
});



    
</script>

</body>
</html>
