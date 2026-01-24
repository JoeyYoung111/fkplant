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
	<link rel="stylesheet" href="<c:url value="/layui/lay/modules/formSelects/formSelects-v4.css"/>" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/js/cardnumber.js"/>"></script>
  </head>
  
  <body>
  	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  		<legend id="typeName">添加风险人员</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
		<input type="hidden"  name="menuid" value=${menuid }>
		<input type="hidden"  name="personlabelid" value=0>
		<input type="hidden"  name="personlabelname" value='风险人员'>
		<div class="layui-form-item">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>身份证号</label>
	    	<div class="layui-input-inline">
	      		<input type="text" name="cardnumber" id="cardnumber" lay-verify="required|cardnumber" autocomplete="off" placeholder="请输入身份证号" class="layui-input"  lay-reqtext="身份证号不能为空" value="${wenGrade.cardnumber }">
	    	</div>
	    	<label class="layui-form-label"><font color="red" size=2>*</font>姓名</label>
	    	<div class="layui-input-inline">
	      		<input type="text" name="personname" id="personname" lay-verify="required" autocomplete="off" placeholder="请输入姓名" class="layui-input"  lay-reqtext="姓名不能为空">
	    	</div>
	  	</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>管辖责任单位</label>
	    	<div class="layui-input-inline">
				<input type="text" id="jurisdictunit1" disabled="true" name="jurisdictunit1" value="0" lay-filter="jurisdictunit1" lay-verify="jurisdictunit1" class="layui-input">
	    	</div>
	    	<label class="layui-form-label"><font color="red" size=2>*</font>管辖责任民警</label>
	    	<div class="layui-input-inline">
	    		<select id="jurisdictpolice1" disabled name="jurisdictpolice1">
	    		</select>
	    	</div>
	  	</div>
		<div class="layui-form-item">
	    	<label class="layui-form-label"><font color="red" size=2>*</font>人员属性标签</label>
	    	<div class="layui-input-inline">
				 <div id="attributelabels" style="width:660px;"></div>
	    	</div>
	  	</div>
<%--	  	<div class="layui-form-item layui-form-text">--%>
<%--		    <label class="layui-form-label">备注信息</label>--%>
<%--		    <div class="layui-input-block">--%>
<%--		      <textarea placeholder="请输入内容" class="layui-textarea" name="memo"></textarea>--%>
<%--		    </div>--%>
<%--		</div>--%>
		<div class="layui-form-item">
			<div class="layui-col-md-offset3">
			    <div class="layui-input-block">
			      <button type="submit" id="msgSub" class="layui-btn" lay-submit="" lay-filter="msgSub">立即提交</button>
			    </div>
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
					$("#jurisdictpolice1 option[value=${jurisdictppolice1}]").select();
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
     		zTreeSelectM: 'zTreeSelectM/zTreeSelectM'
		});
		
		layui.use(['form','treeSelect','zTreeSelectM'], function(){
		  var form = layui.form,
		  treeSelect = layui.treeSelect,
		  zTreeSelectM = layui.zTreeSelectM,
		  layer = layui.layer;
		  
		  treeSelect.render({
		        // 选择器
		        elem: '#jurisdictunit1',
		        // 数据
		        data: '<c:url value="/getDepartmentTree.do"/>',
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
		        	treeSelect.checkNode('jurisdictunit1', "${jurisdictunit1}");
		        	treeSelect.refresh('jurisdictunit1');
		        	$("#layui-treeSelect-body-jurisdictunit1").parent().css("display","none");
		        	form.render();
		        }
		    });
		  var _zTreeSelectM1 = zTreeSelectM({
		    elem: '#attributelabels',//元素容器【必填】          
		    data: '<c:url value="/getAttributeLabelzTreeSelectM.do"/>',
		    type: 'get',  //设置了长度    
		    selected: [],//默认值            
		    max: 100,//最多选中个数，默认5            
		    name: 'attributelabels',//input的name 不设置与选择器相同(去#.)
		    delimiter: ',',//值的分隔符  
		    tips:' 人员属性标签：',         
		    field: { idName: 'id', titleName: 'name' },//候选项数据的键名 
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
		        },
		        view: {
		        	showIcon: false
				}
		    }
		});
		  form.verify({
		  	cardnumber:	function(value,item){
		  		var validator = new IDValidator();
		  		if(!validator.isValid(value)){
		  			return "身份证号存在错误";
		  		}
		  	}
		  });
		  form.render();
		  form.on('submit(msgSub)', function(data){
	         $("#form1").ajaxSubmit({
	              	url:		'<c:url value="/addPersonnelExtend.do"/>',
	              	dataType:	'json',
	              	async:  	false,
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
		 		         		parent.$("#search").click();
		 		         		parent.layer.closeAll("iframe");
	                   		},2000);
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
