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
	<link rel="stylesheet" href="<c:url value="/layui/css/layui.css"/>"  media="all" />
	<style type="text/css">
   		.layui-table td{text-align:center;vertical-align:middle;border:1px solid #1E8CD7;padding:10px;}
   </style>
     <link rel="stylesheet" href="<c:url value="/css/public.css"/>"  media="all" />
     <link rel="stylesheet" href="<c:url value="/css/viewer.css"/>"/>
    <script type="text/javascript" src="<c:url value="/js/jquery-1.8.0.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/> "></script>
  	<script type="text/javascript" src="<c:url value="/layui/layui.js"/>"></script>
  	<script type="text/javascript" src="<c:url value="/js/viewer.js"/>"></script>
  </head>
  
  <body>
	<form class="layui-form" method="post" id="form1">
  		
  		<div class="layui-col-md12">
			<div class="layui-form-item my-form-item">
				<label class="layui-form-label">选择要上传图片：</label>
				<div class="layui-input-block">
				  <button type="button" class="layui-btn" id="upload"><i class="layui-icon">&#xe681;</i>上 传  头 像</button>&nbsp;&nbsp;&nbsp;&nbsp;
				 <div style="width: 150px;display: inline-block;">
				  <div class="layui-progress layui-progress-big" lay-showpercent="yes" lay-filter="demo">
				      <div class="layui-progress-bar" lay-percent=""></div>
			     </div>
			    </div>
				</div>
			</div>
		</div>
		
  		<div class="layui-col-md8">
			<div class="layui-form-item my-form-item">
				<label class="layui-form-label">已上传头像图片：</label>
			</div>
			<div class="layui-input-block" id="photos"></div>	
		</div>
	 
	</form>
	<script type="text/javascript">
		var locat = (window.location+'').split('/'); 
		$(function(){if('main'== locat[3]){locat =  locat[0]+'//'+locat[2];}else{locat =  locat[0]+'//'+locat[2]+'/'+locat[3];};});
		var count=0,defaultid=0,viewflag=true,viewer;
		$(document).ready(function(){
			getPhotos();
		});
		function getPhotos(){
			$.ajax({
				type:		'POST',
				url:		'<c:url value="/getPersonnelPhotoFlowList.do?personnelid="/>'+${param.personnelid},
				dataType:	'json',
				async:      false,
				success:	function(data){
					var options="";
					count=0;
					defaultid=0;
					if(data.count>0){
						$.each(data.photos, function(i) {
						   count++;
							options +='<div class="layui-col-md3 my-imgbox">';
							if(this.validflag>1)options +='<img lay-src="../uploadFiles/'+this.fileallName+'">';
							else options +='<img lay-src="../uploadFiles/pictures/'+this.fileallName+'">';
							options +='<div style="padding-top:8px;">';
							
							if(this.defaultflag==0)options +='<button type="button" class="layui-btn layui-btn-sm layui-btn-radius layui-btn-warm" onclick="defaultflag('+this.id+')">设为默认</button>';
							else if(this.defaultflag==1){
								defaultid=this.id;
								options +='<button type="button" class="layui-btn layui-btn-sm layui-btn-radius layui-btn-normal">默认照片</button>';
							}
							options +='<button type="button" class="layui-btn layui-btn-sm layui-btn-radius layui-btn-danger" onclick="cancel('+this.id+')">删除</button>';
							options +="</div></div>";
							//console.log(options);
						});
					}
				 $('#photos').html(options);
					if(viewflag){
						viewer = new Viewer(document.getElementById("photos"),{
							url:	'data-original',
							navbar:	false
						});
						viewflag=false;
					}else viewer.update();
				}
			});
		}
		
		function defaultflag(id){
			$.ajax({
				type:		'POST',
				url:		'<c:url value="/updatePersonnelPhoto.do"/>?id='+id+"&defaultid="+defaultid+"&menuid="+${param.menuid },
				dataType:	'json',
				async:      false,
				success:	function(data){
					var str = eval('(' + data + ')');
		        	if (str.flag ==1) {		                          
				     	top.layer.msg("默认照片设置成功！"); 	
		        		setTimeout(function(){parent.getDefaultPhoto()},1000);                 
				     	getPhotos();
		        		layui.flow.lazyimg();
		        		layui.form.render();
				    }else{
						top.layer.msg("默认照片设置失败!");
				    }
				}
			});
		}
		function cancel(id){
		    top.layer.confirm('确定删除此照片？', function(index){
		        layer.close(index);
		        $.getJSON(locat+"/cancelPersonnelPhoto.do?id="+id+"&menuid="+${param.menuid },{
					},function(data) {
						var str = eval('(' + data + ')');
			        	if (str.flag ==1) {		                          
					     	top.layer.msg("照片删除成功！"); 	
			        		if(id==defaultid)setTimeout(function(){parent.getDefaultPhoto()},1000);                 
					     	getPhotos();
			        		layui.flow.lazyimg();
			        		layui.form.render();
					    }else{
							top.layer.msg("删除失败!");
					    }			      	    		
		        	});      
				});
		}
		
		layui.use(['form','flow','upload','element'], function(){
		  var form = layui.form,
		  flow = layui.flow,
		  upload = layui.upload,
		  element = layui.element,
		  layer = layui.layer;
		  
		  var uploadInst = upload.render({
			    elem: '#upload'
		        ,url: '<c:url value="/newuploadfile.do"/>'
		        ,async:  false
				,accept:'images' //图片类型
				,auto:	true
			    ,before: function(obj){
			      element.progress('demo', '0%'); //进度条复位
			      layer.msg('上传中', {icon: 16, time: 0});
			    }
			    ,done: function(res){
			      //如果上传失败
			      if(!res.success||res.success <= 0){
			        return layer.msg('上传失败');
			      }else{
				      //上传成功的一些操作 
				      $.ajax({
							type:		'POST',
							url:		'<c:url value="/addPersonnelPhoto.do"/>',
							data:		{
											personnelid:${param.personnelid},
											fileid:res.success,
											defaultflag:count==0?1:0,
											menuid:${param.menuid}
										},
							dataType:	'json',
							async:      false,
							success:	function(data){
								var obj = eval('(' + data + ')');
								if(obj.flag>0){
	                				//弹出loading
			 		            	var index1 = top.layer.msg('照片上传中，请稍候',{icon: 16,time:false,shade:0.8});
			                     	setTimeout(function(){         
			                     		top.layer.msg(obj.msg);
			                     		top.layer.close(index1);
						        		layer.closeAll("iframe");
				 		        		//刷新
						        		setTimeout(function(){parent.getDefaultPhoto()},1000);
						        		getPhotos();
						        		flow.lazyimg();
						        		form.render();
			                   		},500);
               					}else{
               						layer.msg(obj.msg);
               					}
							}
						});
			      }
			    }
			    ,error: function(){
			      //演示失败状态，并实现重传
			      var demoText = $('#demoText');
			      demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
			      demoText.find('.demo-reload').on('click', function(){
			        uploadInst.upload();
			      });
			    }
			    //进度条
			    ,progress: function(n, elem, e){
			      element.progress('demo', n + '%'); //可配合 layui 进度条元素使用
			      if(n == 100){
			        layer.msg('上传完毕', {icon: 1});
			      }
			    }
		  });
		  
		  flow.lazyimg();//图片加载——重要
		  form.render();
		});
	</script>
  </body>
</html>
