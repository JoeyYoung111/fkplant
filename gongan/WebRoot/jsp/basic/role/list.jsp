<%@ page contentType='text/html;charset=UTF-8' language='java'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <title>角色权限设置</title>
    <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"/>
    <link rel="stylesheet" href="<c:url value="/css/system.css"/>" type="text/css"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
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
	<div class="juese_title">系统角色</div>
	<ul>
		<li><a href="javascript:editRole(1)"><i class="layui-icon" style="color:green;">&#xe654;</i>新增</a></li>
		<li><a href="javascript:editRole(2)"><i class="layui-icon" style="color:blue;">&#xe642;</i>修改</a></li>
		<li><a href="javascript:editRole(3)"><i class="layui-icon" style="color:red;">&#xe640;</i>删除</a></li>
	</ul>
	<br>
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
						<div class="layui-form-item" id="roleMenuList">
	
						</div>
						<div class="layui-form-item">
						    <div class="layui-input-block">
								<button type="submit" lay-submit="" lay-filter="roleMenuSub" class="layui-btn layui-btn-normal" style="float:right;margin-right:20px;">确 定</button>
						    </div>
					  	</div>
	    			</div>
	    			<div id="yh_2" style="display:none;">
	    				<div class="layui-form-item" id="roleMenuAPPList">
	
						</div>
						<div class="layui-form-item">
						    <div class="layui-input-block">
								<button type="button" id="roleMenuAPPSub" class="layui-btn layui-btn-normal" style="float:right;margin-right:20px;">确 定</button>
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
	function getRoleMenuList(){
		var nodeid=$('#nodeid').val();
		var index=top.layer.msg("切换至"+firstTitle,{icon: 16,shade:0.8,time:0});
        var div=$("div[data-id="+nodeid+"]"); 
		$('#role_tree').find('.layui-tree-entry').css('background','none');
		div.find('.layui-tree-entry').eq(0).css('background-color','#348FE2');
		$('#menuList').text('操作权限 ——'+firstTitle);
		$('#userList').text('角色用户 ——'+firstTitle);
		$('#menuShow').show();
		$('#userShow').show();
		$.ajax({
			type:		'POST',
			url:		'<c:url value="/getRoleMenuList.do" />?roleId='+nodeid,
			dataType:	'json',
			success:	function(data){
				var zhuList=data.roleMenuList;
				var htmlStr="";
				for(i=0;i<data.roleMenuListSize;i++){
					var ziList=zhuList[i].ziList;
					var ziStr="",ziFlag=false;
					for(j=0;j<ziList.length;j++){	
					var checkbutton=ziList[j].buttons;					
						   ziStr+='<input type="checkbox" class="twoparent'+ziList[j].menuid+'" name="roleMenuCheck" lay-skin="primary"';
							if(ziList[j].validflag>0){
								ziStr+=' checked';
								ziFlag=true;
							}
							var button ="";
							if(ziList[j].button!=""&&ziList[j].button!="null"){
							    button=ziList[j].button+",";
							}
							var buttons=button.split(","); 
							//console.log(ziList[j].menuName+"    "+buttons.length+"    "+button); 	
							if(buttons.length>1){
									ziStr+= ' title="'+ziList[j].menuName+'" value="'+ziList[j].menuid+'"><br>';
									ziStr+='&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
							}else{
							        ziStr+= ' title="'+ziList[j].menuName+'" value="'+ziList[j].menuid+'">';
							}
							for(k=0;k<buttons.length;k++){   
									 if(buttons[k]!=""&&buttons[k]!="null"){  													                                               
		                                 ziStr+='<input type="checkbox"  class="threeparent'+ziList[j].menuid+'" date="'+ziList[j].menuid+'" name="buttons" lay-skin="primary"';	 													
							             ziStr+= 'title="'+buttons[k]+'" value="'+buttons[k]+'"'; 					         					   
							      		 if(checkbutton!=""&&checkbutton!=null){					      		 
											     var checkbuttons=checkbutton.split(",");
											      for(m=0;m<checkbuttons.length;m++){    
											      if(checkbuttons[m]==buttons[k]){
											      ziStr+='checked';
											   }
										   } 
		                             }	 
		                             ziStr+= '>';   					 
									 }                          
					      }	
                           ziStr+='<br>';
						
					}
					htmlStr+='<ul class="layui-input-block" style="margin-top:1px;margin-left:50px;">'+
								'<li>'+
									'<input type="checkbox" class="parent" lay-skin="primary"';
					if(ziFlag)htmlStr+=	' checked';		
					htmlStr+=' title="'+zhuList[i].menuname+'">'+
									'<ul style="margin-left:30px;">'+
										ziStr+	
									'</ul>'+									
								'</li>'+								
							 '</ul>';
				}
				$('#roleMenuList').html(htmlStr);
				top.layer.close(index);
				layui.form.render();
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
	
	function deleteRoleUser(roleuserId,id){
		layer.confirm('确定删除此角色用户？', function(index){
	      layer.close(index);
	      $.getJSON(locat+"/cancelRoleUser.do?id="+roleuserId+'&menuid='+${param.menuid},{},function(data) {
	      	 $("#ru"+id).remove();
	      	 $("#userNum").text(Number($("#userNum").text())-1);
			 var str = eval('(' + data + ')');
	      	 if (str.flag ==1) {		                          
			     top.layer.msg("角色用户删除成功！"); 	               
	       	 }else{
				 top.layer.msg("角色用户删除失败!");
	      	 }			      	    		
	      });      
		});
	}
	
	$(document).ready(function(){
		getRoleList();
		getRoleUser();
		setTimeout(function(){         
 			//getRoleMenuAPPList();
 			getRoleMenuList();
       	},200);
	});
	
	function editRole(i){
		switch(i){
			case 1:
				var index = layui.layer.open({
					title : "新增角色",
					type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
					content : '<c:url value="/jsp/basic/role/addRole.jsp?menuid='+${param.menuid}+'"/>',
					area: ['800', '600'],
					maxmin: false,
					success : function(layero, index){
						setTimeout(function(){
							layui.layer.tips('点击此处返回', '.layui-layer-setwin .layui-layer-close', {
								tips: 3
							});
						},500)
					}
				});	
				break;
			case 2:
				if($('#nodeid').val()){
					var id=$('#nodeid').val();
					var index = layui.layer.open({
						title : "修改角色",
						type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
						content : locat+'/getRoleUpdate.do?id='+id+'&menuid='+${param.menuid},
						area: ['800', '600'],
						maxmin: false,
						success : function(layero, index){
							setTimeout(function(){
								layui.layer.tips('点击此处返回', '.layui-layer-setwin .layui-layer-close', {
									tips: 3
								});
							},500)
						}
					});	
				}else{
					layer.alert("请先选择修改哪个角色！");
				}
				break;
			case 3:
				if($('#nodeid').val()){
					var id=$('#nodeid').val();
					if($('#userNum').text()>0){
						top.layer.msg("该角色存在用户！无法删除！！");
					}else{
						layer.confirm('确定删除此角色？', function(index){
						      layer.close(index);
						      $.getJSON(locat+"/cancelRole.do?id="+id+'&menuid='+${param.menuid},{},function(data) {
								 var str = eval('(' + data + ')');
						      	 if (str.flag ==1) {		                          
								     top.layer.msg("角色删除成功！"); 	
								     window.location.reload();
						       	 }else{
									 top.layer.msg("删除失败!");
						      	 }			      	    		
						      });      
							});
					}
				}else{
					layer.alert("请先选择删除哪个角色！");
				}
				break;
		}
	}
	function addRoleUser(){
		if($('#nodeid').val()){
			var id=$('#nodeid').val();
			var index = layui.layer.open({
				title : "添加角色用户",
				type : 2,  //0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
				content : '<c:url value="/jsp/basic/role/add.jsp?roleid='+id+'&menuid='+${param.menuid}+'"/>',
				area: ['800', '800'],
				maxmin: true,
				success : function(layero, index){
					setTimeout(function(){
						layui.layer.tips('点击此处返回', '.layui-layer-setwin .layui-layer-close', {
							tips: 3
						});
					},500)
				}
			});	
			layui.layer.full(index);
		}else{
			layer.alert("请先选择角色！");
		}
	}
	
	
	

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
	         var checkList=[],noCheckList=[];
	         var checkedbutton="";
	         var notcheckedbutton="";
	         $("input[name='roleMenuCheck']:checked").each(function(){
	         	var v=$(this).val();
	         	
	       var c =$('.threeparent'+v+':checked').each(function (e) {
				var e = $(this); //添加layui的选中的样式   控制台看元素								
				 checkedbutton=checkedbutton+e.val()+",";
				});
				checkList.push({menuid:v,buttons:checkedbutton});
				checkedbutton="";
	         });
	         //console.log(checkList)
	         $("input[name='roleMenuCheck']:not(:checked)").each(function(){
	         	var v=$(this).val();
	         	noCheckList.push(v);
	         });	         
	         var index = top.layer.msg('权限配置中，请稍候',{icon: 16,shade:0.8,time:0});
	         $("#menuForm").ajaxSubmit({
	              	url:		'<c:url value="/setRoleMenu.do"/>',
	              	data:       {
	              					'roleId':$('#nodeid').val(),
	              					'menuid':${param.menuid},
	              					'checkList':JSON.stringify({'change':checkList}),
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
