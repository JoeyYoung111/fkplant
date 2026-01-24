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
    
    <title>添加页面</title>
    
	 <link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
   <script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
   <script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  </head>
  <script type="text/javascript">
		</script>
  <body>
   <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  <legend>菜单信息</legend>
   </fieldset>
   <form class="layui-form" method="post" id="form1">
   <input type="hidden"  name="menuid" value=${param.menuid }>
   <!-- 菜单ID -->
			<input type="hidden" name="id" id="id" value="${menu.id }" />
			
			<!-- 目前菜单类型 -->
			<input type="hidden" name="menutype" id="menutype" value="${menu.menutype }" />
   <div class="layui-form-item">
   
    
 </div>
 <div class="layui-form-item">
    <label class="layui-form-label"><font color="red" size=2>*</font>菜单名称</label>
    <div class="layui-input-block">
      <input type="text" name="menuname" lay-verify="required" autocomplete="off" placeholder="请输入菜单名称" class="layui-input"  lay-reqtext="菜单名称不能为空" value="${menu.menuname }">
    </div>
   </div>
  
  
  <div class="layui-form-item">
    <label class="layui-form-label"><font color="red" size=2>*</font>菜单排序</label>
      <div class="layui-input-block">
        <input type="tel" name="orderno" lay-verify="required|number" autocomplete="off" class="layui-input" value="${menu.orderno }">
      </div>
    </div>
    <div class="layui-form-item">
   
      <label class="layui-form-label">菜单图标</label>
      <div class="layui-input-block">
        <input type="text" name="icon"  autocomplete="off" class="layui-input" value="${menu.icon }">
      </div>
  
  </div>

  <div class="layui-form-item layui-form-text">
    <label class="layui-form-label">备注信息</label>
    <div class="layui-input-block">
      <textarea placeholder="请输入内容" class="layui-textarea" name="memo"></textarea>
    </div>
  </div>
  <!--<div class="layui-form-item layui-form-text">
    <label class="layui-form-label">编辑器</label>
    <div class="layui-input-block">
      <textarea class="layui-textarea layui-hide" name="content" lay-verify="content" id="LAY_demo_editor"></textarea>
    </div>
  </div>-->
  <div class="layui-form-item">
    <div class="layui-input-block">
      <button type="submit" class="layui-btn" lay-submit="" lay-filter="demo1">立即提交</button>
      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
    </div>
  </div>
</form>
<script>
           /*获取主菜单信息*/
			function getZhuMenu(){
				$.ajax({
					type:		'POST',
					url:		'<c:url value="/getZhuMenuToJSON.do" />',
					dataType:	'json',
					success:	function(data){
					  
						var options = fillOption(data);
						$("select[name^=parentid]").html(options);
					}
				});
			}

$(document).ready(function(){
				/*默认加载主菜单信息*/
				getZhuMenu();
				
			
			});


layui.use(['form', 'layedit', 'laydate'], function(){
  var form = layui.form,
  layer = layui.layer,
  layedit = layui.layedit,
  laydate = layui.laydate;
   
  //监听提交
  form.on('submit(demo1)', function(data){
   //alert(JSON.stringify(data.field));  
         $("#form1").ajaxSubmit({
              	url:		'<c:url value="/updateMenu.do"/>',
              	dataType:	'json',
              	async:  false,
              	success:	function(data) {
                  	var obj = eval('(' + data + ')');
                  	if(obj.flag>0){
                  	   //弹出loading
 		             var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
                     setTimeout(function(){
                     
                     top.layer.msg(obj.msg);
                   
			         top.layer.closeAll("iframe");
			          layer.close(index);
	 		        //刷新父页面
	 		         parent.location.reload();
                   },5000);
                 }else{
                  	 layer.msg(obj.msg);
                }
             },
              	error:function() {
                  	alert("请求失败！");
              	}
          	});
           return false;
  });
 
  //表单赋值
  layui.$('#LAY-component-form-setval').on('click', function(){
    form.val('example', {
      "username": "贤心" // "name": "value"
      ,"password": "123456"
      ,"interest": 1
      ,"like[write]": true //复选框选中状态
      ,"close": true //开关状态
      ,"sex": "女"
      ,"desc": "我爱 layui"
    });
  });
  
  //表单取值
  layui.$('#LAY-component-form-getval').on('click', function(){
    var data = form.val('example');
    alert(JSON.stringify(data));
  });
  
});
</script>
  </body>
</html>
