<%@ page contentType='text/html;charset=UTF-8' language='java'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <title>移动端角色权限</title>
    <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
    <link rel="stylesheet" href="<c:url value="/css/system.css"/>" type="text/css"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
    <!-- ztree -->
	<link rel="stylesheet" href="<c:url value='/jquery/ztree/zTreeStyle.css'/>" />
	<script type="text/javascript" src="<c:url value='/jquery/ztree/jquery.ztree.all-3.5.js'/>"></script>
    <script type="text/javascript">
		function ChangeTab(num){
			var object_id = "cd_" + num;
			var div_id = "yh_" + num;
			for(var i=1; i<3; i++){
				document.getElementById("cd_" + i).className = "border_line2";
				document.getElementById("yh_" + i).style.display = "none";
			}
			document.getElementById(object_id).className = "border_line";
			document.getElementById(div_id).style.display = "";
		}
	</script>
	<style>
      .layui-tree-entry{position:relative;padding:3px 0;height:28px;white-space:nowrap}
    </style>
  </head>
  
<body>
<div class="juese jsqx">
	<div class="juese_title">移动端角色</div>
	<input type="hidden" class="layui-input" id="nodeid" autocomplete="off" style="width:170px;">
	<br>
	<div>
    	<div id="role_tree">
    		
    	</div>	
    </div>
</div>
<div class="jsqx_cz jsqx">
	<form class="layui-form" method="post" id="menuForm" >
		<div class="caozuoqx" style="height:98%;">
			<div class="juese_title" id="menuList">操作权限</div>
			<div class="qx_title" style="display:none;" id="menuShow" >
				<div id="cd_1"><a href="javascript:ChangeTab('1')"></a></div>
	   			<%--<div id="cd_2" class="border_line2"><a href="javascript:ChangeTab('2')">APP</a></div>--%>
	   			<div class="clear"></div>
	   			<div class="qx_title" style="height:80%;overflow:auto;">
	    			<div id="yh_1">
						<div class="layui-form-item">
							<ul id="appbuttontree" class="ztree" style="width: 250px;overflow: auto;height: 410px;"></ul>
						</div>
						<div class="layui-form-item">
						    <div class="layui-input-block">
								<button type="submit" lay-submit="" lay-filter="roleMenuSub" class="layui-btn layui-btn-normal" style="float:right;margin-right:20px;">确 定</button>
						    </div>
					  	</div>
	    			</div>
	    		</div>
	   		</div>
		</div>
		<div class="jueseyh">	
			<div class="juese_title">
				<span id="userList">角色用户</span>
			<!-- <button type="button" onclick="addRoleUser()" class="layui-btn layui-btn-normal" style="float:right;margin-right:20px; background:none;">添加【+】</button> -->
			</div>
			<div class="qx_title" style="display:none;height:86%;overflow:auto;" id="userShow">
				<div class="jsyh">
					<i class="layui-icon">&#xe613;</i>
					共<span id="userNum">0</span>人
				</div>
				<div id="roleUserList">
					
				</div>
			</div>
		</div>
	</form>
</div>

