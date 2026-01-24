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
  
  <body>
   <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  <legend>菜单信息</legend>
   </fieldset>
   <form class="layui-form" method="post" id="form1">
   <input type="hidden"  name="menuid" value=${param.menuid }>
   <div class="layui-form-item">
   <div class="layui-inline">
    <label class="layui-form-label"><font color="red" size=2>*</font>菜单类型</label>
    <div class="layui-input-inline">
      <input type="radio" name="menutype" value="1" title="主菜单" checked="" lay-filter="types" />
      <input type="radio" name="menutype" value="2" title="子菜单" lay-filter="typess" />
      </div>
       </div>
     <div id="show" class="layui-inline" style="display:none">
    <label class="layui-form-label"><font color="red" size=2>*</font>子菜单归属</label>
    <div class="layui-input-inline">
      <select name="parentid" id="parentid" lay-filter="test">
      </select>
    </div>
  </div>
 </div>
 <div class="layui-form-item">
    <label class="layui-form-label"><font color="red" size=2>*</font>菜单名称</label>
    <div class="layui-input-block">
      <input type="text" name="menuname" lay-verify="required" autocomplete="off" placeholder="请输入菜单名称" class="layui-input"  lay-reqtext="菜单名称不能为空">
    </div>
  </div>
  
  
  <div class="layui-form-item">
    <div class="layui-inline">
      <label class="layui-form-label"><font color="red" size=2>*</font>菜单排序</label>
      <div class="layui-input-inline">
        <input type="tel" name="orderno" lay-verify="required|number" autocomplete="off" class="layui-input">
      </div>
    </div>
    <div class="layui-inline">
      <label class="layui-form-label">菜单链接</label>
      <div class="layui-input-inline">
        <input type="text" name="url"  autocomplete="off" class="layui-input">
      </div>
    </div>
  </div>
  <div id="showss" class="layui-form-item">
    <label class="layui-form-label">菜单图标</label>
    <div class="layui-input-block">
      <input type="text" name="icon"  autocomplete="off" class="layui-input" >
    </div>
  </div>
   <div id="shows" class="layui-form-item" style="display:none">
    <label class="layui-form-label">菜单按钮</label>
    <div class="layui-input-block"> 
  <input type="checkbox" class="parent" name="buttons" lay-skin="primary" value="查询" title="查询">					
  <input type="checkbox" class="parent" name="buttons" lay-skin="primary" value="新增" title="新增">		
  <input type="checkbox" class="parent" name="buttons" lay-skin="primary" value="修改" title="修改">	
  <input type="checkbox" class="parent" name="buttons" lay-skin="primary" value="删除" title="删除">		
  <input type="checkbox" class="parent" name="buttons" lay-skin="primary" value="导入" title="导入">		
  <input type="checkbox" class="parent" name="buttons" lay-skin="primary" value="导出" title="导出">		
  <input type="checkbox" class="parent" name="buttons" lay-skin="primary" value="审核" title="审核">		
  <input type="checkbox" class="parent" name="buttons" lay-skin="primary" value="取消" title="取消">
   <input type="checkbox" class="parent" name="buttons" lay-skin="primary" value="下架" title="下架">		
  <input type="checkbox" class="parent" name="buttons" lay-skin="primary" value="发布" title="发布"><br>	
  <input type="checkbox" class="parent" name="buttons" lay-skin="primary" value="分配" title="分配">		
  <input type="checkbox" class="parent" name="buttons" lay-skin="primary" value="回复" title="回复">		
  <input type="checkbox" class="parent" name="buttons" lay-skin="primary" value="设置" title="设置">	
  <input type="checkbox" class="parent" name="buttons" lay-skin="primary" value="禁用" title="禁用">					
  <input type="checkbox" class="parent" name="buttons" lay-skin="primary" value="走访" title="走访">
  <input type="checkbox" class="parent" name="buttons" lay-skin="primary" value="受理" title="受理">					
  <input type="checkbox" class="parent" name="buttons" lay-skin="primary" value="授信" title="授信">
  <input type="checkbox" class="parent" name="buttons" lay-skin="primary" value="放贷" title="放贷">		
  <input type="checkbox" class="parent" name="buttons" lay-skin="primary" value="恢复" title="恢复">
	<input type="checkbox" class="parent" name="buttons" lay-skin="primary" value="设置用户" title="设置用户（网点、客户经理）">
    </div>
    
    <label class="layui-form-label"></label>
     <div class="layui-input-block"> 
   <input type="checkbox" class="parent" name="buttons" lay-skin="primary" value="抽查" title="抽查">
   <input type="checkbox" class="parent" name="buttons" lay-skin="primary" value="选择" title="选择">
     </div>
  </div> 
  <div class="layui-form-item layui-form-text">
    <label class="layui-form-label">备注信息</label>
    <div class="layui-input-block">
      <textarea placeholder="请输入内容" class="layui-textarea" name="memo"></textarea>
    </div>
  </div>
  <div class="layui-form-item">
    <div class="layui-input-block">
      <button type="submit" class="layui-btn" lay-submit="" lay-filter="demo1">立即提交</button>
      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
    </div>
  </div>
</form>
<script type="text/javascript">
           /*获取主菜单信息*/
			function getZhuMenu(){
				$.ajax({
					type:		'POST',
					url:		'<c:url value="/getZhuMenuToJSON.do" />',
					dataType:	'json',
					async:   false,
					success:	function(data){					  
						var options = fillOption(data);
						$("select[name^=parentid]").html(options);
					}
				});
			}
			
$(document).ready(function(){
				/*默认加载主菜单信息*/
				getZhuMenu();
				$("#show").hide();
			    $("#shows").hide();
			});


layui.use(['form', 'layedit', 'laydate'], function(){
  var form = layui.form,
  layer = layui.layer,
  layedit = layui.layedit,
  laydate = layui.laydate;
 
  //监听提交
  form.on('radio(types)', function(data){
   $("#show").hide();
     $("#shows").hide();
  
});  
 form.on('radio(typess)', function(data){
   $("#show").show();
   $("#shows").show();
   $("#showss").hide();
  
});  
 form.render();
  form.on('submit(demo1)', function(data){
   //alert(JSON.stringify(data.field));  
         $("#form1").ajaxSubmit({
              	url:		'<c:url value="/addMenu.do"/>',
              	
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
	 		         parent.location.reload();
                   },2000);
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
