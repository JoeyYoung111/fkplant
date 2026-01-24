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
  <legend>添加按钮</legend>
   </fieldset>
   <form class="layui-form" method="post" id="form1">
   <input type="hidden"  name="menuid" value=${param.menuid }>
   <div class="layui-form-item">
   <div class="layui-inline">
    <label class="layui-form-label"><font color="red" size=2>*</font>按钮类型</label>
    <div class="layui-input-inline">
      <input type="radio" name="btntype" value="1" title="主按钮" checked="" lay-filter="types" />
      <input type="radio" name="btntype" value="2" title="子按钮" lay-filter="typess" />
      </div>
       </div>
     <div id="show" class="layui-inline" style="display:none">
    <label class="layui-form-label"><font color="red" size=2>*</font>子按钮归属</label>
    <div class="layui-input-inline">
      <select name="parentid" id="parentid" lay-filter="test">
      </select>
    </div>
  </div>
 </div>
 <div class="layui-form-item">
    <label class="layui-form-label"><font color="red" size=2>*</font>按钮名称</label>
    <div class="layui-inline">
      <input type="text" name="btnname" lay-verify="required" autocomplete="off" placeholder="请输入按钮名称" class="layui-input"  lay-reqtext="按钮名称不能为空">
    </div>
  </div>
  
  
  <div class="layui-form-item">
    <div class="layui-inline">
      <label class="layui-form-label"><font color="red" size=2>*</font>菜单排序</label>
      <div class="layui-input-inline">
        <input type="text" name="orderno" lay-verify="required|number" autocomplete="off" class="layui-input">
      </div>
    </div>
  </div>
  <div id="showss" class="layui-form-item">
    <label class="layui-form-label">菜单图标</label>
    <div class="layui-input-block">
      <input type="text" name="icon"  autocomplete="off" class="layui-input" >
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
           	/*获取主按钮信息*/
			function getZhuButton(){
				$.ajax({
					type:		'POST',
					url:		'<c:url value="/getZhuButtonToJSON.do" />',
					dataType:	'json',
					async:   false,
					success:	function(data){					  
						var options = fillOption(data);
						$("select[name^=parentid]").html(options);
					}
				});
			}
			
			$(document).ready(function(){
				/*默认加载主按钮信息*/
				getZhuButton();
			});


layui.use(['form', 'layedit', 'laydate'], function(){
  var form = layui.form,
  layer = layui.layer,
  layedit = layui.layedit,
  laydate = layui.laydate;
 
  //监听提交
  form.on('radio(types)', function(data){
   $("#show").hide();
  });  
  form.on('radio(typess)', function(data){
   $("#show").show();
  });  
 form.render();
  form.on('submit(demo1)', function(data){
   //alert(JSON.stringify(data.field));  
         $("#form1").ajaxSubmit({
              	url:		'<c:url value="/addAppButton.do"/>',
              	
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
  
});
</script>
  </body>
</html>
