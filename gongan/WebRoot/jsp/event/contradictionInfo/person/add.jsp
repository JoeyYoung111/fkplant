<%@ page contentType='text/html;charset=UTF-8' language='java'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ page import="com.aladdin.model.UserSession"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
UserSession userSession = (UserSession) session.getAttribute("userSession");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>添加涉稳人员页面</title>
    
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
	<link rel="stylesheet" href="<c:url value="/css/public.css"/>"  media="all" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/js/cardnumber.js"/>"></script>
  </head>
  
  <body>
  	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  		<legend id="typeName">添加涉稳人员</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1" onsubmit="return false;">
		<input type="hidden"  name="menuid" value=${menuid }>
		<div class="layui-form-item">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>身份证号</label>
	    	<div class="layui-input-inline">
	      		<input type="text" id="cardnumber" name="cardnumber" lay-verify="required|cardnumber" autocomplete="off" placeholder="请输入身份证号" class="layui-input"  lay-reqtext="身份证号不能为空" value="${wenGrade.cardnumber }">
	    	</div>
	    	<label class="layui-form-label"><font color="red" size=2>*</font>姓名</label>
	    	<div class="layui-input-inline">
	      		<input type="text" id="personname" name="personname" lay-verify="required" autocomplete="off" placeholder="请输入姓名" class="layui-input"  lay-reqtext="姓名不能为空">
	    	</div>
	  	</div>
		<div class="layui-form-item">
	    	<div id="labels">
	    	</div>
	  	</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>管辖责任单位</label>
	    	<div class="layui-input-inline" lay-verify="jurisdictunit1" id="unitdiv">
				<input type="text" id="jurisdictunit1" name="jurisdictunit1" value="0" lay-filter="jurisdictunit1" class="layui-input" autocomplete="off">
	    	</div>
	    	<label class="layui-form-label"><font color="red" size=2>*</font>管辖责任民警</label>
	    	<div class="layui-input-inline" lay-verify="jurisdictpolice1">
	    		<select id="jurisdictpolice1" name="jurisdictpolice1">
	    		</select>
	    	</div>
	  	</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>责任警种</label>
	    	<div class="layui-input-inline">
	    		<div id="responsiblepolice"></div>
	    	</div>
	  	</div>
