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
   
   <form class="layui-form" method="post" id="form">
   		<input type="hidden"  name="menuid" value=${param.menuid }>
   		<input type="hidden" name="id" id="id" value="${menu.id }" />
   		 <input type="hidden"  id="buttons" value=${menu.buttons }>
   		<input type="hidden" name="parentid" id="parentid" value="${menu.parentid }" />
	<br>
		<div class="layui-form-item">
		<div class="layui-inline">
        	<label class="layui-form-label">上级菜单：</label>
	        <div class="layui-input-inline">
	            <input type="text"   id="parentname" value="${menu.parentname }"  class="layui-input"  readonly/>
	        </div>
  		</div>
  		<div class="layui-inline">
  		<label class="layui-form-label"><font color="red" size=2>*</font>菜单名称</label>
		    <div class="layui-input-inline">
		      <input type="text" name="menuname"  lay-verify="required" value="${menu.menuname }" autocomplete="off" placeholder="请输入菜单名称" class="layui-input"  lay-reqtext="菜单名称不能为空">
		    </div>
		 </div>
  	
  		</div>
		
	     <div class="layui-form-item">
	     <div class="layui-inline">
	        <label class="layui-form-label"><font color="red" size=2>*</font>菜单排序</label>
      		<div class="layui-input-inline">
        		<input type="tel" name="orderno" lay-verify="required|number" autocomplete="off" class="layui-input" value="${menu.orderno }" placeholder="请输入菜单排序" class="layui-input"  lay-reqtext="菜单排序不能为空"/>
      		</div>
      		</div>
      		  <div class="layui-inline">
      		   <label class="layui-form-label">菜单图标</label>
					    <div class="layui-input-inline">
					      <input type="text" name="icon"  autocomplete="off" class="layui-input" value="${menu.icon }"/>
					    </div>
      		  </div>
    	</div>
	 
	  <div  class="layui-form-item">
	   <label class="layui-form-label">菜单链接</label>
	          <div class=layui-input-inline>
	               <input type="text" name="url"  autocomplete="off" class="layui-input"  style="width:270%"  value="${menu.url }"/>
	          </div>
	   </div>
	<div  class="layui-form-item">
		 <label class="layui-form-label">菜单按钮</label>
		  <div class="layui-input-inline"  style="width:650px;">  
		 <c:forEach items="${buttons}" var="row" varStatus="num">
					<input type="checkbox" class="parent" name="buttons" lay-skin="primary" value="${row}" title="${row}" >	
			</c:forEach>		
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
           /*给按钮赋值*/
          function checkboxed(){
          var buttons =$("#buttons").val();          
          if(buttons!=""){     
          var button=buttons.split(",");   
           $('input:checkbox[name=buttons]').each(function (i) {         
             for(i=0;i<button.length;i++){                                             
             if(button[i]==$(this).val()){            
               $(this).prop('checked', 'checked');
                     }               
                  }   
               });            
             }
           }
           $(document).ready(function(){
			checkboxed();
			
			});       
layui.use(['form', 'layedit', 'laydate'], function(){
  var form = layui.form,
  layer = layui.layer,
  layedit = layui.layedit,
  laydate = layui.laydate;
 
 
 form.render();
  form.on('submit(demo1)', function(data){
   //alert(JSON.stringify(data.field));  
         $("#form").ajaxSubmit({
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
