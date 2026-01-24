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
    
    <title>添加字典</title>
    
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  	
  </head>
   <body>
		<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  <legend>字典信息</legend>
   </fieldset>
   <form class="layui-form" method="post" id="form1">
   <input type="hidden"  name="menuid" value=${menuid }>
   <input type="hidden"  name="id" value=${basicType.id }>
  <div class="layui-form-item">
    <div class="layui-inline">
      <label class="layui-form-label">上级节点</label>
      <div class="layui-input-inline">
	    <input type="text" id="parentid" name="parentid" value="0" lay-filter="parentid" lay-verify="parentid" class="layui-input">
      </div>
    </div>
    <div class="layui-inline">
      <label class="layui-form-label"><font color="red" size=2>*</font>字典名称</label>
      <div class="layui-input-inline">
        <input type="text" name="basicTypeName" value="${basicType.basicTypeName}" lay-verify="required" autocomplete="off" class="layui-input">
      </div>
    </div>
  </div>
  <div class="layui-form-item">
  	<div class="layui-inline">
	  	<label class="layui-form-label">是否存在外联</label>
	    <div class="layui-input-inline">
	    	<input type="radio" name="isexternal" value="0" title="不存在" checked="" lay-filter="types" <c:if test="${basicType.isexternal eq 0}">checked=""</c:if>/>
      		<input type="radio" name="isexternal" value="1" title="存在" lay-filter="typess" <c:if test="${basicType.isexternal eq 1}">checked=""</c:if>/>
	    </div>
    </div>
  	<div id="show1" class="layui-inline" <c:if test="${basicType.isexternal eq 0}">style="display:none"</c:if>>
	  	<label class="layui-form-label">外联字典</label>
	    <div class="layui-input-inline">
	    	<input type="text" id="externalid" name="externalid" value="0" lay-filter="externalid" lay-verify="externalid" class="layui-input">
	    </div>
    </div>
  </div>
  <div class="layui-form-item">
  	<div class="layui-inline">
	  	<label class="layui-form-label">树形结构</label>
	    <div class="layui-input-inline">
	    	<input type="radio" name="istree" value="0" title="否" checked="" lay-filter="types" <c:if test="${basicType.istree eq 0}">checked=""</c:if>/>
      		<input type="radio" name="istree" value="1" title="是" lay-filter="typess" <c:if test="${basicType.istree eq 1}">checked=""</c:if>/>
	    </div>
    </div>
  </div> 
  
  <div class="layui-form-item layui-form-text">
    <label class="layui-form-label">备注信息</label>
    <div class="layui-input-block">
      <textarea placeholder="请输入内容" class="layui-textarea" name="memo">${basicType.memo}</textarea>
    </div>
  </div>
  <div class="layui-form-item">
    <div class="layui-input-block">
      <button type="submit" class="layui-btn" lay-submit="" lay-filter="updateNode">立即提交</button>
<%--      <button type="reset" class="layui-btn layui-btn-primary">重置</button>--%>
    </div>
  </div>
</form>
		<script type="text/javascript">
		$(document).ready(function(){
		});
		layui.config({
		    base: "<c:url value="/layui/lay/modules/"/>"
		}).extend({
		    treeSelect: "treeSelect"
		});
		
		layui.use(['form','treeSelect'], function(){
		  var form = layui.form,
		  treeSelect = layui.treeSelect,
		  layer = layui.layer;
		  
		  treeSelect.render({
		        // 选择器
		        elem: '#parentid',
		        // 数据
		        data: '<c:url value="/getBasicTypeRootTree.do"/>',
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
		           treeSelect.checkNode('parentid', '${basicType.parentid}');
				   //获取zTree对象，可以调用zTree方法
               	   var treeObj = treeSelect.zTree('parentid');
				   //刷新树结构
                   treeSelect.refresh('parentid');
		        }
		    });
		    
		  treeSelect.render({
		        // 选择器
		        elem: '#externalid',
		        // 数据
		        data: '<c:url value="/getBasicTypeTree.do"/>',
		        // 异步加载方式：get/post，默认get
		        type: 'get',
		        // 占位符
		        placeholder: '请选择外联字典',
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
		            //console.log($('#externalid').val());
		        },
		        // 加载完成后的回调函数
		        success: function (d) {
		           treeSelect.checkNode('externalid', '${basicType.externalid}');
				   //获取zTree对象，可以调用zTree方法
               	   var treeObj = treeSelect.zTree('externalid');
				   //刷新树结构
                   treeSelect.refresh('externalid');
		        }
		    });
		  
		  //监听提交
		  form.on('radio(types)', function(data){
		   	  $("#show1").hide();
		   	  //撤销选中的节点
		   	  treeSelect.revokeNode('externalid', function(d){
				    $('#externalid').val(0);
				    //console.log($('#externalid').val());
				});
		  });  
		  form.on('radio(typess)', function(data){
			  $("#show1").show();
			  treeSelect.checkNode('externalid', '${basicType.externalid}');
	   		  //获取zTree对象，可以调用zTree方法
         	  var treeObj = treeSelect.zTree('externalid');
		      //刷新树结构
              treeSelect.refresh('externalid');
		  });  
		  form.verify({
		  	externalid:function(value,item){
		  		if($("input[name=isexternal]:checked").val()==1&&value==0){
		  			return "请选择外联字典";
		  		}
		  	}
		  });
		  form.render();
		  form.on('submit(updateNode)', function(data){
	         $("#form1").ajaxSubmit({
	              	url:		'<c:url value="/updateBasicType.do"/>',
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
				        		layer.closeAll("iframe");
		 		        		//刷新父页面
		 		        		parent.$('#nodeid').val(0);
								parent.$('#nodetitle').val('无');
		 		         		parent.getTypeTree();
		 		         		parent.searchMsg();
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
