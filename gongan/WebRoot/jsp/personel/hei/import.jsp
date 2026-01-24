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
    
    <title>涉黑人员-导入页面</title>
    
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/check.js"/>"></script>
  </head>
  
  <body>
  	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  		<legend id="typeName"><button type="button" class="layui-btn" id="upload"><i class="layui-icon">&#xe601;</i>下 载 导 入 模 板</button></legend>
	</fieldset>
	<form class="layui-form" method="post" id="form1">
		<input type="hidden"  name="menuid" value=${param.menuid}>
		<button type="button"  class="layui-btn jjbz-btn-submit" style="display:none;" id="btns">文件上传</button>		
		<div class="layui-upload-drag" id="files" style="width:470px;margin-left:25px;">
        <i class="layui-icon"></i>
        <p>点击上传，或将文件拖拽到此处（只支持xls、xlsx）</p>
  <div class="layui-hide" id="uploadDemoView">
    <hr>
    <img src="" alt="上传成功后渲染" style="max-width: 196px">
  </div>
</div>
 <div class="layui-upload" style="width:535px;margin-left:25px;">
	  	 <div class="layui-upload-list">
	  	 <table class="layui-table" id="table3">
	  	 <thead>
	  	 <tr><th style="text-align:center">文件名</th>
	  	 <th style="text-align:center">大小</th>
	  	 <th style="text-align:center">状态</th>
	  	 <th style="text-align:center">操作</th>
	  	 </tr></thead>
	  	 <tbody id="demoList"></tbody>
	  	 </table>
	  	 </div>
	  	 </div>
	  	 <div class="layui-upload-drag" id="text" style="width:470px;margin-left:25px;display:none;">
	  	 文件导入中，请不要关闭页面。。。
	  	 </div>
	</form>
	<script type="text/javascript">
	$("#upload").on("click",function(){
		//window.location.href="<c:url value='/jsp/personel/template/wen_template.xlsx' />";
		window.location.href="<c:url value='/jsp/personel/template/风险人员导入模板(涉黑).xlsx' />";
	});
	$("#btns").on("click", function(){ 
	  if(nums==0){
	        top.layer.msg("请先选择要上传的导入文件，文件模板请先下载！");
	   }else 	if(nums==1){
	  // 单击之后提交按钮不可选,防止重复提交
			 var DISABLED = 'layui-btn-disabled';
			 // 增加样式
			 $('.jjbz-btn-submit').addClass(DISABLED);
			 // 增加属性
			 $('.jjbz-btn-submit').attr('disabled', 'disabled');
			 $("#text").show();			
	    }
			 });
	var nums=0;
		layui.use(['upload', 'element', 'layer'], function(){
		  var $ = layui.jquery,
		  upload = layui.upload,
		  element = layui.element,
		  layer = layui.layer;
          //拖拽上传
 var listView=$("#demoList");
 uploadListIns=upload.render({
    elem:'#files',
  url: '<c:url value="/importHeiPersonel.do" />',
 accept:'file',     //文件类型
 exts: 'xls|xlsx',
 multiple:true,     //多文件上传
 auto:false,        //点击按钮之后,再上传
 bindAction:'#btns',//按钮不能是同一个否则触发不了
choose:function(obj){
nums=nums+1;
if(nums==1){
 var files = this.files = obj.pushFile(); //将每次选择的文件追加到文件队列
      //读取本地文件
      obj.preview(function(index, file, result){
        var tr = $(['<tr id="upload-'+ index +'">'
          ,'<td>'+ file.name +'</td>'
          ,'<td>'+ (file.size/1024).toFixed(1) +'kb</td>'
          ,'<td id="flags">等待上传</td>'
          ,'<td>'
            ,'<button class="layui-btn layui-btn-xs demo-reload layui-hide">重传</button>'
            ,'<button class="layui-btn layui-btn-xs layui-btn-danger demo-delete">删除</button>'
          ,'</td>'
        ,'</tr>'].join(''));
        
        //单个重传
        tr.find('.demo-reload').on('click', function(){
          obj.upload(index, file);
        });
        
        //删除
        tr.find('.demo-delete').on('click', function(){
        nums=0;
          delete files[index]; //删除对应的文件
          tr.remove();
          uploadListIns.config.elem.next()[0].value = ''; //清空 input file 值，以免删除后出现同名文件不可选
        });
        
        listView.append(tr);
      });
      }else{
      top.layer.msg("只能上传一个文件！");
      }
    },
  done:function(res){
  $("#text").html(res.success);
  parent.$(".layui-layer-iframe").find(".layui-layer-btn0").hide();
   $("#flags").text("导入成功");
 },
 error:function(res){
  top.layer.msg("上传失败！");
 }
  });
   });
	</script>
  </body>
</html>
