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
    
    <title></title>
    
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  </head>
  
  <body>
	<form class="layui-form" method="post" id="form1" submit="return false;">
		<input type="hidden"  name="id" value=${duty.id }>
		<input type="hidden"  name="menuid" value=${menuid }>
		<input type="hidden"  name="field" value="${duty.field}">
		<div class="layui-form layui-row layui-col-md12" style="padding-top:10px;">
			<div class="layui-col-md5">
				<div class="layui-form-item">
					<div class="layui-input-block">
		    			<div id="users" style="height:360px;"></div>
					</div>
				</div>
			</div>
			<div class="layui-col-md5">
				<div class="layui-form-item">
					<div class="layui-input-block">
		    			<textarea class="layui-textarea" style="height:360px;width:220px;left:-80px;" id="fieldString" rows=5 name="fieldString" placeholder="请填写值班管理修改内容">${duty.fieldString}</textarea>
					</div>
				</div>
			</div>
	  	</div>
		<div class="layui-col-md6 layui-col-md-offset4">
			<div class="layui-form-item">
			    <div class="layui-input-block">
			      <button type="submit" class="layui-btn" lay-submit="" lay-filter="userSub">提交</button>
			    </div>
		  	</div>
	  	</div>
	  	<div style="height:150px;"></div>
	</form>
	<script type="text/javascript">
		var transferData=false;
		function changeTransfer(){
			if(transferData){
				var users=[];
				$.each(transferData.list, function(i, item) {
					$.each(item, function(i) {
						var title=this.text+(this.memo!=undefined?this.memo:"");
						var pushdata={"value":this.value,"title":title,"disabled":"","checked":""};
						users.push(pushdata);
					});
				});
				layui.transfer.render({
					elem:'#users'
					,data:users
					,id:'userslist'
					,height:360
					,width:220
					,showSearch:true
					,title:['备选人员','待填入内容']
					,onchange:function(data,index){
						var fieldString="";
						$.each(data, function(i, item) {
							fieldString+=item.title+"\r";
						});
						if(fieldString!=""){
							fieldString=$("#fieldString").val()+fieldString;
							$("#fieldString").val(fieldString);
						}
						changeTransfer();
					}
				});
			}else{
				$.ajax({
					type:		'POST',
					url:		'<c:url value="/getUsersByDepartmentid.do?departmentid="/>'+${duty.departid},
					dataType:	'json',
					async:      false,
					success:	function(data){
						transferData=data;
						var users=[];
						$.each(data.list, function(i, item) {
							$.each(item, function(i) {
								var title=this.text+(this.memo!=undefined?this.memo:"");
								var pushdata={"value":this.value,"title":title,"disabled":"","checked":""};
								users.push(pushdata);
							});
						});
						layui.transfer.render({
							elem:'#users'
							,data:users
							,id:'userslist'
							,height:360
							,width:220
							,showSearch:true
							,title:['备选人员','待填入内容']
							,onchange:function(data,index){
								var fieldString="";
								$.each(data, function(i, item) {
									fieldString+=item.title+"\r\n";
								});
								if(fieldString!=""){
									fieldString=$("#fieldString").val()+fieldString;
									$("#fieldString").val(fieldString);
								}
								changeTransfer();
							}
						});
					}
				});
			}
			layui.form.render();			
		  $(".layui-transfer-box[data-index=1]").hide();
		  $(".layui-transfer-active").find("button[data-index=1]").hide();
		}
		layui.use(['form', 'layedit','transfer'], function(){
		  var form = layui.form,
		  layer = layui.layer,
		  transfer = layui.transfer,
		  layedit = layui.layedit;
		  
		  changeTransfer();
		  form.on('submit(userSub)', function(data){
	         var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
	         $("#form1").ajaxSubmit({
	              	url:		'<c:url value="/updateDailyDuty.do"/>',
	              	dataType:	'json',
	              	async:  false,
	              	success:	function(data) {
	                  	var obj = eval('(' + data + ')');
	                  	if(obj.flag>0){
                  			//弹出loading
	                     	setTimeout(function(){         
	                     		top.layer.msg(obj.msg);
	                     		top.layer.close(index);
				        		layer.closeAll("iframe");
		 		        		//刷新父页面
		 		         		parent.$("#refresh").click();
		 		         		parent.layer.closeAll("iframe");
	                   		},2000);
	                 	}else{
	                  	 	top.layer.msg(obj.msg);
	                	}
	             	},
	              	error:function() {
	                  	layer.alert("请求失败！");
	              	}
	          	});
	           	return false;
			 });
		});
	</script>
  </body>
</html>