<%--	  	<div class="layui-form-item layui-form-text">--%>
<%--		    <label class="layui-form-label">备注信息</label>--%>
<%--		    <div class="layui-input-block">--%>
<%--		      <textarea placeholder="请输入内容" class="layui-textarea" name="memo"></textarea>--%>
<%--		    </div>--%>
<%--		</div>--%>
		<div class="layui-form-item">
		    <div class="layui-input-block">
		      <button type="submit" class="layui-btn" lay-submit="" lay-filter="msgSub">立即提交</button>
		    </div>
	  	</div>
	</form>
	<script type="text/javascript">
		function getUsers(departmentid){
			$.ajax({
				type:		'POST',
				url:		'<c:url value="/getUsersByDepartmentid.do?departmentid="/>'+departmentid,
				dataType:	'json',
				async:      false,
				success:	function(data){
					var options = fillOption(data);
					$("#jurisdictpolice1").html(options);
					$("#jurisdictpolice1 option[value=${jurisdictpolice1}]").select();
				}
			});
		}
		
		$(document).ready(function(){
			getUsers("${jurisdictunit1}");
		});
		layui.config({
		    base: "<c:url value="/layui/lay/modules/"/>"
		}).extend({
		    treeSelect: "treeSelect",
		    zTreeSelectM: "zTreeSelectM/zTreeSelectM"
		});
		
		layui.use(['form','treeSelect'], function(){
			var form = layui.form,
			layer = layui.layer,
		  	treeSelect = layui.treeSelect;
		  	treeSelect.render({
		        // 选择器
		        elem: '#jurisdictunit1',
		        // 数据
		        //data: '<c:url value="/getDepartmentTree.do"/>',
		        data: '<c:url value="/getDepartmentTreeBytype.do"/>?departtype=4',
		        // 异步加载方式：get/post，默认get
		        type: 'get',
		        // 占位符
		        placeholder: '管辖责任单位',
		        // 是否开启搜索功能：true/false，默认false
		        search: false,
		        // 一些可定制的样式
		        style: {
		            folder: {
		                enable: false
		            },
		            line: {
		                enable: true
		            }
		        },
		        // 点击回调
		        click: function(d){
		        	getUsers($('#jurisdictunit1').val());
		        	form.render();
		        },
		        // 加载完成后的回调函数
		        success: function (d) {
		        	if(<%=userSession.getLoginUserRoleid()==32||userSession.getLoginUserRoleid()==31%>){
			        	treeSelect.checkNode('jurisdictunit1', "<%=userSession.getLoginUserDepartmentid()%>");
			        	treeSelect.refresh('jurisdictunit1');
			        	getUsers($('#jurisdictunit1').val());
			        	form.render();
			        	$("#unitdiv").css("pointerEvents","none");
		        	}
		        }
		    });
			  
			  $('#cardnumber').blur(function(){
					$("#labels").empty();
					$("#personname").val("");
					$("#personname").removeAttr("readonly");
					$("#personname").css("background","");
			  		var validator = new IDValidator();
			  		if(validator.isValid(this.value)){
			  			$.ajax({
							type:		'POST',
							url:		'<c:url value="/checkPersonnelCardnumber.do"/>',
							data:		{cardnumber :  this.value},
							dataType:	'json',
							async:      false,
							success:	function(data){
								if(data.flag){
									var flaglabel=","+data.personnel.zslabel1+",";
									if(flaglabel.indexOf(",1,")!=-1){
										$("#personname").val(data.personnel.personname);
										$("#personname").attr("readonly","readonly");
										$("#personname").css("background","#efefef");
			        					form.render();								
										layer.alert("该身份证已存在涉稳人员--"+data.personnel.personname+"!!");
									}else {
			        					form.render();								
										$("#personname").val(data.personnel.personname);
										$("#personname").attr("readonly","readonly");
										$("#personname").css("background","#efefef");
										if(data.personnel.jdunit1!=null&&data.personnel.jdunit1!=""){
											treeSelect.checkNode('jurisdictunit1', data.personnel.jdunit1);
				        					treeSelect.refresh('jurisdictunit1');
				        					getUsers($('#jurisdictunit1').val());
		        							form.render();
				        					if(data.personnel.jdpolice1!=null&&data.personnel.jdpolice1!="")$("#jurisdictpolice1 option[value='"+data.personnel.jdpolice1+"']").select();
										}
										if(data.personnel.zslabel1!=null&&data.personnel.zslabel1!=""){
						               		var zslabel1s=data.personnel.zslabel1.split(",");
						               		var str1='<label class="layui-form-label">已存在标签</label><div class="layui-input-inline" style="padding-left:5px;padding-top:6px;">';
						               		for(var i=0;i<zslabel1s.length;i++){
							               		$.ajax({
													type:		'POST',
													url:		'<c:url value="/getAttributeLabelByLabelid.do"/>',
													data:		{
																	id: zslabel1s[i]
																},
													dataType:	'json',
													async:      false,
													success:	function(data){
														str1+='<span class="my-tag-item3" style="background-color:#1E9FFF;color:white;">'+data.attributelabel+'</span>';
													}
												});
						               		}
						               		str1+="</div>";
						               		$("#labels").html(str1);
						               }
			        					form.render();								
									}
								}
							}
						});
			  		}
			  		
			  });
		});
		
		layui.use(['form','zTreeSelectM'], function(){
		  var form = layui.form,
		  zTreeSelectM = layui.zTreeSelectM,
		  layer = layui.layer;
		  var _zTreeSelectM2 = zTreeSelectM({
			    elem: '#responsiblepolice',//元素容器【必填】          
			    json: ${responsiblepolice},//json数组直接获取 默认''
			    //data:url
			    width: 650,  //设置了长度    
			    selected: [],//默认值            
			    max: 100,//最多选中个数，默认5            
			    name: 'responsiblepolice',//input的name 不设置与选择器相同(去#.)
			    delimiter: ',',//值的分隔符 
			    tips:'请选择责任警种',      
			    verify: 'required', 
			    reqtext:"请选择责任警种", 
			    reqdiv:"responsiblepolice",      
			    field: { idName: 'id', titleName: 'basicName'},//候选项数据的键名 
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
			                name: 'basicName'
			            }
			        },
			        view: {
			        	showIcon: false,
						showLine: false
					}
			    }
			});  
		  
		  form.verify({
			  	cardnumber:function(value,item){
			  		var validator = new IDValidator();
			  		if(!validator.isValid(value)){
			  			return "身份证号存在错误";
			  		}else{
			  			var msg="";
			  			$.ajax({
							type:	'post',
							url:	'<c:url value="/checkPersonnelCardnumber.do"/>',
							data:	{cardnumber :  value},
							dataType:	'json',
							async:		false,
							success:	function(data){
								if(data.flag){
									var flaglabel=","+data.personnel.zslabel1+",";
									if(flaglabel.indexOf(",1,")!=-1){
										msg = "该身份证已存在涉稳人员--"+data.personnel.personname+"!!";
									}
								}
							}
						});
						if(msg!="")return msg;
			  		}
			  	},
			  	jurisdictpolice1: function(value,item){
		    		if(!$("#jurisdictpolice1").val()||$("#jurisdictpolice1").val()==""){
		    			$("#jurisdictpolice1").next().find("input").focus();
			  			return "请选择管辖责任民警";
		    		}
		    	},
			  	jurisdictunit1: function(value,item){
		    		if(!$("#jurisdictunit1").val()||$("#jurisdictunit1").val()=="0"){
			  			return "请选择管辖责任单位";
		    		}
		    	}
			  });
		  form.render();
		  form.on('submit(msgSub)', function(data){
	         $("#form1").ajaxSubmit({
	              	url:		'<c:url value="/addWenGrade.do"/>',
	              	dataType:	'json',
	              	async:  false,
	              	success:	function(data) {
	                  	var obj = eval('(' + data + ')');
	                  	if(obj.flag>0){
	                  		if(${wenGrade.cdtid }!=0){
	                  			//新增关联
								$.ajax({
									type:		'POST',
									url:		'<c:url value="/addKeypersonnel.do"/>',
									data:		{personnelid:obj.flag,cdtid:${wenGrade.cdtid},workinfoid:${wenGrade.workinfoid},menuid:${menuid}},
									dataType:	'json',
									success:	function(data1){
					           			var obj1 = eval('(' + data1 + ')');
	                  					if(obj1.flag>0){
	                  						//弹出loading
					 		            	var index1 = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
					                     	setTimeout(function(){         
					                     		top.layer.msg(obj1.msg);
					                     		top.layer.close(index1);
								        		layer.closeAll("iframe");
						 		         		parent.layer.closeAll("iframe");
						 		         		if(${wenGrade.workinfoid }==0){
						 		         			parent.formSubmit('zzry','<c:url value="searchKeypersonnel.do"/>');
						 		         		}else{
						 		         			parent.formSubmit();
						 		         			if(parent.parent.parent.formSubmit!=undefined){
						 		         				parent.parent.parent.formSubmit('zzry','<c:url value="searchKeypersonnel.do"/>');
						 		         			}
						 		         		}
					                   		},2000);
	                  					}else{
	                  						layer.msg(obj1.msg);
	                  					}
									}
								});
	                  		}else{
	                  			//弹出loading
		 		            	var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
		                     	setTimeout(function(){         
		                     		top.layer.msg(obj.msg);
		                     		top.layer.close(index);
					        		layer.closeAll("iframe");
			 		        		//刷新父页面
			 		         		parent.$("#search").click();
			 		         		parent.layer.closeAll("iframe");
		                   		},2000);
	                  		}
	                 	}else{
	                  	 	layer.msg(obj.msg);
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
