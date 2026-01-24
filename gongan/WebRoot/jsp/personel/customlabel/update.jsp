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
    
    <title>修改人员自定义标签</title>
    
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  </head>
  
  <body>
  	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  		<legend>修改人员自定义标签</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
		<input type="hidden"  name="menuid" value=${menuid }>
		<input type="hidden"  name="id" value=${customlabel.id }>
		<input type="hidden"  name="personlabel" value=${customlabel.personlabel }>
		<div class="layui-form-item">
	       <label class="layui-form-label"><font color="red" size=2>*</font>上级标签</label>
	    	<div class="layui-input-inline">
	      		 <input type="text" id="parentid" name="parentid" value="0" lay-filter="parentid" lay-verify="parentid" class="layui-input">
	      	</div>
	       <label class="layui-form-label"><font color="red" size=2>*</font>自定义标签名称</label>
	    	<div class="layui-input-inline">
	      		<input type="text" name="customlabel" lay-verify="required" autocomplete="off" placeholder="请输入自定义标签" 
	      		value="${customlabel.customlabel}"  class="layui-input"  lay-reqtext="请输入自定义标签">
	      	</div>
	    </div>
	 	 <div class="layui-form-item">
		   <label class="layui-form-label">标签描述</label>
	          <div class="layui-input-inline">
		      			<textarea class="layui-textarea" rows=2 name="labledescription"   style="width:660px;">${customlabel.labledescription}</textarea>
			    </div>
		 </div>
	 	<div class="layui-form-item">
		    <div class="layui-input-block">
		      <button type="submit" class="layui-btn" lay-submit="" lay-filter="roleSub">立即提交</button>
		      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
		    </div>
	  	</div>
	</form>
	<script type="text/javascript">
		layui.config({
		    base: "<c:url value="/layui/lay/modules/"/>"
		}).extend({
		    treeSelect: "treeSelect"
		});
		layui.use(['form', 'layedit','treeSelect'], function(){
		  var form = layui.form,
		  layer = layui.layer,
		  treeSelect = layui.treeSelect,
		  layedit = layui.layedit;
		  
		    treeSelect.render({
		        elem: '#parentid',
		        data: '<c:url value="/getCustomLabelTree.do"/>?personlabel='+${customlabel.personlabel },
		        // 异步加载方式：get/post，默认get
		        type: 'get',
		        // 占位符
		        placeholder: '请选择上级节点',
		        // 是否开启搜索功能：true/false，默认false
		        search: true,
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
		            //console.log($('#parentid').val());
		        },
		        // 加载完成后的回调函数
		        success: function (d) {
		           treeSelect.checkNode('parentid', '${customlabel.parentid}');
				   //获取zTree对象，可以调用zTree方法
               	   var treeObj = treeSelect.zTree('parentid');
				   //刷新树结构
                   treeSelect.refresh('parentid');
		        }
		    });
		  
		  
		  form.on('submit(roleSub)', function(data){
	         $("#form1").ajaxSubmit({
	              	url:		'<c:url value="/updatecustomlabel.do"/>',
	              	dataType:	'json',
	              	async:  false,
	              	success:	function(data) {
	                  	var obj = eval('(' + data + ')');
	                  	if(obj.flag>0){
	                  	    //弹出loading
	 		            	var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
	                     	setTimeout(function(){         
	                     		top.layer.msg(obj.msg);
	                     		top.layer.close(index);
				        	    parent.$("#tabCustomlabel").click();
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