<script>
	var roleList=[];
	var firstTitle;
	var t;
	function getRoleList(){
		$.ajax({
			type:		'POST',
			url:		'<c:url value="/getRoleList.do" />',
			dataType:	'json',
			async:		false,
			success:	function(data){
				roleList=[];
				for(i=0;i<data.length;i++){
					if(i==0){
						$('#nodeid').val(data[i].id);
						firstTitle=data[i].rolename;
					}
					var aRole={title:data[i].rolename,id:data[i].id};
					roleList.push(aRole);
				}
			}
		});
	}
	
	function initAppbuttonList(){
		$.ajax({
			type:		'POST',
			url:		'<c:url value="/getAppbuttonList.do" />',
			dataType:	'json',
			success:	function(data){
				t = $("#appbuttontree");
				t = $.fn.zTree.init(t, setting, data);
				t.expandAll(true);
				getRoleMenuList();
			}
		});
	}
	
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
				name:"btnname"
			},
			simpleData: {
				enable:		true,
				idKey: 		"id",
				pIdKey: 	"parentid"
			}
		},
		view:{
			showIcon:false
		}
	};
	
	function getRoleMenuList(){
		var nodeid=$('#nodeid').val();
        var div=$("div[data-id="+nodeid+"]"); 
		$('#role_tree').find('.layui-tree-entry').css('background','none');
		div.find('.layui-tree-entry').eq(0).css('background-color','#348FE2');
		$('#menuList').text('操作权限 ——'+firstTitle);
		$('#userList').text('角色用户 ——'+firstTitle);
		$('#menuShow').show();
		$('#userShow').show();
		t.checkAllNodes(false);
		$.ajax({
			type:		'POST',
			url:		'<c:url value="/getRoleAppbuttonByRoleid.do" />',
			data:		{roleid:$("#nodeid").val()},
			dataType:	'json',
			async:		false,
			success:	function(data){
				if(data.roleAppbutton!=null){
					var appbuttonIds = data.roleAppbutton.appbuttonIds;
					var ids = appbuttonIds.split(",");
					for(var i=0;i<ids.length;i++){
						var node = t.getNodeByParam("id",ids[i]);
						if(node!=null){
							t.checkNode(node,true);
						}
					}
				}
			}
		});
	}
	
	
	function getRoleUser(){
		$.ajax({
			type:		'POST',
			url:		'<c:url value="/getRoleUser.do" />',
			data:		{ roleid:$("#nodeid").val() },
			dataType:	'json',
			async:		false,
			success:	function(data){
				$("#roleUserList").html("");
			    if(data.list.user==null){
			   $("#userNum").text(0);
			    }else{
				for(var num=0;num<data.list.user.length;num++){
					var str = '<div id="ru'+data.list.user[num].id+'">'+
			      			  '<div class="js_addname">'+data.list.user[num].staffName+'</div>'+
<%--							  '<div class="js_adddel"><a onclick="deleteRoleUser('+data.list.user[num].roleuserId+','+data.list.user[num].id+')"><img src="../../../images/btn_delete.png" width="24" height="24" /></a></div>'+--%>
							  '<div class="clear"></div></div>';
					$("#roleUserList").append(str);
				}			
				$("#userNum").text(data.list.user.length);
				}
			}
		});
	}

	$(document).ready(function(){
		getRoleList();
		getRoleUser();
		initAppbuttonList();
	});

	var locat = (window.location+'').split('/'); 
	$(function(){if('main'== locat[3]){locat =  locat[0]+'//'+locat[2];}else{locat =  locat[0]+'//'+locat[2]+'/'+locat[3];};});
	layui.use(['tree','form'],function(){
		var tree=layui.tree,form=layui.form;
		tree.render({
			elem:'#role_tree',
	 		onlyIconControl:true,
	 		data:roleList,
	 		id:"roleTree",
			click:function(obj){
				firstTitle=obj.data.title;
             	$('#nodeid').val(obj.data.id);
	 			setTimeout(function(){ 
	 				//getRoleMenuAPPList();       
                  	getRoleMenuList();
                  	getRoleUser();
             	},200);
	 		},
	 		
		});
		
			form.on('submit(roleMenuSub)', function(data){
				var nodes = t.getCheckedNodes(true);
				var appbuttonIds = "";
				for(var i=0;i<nodes.length;i++){
					if(appbuttonIds==""){
						appbuttonIds = nodes[i].id;
					}else{
						appbuttonIds = appbuttonIds + "," + nodes[i].id;
					}
				}
				//更新角色权限
				$.ajax({
					type:       "POST",
					url:        "<c:url value="/updateRoleAppbutton.do"/>",      //可改为调用的.do路径
					data:		{appbuttonIds:appbuttonIds,roleid:$("#nodeid").val(),menuid:${param.menuid}},
					dataType:   'json',
					success:    function(data) {
						var obj = eval('(' + data + ')');
                  		if(obj.flag>0){
                  			layer.msg(obj.msg);
                  		}else{
                  			layer.msg(obj.msg);
                  		}
					},
					error:    function() {
						alert("请求失败！");
					}
				});
				return false;
			});
			 
			 $(document).on("click","#roleMenuAppSub",function(){
		         var checkList=[],noCheckList=[];
		         $("input[name='roleMenuAppCheck']:checked").each(function(){
		         	var v=$(this).val();
		         	checkList.push(v);
		         });
		         $("input[name='roleMenuAppCheck']:not(:checked)").each(function(){
		         	var v=$(this).val();
		         	noCheckList.push(v);
		         });
		         var index = top.layer.msg('权限配置中，请稍候',{icon: 16,shade:0.8,time:0});
		         $.ajax({
		              	url:		'<c:url value="/setRoleMenuApp.do"/>',
		              	data:       {
		              					'roleId':$('#nodeid').val(),
		              					'menuid':${param.menuid},
		              					'checkList':checkList.join(','),
		              					'noCheckList':noCheckList.join(',')
		              				},
		              	dataType:	'json',
		              	//async:  false,
		              	success:	function(data) {
		                  	var obj = eval('(' + data + ')');
		                  	if(obj.flag>0){
		                     	setTimeout(function(){         
		                     		top.layer.msg(obj.msg);
		                     		top.layer.close(index);
		                   		},1000);
		                 	}else{
		                  	 	top.layer.msg(obj.msg);
		                 		top.layer.close(index);
		                	}
		             	},
		              	error:function() {
		                  	layer.alert("请求失败！");
		              	}
		          	});
			 });
		form.on('checkbox()', function(data){	
				var pc =  data.elem.classList //获取选中的checkbox的class属性				
				var dates=  data.elem.value;				
				var date=pc.value;
				date=date.substring(11,date.length);				
				/* checkbox处于选中状态  */
				if(data.elem.checked==true){//并且当前checkbox为选中状态
						/*如果是parent节点 */
						if(pc=="parent"){  //如果当前选中的checkbox class里面有parent 
							//获取当前checkbox的兄弟节点的孩子们是 input[type='checkbox']的元素
							var c =$(data.elem).siblings().children("input[type='checkbox']");
							 c.each(function(){//遍历他们的孩子们
								var e = $(this); //添加layui的选中的样式   控制台看元素
								e.attr("checked",true);
								e.next().addClass("layui-form-checked");
						   });
						}else if(pc=="twoparent"+dates){/*如果不是parent*/												
						var c =$(".threeparent"+dates).each(function (e) {
								var e = $(this); //添加layui的选中的样式   控制台看元素
								e.attr("checked",true);
								e.next().addClass("layui-form-checked");
						   });
						   $(data.elem).parent().prev().addClass("layui-form-checked");
						}else if(pc=="threeparent"+date){						
						var c =$(".twoparent"+date).each(function (e) {
								var e = $(this); //添加layui的选中的样式   控制台看元素
								e.attr("checked",true);
								e.next().addClass("layui-form-checked");
						   });
							//选中子级选中父级
							$(data.elem).parent().prev().addClass("layui-form-checked");
						}
					
				}else{	/*checkbox处于 false状态*/
					   
					  //父级没有选中 取消所有的子级选中
					  if(pc=="parent"){/*判断当前取消的是父级*/
						var c =$(data.elem).siblings().children("input[type='checkbox']");
						 c.each(function(){
							var e = $(this);
							e.attr("checked",false);
							e.next().removeClass("layui-form-checked")
						 });
					}else if(pc=="twoparent"+dates){
					var c =$(".threeparent"+dates).each(function (e) {
								var e = $(this); //添加layui的选中的样式   控制台看元素
								e.attr("checked",false);
								e.next().removeClass("layui-form-checked");
						   });					
							var a= $(data.elem).siblings("div"); 
							var count =0; 
							a.each(function(){//遍历他们的孩子们
								   //如果有一个==3那么久说明是处于选中状态
									var is =  $(this).get(0).classList;
									if(is.length==3){
										count++;
									}
							 });
							//如果大于0说明还有子级处于选中状态
							if(count>0){
								
							}else{/*如果不大于那么就说明没有子级处于选中状态那么就移除父级的选中状态*/
								$(data.elem).parent().prev().removeClass("layui-form-checked");
							}
					  }
					  }
		}); 
	});
</script>
</body>
</html>
