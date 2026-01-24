<%@ page contentType='text/html;charset=UTF-8' language='java'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<!DOCTYPE HTML>
<html>
	<head>
		<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
		<link rel="stylesheet" href="<c:url value='/jquery/ztree/zTreeStyle.css'/>" />
	    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
	    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
	  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
	  	<script type="text/javascript" src="<c:url value="/layui/lay/modules/form.js"/>"></script>
		<script type="text/javascript" src="<c:url value='/jquery/ztree/jquery.ztree.all-3.5.js'/>"></script>
		<title>接收目标</title>
	</head>
	<style>
     	.js_addname{
     		float:left;
     		width:15%;
     		height:24px;
     		background-color:#E5E5E5; 
     		line-height:24px;
     		text-indent:15px;
     		margin-top:8px;
     	}
     	.js_adddel{
     		float:left;
     		width:24px;
     		height:24px;
     		background-color:#f00;
     		margin-top:8px;
     	}
   	</style>
	<body>
		<form class="layui-form" method="post" id="form1">
			<input type="hidden" id="personreceiveids" name="personreceiveids">
			<table class="layui-table">
				<tr>
					<th style="font-size: 12" colspan="2">选择接收目标</th>
				</tr>
				<tr>
					<td valign="top" width="150px">		
						接收目标：<input type="text" name="staffName" id="staffName" style="width: 120px;">
						<input type="button" id="query" name="query" value="查 询"/><br/><br/>
						<font size="2"><B>接收目标</B></font>											
						<ul id="tree" class="ztree" style="width: 250px;overflow: auto;height: 410px;"></ul>
					</td>
					<td valign="top">
						<div style="border-bottom:solid 1px #C1C1C1;line-height:30px;">
							<i class="layui-icon">&#xe613;</i>
							共<span id="userNum">0</span>人
						</div>
						<div id="userList">
							
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2">&nbsp;</td>
				</tr>
				<tr>
					<td align="center" colspan="2">
						<button type="submit" class="layui-btn" lay-submit="" lay-filter="msgSub">确定</button>
		      			<button type="reset" class="layui-btn layui-btn-primary">取消</button>
					</td>
				</tr>
			</table>
		</form>
	</body>
	<script type="text/javascript" language="javascript">
		var names=[];
		var t;
		
		/*查询按钮*/
	 	$("#query").click(function(){
	 		initReceiver();
	 	});
	 	
		var setting = {
			check: {
				enable: true,
				chkStyle: "checkbox",
				chkboxType: { "Y": "ps", "N": "s" }
			},
            view: {
					showLine: true
				},
            data: {
				key:{
					name:"departname"
				},
				simpleData: {
					enable:		true,
					idKey: 		"id",
					pIdKey: 	"parentid"
				}
			},
			view:{
				showIcon:false
			},
			callback: {
				onCheck: zTreeOnCheck
			}
        };
		
		layui.use(['form'], function(){
			var form = layui.form;
			var layer = layui.layer;
			initReceiver();
			
			form.on('submit(msgSub)', function(data){
				parent.document.getElementById('personreceiveids').value = $("#personreceiveids").val();
				var idss = $("#personreceiveids").val().split(",");
				var receiverHTML="";
				for(var i = 0;i<idss.length-1;i++){
					receiverHTML += "<a id="+idss[i]+">" +names["ru"+idss[i]]+ "<img src='<c:url value='/images/cancel.png'/>' border='0' style='cursor: pointer;vertical-align: text-bottom;' onclick='cancelExpress("+idss[i]+");return false;'>&nbsp;&nbsp;</a>";
				}
				parent.document.getElementById('receiverspan').innerHTML = receiverHTML;
				layer.closeAll("iframe");
                parent.layer.closeAll("iframe");
			});
		});
    	/* 默认页面加载查询数据*/ 
    	function initReceiver(){
	    	$.ajax({
				type:       "POST",
				url:        "<c:url value="/getAllReceiver.do"/>",      //可改为调用的.do路径
				data:		{departname:$("#staffName").val()},
				dataType:   'json',
				success:    function(data) {
					t = $("#tree");
					t = $.fn.zTree.init(t, setting, data);
					t.expandAll(false);
					var ids = "${param.personreceiveids }".split(",");
					for(var i=0;i<ids.length;i++){
						var node = t.getNodeByParam("id", 0-ids[i]);
						if(node!=null){
							t.checkNode(node, true,true,true);
						}
					}
				},
				error:    function() {
					alert("请求失败！");
				}
			});
	    }
	    
	    /*zTree勾选事件*/
 		function zTreeOnCheck(event, treeId, treeNode){
 			/*
 				1.获取当前操作的所有节点下的用户信息
 			*/
 			/*-------1.获取当前节点下所有的用户信息-------*/
 			var treeObj = $.fn.zTree.getZTreeObj("tree");
			var nodes = treeObj.getChangeCheckedNodes();
 			for(var i=0;i<nodes.length;i++){
 				nodes[i].checkedOld  = nodes[i].checked;
 				if(nodes[i].id < 0){
 					var id = (0-nodes[i].id);
 					/*将用户信息新增入待接收人中*/
 					/*待接收人的选项*/
 					if(nodes[i].checked){
 						/*需要新增该用户*/
 						var str = '<div id="ru'+id+'">'+
			      			  '<div class="js_addname">'+nodes[i].departname+'</div>'+
							  '<div class="js_adddel"><a onclick="deleteUser('+id+')"><img src="<c:url value="/images/btn_delete.png"/>" width="24" height="24" /></a></div></div>';
						$("#userList").append(str);
						$("#userNum").text(Number($("#userNum").text())+1);
						document.getElementById('personreceiveids').value = $("#personreceiveids").val()+id+",";
						names["ru"+id]=nodes[i].departname;
 					}else{
 						/*需要删除该用户*/
 						$("#ru"+id).remove();
 						$("#userNum").text(Number($("#userNum").text())-1);
						document.getElementById('personreceiveids').value = $("#personreceiveids").val().replace(id+',','');
 					}
 				}
 			}
 		}
 		
 		function deleteUser(id){
 			layer.confirm('确定删除此接收目标？', function(index){
	      		layer.close(index);
	      		$("#ru"+id).remove();
	      		$("#userNum").text(Number($("#userNum").text())-1);
	      		document.getElementById('personreceiveids').value = $("#personreceiveids").val().replace(id+',','');
	      		var node = t.getNodeByParam("id", 0-id);
	      		t.checkNode(node, false,true);
			});
 		}
	</script>
</html>