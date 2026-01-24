<%@ page contentType='text/html;charset=UTF-8' language='java'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ page import="com.aladdin.model.UserSession"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>添加风险人员页面</title>
    
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/js/cardnumber.js"/>"></script>
  </head>
    <%
	UserSession userSession = (UserSession) session.getAttribute("userSession");
%> 
  <body>
  	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  		<legend id="typeName">添加风险人员</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
		<input type="hidden"  name="menuid" value=${param.menuid }>
		<input type="hidden"  name="cdtid" value=${param.cdtid }>
		<input type="hidden"  name="deal" value=${param.deal }>
		<div class="layui-form-item">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>身份证号</label>
	    	<div class="layui-input-inline">
	      		<input type="text" id="cardnumber" name="cardnumber" lay-verify="required|cardnumber" autocomplete="off" placeholder="请输入身份证号" class="layui-input"  lay-reqtext="身份证号不能为空" value="${param.cardnumber }" readonly="readonly">
	    	</div>
	    	<label class="layui-form-label"><font color="red" size=2>*</font>姓名</label>
	    	<div class="layui-input-inline">
	      		<input type="text" id="personname" name="personname" lay-verify="required" autocomplete="off" placeholder="请输入姓名" class="layui-input"  lay-reqtext="姓名不能为空">
	    	</div>
	  	</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>管辖责任单位</label>
	    	<div class="layui-input-inline">
				<input type="text" id="jdunit1" name="jdunit1" value="0" lay-filter="jdunit1" lay-verify="jdunit1" class="layui-input" autocomplete="off">
	    	</div>
	    	<label class="layui-form-label"><font color="red" size=2>*</font>管辖责任民警</label>
	    	<div class="layui-input-inline">
	    		<select id="jdpolice1" name="jdpolice1">
	    		</select>
	    	</div>
	  	</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>人员一级标签</label>
	    	<div class="layui-input-inline"  style="width:650px;">
	    		<select id="zslabel1" name="zslabel1"></select>
	    	</div>
	  	</div>
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
					$("#jdpolice1").html(options);
					$("#jdpolice1 option[value=<%=userSession.getLoginUserID()%>]").select();
				}
			});
		}
		function getAttributeLabels(){
			$.ajax({
				type:		'POST',
				url:		'<c:url value="/getAttributeLabelByParentid.do"/>',
				dataType:	'json',
				async:      false,
				success:	function(data){
					var options = '';
					$.each(data, function(i, item) {
						options += '<option value="' + item.id + '">' + item.attributelabel + '</option>';
					});
					$("#zslabel1").html(options);
				}
			});
		}
		
		$(document).ready(function(){
			getAttributeLabels()
			getUsers("<%=userSession.getLoginUserDepartmentid()%>");
		});
		layui.config({
		    base: "<c:url value="/layui/lay/modules/"/>"
		}).extend({
		    treeSelect: "treeSelect"
		});
		
		layui.use(['form','treeSelect'], function(){
			var form = layui.form,
		  	treeSelect = layui.treeSelect;
		  	treeSelect.render({
		        // 选择器
		        elem: '#jdunit1',
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
		        	getUsers($('#jdunit1').val());
		        	form.render();
		        },
		        // 加载完成后的回调函数
		        success: function (d) {
		        	treeSelect.checkNode('jdunit1', "<%=userSession.getLoginUserDepartmentid()%>");
		        	treeSelect.refresh('jdunit1');
		        	form.render();
		        }
		    });
		});
		
		layui.use(['form'], function(){
		  var form = layui.form,
		  layer = layui.layer;
		  
		  form.verify({
		  	cardnumber:function(value,item){
		  		var validator = new IDValidator();
		  		if(!validator.isValid(value)){
		  			return "身份证号存在错误";
		  		}
		  	}
		  });
		  
		  form.render();
		  form.on('submit(msgSub)', function(data){
           	var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
	         $("#form1").ajaxSubmit({
	              	url:		'<c:url value="/addWholePersonel.do"/>',
	              	dataType:	'json',
	              	async:  	false,
	              	success:	function(data) {
	                  	var obj = eval('(' + data + ')');
	                  	if(obj.flag>0){
                  			//新增关联
							$.ajax({
								type:		'POST',
								url:		'<c:url value="/addKeypersonnel.do"/>',
								data:		{personnelid:obj.flag,cdtid:${param.cdtid},menuid:${param.menuid},deal:"${param.deal }"},
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
					 		         		parent.parent.$("#sjrybutton").click();
					 		         		parent.parent.layer.closeAll("iframe");
				                   		},2000);
                  					}else{
                  						layer.msg(obj1.msg);
                  					}
								}
							});
	                 	}else{
	                  	 	top.layer.msg(obj.msg);
	                	}
	             	},
	              	error:function() {
	                  	top.layer.alert("请求失败！");
	              	}
	          	});
	           	return false;
			 });
		});
	</script>
  </body>
</html>
