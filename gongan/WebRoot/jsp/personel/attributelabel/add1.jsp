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
    
    <title>添加人员属性标签  需审核的标签</title>
    
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  </head>
  
  <body>
  	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  		<legend>新增人员属性标签</legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
		<input type="hidden"  name="menuid" value=${param.menuid }>
<%--		<input type="hidden"  name="parentid" value=${param.parentid }>--%>
		<input type="hidden"  name="examineflag" value=${param.examineflag }>
		<div class="layui-form-item">
	       <label class="layui-form-label"><font color="red" size=2>*</font>上级标签</label>
	    	<div class="layui-input-inline">
	      		<input type="text" id="parentid" name="parentid"  lay-filter="parentid" lay-verify="required" class="layui-input">
	      	</div>
	       <label class="layui-form-label"><font color="red" size=2>*</font>人员属性标签</label>
	    	<div class="layui-input-inline">
	      		<input type="text" name="attributelabel" lay-verify="required" autocomplete="off" placeholder="请输入属性标签" class="layui-input"  lay-reqtext="请输入属性标签">
	      	</div>
	    </div>
	    <div class="layui-form-item"  id="department">
		   <label class="layui-form-label">责任部门</label>
		      <div class="layui-input-inline" id="departmentid" style="width:660px;"   lay-verify="departmentid"></div>
<%--	          <div class="layui-input-inline"  style="width:660px;"   lay-verify="departmentid">--%>
<%--	             <input type="text" id="departmentid" name="departmentid" value="0" lay-filter="departmentid"  class="layui-input">--%>
<%--	          </div>--%>
		 </div>
	    
	    <div class="layui-form-item">
		   <label class="layui-form-label">标签描述</label>
	          <div class="layui-input-inline">
		      		<textarea class="layui-textarea" rows=2 name="memo"   style="width:660px;"></textarea>
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
	 $(document).ready(function(){
	    if(${param.parentid}!="0"){
	        $("#department").hide();
	     }
     });
	   layui.config({
			    base: "<c:url value="/layui/lay/modules/"/>"
			}).extend({
			    treeSelect: "treeSelect",
			    zTreeSelectM: "zTreeSelectM/zTreeSelectM",
			    selectInput:"selectInput/selectInput"
			});
		layui.use(['form', 'layedit','treeSelect','zTreeSelectM'], function(){
		  var form = layui.form,
		  layer = layui.layer,
		  treeSelect = layui.treeSelect,
		  zTreeSelectM = layui.zTreeSelectM,
		  layedit = layui.layedit;
		  if(${param.parentid}=="0"){
	        var _zTreeSelectM1 = zTreeSelectM({
			    elem: '#departmentid',//元素容器【必填】          
			    data: '<c:url value="/getDepartmentTree.do"/>',
			    type: 'get',  //设置了长度    
			    selected: [],//默认值            
			    max: 100,//最多选中个数，默认5            
			    name: 'departmentid',//input的name 不设置与选择器相同(去#.)
			    delimiter: ',',//值的分隔符  
			    tips:' 责任单位：', 
			    verify: 'required',
			     reqtext:"请选择责任责任单位",         
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
	     }
		  
		  treeSelect.render({
		        elem: '#parentid',
		        data: '<c:url value="/getAttributeLabelTreeSelect1.do"/>?parentid='+${param.parentid },
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
		         
		        }
		    }); 
		  
		 	
		 
		   form.on('submit(roleSub)', function(data){
	         $("#form1").ajaxSubmit({
	              	url:		'<c:url value="/addattributelabel.do"/>',
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
				        		//刷新父页面
		 		         		parent.location.reload();
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
